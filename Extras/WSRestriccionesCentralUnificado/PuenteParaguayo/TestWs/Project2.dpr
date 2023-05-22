program Project2;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {Form2},
  IPuenteParaguayo1 in 'IPuenteParaguayo1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
