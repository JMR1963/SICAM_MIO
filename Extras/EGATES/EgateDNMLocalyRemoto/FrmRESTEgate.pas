unit FrmRESTEgate;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    EditPort: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    ButtonOpenBrowser: TButton;
    mmo1: TMemo;
    btn1: TButton;
    btn2: TButton;
    img1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);

  private
    FServer: TIdHTTPWebBrokerBridge;
    procedure StartServer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  WinApi.Windows, Winapi.ShellApi,System.JSON,EgateFunciones,WMRest,uGlobal;

procedure TForm1.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
end;

procedure TForm1.btn1Click(Sender: TObject);


Function ExtractBetweenTags(Const Line, TagI, TagF: string): string;
var
  i, f : integer;
begin
  i := Pos(TagI, Line);
  f := Pos(TagF, Copy(Line, i+length(TagI), MAXINT));
  if (i > 0) and (f > 0) then
    Result:= Copy(Line, i+length(TagI), f-1);
end;

begin

    ShowMessage(ExtractBetweenTags(mmo1.Text,'"gateid":"','"'));
    ShowMessage(ExtractBetweenTags(mmo1.Text,'"transactionId":"','"'));
    ShowMessage(ExtractBetweenTags(mmo1.Text,'"img":"','"'));
end;


procedure TForm1.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  ShellExecute(0,
        nil,
        PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TForm1.ButtonStartClick(Sender: TObject);
begin
  StartServer;
end;

procedure TForm1.ButtonStopClick(Sender: TObject);
begin
  FServer.Active := False;
  FServer.Bindings.Clear;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  EditPort.Text := IntToStr(PuertoREST);
  GLOBAL_NROREMOTO := NroRemoto;
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
  ButtonStart.Click;
end;

procedure TForm1.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := True;
  end;
end;

end.
