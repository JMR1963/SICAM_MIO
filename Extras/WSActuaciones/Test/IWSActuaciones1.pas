// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.192.111/cgi-bin/WSActuaciones/WSActuaciones/wsdl/IWSActuaciones
// Encoding : utf-8
// Version  : 1.0
// (02/09/2009 10:58:25 - 1.33.2.5)
// ************************************************************************ //

unit IWSActuaciones1;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:int             - "http://www.w3.org/2001/XMLSchema"
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:long            - "http://www.w3.org/2001/XMLSchema"

  THabilitaciones      = class;                 { "urn:WSActuacionesIntf" }
  TExpedientes         = class;                 { "urn:WSActuacionesIntf" }
  TResultado           = class;                 { "urn:WSActuacionesIntf" }



  // ************************************************************************ //
  // Namespace : urn:WSActuacionesIntf
  // ************************************************************************ //
  THabilitaciones = class(TRemotable)
  private
    FAPELLIDOS: WideString;
    FNOMBRES: WideString;
    FSEXO: WideString;
    FNACIONALIDAD: WideString;
    FFECHA_ALTA: WideString;
    FEXPEDIENTE: WideString;
    FTIPO_DOCUMENTO: WideString;
    FNUMERO_DOCUMENTO: WideString;
    FPAIS_DOCUMENTO: WideString;
    FNRO_SOLICITUD: WideString;
    FCONDICION_PAGO: WideString;
    FFECHA_PAGO: WideString;
    FBURE: WideString;
    FIMPORTE: WideString;
    FPASO: WideString;
    FTIPO_TRAMITE: WideString;
    FIDACTUACION: WideString;
    FID_PERS: WideString;
    FID_LOC: WideString;
  published
    property APELLIDOS: WideString read FAPELLIDOS write FAPELLIDOS;
    property NOMBRES: WideString read FNOMBRES write FNOMBRES;
    property SEXO: WideString read FSEXO write FSEXO;
    property NACIONALIDAD: WideString read FNACIONALIDAD write FNACIONALIDAD;
    property FECHA_ALTA: WideString read FFECHA_ALTA write FFECHA_ALTA;
    property EXPEDIENTE: WideString read FEXPEDIENTE write FEXPEDIENTE;
    property TIPO_DOCUMENTO: WideString read FTIPO_DOCUMENTO write FTIPO_DOCUMENTO;
    property NUMERO_DOCUMENTO: WideString read FNUMERO_DOCUMENTO write FNUMERO_DOCUMENTO;
    property PAIS_DOCUMENTO: WideString read FPAIS_DOCUMENTO write FPAIS_DOCUMENTO;
    property NRO_SOLICITUD: WideString read FNRO_SOLICITUD write FNRO_SOLICITUD;
    property CONDICION_PAGO: WideString read FCONDICION_PAGO write FCONDICION_PAGO;
    property FECHA_PAGO: WideString read FFECHA_PAGO write FFECHA_PAGO;
    property BURE: WideString read FBURE write FBURE;
    property IMPORTE: WideString read FIMPORTE write FIMPORTE;
    property PASO: WideString read FPASO write FPASO;
    property TIPO_TRAMITE: WideString read FTIPO_TRAMITE write FTIPO_TRAMITE;
    property IDACTUACION: WideString read FIDACTUACION write FIDACTUACION;
    property ID_PERS: WideString read FID_PERS write FID_PERS;
    property ID_LOC: WideString read FID_LOC write FID_LOC;
  end;

  TVectHabilitaciones = array of THabilitaciones;   { "urn:WSActuacionesIntf" }


  // ************************************************************************ //
  // Namespace : urn:WSActuacionesIntf
  // ************************************************************************ //
  TExpedientes = class(TRemotable)
  private
    FAPELLIDO: WideString;
    FNOMBRE: WideString;
    FNRO_CUIM: WideString;
    FTIPO_DOC: WideString;
    FNUM_DOC: WideString;
    FFECHA_NAC: WideString;
    FSEXO: WideString;
    FE_CIVIL: WideString;
    FPAIS_NAC: WideString;
    FNACIONALIDAD: WideString;
    FFECHA_INGRESO: WideString;
    FDOMICILIO: WideString;
    FLOCALIDAD: WideString;
    FPROFESION: WideString;
    FDATO_MADRE: WideString;
    FDATO_PADRE: WideString;
    FTIPO_ACTUACION: WideString;
    FNRO_EXPEDIENTE: WideString;
    FFECHA_INICIO: WideString;
    FDELEGACION_INICIO: WideString;
    FMOTIVO: WideString;
    FNORMA: WideString;
    FCATEGORIA_OBTENIDA: WideString;
    FNRO_DISPO: WideString;
    FFECHA_DISPO: WideString;
    FFECHA_RADICACION_DESDE: WideString;
    FFECHA_VENCIMIENTO: WideString;
    FCONSULADO: WideString;
    FNRO_ACTO_CONSULAR: WideString;
    FANIO_ACTO_CONSULAR: WideString;
    FPERMANENCIA_AUTORIZADA_DNM: WideString;
    FPERMANENCIA_AUTORIZADA_CONSUL: WideString;
    FNRO_PRESOLICITUD: WideString;
    FIDACTUACION: WideString;
    FANIO_DISPOSICION: WideString;
    FDIAS: WideString;
    FDIAS_CONSULADO: WideString;
    FDIAS_CON_INGRESO: WideString;
    FFECHA_ULTIMO_INGRESO: WideString;
  published
    property APELLIDO: WideString read FAPELLIDO write FAPELLIDO;
    property NOMBRE: WideString read FNOMBRE write FNOMBRE;
    property NRO_CUIM: WideString read FNRO_CUIM write FNRO_CUIM;
    property TIPO_DOC: WideString read FTIPO_DOC write FTIPO_DOC;
    property NUM_DOC: WideString read FNUM_DOC write FNUM_DOC;
    property FECHA_NAC: WideString read FFECHA_NAC write FFECHA_NAC;
    property SEXO: WideString read FSEXO write FSEXO;
    property E_CIVIL: WideString read FE_CIVIL write FE_CIVIL;
    property PAIS_NAC: WideString read FPAIS_NAC write FPAIS_NAC;
    property NACIONALIDAD: WideString read FNACIONALIDAD write FNACIONALIDAD;
    property FECHA_INGRESO: WideString read FFECHA_INGRESO write FFECHA_INGRESO;
    property DOMICILIO: WideString read FDOMICILIO write FDOMICILIO;
    property LOCALIDAD: WideString read FLOCALIDAD write FLOCALIDAD;
    property PROFESION: WideString read FPROFESION write FPROFESION;
    property DATO_MADRE: WideString read FDATO_MADRE write FDATO_MADRE;
    property DATO_PADRE: WideString read FDATO_PADRE write FDATO_PADRE;
    property TIPO_ACTUACION: WideString read FTIPO_ACTUACION write FTIPO_ACTUACION;
    property NRO_EXPEDIENTE: WideString read FNRO_EXPEDIENTE write FNRO_EXPEDIENTE;
    property FECHA_INICIO: WideString read FFECHA_INICIO write FFECHA_INICIO;
    property DELEGACION_INICIO: WideString read FDELEGACION_INICIO write FDELEGACION_INICIO;
    property MOTIVO: WideString read FMOTIVO write FMOTIVO;
    property NORMA: WideString read FNORMA write FNORMA;
    property CATEGORIA_OBTENIDA: WideString read FCATEGORIA_OBTENIDA write FCATEGORIA_OBTENIDA;
    property NRO_DISPO: WideString read FNRO_DISPO write FNRO_DISPO;
    property FECHA_DISPO: WideString read FFECHA_DISPO write FFECHA_DISPO;
    property FECHA_RADICACION_DESDE: WideString read FFECHA_RADICACION_DESDE write FFECHA_RADICACION_DESDE;
    property FECHA_VENCIMIENTO: WideString read FFECHA_VENCIMIENTO write FFECHA_VENCIMIENTO;
    property CONSULADO: WideString read FCONSULADO write FCONSULADO;
    property NRO_ACTO_CONSULAR: WideString read FNRO_ACTO_CONSULAR write FNRO_ACTO_CONSULAR;
    property ANIO_ACTO_CONSULAR: WideString read FANIO_ACTO_CONSULAR write FANIO_ACTO_CONSULAR;
    property PERMANENCIA_AUTORIZADA_DNM: WideString read FPERMANENCIA_AUTORIZADA_DNM write FPERMANENCIA_AUTORIZADA_DNM;
    property PERMANENCIA_AUTORIZADA_CONSUL: WideString read FPERMANENCIA_AUTORIZADA_CONSUL write FPERMANENCIA_AUTORIZADA_CONSUL;
    property NRO_PRESOLICITUD: WideString read FNRO_PRESOLICITUD write FNRO_PRESOLICITUD;
    property IDACTUACION: WideString read FIDACTUACION write FIDACTUACION;
    property ANIO_DISPOSICION: WideString read FANIO_DISPOSICION write FANIO_DISPOSICION;
    property DIAS: WideString read FDIAS write FDIAS;
    property DIAS_CONSULADO: WideString read FDIAS_CONSULADO write FDIAS_CONSULADO;
    property DIAS_CON_INGRESO: WideString read FDIAS_CON_INGRESO write FDIAS_CON_INGRESO;
    property FECHA_ULTIMO_INGRESO: WideString read FFECHA_ULTIMO_INGRESO write FFECHA_ULTIMO_INGRESO;
  end;

  TVectExpedientes = array of TExpedientes;     { "urn:WSActuacionesIntf" }


  // ************************************************************************ //
  // Namespace : urn:WSActuacionesIntf
  // ************************************************************************ //
  TResultado = class(TRemotable)
  private
    FFilasExpedientes: TVectExpedientes;
    FNroFilasExpedientes: Integer;
    FFilasHabilitaciones: TVectHabilitaciones;
    FNroFilasHabilitaciones: Integer;
  public
    destructor Destroy; override;
  published
    property FilasExpedientes: TVectExpedientes read FFilasExpedientes write FFilasExpedientes;
    property NroFilasExpedientes: Integer read FNroFilasExpedientes write FNroFilasExpedientes;
    property FilasHabilitaciones: TVectHabilitaciones read FFilasHabilitaciones write FFilasHabilitaciones;
    property NroFilasHabilitaciones: Integer read FNroFilasHabilitaciones write FNroFilasHabilitaciones;
  end;


  // ************************************************************************ //
  // Namespace : urn:WSActuacionesIntf-IWSActuaciones
  // soapAction: urn:WSActuacionesIntf-IWSActuaciones#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IWSActuacionesbinding
  // service   : IWSActuacionesservice
  // port      : IWSActuacionesPort
  // URL       : http://172.16.192.111/cgi-bin/WSActuaciones/WSActuaciones/soap/IWSActuaciones
  // ************************************************************************ //
  IWSActuaciones = interface(IInvokable)
  ['{56566CD8-49D4-DFBD-B69E-641145BCF4F4}']
    function  GetDisposiciones(const nro_dispo: Int64; const anio: Integer): TResultado; stdcall;
    function  GetExpedientes(const nro_exp: Int64): TResultado; stdcall;
    function  GetFotoExpedientes(const nro_presol: Int64): WideString; stdcall;
    function  GetHabilitaciones(const nro_habilitacion: WideString): TResultado; stdcall;
    function  GetFotoHabilitaciones(const id_pers: WideString; const ID_LOC: WideString): WideString; stdcall;
  end;

