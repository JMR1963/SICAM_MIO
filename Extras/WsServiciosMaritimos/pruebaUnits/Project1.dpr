program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ubaseDatos in '..\src\ubaseDatos.pas',
  WsServiciosMaritimosIntf in '..\src\WsServiciosMaritimosIntf.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
