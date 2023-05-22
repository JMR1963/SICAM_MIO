// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.0.60/cgi-bin/puenteBoliviano/puenteBoliviano/wsdl/IpuenteBoliviano
// Version  : 1.0
// (29/09/2016 20:49:48 - 1.33.2.5)
// ************************************************************************ //

unit IpuenteBoliviano1;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, system.Types, Soap.XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"

  DatosEntradaPte      = class;                 { "urn:puenteBolivianoIntf" }
  DatosSalidaPte       = class;                 { "urn:puenteBolivianoIntf" }



  // ************************************************************************ //
  // Namespace : urn:puenteBolivianoIntf
  // ************************************************************************ //
  DatosEntradaPte = class(TRemotable)
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
  end;



  // ************************************************************************ //
  // Namespace : urn:puenteBolivianoIntf
  // ************************************************************************ //
  DatosSalidaPte = class(TRemotable)
  private
    FCOD_RTA: WideString;
    FCOD_DETALLE_RTA: WideString;
  published
    property COD_RTA: WideString read FCOD_RTA write FCOD_RTA;
    property COD_DETALLE_RTA: WideString read FCOD_DETALLE_RTA write FCOD_DETALLE_RTA;
  end;


  // ************************************************************************ //
  // Namespace : urn:puenteBolivianoIntf-IpuenteBoliviano
  // soapAction: urn:puenteBolivianoIntf-IpuenteBoliviano#ConsultaBolivia
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IpuenteBolivianobinding
  // service   : IpuenteBolivianoservice
  // port      : IpuenteBolivianoPort
  // URL       : http://172.16.0.60/cgi-bin/puenteBoliviano/puenteBoliviano/soap/IpuenteBoliviano
  // ************************************************************************ //
  IpuenteBoliviano = interface(IInvokable)
  ['{F0800C95-B179-5BE0-CA42-0E4CAD9367C7}']
    function  ConsultaBolivia(const Consulta: DatosEntradaPte): DatosSalidaPte; stdcall;
  end;

function GetIpuenteBoliviano(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IpuenteBoliviano;


implementation

function GetIpuenteBoliviano(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IpuenteBoliviano;
const
  defWSDL = ''; //  http://172.16.0.60/cgi-bin/puenteBoliviano/puenteBoliviano/wsdl/IpuenteBoliviano
  defURL  = '';  //http://172.16.0.60/cgi-bin/puenteBoliviano/puenteBoliviano/soap/IpuenteBoliviano
  defSvc  = 'IpuenteBolivianoservice';
  defPrt  = 'IpuenteBolivianoPort';
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
    Result := (RIO as IpuenteBoliviano);
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
  InvRegistry.RegisterInterface(TypeInfo(IpuenteBoliviano), 'urn:puenteBolivianoIntf-IpuenteBoliviano', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IpuenteBoliviano), 'urn:puenteBolivianoIntf-IpuenteBoliviano#ConsultaBolivia');
  RemClassRegistry.RegisterXSClass(DatosEntradaPte, 'urn:puenteBolivianoIntf', 'DatosEntradaPte');
  RemClassRegistry.RegisterXSClass(DatosSalidaPte, 'urn:puenteBolivianoIntf', 'DatosSalidaPte');

end. 