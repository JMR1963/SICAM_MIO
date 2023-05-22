// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\Users\Administrador.wsprueba\Desktop\consultaArgentina.wsdl
// Encoding : UTF-8
// Version  : 1.0
// (11/09/2015 19:14:59 - 1.33.2.5)
// ************************************************************************ //

unit consultaArgentina;

interface

uses soap.InvokeRegistry, soap.SOAPHTTPClient, system.types, soap.XSBuiltIns;

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

  respuestaAlianza     = class;                 { "http://servicio.migracion.gov.co/" }



  // ************************************************************************ //
  // Namespace : http://servicio.migracion.gov.co/
  // ************************************************************************ //
  respuestaAlianza = class(TRemotable)
  private
    FcodigoError: Integer;
    FcodigoRespuesta: Integer;
  published
    property codigoError: Integer read FcodigoError write FcodigoError;
    property codigoRespuesta: Integer read FcodigoRespuesta write FcodigoRespuesta;
  end;


  // ************************************************************************ //
  // Namespace : http://servicio.migracion.gov.co/
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : AlianzaArgentinaServicePortBinding
  // service   : AlianzaArgentinaServiceService
  // port      : AlianzaArgentinaServicePort
  // URL       : http://172.20.3.115:8011/AlianzaPacifico/consultaArgentina
  // ************************************************************************ //
  AlianzaArgentinaService = interface(IInvokable)
  ['{1598FEAB-8D4F-490F-FD6B-9254F422DEBE}']
    function  consultarPersona(const tipoDocumento: WideString; const numeroDocumento: WideString; const EmisorDocumento: WideString; const numeroIdentificacion: WideString; const PrimerNombre: WideString; const OtrosNombres: WideString; const primerApellido: WideString; const OtrosApellidos: WideString; const fechaNacimiento: WideString; const Genero: WideString; 
                               const Nacionalidad: WideString; const codigoPais: WideString; const nombrePuestoControl: WideString): respuestaAlianza; stdcall;
  end;

function GetAlianzaArgentinaService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): AlianzaArgentinaService;


implementation

function GetAlianzaArgentinaService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): AlianzaArgentinaService;
const
  defWSDL = 'C:\Users\Administrador.wsprueba\Desktop\consultaArgentina.wsdl';
  defURL  = 'http://172.20.3.115:8011/AlianzaPacifico/consultaArgentina';
  defSvc  = 'AlianzaArgentinaServiceService';
  defPrt  = 'AlianzaArgentinaServicePort';
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
    Result := (RIO as AlianzaArgentinaService);
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
  InvRegistry.RegisterInterface(TypeInfo(AlianzaArgentinaService), 'http://servicio.migracion.gov.co/', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(AlianzaArgentinaService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(AlianzaArgentinaService), ioDocument);
  RemClassRegistry.RegisterXSClass(respuestaAlianza, 'http://servicio.migracion.gov.co/', 'respuestaAlianza');

end. 