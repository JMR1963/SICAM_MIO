program PuenteCHILENo;

{$APPTYPE CONSOLE}

uses
  Web.WebBroker,
  Web.CGIApp,
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  puentechilenoImpl in 'puentechilenoImpl.pas',
  puentechilenoIntf in 'puentechilenoIntf.pas',
  WebService1 in 'WebService1.pas',
  SemaforoCL in 'SemaforoCL.pas',
  ufixWS in 'ufixWS.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  Application.Run;
end.
