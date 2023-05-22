program EntradaARGSalidaCHL;

uses
  Forms,
  uEntradaARGSalidaCHL in 'uEntradaARGSalidaCHL.pas' {EntradaARGSalidaCHLFrm},
  uDMEntradaARGSalidaCHL in 'uDMEntradaARGSalidaCHL.pas' {DMSem: TDataModule},
  ufUsuarioIngreso in 'ufUsuarioIngreso.pas' {UsuarioIngresoFrm},
  uFaltantes in 'uFaltantes.pas' {FrmFaltantes},
  IWsListaControl_Unif2 in 'IWsListaControl_Unif2.pas',
  IwsRestriccionArgentina in 'IwsRestriccionArgentina.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMSem, DMSem);
  Application.CreateForm(TEntradaARGSalidaCHLFrm, EntradaARGSalidaCHLFrm);
  Application.Run;
end.
