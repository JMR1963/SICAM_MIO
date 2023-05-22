program TEST;

uses
  Vcl.Forms,
  UTest in 'UTest.pas' {Form1},
  IEGateMgrWS1 in 'IEGateMgrWS1.pas',
  EgateFunciones in 'EgateFunciones.pas',
  IEGateMgrWS11 in 'IEGateMgrWS11.pas',
  IEGateMgrWS112 in 'IEGateMgrWS112.pas',
  IEGateMgrWS1123 in 'IEGateMgrWS1123.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
