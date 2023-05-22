// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.192.151/cgi-bin/puenteApiMar/puenteApiMar/wsdl/IpuenteApiMar
// Version  : 1.0
// (25/6/2018 18:02:16 - - $Rev: 69934 $)
// ************************************************************************ //

unit IpuenteApiMar1;

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
  // !:string          - "http://www.w3.org/2001/XMLSchema"[]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[]


  // ************************************************************************ //
  // Namespace : urn:puenteApiMarIntf-IpuenteApiMar
  // soapAction: urn:puenteApiMarIntf-IpuenteApiMar#dameApi
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : IpuenteApiMarbinding
  // service   : IpuenteApiMarservice
  // port      : IpuenteApiMarPort
  // URL       : http://172.16.192.151/cgi-bin/puenteApiMar/puenteApiMar/soap/IpuenteApiMar
  // ************************************************************************ //
  IpuenteApiMar = interface(IInvokable)
  ['{6C778327-0C30-CC6A-63A2-328AD2972A36}']
    function  dameApi(const Paso:  string; const Ape1: string; const ape2: string; const nombre1: string; const nombre2: string; const FechaNac: string;
                      const nroDoc: string; const Libreta: string): string; stdcall;
  end;

function GetIpuenteApiMar(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IpuenteApiMar;


implementation
  uses System.SysUtils;

function GetIpuenteApiMar(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IpuenteApiMar;
const
  defWSDL = 'http://172.16.192.151/cgi-bin/puenteApiMar/puenteApiMar/wsdl/IpuenteApiMar';
  defURL  = 'http://172.16.192.151/cgi-bin/puenteApiMar/puenteApiMar/soap/IpuenteApiMar';
  defSvc  = 'IpuenteApiMarservice';
  defPrt  = 'IpuenteApiMarPort';
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
  { IpuenteApiMar }
  InvRegistry.RegisterInterface(TypeInfo(IpuenteApiMar), 'urn:puenteApiMarIntf-IpuenteApiMar', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IpuenteApiMar), 'urn:puenteApiMarIntf-IpuenteApiMar#dameApi');

end.