program Project1;

uses
  Vcl.Forms,
  ConsultaImpedidos_v2 in '..\SRC\ConsultaImpedidos_v2.pas',
  puenteUryImpl in '..\SRC\puenteUryImpl.pas',
  puenteUryIntf in '..\SRC\puenteUryIntf.pas',
  ufixWS in '..\SRC\ufixWS.pas',
  WebModuleUnit1 in '..\SRC\WebModuleUnit1.pas' {WebModule1: TWebModule},
  WebService1 in '..\SRC\WebService1.pas',
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
