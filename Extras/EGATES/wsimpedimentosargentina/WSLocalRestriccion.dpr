program WSLocalRestriccion;

{$APPTYPE CONSOLE}

uses
  Web.WebBroker,
  web.CGIApp,
  uWSRestriccion in 'uWSRestriccion.pas' {WebModule1: TWebModule},
  wsRestriccionImpl in 'wsRestriccionImpl.pas',
  wsRestriccionIntf in 'wsRestriccionIntf.pas',
  uDMRestriccion in 'uDMRestriccion.pas' {DMRestriccion: TDataModule},
  IWsListaControl_unif1 in 'IWsListaControl_unif1.pas',
  IpuenteApiMar1 in 'IpuenteApiMar1.pas',
  ufixWS in 'ufixWS.pas',
  Iws_obtener_autorizacion1 in 'Iws_obtener_autorizacion1.pas',
  IWSActuaciones1 in 'IWSActuaciones1.pas',
  IwsRenaper1 in 'IwsRenaper1.pas',
  IinfoTransporte2 in 'IinfoTransporte2.pas',
  IwsAnticipadaDNM1 in 'IwsAnticipadaDNM1.pas',
  wsAnticipadaDNM in 'wsAnticipadaDNM.pas',
  IwsAnticipadaDNM2 in 'IwsAnticipadaDNM2.pas',
  IwsAnticipadaDNM3 in 'IwsAnticipadaDNM3.pas',
  IwsAnticipadaDNM4 in 'IwsAnticipadaDNM4.pas',
  IinfoTransporte1 in 'IinfoTransporte1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
