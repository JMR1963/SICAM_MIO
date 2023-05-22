program ws;

{$APPTYPE CONSOLE}

uses
  WebBroker,
  CGIApp,
  uWS in 'uWS.pas' {WebModule1: TWebModule},
  TRANSITOSGNAImpl in 'TRANSITOSGNAImpl.pas',
  TRANSITOSGNAIntf in 'TRANSITOSGNAIntf.pas',
  uGNAws in 'uGNAws.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
