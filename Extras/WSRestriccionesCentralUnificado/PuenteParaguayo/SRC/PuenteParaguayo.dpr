program PuenteParaguayo;

{$APPTYPE CONSOLE}

uses
  Web.WebBroker,
  CGIApp,
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  PuenteParaguayoImpl in 'PuenteParaguayoImpl.pas',
  PuenteParaguayoIntf in 'PuenteParaguayoIntf.pas',
  WSPersonas in 'WSPersonas.pas',
  ufixWS in 'ufixWS.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  Application.Run;
end.
