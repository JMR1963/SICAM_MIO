program WSTAMS;

{$APPTYPE CONSOLE}

uses
  Web.WebBroker,
  Web.CGIApp,
  uws in 'uws.pas' {WebModule1: TWebModule},
  uTAMSImpl in 'uTAMSImpl.pas',
  uTAMSIntf in 'uTAMSIntf.pas',
  uAA2000 in 'uAA2000.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
