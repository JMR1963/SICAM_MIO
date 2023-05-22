program Project2;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {Form2},
  puentechilenoImpl in '..\SRC\puentechilenoImpl.pas',
  puentechilenoIntf in '..\SRC\puentechilenoIntf.pas',
  WebModuleUnit1 in '..\SRC\WebModuleUnit1.pas' {WebModule1: TWebModule},
  WebService1 in '..\SRC\WebService1.pas',
  SemaforoCL in '..\SRC\SemaforoCL.pas',
  ufixWS in '..\SRC\ufixWS.pas';

{$R *.res}

begin
  Application.Initialize;
//  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
