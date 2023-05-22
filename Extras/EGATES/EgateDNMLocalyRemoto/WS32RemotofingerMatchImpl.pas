{ Invokable implementation File for TWS32RemotofingerMatch which implements IWS32RemotofingerMatch }

unit WS32RemotofingerMatchImpl;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, WS32RemotofingerMatchIntf;

type

  { TWS32RemotofingerMatch }
  TWS32RemotofingerMatch = class(TInvokableClass, IWS32RemotofingerMatch)
  public
    function fingerMatch(paramList:AnsiString;const image: TByteDynArray):Integer;stdcall;
    function formateoSoloHuella1WSQ(paramList:AnsiString):Integer;stdcall;    
    procedure reinicioWS64Remoto;stdcall;
  end;



function CompararHuellasWSQ(const H1,H2:Pchar):Integer; StdCall; external 'CompararHuellas.dll' name 'CompararHuellasWSQ';
function formateoWSQ1(const H1:Pchar):Integer; StdCall; external 'CompararHuellas.dll' name 'formateoWSQ1';


implementation

uses EgateFunciones, Iwsbiometricdevices1, Winapi.ActiveX,Winapi.Windows,System.Classes,
   System.SysUtils,Winapi.ShellAPI,uGlobal;

{ TWS32RemotofingerMatch }

var
  CSHuella: TRTLCriticalSection;


function TWS32RemotofingerMatch.fingerMatch(paramList: AnsiString;
  const image: TByteDynArray): Integer;
var
  transactionId, idLOC,Sentido: string;
  Path: string;
  StrL:TStringList;
  i,r:Integer;
  h1,h2:string;
begin
  Result := -1;
  CoInitialize(nil);
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
    if not FileExists(Path+'huella2.wsq') then Sleep(500);

    if not FileExists(Path+'huella2.wsq') then Exit;

    EnterCriticalSection(CSHuella);
    try
      try
        h1 := Path + 'huella1.wsq';
        h2 := Path + 'huella2.wsq';
        R := CompararHuellasWSQ(Pchar(AnsiString(h1)),Pchar(AnsiString(h2)));
      except
        R := -1;
      end;
    finally
      LeaveCriticalSection(CSHuella);
    end;
  finally
    try
      CoUninitialize;
      grabarEnArchivoLog('F CompararHuellasWSQ:'+Path);
    except
    end;
    Result := R;
  end;
end;

function TWS32RemotofingerMatch.formateoSoloHuella1WSQ(paramList: AnsiString): Integer;
var
  transactionId, idLOC,Sentido: string;
  Path: string;
  StrL:TStringList;
  i,r:Integer;
  h1,h2:string;
begin
  Result := -1;
  CoInitialize(nil);
  try
    StrL:=TStringList.Create;
    StrL.Text := paramList;
    try
      idLOC := StrL.Values['IDLOC'];
      transactionId := StrL.Values['transactionId'];
    finally
      StrL.Free;
    end;

    Path := DirTransac(idLOC,transactionId);


    EnterCriticalSection(CSHuella);
    try
      try
        h1 := Path + 'huella1.wsq';

        R := formateoWSQ1(Pchar(AnsiString(h1)));
      except
        R := -1;
      end;
    finally
      LeaveCriticalSection(CSHuella);
    end;
  finally
    try
      CoUninitialize;
    except
    end;
    Result := R;
  end;
end;


procedure TWS32RemotofingerMatch.reinicioWS64Remoto;
begin
  ShellExecute(0, 'open', PChar(normalizoDir(ExtractFilePath(ParamStr(0))) + 'reinicioWS64Remoto.bat'), '', '', 0);
  grabarEnArchivoLog('reinicioWS64Remoto');
end;

initialization


{ Invokable classes must be registered }
  InvRegistry.RegisterInvokableClass(TWS32RemotofingerMatch);
  InitializeCriticalSection(CSHuella);
finalization
  DeleteCriticalSection(CSHuella);

end.

