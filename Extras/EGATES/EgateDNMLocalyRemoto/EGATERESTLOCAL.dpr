program EGATERESTLOCAL;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  SysUtils,
  FrmRESTEgate in 'FrmRESTEgate.pas' {Form1},
  WMRest in 'WMRest.pas' {WebModule1: TWebModule},
  EgateFunciones in 'EgateFunciones.pas',
  DMBase in 'DMBase.pas' {DMBaseIB: TDataModule},
  IWSRemotoEGATE2 in 'IWSRemotoEGATE2.pas',
  IWSArchAdminImpl1 in 'IWSArchAdminImpl1.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  WebRequestHandler.MaxConnections := 500;

  Application.Title := ExtractFileName(Application.ExeName);
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
