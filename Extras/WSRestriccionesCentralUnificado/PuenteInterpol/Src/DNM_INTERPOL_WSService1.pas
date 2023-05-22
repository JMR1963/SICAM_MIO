// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://server04.soflex.com.ar:88/DNM_WS/DNM_INTERPOL_WSService?WSDL
//  >Import : http://server04.soflex.com.ar:88/DNM_WS/DNM_INTERPOL_WSService?WSDL>0
//  >Import : http://server04.soflex.com.ar:88/DNM_WS/DNM_INTERPOL_WSService?xsd=1
// Encoding : UTF-8
// Codegen  : [wfForceSOAP11+]
// Version  : 1.0
// (10/06/2016 00:54:49 - - $Rev: 69934 $)
// ************************************************************************ //

unit DNM_INTERPOL_WSService1;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns, ufixWs;

const
  IS_OPTN = $0001;
  IS_UNQL = $0008;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]



  // ************************************************************************ //
  // Namespace : http://ws.interpol.dnm/
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : DNM_INTERPOL_WSPortBinding
  // service   : DNM_INTERPOL_WSService
  // port      : DNM_INTERPOL_WSPort
  // URL       : http://server04.soflex.com.ar:88/DNM_WS/DNM_INTERPOL_WSService
  // ************************************************************************ //
  DNM_INTERPOL_WS = interface(IInvokable)
  ['{0C0A02A2-590C-7DAB-888A-81B42D2FF90A}']
    function  ConsultaInterpolPersonas(const nombre: string; const apellido: string; const fechaNacimiento: string; const tipoDoc: string; const nroDoc: string; const pais: string; 
                                       const genero: string; const transito: string; const usuarioGenerico: string; const passGenerico: string; const usuarioNombre: string; 
                                       const usuarioApellido: string; const usuarioIp: string; const usuarioDepen: string; const usuarioDepenId: string; const usuarioTipoDoc: string; 
                                       const usuarioDoc: string; const usuarioJerarquia: string; const usuario: string): string; stdcall;
    procedure init_static_members; stdcall;
  end;

function GetDNM_INTERPOL_WS(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): DNM_INTERPOL_WS;


implementation
  uses System.SysUtils;

function GetDNM_INTERPOL_WS(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): DNM_INTERPOL_WS;
const
  defWSDL = '';//'http://server04.soflex.com.ar:88/DNM_WS/DNM_INTERPOL_WSService?WSDL';
  defURL  = '';//'http://server04.soflex.com.ar:88/DNM_WS/DNM_INTERPOL_WSService';
  defSvc  = 'DNM_INTERPOL_WSService';
  defPrt  = 'DNM_INTERPOL_WSPort';
var
  RIO: THTTPRIO;
  d : twsdemora;
begin
  Result := nil;
  d := TWSDemora.Create;
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
    rio.HTTPWebNode.OnBeforePost :=   d.configureHttpRequest;
    Result := (RIO as DNM_INTERPOL_WS);
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
  { DNM_INTERPOL_WS }
  InvRegistry.RegisterInterface(TypeInfo(DNM_INTERPOL_WS), 'http://ws.interpol.dnm/', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(DNM_INTERPOL_WS), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(DNM_INTERPOL_WS), ioDocument);
  { DNM_INTERPOL_WS.ConsultaInterpolPersonas }
  InvRegistry.RegisterMethodInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'nombre', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'apellido', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'fechaNacimiento', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'tipoDoc', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'nroDoc', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'pais', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'genero', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'transito', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'usuarioGenerico', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'passGenerico', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'usuarioNombre', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'usuarioApellido', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'usuarioIp', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'usuarioDepen', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'usuarioDepenId', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'usuarioTipoDoc', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'usuarioDoc', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'usuarioJerarquia', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'usuario', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTERPOL_WS), 'ConsultaInterpolPersonas', 'return', '',
                                '', IS_UNQL);

end.