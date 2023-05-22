program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  puenteInterpolImpl in '..\Src\puenteInterpolImpl.pas',
  puenteInterpolIntf in '..\Src\puenteInterpolIntf.pas',
  DNM_INTERPOL_WSService1 in '..\Src\DNM_INTERPOL_WSService1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
