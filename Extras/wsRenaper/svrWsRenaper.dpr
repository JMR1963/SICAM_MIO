program svrWsRenaper;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  DATOSFYH1 in 'DATOSFYH1.pas',
  UDM1 in 'UDM1.pas' {dm1: TDataModule},
  Ufunciones in 'Ufunciones.pas',
  ufuncs in 'ufuncs.pas',
  uMainForm in 'uMainForm.pas' {MainForm},
  Umini in 'Umini.pas',
  UwsdlRenaper in 'UwsdlRenaper.pas',
  Uwsrenaper in 'Uwsrenaper.pas' {WebModule1: TWebModule},
  wsRenaperImpl in 'wsRenaperImpl.pas',
  wsRenaperIntf in 'wsRenaperIntf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := TWebModule1;
  Application.Initialize;
  Application.CreateForm(Tdm1, dm1);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
