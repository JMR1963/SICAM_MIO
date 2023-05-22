// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.192.111/cgi-bin/wsimpedimentosargentina/wsimpedimentosargentina/wsdl/IwsRestriccion
// Encoding : utf-8
// Version  : 1.0
// (09/11/2016 11:13:56 a.m. - 1.33.2.5)
// ************************************************************************ //

unit IwsRestriccion1;

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

  TRespuesta           = class;                 { "urn:wsRestriccionIntf" }
  DatosEntrada         = class;                 { "urn:wsRestriccionIntf" }
  DatosSalida          = class;                 { "urn:wsRestriccionIntf" }



  // ************************************************************************ //
  // Namespace : urn:wsRestriccionIntf
  // ************************************************************************ //
  TRespuesta = class(TRemotable)
  private
    FRestriccion: WideString;
    FTransporte: WideString;
  published
    property Restriccion: WideString read FRestriccion write FRestriccion;
    property Transporte: WideString read FTransporte write FTransporte;
  end;



  // ************************************************************************ //
  // Namespace : urn:wsRestriccionIntf
  // ************************************************************************ //
  DatosEntrada = class(TRemotable)
  private
    FUSUARIO: WideString;
    FCLAVE: WideString;
    FOPERADOR: WideString;
    FCODPAIS: WideString;
    FNOMBRE1: WideString;
    FNOMBRE2: WideString;
    FAPELLIDO1: WideString;
    FAPELLIDO2: WideString;
    FNUMDOC: WideString;
    FPUESTOCONTROL: WideString;
    FTIPODOC: WideString;
    FEMISORDOC: WideString;
    FFECHANAC: WideString;
    FGENERO: WideString;
    FNACIONALIDAD: WideString;
    FNUMEROIDENIFICACION: WideString;
    FPASO: WideString;
  published
    property USUARIO: WideString read FUSUARIO write FUSUARIO;
    property CLAVE: WideString read FCLAVE write FCLAVE;
    property OPERADOR: WideString read FOPERADOR write FOPERADOR;
    property CODPAIS: WideString read FCODPAIS write FCODPAIS;
    property NOMBRE1: WideString read FNOMBRE1 write FNOMBRE1;
    property NOMBRE2: WideString read FNOMBRE2 write FNOMBRE2;
    property APELLIDO1: WideString read FAPELLIDO1 write FAPELLIDO1;
    property APELLIDO2: WideString read FAPELLIDO2 write FAPELLIDO2;
    property NUMDOC: WideString read FNUMDOC write FNUMDOC;
    property PUESTOCONTROL: WideString read FPUESTOCONTROL write FPUESTOCONTROL;
    property TIPODOC: WideString read FTIPODOC write FTIPODOC;
    property EMISORDOC: WideString read FEMISORDOC write FEMISORDOC;
    property FECHANAC: WideString read FFECHANAC write FFECHANAC;
    property GENERO: WideString read FGENERO write FGENERO;
    property NACIONALIDAD: WideString read FNACIONALIDAD write FNACIONALIDAD;
    property NUMEROIDENIFICACION: WideString read FNUMEROIDENIFICACION write FNUMEROIDENIFICACION;
    property PASO: WideString read FPASO write FPASO;
  end;



  // ************************************************************************ //
  // Namespace : urn:wsRestriccionIntf
  // ************************************************************************ //
  DatosSalida = class(TRemotable)
  private
    FCOD_RTA: WideString;
    FCOD_DETALLE_RTA: WideString;
    FOBSERVACIONES: WideString;
  published
    property COD_RTA: WideString read FCOD_RTA write FCOD_RTA;
    property COD_DETALLE_RTA: WideString read FCOD_DETALLE_RTA write FCOD_DETALLE_RTA;
    property OBSERVACIONES: WideString read FOBSERVACIONES write FOBSERVACIONES;
  end;


  // ************************************************************************ //
  // Namespace : urn:wsRestriccionIntf-IwsRestriccion
  // soapAction: urn:wsRestriccionIntf-IwsRestriccion#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IwsRestriccionbinding
  // service   : IwsRestriccionservice
  // port      : IwsRestriccionPort
  // URL       : http://172.16.192.111/cgi-bin/wsimpedimentosargentina/wsimpedimentosargentina/soap/IwsRestriccion
  // ************************************************************************ //
  IwsRestriccion = interface(IInvokable)
  ['{EB219DA4-239F-B09C-A8D6-DD790734174F}']
    function  buscarRestricciones(const Apellidos: WideString; const Nombres: WideString; const fechaNac: WideString; const nroDoc: WideString; const nrolibreta: WideString): TRespuesta; stdcall;
    function  ConsultaImpedimentosArgentina(const consulta: DatosEntrada): DatosSalida; stdcall;
  end;

function GetIwsRestriccion(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IwsRestriccion;


implementation

uses uDMEntradaCHLSalidaARG;

function GetIwsRestriccion(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IwsRestriccion;
const
 // defWSDL ='';// 'http://10.170.109.194:82/cgi-bin/wsimpedimentosargentina/wsimpedimentosargentina/wsdl/IwsRestriccion';
 // defURL  ='';// 'http://10.170.109.194:82/cgi-bin/wsimpedimentosargentina/wsimpedimentosargentina/soap/IwsRestriccion';
  defSvc  = 'IwsRestriccionservice';
  defPrt  = 'IwsRestriccionPort';
var
  RIO: THTTPRIO;
  defWSDL :String;
  defURL  :String;
begin
  Result := nil;
  defURL := DMSem.GLOBAL_WSListaControl;
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
    Result := (RIO as IwsRestriccion);
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
  InvRegistry.RegisterInterface(TypeInfo(IwsRestriccion), 'urn:wsRestriccionIntf-IwsRestriccion', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IwsRestriccion), 'urn:wsRestriccionIntf-IwsRestriccion#%operationName%');
  RemClassRegistry.RegisterXSClass(TRespuesta, 'urn:wsRestriccionIntf', 'TRespuesta');
  RemClassRegistry.RegisterXSClass(DatosEntrada, 'urn:wsRestriccionIntf', 'DatosEntrada');
  RemClassRegistry.RegisterXSClass(DatosSalida, 'urn:wsRestriccionIntf', 'DatosSalida');

end. 