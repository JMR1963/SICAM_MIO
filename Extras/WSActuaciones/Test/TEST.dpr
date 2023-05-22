program TEST;

uses
  Forms,
  UTestWS in 'UTestWS.pas' {Form1},
  IWSActuaciones1 in 'IWSActuaciones1.pas',
  WSActuacionesImpl in '..\src\WSActuacionesImpl.pas',
  WSActuacionesIntf in '..\src\WSActuacionesIntf.pas',
  UDMActuaciones in '..\src\UDMActuaciones.pas' {DMActuaciones: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  // Application.CreateForm(TDMActuaciones, DMActuaciones);
  Application.Run;
end.
