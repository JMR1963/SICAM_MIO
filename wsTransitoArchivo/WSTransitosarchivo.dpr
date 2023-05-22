program WSTransitosarchivo;

{$APPTYPE CONSOLE}

uses
  Web.WebBroker,
  web.CGIApp,
  Unit1 in 'Unit1.pas' {WebModule1: TWebModule},
  WSTransitosImpl in 'WSTransitosImpl.pas',
  WSTransitosIntf in 'WSTransitosIntf.pas',
  Udatos in 'Udatos.pas' {dmdatos: TDataModule},
  WebServiceMMPaysandu in 'WebServiceMMPaysandu.pas',
  Iwspuente1 in 'Iwspuente1.pas',
  IwsPuenteBolivia1 in 'IwsPuenteBolivia1.pas',
  IwsPuentePRY1 in 'IwsPuentePRY1.pas',
  ufixWS in 'ufixWS.pas',
  Ipuentechileno2 in 'Ipuentechileno2.pas',
  md5 in 'md5.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
