program svrWSServiciosMaritimos;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  ubaseDatos in 'ubaseDatos.pas',
  uMainForm in 'uMainForm.pas' {MainForm},
  uWebModule in 'uWebModule.pas' {WebModule1: TWebModule},
  WsServiciosMaritimosImpl in 'WsServiciosMaritimosImpl.pas',
  WsServiciosMaritimosIntf in 'WsServiciosMaritimosIntf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := TWebModule1;

  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
