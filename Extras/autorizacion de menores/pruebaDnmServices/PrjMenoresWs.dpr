program PrjMenoresWs;

uses
  Forms,
  Ufrm in 'Ufrm.pas' {Form1},
  wsAutorizacionViaje in 'wsAutorizacionViaje.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
