program wsDespachosSicam;

{$APPTYPE CONSOLE}

uses
  web.WebBroker,
  Web.CGIApp,
  desapachosSicam in 'desapachosSicam.pas' {WebModule1: TWebModule},
  despachosSicamImpl in 'despachosSicamImpl.pas',
  despachosSicamIntf in 'despachosSicamIntf.pas',
  uDMDespachos in 'uDMDespachos.pas' {DMDespachos: TDataModule},
  Ipuentechileno1 in 'Ipuentechileno1.pas',
  md5 in 'md5.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
