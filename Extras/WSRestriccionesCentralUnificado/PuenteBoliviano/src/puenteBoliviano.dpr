program puenteBoliviano;

{$APPTYPE CONSOLE}

uses
  Web.WebBroker,
  CGIApp,
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  puenteBolivianoImpl in 'puenteBolivianoImpl.pas',
  puenteBolivianoIntf in 'puenteBolivianoIntf.pas',
  wsImpedimentosBolivia in 'wsImpedimentosBolivia.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  Application.Run;
end.
