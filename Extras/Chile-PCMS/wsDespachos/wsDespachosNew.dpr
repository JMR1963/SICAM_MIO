program wsDespachosNew;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uMainForm in 'uMainForm.pas' {MainForm},
  desapachosSicam in 'desapachosSicam.pas' {WebModule1: TWebModule},
  despachosSicamImpl in 'despachosSicamImpl.pas',
  despachosSicamIntf in 'despachosSicamIntf.pas',
  Ipuentechileno1 in 'Ipuentechileno1.pas',
  md5 in 'md5.pas',
  uDMDespachos in 'uDMDespachos.pas' {DMDespachos: TDataModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := TWebModule1;

  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TWebModule1, WebModule1);
  Application.CreateForm(TDMDespachos, DMDespachos);
  Application.Run;
end.
