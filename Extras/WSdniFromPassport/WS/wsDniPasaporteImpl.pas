{ Invokable implementation File for TwsDniPasaporte which implements IwsDniPasaporte }

unit wsDniPasaporteImpl;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, wsDniPasaporteIntf, MIGRA_passWs;

type

  { TwsDniPasaporte }
  TwsDniPasaporte = class(TInvokableClass, IwsDniPasaporte)
  public
    function dniDePasaporte(unPasaporte: string): string; stdcall;
    function PasaportesEnTramite(dni, sexo: string): string; stdcall;
  end;

implementation

{ TwsDniPasaporte }

function TwsDniPasaporte.dniDePasaporte(unPasaporte: string): string;
var
  ws : renaperwsdlPortType;
  r: resultado;
  entrada: entrada_pasaporte;
begin
  try
    ws := GetrenaperwsdlPortType();
    entrada := entrada_pasaporte.Create;
    entrada.num_pasaporte := unPasaporte;
    result := ws.obtenerDni(entrada).nroDni;
  except
    result := 'ERROR';
  end;
end;

function TwsDniPasaporte.PasaportesEnTramite(dni, sexo: string): string;
var
  ws : renaperwsdlPortType;
  r: resultado;
  e: entrada;
begin
  try
    ws      := GetrenaperwsdlPortType();
    e       := entrada.Create;
    e.dni   := dni;
    e.sexo  := sexo;
    ws.obtenerTramitePass(e)


  except
    result := 'ERROR';
  end;
end;

initialization
  { Invokable classes must be registered }
  InvRegistry.RegisterInvokableClass(TwsDniPasaporte);

end.
 