function GetIWSActuaciones(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IWSActuaciones;


implementation

function GetIWSActuaciones(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IWSActuaciones;
const
  defWSDL = 'http://172.16.192.111/cgi-bin/WSActuaciones/WSActuaciones/wsdl/IWSActuaciones';
  defURL  = 'http://172.16.192.111/cgi-bin/WSActuaciones/WSActuaciones/soap/IWSActuaciones';
  defSvc  = 'IWSActuacionesservice';
  defPrt  = 'IWSActuacionesPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as IWSActuaciones);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


destructor TResultado.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FFilasExpedientes)-1 do
    if Assigned(FFilasExpedientes[I]) then
      FFilasExpedientes[I].Free;
  SetLength(FFilasExpedientes, 0);
  for I := 0 to Length(FFilasHabilitaciones)-1 do
    if Assigned(FFilasHabilitaciones[I]) then
      FFilasHabilitaciones[I].Free;
  SetLength(FFilasHabilitaciones, 0);
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(IWSActuaciones), 'urn:WSActuacionesIntf-IWSActuaciones', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IWSActuaciones), 'urn:WSActuacionesIntf-IWSActuaciones#%operationName%');
  RemClassRegistry.RegisterXSClass(THabilitaciones, 'urn:WSActuacionesIntf', 'THabilitaciones');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TVectHabilitaciones), 'urn:WSActuacionesIntf', 'TVectHabilitaciones');
  RemClassRegistry.RegisterXSClass(TExpedientes, 'urn:WSActuacionesIntf', 'TExpedientes');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TVectExpedientes), 'urn:WSActuacionesIntf', 'TVectExpedientes');
  RemClassRegistry.RegisterXSClass(TResultado, 'urn:WSActuacionesIntf', 'TResultado');

end. 