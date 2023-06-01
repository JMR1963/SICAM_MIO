// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.192.111/cgi-bin/wsserviciosmaritimos/wsserviciosmaritimos/wsdl/IWsServiciosMaritimos
// Encoding : utf-8
// Version  : 1.0
// (02/10/2009 16:27:24 - 1.33.2.5)
// ************************************************************************ //

unit IWsServiciosMaritimos1;

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
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"

  servicios            = class;                 { "urn:WsServiciosMaritimosIntf" }

  { "urn:WsServiciosMaritimosIntf" }
  Testado = (SOLICITADO, CANCELADO, INTERVENIDO, DIFERIDO, PROCESANDO);



  // ************************************************************************ //
  // Namespace : urn:WsServiciosMaritimosIntf
  // ************************************************************************ //
  servicios = class(TRemotable)
  private
    Fnumero_solicitud: Integer;
    Fautorizado: WideString;
    Festado: WideString;
    Ffecha_declarada: WideString;
    FnombreBuque: WideString;
    Fmatricula: WideString;
  published
    property numero_solicitud: Integer read Fnumero_solicitud write Fnumero_solicitud;
    property autorizado: WideString read Fautorizado write Fautorizado;
    property estado: WideString read Festado write Festado;
    property fecha_declarada: WideString read Ffecha_declarada write Ffecha_declarada;
    property nombreBuque: WideString read FnombreBuque write FnombreBuque;
    property matricula: WideString read Fmatricula write Fmatricula;
  end;

  Tservicios = array of servicios;              { "urn:WsServiciosMaritimosIntf" }

  // ************************************************************************ //
  // Namespace : urn:WsServiciosMaritimosIntf-IWsServiciosMaritimos
  // soapAction: urn:WsServiciosMaritimosIntf-IWsServiciosMaritimos#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IWsServiciosMaritimosbinding
  // service   : IWsServiciosMaritimosservice
  // port      : IWsServiciosMaritimosPort
  // URL       : http://172.16.192.111/cgi-bin/wsserviciosmaritimos/wsserviciosmaritimos/soap/IWsServiciosMaritimos
  // ************************************************************************ //
  IWsServiciosMaritimos = interface(IInvokable)
  ['{1285CE0E-F142-B608-78B4-CC074E9CDE27}']
    function  getServicios(const jurisdiccion: Integer; const fecha_desde: WideString; const fecha_hasta: WideString): Tservicios; stdcall;
    function  setAprobado(const servicio: Integer): Boolean; stdcall;
    function  setEstado(const servicio: Integer; const estado: Testado): Boolean; stdcall;
  end;

function GetIWsServiciosMaritimos(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IWsServiciosMaritimos;


implementation

function GetIWsServiciosMaritimos(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IWsServiciosMaritimos;
const
  defWSDL = 'http://172.16.192.111/cgi-bin/wsserviciosmaritimos/wsserviciosmaritimos/wsdl/IWsServiciosMaritimos';
  defURL  = 'http://172.16.192.111/cgi-bin/wsserviciosmaritimos/wsserviciosmaritimos/soap/IWsServiciosMaritimos';
  defSvc  = 'IWsServiciosMaritimosservice';
  defPrt  = 'IWsServiciosMaritimosPort';
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
    Result := (RIO as IWsServiciosMaritimos);
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
  InvRegistry.RegisterInterface(TypeInfo(IWsServiciosMaritimos), 'urn:WsServiciosMaritimosIntf-IWsServiciosMaritimos', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IWsServiciosMaritimos), 'urn:WsServiciosMaritimosIntf-IWsServiciosMaritimos#%operationName%');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Testado), 'urn:WsServiciosMaritimosIntf', 'Testado');
  RemClassRegistry.RegisterXSClass(servicios, 'urn:WsServiciosMaritimosIntf', 'servicios');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Tservicios), 'urn:WsServiciosMaritimosIntf', 'Tservicios');

end. 