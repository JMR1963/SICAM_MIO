program svrPuenteInterpol;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uMainForm in 'uMainForm.pas' {MainForm},
  DNM_INTERPOL_WSService1 in 'C:\Git-WS\extras\WSRestriccionesCentralUnificado\PuenteInterpol\Src\DNM_INTERPOL_WSService1.pas',
  DNM_INTI_WSService in 'C:\Git-WS\extras\WSRestriccionesCentralUnificado\PuenteInterpol\Src\DNM_INTI_WSService.pas',
  puenteInterpolImpl in 'C:\Git-WS\extras\WSRestriccionesCentralUnificado\PuenteInterpol\Src\puenteInterpolImpl.pas',
  puenteInterpolIntf in 'C:\Git-WS\extras\WSRestriccionesCentralUnificado\PuenteInterpol\Src\puenteInterpolIntf.pas',
  ufixWS in 'C:\Git-WS\extras\WSRestriccionesCentralUnificado\PuenteInterpol\Src\ufixWS.pas',
  WebModuleUnit1 in 'C:\Git-WS\extras\WSRestriccionesCentralUnificado\PuenteInterpol\Src\WebModuleUnit1.pas' {WebModule1: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;

  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
