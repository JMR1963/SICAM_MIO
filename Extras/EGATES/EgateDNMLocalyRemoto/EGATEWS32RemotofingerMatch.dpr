program EGATEWS32RemotofingerMatch;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  SysUtils,
  FrmWS32RemotofingerMatchImpl in 'FrmWS32RemotofingerMatchImpl.pas' {FormWS32RemotofingerMatchImpl},
  WM32RemotofingerMatch in 'WM32RemotofingerMatch.pas' {WebModule1: TWebModule},
  WS32RemotofingerMatchImpl in 'WS32RemotofingerMatchImpl.pas',
  WS32RemotofingerMatchIntf in 'WS32RemotofingerMatchIntf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then begin
    WebRequestHandler.WebModuleClass := WebModuleClass;
    WebRequestHandler.MaxConnections := 500;
  end;
  Application.Title := ExtractFileName(Application.ExeName);
  Application.Initialize;
  Application.CreateForm(TFormWS32RemotofingerMatchImpl, FormWS32RemotofingerMatchImpl);
  Application.Run;
end.
