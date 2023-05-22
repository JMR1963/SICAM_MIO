// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.1.127.5/PFA_INTI_WS/API/DNM_INTI_WSService.wsdl
//  >Import : http://10.1.127.5/PFA_INTI_WS/API/DNM_INTI_WSService.wsdl>0
//  >Import : http://10.1.127.5/PFA_INTI_WS/API/DNM_INTI_WSService.xsd
// Encoding : UTF-8
// Version  : 1.0
// (30/7/2019 18:44:56 - - $Rev: 69934 $)
// ************************************************************************ //

unit DNM_INTI_WSService;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

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
  // Namespace : http://ws.inti.dnm/
  // soapAction: %operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : DNM_INTI_WSPortBinding
  // service   : DNM_INTI_WSService
  // port      : DNM_INTI_WSPort
  // URL       : http://10.1.150.47/DNM_INTI_WSService
  // ************************************************************************ //
  DNM_INTI_WS = interface(IInvokable)
  ['{C402282F-306B-7CB3-2A3F-61965972E461}']
    function  ConsultaInterpolPersonas(const nombre: string; const apellido: string; const fechaNacimiento: string; const tipoDoc: string; const nroDoc: string; const pais: string;
                                       const genero: string; const transito: string; const fechaConsulta: string; const tipoConsulta: string; const usuarioGenerico: string; 
                                       const passGenerico: string; const usuarioNombre: string; const usuarioApellido: string; const usuarioIp: string; const usuarioDepen: string; 
                                       const usuarioDepenId: string; const usuarioTipoDoc: string; const usuarioDoc: string; const usuarioJerarquia: string; const usuario: string
                                       ): string; stdcall;
    function  LoteInterpolPersonas(const lote: string): string; stdcall;
    function  LoteDocumentos(const lote: string): string; stdcall;
  end;

function GetDNM_INTI_WS(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): DNM_INTI_WS;


implementation
  uses System.SysUtils;

function GetDNM_INTI_WS(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): DNM_INTI_WS;
const
  defWSDL = ''; //'http://10.1.127.5/PFA_INTI_WS/API/DNM_INTI_WSService.wsdl';
  defURL  = ''; //'http://10.1.127.5/DNM_INTI_WSService';

  defSvc  = 'DNM_INTI_WSService';
  defPrt  = 'DNM_INTI_WSPort';
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
    Result := (RIO as DNM_INTI_WS);
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
  { DNM_INTI_WS }
  InvRegistry.RegisterInterface(TypeInfo(DNM_INTI_WS), 'http://ws.inti.dnm/', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(DNM_INTI_WS), '%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(DNM_INTI_WS), ioDocument);
  { DNM_INTI_WS.ConsultaInterpolPersonas }
  InvRegistry.RegisterMethodInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'nombre', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'apellido', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'fechaNacimiento', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'tipoDoc', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'nroDoc', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'pais', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'genero', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'transito', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'fechaConsulta', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'tipoConsulta', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'usuarioGenerico', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'passGenerico', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'usuarioNombre', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'usuarioApellido', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'usuarioIp', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'usuarioDepen', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'usuarioDepenId', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'usuarioTipoDoc', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'usuarioDoc', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'usuarioJerarquia', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'usuario', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'ConsultaInterpolPersonas', 'return', '',
                                '', IS_UNQL);
  { DNM_INTI_WS.LoteInterpolPersonas }
  InvRegistry.RegisterMethodInfo(TypeInfo(DNM_INTI_WS), 'LoteInterpolPersonas', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'LoteInterpolPersonas', 'lote', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'LoteInterpolPersonas', 'return', '',
                                '', IS_UNQL);
  { DNM_INTI_WS.LoteDocumentos }
  InvRegistry.RegisterMethodInfo(TypeInfo(DNM_INTI_WS), 'LoteDocumentos', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'LoteDocumentos', 'lote', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(DNM_INTI_WS), 'LoteDocumentos', 'return', '',
                                '', IS_UNQL);

end.