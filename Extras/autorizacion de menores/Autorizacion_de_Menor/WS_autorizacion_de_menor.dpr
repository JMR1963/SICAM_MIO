program WS_autorizacion_de_menor;

{$APPTYPE CONSOLE}

uses
  WebBroker,
  CGIApp,
  Uautorizacion_de_menor in 'Uautorizacion_de_menor.pas' {WebModule1: TWebModule},
  ws_autorizacion_viajeImpl in 'ws_autorizacion_viajeImpl.pas',
  ws_autorizacion_viajeIntf in 'ws_autorizacion_viajeIntf.pas',
  UdmDatosTramite in 'UdmDatosTramite.pas' {dmMenor: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
