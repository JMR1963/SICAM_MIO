program WSRenaper;
{$APPTYPE CONSOLE}
uses
  Web.WebBroker,
  Web.CGIApp,
  Uwsrenaper in 'Uwsrenaper.pas' {WebModule1: TWebModule},
  wsRenaperImpl in 'wsRenaperImpl.pas',
  wsRenaperIntf in 'wsRenaperIntf.pas',
  Umini in 'Umini.pas',
  UwsdlRenaper in 'UwsdlRenaper.pas',
  ufuncs in 'ufuncs.pas',
  Ufunciones in 'Ufunciones.pas',
  UDM1 in 'UDM1.pas' {dm1: TDataModule},
  DATOSFYH1 in 'DATOSFYH1.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
