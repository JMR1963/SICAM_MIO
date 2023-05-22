program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ws_obtener_autorizacionImpl in '..\webServiceSICaM\ws_obtener_autorizacionImpl.pas',
  ws_obtener_autorizacionIntf in '..\webServiceSICaM\ws_obtener_autorizacionIntf.pas',
  Udatosd in '..\webServiceSICaM\Udatosd.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
