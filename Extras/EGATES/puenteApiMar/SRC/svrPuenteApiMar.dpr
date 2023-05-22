program svrPuenteApiMar;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  puenteApiMarImpl in 'puenteApiMarImpl.pas',
  puenteApiMarIntf in 'puenteApiMarIntf.pas',
  ServicioConsulta in 'ServicioConsulta.pas',
  uMainForm in 'uMainForm.pas' {MainForm},
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
