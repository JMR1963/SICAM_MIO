// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.0.31/cgi-bin/puenteInterpol/puenteInterpol/wsdl/IpuenteInterpol
// Version  : 1.0
// (10/06/2016 12:43:53 - 1.33.2.5)
// ************************************************************************ //

unit IpuenteInterpol1;

interface

uses soap.InvokeRegistry, soap.SOAPHTTPClient, system.Types, soap.XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"

  datosConsultaInterpol = class;                { "urn:puenteInterpolIntf" }
  respuestaInterpol    = class;                 { "urn:puenteInterpolIntf" }



  // ************************************************************************ //
  // Namespace : urn:puenteInterpolIntf
  // ************************************************************************ //
  datosConsultaInterpol = class(TRemotable)
  private
    Fnombre: WideString;
    Fapellido: WideString;
    FfechaNacimiento: WideString;
    FtipoDoc: WideString;
    FnroDoc: WideString;
    Fpais: WideString;
    Fgenero: WideString;
    Ftransito: WideString;
    FusuarioNombre: WideString;
    FusuarioApellido: WideString;
    FusuarioIp: WideString;
    FusuarioDepen: WideString;
    FusuarioDepenId: WideString;
    FusuarioTipoDoc: WideString;
    FusuarioDoc: WideString;
    FusuarioJerarquia: WideString;
    Fusuario: WideString;
  published
    property nombre: WideString read Fnombre write Fnombre;
    property apellido: WideString read Fapellido write Fapellido;
    property fechaNacimiento: WideString read FfechaNacimiento write FfechaNacimiento;
    property tipoDoc: WideString read FtipoDoc write FtipoDoc;
    property nroDoc: WideString read FnroDoc write FnroDoc;
    property pais: WideString read Fpais write Fpais;
    property genero: WideString read Fgenero write Fgenero;
    property transito: WideString read Ftransito write Ftransito;
    property usuarioNombre: WideString read FusuarioNombre write FusuarioNombre;
    property usuarioApellido: WideString read FusuarioApellido write FusuarioApellido;
    property usuarioIp: WideString read FusuarioIp write FusuarioIp;
    property usuarioDepen: WideString read FusuarioDepen write FusuarioDepen;
    property usuarioDepenId: WideString read FusuarioDepenId write FusuarioDepenId;
    property usuarioTipoDoc: WideString read FusuarioTipoDoc write FusuarioTipoDoc;
    property usuarioDoc: WideString read FusuarioDoc write FusuarioDoc;
    property usuarioJerarquia: WideString read FusuarioJerarquia write FusuarioJerarquia;
    property usuario: WideString read Fusuario write Fusuario;
  end;



  // ************************************************************************ //
  // Namespace : urn:puenteInterpolIntf
  // ************************************************************************ //
  respuestaInterpol = class(TRemotable)
  private
    FCOD_DETALLE_RTA: WideString;
    FCOD_RTA: WideString;
    FCOLOR: WideString;
  published
    property COD_DETALLE_RTA: WideString read FCOD_DETALLE_RTA write FCOD_DETALLE_RTA;
    property COD_RTA: WideString read FCOD_RTA write FCOD_RTA;
    property COLOR: WideString read FCOLOR write FCOLOR;
  end;


  // ************************************************************************ //
  // Namespace : urn:puenteInterpolIntf-IpuenteInterpol
  // soapAction: urn:puenteInterpolIntf-IpuenteInterpol#ConsultaInterpol
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IpuenteInterpolbinding
  // service   : IpuenteInterpolservice
  // port      : IpuenteInterpolPort
  // URL       : http://172.16.0.31/cgi-bin/puenteInterpol/puenteInterpol/soap/IpuenteInterpol
  // ************************************************************************ //
  IpuenteInterpol = interface(IInvokable)
  ['{75B0BB80-C565-162D-5EC1-B20CFA8A2020}']
    function  ConsultaInterpol(const datos: datosConsultaInterpol): respuestaInterpol; stdcall;
  end;

function GetIpuenteInterpol(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IpuenteInterpol;


implementation

function GetIpuenteInterpol(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IpuenteInterpol;
const
//  defWSDL = 'http://172.16.0.31/cgi-bin/puenteInterpol/puenteInterpol/wsdl/IpuenteInterpol';
//  defURL  = 'http://172.16.0.31/cgi-bin/puenteInterpol/puenteInterpol/soap/IpuenteInterpol';
  defWSDL = '';
  defURL  = '';
  defSvc  = 'IpuenteInterpolservice';
  defPrt  = 'IpuenteInterpolPort';
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
    Result := (RIO as IpuenteInterpol);
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
  InvRegistry.RegisterInterface(TypeInfo(IpuenteInterpol), 'urn:puenteInterpolIntf-IpuenteInterpol', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IpuenteInterpol), 'urn:puenteInterpolIntf-IpuenteInterpol#ConsultaInterpol');
  RemClassRegistry.RegisterXSClass(datosConsultaInterpol, 'urn:puenteInterpolIntf', 'datosConsultaInterpol');
  RemClassRegistry.RegisterXSClass(respuestaInterpol, 'urn:puenteInterpolIntf', 'respuestaInterpol');

end. 