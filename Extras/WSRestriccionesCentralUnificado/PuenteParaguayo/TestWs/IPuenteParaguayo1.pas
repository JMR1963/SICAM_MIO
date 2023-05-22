// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.192.151/cgi-bin/puenteparaguayo/puenteparaguayo/wsdl/IPuenteParaguayo
//  >Import : http://172.16.192.151/cgi-bin/puenteparaguayo/puenteparaguayo/wsdl/IPuenteParaguayo>0
// Version  : 1.0
// (19/04/2016 18:31:40 - - $Rev: 69934 $)
// ************************************************************************ //

unit IPuenteParaguayo1;

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

  respuestaDTOPry      = class;                 { "urn:PuenteParaguayoIntf"[GblCplx] }
  consultaPuentePry    = class;                 { "urn:PuenteParaguayoIntf"[GblCplx] }



  // ************************************************************************ //
  // XML       : respuestaDTOPry, global, <complexType>
  // Namespace : urn:PuenteParaguayoIntf
  // ************************************************************************ //
  respuestaDTOPry = class(TRemotable)
  private
    FCOD_DETALLE_RTA: string;
    FCOD_RTA: string;
  published
    property COD_DETALLE_RTA: string  read FCOD_DETALLE_RTA write FCOD_DETALLE_RTA;
    property COD_RTA:         string  read FCOD_RTA write FCOD_RTA;
  end;



  // ************************************************************************ //
  // XML       : consultaPuentePry, global, <complexType>
  // Namespace : urn:PuenteParaguayoIntf
  // ************************************************************************ //
  consultaPuentePry = class(TRemotable)
  private
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
    FNUMEROIDENTIFICACION: string;
  published
    property CODPAIS:              string  read FCODPAIS write FCODPAIS;
    property NOMBRE1:              string  read FNOMBRE1 write FNOMBRE1;
    property NOMBRE2:              string  read FNOMBRE2 write FNOMBRE2;
    property APELLIDO1:            string  read FAPELLIDO1 write FAPELLIDO1;
    property APELLIDO2:            string  read FAPELLIDO2 write FAPELLIDO2;
    property NUMDOC:               string  read FNUMDOC write FNUMDOC;
    property PUESTOCONTROL:        string  read FPUESTOCONTROL write FPUESTOCONTROL;
    property TIPODOC:              string  read FTIPODOC write FTIPODOC;
    property EMISORDOC:            string  read FEMISORDOC write FEMISORDOC;
    property FECHANAC:             string  read FFECHANAC write FFECHANAC;
    property GENERO:               string  read FGENERO write FGENERO;
    property NACIONALIDAD:         string  read FNACIONALIDAD write FNACIONALIDAD;
    property NUMEROIDENTIFICACION: string  read FNUMEROIDENTIFICACION write FNUMEROIDENTIFICACION;
  end;


  // ************************************************************************ //
  // Namespace : urn:PuenteParaguayoIntf-IPuenteParaguayo
  // soapAction: urn:PuenteParaguayoIntf-IPuenteParaguayo#consultarPuentePry
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : IPuenteParaguayobinding
  // service   : IPuenteParaguayoservice
  // port      : IPuenteParaguayoPort
  // URL       : http://172.16.192.151/cgi-bin/puenteparaguayo/puenteparaguayo/soap/IPuenteParaguayo
  // ************************************************************************ //
  IPuenteParaguayo = interface(IInvokable)
  ['{731BDC6E-5657-0BD4-D98F-75AE0B93BC6A}']
    function  consultarPuentePry(const a: consultaPuentePry): respuestaDTOPry; stdcall;
  end;

function GetIPuenteParaguayo(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IPuenteParaguayo;


implementation
  uses System.SysUtils;

function GetIPuenteParaguayo(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IPuenteParaguayo;
const
  defWSDL = 'http://172.16.0.31/cgi-bin/puenteParaguayo - New - solopruebas/puenteparaguayo/wsdl/IPuenteParaguayo';
  defURL  = 'http://172.16.0.31/cgi-bin/puenteParaguayo - New - solopruebas/puenteparaguayo/soap/IPuenteParaguayo';
  defSvc  = 'IPuenteParaguayoservice';
  defPrt  = 'IPuenteParaguayoPort';
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
    Result := (RIO as IPuenteParaguayo);
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
  { IPuenteParaguayo }
  InvRegistry.RegisterInterface(TypeInfo(IPuenteParaguayo), 'urn:PuenteParaguayoIntf-IPuenteParaguayo', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IPuenteParaguayo), 'urn:PuenteParaguayoIntf-IPuenteParaguayo#consultarPuentePry');
  RemClassRegistry.RegisterXSClass(respuestaDTOPry, 'urn:PuenteParaguayoIntf', 'respuestaDTOPry');
  RemClassRegistry.RegisterXSClass(consultaPuentePry, 'urn:PuenteParaguayoIntf', 'consultaPuentePry');

end.