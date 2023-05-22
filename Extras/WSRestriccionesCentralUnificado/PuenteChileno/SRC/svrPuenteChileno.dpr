program svrPuenteChileno;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uMainForm in 'uMainForm.pas' {MainForm},
  puentechilenoImpl in 'puentechilenoImpl.pas',
  puentechilenoIntf in 'puentechilenoIntf.pas',
  SemaforoCL in 'SemaforoCL.pas',
  ufixWS in 'ufixWS.pas',
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  WebService1 in 'WebService1.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
