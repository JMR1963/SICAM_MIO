program svrTransitoArchivo;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Ipuentechileno2 in 'Ipuentechileno2.pas',
  Iwspuente1 in 'Iwspuente1.pas',
  IwsPuenteBolivia1 in 'IwsPuenteBolivia1.pas',
  IwsPuentePRY1 in 'IwsPuentePRY1.pas',
  md5 in 'md5.pas',
  uBase64 in 'uBase64.pas',
  Udatos in 'Udatos.pas' {dmdatos: TDataModule},
  ufixWS in 'ufixWS.pas',
  uMainForm in 'uMainForm.pas' {MainForm},
  uMD5 in 'uMD5.pas',
  Unit1 in 'Unit1.pas' {WebModule1: TWebModule},
  WebServiceMMPaysandu in 'WebServiceMMPaysandu.pas',
  WSTransitosImpl in 'WSTransitosImpl.pas',
  WSTransitosIntf in 'WSTransitosIntf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := TWebModule1;
  Application.Initialize;
  Application.CreateForm(Tdmdatos, dmdatos);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
