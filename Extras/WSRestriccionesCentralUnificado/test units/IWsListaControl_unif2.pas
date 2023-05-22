// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.0.31/cgi-bin/wsRestriccionUnificado/prueba/WsListaControlUnificado/wsdl/IWsListaControl_unif
// Encoding : utf-8
// Version  : 1.0
// (21/06/2016 16:03:14 - 1.33.2.5)
// ************************************************************************ //

unit IWsListaControl_unif2;

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
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:int             - "http://www.w3.org/2001/XMLSchema"

  XML_CONSULTA_NEW     = class;                 { "urn:WsListaControlIntf" }
  TESTATSOURCE_NEW     = class;                 { "urn:WsListaControlIntf" }
  Restriccion          = class;                 { "urn:WsListaControlIntf" }
  TRESULTADO_NEW       = class;                 { "urn:WsListaControlIntf" }
  TRESPUESTA_ARG       = class;                 { "urn:WsListaControlIntf" }



  // ************************************************************************ //
  // Namespace : urn:WsListaControlIntf
  // ************************************************************************ //
  XML_CONSULTA_NEW = class(TRemotable)
  private
    FFUENTES: WideString;
    FUSUARIO: WideString;
    FCLAVE: WideString;
    FOPERADOR: WideString;
    FIP: WideString;
    FNOMBRE1: WideString;
    FNOMBRE2: WideString;
    FAPELLIDO1: WideString;
    FAPELLIDO2: WideString;
    FNUMDOC: WideString;
    FTIPODOC: WideString;
    FEMISORDOC: WideString;
    FFECHANAC: WideString;
    FGENERO: WideString;
    FNACIONALIDAD: WideString;
    FNUMEROIDENIFICACION: WideString;
    FPASO: WideString;
  published
    property FUENTES: WideString read FFUENTES write FFUENTES;
    property USUARIO: WideString read FUSUARIO write FUSUARIO;
    property CLAVE: WideString read FCLAVE write FCLAVE;
    property OPERADOR: WideString read FOPERADOR write FOPERADOR;
    property IP: WideString read FIP write FIP;
    property NOMBRE1: WideString read FNOMBRE1 write FNOMBRE1;
    property NOMBRE2: WideString read FNOMBRE2 write FNOMBRE2;
    property APELLIDO1: WideString read FAPELLIDO1 write FAPELLIDO1;
    property APELLIDO2: WideString read FAPELLIDO2 write FAPELLIDO2;
    property NUMDOC: WideString read FNUMDOC write FNUMDOC;
    property TIPODOC: WideString read FTIPODOC write FTIPODOC;
    property EMISORDOC: WideString read FEMISORDOC write FEMISORDOC;
    property FECHANAC: WideString read FFECHANAC write FFECHANAC;
    property GENERO: WideString read FGENERO write FGENERO;
    property NACIONALIDAD: WideString read FNACIONALIDAD write FNACIONALIDAD;
    property NUMEROIDENIFICACION: WideString read FNUMEROIDENIFICACION write FNUMEROIDENIFICACION;
    property PASO: WideString read FPASO write FPASO;
  end;



  // ************************************************************************ //
  // Namespace : urn:WsListaControlIntf
  // ************************************************************************ //
  TESTATSOURCE_NEW = class(TRemotable)
  private
    FFUENTES: WideString;
    FESTADO: WideString;
  published
    property FUENTES: WideString read FFUENTES write FFUENTES;
    property ESTADO: WideString read FESTADO write FESTADO;
  end;

  TESTATMANYSOURCES_NEW = array of TESTATSOURCE_NEW;   { "urn:WsListaControlIntf" }


  // ************************************************************************ //
  // Namespace : urn:WsListaControlIntf
  // ************************************************************************ //
  Restriccion = class(TRemotable)
  private
    FFUENTE: WideString;
    FID_PERS_PADRE: Integer;
    FID_PERS: Integer;
    FID_MOV_C: Integer;
    FDESC_TIPO_DOC: WideString;
    FDOCTIPO: WideString;
    FNUM_DOC: WideString;
    FPAIS_EMISOR_DOC: WideString;
    FAPELLIDO: WideString;
    FAPELLIDO2: WideString;
    FNOMBRE: WideString;
    FNOMBRE2: WideString;
    FNACIONALIDAD: WideString;
    FFECHA_NAC: WideString;
    FSEXO: WideString;
    FDESC_TIPO_RESTRICCION: WideString;
    FEXPED_DNM: WideString;
    FDESC_RESTRICCION: WideString;
    FDESC_CAUSA: WideString;
    FDESC_INSTRUCCION: WideString;
    FDESC_TIPO_JUSTICIA: WideString;
    FDESC_PROVINCIA: WideString;
    FDESC_JUZGADOS: WideString;
    FDESC_LOCALIDAD: WideString;
    FJUZGADO: WideString;
    FSECRETARIA: WideString;
    FSALA: WideString;
    FDESTINO: WideString;
    FFECHA_DESDE: WideString;
    FFECHA_HASTA: WideString;
    FFEC_RECEP_DNM: WideString;
    FDESC_ENTIDAD: WideString;
    FNRO_DISPO: WideString;
    FANIO_DISPO: WideString;
    FNRO_NOTA: WideString;
    FACTA: WideString;
    FDESC_DELEGACION: WideString;
    FFECHA_SALIDA: WideString;
    FFECHA_BAJA: WideString;
    FOBSERVACIONES: WideString;
    FFOTO: WideString;
    FEXTRA_INFO: WideString;
  published
    property FUENTE: WideString read FFUENTE write FFUENTE;
    property ID_PERS_PADRE: Integer read FID_PERS_PADRE write FID_PERS_PADRE;
    property ID_PERS: Integer read FID_PERS write FID_PERS;
    property ID_MOV_C: Integer read FID_MOV_C write FID_MOV_C;
    property DESC_TIPO_DOC: WideString read FDESC_TIPO_DOC write FDESC_TIPO_DOC;
    property DOCTIPO: WideString read FDOCTIPO write FDOCTIPO;
    property NUM_DOC: WideString read FNUM_DOC write FNUM_DOC;
    property PAIS_EMISOR_DOC: WideString read FPAIS_EMISOR_DOC write FPAIS_EMISOR_DOC;
    property APELLIDO: WideString read FAPELLIDO write FAPELLIDO;
    property APELLIDO2: WideString read FAPELLIDO2 write FAPELLIDO2;
    property NOMBRE: WideString read FNOMBRE write FNOMBRE;
    property NOMBRE2: WideString read FNOMBRE2 write FNOMBRE2;
    property NACIONALIDAD: WideString read FNACIONALIDAD write FNACIONALIDAD;
    property FECHA_NAC: WideString read FFECHA_NAC write FFECHA_NAC;
    property SEXO: WideString read FSEXO write FSEXO;
    property DESC_TIPO_RESTRICCION: WideString read FDESC_TIPO_RESTRICCION write FDESC_TIPO_RESTRICCION;
    property EXPED_DNM: WideString read FEXPED_DNM write FEXPED_DNM;
    property DESC_RESTRICCION: WideString read FDESC_RESTRICCION write FDESC_RESTRICCION;
    property DESC_CAUSA: WideString read FDESC_CAUSA write FDESC_CAUSA;
    property DESC_INSTRUCCION: WideString read FDESC_INSTRUCCION write FDESC_INSTRUCCION;
    property DESC_TIPO_JUSTICIA: WideString read FDESC_TIPO_JUSTICIA write FDESC_TIPO_JUSTICIA;
    property DESC_PROVINCIA: WideString read FDESC_PROVINCIA write FDESC_PROVINCIA;
    property DESC_JUZGADOS: WideString read FDESC_JUZGADOS write FDESC_JUZGADOS;
    property DESC_LOCALIDAD: WideString read FDESC_LOCALIDAD write FDESC_LOCALIDAD;
    property JUZGADO: WideString read FJUZGADO write FJUZGADO;
    property SECRETARIA: WideString read FSECRETARIA write FSECRETARIA;
    property SALA: WideString read FSALA write FSALA;
    property DESTINO: WideString read FDESTINO write FDESTINO;
    property FECHA_DESDE: WideString read FFECHA_DESDE write FFECHA_DESDE;
    property FECHA_HASTA: WideString read FFECHA_HASTA write FFECHA_HASTA;
    property FEC_RECEP_DNM: WideString read FFEC_RECEP_DNM write FFEC_RECEP_DNM;
    property DESC_ENTIDAD: WideString read FDESC_ENTIDAD write FDESC_ENTIDAD;
    property NRO_DISPO: WideString read FNRO_DISPO write FNRO_DISPO;
    property ANIO_DISPO: WideString read FANIO_DISPO write FANIO_DISPO;
    property NRO_NOTA: WideString read FNRO_NOTA write FNRO_NOTA;
    property ACTA: WideString read FACTA write FACTA;
    property DESC_DELEGACION: WideString read FDESC_DELEGACION write FDESC_DELEGACION;
    property FECHA_SALIDA: WideString read FFECHA_SALIDA write FFECHA_SALIDA;
    property FECHA_BAJA: WideString read FFECHA_BAJA write FFECHA_BAJA;
    property OBSERVACIONES: WideString read FOBSERVACIONES write FOBSERVACIONES;
    property FOTO: WideString read FFOTO write FFOTO;
    property EXTRA_INFO: WideString read FEXTRA_INFO write FEXTRA_INFO;
  end;

  XML_RESPUESTA_NEW = array of Restriccion;     { "urn:WsListaControlIntf" }


  // ************************************************************************ //
  // Namespace : urn:WsListaControlIntf
  // ************************************************************************ //
  TRESULTADO_NEW = class(TRemotable)
  private
    Frestricciones: XML_RESPUESTA_NEW;
    Ffuentes: TESTATMANYSOURCES_NEW;
  public
    destructor Destroy; override;
  published
    property restricciones: XML_RESPUESTA_NEW read Frestricciones write Frestricciones;
    property fuentes: TESTATMANYSOURCES_NEW read Ffuentes write Ffuentes;
  end;



  // ************************************************************************ //
  // Namespace : urn:WsListaControlIntf
  // ************************************************************************ //
  TRESPUESTA_ARG = class(TRemotable)
  private
    FCOD_RTA: WideString;
    FCOD_DETALLE_RTA: WideString;
  published
    property COD_RTA: WideString read FCOD_RTA write FCOD_RTA;
    property COD_DETALLE_RTA: WideString read FCOD_DETALLE_RTA write FCOD_DETALLE_RTA;
  end;


  // ************************************************************************ //
  // Namespace : urn:WsListaControlIntf-IWsListaControl_Unif
  // soapAction: urn:WsListaControlIntf-IWsListaControl_Unif#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IWsListaControl_Unifbinding
  // service   : IWsListaControl_Unifservice
  // port      : IWsListaControl_unifPort
  // URL       : http://172.16.0.31/cgi-bin/wsRestriccionUnificado/prueba/WsListaControlUnificado/soap/IWsListaControl_unif
  // ************************************************************************ //
  IWsListaControl_Unif = interface(IInvokable)
  ['{AF8A8886-7CB0-2D04-3D45-0A2666FE4DF1}']
    function  ConsultaRestriccion(const Consulta: XML_CONSULTA_NEW): TRESULTADO_NEW; stdcall;
    function  ConsultaRestriccionARG(const consulta: XML_CONSULTA_NEW): TRESPUESTA_ARG; stdcall;
    function  ConsultaRestriccionLocal(const Consulta: XML_CONSULTA_NEW): TRESULTADO_NEW; stdcall;
  end;

