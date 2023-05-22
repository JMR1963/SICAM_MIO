program WSValidarSemaforo;
{$APPTYPE CONSOLE}
uses
  Web.WebBroker,
  web.CGIApp,
  uDMWebModule in 'uDMWebModule.pas' {WebModule1: TWebModule},
  WSValidarSemaforoImpl in 'WSValidarSemaforoImpl.pas',
  WSValidarSemaforoIntf in 'WSValidarSemaforoIntf.pas',
  Ipuentechileno1 in 'Ipuentechileno1.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
