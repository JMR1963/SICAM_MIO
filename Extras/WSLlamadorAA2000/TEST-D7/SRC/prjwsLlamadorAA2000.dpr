program prjwsLlamadorAA2000;

{$APPTYPE CONSOLE}

uses
  WebBroker,
  CGIApp,
  wsLlamadorAA2000 in 'wsLlamadorAA2000.pas' {WebModule1: TWebModule},
  wsLlamadorAA2000Impl in 'wsLlamadorAA2000Impl.pas',
  wsLlamadorAA2000Intf in 'wsLlamadorAA2000Intf.pas',
  manager in 'manager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
