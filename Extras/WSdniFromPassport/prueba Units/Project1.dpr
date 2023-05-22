program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  wsDniPasaporteImpl in '..\WS\wsDniPasaporteImpl.pas',
  wsDniPasaporteIntf in '..\WS\wsDniPasaporteIntf.pas',
  MIGRA_passWs in '..\WS\MIGRA_passWs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
