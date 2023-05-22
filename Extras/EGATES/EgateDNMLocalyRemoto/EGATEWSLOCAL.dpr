program EGATEWSLOCAL;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  SysUtils,
  FrmEgate in 'FrmEgate.pas' {FrmWSEgate},
  WMEgate in 'WMEgate.pas' {WebModule1: TWebModule},
  EGateMgrWSImpl in 'EGateMgrWSImpl.pas',
  EGateMgrWSIntf in 'EGateMgrWSIntf.pas',
  uIcao in 'uIcao.pas',
  uScannerICAO in 'uScannerICAO.pas',
  EgateFunciones in 'EgateFunciones.pas',
  IwsRestriccion1 in 'IwsRestriccion1.pas',
  DMBase in 'DMBase.pas' {DMBaseIB: TDataModule},
  uGlobal in 'uGlobal.pas',
  uMANIFIESTO in 'uMANIFIESTO.pas',
  IWSTransitos1 in 'IWSTransitos1.pas',
  IWSRemotoEGATE1 in 'IWSRemotoEGATE1.pas',
  HiloWsRestricciones in 'HiloWsRestricciones.pas',
  IWS32RemotofingerMatch1 in 'IWS32RemotofingerMatch1.pas',
  IWSArchAdminImpl1 in 'IWSArchAdminImpl1.pas',
  IWsRA1 in 'IWsRA1.pas',
  HiloWsRestriccionesLOCAL in 'HiloWsRestriccionesLOCAL.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  WebRequestHandler.MaxConnections := 100;

  Application.MainFormOnTaskbar := True;
  Application.Title := ExtractFileName(Application.ExeName);
  Application.Initialize;
  Application.CreateForm(TFrmWSEgate, FrmWSEgate);
  Application.Run;

end.
