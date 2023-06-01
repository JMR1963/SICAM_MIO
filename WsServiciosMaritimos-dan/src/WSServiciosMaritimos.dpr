program WSServiciosMaritimos;

{$APPTYPE CONSOLE}

uses
  Web.WebBroker,
  Web.CGIApp,
  uWebModule in 'uWebModule.pas' {WebModule1: TWebModule},
  WsServiciosMaritimosImpl in 'WsServiciosMaritimosImpl.pas',
  WsServiciosMaritimosIntf in 'WsServiciosMaritimosIntf.pas',
  ubaseDatos in 'ubaseDatos.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
