program EntradaCHLSalidaARG;

uses
  Forms,
  uEntradaCHLSalidaARG in 'uEntradaCHLSalidaARG.pas' {EntradaCHLSalidaARGFrm},
  uDMEntradaCHLSalidaARG in 'uDMEntradaCHLSalidaARG.pas' {DMSem: TDataModule},
  ufUsuarioIngreso in 'ufUsuarioIngreso.pas' {UsuarioIngresoFrm},
  uValidar in 'uValidar.pas' {ValidarFrm},
  IWSValidarSemaforo1 in 'IWSValidarSemaforo1.pas',
  IWsListaControl_Unif1 in 'IWsListaControl_Unif1.pas',
  uFaltantes in 'uFaltantes.pas' {FrmFaltantes},
  uList in 'uList.pas' {FrmLs},
  Diff in '..\diff\BasicDemo2\Diff.pas',
  HashUnit in '..\diff\BasicDemo2\HashUnit.pas',
  Unit1 in '..\diff\BasicDemo2\Unit1.pas' {FDiff},
  uDiff in '..\diffLQ\uDiff.pas' {FDiff2},
  ureacomodoArchivos in '..\diffLQ\ureacomodoArchivos.pas',
  IWSValidarSemaforo2 in '..\..\WSValidarSemaforo\Prueba\SRC\IWSValidarSemaforo2.pas',
  IwsRestriccionArgentina in 'IwsRestriccionArgentina.pas',
  IWsListaControl_Unif2 in 'IWsListaControl_Unif2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMSem, DMSem);
  Application.CreateForm(TEntradaCHLSalidaARGFrm, EntradaCHLSalidaARGFrm);
  Application.Run;
end.
