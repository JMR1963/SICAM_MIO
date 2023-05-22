program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  IwsRestriccion1 in 'IwsRestriccion1.pas',
  uDMRestriccion in '..\uDMRestriccion.pas' {DMRestriccion: TDataModule},
  uWSRestriccion in '..\uWSRestriccion.pas' {WebModule1: TWebModule},
  wsRestriccionImpl in '..\wsRestriccionImpl.pas',
  wsRestriccionIntf in '..\wsRestriccionIntf.pas',
  IWsListaControl_unif1 in '..\IWsListaControl_unif1.pas',
  IpuenteApiMar1 in '..\IpuenteApiMar1.pas',
  Iws_obtener_autorizacion1 in '..\Iws_obtener_autorizacion1.pas',
  ufixWS in '..\ufixWS.pas',
  IWSActuaciones1 in '..\IWSActuaciones1.pas',
  IwsRenaper1 in '..\IwsRenaper1.pas',
  IinfoTransporte2 in '..\IinfoTransporte2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
