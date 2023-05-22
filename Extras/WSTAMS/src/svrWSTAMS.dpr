program svrWSTAMS;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uMainForm in 'uMainForm.pas' {MainForm},
  uAA2000 in 'uAA2000.pas',
  uTAMSImpl in 'uTAMSImpl.pas',
  uTAMSIntf in 'uTAMSIntf.pas',
  uws in 'uws.pas' {WebModule1: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := TWebModule1;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
