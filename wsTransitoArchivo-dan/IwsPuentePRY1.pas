// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.0.31/cgi-bin/wsPuentePRY/wsPuentePRY/wsdl/IwsPuentePRY
// Version  : 1.0
// (21/12/2016 12:13:06 - 1.33.2.5)
// ************************************************************************ //

unit IwsPuentePRY1;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns, ufixWS;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"

  TRespuestaPry        = class;                 { "urn:wsPuentePRYIntf" }



  // ************************************************************************ //
  // Namespace : urn:wsPuentePRYIntf
  // ************************************************************************ //
  TRespuestaPry = class(TRemotable)
  private
    FRespuesta: WideString;
    FDetalleRta: WideString;
  published
    property Respuesta: WideString read FRespuesta write FRespuesta;
    property DetalleRta: WideString read FDetalleRta write FDetalleRta;
  end;


  // ************************************************************************ //
  // Namespace : urn:wsPuentePRYIntf-IwsPuentePRY
  // soapAction: urn:wsPuentePRYIntf-IwsPuentePRY#enviarSobre
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IwsPuentePRYbinding
  // service   : IwsPuentePRYservice
  // port      : IwsPuentePRYPort
  // URL       : http://172.16.0.31/cgi-bin/wsPuentePRY/wsPuentePRY/soap/IwsPuentePRY
  // ************************************************************************ //
  IwsPuentePRY = interface(IInvokable)
  ['{9EE88B86-96B3-E4E7-F93A-B7A1FB01A941}']
    function  enviarSobre(const name: WideString; const sobre: WideString): TRespuestaPry; stdcall;
  end;

function GetIwsPuentePRY(UseWSDL: Boolean=System.False; ip:string=''; Addr: string=''; HTTPRIO: THTTPRIO = nil): IwsPuentePRY;


implementation

function GetIwsPuentePRY(UseWSDL: Boolean; ip:string; Addr: string; HTTPRIO: THTTPRIO): IwsPuentePRY;
const
  //defWSDL = 'http://172.16.0.31/cgi-bin/wsPuentePRY/wsPuentePRY/wsdl/IwsPuentePRY';
  //defURL  = 'http://172.16.0.31/cgi-bin/wsPuentePRY/wsPuentePRY/soap/IwsPuentePRY';
  defSvc  = 'IwsPuentePRYservice';
  defPrt  = 'IwsPuentePRYPort';
var
  RIO: THTTPRIO;
  D : TWSDemora;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := 'http://'+ip+'/cgi-bin/wsPuentePRY/wsPuentePRY/wsdl/IwsPuentePRY'
    else
      Addr := 'http://'+ip+'/cgi-bin/wsPuentePRY/wsPuentePRY/soap/IwsPuentePRY';
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    //D := TWSDemora.Create;
    // D.FconnectTimeoutMS := 5000;
    //RIO.HTTPWebNode.OnBeforePost := D.configureHttpRequest;

    Result := (RIO as IwsPuentePRY);
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
  InvRegistry.RegisterInterface(TypeInfo(IwsPuentePRY), 'urn:wsPuentePRYIntf-IwsPuentePRY', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IwsPuentePRY), 'urn:wsPuentePRYIntf-IwsPuentePRY#enviarSobre');
  RemClassRegistry.RegisterXSClass(TRespuestaPry, 'urn:wsPuentePRYIntf', 'TRespuestaPry');

end.