unit uGlobal;

interface

uses
  System.Classes, System.SysUtils;

var
  GLOBAL_DB, TIPO_MEDIO_TRANSPORTE: string;
  wsRestriccionEntrada, wsRestriccionSalida, wsbiometric, wsfingerMatch,
    wstransitosarchivoEntrada, wstransitosarchivoSalida, IDLOC,
    wsbiometricdevices,wsbiometric2,wsfingerMatch2: string;
  GLOBAL_FechaHuella:TDateTime;
  GLOBAL_BORRARIMAGENES:LongWord=0;
  GLOBAL_NROREMOTO:Integer=0;
  GLOBAL_HABILITO_SICAM_PUERTAS:Boolean=false;

implementation

initialization
  GLOBAL_FechaHuella:=now-10;
end.
