program svrWSDniDePasaporte;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  MIGRA_passWs in 'MIGRA_passWs.pas',
  uMainForm in 'uMainForm.pas' {MainForm},
  Unit1 in 'Unit1.pas' {WebModule1: TWebModule},
  wsDniPasaporteImpl in 'wsDniPasaporteImpl.pas',
  wsDniPasaporteIntf in 'wsDniPasaporteIntf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := TWebModule1;

  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
