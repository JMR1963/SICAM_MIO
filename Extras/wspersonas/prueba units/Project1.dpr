program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  webusersicamImpl in '..\Web service\webusersicamImpl.pas',
  webusersicamIntf in '..\Web service\webusersicamIntf.pas',
  ubaseDatos in '..\Web service\ubaseDatos.pas',
  uBase64 in '..\..\..\stable\7 Biometrico\src\Units\uBase64.pas',
  IwsRenaper1 in '..\Web service\IwsRenaper1.pas',
  ufixWS in '..\Web service\ufixWS.pas',
  Iwebusersicam3 in 'Iwebusersicam3.pas',
  IwsRenaper2 in '..\Web service\IwsRenaper2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
