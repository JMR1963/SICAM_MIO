{ Invokable implementation File for TWSRemotoEGATE which implements IWSRemotoEGATE }

unit WSRemotoEGATEImpl;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, WSRemotoEGATEIntf;

type

  { TWSRemotoEGATE }
  TWSRemotoEGATE = class(TInvokableClass, IWSRemotoEGATE)
  public
    function biometricdevices(paramList:AnsiString):AnsiString; stdcall;
    function fingerMatch(paramList:AnsiString;const image: TByteDynArray):Integer;stdcall;
    function faceMatch(paramList:AnsiString;const strImgB64:AnsiString):Integer;stdcall;
    function foto1fft(paramList:AnsiString):Integer;stdcall;
    procedure reinicioWS32RemotofingerMatch;stdcall;
  end;

implementation

uses EgateFunciones, Iwsbiometricdevices1, Winapi.ActiveX,Winapi.Windows,System.Classes,
   System.SysUtils,Winapi.ShellAPI,uNecFaceDLL,uGlobal,System.DateUtils;

var
  CSCara1: TRTLCriticalSection;




function TWSRemotoEGATE.biometricdevices(paramList:AnsiString):AnsiString;
var
  transactionId, idLOC,Sentido: string;
  dir: string;
  score: Integer;
  StrL:TStringList;
  p: TPerson;
  r: TResponse;
begin
  grabarEnArchivoLog('INI biometricdevices '+paramList);
  Result := '';
  try
    StrL:=TStringList.Create;
    StrL.Text := paramList;
    p := TPerson.Create;
    try
      idLOC := StrL.Values['idLOC'];
      transactionId := StrL.Values['transactionId'];
      sentido := StrL.Values['Sentido'];

      p.doc_type := StrL.Values['docType'];
      p.sub_doc_type := StrL.Values['subDocType'];
      p.issuing_country := StrL.Values['issuingCountry'];
      p.number := StrL.Values['docNumber'];
      p.nationality := StrL.Values['nationality'];
      p.sex := StrL.Values['sex'];
      wsbiometricdevices := StrL.Values['wsbiometricdevices'];

      r :=GetIwsbiometricdevices.getBiometricData(p);

      if (r.fingerWsq <> '') and (r.faseJpg <> '') then
      begin
        Result := r.faseJpg;

        DeleteFile(PChar(DirTransac(idLOC,transactionId) + 'foto1.jpg'));
        DeleteFile(PChar(DirTransac(idLOC,transactionId) + 'foto1.bmp'));

        ConvertStrBase64ToFile(r.fingerWsq, DirTransac(idLOC,transactionId)  +  'huella1.wsq');
        ConvertStrBase64ToFile(r.faseJpg, DirTransac(idLOC,transactionId) +  'foto1.jpg');

      end;
    finally
      StrL.Free;
      p.Free;
    end;
    grabarEnArchivoLog('FIN biometricdevices '+paramList);
  except
    on e:Exception do begin
      grabarEnArchivoLog('ERR biometricdevices '+paramList+e.Message);
    //Result := '';
    end;
  end;
end;


function TWSRemotoEGATE.fingerMatch(paramList: AnsiString;
  const image: TByteDynArray): Integer;
begin
  raise Exception.Create('Error fingerMatch NO USAR!');
{var
  transactionId, idLOC,Sentido: string;
  Path: string;
  StrL:TStringList;
  i,r:Integer;
begin
  Result := -1;
  try
    StrL:=TStringList.Create;
    StrL.Text := paramList;
    try
      idLOC := StrL.Values['idLOC'];
      transactionId := StrL.Values['transactionId'];
      sentido := StrL.Values['Sentido'];
    finally
      StrL.Free;
    end;

    Path := DirTransac(idLOC,transactionId);

    ByteArrayToFIle(image,Path+'huella2.wsq');

    grabarArchivoBat(Path + 'compH.bat', 'set path = ' + normalizoDir(ExtractFilePath(ParamStr(0))), normalizoDir(ExtractFilePath(ParamStr(0))) + 'CompararHuellasWSQ.exe ' + Path + 'huella1.wsq ' + Path + 'huella2.wsq', '', '', '');

    EnterCriticalSection(CSHuella);
    try
      ShellExecute(0, 'open', PChar(Path + 'compH.bat'), '', PChar(Path), 0);

      while not FileExists(Path + 'finH.txt') do
        Sleep(3);

      for I := 0 to 5 do
      try
        R := leerInt(Path + 'finH.txt');
        Break;
      except
        R := -1;
        Sleep(50);
      end;
    finally
      LeaveCriticalSection(CSHuella);
    end;
  finally
    Result := R;
  end;}
end;


function TWSRemotoEGATE.foto1fft(paramList: AnsiString): Integer;
var
  transactionId, idLOC: string;
  Path: string;
  StrL:TStringList;
