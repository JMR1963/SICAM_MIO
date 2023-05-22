{ Invokable implementation File for Tws_autorizacion_viaje which implements Iws_autorizacion_viaje }

unit ws_autorizacion_viajeImpl;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, ws_autorizacion_viajeIntf, UdmDatosTramite , Classes;

type


  { Tws_autorizacion_viaje }
  Tws_autorizacion_viaje = class(TInvokableClass, Iws_autorizacion_viaje)
  private
    function guardarMenor(menor: rmenor): integer;
    function guardarAutorizante(autorizante: rautorizante; numero: integer):integer;
    function guardarAcompaniante(acompanante: racompanante; id_autorizacion:integer):integer;
    function guardarTramite(datos_tramite: rdatos_tramite; id_autorizacion:integer): integer;
    function guardarAutorizacion(au:  rautorizacion):integer;
    function error_str(pedido: Tpedido): string;
    //-- Actualizar.

    function actualizarMenor(menor: rmenor; id:integer):integer;
    function actualizarAutorizante(autorizante: rautorizante; id:integer): integer;
    function actualizarAcompaniante(acompanante: racompanante; id:integer): integer;
    function actualizarTramite(datos_tramite: rdatos_tramite; id:integer;  paises:integer):integer;
    function actualizarAutorizacion(au: rautorizacion; id:integer): integer;
    procedure getIdsActualizar(var ids: rids);


    //---
    //function error_str: string;
    //----Funciones de validacion
    function v_sexo(s: char): string;
    function v_tipo_doc(s: string): string;
    function v_emisor(s: string): string;
    function v_nacionalidad(s: string): string;
    function v_fecha(s: string): string;
    procedure inicializarAutorizacion(var au:rautorizacion);
  public
    function grabar(pedido: Tpedido): tresultado;  stdcall;
    function revocar(solicitud:trevocar): tresultado_revocar; stdcall;
    function solicitudes_menor(solicitud: tsolicitud): tresultado_revocar; stdcall;
    function modificar(pedido: Tpedido; solicitud:TNumeroSolicitud): tresultado; stdcall;
  end;

implementation

uses SysUtils;

{ Tws_autorizacion_viaje }

function Tws_autorizacion_viaje.grabar(pedido: Tpedido): tresultado; stdcall;
var
  au: rautorizacion;
begin
{
  Chequeo de errores de catalogos en el envio.
}
  result := tresultado.Create;
  dmMenor := TdmMenor.Create(nil);
  //Si no hay error en los catalogos -> enviar
  if (error_str(pedido) = '') then
  begin
    //listo
    inicializarAutorizacion(au);
    au.id := dmMenor.siguienteNroAutorizacion;
    au.menor := guardarMenor(pedido.menor);
    //listo
    au.autorizante1 := guardarAutorizante(pedido.autorizante_1,au.id);
    //listo
    if (pedido.autorizante_2.apellido <> '') then
      au.autorizante2 := guardarAutorizante(pedido.autorizante_2,au.id)
    else
      au.autorizante2 := -1; //No hay autorizante2
    //listo
    au.acompaniante := guardarAcompaniante(pedido.acompanante, au.id);
    //--
    au.tramite      := guardarTramite(pedido.datos_tramite, au.id);
    //--
    result.fnumero_autorizacion := guardarAutorizacion(au);
    result.aceptado := True;
  end
  else
  begin
    //Hubo error en los catalogos.
    result.ferror               := error_str(pedido);
    Result.faceptado            := false;
    Result.fnumero_autorizacion := -1;
  end;
end;

function Tws_autorizacion_viaje.guardarAcompaniante(acompanante: racompanante; id_autorizacion:integer): integer;
begin
  result := dmMenor.guardarAcompaniante_db(acompanante, id_autorizacion);
end;

function Tws_autorizacion_viaje.guardarAutorizante(autorizante: rautorizante; numero: integer): integer;
begin
  result := dmMenor.guardarAutorizante_db(autorizante);
end;

function Tws_autorizacion_viaje.guardarMenor(menor: rmenor): integer;
begin
  result := dmMenor.guardarMenor_db(menor);
end;

function Tws_autorizacion_viaje.guardarTramite(datos_tramite: rdatos_tramite; id_autorizacion:integer): integer;
var
  paises: integer;
begin
  paises := 1;
  result := dmMenor.guardarTramite_db(datos_tramite, paises, id_autorizacion);
end;

function Tws_autorizacion_viaje.error_str(pedido: Tpedido): string;
begin
  //verificador Menor
  result := '';
  if (v_nacionalidad(pedido.menor.nacionalidad)  <> '') or
     (v_tipo_doc(pedido.menor.tipo_de_documento) <> '') or
     (v_emisor(pedido.menor.emisor_documento)    <> '') or
     (v_fecha(pedido.menor.fecha_de_nacimiento)  <> '') or
     (v_sexo(pedido.menor.sexo[1])               <> '') then
  begin
     result := 'Datos del menor invalidos';
     exit;
  end;
end;

function Tws_autorizacion_viaje.guardarAutorizacion(au: rautorizacion): integer;
begin
  result := dmMenor.guardarAutorizacion(au);
end;

function Tws_autorizacion_viaje.v_emisor(s: string): string;
begin
  result := '';
  if not dmMenor.emisor_valido(s) then
    result := 'Emisor de documento invalida' + s;
end;

function Tws_autorizacion_viaje.v_fecha(s: string): string;
//ddmmaaaa
var
  dia, mes, ano: integer;
begin
  try
    dia := StrToInt(copy(s,1,2));
    mes := StrToInt(copy(s,3,2));
    ano := StrToInt(copy(s,5,4));
    EncodeDate(ano,mes,dia);
  except
    result := 'Error en la fecha';
  end;

