// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.192.152/cgi-bin/wsLlamadorAA2000/wsLlamadorAA2000/wsdl/IwsLLamadorAA2000B
// Version  : 1.0
// (22/02/2021 14:38:34 - 1.33.2.5)
// ************************************************************************ //

unit IwsLLamadorAA2000B5;

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

  TData                = class;                 { "urn:wsLLamadorAA2000BIntf" }
  TTurno               = class;                 { "urn:wsLLamadorAA2000BIntf" }
  TRespuesta           = class;                 { "urn:wsLLamadorAA2000BIntf" }
  TCOLAS               = class;                 { "urn:wsLLamadorAA2000BIntf" }



  // ************************************************************************ //
  // Namespace : urn:wsLLamadorAA2000BIntf
  // ************************************************************************ //
  TData = class(TRemotable)
  private
    FID_COLA: WideString;
    FBOX: WideString;
    FLETRA: WideString;
  published
    property ID_COLA: WideString read FID_COLA write FID_COLA;
    property BOX: WideString read FBOX write FBOX;
    property LETRA: WideString read FLETRA write FLETRA;
  end;



  // ************************************************************************ //
  // Namespace : urn:wsLLamadorAA2000BIntf
  // ************************************************************************ //
  TTurno = class(TRemotable)
  private
    FERROR: WideString;
    FDESCRIPCION: WideString;
    FID_COLA: WideString;
    FID_TURNO: WideString;
    FBOX: WideString;
    FLETRA: WideString;
    FORDEN: WideString;
    FXDIA_COLA: WideString;
    FXINI_COLA: WideString;
    FXSTAR_COLA: WideString;
    FCANT_RELLAMAR: WideString;
  published
    property ERROR: WideString read FERROR write FERROR;
    property DESCRIPCION: WideString read FDESCRIPCION write FDESCRIPCION;
    property ID_COLA: WideString read FID_COLA write FID_COLA;
    property ID_TURNO: WideString read FID_TURNO write FID_TURNO;
    property BOX: WideString read FBOX write FBOX;
    property LETRA: WideString read FLETRA write FLETRA;
    property ORDEN: WideString read FORDEN write FORDEN;
    property XDIA_COLA: WideString read FXDIA_COLA write FXDIA_COLA;
    property XINI_COLA: WideString read FXINI_COLA write FXINI_COLA;
    property XSTAR_COLA: WideString read FXSTAR_COLA write FXSTAR_COLA;
    property CANT_RELLAMAR: WideString read FCANT_RELLAMAR write FCANT_RELLAMAR;
  end;



  // ************************************************************************ //
  // Namespace : urn:wsLLamadorAA2000BIntf
  // ************************************************************************ //
  TRespuesta = class(TRemotable)
  private
    FERROR: WideString;
    FDESCRIPCION: WideString;
  published
    property ERROR: WideString read FERROR write FERROR;
    property DESCRIPCION: WideString read FDESCRIPCION write FDESCRIPCION;
  end;



  // ************************************************************************ //
  // Namespace : urn:wsLLamadorAA2000BIntf
  // ************************************************************************ //
  TCOLAS = class(TRemotable)
  private
    FID_COLA: WideString;
    FNOMBRE: WideString;
    FLUGAR: WideString;
    FLETRA: WideString;
  published
    property ID_COLA: WideString read FID_COLA write FID_COLA;
    property NOMBRE: WideString read FNOMBRE write FNOMBRE;
    property LUGAR: WideString read FLUGAR write FLUGAR;
    property LETRA: WideString read FLETRA write FLETRA;
  end;

  TArrayColas = array of TCOLAS;                { "urn:wsLLamadorAA2000BIntf" }

  // ************************************************************************ //
  // Namespace : urn:wsLLamadorAA2000BIntf-IwsLLamadorAA2000B
  // soapAction: urn:wsLLamadorAA2000BIntf-IwsLLamadorAA2000B#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IwsLLamadorAA2000Bbinding
  // service   : IwsLLamadorAA2000Bservice
  // port      : IwsLLamadorAA2000BPort
  // URL       : http://172.16.192.152/cgi-bin/wsLlamadorAA2000/wsLlamadorAA2000/soap/IwsLLamadorAA2000B
  // ************************************************************************ //
  IwsLLamadorAA2000B = interface(IInvokable)
  ['{1AA9DE18-7AAB-63F1-F394-FF1E7C968D71}']
    function  Call(const Data: TData): TTurno; stdcall;
    function  ReCall(const Turno: TTurno): TRespuesta; stdcall;
    function  Finish(const Turno: TTurno): TRespuesta; stdcall;
    function  QueuesList: TArrayColas; stdcall;
  end;

function GetIwsLLamadorAA2000B(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IwsLLamadorAA2000B;


implementation

function GetIwsLLamadorAA2000B(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IwsLLamadorAA2000B;
const
  defWSDL = 'http://172.16.192.152/cgi-bin/wsLlamadorAA2000/wsLlamadorAA2000/wsdl/IwsLLamadorAA2000B';
  defURL  = 'http://172.16.192.152/cgi-bin/wsLlamadorAA2000/wsLlamadorAA2000/soap/IwsLLamadorAA2000B';
  defSvc  = 'IwsLLamadorAA2000Bservice';
  defPrt  = 'IwsLLamadorAA2000BPort';
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
    Result := (RIO as IwsLLamadorAA2000B);
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
  InvRegistry.RegisterInterface(TypeInfo(IwsLLamadorAA2000B), 'urn:wsLLamadorAA2000BIntf-IwsLLamadorAA2000B', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IwsLLamadorAA2000B), 'urn:wsLLamadorAA2000BIntf-IwsLLamadorAA2000B#%operationName%');
  RemClassRegistry.RegisterXSClass(TData, 'urn:wsLLamadorAA2000BIntf', 'TData');
  RemClassRegistry.RegisterXSClass(TTurno, 'urn:wsLLamadorAA2000BIntf', 'TTurno');
  RemClassRegistry.RegisterXSClass(TRespuesta, 'urn:wsLLamadorAA2000BIntf', 'TRespuesta');
  RemClassRegistry.RegisterXSClass(TCOLAS, 'urn:wsLLamadorAA2000BIntf', 'TCOLAS');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TArrayColas), 'urn:wsLLamadorAA2000BIntf', 'TArrayColas');

end. 