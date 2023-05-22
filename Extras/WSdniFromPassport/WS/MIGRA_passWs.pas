// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://wsrenaper.idear.gov.ar/webservice/MIGRA_passWs.php?wsdl
// Encoding : ISO-8859-1
// Version  : 1.0
// (20/03/2013 09:18:21 a.m. - 1.33.2.5)
// ************************************************************************ //

unit MIGRA_passWs;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

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

  entrada              = class;                 { "urn:renaperwsdl" }
  entrada_pasaporte    = class;                 { "urn:renaperwsdl" }
  pasaporte            = class;                 { "urn:renaperwsdl" }
  resultado            = class;                 { "urn:renaperwsdl" }



  // ************************************************************************ //
  // Namespace : urn:renaperwsdl
  // ************************************************************************ //
  entrada = class(TRemotable)
  private
    Fdni: WideString;
    Fsexo: WideString;
  published
    property dni: WideString read Fdni write Fdni;
    property sexo: WideString read Fsexo write Fsexo;
  end;



  // ************************************************************************ //
  // Namespace : urn:renaperwsdl
  // ************************************************************************ //
  entrada_pasaporte = class(TRemotable)
  private
    Fnum_pasaporte: WideString;
  published
    property num_pasaporte: WideString read Fnum_pasaporte write Fnum_pasaporte;
  end;



  // ************************************************************************ //
  // Namespace : urn:renaperwsdl
  // ************************************************************************ //
  pasaporte = class(TRemotable)
  private
    Fid_tramite: Integer;
    Fnro_pasaporte: WideString;
    Ffecha_vencimiento: WideString;
  published
    property id_tramite: Integer read Fid_tramite write Fid_tramite;
    property nro_pasaporte: WideString read Fnro_pasaporte write Fnro_pasaporte;
    property fecha_vencimiento: WideString read Ffecha_vencimiento write Ffecha_vencimiento;
  end;



  // ************************************************************************ //
  // Namespace : urn:renaperwsdl
  // ************************************************************************ //
  resultado = class(TRemotable)
  private
    FnroDni: WideString;
    Fsexo: WideString;
    Ftramite_id: Integer;
    Ferror: Integer;
    FerrorDescripcion: WideString;
  published
    property nroDni: WideString read FnroDni write FnroDni;
    property sexo: WideString read Fsexo write Fsexo;
    property tramite_id: Integer read Ftramite_id write Ftramite_id;
    property error: Integer read Ferror write Ferror;
    property errorDescripcion: WideString read FerrorDescripcion write FerrorDescripcion;
  end;

  PasaportesArray = array of pasaporte;         { "urn:renaperwsdl" }

  // ************************************************************************ //
  // Namespace : urn:renaperwsdl
  // soapAction: urn:renaperwsdl#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : renaperwsdlBinding
  // service   : renaperwsdl
  // port      : renaperwsdlPort
  // URL       : http://wsrenaper.idear.gov.ar/webservice/MIGRA_passWs.php
  // ************************************************************************ //
  renaperwsdlPortType = interface(IInvokable)
  ['{A664F872-D06D-8B17-8AA5-5166D40E61E3}']
    function  obtenerTramitePass(const entrada: entrada): PasaportesArray; stdcall;
    function  obtenerDni(const entrada: entrada_pasaporte): resultado; stdcall;
  end;

function GetrenaperwsdlPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): renaperwsdlPortType;


implementation

function GetrenaperwsdlPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): renaperwsdlPortType;
const
  defWSDL = 'http://wsrenaper.idear.gov.ar/webservice/MIGRA_passWs.php?wsdl';
  defURL  = 'http://wsrenaper.idear.gov.ar/webservice/MIGRA_passWs.php';
  defSvc  = 'renaperwsdl';
  defPrt  = 'renaperwsdlPort';
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
    Result := (RIO as renaperwsdlPortType);
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
  InvRegistry.RegisterInterface(TypeInfo(renaperwsdlPortType), 'urn:renaperwsdl', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(renaperwsdlPortType), 'urn:renaperwsdl#%operationName%');
  RemClassRegistry.RegisterXSClass(entrada, 'urn:renaperwsdl', 'entrada');
  RemClassRegistry.RegisterXSClass(entrada_pasaporte, 'urn:renaperwsdl', 'entrada_pasaporte');
  RemClassRegistry.RegisterXSClass(pasaporte, 'urn:renaperwsdl', 'pasaporte');
  RemClassRegistry.RegisterXSClass(resultado, 'urn:renaperwsdl', 'resultado');
  RemClassRegistry.RegisterXSInfo(TypeInfo(PasaportesArray), 'urn:renaperwsdl', 'PasaportesArray');

end. 