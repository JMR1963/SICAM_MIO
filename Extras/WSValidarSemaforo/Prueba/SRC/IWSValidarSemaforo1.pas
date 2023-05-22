// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.192.151/cgi-bin/WSValidarSemaforo/WSValidarSemaforo/wsdl/IWSValidarSemaforo
// Encoding : utf-8
// Version  : 1.0
// (29/03/2016 04:20:54 p.m. - 1.33.2.5)
// ************************************************************************ //

unit IWSValidarSemaforo1;

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

  TDatosEntrada        = class;                 { "urn:WSValidarSemaforoIntf" }



  // ************************************************************************ //
  // Namespace : urn:WSValidarSemaforoIntf
  // ************************************************************************ //
  TDatosEntrada = class(TRemotable)
  private
    FCodigoPaisEmisor: WideString;
    FNumeroDocumento: WideString;
    FFlag: WideString;
    FObservacion: WideString;
    FFuncionario: WideString;
  published
    property CodigoPaisEmisor: WideString read FCodigoPaisEmisor write FCodigoPaisEmisor;
    property NumeroDocumento: WideString read FNumeroDocumento write FNumeroDocumento;
    property Flag: WideString read FFlag write FFlag;
    property Observacion: WideString read FObservacion write FObservacion;
    property Funcionario: WideString read FFuncionario write FFuncionario;
  end;


  // ************************************************************************ //
  // Namespace : urn:WSValidarSemaforoIntf-IWSValidarSemaforo
  // soapAction: urn:WSValidarSemaforoIntf-IWSValidarSemaforo#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IWSValidarSemaforobinding
  // service   : IWSValidarSemaforoservice
  // port      : IWSValidarSemaforoPort
  // URL       : http://172.16.192.151/cgi-bin/WSValidarSemaforo/WSValidarSemaforo/soap/IWSValidarSemaforo
  // ************************************************************************ //
  IWSValidarSemaforo = interface(IInvokable)
  ['{C2B1183B-4EEB-3102-5B85-7064BB739A50}']
    procedure EnviarRespuesta(const Datos: TDatosEntrada); stdcall;
    function  RecibirRespuesta(const Datos: TDatosEntrada): WideString; stdcall;
  end;

function GetIWSValidarSemaforo(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IWSValidarSemaforo;


implementation

function GetIWSValidarSemaforo(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IWSValidarSemaforo;
const
  defWSDL = 'http://172.16.192.151/cgi-bin/WSValidarSemaforo/WSValidarSemaforo/wsdl/IWSValidarSemaforo';
  defURL  = 'http://172.16.192.151/cgi-bin/WSValidarSemaforo/WSValidarSemaforo/soap/IWSValidarSemaforo';
  defSvc  = 'IWSValidarSemaforoservice';
  defPrt  = 'IWSValidarSemaforoPort';
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
    Result := (RIO as IWSValidarSemaforo);
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
  InvRegistry.RegisterInterface(TypeInfo(IWSValidarSemaforo), 'urn:WSValidarSemaforoIntf-IWSValidarSemaforo', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IWSValidarSemaforo), 'urn:WSValidarSemaforoIntf-IWSValidarSemaforo#%operationName%');
  RemClassRegistry.RegisterXSClass(TDatosEntrada, 'urn:WSValidarSemaforoIntf', 'TDatosEntrada');

end. 