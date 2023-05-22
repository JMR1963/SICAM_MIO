// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.170.106.130:82/cgi-bin/wsDespachosSalidas/wsDespachos/wsdl/IdespachosSicam
// Encoding : utf-8
// Version  : 1.0
// (19/09/2017 08:23:48 p.m. - 1.33.2.5)
// ************************************************************************ //

unit IdespachosSicam1;

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

  TFECHA               = class;                 { "urn:despachosSicamIntf" }
  TRESULTADO           = class;                 { "urn:despachosSicamIntf" }
  TDESPCHILES          = class;                 { "urn:despachosSicamIntf" }
  TXML                 = class;                 { "urn:despachosSicamIntf" }
  TLS                  = class;                 { "urn:despachosSicamIntf" }



  // ************************************************************************ //
  // Namespace : urn:despachosSicamIntf
  // ************************************************************************ //
  TFECHA = class(TRemotable)
  private
    FFINI: WideString;
    FFFIN: WideString;
  published
    property FINI: WideString read FFINI write FFINI;
    property FFIN: WideString read FFFIN write FFFIN;
  end;



  // ************************************************************************ //
  // Namespace : urn:despachosSicamIntf
  // ************************************************************************ //
  TRESULTADO = class(TRemotable)
  private
    FRESULTADO: WideString;
  published
    property RESULTADO: WideString read FRESULTADO write FRESULTADO;
  end;



  // ************************************************************************ //
  // Namespace : urn:despachosSicamIntf
  // ************************************************************************ //
  TDESPCHILES = class(TRemotable)
  private
    FFINI: WideString;
    FFFIN: WideString;
    FID: WideString;
    FFUN: WideString;
  published
    property FINI: WideString read FFINI write FFINI;
    property FFIN: WideString read FFFIN write FFFIN;
    property ID: WideString read FID write FID;
    property FUN: WideString read FFUN write FFUN;
  end;



  // ************************************************************************ //
  // Namespace : urn:despachosSicamIntf
  // ************************************************************************ //
  TXML = class(TRemotable)
  private
    FXML: WideString;
  published
    property XML: WideString read FXML write FXML;
  end;



  // ************************************************************************ //
  // Namespace : urn:despachosSicamIntf
  // ************************************************************************ //
  TLS = class(TRemotable)
  private
    FLSA: WideString;
    FLSB: WideString;
  published
    property LSA: WideString read FLSA write FLSA;
    property LSB: WideString read FLSB write FLSB;
  end;


  // ************************************************************************ //
  // Namespace : urn:despachosSicamIntf-IdespachosSicam
  // soapAction: |urn:despachosSicamIntf-IdespachosSicam#despachosSicam|urn:despachosSicamIntf-IdespachosSicam#despachosChile|urn:despachosSicamIntf-IdespachosSicam#despachosUruguay|urn:despachosSicamIntf-IdespachosSicam#DESPACHOSxmlToLs|urn:despachosSicamIntf-IdespachosSicam#FALTANTESxmlToLs|urn:despachosSicamIntf-IdespachosSicam#DifLsALsB
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IdespachosSicambinding
  // service   : IdespachosSicamservice
  // port      : IdespachosSicamPort
  // URL       : http://10.170.106.130:82/cgi-bin/wsDespachosSalidas/wsDespachos/soap/IdespachosSicam
  // ************************************************************************ //
  IdespachosSicam = interface(IInvokable)
  ['{38787457-F563-EF37-A0F7-E00F293B5D1D}']
    function  despachosSicam(const FECHA: TFECHA): TRESULTADO; stdcall;
    function  despachosChile(const DESPCHL: TDESPCHILES): TRESULTADO; stdcall;
    function  despachosUruguay(const FECHA: TFECHA): TRESULTADO; stdcall;
    function  DESPACHOSxmlToLs(const aXML: TXML): TRESULTADO; stdcall;
    function  FALTANTESxmlToLs(const aXML: TXML): TRESULTADO; stdcall;
    function  DifLsALsB(const LS: TLS): TRESULTADO; stdcall;
  end;

function GetIdespachosSicam(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IdespachosSicam;


implementation

function GetIdespachosSicam(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IdespachosSicam;
const
  defWSDL = '';//http://10.170.106.130:82/cgi-bin/wsDespachosSalidas/wsDespachos/wsdl/IdespachosSicam';
  defURL  = '';//http://10.170.106.130:82/cgi-bin/wsDespachosSalidas/wsDespachos/soap/IdespachosSicam';
  defSvc  = 'IdespachosSicamservice';
  defPrt  = 'IdespachosSicamPort';
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
    Result := (RIO as IdespachosSicam);
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
  InvRegistry.RegisterInterface(TypeInfo(IdespachosSicam), 'urn:despachosSicamIntf-IdespachosSicam', 'utf-8');
  InvRegistry.RegisterAllSOAPActions(TypeInfo(IdespachosSicam), '|urn:despachosSicamIntf-IdespachosSicam#despachosSicam'
                                                               +'|urn:despachosSicamIntf-IdespachosSicam#despachosChile'
                                                               +'|urn:despachosSicamIntf-IdespachosSicam#despachosUruguay'
                                                               +'|urn:despachosSicamIntf-IdespachosSicam#DESPACHOSxmlToLs'
                                                               +'|urn:despachosSicamIntf-IdespachosSicam#FALTANTESxmlToLs'
                                                               +'|urn:despachosSicamIntf-IdespachosSicam#DifLsALsB'
                                                               );
  RemClassRegistry.RegisterXSClass(TFECHA, 'urn:despachosSicamIntf', 'TFECHA');
  RemClassRegistry.RegisterXSClass(TRESULTADO, 'urn:despachosSicamIntf', 'TRESULTADO');
  RemClassRegistry.RegisterXSClass(TDESPCHILES, 'urn:despachosSicamIntf', 'TDESPCHILES');
  RemClassRegistry.RegisterXSClass(TXML, 'urn:despachosSicamIntf', 'TXML');
  RemClassRegistry.RegisterXSClass(TLS, 'urn:despachosSicamIntf', 'TLS');

end. 