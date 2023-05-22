// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.192.151/cgi-bin/puentechileno/puentechileno/wsdl/Ipuentechileno
// Version  : 1.0
// (02/09/2019 14:25:01 - 1.33.2.5)
// ************************************************************************ //

unit Ipuentechileno;

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

  consultaPuenteCHL    = class;                 { "urn:puentechilenoIntf" }
  respuestaDTOCHL      = class;                 { "urn:puentechilenoIntf" }
  consultaProcederCHL  = class;                 { "urn:puentechilenoIntf" }
  respuestaProcederCHL = class;                 { "urn:puentechilenoIntf" }



  // ************************************************************************ //
  // Namespace : urn:puentechilenoIntf
  // ************************************************************************ //
  consultaPuenteCHL = class(TRemotable)
  private
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
    FNUMEROIDENTIFICACION: WideString;
  published
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
    property NUMEROIDENTIFICACION: WideString read FNUMEROIDENTIFICACION write FNUMEROIDENTIFICACION;
  end;



  // ************************************************************************ //
  // Namespace : urn:puentechilenoIntf
  // ************************************************************************ //
  respuestaDTOCHL = class(TRemotable)
  private
    FCOD_DETALLE_RTA: WideString;
    FCOD_RTA: WideString;
  published
    property COD_DETALLE_RTA: WideString read FCOD_DETALLE_RTA write FCOD_DETALLE_RTA;
    property COD_RTA: WideString read FCOD_RTA write FCOD_RTA;
  end;



  // ************************************************************************ //
  // Namespace : urn:puentechilenoIntf
  // ************************************************************************ //
  consultaProcederCHL = class(TRemotable)
  private
    FTipoDocumento: WideString;
    FNumeroDocumento: WideString;
    FPaisDocumento: WideString;
    FObservacion: WideString;
    FFuncionario: WideString;
    FStatus: WideString;
  published
    property TipoDocumento: WideString read FTipoDocumento write FTipoDocumento;
    property NumeroDocumento: WideString read FNumeroDocumento write FNumeroDocumento;
    property PaisDocumento: WideString read FPaisDocumento write FPaisDocumento;
    property Observacion: WideString read FObservacion write FObservacion;
    property Funcionario: WideString read FFuncionario write FFuncionario;
    property Status: WideString read FStatus write FStatus;
  end;



  // ************************************************************************ //
  // Namespace : urn:puentechilenoIntf
  // ************************************************************************ //
  respuestaProcederCHL = class(TRemotable)
  private
    FStatus: Integer;
    FDescripcion: WideString;
  published
    property Status: Integer read FStatus write FStatus;
    property Descripcion: WideString read FDescripcion write FDescripcion;
  end;


  // ************************************************************************ //
  // Namespace : urn:puentechilenoIntf-Ipuentechileno
  // soapAction: urn:puentechilenoIntf-Ipuentechileno#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : Ipuentechilenobinding
  // service   : Ipuentechilenoservice
  // port      : IpuentechilenoPort
  // URL       : http://172.16.192.151/cgi-bin/puentechileno/puentechileno/soap/Ipuentechileno
  // ************************************************************************ //
  Ipuentechileno = interface(IInvokable)
  ['{DF3047EE-01A9-ABC1-A924-4433DF4A84B7}']
    function  consultarPuenteCHL(const a: consultaPuenteCHL): respuestaDTOCHL; stdcall;
    function  procederCHL(const a: consultaProcederCHL): respuestaProcederCHL; stdcall;
  end;

function GetIpuentechileno(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): Ipuentechileno;


implementation

function GetIpuentechileno(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): Ipuentechileno;
const
  defWSDL = 'http://172.16.192.151/cgi-bin/puentechileno/puentechileno/wsdl/Ipuentechileno';
  defURL  = 'http://172.16.192.151/cgi-bin/puentechileno/puentechileno/soap/Ipuentechileno';
  defSvc  = 'Ipuentechilenoservice';
  defPrt  = 'IpuentechilenoPort';
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
    Result := (RIO as Ipuentechileno);
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
  InvRegistry.RegisterInterface(TypeInfo(Ipuentechileno), 'urn:puentechilenoIntf-Ipuentechileno', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(Ipuentechileno), 'urn:puentechilenoIntf-Ipuentechileno#%operationName%');
  RemClassRegistry.RegisterXSClass(consultaPuenteCHL, 'urn:puentechilenoIntf', 'consultaPuenteCHL');
  RemClassRegistry.RegisterXSClass(respuestaDTOCHL, 'urn:puentechilenoIntf', 'respuestaDTOCHL');
  RemClassRegistry.RegisterXSClass(consultaProcederCHL, 'urn:puentechilenoIntf', 'consultaProcederCHL');
  RemClassRegistry.RegisterXSClass(respuestaProcederCHL, 'urn:puentechilenoIntf', 'respuestaProcederCHL');

end.