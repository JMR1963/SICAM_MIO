program svrWsSolicitudConsular;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  SolicitudConsular in 'SolicitudConsular.pas' {WebModule1: TWebModule},
  uBase64 in 'uBase64.pas',
  uDMDatos in 'uDMDatos.pas' {DMDatos: TDataModule},
  uMainForm in 'uMainForm.pas' {MainForm},
  wsSolicitudConsularImpl in 'wsSolicitudConsularImpl.pas',
  wsSolicitudConsularIntf in 'wsSolicitudConsularIntf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := TWebModule1;
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.CreateForm(TDMDatos, DMDatos);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
