program WSDniDePasaporte;

{$APPTYPE CONSOLE}

uses
  Web.WebBroker,
  web.CGIApp,
  Unit1 in 'Unit1.pas' {WebModule1: TWebModule},
  wsDniPasaporteImpl in 'wsDniPasaporteImpl.pas',
  wsDniPasaporteIntf in 'wsDniPasaporteIntf.pas',
  MIGRA_passWs in 'MIGRA_passWs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
