program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  UDMActuaciones in '..\src\UDMActuaciones.pas' {DMActuaciones: TDataModule},
  UFuncionesSQL in '..\src\UFuncionesSQL.pas',
  WSActuacionesImpl in '..\src\WSActuacionesImpl.pas',
  WSActuacionesIntf in '..\src\WSActuacionesIntf.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
