program wsInfoTransporte;

{$APPTYPE CONSOLE}

uses
  Web.WebBroker,
  web.CGIApp,
  infotransporte in 'infotransporte.pas' {WebModule1: TWebModule},
  infoTransporteImpl in 'infoTransporteImpl.pas',
  infoTransporteIntf in 'infoTransporteIntf.pas',
  UDM in 'UDM.pas' {dm: TDataModule},
  IpuenteApiMar2 in 'IpuenteApiMar2.pas',
  IpuenteApiMar3 in 'IpuenteApiMar3.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
