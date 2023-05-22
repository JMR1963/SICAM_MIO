program ws;

{$APPTYPE CONSOLE}

uses
  Web.WebBroker,
  CGIApp,
  uWS in 'src\uWS.pas' {WebModule1: TWebModule},
  TRANSITOSGNAImpl in 'src\TRANSITOSGNAImpl.pas',
  TRANSITOSGNAIntf in 'src\TRANSITOSGNAIntf.pas',
  uGNAws in 'src\uGNAws.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
