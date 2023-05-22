// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://localhost:8090/wsdl/IWSRemotoEGATE
// Version  : 1.0
// (19/09/2019 17:53:56 - - $Rev: 69934 $)
// ************************************************************************ //

unit IWSRemotoEGATE2;

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
  // Namespace : urn:WSRemotoEGATEIntf-IWSRemotoEGATE
  // soapAction: urn:WSRemotoEGATEIntf-IWSRemotoEGATE#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : IWSRemotoEGATEbinding
  // service   : IWSRemotoEGATEservice
  // port      : IWSRemotoEGATEPort
  // URL       : http://localhost:8090/soap/IWSRemotoEGATE
  // ************************************************************************ //
  IWSRemotoEGATE = interface(IInvokable)
  ['{8957A336-1092-AEC6-1E18-DE24600CC2F3}']
    function  biometricdevices(const paramList: string): string; stdcall;
    function  fingerMatch(const paramList: string; const image: TByteDynArray): Integer; stdcall;
    function  faceMatch(const paramList: string; const strImgB64: string): Integer; stdcall;
  end;

function GetIWSRemotoEGATE(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IWSRemotoEGATE;

implementation

uses System.SysUtils,uGlobal;

function GetIWSRemotoEGATE(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IWSRemotoEGATE;
const
  defSvc  = 'IWSRemotoEGATEservice';
  defPrt  = 'IWSRemotoEGATEPort';
var
  RIO: THTTPRIO;

begin
  if GLOBAL_NROREMOTO=0 then
    Addr := wsbiometric
  else
    Addr := wsbiometric2;

  Result := nil;

  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as IWSRemotoEGATE);
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
  { IWSRemotoEGATE }
  InvRegistry.RegisterInterface(TypeInfo(IWSRemotoEGATE), 'urn:WSRemotoEGATEIntf-IWSRemotoEGATE', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IWSRemotoEGATE), 'urn:WSRemotoEGATEIntf-IWSRemotoEGATE#%operationName%');

end.