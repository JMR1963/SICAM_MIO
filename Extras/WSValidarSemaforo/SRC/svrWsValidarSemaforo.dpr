program svrWsValidarSemaforo;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Ipuentechileno1 in 'Ipuentechileno1.pas',
  uDMWebModule in 'uDMWebModule.pas' {WebModule1: TWebModule},
  uMainForm in 'uMainForm.pas' {MainForm},
  WSValidarSemaforoImpl in 'WSValidarSemaforoImpl.pas',
  WSValidarSemaforoIntf in 'WSValidarSemaforoIntf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := TWebModule1;

  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
