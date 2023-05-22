program Puenteury;

{$APPTYPE CONSOLE}

uses
  Web.WebBroker,
  CGIApp,
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  puenteuryImpl in 'puenteuryImpl.pas',
  puenteuryIntf in 'puenteuryIntf.pas',
  WebService1 in 'WebService1.pas',
  ufixWS in 'ufixWS.pas',
  ConsultaImpedidos_v21 in 'ConsultaImpedidos_v21.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  Application.Run;
end.
