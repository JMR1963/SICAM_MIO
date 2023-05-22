// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://localhost:8083/wsdl/IWsRA
//  >Import : http://localhost:8083/wsdl/IWsRA>0
// Version  : 1.0
// (14/7/2022 14:33:47 - - $Rev: 103843 $)
// ************************************************************************ //

unit IWsRA1;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  DatosEntrada         = class;                 { "urn:WsRAIntf"[GblCplx] }
  DatosSalida          = class;                 { "urn:WsRAIntf"[GblCplx] }
  TRespuesta           = class;                 { "urn:WsRAIntf"[GblCplx] }



  // ************************************************************************ //
  // XML       : DatosEntrada, global, <complexType>
  // Namespace : urn:WsRAIntf
  // ************************************************************************ //
  DatosEntrada = class(TRemotable)
  private
    FUSUARIO: string;
    FCLAVE: string;
    FOPERADOR: string;
    FCODPAIS: string;
    FNOMBRE1: string;
    FNOMBRE2: string;
    FAPELLIDO1: string;
    FAPELLIDO2: string;
    FNUMDOC: string;
    FPUESTOCONTROL: string;
    FTIPODOC: string;
    FEMISORDOC: string;
    FFECHANAC: string;
    FGENERO: string;
    FNACIONALIDAD: string;
    FNUMEROIDENIFICACION: string;
    FPASO: string;
  published
    property USUARIO:             string  read FUSUARIO write FUSUARIO;
    property CLAVE:               string  read FCLAVE write FCLAVE;
    property OPERADOR:            string  read FOPERADOR write FOPERADOR;
    property CODPAIS:             string  read FCODPAIS write FCODPAIS;
    property NOMBRE1:             string  read FNOMBRE1 write FNOMBRE1;
    property NOMBRE2:             string  read FNOMBRE2 write FNOMBRE2;
    property APELLIDO1:           string  read FAPELLIDO1 write FAPELLIDO1;
    property APELLIDO2:           string  read FAPELLIDO2 write FAPELLIDO2;
    property NUMDOC:              string  read FNUMDOC write FNUMDOC;
    property PUESTOCONTROL:       string  read FPUESTOCONTROL write FPUESTOCONTROL;
    property TIPODOC:             string  read FTIPODOC write FTIPODOC;
    property EMISORDOC:           string  read FEMISORDOC write FEMISORDOC;
    property FECHANAC:            string  read FFECHANAC write FFECHANAC;
    property GENERO:              string  read FGENERO write FGENERO;
    property NACIONALIDAD:        string  read FNACIONALIDAD write FNACIONALIDAD;
    property NUMEROIDENIFICACION: string  read FNUMEROIDENIFICACION write FNUMEROIDENIFICACION;
    property PASO:                string  read FPASO write FPASO;
  end;



  // ************************************************************************ //
  // XML       : DatosSalida, global, <complexType>
  // Namespace : urn:WsRAIntf
  // ************************************************************************ //
  DatosSalida = class(TRemotable)
  private
    FCOD_RTA: string;
    FCOD_DETALLE_RTA: string;
    FOBSERVACIONES: string;
  published
    property COD_RTA:         string  read FCOD_RTA write FCOD_RTA;
    property COD_DETALLE_RTA: string  read FCOD_DETALLE_RTA write FCOD_DETALLE_RTA;
    property OBSERVACIONES:   string  read FOBSERVACIONES write FOBSERVACIONES;
  end;



  // ************************************************************************ //
  // XML       : TRespuesta, global, <complexType>
  // Namespace : urn:WsRAIntf
  // ************************************************************************ //
  TRespuesta = class(TRemotable)
  private
    FRestriccion: string;
    FTransporte: string;
    FTipoPasajero: string;
  published
    property Restriccion:  string  read FRestriccion write FRestriccion;
    property Transporte:   string  read FTransporte write FTransporte;
    property TipoPasajero: string  read FTipoPasajero write FTipoPasajero;
  end;


  // ************************************************************************ //
  // Namespace : urn:WsRAIntf-IWsRA
  // soapAction: urn:WsRAIntf-IWsRA#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : IWsRAbinding
  // service   : IWsRAservice
  // port      : IWsRAPort
  // URL       : http://localhost:8083/soap/IWsRA
  // ************************************************************************ //
  IWsRA = interface(IInvokable)
  ['{59EA2CFF-3945-AC3D-E06F-9F607149736A}']
    function  buscarRestricciones(const Apellidos: string; const Nombres: string; const fechaNac: string; const nroDoc: string; const nrolibreta: string; const genero: string;
                                  const tipoDoc: string; const paisEmisorDoc: string; const nacionalidad: string; const fechaVTO: string;const sentidoES: String): TRespuesta; stdcall;
    function  ConsultaImpedimentosArgentina(const consulta: DatosEntrada): DatosSalida; stdcall;
  end;

function GetIWsRA(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IWsRA;


implementation
  uses System.SysUtils;

function GetIWsRA(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IWsRA;
const
  defWSDL = 'http://127.0.0.1:8083/wsdl/IWsRA';
  defURL  = 'http://127.0.0.1:8083/soap/IWsRA';
  defSvc  = 'IWsRAservice';
  defPrt  = 'IWsRAPort';
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
    Result := (RIO as IWsRA);
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
  { IWsRA }
  InvRegistry.RegisterInterface(TypeInfo(IWsRA), 'urn:WsRAIntf-IWsRA', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IWsRA), 'urn:WsRAIntf-IWsRA#%operationName%');
  RemClassRegistry.RegisterXSClass(DatosEntrada, 'urn:WsRAIntf', 'DatosEntrada');
  RemClassRegistry.RegisterXSClass(DatosSalida, 'urn:WsRAIntf', 'DatosSalida');
  RemClassRegistry.RegisterXSClass(TRespuesta, 'urn:WsRAIntf', 'TRespuesta');

end.