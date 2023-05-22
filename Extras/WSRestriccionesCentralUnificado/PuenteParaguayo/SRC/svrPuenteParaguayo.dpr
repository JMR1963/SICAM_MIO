program svrPuenteParaguayo;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  PuenteParaguayoImpl in 'PuenteParaguayoImpl.pas',
  PuenteParaguayoIntf in 'PuenteParaguayoIntf.pas',
  ufixWS in 'ufixWS.pas',
  uMainForm in 'uMainForm.pas' {MainForm},
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  WSPersonas in 'WSPersonas.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
