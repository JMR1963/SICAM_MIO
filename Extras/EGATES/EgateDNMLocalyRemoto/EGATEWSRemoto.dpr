program EGATEWSRemoto;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  SysUtils,
  FrmWSRemotoEGATE in 'FrmWSRemotoEGATE.pas' {FormWSRemotoEGATE},
  WMWSRemotoEGATE in 'WMWSRemotoEGATE.pas' {WebModule1: TWebModule},
  WSRemotoEGATEImpl in 'WSRemotoEGATEImpl.pas',
  WSRemotoEGATEIntf in 'WSRemotoEGATEIntf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  WebRequestHandler.MaxConnections := 100;

  Application.Title := ExtractFileName(Application.ExeName);
  Application.MainFormOnTaskbar := True;
  Application.Initialize;
  Application.CreateForm(TFormWSRemotoEGATE, FormWSRemotoEGATE);
  Application.Run;
end.
