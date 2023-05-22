program Project2;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {Form2},
  PuenteParaguayoImpl in '..\SRC\PuenteParaguayoImpl.pas',
  PuenteParaguayoIntf in '..\SRC\PuenteParaguayoIntf.pas',
  WebModuleUnit1 in '..\SRC\WebModuleUnit1.pas' {WebModule1: TWebModule},
  ufixWS in '..\SRC\ufixWS.pas',
  WSPersonas in '..\SRC\WSPersonas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
