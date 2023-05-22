// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.192.152/cgi-bin/wsLlamadorAA2000/wsLlamadorAA2000/wsdl/IwsLlamadorAA200
// Version  : 1.0
// (02/02/2021 10:22:20 - 1.33.2.5)
// ************************************************************************ //

unit IwsLlamadorAA2001;

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
  // !:int             - "http://www.w3.org/2001/XMLSchema"

  TDatosEntrada        = class;                 { "urn:wsLlamadorAA200Intf" }
  TTurnoInfo           = class;                 { "urn:wsLlamadorAA200Intf" }
  TDatosSalida         = class;                 { "urn:wsLlamadorAA200Intf" }



  // ************************************************************************ //
  // Namespace : urn:wsLlamadorAA200Intf
  // ************************************************************************ //
  TDatosEntrada = class(TRemotable)
  private
    FCOLA: WideString;
    FPUESTO: WideString;
    FLETRA: WideString;
  published
    property COLA: WideString read FCOLA write FCOLA;
    property PUESTO: WideString read FPUESTO write FPUESTO;
    property LETRA: WideString read FLETRA write FLETRA;
  end;



  // ************************************************************************ //
  // Namespace : urn:wsLlamadorAA200Intf
  // ************************************************************************ //
  TTurnoInfo = class(TRemotable)
  private
    FidQueue: WideString;
    FidQueueShift: WideString;
    FidParentQueue: WideString;
    Fplace: WideString;
    Freason: WideString;
    Fletter: WideString;
    FidNumber: Integer;
  published
    property idQueue: WideString read FidQueue write FidQueue;
    property idQueueShift: WideString read FidQueueShift write FidQueueShift;
    property idParentQueue: WideString read FidParentQueue write FidParentQueue;
    property place: WideString read Fplace write Fplace;
    property reason: WideString read Freason write Freason;
    property letter: WideString read Fletter write Fletter;
    property idNumber: Integer read FidNumber write FidNumber;
  end;



  // ************************************************************************ //
  // Namespace : urn:wsLlamadorAA200Intf
  // ************************************************************************ //
  TDatosSalida = class(TRemotable)
  private
    FERROR: WideString;
    FDESCRIPCION: WideString;
    FTURNO: TTurnoInfo;
  public
    destructor Destroy; override;
  published
    property ERROR: WideString read FERROR write FERROR;
    property DESCRIPCION: WideString read FDESCRIPCION write FDESCRIPCION;
    property TURNO: TTurnoInfo read FTURNO write FTURNO;
  end;


  // ************************************************************************ //
  // Namespace : urn:wsLlamadorAA200Intf-IwsLlamadorAA200
  // soapAction: urn:wsLlamadorAA200Intf-IwsLlamadorAA200#ConcederTurno
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IwsLlamadorAA200binding
  // service   : IwsLlamadorAA200service
  // port      : IwsLlamadorAA200Port
  // URL       : http://172.16.192.152/cgi-bin/wsLlamadorAA2000/wsLlamadorAA2000/soap/IwsLlamadorAA200
  // ************************************************************************ //
  IwsLlamadorAA200 = interface(IInvokable)
  ['{ED065AE6-372D-53D2-4F3C-9EA07BA380FA}']
    function  ConcederTurno(const Data: TDatosEntrada): TDatosSalida; stdcall;
  end;

function GetIwsLlamadorAA200(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IwsLlamadorAA200;


implementation

function GetIwsLlamadorAA200(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IwsLlamadorAA200;
const
  defWSDL = 'http://172.16.192.152/cgi-bin/wsLlamadorAA2000/wsLlamadorAA2000/wsdl/IwsLlamadorAA200';
           //http://172.16.192.152/cgi-bin/wsLlamadorAA2000/wsLlamadorAA2000/wsdl/IwsLlamadorAA2000
  defURL  = 'http://172.16.192.152/cgi-bin/wsLlamadorAA2000/wsLlamadorAA2000/soap/IwsLlamadorAA200';
  defSvc  = 'IwsLlamadorAA200service';
  defPrt  = 'IwsLlamadorAA200Port';
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
    Result := (RIO as IwsLlamadorAA200);
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


destructor TDatosSalida.Destroy;
begin
  if Assigned(FTURNO) then
    FTURNO.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(IwsLlamadorAA200), 'urn:wsLlamadorAA200Intf-IwsLlamadorAA200', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IwsLlamadorAA200), 'urn:wsLlamadorAA200Intf-IwsLlamadorAA200#ConcederTurno');
  RemClassRegistry.RegisterXSClass(TDatosEntrada, 'urn:wsLlamadorAA200Intf', 'TDatosEntrada');
  RemClassRegistry.RegisterXSClass(TTurnoInfo, 'urn:wsLlamadorAA200Intf', 'TTurnoInfo');
  RemClassRegistry.RegisterXSClass(TDatosSalida, 'urn:wsLlamadorAA200Intf', 'TDatosSalida');

end. 