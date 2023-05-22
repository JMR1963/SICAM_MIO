// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://127.0.0.1:8091/wsdl/IWS32RemotofingerMatch
// Version  : 1.0
// (01/10/2019 15:51:10 - - $Rev: 69934 $)
// ************************************************************************ //

unit IWS32RemotofingerMatch1;

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
  // !:int             - "http://www.w3.org/2001/XMLSchema"[]
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"[]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[]

  // ************************************************************************ //
  // Namespace : urn:WS32RemotofingerMatchIntf-IWS32RemotofingerMatch
  // soapAction: urn:WS32RemotofingerMatchIntf-IWS32RemotofingerMatch#fingerMatch
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : IWS32RemotofingerMatchbinding
  // service   : IWS32RemotofingerMatchservice
  // port      : IWS32RemotofingerMatchPort
  // URL       : http://127.0.0.1:8091/soap/IWS32RemotofingerMatch
  // ************************************************************************ //
  IWS32RemotofingerMatch = interface(IInvokable)
  ['{8123D87B-A1C4-D9CB-147F-F9E75F239DA5}']
    function  fingerMatch(const paramList: string; const image: TByteDynArray): Integer; stdcall;
    function  formateoSoloHuella1WSQ(const paramList: string): Integer; stdcall;
  end;

function GetIWS32RemotofingerMatch(UseWSDL: Boolean = System.False;
  Addr: string = ''; HTTPRIO: THTTPRIO = nil): IWS32RemotofingerMatch;

implementation

uses System.SysUtils, uGlobal;

function GetIWS32RemotofingerMatch(UseWSDL: Boolean; Addr: string;
  HTTPRIO: THTTPRIO): IWS32RemotofingerMatch;
const
  defSvc = 'IWS32RemotofingerMatchservice';
  defPrt = 'IWS32RemotofingerMatchPort';
var
  RIO: THTTPRIO;
begin
  if GLOBAL_NROREMOTO=0 then
    Addr := wsfingerMatch
  else
    Addr := wsfingerMatch2;


  Result := nil;

  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as IWS32RemotofingerMatch);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end
    else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;

initialization

{ IWS32RemotofingerMatch }
  InvRegistry.RegisterInterface(TypeInfo(IWS32RemotofingerMatch), 'urn:WS32RemotofingerMatchIntf-IWS32RemotofingerMatch', '');
  InvRegistry.RegisterAllSOAPActions(TypeInfo(IWS32RemotofingerMatch), '|urn:WS32RemotofingerMatchIntf-IWS32RemotofingerMatch#fingerMatch|urn:WS32RemotofingerMatchIntf-IWS32RemotofingerMatch#formateoSoloHuella1WSQ');

end.
