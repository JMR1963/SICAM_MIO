program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Iws_autorizacion_viaje1 in 'Iws_autorizacion_viaje1.pas',
  Iws_autorizacion_viaje2 in 'Iws_autorizacion_viaje2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
