// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.192.152/cgi-bin/wsautorizacionesdeviaje/wsautorizacionesdeviaje/wsdl/Iws_obtener_autorizacion
// Encoding : utf-8
// Version  : 1.0
// (12/06/2022 21:40:57 - 1.33.2.5)
// ************************************************************************ //

unit Iws_obtener_autorizacion1;

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

  Tdatos_busqueda      = class;                 { "urn:ws_obtener_autorizacionIntf" }
  tautorizacion        = class;                 { "urn:ws_obtener_autorizacionIntf" }
  tautorizacion_sacer  = class;                 { "urn:ws_obtener_autorizacionIntf" }
  ttercero             = class;                 { "urn:ws_obtener_autorizacionIntf" }
  tautorizacion_full   = class;                 { "urn:ws_obtener_autorizacionIntf" }



  // ************************************************************************ //
  // Namespace : urn:ws_obtener_autorizacionIntf
  // ************************************************************************ //
  Tdatos_busqueda = class(TRemotable)
  private
    Ffecha_nacimiento: WideString;
    Fnumero_documento: WideString;
  published
    property fecha_nacimiento: WideString read Ffecha_nacimiento write Ffecha_nacimiento;
    property numero_documento: WideString read Fnumero_documento write Fnumero_documento;
  end;



  // ************************************************************************ //
  // Namespace : urn:ws_obtener_autorizacionIntf
  // ************************************************************************ //
  tautorizacion = class(TRemotable)
  private
    FNUMERO_DOCUMENTO: WideString;
    FFECHA_NACIMIENTO: WideString;
    FNRO_ACT_NOTARIAL_CERT_FIRMA: WideString;
    FSERIE_FOJA: WideString;
    FTIPO_FOJA: WideString;
    FMENOR: WideString;
    FAUTORIZANTE_1: WideString;
    FAUTORIZANTE_2: WideString;
    FACOMPANIANTE: WideString;
    FNOMBRES_ESCRIBANO: WideString;
    FAPELLIDOS_ESCRIBANO: WideString;
    FFECHA_DEL_INSTRUMENTO: WideString;
    FPAISES_TODOS: WideString;
    FAPELLIDO_MENOR: WideString;
    FSAPELLIDO_MENOR: WideString;
    FNOMBRE_MENOR: WideString;
    FSNOMBRE_MENOR: WideString;
    FNACIONALIDAD_MENOR: WideString;
    FTIPO_DOC_MENOR: WideString;
    FEMISOR_DOC_MENOR: WideString;
    FNUMERO_TRAMITE: WideString;
    FNOMBRE_AUTORIZANTE1: WideString;
    FOTROS_NOMBRES_AUTORIZANTE1: WideString;
    FAPELLIDO_AUTORIZANTE1: WideString;
    FS_APELLIDO_AUTORIZANTE1: WideString;
    FNOMBRE_AUTORIZANTE2: WideString;
    FOTROS_NOMBRES_AUTORIZANTE2: WideString;
    FAPELLIDO_AUTORIZANTE2: WideString;
    FS_APELLIDO_AUTORIZANTE2: WideString;
  published
    property NUMERO_DOCUMENTO: WideString read FNUMERO_DOCUMENTO write FNUMERO_DOCUMENTO;
    property FECHA_NACIMIENTO: WideString read FFECHA_NACIMIENTO write FFECHA_NACIMIENTO;
    property NRO_ACT_NOTARIAL_CERT_FIRMA: WideString read FNRO_ACT_NOTARIAL_CERT_FIRMA write FNRO_ACT_NOTARIAL_CERT_FIRMA;
    property SERIE_FOJA: WideString read FSERIE_FOJA write FSERIE_FOJA;
    property TIPO_FOJA: WideString read FTIPO_FOJA write FTIPO_FOJA;
    property MENOR: WideString read FMENOR write FMENOR;
    property AUTORIZANTE_1: WideString read FAUTORIZANTE_1 write FAUTORIZANTE_1;
    property AUTORIZANTE_2: WideString read FAUTORIZANTE_2 write FAUTORIZANTE_2;
    property ACOMPANIANTE: WideString read FACOMPANIANTE write FACOMPANIANTE;
    property NOMBRES_ESCRIBANO: WideString read FNOMBRES_ESCRIBANO write FNOMBRES_ESCRIBANO;
    property APELLIDOS_ESCRIBANO: WideString read FAPELLIDOS_ESCRIBANO write FAPELLIDOS_ESCRIBANO;
    property FECHA_DEL_INSTRUMENTO: WideString read FFECHA_DEL_INSTRUMENTO write FFECHA_DEL_INSTRUMENTO;
    property PAISES_TODOS: WideString read FPAISES_TODOS write FPAISES_TODOS;
    property APELLIDO_MENOR: WideString read FAPELLIDO_MENOR write FAPELLIDO_MENOR;
    property SAPELLIDO_MENOR: WideString read FSAPELLIDO_MENOR write FSAPELLIDO_MENOR;
    property NOMBRE_MENOR: WideString read FNOMBRE_MENOR write FNOMBRE_MENOR;
    property SNOMBRE_MENOR: WideString read FSNOMBRE_MENOR write FSNOMBRE_MENOR;
    property NACIONALIDAD_MENOR: WideString read FNACIONALIDAD_MENOR write FNACIONALIDAD_MENOR;
    property TIPO_DOC_MENOR: WideString read FTIPO_DOC_MENOR write FTIPO_DOC_MENOR;
    property EMISOR_DOC_MENOR: WideString read FEMISOR_DOC_MENOR write FEMISOR_DOC_MENOR;
    property NUMERO_TRAMITE: WideString read FNUMERO_TRAMITE write FNUMERO_TRAMITE;
    property NOMBRE_AUTORIZANTE1: WideString read FNOMBRE_AUTORIZANTE1 write FNOMBRE_AUTORIZANTE1;
    property OTROS_NOMBRES_AUTORIZANTE1: WideString read FOTROS_NOMBRES_AUTORIZANTE1 write FOTROS_NOMBRES_AUTORIZANTE1;
    property APELLIDO_AUTORIZANTE1: WideString read FAPELLIDO_AUTORIZANTE1 write FAPELLIDO_AUTORIZANTE1;
    property S_APELLIDO_AUTORIZANTE1: WideString read FS_APELLIDO_AUTORIZANTE1 write FS_APELLIDO_AUTORIZANTE1;
    property NOMBRE_AUTORIZANTE2: WideString read FNOMBRE_AUTORIZANTE2 write FNOMBRE_AUTORIZANTE2;
    property OTROS_NOMBRES_AUTORIZANTE2: WideString read FOTROS_NOMBRES_AUTORIZANTE2 write FOTROS_NOMBRES_AUTORIZANTE2;
    property APELLIDO_AUTORIZANTE2: WideString read FAPELLIDO_AUTORIZANTE2 write FAPELLIDO_AUTORIZANTE2;
    property S_APELLIDO_AUTORIZANTE2: WideString read FS_APELLIDO_AUTORIZANTE2 write FS_APELLIDO_AUTORIZANTE2;
  end;



  // ************************************************************************ //
  // Namespace : urn:ws_obtener_autorizacionIntf
  // ************************************************************************ //
  tautorizacion_sacer = class(TRemotable)
  private
    FNUMERO_DOC: WideString;
    FFECHA_NAC: WideString;
    FNRO_SOLICITUD: WideString;
    FFECHA_SOLICITUD: WideString;
    FAPELLIDO_MENOR: WideString;
    FNOMBRE_MENOR: WideString;
    FNACIONALIDAD: WideString;
    FPA_APELLIDO_1: WideString;
    FPA_APELLIDO_2: WideString;
    FPA_NOMBRE_1: WideString;
    FPA_NOMBRE_2: WideString;
    FPA_TIPO_DOCUMENTO: WideString;
    FPA_NRO_DOCUMENTO: WideString;
    FPA_NACIONALIDAD: WideString;
    FSA_APELLIDO_1: WideString;
    FSA_APELLIDO_2: WideString;
    FSA_NOMBRE_1: WideString;
    FSA_NOMBRE_2: WideString;
    FSA_TIPO_DOCUMENTO: WideString;
    FSA_NRO_DOCUMENTO: WideString;
    FSA_NACIONALIDAD: WideString;
    FACOMPANIANTE_DESCRIPCION: WideString;
  published
    property NUMERO_DOC: WideString read FNUMERO_DOC write FNUMERO_DOC;
    property FECHA_NAC: WideString read FFECHA_NAC write FFECHA_NAC;
    property NRO_SOLICITUD: WideString read FNRO_SOLICITUD write FNRO_SOLICITUD;
    property FECHA_SOLICITUD: WideString read FFECHA_SOLICITUD write FFECHA_SOLICITUD;
    property APELLIDO_MENOR: WideString read FAPELLIDO_MENOR write FAPELLIDO_MENOR;
    property NOMBRE_MENOR: WideString read FNOMBRE_MENOR write FNOMBRE_MENOR;
    property NACIONALIDAD: WideString read FNACIONALIDAD write FNACIONALIDAD;
    property PA_APELLIDO_1: WideString read FPA_APELLIDO_1 write FPA_APELLIDO_1;
    property PA_APELLIDO_2: WideString read FPA_APELLIDO_2 write FPA_APELLIDO_2;
    property PA_NOMBRE_1: WideString read FPA_NOMBRE_1 write FPA_NOMBRE_1;
    property PA_NOMBRE_2: WideString read FPA_NOMBRE_2 write FPA_NOMBRE_2;
    property PA_TIPO_DOCUMENTO: WideString read FPA_TIPO_DOCUMENTO write FPA_TIPO_DOCUMENTO;
    property PA_NRO_DOCUMENTO: WideString read FPA_NRO_DOCUMENTO write FPA_NRO_DOCUMENTO;
    property PA_NACIONALIDAD: WideString read FPA_NACIONALIDAD write FPA_NACIONALIDAD;
    property SA_APELLIDO_1: WideString read FSA_APELLIDO_1 write FSA_APELLIDO_1;
    property SA_APELLIDO_2: WideString read FSA_APELLIDO_2 write FSA_APELLIDO_2;
    property SA_NOMBRE_1: WideString read FSA_NOMBRE_1 write FSA_NOMBRE_1;
    property SA_NOMBRE_2: WideString read FSA_NOMBRE_2 write FSA_NOMBRE_2;
    property SA_TIPO_DOCUMENTO: WideString read FSA_TIPO_DOCUMENTO write FSA_TIPO_DOCUMENTO;
    property SA_NRO_DOCUMENTO: WideString read FSA_NRO_DOCUMENTO write FSA_NRO_DOCUMENTO;
    property SA_NACIONALIDAD: WideString read FSA_NACIONALIDAD write FSA_NACIONALIDAD;
    property ACOMPANIANTE_DESCRIPCION: WideString read FACOMPANIANTE_DESCRIPCION write FACOMPANIANTE_DESCRIPCION;
  end;



  // ************************************************************************ //
  // Namespace : urn:ws_obtener_autorizacionIntf
  // ************************************************************************ //
  ttercero = class(TRemotable)
  private
    Fnombre1: WideString;
    Fnombre2: WideString;
    Fapellido1: WideString;
    Fapellido2: WideString;
  published
    property nombre1: WideString read Fnombre1 write Fnombre1;
    property nombre2: WideString read Fnombre2 write Fnombre2;
    property apellido1: WideString read Fapellido1 write Fapellido1;
    property apellido2: WideString read Fapellido2 write Fapellido2;
  end;

  tterceros  = array of ttercero;               { "urn:ws_obtener_autorizacionIntf" }


  // ************************************************************************ //
  // Namespace : urn:ws_obtener_autorizacionIntf
  // ************************************************************************ //
  tautorizacion_full = class(TRemotable)
  private
    Fnumero_doc: WideString;
    Ffecha_nac: WideString;
    Ftipo: WideString;
    Fnro_solicitud: WideString;
    Ffecha_solicitud: WideString;
    Fserie_foja: WideString;
    Ftipo_foja: WideString;
    Fnombre_escribano: WideString;
    Fapellido_escribano: WideString;
    Fconsulado: WideString;
    Fjuzgado: WideString;
    Fapellido_menor: WideString;
    Fapellido2_menor: WideString;
    Fnombre_menor: WideString;
    Fnombre2_menor: WideString;
    Fnac_menor: WideString;
    Ftipo_doc_menor: WideString;
    Fpais_doc_menor: WideString;
    Fnro_doc_menor: WideString;
    Ffecha_nac_menor: WideString;
    Fpa_tipo_aut: WideString;
    Fpa_apellido_1: WideString;
    Fpa_apellido_2: WideString;
    Fpa_nombre_1: WideString;
    Fpa_nombre_2: WideString;
    Fpa_tipo_doc: WideString;
    Fpa_nro_doc: WideString;
    Fpa_nacionalidad: WideString;
    Fsa_tipo_aut: WideString;
    Fsa_apellido_1: WideString;
    Fsa_apellido_2: WideString;
    Fsa_nombre_1: WideString;
    Fsa_nombre_2: WideString;
    Fsa_tipo_doc: WideString;
    Fsa_nro_doc: WideString;
    Fsa_nacionalidad: WideString;
    Fta_tipo_aut: WideString;
    Fta_apellido_1: WideString;
    Fta_apellido_2: WideString;
    Fta_nombre_1: WideString;
    Fta_nombre_2: WideString;
    Fta_tipo_doc: WideString;
    Fta_nro_doc: WideString;
    Fta_nacionalidad: WideString;
    Ftipo_acompaniante: WideString;
    Fdatos_acompaniante: WideString;
    Ftipo_vigencia: WideString;
    Fvigencia_desde: WideString;
    Fvigencia_hasta: WideString;
    Fpais_viaje: WideString;
    Festado: WideString;
  published
    property numero_doc: WideString read Fnumero_doc write Fnumero_doc;
    property fecha_nac: WideString read Ffecha_nac write Ffecha_nac;
    property tipo: WideString read Ftipo write Ftipo;
    property nro_solicitud: WideString read Fnro_solicitud write Fnro_solicitud;
    property fecha_solicitud: WideString read Ffecha_solicitud write Ffecha_solicitud;
    property serie_foja: WideString read Fserie_foja write Fserie_foja;
    property tipo_foja: WideString read Ftipo_foja write Ftipo_foja;
    property nombre_escribano: WideString read Fnombre_escribano write Fnombre_escribano;
    property apellido_escribano: WideString read Fapellido_escribano write Fapellido_escribano;
    property consulado: WideString read Fconsulado write Fconsulado;
    property juzgado: WideString read Fjuzgado write Fjuzgado;
    property apellido_menor: WideString read Fapellido_menor write Fapellido_menor;
    property apellido2_menor: WideString read Fapellido2_menor write Fapellido2_menor;
    property nombre_menor: WideString read Fnombre_menor write Fnombre_menor;
    property nombre2_menor: WideString read Fnombre2_menor write Fnombre2_menor;
    property nac_menor: WideString read Fnac_menor write Fnac_menor;
    property tipo_doc_menor: WideString read Ftipo_doc_menor write Ftipo_doc_menor;
    property pais_doc_menor: WideString read Fpais_doc_menor write Fpais_doc_menor;
    property nro_doc_menor: WideString read Fnro_doc_menor write Fnro_doc_menor;
    property fecha_nac_menor: WideString read Ffecha_nac_menor write Ffecha_nac_menor;
    property pa_tipo_aut: WideString read Fpa_tipo_aut write Fpa_tipo_aut;
    property pa_apellido_1: WideString read Fpa_apellido_1 write Fpa_apellido_1;
    property pa_apellido_2: WideString read Fpa_apellido_2 write Fpa_apellido_2;
    property pa_nombre_1: WideString read Fpa_nombre_1 write Fpa_nombre_1;
    property pa_nombre_2: WideString read Fpa_nombre_2 write Fpa_nombre_2;
    property pa_tipo_doc: WideString read Fpa_tipo_doc write Fpa_tipo_doc;
    property pa_nro_doc: WideString read Fpa_nro_doc write Fpa_nro_doc;
    property pa_nacionalidad: WideString read Fpa_nacionalidad write Fpa_nacionalidad;
    property sa_tipo_aut: WideString read Fsa_tipo_aut write Fsa_tipo_aut;
    property sa_apellido_1: WideString read Fsa_apellido_1 write Fsa_apellido_1;
    property sa_apellido_2: WideString read Fsa_apellido_2 write Fsa_apellido_2;
    property sa_nombre_1: WideString read Fsa_nombre_1 write Fsa_nombre_1;
    property sa_nombre_2: WideString read Fsa_nombre_2 write Fsa_nombre_2;
    property sa_tipo_doc: WideString read Fsa_tipo_doc write Fsa_tipo_doc;
    property sa_nro_doc: WideString read Fsa_nro_doc write Fsa_nro_doc;
    property sa_nacionalidad: WideString read Fsa_nacionalidad write Fsa_nacionalidad;
    property ta_tipo_aut: WideString read Fta_tipo_aut write Fta_tipo_aut;
    property ta_apellido_1: WideString read Fta_apellido_1 write Fta_apellido_1;
    property ta_apellido_2: WideString read Fta_apellido_2 write Fta_apellido_2;
    property ta_nombre_1: WideString read Fta_nombre_1 write Fta_nombre_1;
    property ta_nombre_2: WideString read Fta_nombre_2 write Fta_nombre_2;
    property ta_tipo_doc: WideString read Fta_tipo_doc write Fta_tipo_doc;
    property ta_nro_doc: WideString read Fta_nro_doc write Fta_nro_doc;
    property ta_nacionalidad: WideString read Fta_nacionalidad write Fta_nacionalidad;
    property tipo_acompaniante: WideString read Ftipo_acompaniante write Ftipo_acompaniante;
    property datos_acompaniante: WideString read Fdatos_acompaniante write Fdatos_acompaniante;
    property tipo_vigencia: WideString read Ftipo_vigencia write Ftipo_vigencia;
    property vigencia_desde: WideString read Fvigencia_desde write Fvigencia_desde;
    property vigencia_hasta: WideString read Fvigencia_hasta write Fvigencia_hasta;
    property pais_viaje: WideString read Fpais_viaje write Fpais_viaje;
    property estado: WideString read Festado write Festado;
  end;


  // ************************************************************************ //
  // Namespace : urn:ws_obtener_autorizacionIntf-Iws_obtener_autorizacion
  // soapAction: urn:ws_obtener_autorizacionIntf-Iws_obtener_autorizacion#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : Iws_obtener_autorizacionbinding
  // service   : Iws_obtener_autorizacionservice
  // port      : Iws_obtener_autorizacionPort
  // URL       : http://172.16.192.152/cgi-bin/wsautorizacionesdeviaje/wsautorizacionesdeviaje/soap/Iws_obtener_autorizacion
  // ************************************************************************ //
  Iws_obtener_autorizacion = interface(IInvokable)
  ['{3100E9AD-373F-F364-38A2-74518450591A}']
    function  obtener_autorizacion_escribanos(const datos_busqueda: Tdatos_busqueda): tautorizacion; stdcall;
    function  obtener_autorizacion_sacer(const datos_busqueda: Tdatos_busqueda): tautorizacion_sacer; stdcall;
    function  obtener_terceros(const tramite: WideString): tterceros; stdcall;
    function  obtener_autorizantes(const tramite: WideString): tterceros; stdcall;
    function  autorizacion_menores(const datos_busqueda: Tdatos_busqueda): tautorizacion_full; stdcall;
  end;

