unit UDMActuaciones;

interface

uses
  System.SysUtils, System.Classes, Data.DB, MemDS, DBAccess, Ora, WSActuacionesIntf,
  System.iniFiles, NetConn, OraCall;

type
  TDMActuaciones = class(TDataModule)
    OracleConexion: TOraSession;
    procedure DataModuleCreate(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
    function OpenSQL(strSQL:String;params:String;values:Variant):TOraQuery;
    ///* CONSULTAR DISPOSICIONES */
    function ConsultaDisposicion:string;
    function RestConsultaDisposicion(nro_dispo:Int64;anio:Integer):TResultado;
    ///* CONSULTAR EXPEDIENTES */
    function ConsultaExpedientes:string;
    function RestConsultaExpedientes(nro_Expediente:Int64):TResultado;

    function DoResultadoExpedientes(OraQuery:TOraQuery):TResultado;
    ///* CONSULTAR HABILITACIONES */
    function ConsultaHabilitaciones:string;
    function RestConsultaHabilitaciones(nro_habilitacion:string):TResultado;

    function DoResultadoHabilitaciones(OraQuery:TOraQuery):TResultado;
    ///*FOTO EXPEDIENTES
    function ConsultaFotoExpedientes:String;
    function RestFotoExpedientes(const nro_presol: Int64): String;

    function DoResultadoFoto(OraQuery:TOraQuery):String;

    function Loadimagen( Filename: String; var ImgEncode : string): boolean;    

    ///*FOTO HABILITACION
    function ConsultaFotoHabilitaciones:String;
    function RestFotoHabilitaciones(id_pers,ID_LOC:WideString): String;

    function RestSituacionMigratoria(doc:widestring; var Fecha_vto : string):string;
  end;

  var
      NetRemoteName : string;
    NetUserName    : string;
    NetPassword : string;


implementation

{$R *.dfm}

uses System.Variants, System.DateUtils, System.Types, WinApi.Windows, System.Math,
     IdBaseComponent, IdCoder, IdCoder3to4,
  IdCoderMIME, System.StrUtils;
{ TDMActuaciones }

const constDateTimeNull=-0.5;


function IntNull(i:Variant;defNull:Int64=-1):Int64;
begin
  result := IfThen(i=Null, defNull, i);
end;

function DateTimeNull(dt:Variant;defNull:TDateTime=constDateTimeNull):TDateTime;
begin
  if varIsNull(dt) then
    Result := defNull
  else
    Result := dt;
end;

function DTStr(dt:Variant):String;
var
  myStrDate:String;
begin
  myStrDate := '';
  if DateTimeNull(dt)<>constDateTimeNull then
    DateTimeToString(myStrDate,'DD/MM/YYYY HH:NN:SS',dt);
  Result := myStrDate;
end;

function TDMActuaciones.ConsultaFotoExpedientes:String;
var
  sql:String;
begin
//juampi
  sql :=
      'SELECT * '+
      'FROM sadex.FOTOS '+
      'WHERE NRO_PRESOLICITUD = :NRO_PRESOLICITUD ';

  Result := sql;
end;

function TDMActuaciones.ConsultaExpedientes: string;
var
  sql:String;

begin

  {sql :=
    'SELECT /* CONSULTAR DISPOSICIONES */ '+
    '   null as IDACTUACION, '+
    '   t.apellido1_documento || '' '' || t.apellido2_documento as APELLIDO,  '+
    '   t.nombre1_documento || '' '' || t.nombre2_documento as NOMBRE,  '+
    '   t.nro_cuim as NRO_CUIM, '+
    '   t.nro_presolicitud as NRO_PRESOL, '+
    '   td.descripcion as TIPO_DOC, '+
    '   t.nro_documento as NUM_DOC, '+
    '   p.fecha_nacimiento as FECHA_NAC, '+
    '   p.sexo as SEXO, '+
    '   ec.descripcion as E_CIVIL, '+
    '   pais.descripcion as PAIS_NAC, '+
    '   nac.nacionalidad as NACIONALIDAD,  '+
    '   t.fecha_ultimo_ingreso as FECHA_INGRESO, '+
    '   t.domicilio_real as DOMICILIO, '+
    '   loc.descripcion as LOCALIDAD, '+
    '   prof.descripcion as PROFESION, '+
    '   t.apellido_madre || '' '' || t.nombre_madre as DATO_MADRE,  '+
    '   t.apellido_padre || '' '' || t.nombre_padre as DATO_PADRE,  '+
    '   tt.descripcion as TIPO_ACTUACION, '+
    '   t.nro_expediente as NRO_EXPEDIENTE, '+
    '   t.fecha_expediente as FECHA_INICIO,  '+
    '   del.descripcion as DELEGACION_INICIO,  '+
    '   mot.descripcion as MOTIVO, '+
    '   cri.descripcion as NORMA, '+
    '   cat.descripcion as CATEGORIA_OBTENIDA, '+
    '   d.nro_disposicion as NRO_DISPO,  '+
    '   d.fecha_disposicion as FECHA_DISPO, '+
    '   case t.tipo_tramite when 1 then d.fecha_desde '+
    '                       when 100 then d.fecha_desde '+
    '					   when 102 then d.fecha_desde  '+
    '        else null end as FECHA_RADICACION_DESDE, '+
    '   case t.tipo_tramite when 7 then t.vencimiento_dnm else '+
    '   d.fecha_vencimiento end as FECHA_VENCIMIENTO, '+
    '   con.descripcion as CONSULADO, '+
    '   t.nro_acto as NRO_ACTO_CONSULAR, '+
    '   t.anio_acto as ANIO_ACTO_CONSULAR, '+
    '   case when t.permanencia_dnm_dias is not null then to_char(t.permanencia_dnm_dias) || '' d�as'' '+
    '   when t.permanencia_dnm_meses is not null then to_char(t.permanencia_dnm_meses) || '' meses'' '+
    '   when t.permanencia_dnm_fecha is not null then ''hasta '' || to_char(t.permanencia_dnm_fecha,''dd-mm-yyyy'') end as PERMANENCIA_AUTORIZADA_DNM, '+
    '   case when t.permanencia_consul_dias is not null then to_char(t.permanencia_consul_dias) || '' d�as'' '+
    '   when t.permanencia_consul_meses is not null then to_char(t.permanencia_consul_meses) || '' meses'' '+
    '   when t.permanencia_consul_anios is not null then t.permanencia_consul_anios || '' a�os'' end as PERMANENCIA_AUTORIZADA_CONSUL, '+
    '   (case when t.permanencia_dnm_dias is not null then t.permanencia_dnm_dias '+
    '   when t.permanencia_dnm_meses is not null then t.permanencia_dnm_meses * 30 '+
    '   when t.permanencia_dnm_fecha is not null then cast(trunc(t.permanencia_dnm_fecha) - trunc(sysdate) as integer) else null end) as DIAS, '+
    '   (case when t.permanencia_consul_dias is not null then t.permanencia_consul_dias '+
    '   when t.permanencia_consul_meses is not null then t.permanencia_consul_meses * 30 '+
    '   when t.permanencia_consul_anios is not null then t.permanencia_consul_anios * 365 else null end) as DIAS_CONSULADO, '+
    '   d.ANIO_DISPOSICION, '+
    '   case when fecha_ultimo_ingreso is not null then cast (trunc(fecha_ultimo_ingreso + (case when t.permanencia_dnm_dias is not null then t.permanencia_dnm_dias '+
    '   when t.permanencia_dnm_meses is not null then t.permanencia_dnm_meses * 30 '+
    '   when t.permanencia_dnm_fecha is not null then cast(trunc(t.permanencia_dnm_fecha) - trunc(sysdate) as integer)end)) - trunc(sysdate) as integer)  else null end as DIAS_CON_INGRESO, '+
    '   FECHA_ULTIMO_INGRESO, '+
    '   t.PAIS_DOCUMENTO as Cod_Pais_Emisor, '+
    '   t.NACIONALIDAD as Cod_Nacionalidad '+
    'FROM  '+
    '   sadex.persona p '+
    '   join sadex.tramite t on (p.nro_cuim = t.nro_cuim and t.anulado = ''f'') '+
    '   join sadex.disposiciones d on t.nro_expediente = d.nro_expediente '+
    '   join catalogos.cat_resoluciones r on d.criterio = r.codigo '+
    '   join catalogos.cat_categorias cat on r.codigo_categoria = cat.codigo '+
    '   join catalogos.cat_criterios cri on r.codigo_criterio = cri.codigo '+
    '   join catalogos.cat_motivos mot on r.codigo_motivo = mot.codigo '+
    '   left outer join catalogos.cat_motivos submot on r.codigo_submotivo = submot.codigo '+
    '   left outer join catalogos.cat_motivos esp on r.codigo_especialidad = esp.codigo '+
    '   join catalogos.cat_delegaciones del on t.delegacion = del.codigo '+
    '   join catalogos.cat_tipo_tramite tt on t.tipo_tramite = tt.codigo '+
    '   join catalogos.cat_paises pais on p.pais_nacimiento = pais.codigo '+
    '   join catalogos.cat_tipo_documento td on t.tipo_documento = td.codigo '+
    '   left outer join catalogos.vw_nacionalidades nac on t.nacionalidad = nac.codigo_nacionalidad '+
    '   left outer join catalogos.cat_estado_civil ec on t.estado_civil = ec.codigo '+
    '   left outer join catalogos.cat_profesiones prof on t.profesion = prof.codigo '+
    '   left outer join catalogos.cat_localidades loc on t.localidad_real = loc.codigo '+
    '   left outer join catalogos.cat_consulados con on t.consulado = con.codigo    '+
    'where '+
    ' d.nro_disposicion is not null and ' +
    ' t.nro_expediente = :nro_expediente ' +
    'union all '+
    'SELECT /* CONSULTA PRECARIA DEL TRAMITE COMUN */ '+
    '   null as IDACTUACION, '+
    '   t.apellido1_documento || '' '' || t.apellido2_documento as APELLIDO,  '+
    '   t.nombre1_documento || '' '' || t.nombre2_documento as NOMBRE,  '+
    '   t.nro_cuim as NRO_CUIM, '+
    '   t.nro_presolicitud as NRO_PRESOL, '+
    '   td.descripcion as TIPO_DOC, '+
    '   t.nro_documento as NUM_DOC, '+
    '   p.fecha_nacimiento as FECHA_NAC, '+
    '   p.sexo as SEXO, '+
    '   ec.descripcion as E_CIVIL, '+
    '   pais.descripcion as PAIS_NAC, '+
    '   nac.nacionalidad as NACIONALIDAD,  '+
    '   t.fecha_ultimo_ingreso as FECHA_INGRESO, '+
    '   t.domicilio_real as DOMICILIO, '+
    '   loc.descripcion as LOCALIDAD, '+
    '   prof.descripcion as PROFESION, '+
    '   t.apellido_madre || '' '' || t.nombre_madre as DATO_MADRE,  '+
    '   t.apellido_padre || '' '' || t.nombre_padre as DATO_PADRE,  '+
    '   ''PRECARIA'' as TIPO_ACTUACION, '+
    '   t.nro_expediente as NRO_EXPEDIENTE, '+
    '   case when t.fecha_conversion_radicacion is not null '+
    '		then t.fecha_conversion_radicacion '+
    '		else t.fecha_expediente end as FECHA_INICIO,  '+
    '   del.descripcion as DELEGACION_INICIO,  '+
    '   null as MOTIVO, '+
    '   null as NORMA, '+
    '   null as CATEGORIA_OBTENIDA, '+
    '   null as NRO_DISPO,  '+
    '   null as FECHA_DISPO, '+
    '   null as FECHA_RADICACION_DESDE, '+
    '   t.vencimiento_precaria as FECHA_VENCIMIENTO, '+
    '   null as CONSULADO, '+
    '   null as NRO_ACTO_CONSULAR, '+
    '   null as ANIO_ACTO_CONSULAR, '+

    '   null as PERMANENCIA_AUTORIZADA_DNM, '+
    '   null as PERMANENCIA_AUTORIZADA_CONSUL, '+
    '   null as DIAS, '+
    '   null as DIAS_CONSULADO, '+
    '   null as ANIO_DISPOSICION, '+
    '   null as DIAS_CON_INGRESO, '+
    '   null as FECHA_ULTIMO_INGRESO, '+
    '   t.PAIS_DOCUMENTO as Cod_Pais_Emisor, '+
    '   t.NACIONALIDAD as Cod_Nacionalidad '+
    'FROM  '+
    '   sadex.persona p '+
    '   join sadex.tramite t on (p.nro_cuim = t.nro_cuim and t.anulado = ''f'') '+
    '   join catalogos.cat_paises pais on p.pais_nacimiento = pais.codigo '+
    '   join catalogos.cat_tipo_documento td on t.tipo_documento = td.codigo '+
    '   join catalogos.cat_delegaciones del on t.delegacion = del.codigo '+
    '   left outer join catalogos.vw_nacionalidades nac on t.nacionalidad = nac.codigo_nacionalidad '+
    '   left outer join catalogos.cat_estado_civil ec on t.estado_civil = ec.codigo '+
    '   left outer join catalogos.cat_profesiones prof on t.profesion = prof.codigo '+
    '   left outer join catalogos.cat_localidades loc on t.localidad_real = loc.codigo '+
    'where '+
    '   t.nro_expediente = :nro_expediente and ' +
    '   fecha_expediente is not null and '+
    '   dias_precaria is not null and '+
    '   t.tipo_tramite <> 100  '+
    'union all '+
    'SELECT /* CONSULTA PRECARIA DEL TRAMITE PATRIA */ '+
    '   null as IDACTUACION, '+
    '   t.apellido1_documento || '' '' || t.apellido2_documento as APELLIDO,  '+
    '   t.nombre1_documento || '' '' || t.nombre2_documento as NOMBRE,  '+
    '   t.nro_cuim as NRO_CUIM, '+
    '   t.nro_presolicitud as NRO_PRESOL, '+
    '   td.descripcion as TIPO_DOC, '+
    '   t.nro_documento as NUM_DOC, '+
    '   p.fecha_nacimiento as FECHA_NAC, '+
    '   p.sexo as SEXO, '+
    '   ec.descripcion as E_CIVIL, '+
    '   pais.descripcion as PAIS_NAC, '+
    '   nac.nacionalidad as NACIONALIDAD,  '+
    '   t.fecha_ultimo_ingreso as FECHA_INGRESO, '+
    '   t.domicilio_real as DOMICILIO, '+
    '   loc.descripcion as LOCALIDAD, '+
    '   prof.descripcion as PROFESION, '+
    '   t.apellido_madre || '' '' || t.nombre_madre as DATO_MADRE,  '+
    '   t.apellido_padre || '' '' || t.nombre_padre as DATO_PADRE,  '+
    '   ''PRECARIA'' as TIPO_ACTUACION, '+
    '   t.nro_expediente as NRO_EXPEDIENTE, '+
    '   case when t.fecha_conversion_radicacion is not null '+
    '		then t.fecha_conversion_radicacion '+
    '		else t.fecha_expediente end as FECHA_INICIO,  '+
    '   del.descripcion as DELEGACION_INICIO,  '+
    '   null as MOTIVO, '+
    '   null as NORMA, '+
    '   null as CATEGORIA_OBTENIDA, '+
    '   null as NRO_DISPO,  '+
    '   null as FECHA_DISPO, '+
    '   null as FECHA_RADICACION_DESDE, '+
    '   t.vencimiento_precaria as FECHA_VENCIMIENTO, '+
    '   null as CONSULADO, '+
    '   null as NRO_ACTO_CONSULAR, '+
    '   null as ANIO_ACTO_CONSULAR, '+
    '   null as PERMANENCIA_AUTORIZADA_DNM, '+
    '   null as PERMANENCIA_AUTORIZADA_CONSUL, '+
    '   null as DIAS, '+
    '   null as DIAS_CONSULADO, '+
    '   null as ANIO_DISPOSICION, '+
    '   null as DIAS_CON_INGRESO, '+
    '   null as FECHA_ULTIMO_INGRESO, '+
    '   t.PAIS_DOCUMENTO as Cod_Pais_Emisor, '+
    '   t.NACIONALIDAD as Cod_Nacionalidad '+
    'FROM  '+
    '   sadex.persona p '+
    '   join sadex.tramite t on (p.nro_cuim = t.nro_cuim and t.anulado = ''f'') '+
    '   join catalogos.cat_paises pais on p.pais_nacimiento = pais.codigo '+
    '   join catalogos.cat_tipo_documento td on t.tipo_documento = td.codigo '+
    '   join catalogos.cat_delegaciones del on t.delegacion = del.codigo '+
    '   left outer join catalogos.vw_nacionalidades nac on t.nacionalidad = nac.codigo_nacionalidad '+
    '   left outer join catalogos.cat_estado_civil ec on t.estado_civil = ec.codigo '+
    '   left outer join catalogos.cat_profesiones prof on t.profesion = prof.codigo '+
    '   left outer join catalogos.cat_localidades loc on t.localidad_real = loc.codigo '+
    'WHERE '+
    '   t.nro_expediente = :nro_expediente and ' +
    '   fecha_expediente is not null and '+
    '   dias_precaria is not null and '+
    '   t.tipo_tramite = 100    '+
    'union all '+
    'SELECT /* CONSULTA PRECARIAS */ '+
    '   null as IDACTUACION, '+
    '   t.apellido1_documento || '' '' || t.apellido2_documento as APELLIDO,  '+
    '   t.nombre1_documento || '' '' || t.nombre2_documento as NOMBRE,  '+
    '   t.nro_cuim as NRO_CUIM, '+
    '   t.nro_presolicitud as NRO_PRESOL, '+
    '   td.descripcion as TIPO_DOC, '+
    '   t.nro_documento as NUM_DOC, '+
    '   p.fecha_nacimiento as FECHA_NAC, '+
    '   p.sexo as SEXO, '+
    '   ec.descripcion as E_CIVIL, '+
    '   pais.descripcion as PAIS_NAC, '+
    '   nac.nacionalidad as NACIONALIDAD,  '+
    '   t.fecha_ultimo_ingreso as FECHA_INGRESO, '+
    '   t.domicilio_real as DOMICILIO, '+
    '   loc.descripcion as LOCALIDAD, '+
    '   prof.descripcion as PROFESION, '+
    '   t.apellido_madre || '' '' || t.nombre_madre as DATO_MADRE,  '+
    '   t.apellido_padre || '' '' || t.nombre_padre as DATO_PADRE,  '+
    '   ''PRECARIA'' as TIPO_ACTUACION, '+
    '   t.nro_expediente as NRO_EXPEDIENTE, '+
    '   pre.fecha_precaria as FECHA_INICIO,  '+
    '   del.descripcion as DELEGACION_INICIO,  '+
    '   null as MOTIVO, '+
    '   null as NORMA, '+
    '   null as CATEGORIA_OBTENIDA, '+
    '   null as NRO_DISPO,  '+
    '   null as FECHA_DISPO, '+
    '   null as FECHA_RADICACION_DESDE, '+
    '   pre.vencimiento_precaria as FECHA_VENCIMIENTO, '+
    '   null as CONSULADO, '+
    '   null as NRO_ACTO_CONSULAR, '+
    '   null as ANIO_ACTO_CONSULAR, '+
    '   null as PERMANENCIA_AUTORIZADA_DNM, '+
    '   null as PERMANENCIA_AUTORIZADA_CONSUL, '+
    '   null as DIAS, '+
    '   null as DIAS_CONSULADO, '+
    '   null as ANIO_DISPOSICION, '+
    '   null as DIAS_CON_INGRESO, '+
    '   null as FECHA_ULTIMO_INGRESO, '+
    '   t.PAIS_DOCUMENTO as Cod_Pais_Emisor, '+
    '   t.NACIONALIDAD as Cod_Nacionalidad '+
    'FROM  '+
    '   sadex.persona p '+
    '   join sadex.tramite t on p.nro_cuim = t.nro_cuim '+
    '   join sadex.precarias pre on (t.nro_expediente = pre.nro_expediente and pre.anulado = ''f'' and t.anulado = ''f'') '+
    '   join catalogos.cat_delegaciones del on pre.delegacion = del.codigo '+
    '   join catalogos.cat_paises pais on p.pais_nacimiento = pais.codigo '+
    '   join catalogos.cat_tipo_documento td on t.tipo_documento = td.codigo '+
    '   left outer join catalogos.vw_nacionalidades nac on t.nacionalidad = nac.codigo_nacionalidad '+
    '   left outer join catalogos.cat_estado_civil ec on t.estado_civil = ec.codigo '+
    '   left outer join catalogos.cat_profesiones prof on t.profesion = prof.codigo '+
    '   left outer join catalogos.cat_localidades loc on t.localidad_real = loc.codigo '+
    'WHERE t.fecha_expediente IS NOT NULL AND  '+
    '   t.nro_expediente = :nro_expediente ' +
    'union all '+
    'SELECT /* CONSULTA PRORROGAS */ '+
    '   null as IDACTUACION,	 '+
    '   pro.apellido1_documento || '' '' || pro.apellido2_documento as APELLIDO,  '+
    '   pro.nombre1_documento || '' '' || pro.nombre2_documento as NOMBRE,  '+
    '   t.nro_cuim as NRO_CUIM, '+
    '   t.nro_presolicitud as NRO_PRESOL, '+
    '   td.descripcion as TIPO_DOC, '+
    '   pro.nro_documento as NUM_DOC, '+
    '   p.fecha_nacimiento as FECHA_NAC, '+
    '   p.sexo as SEXO, '+
    '   ec.descripcion as E_CIVIL, '+
    '   pais.descripcion as PAIS_NAC, '+
    '   nac.nacionalidad as NACIONALIDAD,  '+
    '   t.fecha_ultimo_ingreso as FECHA_INGRESO, '+
    '   pro.domicilio_real as DOMICILIO, '+
    '   loc.descripcion as LOCALIDAD, '+
    '   prof.descripcion as PROFESION, '+
    '   t.apellido_madre || '' '' || t.nombre_madre as DATO_MADRE,  '+
    '   t.apellido_padre || '' '' || t.nombre_padre as DATO_PADRE,  '+
    '   ''PRORROGA'' as TIPO_ACTUACION, '+
    '   t.nro_expediente as NRO_EXPEDIENTE, '+
    '   pro.fecha_prorroga as FECHA_INICIO,  '+
    '   del.descripcion as DELEGACION_INICIO,  '+
    '   mot.descripcion as MOTIVO, '+
    '   cri.descripcion as NORMA, '+
    '   cat.descripcion as CATEGORIA_OBTENIDA, '+
    '   null as NRO_DISPO,  '+
    '   null as FECHA_DISPO, '+
    '   null as FECHA_RADICACION_DESDE, '+
    '   pro.vencimiento_prorroga as FECHA_VENCIMIENTO, '+
    '   null as CONSULADO, '+
    '   null as NRO_ACTO_CONSULAR, '+
    '   null as ANIO_ACTO_CONSULAR, '+
    '   null as PERMANENCIA_AUTORIZADA_DNM, '+
    '   null as PERMANENCIA_AUTORIZADA_CONSUL, '+
    '   null as DIAS, '+
    '   null as DIAS_CONSULADO, '+
    '   null as ANIO_DISPOSICION, '+
    '   null as DIAS_CON_INGRESO, '+
    '   null as FECHA_ULTIMO_INGRESO, '+
    '   t.PAIS_DOCUMENTO as Cod_Pais_Emisor, '+
    '   t.NACIONALIDAD as Cod_Nacionalidad '+
    'FROM  '+
    '   sadex.persona p '+
    '   join sadex.tramite t on p.nro_cuim = t.nro_cuim '+
    '   join sadex.prorrogas pro on (t.nro_expediente = pro.nro_expediente and pro.anulado = ''f''and t.anulado = ''f'' and denegado = ''f'') '+
    '   join catalogos.cat_resoluciones r on pro.criterio = r.codigo '+
    '   join catalogos.cat_categorias cat on r.codigo_categoria = cat.codigo '+
    '   join catalogos.cat_criterios cri on r.codigo_criterio = cri.codigo '+
    '   join catalogos.cat_motivos mot on r.codigo_motivo = mot.codigo '+
    '   left outer join catalogos.cat_motivos submot on r.codigo_submotivo = submot.codigo '+
    '   left outer join catalogos.cat_motivos esp on r.codigo_especialidad = esp.codigo '+
    '   join catalogos.cat_delegaciones del on pro.delegacion = del.codigo '+
    '   join catalogos.cat_paises pais on p.pais_nacimiento = pais.codigo '+
    '   join catalogos.cat_tipo_documento td on pro.tipo_documento = td.codigo   '+
    '   left outer join catalogos.vw_nacionalidades nac on t.nacionalidad = nac.codigo_nacionalidad '+
    '   left outer join catalogos.cat_estado_civil ec on pro.estado_civil = ec.codigo '+
    '   left outer join catalogos.cat_profesiones prof on t.profesion = prof.codigo '+
    '   left outer join catalogos.cat_localidades loc on pro.localidad_real = loc.codigo '+
    'WHERE t.fecha_expediente IS NOT NULL AND  '+
    '   t.nro_expediente = :nro_expediente  '+
    'union all '+
    'SELECT /* CONSULTA VISAS, TRABAJADOR TRANSITORIO, PRORROGA TURISTA */ '+
    '   null as IDACTUACION, '+
    '   t.apellido1_documento || '' '' || t.apellido2_documento as APELLIDO,  '+
    '   t.nombre1_documento || '' '' || t.nombre2_documento as NOMBRE,  '+
    '   t.nro_cuim as NRO_CUIM, '+
    '   t.nro_presolicitud as NRO_PRESOL, '+
    '   td.descripcion as TIPO_DOC, '+
    '   t.nro_documento as NUM_DOC, '+
    '   p.fecha_nacimiento as FECHA_NAC, '+
    '   p.sexo as SEXO, '+
    '   ec.descripcion as E_CIVIL, '+
    '   pais.descripcion as PAIS_NAC, '+
    '   nac.nacionalidad as NACIONALIDAD,  '+
    '   t.fecha_ultimo_ingreso as FECHA_INGRESO, '+
    '   t.domicilio_real as DOMICILIO, '+
    '   loc.descripcion as LOCALIDAD, '+
    '   prof.descripcion as PROFESION, '+
    '   t.apellido_madre || '' '' || t.nombre_madre as DATO_MADRE,  '+
    '   t.apellido_padre || '' '' || t.nombre_padre as DATO_PADRE,  '+
    '   tt.descripcion as TIPO_ACTUACION, '+
    '   t.nro_expediente as NRO_EXPEDIENTE, '+
    '   t.fecha_expediente as FECHA_INICIO,  '+
    '   del.descripcion as DELEGACION_INICIO,  '+
    '   mot.descripcion as MOTIVO, '+
    '   cri.descripcion as NORMA, '+
    '   cat.descripcion as CATEGORIA_OBTENIDA, '+
    '   null as NRO_DISPO,  '+
    '   null as FECHA_DISPO, '+
    '   null as FECHA_RADICACION_DESDE, '+
    '   case t.tipo_tramite when 8 then vencimiento_prorroga  '+
    '                       when 103 then vencimiento_visa '+
    '                       when 992 then (fecha_expediente + 15) end as FECHA_VENCIMIENTO, '+
    '   con.descripcion as CONSULADO, '+
    '   null as NRO_ACTO_CONSULAR, '+
    '   null as ANIO_ACTO_CONSULAR, '+
    '   case when t.permanencia_dnm_dias is not null then to_char(t.permanencia_dnm_dias) || '' d�as'' '+
    '   when t.permanencia_dnm_meses is not null then to_char(t.permanencia_dnm_meses) || '' meses'' '+
    '   when t.permanencia_dnm_fecha is not null then ''hasta '' || to_char(t.permanencia_dnm_fecha,''dd-mm-yyyy'') end as PERMANENCIA_AUTORIZADA_DNM, '+
    '   case when t.permanencia_consul_dias is not null then to_char(t.permanencia_consul_dias) || '' d�as'' '+
    '   when t.permanencia_consul_meses is not null then to_char(t.permanencia_consul_meses) || '' meses'' '+
    '   when t.permanencia_consul_anios is not null then t.permanencia_consul_anios || '' a�os'' end as PERMANENCIA_AUTORIZADA_CONSUL, '+
    '   (case when t.permanencia_dnm_dias is not null then t.permanencia_dnm_dias '+
    '   when t.permanencia_dnm_meses is not null then t.permanencia_dnm_meses * 30 '+
    '   when t.permanencia_dnm_fecha is not null then cast(trunc(t.permanencia_dnm_fecha) - trunc(sysdate) as integer) else null end) as DIAS, '+
    '   (case when t.permanencia_consul_dias is not null then t.permanencia_consul_dias '+
    '   when t.permanencia_consul_meses is not null then t.permanencia_consul_meses * 30 '+
    '   when t.permanencia_consul_anios is not null then t.permanencia_consul_anios * 365 else null end) as DIAS_CONSULADO, '+
    '   null as ANIO_DISPOSICION, '+
    '   case when fecha_ultimo_ingreso is not null then cast (trunc(fecha_ultimo_ingreso + (case when t.permanencia_dnm_dias is not null then t.permanencia_dnm_dias '+
    '   when t.permanencia_dnm_meses is not null then t.permanencia_dnm_meses * 30 '+
    '   when t.permanencia_dnm_fecha is not null then cast(trunc(t.permanencia_dnm_fecha) - trunc(sysdate) as integer)end)) - trunc(sysdate) as integer)  else null end as DIAS_CON_INGRESO, '+
    '   FECHA_ULTIMO_INGRESO, '+
    '   t.PAIS_DOCUMENTO as Cod_Pais_Emisor, '+
    '   t.NACIONALIDAD as Cod_Nacionalidad '+
    'FROM  '+
    '   sadex.persona p '+
    '   join sadex.tramite t on (p.nro_cuim = t.nro_cuim and t.anulado = ''f'') '+
    '   join sadex.motivo_tramite mt on t.nro_presolicitud = mt.nro_presolicitud '+
    '   join catalogos.cat_delegaciones del on t.delegacion = del.codigo '+
    '   join catalogos.cat_resoluciones r on t.criterio_solicitado = r.codigo '+
    '   join catalogos.cat_categorias cat on r.codigo_categoria = cat.codigo '+
    '   join catalogos.cat_criterios cri on r.codigo_criterio = cri.codigo '+
    '   join catalogos.cat_motivos mot on r.codigo_motivo = mot.codigo '+
    '   left outer join catalogos.cat_motivos submot on r.codigo_submotivo = submot.codigo '+
    '   left outer join catalogos.cat_motivos esp on r.codigo_especialidad = esp.codigo '+
    '   join catalogos.cat_tipo_tramite tt on t.tipo_tramite = tt.codigo '+
    '   join catalogos.cat_paises pais on p.pais_nacimiento = pais.codigo '+
    '   join catalogos.cat_tipo_documento td on t.tipo_documento = td.codigo '+
    '   left outer join catalogos.vw_nacionalidades nac on t.nacionalidad = nac.codigo_nacionalidad '+
    '   left outer join catalogos.cat_estado_civil ec on t.estado_civil = ec.codigo '+
    '   left outer join catalogos.cat_profesiones prof on t.profesion = prof.codigo '+
    '   left outer join catalogos.cat_localidades loc on t.localidad_real = loc.codigo '+
    '   left outer join catalogos.cat_consulados con on t.consulado = con.codigo '+
    'WHERE t.fecha_expediente IS NOT NULL AND  '+
    '   t.nro_expediente = :nro_expediente and ' +
    '   t.tipo_tramite in (103,992,8,105) ';

    Result := sql;       }
end;

function TDMActuaciones.RestConsultaExpedientes(
  nro_Expediente: Int64): TResultado;
var
  oQ:TOraQuery;

begin
  //oQ := OpenSQL(ConsultaExpedientes,':nro_expediente',VarArrayOf([nro_Expediente]));

  try
  oQ:=TOraQuery.Create(nil);
  oQ.Close;
  oQ.SQL.Clear;
  oQ.SQL.LoadFromFile('.\expediente.sql');
  oQ.Session := OracleConexion;
  oQ.Params.ParamByName('nro_expediente').AsString:= IntToStr( nro_Expediente);
  //oQ.SQL.SaveToFile('sql.txt');

  oQ.Open;
  result:=DoResultadoExpedientes(oQ);
  finally
    FreeAndNil(oQ);
  end;
end;


function TDMActuaciones.ConsultaDisposicion:string;
var
  sql:String;
begin
  sql :=
    'SELECT /* CONSULTAR DISPOSICIONES */ '+
    '   null as IDACTUACION, '+
    '   t.apellido1_documento || '' '' || t.apellido2_documento as APELLIDO,  '+
    '   t.nombre1_documento || '' '' || t.nombre2_documento as NOMBRE,  '+
    '   t.nro_cuim as NRO_CUIM, '+
    '   t.nro_presolicitud as NRO_PRESOL, '+
    '   td.descripcion as TIPO_DOC, '+
    '   t.nro_documento as NUM_DOC, '+
    '   p.fecha_nacimiento as FECHA_NAC, '+
    '   p.sexo as SEXO, '+
    '   ec.descripcion as E_CIVIL, '+
    '   pais.descripcion as PAIS_NAC, '+
    '   nac.nacionalidad as NACIONALIDAD,  '+
    '   t.fecha_ultimo_ingreso as FECHA_INGRESO, '+
    '   t.domicilio_real as DOMICILIO, '+
    '   loc.descripcion as LOCALIDAD, '+
    '   prof.descripcion as PROFESION, '+
    '   t.apellido_madre || '' '' || t.nombre_madre as DATO_MADRE,  '+
    '   t.apellido_padre || '' '' || t.nombre_padre as DATO_PADRE,  '+
    '   tt.descripcion as TIPO_ACTUACION, '+
    '   t.nro_expediente as NRO_EXPEDIENTE, '+
    '   t.fecha_expediente as FECHA_INICIO,  '+
    '   del.descripcion as DELEGACION_INICIO,  '+
    '   mot.descripcion as MOTIVO, '+
    '   cri.descripcion as NORMA, '+
    '   cat.descripcion as CATEGORIA_OBTENIDA, '+
    '   d.nro_disposicion as NRO_DISPO,  '+
    '   d.fecha_disposicion as FECHA_DISPO, '+
    '   case t.tipo_tramite when 1 then d.fecha_desde '+
    '                       when 100 then d.fecha_desde '+
    '					   when 102 then d.fecha_desde  '+
    '        else null end as FECHA_RADICACION_DESDE, '+
    '   case t.tipo_tramite when 7 then t.vencimiento_dnm else '+
    '   d.fecha_vencimiento end as FECHA_VENCIMIENTO, '+
    '   con.descripcion as CONSULADO, '+
    '   t.nro_acto as NRO_ACTO_CONSULAR, '+
    '   t.anio_acto as ANIO_ACTO_CONSULAR, '+
    '   case when t.permanencia_dnm_dias is not null then to_char(t.permanencia_dnm_dias) || '' d�as'' '+
    '   when t.permanencia_dnm_meses is not null then to_char(t.permanencia_dnm_meses) || '' meses'' '+
    '   when t.permanencia_dnm_fecha is not null then ''hasta '' || to_char(t.permanencia_dnm_fecha,''dd-mm-yyyy'') end as PERMANENCIA_AUTORIZADA_DNM, '+
    '   case when t.permanencia_consul_dias is not null then to_char(t.permanencia_consul_dias) || '' d�as'' '+
    '   when t.permanencia_consul_meses is not null then to_char(t.permanencia_consul_meses) || '' meses'' '+
    '   when t.permanencia_consul_anios is not null then t.permanencia_consul_anios || '' a�os'' end as PERMANENCIA_AUTORIZADA_CONSUL, '+
    '   (case when t.permanencia_dnm_dias is not null then t.permanencia_dnm_dias '+
    '   when t.permanencia_dnm_meses is not null then t.permanencia_dnm_meses * 30 '+
    '   when t.permanencia_dnm_fecha is not null then cast(trunc(t.permanencia_dnm_fecha) - trunc(sysdate) as integer) else null end) as DIAS, '+
    '   (case when t.permanencia_consul_dias is not null then t.permanencia_consul_dias '+
    '   when t.permanencia_consul_meses is not null then t.permanencia_consul_meses * 30 '+
    '   when t.permanencia_consul_anios is not null then t.permanencia_consul_anios * 365 else null end) as DIAS_CONSULADO, '+
    '   d.ANIO_DISPOSICION, '+
    '   case when fecha_ultimo_ingreso is not null then cast (trunc(fecha_ultimo_ingreso + (case when t.permanencia_dnm_dias is not null then t.permanencia_dnm_dias '+
    '   when t.permanencia_dnm_meses is not null then t.permanencia_dnm_meses * 30 '+
    '   when t.permanencia_dnm_fecha is not null then cast(trunc(t.permanencia_dnm_fecha) - trunc(sysdate) as integer)end)) - trunc(sysdate) as integer)  else null end as DIAS_CON_INGRESO, '+
    '   FECHA_ULTIMO_INGRESO, '+
    '   t.PAIS_DOCUMENTO as Cod_Pais_Emisor, '+
    '   t.NACIONALIDAD as Cod_Nacionalidad '+
    'FROM  '+
    '   sadex.persona p '+
    '   join sadex.tramite t on (p.nro_cuim = t.nro_cuim and t.anulado = ''f'') '+
    '   join sadex.disposiciones d on t.nro_expediente = d.nro_expediente '+
    '   join catalogos.cat_resoluciones r on d.criterio = r.codigo '+
    '   join catalogos.cat_categorias cat on r.codigo_categoria = cat.codigo '+
    '   join catalogos.cat_criterios cri on r.codigo_criterio = cri.codigo '+
    '   join catalogos.cat_motivos mot on r.codigo_motivo = mot.codigo '+
    '   left outer join catalogos.cat_motivos submot on r.codigo_submotivo = submot.codigo '+
    '   left outer join catalogos.cat_motivos esp on r.codigo_especialidad = esp.codigo '+
    '   join catalogos.cat_delegaciones del on t.delegacion = del.codigo '+
    '   join catalogos.cat_tipo_tramite tt on t.tipo_tramite = tt.codigo '+
    '   join catalogos.cat_paises pais on p.pais_nacimiento = pais.codigo '+
    '   join catalogos.cat_tipo_documento td on t.tipo_documento = td.codigo '+
    '   left outer join catalogos.vw_nacionalidades nac on t.nacionalidad = nac.codigo_nacionalidad '+
    '   left outer join catalogos.cat_estado_civil ec on t.estado_civil = ec.codigo '+
    '   left outer join catalogos.cat_profesiones prof on t.profesion = prof.codigo '+
    '   left outer join catalogos.cat_localidades loc on t.localidad_real = loc.codigo '+
    '   left outer join catalogos.cat_consulados con on t.consulado = con.codigo    '+
    'WHERE  d.nro_disposicion = :nro_disposicion and d.ANIO_DISPOSICION = :ANIO_DISP';

  Result := sql;
end;



function TDMActuaciones.DoResultadoExpedientes(OraQuery: TOraQuery): TResultado;


  function nroExp(nro:String):Integer;
  begin
    Result := StrToInt(copy(nro,1,length(nro)-4));
  end;


var
  Resultado:TResultado;
  VectAct:TVectExpedientes;
  f:integer;
  ding:Integer;
begin
  Resultado:=TResultado.Create;
  Result := Resultado;

  Resultado.NroFilasExpedientes := OraQuery.RecordCount;
  for f:=0 to Resultado.NroFilasExpedientes-1 do
  begin
    SetLength(VectAct,f+1);
    VectAct[f]:=TExpedientes.Create;
    With VectAct[f] do
    begin
      IDACTUACION := OraQuery.fieldByName('IDACTUACION').AsString;
      APELLIDO := OraQuery.fieldByName('APELLIDO').AsString;
      NOMBRE := OraQuery.fieldByName('NOMBRE').AsString;
      NRO_CUIM := OraQuery.fieldByName('NRO_CUIM').AsString;
      TIPO_DOC := OraQuery.fieldByName('TIPO_DOC').AsString;
      NUM_DOC := OraQuery.fieldByName('NUM_DOC').AsString;
      FECHA_NAC := DTStr(OraQuery.fieldByName('FECHA_NAC').Value);
      SEXO := OraQuery.fieldByName('SEXO').AsString;
      E_CIVIL := OraQuery.fieldByName('E_CIVIL').AsString;
      PAIS_NAC := OraQuery.fieldByName('PAIS_NAC').AsString;
      NACIONALIDAD := OraQuery.fieldByName('NACIONALIDAD').AsString;
      FECHA_INGRESO := DTStr(OraQuery.fieldByName('FECHA_INGRESO').Value);
      DOMICILIO := OraQuery.fieldByName('DOMICILIO').AsString;
      LOCALIDAD := OraQuery.fieldByName('LOCALIDAD').AsString;
      PROFESION := OraQuery.fieldByName('PROFESION').AsString;
      DATO_MADRE := OraQuery.fieldByName('DATO_MADRE').AsString;
      DATO_PADRE := OraQuery.fieldByName('DATO_PADRE').AsString;
      TIPO_ACTUACION := OraQuery.fieldByName('TIPO_ACTUACION').AsString;
      NRO_EXPEDIENTE := OraQuery.fieldByName('NRO_EXPEDIENTE').AsString;
      FECHA_INICIO := DTStr(OraQuery.fieldByName('FECHA_INICIO').Value);
      DELEGACION_INICIO := OraQuery.fieldByName('DELEGACION_INICIO').AsString;
      MOTIVO := OraQuery.fieldByName('MOTIVO').AsString;
      NORMA := OraQuery.fieldByName('NORMA').AsString;
      CATEGORIA_OBTENIDA := OraQuery.fieldByName('CATEGORIA_OBTENIDA').AsString;
      NRO_DISPO := OraQuery.fieldByName('NRO_DISPO').AsString;
      FECHA_DISPO := DTStr(OraQuery.fieldByName('FECHA_DISPO').Value);
      FECHA_RADICACION_DESDE := DTStr(OraQuery.fieldByName('FECHA_RADICACION_DESDE').Value);
      FECHA_VENCIMIENTO := DTStr(OraQuery.fieldByName('FECHA_VENCIMIENTO').Value);
      CONSULADO := OraQuery.fieldByName('CONSULADO').AsString;
      NRO_ACTO_CONSULAR := OraQuery.fieldByName('NRO_ACTO_CONSULAR').AsString;
      ANIO_ACTO_CONSULAR := OraQuery.fieldByName('ANIO_ACTO_CONSULAR').AsString;
      PERMANENCIA_AUTORIZADA_DNM := OraQuery.fieldByName('PERMANENCIA_AUTORIZADA_DNM').AsString;
      PERMANENCIA_AUTORIZADA_CONSUL := OraQuery.fieldByName('PERMANENCIA_AUTORIZADA_CONSUL').AsString;
      NRO_PRESOLICITUD := OraQuery.fieldByName('NRO_PRESOL').AsString;
      ANIO_DISPOSICION := OraQuery.fieldByName('ANIO_DISPOSICION').AsString;
      DIAS := OraQuery.fieldByName('DIAS').AsString;
      DIAS_CONSULADO := OraQuery.fieldByName('DIAS_CONSULADO').AsString;
      DIAS_CON_INGRESO := OraQuery.fieldByName('DIAS_CON_INGRESO').AsString;
      FECHA_ULTIMO_INGRESO := OraQuery.fieldByName('FECHA_ULTIMO_INGRESO').AsString;
      COD_PAIS_EMISOR := OraQuery.fieldByName('COD_PAIS_EMISOR').AsString;
      COD_NACIONALIDAD := OraQuery.fieldByName('COD_NACIONALIDAD').AsString;

      ding := 0;
      TryStrToInt(DIAS_CON_INGRESO,ding);

      if ding<0 then
        DIAS_CON_INGRESO := '0';

      //Ver mantis  0000083
      if (trim(CATEGORIA_OBTENIDA)='')and(UpperCase(TIPO_ACTUACION)='PRECARIA')  then
      begin
        CATEGORIA_OBTENIDA := 'PRECARIA';
        MOTIVO := 'RESIDENCIA PRECARIA';
      end;


      {if ((2000000<=nroExp(NRO_EXPEDIENTE)) and (nroExp(NRO_EXPEDIENTE) <=3000000))
      and(UpperCase(TIPO_ACTUACION)='PRECARIA')
      then
        FECHA_VENCIMIENTO := DTStr(EncodeDate(2010,5,31));
       }
    end;
    OraQuery.Next;
  end;
  Resultado.FilasExpedientes := Copy(VectAct);
end;

function TDMActuaciones.OpenSQL(strSQL, params: String;
  values: Variant): TOraQuery;
var
  StrLs:TStringList;
  i:integer;
  ResStr:String;
  varData: Variant;
  OraQuery:TOraQuery;
begin
  //http://www.delphibasics.co.uk/RTL.asp?Name=Variant

  StrLs := TStringList.Create;
  try
    StrLs.Text := StringReplace(params,';',sLineBreak,[rfReplaceAll]);

    for i:=0 to StrLs.Count-1 do
    begin
      varData := values[i];

      case VarType(varData) and VarTypeMask of
        varString,varOleStr: ResStr := ''''+varData+'''';
      else
        ResStr:=varData;
      end;
      strSQL := StringReplace(strSQL,StrLs.Strings[i],ResStr,[rfReplaceAll]);
    end;
    OraQuery:=TOraQuery.Create(self);
    OraQuery.Session := OracleConexion;
    OraQuery.close;
    OraQuery.SQL.Text := strSQL;
    OraQuery.open;
    Result :=  OraQuery;
  finally
    StrLs.Free;
  end;
end;


function TDMActuaciones.RestConsultaDisposicion(nro_dispo:Int64;anio:Integer):TResultado;
var
  oQ:TOraQuery;
begin
  oQ := OpenSQL(ConsultaDisposicion,':nro_disposicion;:ANIO_DISP',VarArrayOf([nro_dispo,anio]));
  try
    result:=DoResultadoExpedientes(oQ);
  finally
    FreeAndNil(oQ);
  end;
end;

procedure TDMActuaciones.DataModuleCreate(Sender: TObject);

  function GetWSDir : String;
  const
    BUFFER_SIZE = 2048;
  var
    buffer : PAnsiChar;
    len : DWORD;
  begin
    Result := '';
    GetMem(buffer, BUFFER_SIZE);
    FillChar(buffer^, BUFFER_SIZE, 0);
    len := GetModuleFileName (0, pchar(buffer), BUFFER_SIZE);
    if len > 0 then
    begin
      SetLength(Result, len);
      Move(buffer^, Result[1], len);
    end;
    FreeMem(buffer);
  end;

var
  inifile:TIniFile;
  Server,Username,Password:String;

begin
  inifile := TIniFile.Create(Format('%sconfig.ini', [ExtractFilePath(GetWSDir)]));
//  inifile := TIniFile.Create('.\config.ini');
  try
    Server := inifile.ReadString('Database', 'server', '');
    Username := inifile.ReadString('Database', 'username', '');
    Password := inifile.ReadString('Database', 'password', '');


    NetRemoteName := inifile.ReadString('conexion', 'server', '');
    NetUserName := inifile.ReadString('conexion', 'username', '');
    NetPassword := inifile.ReadString('conexion', 'password', '');


    {
    NetConnection1 := TNetConnection.create(Nil);
    NetConnection1.RemoteName := inifile.ReadString('conexion', 'server', '');
    NetConnection1.UserName := inifile.ReadString('conexion', 'username', '');
    NetConnection1.Password := inifile.ReadString('conexion', 'password', '');
    NetConnection1.ResourceType:= rtDisk;
    NetConnection1.Connect;
                                   }
  finally
    inifile.Free;
  end;


  OracleConexion.Server := server;
  OracleConexion.Username := username;
  OracleConexion.Password := password;
  OracleConexion.Connect;


end;

function TDMActuaciones.RestFotoExpedientes(const nro_presol: Int64): String;
var
  oQ:TOraQuery;
begin
  oQ := OpenSQL(ConsultaFotoExpedientes,':NRO_PRESOLICITUD',VarArrayOf([nro_presol]));
  try
    result:=DoResultadoFoto(oQ);
  finally
    FreeAndNil(oQ);
  end;
end;

function Encode64(S: string): string;
var
  encoder: TIdEncoderMIME;
begin
  Result := '';
  encoder:= TIdEncoderMIME.Create(nil);
  Result:= encoder.Encode(S);
  encoder.Free;
end;





function TDMActuaciones.Loadimagen( Filename: String; var ImgEncode : string): boolean;

var
  fi: TFileStream;
  resultado : STRING;
  ts: TStrings;
begin
  try
    result:=false;
    if FileExists(Filename) then
    begin
      fi := TFileStream.Create(Filename, fmOpenRead);
      fi.Position := 0;
      SetLength(resultado, fi.Size);
      fi.Read(pointer(resultado)^, fi.Size);
      fi.Free;
      ImgEncode := encode64(resultado);
      result := true
    end
  except
    on e: exception do
      result:=false;
  end;

end;


function TDMActuaciones.DoResultadoFoto(OraQuery: TOraQuery): String;
var
  {blob : TStream;
  str:String;}
  path, deleg,fecha,nro,letra, strTem : string;
  NetConnection1: TNetConnection;
begin
  try
    Result := '';
    with OraQuery do
    begin
      if not IsEmpty then
      begin
        letra:=FieldByName('letra').asstring;
        fecha:=formatdatetime('yyyymmdd', FieldByName('fecha').asdatetime);

        case length(FieldByName('numero').asstring) of
          1 : nro:='000'+FieldByName('numero').asstring;
          2 : nro:='00'+FieldByName('numero').asstring;
          3 : nro:='0'+FieldByName('numero').asstring;
          4 : nro:=FieldByName('numero').asstring;
        end;

        case length(FieldByName('id_delegacion').asstring) of
          1 : deleg:='000'+FieldByName('id_delegacion').asstring;
          2 : deleg:='00'+FieldByName('id_delegacion').asstring;
          3 : deleg:='0'+FieldByName('id_delegacion').asstring;
          4 : deleg:=FieldByName('id_delegacion').asstring;
        end;

        NetConnection1 := TNetConnection.create(Nil);
        NetConnection1.RemoteName :=  NetRemoteName;
        NetConnection1.UserName :=   NetUserName;
        NetConnection1.Password := NetPassword;
        NetConnection1.ResourceType:= rtDisk;
        NetConnection1.Connect;

        path := NetConnection1.RemoteName+'\'+fecha+'\'+UpperCase(deleg)+UpperCase(letra)+UpperCase(nro)+'\'+'foto.jpg';
        //path := '';
        strTem := '';
        if Loadimagen(path, strTem) then
          Result:= strTem;
      end;
    end;
  except
    Result:= '';
  end;




  {blob := OraQuery.CreateBlobStream(OraQuery.FieldByName('FOTO'), bmRead);
  try
    blob.Seek(0, soFromBeginning);

    with TStringStream.Create(str) do
    try
      CopyFrom(blob, blob.Size);
      Result := Encode64(DataString);
    finally
      Free;
    end;
  finally
    blob.Free ;
  end;}


end;

function TDMActuaciones.ConsultaHabilitaciones: string;
var
  sql:String;
begin
  sql := 'select p.id_pers, p.ID_LOC, '+
      ' (p.apellido || '' '' || p.apellido2) as Apellidos,  '+
      '( p.nombre || '' '' ||p.nombre2) as Nombres,   '+
      'nac.nacionalidad as nacionalidad,  '+
      'p.fecha_nac, '+
      '(case p.sexo when ''F'' then ''FEMENINO'' '+
      '          when ''M'' then ''MASCULINO''  '+
      '		  else  ''NO INFORMO''  '+
      ' end) as Sexo, '+
      'p.fecha_registro as fecha_alta, '+
      'p.exped_dnm as Expediente, '+
      'tipo.descripcion as Tipo_documento, '+
      'd.num_doc as Numero_documento,  '+
      'pais.descripcion as Pais_documento, '+
      'hab.nro_solicitud ,  '+
      ' '''' as CONDICION_PAGO, fecha_pago, nro_ticket as bure, importe , tra.descripcion as tipo_tramite,  '+
      'juris.descripcion as Paso, '+
      ' Null as IDACTUACION, '+
      ' p.NACIONALIDAD as Cod_Pais_Emisor, '+
      ' d.PAIS_DOC as Cod_Nacionalidad '+
      'from  siger.personas p   '+
      'inner join siger.pers_doc d on (p.ID_LOC_C = d.ID_LOC  and p.ID_PERS = d.id_pers) '+
      'inner join siger.habilit_salida hab on ( p.ID_MOV_C = hab.id_mov and p.ID_LOC_C = hab.id_loc ) '+
      'inner join catalogos.vw_nacionalidades nac on (p.NACIONALIDAD = nac.CODIGO_NACIONALIDAD) '+
      'inner join catalogos.cat_tipo_documento tipo on ( d.TIPO_DOC = tipo.codigo ) '+
      'inner join catalogos.cat_paises pais on ( d.PAIS_DOC = pais.codigo ) '+
      'inner join catalogos.cat_tipo_tramite  tra on ( tra.codigo = hab.tipo_tasa ) '+
      'inner join catalogos.vw_cat_jurisdicciones juris on ( hab.paso = juris.codigo_recaudacion) '+
      'where p.clase_control = 30 and not paso =  889 AND HAB.FECHA_VTO >= TRUNC (SYSDATE) and hab.nro_solicitud = :nro_habilitacion '+
      'union '+
      'select p.id_pers, p.ID_LOC, '+
      '(p.apellido || '' '' || p.apellido2) as Apellidos, '+
      '( p.nombre || '' '' ||p.nombre2) as Nombres , '+
      'nac.nacionalidad as nacionalidad, '+
      'p.fecha_nac, '+
      '(case p.sexo when ''F'' then ''FEMENINO'' '+
      '          when ''M'' then ''MASCULINO''  '+
      '		  else  ''NO INFORMO''  '+
      '		  end) as Sexo, '+
      'p.fecha_registro as fecha_alta, '+
      'p.exped_dnm as Expediente, '+
      'tipo.descripcion as Tipo_documento, '+
      'd.num_doc as Numero_documento,  '+
      'pais.descripcion as Pais_documento, '+
      'hab.nro_solicitud ,  '+
      ' '''' as CONDICION_PAGO, fecha_pago, nro_ticket as bure, importe , tra.descripcion as tipo_tramite,  '+
      '''SEDE CENTRAL'' as Paso, '+
      ' Null as IDACTUACION, '+
      ' p.NACIONALIDAD as Cod_Pais_Emisor, '+
      ' d.PAIS_DOC as Cod_Nacionalidad '+
      'from  siger.personas p   '+
      'inner join siger.pers_doc d on (p.ID_LOC_C = d.ID_LOC  and p.ID_PERS = d.id_pers) '+
      'inner join siger.habilit_salida hab on ( p.ID_MOV_C = hab.id_mov and p.ID_LOC_C = hab.id_loc ) '+
      'inner join catalogos.vw_nacionalidades nac on (p.NACIONALIDAD = nac.CODIGO_NACIONALIDAD) '+
      'inner join catalogos.cat_tipo_documento tipo on ( d.TIPO_DOC = tipo.codigo ) '+
      'inner join catalogos.cat_paises pais on ( d.PAIS_DOC = pais.codigo ) '+
      'inner join catalogos.cat_tipo_tramite  tra on ( tra.codigo = hab.tipo_tasa ) '+
      'where p.clase_control = 30 and paso =  889 AND HAB.FECHA_VTO >= TRUNC (SYSDATE) and hab.nro_solicitud = :nro_habilitacion ';

  Result := sql;
end;

function TDMActuaciones.DoResultadoHabilitaciones(
  OraQuery: TOraQuery): TResultado;
var
  Resultado:TResultado;
  VectAct:TVectHabilitaciones;
  f:integer;
begin
  Resultado:=TResultado.Create;
  Result := Resultado;

  Resultado.NroFilasHabilitaciones := OraQuery.RecordCount;
  for f:=0 to Resultado.NroFilasHabilitaciones do
  begin
    SetLength(VectAct,f+1);
    VectAct[f]:=THabilitaciones.Create;
    With VectAct[f] do
    begin
      ID_PERS := OraQuery.fieldByName('ID_PERS').AsString;
      ID_LOC :=  OraQuery.fieldByName('ID_LOC').AsString;
      IDACTUACION := OraQuery.fieldByName('IDACTUACION').AsString;
      APELLIDOS := OraQuery.fieldByName('APELLIDOS').AsString;
      NOMBRES := OraQuery.fieldByName('NOMBRES').AsString;
      NACIONALIDAD := OraQuery.fieldByName('NACIONALIDAD').AsString;
      SEXO:= OraQuery.fieldByName('SEXO').AsString;;
      FECHA_ALTA:= OraQuery.fieldByName('FECHA_ALTA').AsString;;
      EXPEDIENTE:= OraQuery.fieldByName('EXPEDIENTE').AsString;;
      TIPO_DOCUMENTO:= OraQuery.fieldByName('TIPO_DOCUMENTO').AsString;;
      NUMERO_DOCUMENTO:= OraQuery.fieldByName('NUMERO_DOCUMENTO').AsString;;
      PAIS_DOCUMENTO:= OraQuery.fieldByName('PAIS_DOCUMENTO').AsString;;
      NRO_SOLICITUD:= OraQuery.fieldByName('NRO_SOLICITUD').AsString;;
      CONDICION_PAGO:= OraQuery.fieldByName('CONDICION_PAGO').AsString;;
      FECHA_PAGO:= OraQuery.fieldByName('FECHA_PAGO').AsString;;
      BURE:= OraQuery.fieldByName('BURE').AsString;;
      IMPORTE:= OraQuery.fieldByName('IMPORTE').AsString;;
      PASO:= OraQuery.fieldByName('PASO').AsString;;
      TIPO_TRAMITE:= OraQuery.fieldByName('TIPO_TRAMITE').AsString;
      IDACTUACION := OraQuery.fieldByName('IDACTUACION').AsString;
      COD_PAIS_EMISOR := OraQuery.fieldByName('COD_PAIS_EMISOR').AsString;
      COD_NACIONALIDAD := OraQuery.fieldByName('COD_NACIONALIDAD').AsString;
    end;
    OraQuery.Next;
  end;
  Resultado.FilasHabilitaciones := Copy(VectAct);
end;

function TDMActuaciones.RestConsultaHabilitaciones(nro_habilitacion: string): TResultado;
var
  oQ:TOraQuery;
begin
  oQ := OpenSQL(ConsultaHabilitaciones,':nro_habilitacion',VarArrayOf([nro_habilitacion]));
  try
    result:=DoResultadoHabilitaciones(oQ);
  finally
    FreeAndNil(oQ);
  end;
end;

function TDMActuaciones.ConsultaFotoHabilitaciones: String;
var
  sql:String;
begin
//juampi
  sql :=
      'select imagen_facial as FOTO '+
      'from siger.imagenes i, siger.personas p '+
      'where p.id_pers = i.id_pers and p.ID_LOC = i.id_loc and '+
      ' p.id_pers = :id_pers and p.ID_LOC = :id_loc ';


  Result := sql;
end;

function TDMActuaciones.RestFotoHabilitaciones(id_pers,ID_LOC:WideString): String;
var
  oQ:TOraQuery;
begin
  oQ := OpenSQL(ConsultaFotoHabilitaciones,':id_pers;:id_loc',VarArrayOf([id_pers,ID_LOC]));
  try
    result:= DoResultadoFoto(oQ);
  finally
    FreeAndNil(oQ);
  end;
end;

function TDMActuaciones.RestSituacionMigratoria(doc: widestring;
 var Fecha_vto : string): string;
const
  Consulta = 'SELECT SITUACION_MIGRATORIA SIT,' + #13 +
             'FECHA_VENCIMIENTO'                + #13 +
             'FROM SADEX.VW_MATRICULAS_SIT_MIG' + #13 +
             'WHERE NRO_DNI = :P_DOC';
var ora:TOraQuery;

begin
   ora := OpenSQL(Consulta,':P_DOC',VarArrayOf([doc]));
   if ora.IsEmpty then
   begin
     Fecha_vto := '';
     Result:= 'REVISION';
   end
   else
   begin
     Fecha_vto := formatdatetime('dd/mm/yyyy',
                  ora.fieldbyname('FECHA_VENCIMIENTO').AsDateTime);
     Result:= ora.fieldbyname('SIT').asstring;
   end;

end;

end.

