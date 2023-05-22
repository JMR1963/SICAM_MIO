program Prueba_WSValidarSemaforo;

uses
  Forms,
  UMain in 'UMain.pas' {FMain},
  IWSValidarSemaforo1 in 'IWSValidarSemaforo1.pas',
  Ipuentechileno1 in '..\..\SRC\Ipuentechileno1.pas',
  uFirmaDll in '..\..\SRC\uFirmaDll.pas',
  uFunciones in '..\..\SRC\uFunciones.pas',
  Unit1 in '..\..\SRC\Unit1.pas' {WebModule1: TWebModule},
  WSValidarSemaforoImpl in '..\..\SRC\WSValidarSemaforoImpl.pas',
  WSValidarSemaforoIntf in '..\..\SRC\WSValidarSemaforoIntf.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
