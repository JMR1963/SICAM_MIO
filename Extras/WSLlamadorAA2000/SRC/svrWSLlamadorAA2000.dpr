program svrWSLlamadorAA2000;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  manager in 'manager.pas',
  uMainForm in 'uMainForm.pas' {MainForm},
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  wsLLamadorAA2000BImpl in 'wsLLamadorAA2000BImpl.pas',
  wsLLamadorAA2000BIntf in 'wsLLamadorAA2000BIntf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
