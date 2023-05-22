// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.0.60/cgi-bin/puenteBoliviano/puenteBoliviano/wsdl/IpuenteBoliviano
//  >Import : http://172.16.0.60/cgi-bin/puenteBoliviano/puenteBoliviano/wsdl/IpuenteBoliviano>0
// Version  : 1.0
// (29/09/2016 21:03:39 - - $Rev: 69934 $)
// ************************************************************************ //

unit IpuenteBoliviano1;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  DatosSalidaPte       = class;                 { "urn:puenteBolivianoIntf"[GblCplx] }
  DatosEntradaPte      = class;                 { "urn:puenteBolivianoIntf"[GblCplx] }



  // ************************************************************************ //
  // XML       : DatosSalidaPte, global, <complexType>
  // Namespace : urn:puenteBolivianoIntf
  // ************************************************************************ //
  DatosSalidaPte = class(TRemotable)
  private
    FCOD_RTA: string;
    FCOD_DETALLE_RTA: string;
  published
    property COD_RTA:         string  read FCOD_RTA write FCOD_RTA;
    property COD_DETALLE_RTA: string  read FCOD_DETALLE_RTA write FCOD_DETALLE_RTA;
  end;



  // ************************************************************************ //
  // XML       : DatosEntradaPte, global, <complexType>
  // Namespace : urn:puenteBolivianoIntf
  // ************************************************************************ //
  DatosEntradaPte = class(TRemotable)
  private
    FUSUARIO: string;
    FCLAVE: string;
    FOPERADOR: string;
    FCODPAIS: string;
    FNOMBRE1: string;
    FNOMBRE2: string;
    FAPELLIDO1: string;
    FAPELLIDO2: string;
    FNUMDOC: string;
    FPUESTOCONTROL: string;
    FTIPODOC: string;
    FEMISORDOC: string;
    FFECHANAC: string;
    FGENERO: string;
    FNACIONALIDAD: string;
    FNUMEROIDENIFICACION: string;
  published
    property USUARIO:             string  read FUSUARIO write FUSUARIO;
    property CLAVE:               string  read FCLAVE write FCLAVE;
    property OPERADOR:            string  read FOPERADOR write FOPERADOR;
    property CODPAIS:             string  read FCODPAIS write FCODPAIS;
    property NOMBRE1:             string  read FNOMBRE1 write FNOMBRE1;
    property NOMBRE2:             string  read FNOMBRE2 write FNOMBRE2;
    property APELLIDO1:           string  read FAPELLIDO1 write FAPELLIDO1;
    property APELLIDO2:           string  read FAPELLIDO2 write FAPELLIDO2;
    property NUMDOC:              string  read FNUMDOC write FNUMDOC;
    property PUESTOCONTROL:       string  read FPUESTOCONTROL write FPUESTOCONTROL;
    property TIPODOC:             string  read FTIPODOC write FTIPODOC;
    property EMISORDOC:           string  read FEMISORDOC write FEMISORDOC;
    property FECHANAC:            string  read FFECHANAC write FFECHANAC;
    property GENERO:              string  read FGENERO write FGENERO;
    property NACIONALIDAD:        string  read FNACIONALIDAD write FNACIONALIDAD;
    property NUMEROIDENIFICACION: string  read FNUMEROIDENIFICACION write FNUMEROIDENIFICACION;
  end;


  // ************************************************************************ //
  // Namespace : urn:puenteBolivianoIntf-IpuenteBoliviano
  // soapAction: urn:puenteBolivianoIntf-IpuenteBoliviano#ConsultaBolivia
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
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
  uses System.SysUtils;

function GetIpuenteBoliviano(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IpuenteBoliviano;
const
  defWSDL = 'http://172.16.0.60/cgi-bin/puenteBoliviano/puenteBoliviano/wsdl/IpuenteBoliviano';
  defURL  = 'http://172.16.0.60/cgi-bin/puenteBoliviano/puenteBoliviano/soap/IpuenteBoliviano';
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
  { IpuenteBoliviano }
  InvRegistry.RegisterInterface(TypeInfo(IpuenteBoliviano), 'urn:puenteBolivianoIntf-IpuenteBoliviano', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IpuenteBoliviano), 'urn:puenteBolivianoIntf-IpuenteBoliviano#ConsultaBolivia');
  RemClassRegistry.RegisterXSClass(DatosSalidaPte, 'urn:puenteBolivianoIntf', 'DatosSalidaPte');
  RemClassRegistry.RegisterXSClass(DatosEntradaPte, 'urn:puenteBolivianoIntf', 'DatosEntradaPte');

end.