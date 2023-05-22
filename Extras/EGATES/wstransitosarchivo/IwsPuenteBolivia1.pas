// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.0.31/cgi-bin/wsPuenteBolivia/wsPuenteBolivia/wsdl/IwsPuenteBolivia
// Version  : 1.0
// (26/10/2016 10:40:58 - 1.33.2.5)
// ************************************************************************ //

unit IwsPuenteBolivia1;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, system.Types, Soap.XSBuiltIns, ufixWS;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"

  TRespuesta           = class;                 { "urn:wsPuenteBoliviaIntf" }



  // ************************************************************************ //
  // Namespace : urn:wsPuenteBoliviaIntf
  // ************************************************************************ //
  TRespuesta = class(TRemotable)
  private
    FRespuesta: WideString;
    FDetalleRta: WideString;
  published
    property Respuesta: WideString read FRespuesta write FRespuesta;
    property DetalleRta: WideString read FDetalleRta write FDetalleRta;
  end;


  // ************************************************************************ //
  // Namespace : urn:wsPuenteBoliviaIntf-IwsPuenteBolivia
  // soapAction: urn:wsPuenteBoliviaIntf-IwsPuenteBolivia#enviarSobre
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IwsPuenteBoliviabinding
  // service   : IwsPuenteBoliviaservice
  // port      : IwsPuenteBoliviaPort
  // URL       : http://172.16.0.31/cgi-bin/wsPuenteBolivia/wsPuenteBolivia/soap/IwsPuenteBolivia
  // ************************************************************************ //
  IwsPuenteBolivia = interface(IInvokable)
  ['{A1932502-CD63-04DE-9948-37106058E289}']
    function  enviarSobre(const sobre: WideString; const nombreSobre: WideString; const usuario: WideString): TRespuesta; stdcall;
  end;

function GetIwsPuenteBolivia(UseWSDL: Boolean=System.False; ip:string='';  Addr: string=''; HTTPRIO: THTTPRIO = nil): IwsPuenteBolivia;


implementation

function GetIwsPuenteBolivia(UseWSDL: Boolean; ip:string; Addr: string; HTTPRIO: THTTPRIO): IwsPuenteBolivia;
const
  defWSDL ='';// 'http://10.170.107.66:82/cgi-bin/wsPuenteBolivia/wsPuenteBolivia/wsdl/IwsPuenteBolivia';
  defURL  ='';// 'http://10.170.107.66:82/cgi-bin/wsPuenteBolivia/wsPuenteBolivia/soap/IwsPuenteBolivia';
  defSvc  = 'IwsPuenteBoliviaservice';
  defPrt  = 'IwsPuenteBoliviaPort';
var
  RIO: THTTPRIO;
  D : TWSDemora;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := 'http://'+ip+'/cgi-bin/wsPuenteBolivia/wsPuenteBolivia/wsdl/IwsPuenteBolivia'
    else
      Addr := 'http://'+ip+'/cgi-bin/wsPuenteBolivia/wsPuenteBolivia/soap/IwsPuenteBolivia';
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    D := TWSDemora.Create;
    D.FconnectTimeoutMS := 5000;
    RIO.HTTPWebNode.OnBeforePost := D.configureHttpRequest;


    Result := (RIO as IwsPuenteBolivia);
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
  InvRegistry.RegisterInterface(TypeInfo(IwsPuenteBolivia), 'urn:wsPuenteBoliviaIntf-IwsPuenteBolivia', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IwsPuenteBolivia), 'urn:wsPuenteBoliviaIntf-IwsPuenteBolivia#enviarSobre');
  RemClassRegistry.RegisterXSClass(TRespuesta, 'urn:wsPuenteBoliviaIntf', 'TRespuesta');

end. 