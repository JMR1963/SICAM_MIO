program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  SolicitudConsular in '..\src\SolicitudConsular.pas' {WebModule1: TWebModule},
  uDMDatos in '..\src\uDMDatos.pas' {DMDatos: TDataModule},
  wsSolicitudConsularImpl in '..\src\wsSolicitudConsularImpl.pas',
  wsSolicitudConsularIntf in '..\src\wsSolicitudConsularIntf.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TWebModule1, WebModule1);
  Application.CreateForm(TDMDatos, DMDatos);
  Application.Run;
end.
