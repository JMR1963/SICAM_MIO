unit FrmEgate;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp, Vcl.ExtCtrls;

type
  TFrmWSEgate = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    EditPort: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    ButtonOpenBrowser: TButton;
    btn1: TButton;
    btn2: TButton;
    mmo1: TMemo;
    btn3: TButton;
    mmo2: TMemo;
    btn4: TButton;
    btnReinciar: TButton;
    tmrReiniciar: TTimer;
    tmrCmd: TTimer;
    mmomrz: TMemo;
    btnMRZ: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure tmrReiniciarTimer(Sender: TObject);
    procedure btnReinciarClick(Sender: TObject);
    procedure btnMRZClick(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    procedure StartServer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmWSEgate: TFrmWSEgate;

implementation

{$R *.dfm}

uses
  Winapi.Windows, Winapi.ShellApi, uScannerICAO, EgateFunciones,
  System.DateUtils, uGlobal, DMBase, uMANIFIESTO,System.IOUtils,System.Types,PsAPI,Web.WebReq;

procedure TFrmWSEgate.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
end;

procedure TFrmWSEgate.btn1Click(Sender: TObject);
var
  l1, l2, l3: AnsiString;
  ICAO: TscannerICAO;
  f: TDateTime;
  AFormatSettings: TFormatSettings;
begin
  l1 := 'IDARG94203750<8<<<<<<<<<<<<<<<';
  l2 := '8005182F2809252USA<<<<<<<<<<<4';
  l3 := 'GARY<<AMANDA<BROOKE<<<<<<<<<<<'+ansichar(0);




  ICAO := TscannerICAO.Create;
  ICAO.linesAticao(l1, 0);
  ICAO.linesAticao(l2, 1);
  ICAO.linesAticao(l3, 2);
  ICAO.nlines := 3;

  ICAO.ExtractMRZ;
  ShowMessage(ICAO.names);
  // TryStrToDate(ICAO.dateOfBirth,f);

  ShowMessage(DateToStr(YYMMDDtoDate(ICAO.dateOfBirth)));

end;

procedure TFrmWSEgate.btn2Click(Sender: TObject);
begin
  ConvertStrBase64ToFile
    (ByteArraytoStr(FIleToByteArray('C:\egate\pruebas\fm\ARG-FCE-True.base64')),
    'C:\egate\pruebas\fm\f.jpg');
  ConvertFileToFileBase64('C:\egate\pruebas\fm\f.jpg',
    'C:\egate\pruebas\fm\f.b64');

  mmo1.Text := ConvertFileToStrBase64('C:\egate\pruebas\fm\f.jpg');
end;

procedure TFrmWSEgate.btn3Click(Sender: TObject);
begin
  // with Tmanifiesto.Create do
  // GenerarXMLVacio;
end;

procedure TFrmWSEgate.btn4Click(Sender: TObject);
var
 s:AnsiString;
 b:TByteDynArray;
begin
  s:= File2Str('C:\LOCALNECFACE64\info\PRUEBA\ZZE_20191202112006_716\foto1.jpg');

  ByteArrayToFIle(strToByteArray(s),'C:\TEMP\G.JPG');
end;

procedure TFrmWSEgate.btnMRZClick(Sender: TObject);
begin
  var s:ansiString;

  s:=trim(mmomrz.lines.text)+AnsiChar(0);
  mmomrz.lines.Text := s;
  mmomrz.Lines.SaveToFile('MRZ_ANSI.txt',TEncoding.ASCII)
end;

procedure TFrmWSEgate.btnReinciarClick(Sender: TObject);

var
  pmc: PPROCESS_MEMORY_COUNTERS;
  cb: Integer;
begin

if WebRequestHandler.ActiveCount<>0 then Exit;

  var archBat,cont:String;
  var memoria:Integer:=0;
  try
    cb := SizeOf(_PROCESS_MEMORY_COUNTERS);
    GetMem(pmc, cb);
    pmc^.cb := cb;
    if GetProcessMemoryInfo(GetCurrentProcess(), pmc, cb) then memoria := pmc^.WorkingSetSize div (1024*1024);

    FreeMem(pmc);
  except
    memoria := 0;
  end;

  if memoria>550 then
  begin
    grabarEnArchivoLog('**** REINICIO!!!****');
    archBat := ExtractFilePath(Application.ExeName)+'\reinicio.bat';
    cont := 'TASKKILL /F /IM '+ ExtractFileName(Application.ExeName)+' & start '+Application.ExeName;
    grabarArchivo(archBat,cont);
    ShellExecute(0, nil, PChar(archBat), nil, nil, SW_SHOWDEFAULT);
  end;


end;

procedure TFrmWSEgate.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  ShellExecute(0, nil, PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TFrmWSEgate.ButtonStartClick(Sender: TObject);
begin
  StartServer;
end;

procedure TFrmWSEgate.ButtonStopClick(Sender: TObject);
begin
  FServer.Active := False;
  FServer.Bindings.Clear;
end;

procedure TFrmWSEgate.FormCreate(Sender: TObject);
begin
  EditPort.Text := IntToStr(PuertoWS);
  GLOBAL_NROREMOTO := NroRemoto;
  FServer := TIdHTTPWebBrokerBridge.Create(Self);

  ButtonStart.Click;

end;

procedure TFrmWSEgate.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := True;
  end;
end;


procedure TFrmWSEgate.tmrReiniciarTimer(Sender: TObject);
begin
  tmrReiniciar.Enabled := False;
  try
    try
      btnReinciar.Click;
    except

    end;

  finally
    tmrReiniciar.Enabled := True;
  end;
end;

end.
