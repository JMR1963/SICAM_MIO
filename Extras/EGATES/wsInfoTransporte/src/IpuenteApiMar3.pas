// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.0.31/cgi-bin/puenteApiMar/puenteApiMar/wsdl/IpuenteApiMar
// Version  : 1.0
// (23/12/2021 10:44:05 - 1.33.2.5)
// ************************************************************************ //

unit IpuenteApiMar3;

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


  // ************************************************************************ //
  // Namespace : urn:puenteApiMarIntf-IpuenteApiMar
  // soapAction: urn:puenteApiMarIntf-IpuenteApiMar#dameApi
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IpuenteApiMarbinding
  // service   : IpuenteApiMarservice
  // port      : IpuenteApiMarPort
  // URL       : http://172.16.0.31/cgi-bin/puenteApiMar/puenteApiMar/soap/IpuenteApiMar
  // ************************************************************************ //
  IpuenteApiMar = interface(IInvokable)
  ['{6C778327-0C30-CC6A-63A2-328AD2972A36}']
    function  dameApi(const Paso: WideString; const Ape1: WideString; const ape2: WideString; const nombre1: WideString; const nombre2: WideString; const FechaNac: WideString; const nroDoc: WideString; const Libreta: WideString): WideString; stdcall;
  end;

function GetIpuenteApiMar(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IpuenteApiMar;


implementation

function GetIpuenteApiMar(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IpuenteApiMar;
const
  //defWSDL = 'http://172.16.0.31/cgi-bin/puenteApiMar/puenteApiMar/wsdl/IpuenteApiMar';
  //defURL  = 'http://172.16.0.31/cgi-bin/puenteApiMar/puenteApiMar/soap/IpuenteApiMar';
  defSvc  = 'IpuenteApiMarservice';
  defPrt  = 'IpuenteApiMarPort';
var
  RIO: THTTPRIO;
  defWSDL, defURL:string;
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
    Result := (RIO as IpuenteApiMar);
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
  InvRegistry.RegisterInterface(TypeInfo(IpuenteApiMar), 'urn:puenteApiMarIntf-IpuenteApiMar', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IpuenteApiMar), 'urn:puenteApiMarIntf-IpuenteApiMar#dameApi');

end.