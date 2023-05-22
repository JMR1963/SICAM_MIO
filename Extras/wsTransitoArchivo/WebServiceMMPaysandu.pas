// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://3.5.7.5/WSUyMovMig/WebServiceMM?wsdl
//  >Import : http://3.5.7.5/WSUyMovMig/WebServiceMM?wsdl:0
//  >Import : http://3.5.7.5:80/WSUyMovMig/WebServiceMM?xsd=1
// Encoding : UTF-8
// Version  : 1.0
// (20/05/2013 17:41:08 - - $Rev: 10138 $)
// ************************************************************************ //

unit WebServiceMMPaysandu;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns, ufixWS;

const
  IS_OPTN = $0001;
  IS_UNQL = $0008;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]



  // ************************************************************************ //
  // Namespace : http://uy.gub.minterior/
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : WebServiceMMPortBinding
  // service   : WebServiceMM
  // port      : WebServiceMMPort
  // URL       : http://3.5.7.5:80/WSUyMovMig/WebServiceMM
  // ************************************************************************ //
  WebServiceMM = interface(IInvokable)
  ['{480CB7B1-AF04-EE6E-3C59-1BB923F8324D}']
    function  Ingreso_MM_RAMM(const xml: WideString): WideString; stdcall;
  end;

function GetWebServiceMM(UseWSDL: Boolean=System.False;ip:string='' ;Addr: string=''; HTTPRIO: THTTPRIO = nil): WebServiceMM;


implementation

uses System.SysUtils;

function GetWebServiceMM(UseWSDL: Boolean; ip:string; Addr: string; HTTPRIO: THTTPRIO): WebServiceMM;
const
  defWSDL = 'http://3.5.7.5/WSUyMovMig/WebServiceMM?wsdl';
  defURL  = 'http://3.5.7.5:80/WSUyMovMig/WebServiceMM';
  defSvc  = 'WebServiceMM';
  defPrt  = 'WebServiceMMPort';
var
  RIO: THTTPRIO;
  D : TWSDemora;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      //Addr := defWSDL
      Addr := 'http://'+ip+'/WSUyMovMig/WebServiceMM?wsdl'
    else
      //Addr := defURL;
      Addr := 'http://'+ip+':80/WSUyMovMig/WebServiceMM';
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    D := TWSDemora.Create;
    D.FconnectTimeoutMS := 5000;
    //RIO.HTTPWebNode.OnBeforePost := D.configureHttpRequest;

    Result := (RIO as WebServiceMM);
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
  InvRegistry.RegisterInterface(TypeInfo(WebServiceMM), 'http://uy.gub.minterior/', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(WebServiceMM), '');
  //InvRegistry.RegisterInvokeOptions(TypeInfo(WebServiceMM), ioDocument);

end.