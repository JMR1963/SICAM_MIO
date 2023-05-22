program svrPuenteBoliviano;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uMainForm in 'uMainForm.pas' {MainForm},
  IpuenteBoliviano1 in 'IpuenteBoliviano1.pas',
  puenteBolivianoImpl in 'puenteBolivianoImpl.pas',
  puenteBolivianoIntf in 'puenteBolivianoIntf.pas',
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  wsImpedimentosBolivia in 'wsImpedimentosBolivia.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
