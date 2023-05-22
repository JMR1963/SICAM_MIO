program svrWSAutorizacion_de_Menor;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Uautorizacion_de_menor in 'Uautorizacion_de_menor.pas' {WebModule1: TWebModule},
  UdmDatosTramite in 'UdmDatosTramite.pas' {dmMenor: TDataModule},
  uMainForm in 'uMainForm.pas' {MainForm},
  ws_autorizacion_viajeImpl in 'ws_autorizacion_viajeImpl.pas',
  ws_autorizacion_viajeIntf in 'ws_autorizacion_viajeIntf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := TWebModule1;
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.CreateForm(TdmMenor, dmMenor);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
