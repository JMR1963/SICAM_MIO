// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.192.152/cgi-bin/wsautorizacionviaje/wsautorizacionviaje/wsdl/Iws_autorizacion_viaje
// Encoding : utf-8
// Version  : 1.0
// (29/08/2022 14:50:15 - 1.33.2.5)
// ************************************************************************ //

unit Iws_autorizacion_viaje2;

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
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"
  // !:int             - "http://www.w3.org/2001/XMLSchema"

  rautorizante         = class;                 { "urn:ws_autorizacion_viajeIntf" }
  rmenor               = class;                 { "urn:ws_autorizacion_viajeIntf" }
  rpersonas            = class;                 { "urn:ws_autorizacion_viajeIntf" }
  racompanante         = class;                 { "urn:ws_autorizacion_viajeIntf" }
  rdatos_tramite       = class;                 { "urn:ws_autorizacion_viajeIntf" }
  Tpedido              = class;                 { "urn:ws_autorizacion_viajeIntf" }
  tresultado           = class;                 { "urn:ws_autorizacion_viajeIntf" }
  trevocar             = class;                 { "urn:ws_autorizacion_viajeIntf" }
  tautorizacion_numero = class;                 { "urn:ws_autorizacion_viajeIntf" }
  tsolicitud           = class;                 { "urn:ws_autorizacion_viajeIntf" }
  TNumeroSolicitud     = class;                 { "urn:ws_autorizacion_viajeIntf" }



  // ************************************************************************ //
  // Namespace : urn:ws_autorizacion_viajeIntf
  // ************************************************************************ //
  rautorizante = class(TRemotable)
  private
    Fapellido: WideString;
    Fsegundo_apellido: WideString;
    Fnombre: WideString;
    Fotros_nombres: WideString;
    Fnacionalidad: WideString;
    Ftipo_de_documento: WideString;
    Femisor_documento: WideString;
    Fnumero_de_documento: WideString;
    Ffecha_de_nacimiento: WideString;
    Fsexo: WideString;
    Fdomicilio: WideString;
    Fcaracter_primer_autorizante: WideString;
    Facredita_vinculo_con: WideString;
    Ftelefono: WideString;
    Frequiere_aut_adicional_de: WideString;
  published
    property apellido: WideString read Fapellido write Fapellido;
    property segundo_apellido: WideString read Fsegundo_apellido write Fsegundo_apellido;
    property nombre: WideString read Fnombre write Fnombre;
    property otros_nombres: WideString read Fotros_nombres write Fotros_nombres;
    property nacionalidad: WideString read Fnacionalidad write Fnacionalidad;
    property tipo_de_documento: WideString read Ftipo_de_documento write Ftipo_de_documento;
    property emisor_documento: WideString read Femisor_documento write Femisor_documento;
    property numero_de_documento: WideString read Fnumero_de_documento write Fnumero_de_documento;
    property fecha_de_nacimiento: WideString read Ffecha_de_nacimiento write Ffecha_de_nacimiento;
    property sexo: WideString read Fsexo write Fsexo;
    property domicilio: WideString read Fdomicilio write Fdomicilio;
    property caracter_primer_autorizante: WideString read Fcaracter_primer_autorizante write Fcaracter_primer_autorizante;
    property acredita_vinculo_con: WideString read Facredita_vinculo_con write Facredita_vinculo_con;
    property telefono: WideString read Ftelefono write Ftelefono;
    property requiere_aut_adicional_de: WideString read Frequiere_aut_adicional_de write Frequiere_aut_adicional_de;
  end;



  // ************************************************************************ //
  // Namespace : urn:ws_autorizacion_viajeIntf
  // ************************************************************************ //
  rmenor = class(TRemotable)
  private
    Fapellido: WideString;
    Fsegundo_apellido: WideString;
    Fnombre: WideString;
    Fotros_nombres: WideString;
    Fnacionalidad: WideString;
    Ftipo_de_documento: WideString;
    Femisor_documento: WideString;
    Fnumero_de_documento: WideString;
    Ffecha_de_nacimiento: WideString;
    FSexo: WideString;
    FDomicilio: WideString;
  published
    property apellido: WideString read Fapellido write Fapellido;
    property segundo_apellido: WideString read Fsegundo_apellido write Fsegundo_apellido;
    property nombre: WideString read Fnombre write Fnombre;
    property otros_nombres: WideString read Fotros_nombres write Fotros_nombres;
    property nacionalidad: WideString read Fnacionalidad write Fnacionalidad;
    property tipo_de_documento: WideString read Ftipo_de_documento write Ftipo_de_documento;
    property emisor_documento: WideString read Femisor_documento write Femisor_documento;
    property numero_de_documento: WideString read Fnumero_de_documento write Fnumero_de_documento;
    property fecha_de_nacimiento: WideString read Ffecha_de_nacimiento write Ffecha_de_nacimiento;
    property Sexo: WideString read FSexo write FSexo;
    property Domicilio: WideString read FDomicilio write FDomicilio;
  end;



  // ************************************************************************ //
  // Namespace : urn:ws_autorizacion_viajeIntf
  // ************************************************************************ //
  rpersonas = class(TRemotable)
  private
    Fapellido: WideString;
    Fsegundo_apellido: WideString;
    Fnombre: WideString;
    Fotros_nombres: WideString;
    Ftipo_de_documento: WideString;
    Fnumero_de_documento: WideString;
  published
    property apellido: WideString read Fapellido write Fapellido;
    property segundo_apellido: WideString read Fsegundo_apellido write Fsegundo_apellido;
    property nombre: WideString read Fnombre write Fnombre;
    property otros_nombres: WideString read Fotros_nombres write Fotros_nombres;
    property tipo_de_documento: WideString read Ftipo_de_documento write Ftipo_de_documento;
    property numero_de_documento: WideString read Fnumero_de_documento write Fnumero_de_documento;
  end;

  personas_varias = array of rpersonas;         { "urn:ws_autorizacion_viajeIntf" }


  // ************************************************************************ //
  // Namespace : urn:ws_autorizacion_viajeIntf
  // ************************************************************************ //
  racompanante = class(TRemotable)
  private
    Fotros_progenitores: personas_varias;
    Fterceros: personas_varias;
    Fviaja_solo: Boolean;
  public
    destructor Destroy; override;
  published
    property otros_progenitores: personas_varias read Fotros_progenitores write Fotros_progenitores;
    property terceros: personas_varias read Fterceros write Fterceros;
    property viaja_solo: Boolean read Fviaja_solo write Fviaja_solo;
  end;

  apaises    = array of WideString;             { "urn:ws_autorizacion_viajeIntf" }


  // ************************************************************************ //
  // Namespace : urn:ws_autorizacion_viajeIntf
  // ************************************************************************ //
  rdatos_tramite = class(TRemotable)
  private
    Fdistrito: WideString;
    Fmatricula: WideString;
    Fnombres_escribano: WideString;
    Fapellidos_escribano: WideString;
    Fnumero_actuacion_notarial_cert_firma: WideString;
    Ffecha_del_instrumento: WideString;
    Fcualquier_pais: Boolean;
    Fpaises: apaises;
    Fserie_foja: WideString;
    Ftipo_foja: WideString;
    Fvigencia_hasta_mayoria_edad: Boolean;
    Ffecha_vigencia_desde: WideString;
    Ffecha_vigencia_hasta: WideString;
    Finstrumento: WideString;
    Fnro_foja: WideString;
  published
    property distrito: WideString read Fdistrito write Fdistrito;
    property matricula: WideString read Fmatricula write Fmatricula;
    property nombres_escribano: WideString read Fnombres_escribano write Fnombres_escribano;
    property apellidos_escribano: WideString read Fapellidos_escribano write Fapellidos_escribano;
    property numero_actuacion_notarial_cert_firma: WideString read Fnumero_actuacion_notarial_cert_firma write Fnumero_actuacion_notarial_cert_firma;
    property fecha_del_instrumento: WideString read Ffecha_del_instrumento write Ffecha_del_instrumento;
    property cualquier_pais: Boolean read Fcualquier_pais write Fcualquier_pais;
    property paises: apaises read Fpaises write Fpaises;
    property serie_foja: WideString read Fserie_foja write Fserie_foja;
    property tipo_foja: WideString read Ftipo_foja write Ftipo_foja;
    property vigencia_hasta_mayoria_edad: Boolean read Fvigencia_hasta_mayoria_edad write Fvigencia_hasta_mayoria_edad;
    property fecha_vigencia_desde: WideString read Ffecha_vigencia_desde write Ffecha_vigencia_desde;
    property fecha_vigencia_hasta: WideString read Ffecha_vigencia_hasta write Ffecha_vigencia_hasta;
    property instrumento: WideString read Finstrumento write Finstrumento;
    property nro_foja: WideString read Fnro_foja write Fnro_foja;
  end;



  // ************************************************************************ //
  // Namespace : urn:ws_autorizacion_viajeIntf
  // ************************************************************************ //
  Tpedido = class(TRemotable)
  private
    Fmenor: rmenor;
    Fautorizante_1: rautorizante;
    Fautorizante_2: rautorizante;
    Facompanante: racompanante;
    Fdatos_tramite: rdatos_tramite;
  public
    destructor Destroy; override;
  published
    property menor: rmenor read Fmenor write Fmenor;
    property autorizante_1: rautorizante read Fautorizante_1 write Fautorizante_1;
    property autorizante_2: rautorizante read Fautorizante_2 write Fautorizante_2;
    property acompanante: racompanante read Facompanante write Facompanante;
    property datos_tramite: rdatos_tramite read Fdatos_tramite write Fdatos_tramite;
  end;



  // ************************************************************************ //
  // Namespace : urn:ws_autorizacion_viajeIntf
  // ************************************************************************ //
  tresultado = class(TRemotable)
  private
    Faceptado: Boolean;
    Ferror: WideString;
    Fnumero_autorizacion: Integer;
  published
    property aceptado: Boolean read Faceptado write Faceptado;
    property error: WideString read Ferror write Ferror;
    property numero_autorizacion: Integer read Fnumero_autorizacion write Fnumero_autorizacion;
  end;



  // ************************************************************************ //
  // Namespace : urn:ws_autorizacion_viajeIntf
  // ************************************************************************ //
  trevocar = class(TRemotable)
  private
    Fnumero_doc: WideString;
    Fnumero_matricula: WideString;
    Fnumero_act_notarial_cert_firma: WideString;
    Ffecha: WideString;
    Ftipo_documento: WideString;
    Fnacionalidad_documento: WideString;
    FEntidad_emisora: WideString;
    FNombre: WideString;
    FNombre2: WideString;
    FApellido: WideString;
    FApellido2: WideString;
    FNacionalidad: WideString;
    FFecha_de_nacimiento: WideString;
    FSexo: WideString;
    Fnombre_escribano: WideString;
  published
    property numero_doc: WideString read Fnumero_doc write Fnumero_doc;
    property numero_matricula: WideString read Fnumero_matricula write Fnumero_matricula;
    property numero_act_notarial_cert_firma: WideString read Fnumero_act_notarial_cert_firma write Fnumero_act_notarial_cert_firma;
    property fecha: WideString read Ffecha write Ffecha;
    property tipo_documento: WideString read Ftipo_documento write Ftipo_documento;
    property nacionalidad_documento: WideString read Fnacionalidad_documento write Fnacionalidad_documento;
    property Entidad_emisora: WideString read FEntidad_emisora write FEntidad_emisora;
    property Nombre: WideString read FNombre write FNombre;
    property Nombre2: WideString read FNombre2 write FNombre2;
    property Apellido: WideString read FApellido write FApellido;
    property Apellido2: WideString read FApellido2 write FApellido2;
    property Nacionalidad: WideString read FNacionalidad write FNacionalidad;
    property Fecha_de_nacimiento: WideString read FFecha_de_nacimiento write FFecha_de_nacimiento;
    property Sexo: WideString read FSexo write FSexo;
    property nombre_escribano: WideString read Fnombre_escribano write Fnombre_escribano;
  end;



  // ************************************************************************ //
  // Namespace : urn:ws_autorizacion_viajeIntf
  // ************************************************************************ //
  tautorizacion_numero = class(TRemotable)
  private
    Fnumero_autorizacion: WideString;
  published
    property numero_autorizacion: WideString read Fnumero_autorizacion write Fnumero_autorizacion;
  end;

  tresultado_revocar = array of tautorizacion_numero;   { "urn:ws_autorizacion_viajeIntf" }


  // ************************************************************************ //
  // Namespace : urn:ws_autorizacion_viajeIntf
  // ************************************************************************ //
  tsolicitud = class(TRemotable)
  private
    Fnumero_doc: WideString;
    Fnumero_matricula: WideString;
    Fnumero_act_notarial_cert_firma: WideString;
    Ffecha: WideString;
  published
    property numero_doc: WideString read Fnumero_doc write Fnumero_doc;
    property numero_matricula: WideString read Fnumero_matricula write Fnumero_matricula;
    property numero_act_notarial_cert_firma: WideString read Fnumero_act_notarial_cert_firma write Fnumero_act_notarial_cert_firma;
    property fecha: WideString read Ffecha write Ffecha;
  end;



  // ************************************************************************ //
  // Namespace : urn:ws_autorizacion_viajeIntf
  // ************************************************************************ //
  TNumeroSolicitud = class(TRemotable)
  private
    Fnumero_solicitud: Integer;
  published
    property numero_solicitud: Integer read Fnumero_solicitud write Fnumero_solicitud;
  end;


  // ************************************************************************ //
  // Namespace : urn:ws_autorizacion_viajeIntf-Iws_autorizacion_viaje
  // soapAction: urn:ws_autorizacion_viajeIntf-Iws_autorizacion_viaje#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : Iws_autorizacion_viajebinding
  // service   : Iws_autorizacion_viajeservice
  // port      : Iws_autorizacion_viajePort
  // URL       : http://172.16.192.152/cgi-bin/wsautorizacionviaje/wsautorizacionviaje/soap/Iws_autorizacion_viaje
  // ************************************************************************ //
  Iws_autorizacion_viaje = interface(IInvokable)
  ['{A78E9808-F999-DB2E-10E0-1080E349BEDD}']
    function  grabar(const pedido: Tpedido): tresultado; stdcall;
    function  revocar(const solicitud: trevocar): tresultado_revocar; stdcall;
    function  solicitudes_menor(const solicitud: tsolicitud): tresultado_revocar; stdcall;
    function  modificar(const pedido: Tpedido; const solicitud: TNumeroSolicitud): tresultado; stdcall;
  end;

