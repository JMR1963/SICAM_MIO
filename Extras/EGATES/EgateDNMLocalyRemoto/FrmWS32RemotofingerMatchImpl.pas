unit FrmWS32RemotofingerMatchImpl;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp, Vcl.Buttons;

type
  TFormWS32RemotofingerMatchImpl = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    EditPort: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    ButtonOpenBrowser: TButton;
    btn1: TBitBtn;
    edt1: TEdit;
    edt2: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    procedure StartServer;
    procedure Configuracion;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormWS32RemotofingerMatchImpl: TFormWS32RemotofingerMatchImpl;

implementation

{$R *.dfm}

uses
  WinApi.Windows, Winapi.ShellApi,uGlobal,inifiles,WS32RemotofingerMatchImpl;

procedure TFormWS32RemotofingerMatchImpl.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
end;

procedure TFormWS32RemotofingerMatchImpl.btn1Click(Sender: TObject);
var
  Path:string;
  P1:string;
begin
  CompararHuellasWSQ(Pchar(AnsiString(edt1.Text)),Pchar(AnsiString(edt2.Text)));
end;

procedure TFormWS32RemotofingerMatchImpl.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  ShellExecute(0,
        nil,
        PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TFormWS32RemotofingerMatchImpl.ButtonStartClick(Sender: TObject);
begin
  StartServer;
end;

procedure TFormWS32RemotofingerMatchImpl.ButtonStopClick(Sender: TObject);
begin
  FServer.Active := False;
  FServer.Bindings.Clear;
end;

procedure TFormWS32RemotofingerMatchImpl.Configuracion;
var
  inifile: TIniFile;
  n:String;
begin
  n := ExtractFileName(ParamStr(0));
  n := 'config.ini';//ChangeFileExt(n,'.ini');
  inifile := TIniFile.Create(ExtractFilePath(ExtractFilePath(ParamStr(0)))+n);
  try
    EditPort.Text := inifile.ReadString('WS32', 'PUERTO', '8091'); // '10.170.15.8:D:\Basedatos\sicam.gdb');
  finally
    inifile.Free;
  end;
end;

procedure TFormWS32RemotofingerMatchImpl.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
  Configuracion;
  ButtonStart.Click;
end;

procedure TFormWS32RemotofingerMatchImpl.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := True;
  end;
end;

end.
