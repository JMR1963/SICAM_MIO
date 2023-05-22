program Project2;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Uautorizacion_de_menor in '..\Uautorizacion_de_menor.pas' {WebModule1: TWebModule},
  UdmDatosTramite in '..\UdmDatosTramite.pas' {dmMenor: TDataModule},
  ws_autorizacion_viajeImpl in '..\ws_autorizacion_viajeImpl.pas',
  ws_autorizacion_viajeIntf in '..\ws_autorizacion_viajeIntf.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