function GetIws_autorizacion_viaje(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): Iws_autorizacion_viaje;


implementation

function GetIws_autorizacion_viaje(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): Iws_autorizacion_viaje;
const
  defWSDL = 'http://172.16.192.152/cgi-bin/wsautorizacionviaje/wsautorizacionviaje/wsdl/Iws_autorizacion_viaje';
  defURL  = 'http://172.16.192.152/cgi-bin/wsautorizacionviaje/wsautorizacionviaje/soap/Iws_autorizacion_viaje';
  defSvc  = 'Iws_autorizacion_viajeservice';
  defPrt  = 'Iws_autorizacion_viajePort';
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
    Result := (RIO as Iws_autorizacion_viaje);
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


destructor racompanante.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Fotros_progenitores)-1 do
    if Assigned(Fotros_progenitores[I]) then
      Fotros_progenitores[I].Free;
  SetLength(Fotros_progenitores, 0);
  for I := 0 to Length(Fterceros)-1 do
    if Assigned(Fterceros[I]) then
      Fterceros[I].Free;
  SetLength(Fterceros, 0);
  inherited Destroy;
end;

destructor Tpedido.Destroy;
begin
  if Assigned(Fmenor) then
    Fmenor.Free;
  if Assigned(Fautorizante_1) then
    Fautorizante_1.Free;
  if Assigned(Fautorizante_2) then
    Fautorizante_2.Free;
  if Assigned(Facompanante) then
    Facompanante.Free;
  if Assigned(Fdatos_tramite) then
    Fdatos_tramite.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(Iws_autorizacion_viaje), 'urn:ws_autorizacion_viajeIntf-Iws_autorizacion_viaje', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(Iws_autorizacion_viaje), 'urn:ws_autorizacion_viajeIntf-Iws_autorizacion_viaje#%operationName%');
  RemClassRegistry.RegisterXSClass(rautorizante, 'urn:ws_autorizacion_viajeIntf', 'rautorizante');
  RemClassRegistry.RegisterXSClass(rmenor, 'urn:ws_autorizacion_viajeIntf', 'rmenor');
  RemClassRegistry.RegisterXSClass(rpersonas, 'urn:ws_autorizacion_viajeIntf', 'rpersonas');
  RemClassRegistry.RegisterXSInfo(TypeInfo(personas_varias), 'urn:ws_autorizacion_viajeIntf', 'personas_varias');
  RemClassRegistry.RegisterXSClass(racompanante, 'urn:ws_autorizacion_viajeIntf', 'racompanante');
  RemClassRegistry.RegisterXSInfo(TypeInfo(apaises), 'urn:ws_autorizacion_viajeIntf', 'apaises');
  RemClassRegistry.RegisterXSClass(rdatos_tramite, 'urn:ws_autorizacion_viajeIntf', 'rdatos_tramite');
  RemClassRegistry.RegisterXSClass(Tpedido, 'urn:ws_autorizacion_viajeIntf', 'Tpedido');
  RemClassRegistry.RegisterXSClass(tresultado, 'urn:ws_autorizacion_viajeIntf', 'tresultado');
  RemClassRegistry.RegisterXSClass(trevocar, 'urn:ws_autorizacion_viajeIntf', 'trevocar');
  RemClassRegistry.RegisterXSClass(tautorizacion_numero, 'urn:ws_autorizacion_viajeIntf', 'tautorizacion_numero');
  RemClassRegistry.RegisterXSInfo(TypeInfo(tresultado_revocar), 'urn:ws_autorizacion_viajeIntf', 'tresultado_revocar');
  RemClassRegistry.RegisterXSClass(tsolicitud, 'urn:ws_autorizacion_viajeIntf', 'tsolicitud');
  RemClassRegistry.RegisterXSClass(TNumeroSolicitud, 'urn:ws_autorizacion_viajeIntf', 'TNumeroSolicitud');

end. 