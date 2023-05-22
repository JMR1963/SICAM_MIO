// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\sicam\extra\wsRenaper\migraciones.xml
// Encoding : ISO-8859-1
// Version  : 1.0
// (01/08/2011 15:57:34 - 1.33.2.5)
// ************************************************************************ //

unit UwsdlRenaper;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns, Ufunciones;

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

  DatosEntrada         = class;                 { "urn:migracioneswsdl" }
  DatosSalida          = class;                 { "urn:migracioneswsdl" }



  // ************************************************************************ //
  // Namespace : urn:migracioneswsdl
  // ************************************************************************ //
  DatosEntrada = class(TRemotable)
  private
    FidPersona: Integer;
  published
    property idPersona: Integer read FidPersona write FidPersona;
  end;



  // ************************************************************************ //
  // Namespace : urn:migracioneswsdl
  // ************************************************************************ //
  DatosSalida = class(TRemotable)
  private
    FidPersona: Integer;
    Fapelldio: WideString;
    Fnombres: WideString;
    Fdni: WideString;
    Fsexo: WideString;
    FfechaDeNacimiento: WideString;
    Ffoto: WideString;
    FnroError: Integer;
    FdescripcionError: WideString;
    FhuellaWsq: WideString;
  published
    property idPersona: Integer read FidPersona write FidPersona;
    property apelldio: WideString read Fapelldio write Fapelldio;
    property nombres: WideString read Fnombres write Fnombres;
    property dni: WideString read Fdni write Fdni;
    property sexo: WideString read Fsexo write Fsexo;
    property fechaDeNacimiento: WideString read FfechaDeNacimiento write FfechaDeNacimiento;
    property foto: WideString read Ffoto write Ffoto;
    property nroError: Integer read FnroError write FnroError;
    property descripcionError: WideString read FdescripcionError write FdescripcionError;
    property huellaWsq: WideString read FhuellaWsq write FhuellaWsq;
  end;


  // ************************************************************************ //
  // Namespace : urn:migracioneswsdl
  // soapAction: urn:migracioneswsdl#obtenerPersona
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : migracioneswsdlBinding
  // service   : migracioneswsdl
  // port      : migracioneswsdlPort
  // URL       : http://wsrenaper.idear.gov.ar/webservice/migraciones.php
  // ************************************************************************ //
  migracioneswsdlPortType = interface(IInvokable)
  ['{A27D21D5-4375-C0DE-D8A2-C6F76B5AC9EC}']
    function  obtenerPersona(const DatosEntrada: DatosEntrada): DatosSalida; stdcall;
  end;

function GetmigracioneswsdlPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): migracioneswsdlPortType;


implementation

function GetmigracioneswsdlPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): migracioneswsdlPortType;
const
  defWSDL = 'http://wsrenaper.idear.gov.ar/webservice/migraciones.php?wsdl';
  defURL  = 'http://wsrenaper.idear.gov.ar/webservice/migraciones.php';
  defSvc  = 'migracioneswsdl';
  defPrt  = 'migracioneswsdlPort';
var
  RIO: THTTPRIO;
  D:TWSDemora;
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
    D := TWSDemora.Create;
    d.FconnectTimeoutMS := 1000;
    d.FsendTimeoutMS    := 1000;
    d.FreceiveTimeoutMS := 1000;
    RIO.HTTPWebNode.OnBeforePost := d.configureHttpRequest;
    //RIO.HTTPWebNode.Proxy := '172.16.14.92:8080';
    Result := (RIO as migracioneswsdlPortType);
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
  InvRegistry.RegisterInterface(TypeInfo(migracioneswsdlPortType), 'urn:migracioneswsdl', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(migracioneswsdlPortType), 'urn:migracioneswsdl#obtenerPersona');
  RemClassRegistry.RegisterXSClass(DatosEntrada, 'urn:migracioneswsdl', 'DatosEntrada');
  RemClassRegistry.RegisterXSClass(DatosSalida, 'urn:migracioneswsdl', 'DatosSalida');

end.