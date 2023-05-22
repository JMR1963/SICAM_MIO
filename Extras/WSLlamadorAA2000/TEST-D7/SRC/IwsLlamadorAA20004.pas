// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.192.152/cgi-bin/wsLlamadorAA2000/wsLlamadorAA2000/wsdl/IwsLlamadorAA2000
// Version  : 1.0
// (03/02/2021 11:24:10 - 1.33.2.5)
// ************************************************************************ //

unit IwsLlamadorAA20004;

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

  TData                = class;                 { "urn:wsLlamadorAA2000Intf" }
  TTurnInfo            = class;                 { "urn:wsLlamadorAA2000Intf" }



  // ************************************************************************ //
  // Namespace : urn:wsLlamadorAA2000Intf
  // ************************************************************************ //
  TData = class(TRemotable)
  private
    FID_Queue: WideString;
    FBOX: WideString;
    Fletter: WideString;
  published
    property ID_Queue: WideString read FID_Queue write FID_Queue;
    property BOX: WideString read FBOX write FBOX;
    property letter: WideString read Fletter write Fletter;
  end;



  // ************************************************************************ //
  // Namespace : urn:wsLlamadorAA2000Intf
  // ************************************************************************ //
  TTurnInfo = class(TRemotable)
  private
    FERROR: WideString;
    FDESCRIPTION: WideString;
    FidQueue: WideString;
    FidQueueShift: WideString;
    Freason: WideString;
    Fletter: WideString;
    Forder: WideString;
  published
    property ERROR: WideString read FERROR write FERROR;
    property DESCRIPTION: WideString read FDESCRIPTION write FDESCRIPTION;
    property idQueue: WideString read FidQueue write FidQueue;
    property idQueueShift: WideString read FidQueueShift write FidQueueShift;
    property reason: WideString read Freason write Freason;
    property letter: WideString read Fletter write Fletter;
    property order: WideString read Forder write Forder;
  end;


  // ************************************************************************ //
  // Namespace : urn:wsLlamadorAA2000Intf-IwsLlamadorAA2000
  // soapAction: urn:wsLlamadorAA2000Intf-IwsLlamadorAA2000#Call
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IwsLlamadorAA2000binding
  // service   : IwsLlamadorAA2000service
  // port      : IwsLlamadorAA2000Port
  // URL       : http://172.16.192.152/cgi-bin/wsLlamadorAA2000/wsLlamadorAA2000/soap/IwsLlamadorAA2000
  // ************************************************************************ //
  IwsLlamadorAA2000 = interface(IInvokable)
  ['{ACA0D755-71FF-67D8-5F3E-595BEB429426}']
    function  Call(const Data: TData): TTurnInfo; stdcall;
  end;

function GetIwsLlamadorAA2000(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IwsLlamadorAA2000;


implementation

function GetIwsLlamadorAA2000(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IwsLlamadorAA2000;
const
  defWSDL = 'http://172.16.192.152/cgi-bin/wsLlamadorAA2000/wsLlamadorAA2000/wsdl/IwsLlamadorAA2000';
  defURL  = 'http://172.16.192.152/cgi-bin/wsLlamadorAA2000/wsLlamadorAA2000/soap/IwsLlamadorAA2000';
  defSvc  = 'IwsLlamadorAA2000service';
  defPrt  = 'IwsLlamadorAA2000Port';
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
    Result := (RIO as IwsLlamadorAA2000);
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
  InvRegistry.RegisterInterface(TypeInfo(IwsLlamadorAA2000), 'urn:wsLlamadorAA2000Intf-IwsLlamadorAA2000', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IwsLlamadorAA2000), 'urn:wsLlamadorAA2000Intf-IwsLlamadorAA2000#Call');
  RemClassRegistry.RegisterXSClass(TData, 'urn:wsLlamadorAA2000Intf', 'TData');
  RemClassRegistry.RegisterXSClass(TTurnInfo, 'urn:wsLlamadorAA2000Intf', 'TTurnInfo');

end. 