function GetIWsListaControl_Unif(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IWsListaControl_Unif;


implementation

function GetIWsListaControl_Unif(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IWsListaControl_Unif;
const
//

  defWSDL = 'http://172.16.0.31/cgi-bin/wsRestriccionUnificado/WsListaControlUnificado/wsdl/IWsListaControl_unif';
  defURL  = 'http://172.16.0.31/cgi-bin/wsRestriccionUnificado/WsListaControlUnificado/soap/IWsListaControl_unif';
//  defWSDL = 'http://172.16.0.60/cgi-bin/wsRestriccionUnificado/WsListaControlUnificado/wsdl/IWsListaControl_unif';
//  defURL  = 'http://172.16.0.60/cgi-bin/wsRestriccionUnificado/WsListaControlUnificado/soap/IWsListaControl_unif';
  defSvc  = 'IWsListaControl_Unifservice';
  defPrt  = 'IWsListaControl_unifPort';
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
    Result := (RIO as IWsListaControl_Unif);
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


destructor TRESULTADO_NEW.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Frestricciones)-1 do
    if Assigned(Frestricciones[I]) then
      Frestricciones[I].Free;
  SetLength(Frestricciones, 0);
  for I := 0 to Length(Ffuentes)-1 do
    if Assigned(Ffuentes[I]) then
      Ffuentes[I].Free;
  SetLength(Ffuentes, 0);
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(IWsListaControl_Unif), 'urn:WsListaControlIntf-IWsListaControl_Unif', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IWsListaControl_Unif), 'urn:WsListaControlIntf-IWsListaControl_Unif#%operationName%');
  RemClassRegistry.RegisterXSClass(XML_CONSULTA_NEW, 'urn:WsListaControlIntf', 'XML_CONSULTA_NEW');
  RemClassRegistry.RegisterXSClass(TESTATSOURCE_NEW, 'urn:WsListaControlIntf', 'TESTATSOURCE_NEW');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TESTATMANYSOURCES_NEW), 'urn:WsListaControlIntf', 'TESTATMANYSOURCES_NEW');
  RemClassRegistry.RegisterXSClass(Restriccion, 'urn:WsListaControlIntf', 'Restriccion');
  RemClassRegistry.RegisterXSInfo(TypeInfo(XML_RESPUESTA_NEW), 'urn:WsListaControlIntf', 'XML_RESPUESTA_NEW');
  RemClassRegistry.RegisterXSClass(TRESULTADO_NEW, 'urn:WsListaControlIntf', 'TRESULTADO_NEW');
  RemClassRegistry.RegisterXSClass(TRESPUESTA_ARG, 'urn:WsListaControlIntf', 'TRESPUESTA_ARG');

end. 