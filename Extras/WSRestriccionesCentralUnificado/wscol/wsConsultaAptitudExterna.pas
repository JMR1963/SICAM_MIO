// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://www.dnmservices.gov.ar/wsConsultaAptitudExterna/wsConsultaAptitudExterna.php?wsdl
// Encoding : UTF-8
// Version  : 1.0
// (25/08/2015 18:18:24 - 1.33.2.5)
// ************************************************************************ //

unit wsConsultaAptitudExterna;

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

  respuestaAlianza     = class;                 { "https://www.dnmservices.gov.ar/wsConsultaAptitudExterna/wsConsultaAptitudExterna.php" }



  // ************************************************************************ //
  // Namespace : https://www.dnmservices.gov.ar/wsConsultaAptitudExterna/wsConsultaAptitudExterna.php
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
  // Namespace : https://www.dnmservices.gov.ar/wsConsultaAptitudExterna/wsConsultaAptitudExterna.php
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : AlianzaArgentinaServicePortBinding
  // service   : AlianzaArgentinaServiceService
  // port      : AlianzaArgentinaServicePort
  // URL       : https://www.dnmservices.gov.ar/wsConsultaAptitudExterna/wsConsultaAptitudExterna.php
  // ************************************************************************ //
  AlianzaArgentinaService = interface(IInvokable)
  ['{88EFD20B-FF0A-2620-AA9D-FBCB7568ACF7}']
    function  consultaColombia(const tipoDocumento: WideString; const numeroDocumento: WideString; const EmisorDocumento: WideString; const numeroIdentificacion: WideString; const PrimerNombre: WideString; const OtrosNombres: WideString; const primerApellido: WideString; const OtrosApellidos: WideString; const fechaNacimiento: WideString; const Genero: WideString; 
                               const Nacionalidad: WideString; const codigoPais: WideString; const nombrePuestoControl: WideString): respuestaAlianza; stdcall;
  end;

function GetAlianzaArgentinaService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): AlianzaArgentinaService;


implementation

function GetAlianzaArgentinaService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): AlianzaArgentinaService;
const
  defWSDL = 'https://www.dnmservices.gov.ar/wsConsultaAptitudExterna/wsConsultaAptitudExterna.php?wsdl';
  defURL  = 'https://www.dnmservices.gov.ar/wsConsultaAptitudExterna/wsConsultaAptitudExterna.php';
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
  InvRegistry.RegisterInterface(TypeInfo(AlianzaArgentinaService), 'https://www.dnmservices.gov.ar/wsConsultaAptitudExterna/wsConsultaAptitudExterna.php', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(AlianzaArgentinaService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(AlianzaArgentinaService), ioDocument);
  RemClassRegistry.RegisterXSClass(respuestaAlianza, 'https://www.dnmservices.gov.ar/wsConsultaAptitudExterna/wsConsultaAptitudExterna.php', 'respuestaAlianza');

end. 