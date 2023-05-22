program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  manager in 'manager.pas',
  IwsLlamadorAA2001 in 'IwsLlamadorAA2001.pas',
  IwsLlamadorAA20001 in 'IwsLlamadorAA20001.pas',
  IwsLlamadorAA20002 in 'IwsLlamadorAA20002.pas',
  IwsLlamadorAA20003 in 'IwsLlamadorAA20003.pas',
  IwsLlamadorAA20004 in 'IwsLlamadorAA20004.pas',
  IwsLlamadorAA20005 in 'IwsLlamadorAA20005.pas',
  IwsLLamadorAA2000B1 in 'IwsLLamadorAA2000B1.pas',
  IwsLLamadorAA2000B2 in 'IwsLLamadorAA2000B2.pas',
  IwsLLamadorAA2000B3 in 'IwsLLamadorAA2000B3.pas',
  IwsLLamadorAA2000B4 in 'IwsLLamadorAA2000B4.pas',
  IwsLLamadorAA2000B5 in 'IwsLLamadorAA2000B5.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