begin
  Result := 0;

  try
    StrL:=TStringList.Create;
    StrL.Text := paramList;
    try
      idLOC := StrL.Values['idLOC'];
      transactionId := StrL.Values['transactionId'];
    finally
      StrL.Free;
    end;

    Path := DirTransac(idLOC,transactionId);

   // EnterCriticalSection(CSCara1);
    try
      if not (FileExists(Path + 'tmpFoto1.fft')) then
      begin
        if FileExists(Path + 'foto1.bmp') then
          Result := uNecFaceDLL.ConvertirFotoBmpAMinusia(Path,Path + 'foto1.bmp', Path + 'tmpFoto1.fft')
        else
          Result := -1;
      end;
    finally
     // LeaveCriticalSection(CSCara1);
    end;
  except
    Result := -1;
  end;

end;

procedure TWSRemotoEGATE.reinicioWS32RemotofingerMatch;
begin
  if MinutesBetween(Now,GLOBAL_FechaHuella)>2 then
  begin
    ShellExecute(0, 'open', PChar(normalizoDir(ExtractFilePath(ParamStr(0))) + 'reinicioWS32RemotofingerMatch.bat'), '', '', 0);
    GLOBAL_FechaHuella := Now;
    grabarEnArchivoLog('reinicioWS32RemotofingerMatch');
  end;
end;

{
function TWSRemotoEGATE.testCara: Integer;
var
  transactionId, idLOC,Sentido: string;
  Path: string;
  StrL:TStringList;
  score,r:Integer;
begin
  Result := -1;
  try



    Path := 'C:\LOCALNECFACE64\';

    if FileExists(Path + 'foto1.bmp') then
    begin

      EnterCriticalSection(CSCara1);
      try

        //if not (FileExists(Path + 'tmpFoto1.fft')) then
        //begin
        r := uNecFaceDLL.ConvertirFotoBmpAMinusia(Path,Path + 'foto1.bmp', Path + 'tmpFoto1.fft');
        //end;

        r := uNecFaceDLL.ConvertirFotoBmpAMinusia(Path,Path + 'foto2.bmp', Path + 'tmpFoto2.fft');

        if (FileExists(Path + 'tmpFoto1.fft')) and (FileExists(Path + 'tmpFoto2.fft')) then
        begin
          score := round(uNecFaceDLL.ArchFotoscore(Path + 'tmpFoto1.fft', Path + 'tmpFoto2.fft'));
        end;

      finally
        LeaveCriticalSection(CSCara1);
      end;

      Result := score;
    end;
  except
    Result := -1;
  end;

end; }

function TWSRemotoEGATE.faceMatch(paramList:AnsiString;const strImgB64:AnsiString):Integer;stdcall;
var
  transactionId, idLOC,Sentido: string;
  Path: string;
  StrL:TStringList;
  score:Integer;
begin
  Result := -1;

  if not FaceComp then
  begin
    grabarEnArchivoLog('Sin COMPARACION '+paramList);
    Result := FaceScore;
    Exit;
  end;


  grabarEnArchivoLog('INI faceMatch '+paramList);
  try
    StrL:=TStringList.Create;
    StrL.Text := paramList;
    try
      idLOC := StrL.Values['idLOC'];
      transactionId := StrL.Values['transactionId'];
      sentido := StrL.Values['Sentido'];
    finally
      StrL.Free;
    end;


    Path := DirTransac(idLOC,transactionId);

    if FileExists(Path + 'foto1.bmp') then
    begin
      DeleteFile(Path + 'foto2.jpg');
      DeleteFile(Path + 'foto2.bmp');

      ConvertStrBase64ToFile(strImgB64,Path+'foto2.jpg');
      try
        Jpeg2Bmp(Path + 'foto2.jpg', Path + 'foto2.bmp');
      except
        Jpeg2BmpOLD(Path + 'foto2.jpg', Path + 'foto2.bmp');
      end;

      if not FileExists(Path + 'foto2.bmp') then
         Exit;

      EnterCriticalSection(CSCara1);
      try

        if not (FileExists(Path + 'tmpFoto1.fft')) then
        begin
          uNecFaceDLL.ConvertirFotoBmpAMinusia(Path,Path + 'foto1.bmp', Path + 'tmpFoto1.fft');
        end;

        if not (FileExists(Path + 'tmpFoto2.fft')) then
        begin
          uNecFaceDLL.ConvertirFotoBmpAMinusia(Path,Path + 'foto2.bmp', Path + 'tmpFoto2.fft');
        end;

        if (FileExists(Path + 'tmpFoto1.fft')) and (FileExists(Path + 'tmpFoto2.fft')) then
        begin
          score := round(uNecFaceDLL.ArchFotoscore(Path + 'tmpFoto1.fft', Path + 'tmpFoto2.fft'));
        end;

      finally
        LeaveCriticalSection(CSCara1);
      end;

      Result := score;
    end;
    grabarEnArchivoLog('FIN faceMatch '+paramList);
  except
    on e:exception do begin
      grabarEnArchivoLog('ERR faceMatch '+paramList+ e.Message);
      Result := -1;
    end;
  end;

  grabarArchivo(Path+'finF.txt',IntToStr(Result));
end;



initialization
{ Invokable classes must be registered }
  InvRegistry.RegisterInvokableClass(TWSRemotoEGATE);

//  InitializeCriticalSection(CSHuella);
  InitializeCriticalSection(CSCara1);
//  InitializeCriticalSection(CSCara2);
finalization
//  DeleteCriticalSection(CSHuella);
  DeleteCriticalSection(CSCara1);
//  DeleteCriticalSection(CSCara2);


end.

