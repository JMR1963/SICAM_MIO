program svrObtenerAutorizaciones;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Udatosd in 'Udatosd.pas' {DataModule1: TDataModule},
  uMainForm in 'uMainForm.pas' {MainForm},
  Uws in 'Uws.pas' {WebModule1: TWebModule},
  ws_obtener_autorizacionImpl in 'ws_obtener_autorizacionImpl.pas',
  ws_obtener_autorizacionIntf in 'ws_obtener_autorizacionIntf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := TWebModule1;

  Application.Initialize;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
