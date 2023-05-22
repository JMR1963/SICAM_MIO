program svrGNWAS;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  TRANSITOSGNAImpl in 'src\TRANSITOSGNAImpl.pas',
  TRANSITOSGNAIntf in 'src\TRANSITOSGNAIntf.pas',
  uGNAws in 'src\uGNAws.pas',
  uMainForm in 'src\uMainForm.pas' {MainForm},
  uWS in 'src\uWS.pas' {WebModule1: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := TWebModule1;

  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
