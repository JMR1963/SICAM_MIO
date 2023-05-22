program puenteInterpol;

{$APPTYPE CONSOLE}

uses
  Web.WebBroker,
  CGIApp,
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  puenteInterpolImpl in 'puenteInterpolImpl.pas',
  puenteInterpolIntf in 'puenteInterpolIntf.pas',
  DNM_INTERPOL_WSService1 in 'DNM_INTERPOL_WSService1.pas',
  ufixWS in 'ufixWS.pas',
  DNM_INTI_WSService in 'DNM_INTI_WSService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  Application.Run;
end.
