program prgtest;

uses
  Forms,
  utest in 'utest.pas' {Form1},
  wsRestriccionImpl in 'wsRestriccionImpl.pas',
  IwsRestriccion1 in 'IwsRestriccion1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
