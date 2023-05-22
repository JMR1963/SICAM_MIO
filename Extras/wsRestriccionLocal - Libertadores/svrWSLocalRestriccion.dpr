program svrWSLocalRestriccion;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uMainForm in 'uMainForm.pas' {MainForm},
  IinfoTransporte2 in 'IinfoTransporte2.pas',
  IpuenteApiMar1 in 'IpuenteApiMar1.pas',
  Iws_obtener_autorizacion1 in 'Iws_obtener_autorizacion1.pas',
  IWSActuaciones1 in 'IWSActuaciones1.pas',
  IWsListaControl_unif1 in 'IWsListaControl_unif1.pas',
  IwsRenaper1 in 'IwsRenaper1.pas',
  IwsRestriccion1 in 'IwsRestriccion1.pas',
  uDMRestriccion in 'uDMRestriccion.pas' {DMRestriccion: TDataModule},
  ufixWS in 'ufixWS.pas',
  utest in 'utest.pas' {Form1},
  uWSRestriccion in 'uWSRestriccion.pas' {WebModule1: TWebModule},
  wsRestriccionImpl in 'wsRestriccionImpl.pas',
  wsRestriccionIntf in 'wsRestriccionIntf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := TWebModule1;

  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDMRestriccion, DMRestriccion);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
