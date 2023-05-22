program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {llamadas},
  wsConsultaAptitudExterna in 'wsConsultaAptitudExterna.pas',
  Unit2 in 'Unit2.pas' {Form2},
  consultaArgentina in '..\ws\src\consultaArgentina.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tllamadas, llamadas);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
