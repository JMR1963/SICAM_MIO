unit FrmfingerMatch;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp;

type
  TFormfingerMatch = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    EditPort: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    ButtonOpenBrowser: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    procedure StartServer;
    { Private declarations }
  public
    { Public declarations }
    procedure Configuracion;
  end;

var
  FormfingerMatch: TFormfingerMatch;

implementation

{$R *.dfm}

uses
  WinApi.Windows, Winapi.ShellApi,uGlobal,inifiles;


procedure TFormfingerMatch.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
end;

procedure TFormfingerMatch.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  ShellExecute(0,
        nil,
        PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TFormfingerMatch.ButtonStartClick(Sender: TObject);
begin
  StartServer;
end;

procedure TFormfingerMatch.ButtonStopClick(Sender: TObject);
begin
  FServer.Active := False;
  FServer.Bindings.Clear;
end;

procedure TFormfingerMatch.Configuracion;
var
  inifile: TIniFile;
  n:String;
begin
  n := ExtractFileName(ParamStr(0));
  n := ChangeFileExt(n,'.ini');
  inifile := TIniFile.Create(ExtractFilePath(ExtractFilePath(ParamStr(0)))+n);
  try
    EditPort.Text := inifile.ReadString('WS', 'PUERTO', '8091');
  finally
    inifile.Free;
  end;
end;

procedure TFormfingerMatch.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
  Configuracion;
  ButtonStart.Click;
end;

procedure TFormfingerMatch.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := True;
  end;
end;

end.
