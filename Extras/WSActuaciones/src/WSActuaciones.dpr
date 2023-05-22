program WSActuaciones;

{$APPTYPE CONSOLE}

uses
  web.WebBroker,
  web.CGIApp,
  UWSActuaciones in 'UWSActuaciones.pas' {WebModule1: TWebModule},
  WSActuacionesImpl in 'WSActuacionesImpl.pas',
  WSActuacionesIntf in 'WSActuacionesIntf.pas',
  UDMActuaciones in 'UDMActuaciones.pas' {DMActuaciones: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;                                                 
end.
