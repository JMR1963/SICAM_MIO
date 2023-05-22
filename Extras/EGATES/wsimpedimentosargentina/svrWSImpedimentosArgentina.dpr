program svrWSImpedimentosArgentina;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  IinfoTransporte1 in 'IinfoTransporte1.pas',
  IinfoTransporte2 in 'IinfoTransporte2.pas',
  IpuenteApiMar1 in 'IpuenteApiMar1.pas',
  Iws_obtener_autorizacion1 in 'Iws_obtener_autorizacion1.pas',
  IWSActuaciones1 in 'IWSActuaciones1.pas',
  IwsAnticipadaDNM1 in 'IwsAnticipadaDNM1.pas',
  IwsAnticipadaDNM2 in 'IwsAnticipadaDNM2.pas',
  IwsAnticipadaDNM3 in 'IwsAnticipadaDNM3.pas',
  IwsAnticipadaDNM4 in 'IwsAnticipadaDNM4.pas',
  IWsListaControl_unif1 in 'IWsListaControl_unif1.pas',
  IwsRenaper1 in 'IwsRenaper1.pas',
  IwsRestriccion1 in 'IwsRestriccion1.pas',
  uDMRestriccion in 'uDMRestriccion.pas' {DMRestriccion: TDataModule},
  ufixWS in 'ufixWS.pas',
  uMainForm in 'uMainForm.pas' {MainForm},
  utest in 'utest.pas' {Form1},
  uWSRestriccion in 'uWSRestriccion.pas' {WebModule1: TWebModule},
  wsAnticipadaDNM in 'wsAnticipadaDNM.pas',
  wsRestriccionImpl in 'wsRestriccionImpl.pas',
  wsRestriccionIntf in 'wsRestriccionIntf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := TWebModule1;

  Application.Initialize;
  Application.CreateForm(TDMRestriccion, DMRestriccion);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
