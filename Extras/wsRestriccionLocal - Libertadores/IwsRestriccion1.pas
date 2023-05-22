// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.192.151/cgi-bin/wsRestriccion/wsRestriccion/wsdl/IwsRestriccion
// Encoding : utf-8
// Version  : 1.0
// (09/05/2014 10:20:18 a.m. - 1.33.2.5)
// ************************************************************************ //

unit IwsRestriccion1;

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
  // !:double          - "http://www.w3.org/2001/XMLSchema"


  // ************************************************************************ //
  // Namespace : urn:wsRestriccionIntf-IwsRestriccion
  // soapAction: urn:wsRestriccionIntf-IwsRestriccion#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IwsRestriccionbinding
  // service   : IwsRestriccionservice
  // port      : IwsRestriccionPort
  // URL       : http://172.16.192.151/cgi-bin/wsRestriccion/wsRestriccion/soap/IwsRestriccion
  // ************************************************************************ //



  TRespuesta = class(TRemotable)
  private
    FRestriccion: AnsiString;
    FTransporte: AnsiString;
  published
    property Restriccion: AnsiString read FRestriccion write FRestriccion;
    property Transporte: AnsiString read FTransporte write FTransporte;
  end;


  IwsRestriccion = interface(IInvokable)
  ['{EB219DA4-239F-B09C-A8D6-DD790734174F}']
    function buscarRestricciones(Ape1lidos, Nombres, fechaNac, nroDoc,nrolibreta:string): TRespuesta; stdcall;
  end;

  
function GetIwsRestriccion(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IwsRestriccion;


implementation

uses utest;


function GetIwsRestriccion(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IwsRestriccion;

var
  defWSDL:String;
  defURL:String;
  defSvc:String;
  defPrt:String;

  RIO: THTTPRIO;
begin

  defWSDL := 'http://'+Form1.Edit1.Text+'/cgi-bin/wsRestriccion/wsRestriccion/wsdl/IwsRestriccion';
  defURL  := 'http://'+Form1.Edit1.Text+'/cgi-bin/wsRestriccion/wsRestriccion/soap/IwsRestriccion';
  defSvc  := 'IwsRestriccionservice';
  defPrt  := 'IwsRestriccionPort';

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
    Result := (RIO as IwsRestriccion);
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
  InvRegistry.RegisterInterface(TypeInfo(IwsRestriccion), 'urn:wsRestriccionIntf-IwsRestriccion', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IwsRestriccion), 'urn:wsRestriccionIntf-IwsRestriccion#%operationName%');

end. 