program svrWebservSicam;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  IwsRenaper1 in 'IwsRenaper1.pas',
  md5 in 'md5.pas',
  sqlBaseManage in 'sqlBaseManage.pas',
  uBase64 in 'uBase64.pas',
  ubaseDatos in 'ubaseDatos.pas',
  ufixWS in 'ufixWS.pas',
  uMainForm in 'uMainForm.pas' {MainForm},
  UwsSicam in 'UwsSicam.pas' {WebModule1: TWebModule},
  webusersicamImpl in 'webusersicamImpl.pas',
  webusersicamIntf in 'webusersicamIntf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := TWebModule1;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
