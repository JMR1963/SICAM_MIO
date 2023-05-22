// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.170.106.130:82/cgi-bin/WSDespachosPuenteURG/WSDespachosPuenteURG/wsdl/IpuenteWSdespachosUruguay
// Version  : 1.0
// (19/09/2017 08:17:13 p.m. - 1.33.2.5)
// ************************************************************************ //

unit IpuenteWSdespachosUruguay1;

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


  // ************************************************************************ //
  // Namespace : urn:puenteWSdespachosUruguayIntf-IpuenteWSdespachosUruguay
  // soapAction: urn:puenteWSdespachosUruguayIntf-IpuenteWSdespachosUruguay#PuenteDespachosURG
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IpuenteWSdespachosUruguaybinding
  // service   : IpuenteWSdespachosUruguayservice
  // port      : IpuenteWSdespachosUruguayPort
  // URL       : http://10.170.106.130:82/cgi-bin/WSDespachosPuenteURG/WSDespachosPuenteURG/soap/IpuenteWSdespachosUruguay
  // ************************************************************************ //
  IpuenteWSdespachosUruguay = interface(IInvokable)
  ['{B4EC5D48-E95E-DF9C-ED3A-06E4886BD227}']
    function  PuenteDespachosURG(const fechaDesde: WideString; const fechaHasta: WideString): WideString; stdcall;
  end;

function GetIpuenteWSdespachosUruguay(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IpuenteWSdespachosUruguay;


implementation

function GetIpuenteWSdespachosUruguay(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IpuenteWSdespachosUruguay;
const
  defWSDL = 'http://10.170.106.130:82/cgi-bin/WSDespachosPuenteURG/WSDespachosPuenteURG/wsdl/IpuenteWSdespachosUruguay';
  defURL  = 'http://10.170.106.130:82/cgi-bin/WSDespachosPuenteURG/WSDespachosPuenteURG/soap/IpuenteWSdespachosUruguay';
  defSvc  = 'IpuenteWSdespachosUruguayservice';
  defPrt  = 'IpuenteWSdespachosUruguayPort';
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
    Result := (RIO as IpuenteWSdespachosUruguay);
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
  InvRegistry.RegisterInterface(TypeInfo(IpuenteWSdespachosUruguay), 'urn:puenteWSdespachosUruguayIntf-IpuenteWSdespachosUruguay', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IpuenteWSdespachosUruguay), 'urn:puenteWSdespachosUruguayIntf-IpuenteWSdespachosUruguay#PuenteDespachosURG');

end. 