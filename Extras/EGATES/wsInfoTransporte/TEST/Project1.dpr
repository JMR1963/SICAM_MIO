program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  infoTransporteImpl in '..\src\infoTransporteImpl.pas',
  infoTransporteIntf in '..\src\infoTransporteIntf.pas',
  IpuenteApiMar1 in '..\src\IpuenteApiMar1.pas',
  UDM in '..\src\UDM.pas' {dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
