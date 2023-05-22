unit WMbiometricdevices;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp;

type
  TWebModule1 = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
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

uses EgateFunciones, IwsRestriccion1,
  Iwsbiometricdevices1, DMBase, System.NetEncoding,  Winapi.ShellAPI,
  IWSTransitos1, uMANIFIESTO, Winapi.ActiveX,Winapi.Windows;

function ExtractBetweenTags(const Line, TagI, TagF: string): string;
var
  i, f: integer;
begin
  i := Pos(TagI, Line);
  f := Pos(TagF, Copy(Line, i + length(TagI), MAXINT));
  if (i > 0) and (f > 0) then
    Result := Copy(Line, i + length(TagI), f - 1);
end;


procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);

var
  s, transactionId, idLOC: string;
  dir: string;
  score: Integer;
  StrL:TStringList;
  wsB: Iwsbiometricdevices;
  p: TPerson;
  r: TResponse;
begin

  Response.ContentType := 'text/plain; charset="UTF-8"';
  Response.Content := '';

  Handled := True;
  if Request.MethodType <> mtPost then
    Exit;
  try
    CoInitialize(nil);
    try
      if Pos('biometricdevices', LowerCase(Request.PathInfo)) > 0 then
      begin
        StrL:=TStringList.Create;
        try
          StrL.Text :=StringReplace(Request.Content,'&',#13#10,[rfReplaceAll]);
          idLOC := StrL.Values['idLOC'];
          transactionId := StrL.Values['transactionId'];

          p := TPerson.Create;

          p.doc_type := StrL.Values['docType'];
          p.sub_doc_type := StrL.Values['subDocType'];
          p.issuing_country := StrL.Values['issuingCountry'];
          p.number := StrL.Values['docNumber'];
          p.nationality := StrL.Values['nationality'];
          p.sex := StrL.Values['sex'];


          wsB := GetIwsbiometricdevices(false);
          r := wsB.getBiometricData(p);

          if (r.fingerWsq <> '') and (r.faseJpg <> '') then
          begin
            Response.Content := r.faseJpg;

            DeleteFile(PChar(DirTransac(idLOC,transactionId) + 'foto1.jpg'));
            DeleteFile(PChar(DirTransac(idLOC,transactionId) + 'foto1.bmp'));

            ConvertStrBase64ToFile(r.faseJpg, DirTransac(idLOC,transactionId) +  'foto1.jpg');
            Jpeg2BmpOLD(DirTransac(idLOC,transactionId) + 'foto1.jpg', DirTransac(idLOC,transactionId) + 'foto1.bmp');

            ConvertStrBase64ToFile(r.fingerWsq, DirTransac(idLOC,transactionId)  +  'huella1.wsq');
          end;
        finally
          StrL.Free;
        end;
      end;
    finally
      CoUninitialize;
    end;
  except
    Response.Content := '';
  end;

end;

end.
