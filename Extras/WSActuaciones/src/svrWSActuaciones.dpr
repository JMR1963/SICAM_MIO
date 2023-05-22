program svrWSActuaciones;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  UDMActuaciones in 'UDMActuaciones.pas' {DMActuaciones: TDataModule},
  UFuncionesSQL in 'UFuncionesSQL.pas',
  uMainForm in 'uMainForm.pas' {MainForm},
  UWSActuaciones in 'UWSActuaciones.pas' {WebModule1: TWebModule},
  WSActuacionesImpl in 'WSActuacionesImpl.pas',
  WSActuacionesIntf in 'WSActuacionesIntf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := TWebModule1;

  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
