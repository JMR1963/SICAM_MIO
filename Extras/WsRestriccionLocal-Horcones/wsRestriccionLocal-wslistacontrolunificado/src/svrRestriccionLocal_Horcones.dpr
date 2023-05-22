program svrRestriccionLocal_Horcones;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  consultaArgentina in 'consultaArgentina.pas',
  InvRules in 'InvRules.pas',
  IpuenteBoliviano1 in 'IpuenteBoliviano1.pas',
  Ipuentechileno2 in 'Ipuentechileno2.pas',
  IpuenteInterpol1 in 'IpuenteInterpol1.pas',
  IPuenteParaguayo1 in 'IPuenteParaguayo1.pas',
  IpuenteUry1 in 'IpuenteUry1.pas',
  IWsListaControl1 in 'IWsListaControl1.pas',
  ListaControl in 'ListaControl.pas' {WebModule1: TWebModule},
  md5 in 'md5.pas',
  SqlOracleManage in 'SqlOracleManage.pas',
  UcheckConn in 'UcheckConn.pas',
  uexport in 'uexport.pas',
  UGlobal in 'UGlobal.pas',
  Uhilo in 'Uhilo.pas',
  uMainForm in 'uMainForm.pas' {MainForm},
  usocket in 'usocket.pas',
  WSdePaiseParaConsultaRestriccionLocal in 'WSdePaiseParaConsultaRestriccionLocal.pas',
  WsListaControlImpl in 'WsListaControlImpl.pas',
  WsListaControlIntf in 'WsListaControlIntf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := TWebModule1;

  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
