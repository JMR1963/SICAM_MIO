// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.0.48/cgi-bin/Wsdnidepasaporte/wsdnidepasaporte/wsdl/IwsDniPasaporte
// Encoding : utf-8
// Version  : 1.0
// (20/03/2013 09:27:29 a.m. - 1.33.2.5)
// ************************************************************************ //

unit IwsDniPasaporte1;

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
  // Namespace : urn:wsDniPasaporteIntf-IwsDniPasaporte
  // soapAction: urn:wsDniPasaporteIntf-IwsDniPasaporte#dniDePasaporte
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IwsDniPasaportebinding
  // service   : IwsDniPasaporteservice
  // port      : IwsDniPasaportePort
  // URL       : http://172.16.0.48/cgi-bin/Wsdnidepasaporte/wsdnidepasaporte/soap/IwsDniPasaporte
  // ************************************************************************ //
  IwsDniPasaporte = interface(IInvokable)
  ['{0274416C-CFED-380F-D5EA-9515E32D542E}']
    function  dniDePasaporte(const unPasaporte: WideString): WideString; stdcall;
  end;

function GetIwsDniPasaporte(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IwsDniPasaporte;


implementation

function GetIwsDniPasaporte(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IwsDniPasaporte;
const
  defWSDL = 'http://172.16.0.48/cgi-bin/Wsdnidepasaporte/wsdnidepasaporte/wsdl/IwsDniPasaporte';
  defURL  = 'http://172.16.0.48/cgi-bin/Wsdnidepasaporte/wsdnidepasaporte/soap/IwsDniPasaporte';
  defSvc  = 'IwsDniPasaporteservice';
  defPrt  = 'IwsDniPasaportePort';
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
    Result := (RIO as IwsDniPasaporte);
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
  InvRegistry.RegisterInterface(TypeInfo(IwsDniPasaporte), 'urn:wsDniPasaporteIntf-IwsDniPasaporte', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IwsDniPasaporte), 'urn:wsDniPasaporteIntf-IwsDniPasaporte#dniDePasaporte');

end. 