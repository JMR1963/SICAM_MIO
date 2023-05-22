// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.0.31/cgi-bin/wsautorizacionesdeviaje/wsautorizacionesdeviaje/wsdl/Iws_obtener_autorizacion
// Encoding : utf-8
// Version  : 1.0
// (28/12/2018 17:00:33 - 1.33.2.5)
// ************************************************************************ //

unit Iws_obtener_autorizacion1;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns,ufixWS;

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
  // Namespace : urn:ws_obtener_autorizacionIntf-Iws_obtener_autorizacion
  // soapAction: urn:ws_obtener_autorizacionIntf-Iws_obtener_autorizacion#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : Iws_obtener_autorizacionbinding
  // service   : Iws_obtener_autorizacionservice
  // port      : Iws_obtener_autorizacionPort
  // URL       : http://172.16.0.31/cgi-bin/wsautorizacionesdeviaje/wsautorizacionesdeviaje/soap/Iws_obtener_autorizacion
  // ************************************************************************ //
  Iws_obtener_autorizacion = interface(IInvokable)
  ['{3100E9AD-373F-F364-38A2-74518450591A}']
    function  obtener_autorizacion_escribanos(const datos_busqueda: Tdatos_busqueda): tautorizacion; stdcall;
    function  obtener_autorizacion_sacer(const datos_busqueda: Tdatos_busqueda): tautorizacion_sacer; stdcall;
    function  obtener_terceros(const tramite: WideString): tterceros; stdcall;
    function  obtener_autorizantes(const tramite: WideString): tterceros; stdcall;
  end;

function GetIws_obtener_autorizacion(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): Iws_obtener_autorizacion;


implementation

function GetIws_obtener_autorizacion(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): Iws_obtener_autorizacion;
const
 // defWSDL = 'http://172.16.0.31/cgi-bin/wsautorizacionesdeviaje/wsautorizacionesdeviaje/wsdl/Iws_obtener_autorizacion';
 // defURL  = 'http://172.16.0.31/cgi-bin/wsautorizacionesdeviaje/wsautorizacionesdeviaje/soap/Iws_obtener_autorizacion';
  defSvc  = 'Iws_obtener_autorizacionservice';
  defPrt  = 'Iws_obtener_autorizacionPort';
var
  RIO: THTTPRIO;
  defWSDL ,  defURL :string;
  d : twsdemora;  
begin
  //defWSDL ,  defURL :string;
  Result := nil;
  d := TWSDemora.Create; //jpb
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
    rio.HTTPWebNode.OnBeforePost :=   d.configureHttpRequest; //JPB
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

end. 