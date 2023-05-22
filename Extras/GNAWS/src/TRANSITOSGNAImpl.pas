{ Invokable implementation File for TTRANSITOSGNA which implements ITRANSITOSGNA }

unit TRANSITOSGNAImpl;

interface

uses
  Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, TRANSITOSGNAIntf, System.SysUtils;

type

  { TTRANSITOSGNA }
  TTRANSITOSGNA = class(TInvokableClass, ITRANSITOSGNA)
  public
    function doRequest(Consulta: TConsulta) : TRespuesta; stdcall;
    function doRequestStr(Consulta: TConsulta) : String; stdcall;
    function doRequestPersons(fecha: string; matricula : string ) : TRespuesta; stdcall; // transitoDireccion : string
    function doRequestNew(ConsultaNew: TConsultaNew): TRespuesta;  stdcall;

    function doRequestAmpliada(Consulta: TConsulta): TRespuestaAmpliada; stdcall;
  end;

implementation

uses
  uGNAws;

function TTRANSITOSGNA.doRequest(Consulta: TConsulta): TRespuesta;
var
  q : TOraQry;
begin

  q := TOraQry.Create;
  Result := q.Exec(Consulta);
  q.Free;
end;

function TTRANSITOSGNA.doRequestAmpliada(Consulta: TConsulta): TRespuestaAmpliada; stdcall;
var
  q : TOraQry;
begin

  q := TOraQry.Create;
  Result := q.ExecAmpliada(Consulta);
  q.Free;
end;


function TTRANSITOSGNA.doRequestStr(Consulta: TConsulta) : String;
var
  q : TOraQry;
begin
  q := TOraQry.Create;
  Result := q.ExecStr(Consulta);
  q.Free;
end;

function TTRANSITOSGNA.doRequestPersons(fecha: string; matricula : string) : TRespuesta; //; transitoDireccion : string
var
  q : TOraQry;
begin
  q := TOraQry.Create2;
  result := q.ExecQry(fecha, matricula); //, transitoDireccion
  q.Free;
end;




function TTRANSITOSGNA.doRequestNew(ConsultaNew: TConsultaNew): TRespuesta;
var
  q : TOraQry;
begin

  q := TOraQry.Create;
  Result := q.ExecNew(ConsultaNew);
  q.Free;
end;

initialization
  { Invokable classes must be registered }
  InvRegistry.RegisterInvokableClass(TTRANSITOSGNA);

end.
 