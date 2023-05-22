unit WMRest;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp;

type
  TWebModule1 = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  Vcl.Dialogs, EgateFunciones, DMBase, Winapi.ActiveX, uGlobal, IWSRemotoEGATE2, IWSArchAdminImpl1, vcl.Imaging.jpeg,
  vcl.Graphics;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);

  function ExtractBetweenTags(const Line, TagI, TagF: string): string;
  var
    i, f: integer;
  begin
    i := Pos(TagI, Line);
    f := Pos(TagF, Copy(Line, i + length(TagI), MAXINT));
    if (i > 0) and (f > 0) then
      Result := Copy(Line, i + length(TagI), f - 1);
  end;

var
  s, transactionId, gateID: string;
  dir: string;
  score,v: Integer;
  imgB64:AnsiString;
  DMBaseIB: TDMBaseIB;
  StrL:TStringList;
  iniH,FinH:String;
begin

  Response.ContentType := 'application/json';
  Response.Content := '{"result": false}';



  Handled := True;
  if Request.MethodType <> mtPost then
    Exit;
  //try
  iniH :='REST faceMatch '+FormatDateTime('hh:mm:ss', Now);
  DMBaseIB := TDMBaseIB.Create(nil);
  try
    if Pos(LowerCase('faceMatch'), LowerCase(Request.PathInfo)) > 0 then
    begin
      s := Request.Content;

      transactionId := ExtractBetweenTags(s, '"transactionId":"', '"');
      gateID := ExtractBetweenTags(s, '"gateid":"', '"');


      dir := DirTransac(IDLOC,transactionId);
      imgB64 := ExtractBetweenTags(s,'"img":"','"');

      if trim(imgB64)='' then
        Exit;


      ConvertStrBase64ToFile(imgB64, dir + 'foto2.jpg');


        try
        var jpg := TJPEGImage.Create;
        try
        try
          jpg.LoadFromFile(dir + 'foto2.jpg');
          grabarEnArchivoLog(transactionId+' '+gateID+' WxH:'+jpg.Width.ToString+'x'+jpg.Height.ToString+' '+iif(jpg.Width<240,'*',''),ExtractFilePath(ParamStr(0))+'\RESTFotos.log');

        except
              //Es un bmp
          var bmp:=TBitmap.Create;
          try
            bmp.LoadFromFile(dir + 'foto2.jpg');
            jpg.Assign(bmp);
            jpg.SaveToFile(dir + 'foto2.jpg');
            grabarEnArchivoLog(transactionId+' '+gateID+' WxH:'+jpg.Width.ToString+'x'+jpg.Height.ToString+' '+iif(jpg.Width<240,'*',''),ExtractFilePath(ParamStr(0))+'\RESTFotos.log');
          finally
            bmp.Free;
          end;
        end;
        finally
          jpg.Free;
        end;
        except
        end;



       if DMBaseIB.DBPersonData(transactionId)=nil then
       begin
        grabarEnArchivoLog('faceMath Persona no encontrada' +dir);
        Exit;
       end;



     // if FileSize2(dir + 'foto2.jpg')<3000 then begin
     //   Response.Content := '{"result": false}';
     //   grabarEnArchivoLog('faceMath tamaño incorrecto foto2 '+dir);
     //   Exit;
     // end;




      StrL:=TStringList.Create;
      try
        StrL.Add('idLOC='+IDLOC);
        StrL.Add('transactionId='+transactionId);


        CoInitialize(nil);
        try
          for v := 1 to 3 do
          begin
            try
              score := GetIWSRemotoEGATE.faceMatch(StrL.Text,imgB64);
              try
                DMBaseIB.BDFACE_SCORE(transactionId,score);
              except
              end;

              Break;
            except
              on e:Exception do
              begin
                grabarEnArchivoLog('faceMath '+e.Message+ ' '+dir);
                if v=2 then begin
                  if (POS('The operation timed out',e.Message)>0)
                  or
                  (POS('connection with the server could',e.Message)>0)
                   then
                    if CMDReinicioFacial<>'' then begin
                      try
                        GetIWSArchAdminImpl.EjecutoBatRemoto(CMDReinicioFacial);
                        grabarEnArchivoLog('faceMath 1 Bat  '+e.Message+ ' '+dir);
                        Sleep(2000);
                      except
                        on e1:Exception do
                        begin
                          grabarEnArchivoLog('faceMath 2 Bat '+e1.Message+ ' '+dir);
                        end;
                      end;
                    end;
                end;


                if v=3 then begin
                  Response.Content := '{"result": false}';
                  grabarEnArchivoLog('Erorr de reinicio foto2 '+dir);
                  Exit;
                end;

                Sleep(500);
              end;
            end;
          end;
        finally
          CoUninitialize;
        end;
      finally
        StrL.Free;
      end;

      if score>60 then
        Response.Content := '{"result": true}';

      grabarArchivo(dir + 'compF.txt',IntToStr(score));
    end;
  finally
  FinH := iniH + ' '+FormatDateTime('hh:mm:ss', Now);
  //grabarEnArchivoDUR(FinH);
    DMBaseIB.Free;
  end;
//  except
//    on e:Exception do
//      ShowMessage(e.Message);
//  end;
end;

var
  ID:Integer=0;


procedure TWebModule1.WebModuleBeforeDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  Arch:String;
begin

  if WSDebug then
  begin
    inc(id);
    Arch:=ExtractFilePath(ParamStr(0))+'\LOGWS\'+FormatDateTime('YYYYMMDDhhmmss',now)+'_RES_Request_'+id.ToString+'.xml';
    grabarArchivo(Arch,Request.Content);
  end;

end;

end.

