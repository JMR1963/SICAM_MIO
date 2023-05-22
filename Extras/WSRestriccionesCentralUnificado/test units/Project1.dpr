program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  WsListaControlIntf in '..\ws\src\WsListaControlIntf.pas',
  SqlOracleManage in '..\ws\src\SqlOracleManage.pas',
  UcheckConn in '..\ws\src\UcheckConn.pas',
  WsListaControlImpl in '..\ws\src\WsListaControlImpl.pas',
  Uhilo in '..\ws\src\Uhilo.pas',
  IWsListaControl1 in '..\ws\src\IWsListaControl1.pas',
  UGlobal in '..\ws\src\UGlobal.pas',
  IWsListaControl_unif1 in 'IWsListaControl_unif1.pas',
  consultaArgentina in '..\ws\src\consultaArgentina.pas',
  WSdePaiseParaConsultaRestriccionLocal in '..\ws\src\WSdePaiseParaConsultaRestriccionLocal.pas',
  IPuenteParaguayo1 in '..\ws\src\IPuenteParaguayo1.pas',
  IpuenteInterpol1 in '..\ws\src\IpuenteInterpol1.pas',
  IWsListaControl_unif2 in 'IWsListaControl_unif2.pas',
  IpuenteBoliviano1 in '..\ws\src\IpuenteBoliviano1.pas',
  Ipuentechileno2 in '..\ws\src\Ipuentechileno2.pas',
  IpuenteUry1 in '..\ws\src\IpuenteUry1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
