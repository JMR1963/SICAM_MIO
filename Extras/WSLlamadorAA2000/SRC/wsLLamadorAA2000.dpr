program wsLLamadorAA2000;

{$APPTYPE CONSOLE}

uses
  Web.WebBroker,
  Web.CGIApp,
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  wsLLamadorAA2000BImpl in 'wsLLamadorAA2000BImpl.pas',
  wsLLamadorAA2000BIntf in 'wsLLamadorAA2000BIntf.pas',
  manager in 'manager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  Application.Run;
end.
