program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Iws_obtener_autorizacion1 in 'Iws_obtener_autorizacion1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
