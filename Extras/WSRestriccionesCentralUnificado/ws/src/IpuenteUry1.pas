// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.0.31/cgi-bin/PuenteUruguayo/Puenteury/wsdl/IpuenteUry
// Version  : 1.0
// (17/06/2020 17:44:31 - 1.33.2.5)
// ************************************************************************ //

unit IpuenteUry1;

interface

uses soap.InvokeRegistry, soap.SOAPHTTPClient, system.Types, soap.XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"

  consultaPuenteURY    = class;                 { "urn:puenteUryIntf" }
  respuestaURY         = class;                 { "urn:puenteUryIntf" }



  // ************************************************************************ //
  // Namespace : urn:puenteUryIntf
  // ************************************************************************ //
  consultaPuenteURY = class(TRemotable)
  private
    FNOMBRES: WideString;
    FAPELLIDOS: WideString;
    FNUMDOC: WideString;
    FPUESTOCONTROL: WideString;
    FTIPODOC: WideString;
    FEMISORDOC: WideString;
    FFECHANAC: WideString;
    FGENERO: WideString;
    FNACIONALIDAD: WideString;
    FNUMEROIDENTIFICACION: WideString;
    FUSER: WideString;
  published
    property NOMBRES: WideString read FNOMBRES write FNOMBRES;
    property APELLIDOS: WideString read FAPELLIDOS write FAPELLIDOS;
    property NUMDOC: WideString read FNUMDOC write FNUMDOC;
    property PUESTOCONTROL: WideString read FPUESTOCONTROL write FPUESTOCONTROL;
    property TIPODOC: WideString read FTIPODOC write FTIPODOC;
    property EMISORDOC: WideString read FEMISORDOC write FEMISORDOC;
    property FECHANAC: WideString read FFECHANAC write FFECHANAC;
    property GENERO: WideString read FGENERO write FGENERO;
    property NACIONALIDAD: WideString read FNACIONALIDAD write FNACIONALIDAD;
    property NUMEROIDENTIFICACION: WideString read FNUMEROIDENTIFICACION write FNUMEROIDENTIFICACION;
    property USER: WideString read FUSER write FUSER;
  end;



  // ************************************************************************ //
  // Namespace : urn:puenteUryIntf
  // ************************************************************************ //
  respuestaURY = class(TRemotable)
  private
    FCOD_DETALLE_RTA: WideString;
    FCOD_RTA: WideString;
  published
    property COD_DETALLE_RTA: WideString read FCOD_DETALLE_RTA write FCOD_DETALLE_RTA;
    property COD_RTA: WideString read FCOD_RTA write FCOD_RTA;
  end;


  // ************************************************************************ //
  // Namespace : urn:puenteUryIntf-IpuenteUry
  // soapAction: urn:puenteUryIntf-IpuenteUry#consultarPuenteUry
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IpuenteUrybinding
  // service   : IpuenteUryservice
  // port      : IpuenteUryPort
  // URL       : http://172.16.0.31/cgi-bin/PuenteUruguayo/Puenteury/soap/IpuenteUry
  // ************************************************************************ //
  IpuenteUry = interface(IInvokable)
  ['{F4B680BF-0A75-990D-1D96-3C05E0C1087F}']
    function  consultarPuenteUry(const a: consultaPuenteURY): respuestaURY; stdcall;
  end;

function GetIpuenteUry(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IpuenteUry;


implementation

function GetIpuenteUry(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IpuenteUry;
const
  defWSDL = ''; //'http://172.16.0.31/cgi-bin/PuenteUruguayo/Puenteury/wsdl/IpuenteUry';
  defURL  = ''; //'http://172.16.0.31/cgi-bin/PuenteUruguayo/Puenteury/soap/IpuenteUry';
  defSvc  = 'IpuenteUryservice';
  defPrt  = 'IpuenteUryPort';
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
    Result := (RIO as IpuenteUry);
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
  InvRegistry.RegisterInterface(TypeInfo(IpuenteUry), 'urn:puenteUryIntf-IpuenteUry', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IpuenteUry), 'urn:puenteUryIntf-IpuenteUry#consultarPuenteUry');
  RemClassRegistry.RegisterXSClass(consultaPuenteURY, 'urn:puenteUryIntf', 'consultaPuenteURY');
  RemClassRegistry.RegisterXSClass(respuestaURY, 'urn:puenteUryIntf', 'respuestaURY');

end. 