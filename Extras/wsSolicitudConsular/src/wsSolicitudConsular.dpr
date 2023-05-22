program wsSolicitudConsular;
{$APPTYPE CONSOLE}
uses
  Web.WebBroker,
  web.CGIApp,
  SolicitudConsular in 'SolicitudConsular.pas' {WebModule1: TWebModule},
  wsSolicitudConsularImpl in 'wsSolicitudConsularImpl.pas',
  wsSolicitudConsularIntf in 'wsSolicitudConsularIntf.pas',
  uDMDatos in 'uDMDatos.pas' {DMDatos: TDataModule},
  uBase64 in 'uBase64.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