function GetIws_obtener_autorizacion(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): Iws_obtener_autorizacion;


implementation

function GetIws_obtener_autorizacion(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): Iws_obtener_autorizacion;
const
  defWSDL = 'http://172.16.192.152/cgi-bin/wsautorizacionesdeviaje/wsautorizacionesdeviaje/wsdl/Iws_obtener_autorizacion';
  defURL  = 'http://172.16.192.152/cgi-bin/wsautorizacionesdeviaje/wsautorizacionesdeviaje/soap/Iws_obtener_autorizacion';
  defSvc  = 'Iws_obtener_autorizacionservice';
  defPrt  = 'Iws_obtener_autorizacionPort';
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
    Result := (RIO as Iws_obtener_autorizacion);
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


initialization
  InvRegistry.RegisterInterface(TypeInfo(Iws_obtener_autorizacion), 'urn:ws_obtener_autorizacionIntf-Iws_obtener_autorizacion', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(Iws_obtener_autorizacion), 'urn:ws_obtener_autorizacionIntf-Iws_obtener_autorizacion#%operationName%');
  RemClassRegistry.RegisterXSClass(Tdatos_busqueda, 'urn:ws_obtener_autorizacionIntf', 'Tdatos_busqueda');
  RemClassRegistry.RegisterXSClass(tautorizacion, 'urn:ws_obtener_autorizacionIntf', 'tautorizacion');
  RemClassRegistry.RegisterXSClass(tautorizacion_sacer, 'urn:ws_obtener_autorizacionIntf', 'tautorizacion_sacer');
  RemClassRegistry.RegisterXSClass(ttercero, 'urn:ws_obtener_autorizacionIntf', 'ttercero');
  RemClassRegistry.RegisterXSInfo(TypeInfo(tterceros), 'urn:ws_obtener_autorizacionIntf', 'tterceros');
  RemClassRegistry.RegisterXSClass(tautorizacion_full, 'urn:ws_obtener_autorizacionIntf', 'tautorizacion_full');

end. 