end;

function Tws_autorizacion_viaje.v_sexo(s: char): string;
begin
  try
    result := '';
    if (s = 'F') or (s = 'M') then
      result := ''
    else
      result := 'El sexo es invalido el mismo debe ser F o M.';
  except
    result := 'El sexo es invalido el mismo debe ser F o M.';
  end;

end;

function Tws_autorizacion_viaje.v_tipo_doc(s: string): string;
begin
  result := '';
  if not dmMenor.tipo_doc_valido(s) then
    result := 'Tipo de documento invalido: ' + s;
end;

function Tws_autorizacion_viaje.v_nacionalidad(s: string): string;
begin
  result := '';
  if not dmMenor.nacionalidad_valida(s) then
    result := 'Nacionalidad invalida';
end;

function Tws_autorizacion_viaje.revocar(solicitud:trevocar): tresultado_revocar;
var
  ts: TStringList;
begin
  ts := tstringList.Create;
  ts.Add('INICIO');
  ts.SaveToFile('log.txt');
  try
    dmMenor := TdmMenor.Create(nil);
    if dmMenor.guardar_revocacion(solicitud) then
    begin
      ts.Add('PASE GUARDAR');
      ts.SaveToFile('log.txt');
      dmMenor.marcar_persona_revocada(solicitud); //Marca a la persona como revocada y retorna un array
      ts.Add('PASE MARCAR');
      ts.SaveToFile('log.txt');
      dmMenor.revocar_siger(solicitud);
      ts.Add('PAE SIGER');
      ts.SaveToFile('log.txt');
      SetLength(result,1);
      result[0] := tautorizacion_numero.Create;
      result[0].fnumero_autorizacion := 'REVOCADA';
    end;
    dmMenor.Free;
  except
    on e:exception do
    begin
      SetLength(result,1);
      result[0] := tautorizacion_numero.Create;
      result[0].fnumero_autorizacion := e.Message;
    end;
  end;
end;

function Tws_autorizacion_viaje.solicitudes_menor(solicitud: tsolicitud): tresultado_revocar;
begin
   try
    dmMenor := TdmMenor.Create(nil);
    result := dmMenor.persona_solicitudes(solicitud); //Marca a la persona como revocada y retorna un array
    dmMenor.Free;
  except
    result := nil;
  end;

end;

procedure Tws_autorizacion_viaje.inicializarAutorizacion(var au: rautorizacion);
begin
  with au do
  begin
    id            := -1;
    menor         := -1;
    autorizante1  := -1;
    autorizante2  := -1;
    acompaniante  := -1;
    tramite       := -1;
  end;
end;

function Tws_autorizacion_viaje.modificar(pedido: Tpedido; solicitud:TNumeroSolicitud): tresultado; stdcall;
var
  au: rautorizacion;
  ids: rids;
  paises:integer;
begin
{
  Chequeo de errores de catalogos en el envio.
}
  result := tresultado.Create;
  dmMenor := TdmMenor.Create(nil);
  //Si no hay error en los catalogos -> enviar
  if (error_str(pedido) = '') then
  begin
    //listo
    inicializarAutorizacion(au);
    au.id := solicitud.numero_solicitud;
    ids.tramite := solicitud.numero_solicitud;
    getIdsActualizar(ids);
//aca
    au.menor := actualizarMenor(pedido.menor, ids.menor);
    //listo
    au.autorizante1 := actualizarAutorizante(pedido.autorizante_1,ids.autorizante1);
    //listo
    if (pedido.autorizante_2.apellido <> '') then
      au.autorizante2 := actualizarAutorizante(pedido.autorizante_2,ids.autorizante2)
    else
      au.autorizante2 := -1; //No hay autorizante2
    //listo

    au.acompaniante := actualizarAcompaniante(pedido.acompanante, au.id);
    //--
    au.tramite      := actualizarTramite(pedido.datos_tramite, au.id, paises);
    //--
    result.fnumero_autorizacion := actualizarAutorizacion(au, solicitud.numero_solicitud);
    result.aceptado := True;
  end
  else
  begin
    //Hubo error en los catalogos.
    result.ferror               := error_str(pedido);
    Result.faceptado            := false;
    Result.fnumero_autorizacion := -1;
  end;

end;

function Tws_autorizacion_viaje.actualizarAcompaniante(acompanante: racompanante; id: integer): integer;
begin
  result := dmMenor.actualizarAcompaniante_db(acompanante, id);

end;

function Tws_autorizacion_viaje.actualizarAutorizacion(au: rautorizacion; id:integer): integer;
begin
  result := dmMenor.actualizarAutorizacion(au, id);
end;

function Tws_autorizacion_viaje.actualizarAutorizante(
  autorizante: rautorizante; id: integer): integer;
begin
  result := dmMenor.actualizarAutorizante_db(autorizante, id);

end;

function Tws_autorizacion_viaje.actualizarMenor(menor: rmenor; id: integer): integer;
begin
  result := dmMenor.actualizarMenor(menor,id);

end;

function Tws_autorizacion_viaje.actualizarTramite(datos_tramite: rdatos_tramite; id: integer; paises:integer): integer;
begin
  result := dmMenor.actualizarTramite(datos_tramite, id, paises);
end;

procedure Tws_autorizacion_viaje.getIdsActualizar(var ids: rids);
begin
  dmMenor.getIdsActualizar(ids);

end;

initialization
  { Invokable classes must be registered }
  InvRegistry.RegisterInvokableClass(Tws_autorizacion_viaje);

end.
