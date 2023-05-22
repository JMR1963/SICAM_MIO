program webservsicam;

{
  Dos WebServices 



}

{$APPTYPE CONSOLE}

uses
  Web.WebBroker,
  Web.CGIApp,
  UwsSicam in 'UwsSicam.pas' {WebModule1: TWebModule},
  webusersicamImpl in 'webusersicamImpl.pas',
  webusersicamIntf in 'webusersicamIntf.pas',
  ubaseDatos in 'ubaseDatos.pas',
  uBase64 in 'uBase64.pas',
  ufixWS in 'ufixWS.pas',
  IwsRenaper1 in 'IwsRenaper1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
