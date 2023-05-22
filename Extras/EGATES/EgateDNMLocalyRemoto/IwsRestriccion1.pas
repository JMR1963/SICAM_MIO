// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.192.151/cgi-bin/wsimpedimentosargentina/wsimpedimentosargentina/wsdl/IwsRestriccion
// >Import : http://172.16.192.151/cgi-bin/wsimpedimentosargentina/wsimpedimentosargentina/wsdl/IwsRestriccion>0
// Encoding : utf-8
// Version  : 1.0
// (04/06/2019 18:35:30 - - $Rev: 69934 $)
// ************************************************************************ //

unit IwsRestriccion1;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  TRespuesta = class; { "urn:wsRestriccionIntf"[GblCplx] }
  DatosSalida = class; { "urn:wsRestriccionIntf"[GblCplx] }
  DatosEntrada = class; { "urn:wsRestriccionIntf"[GblCplx] }

  // ************************************************************************ //
  // XML       : TRespuesta, global, <complexType>
  // Namespace : urn:wsRestriccionIntf
  // ************************************************************************ //
  TRespuesta = class(TRemotable)
  private
    FRestriccion: string;
    FTransporte: string;
    FTipoPasajero: string;
 //   FInfoExtra: string;
  published
    property Restriccion: string read FRestriccion write FRestriccion;
    property Transporte: string read FTransporte write FTransporte;
    // MATRICULA_MEDIO_TRANSPORTE="EGATES"
    property TipoPasajero: string read FTipoPasajero write FTipoPasajero;
    // TRIPULANTE_PASAJERO="X"/

  //  property InfoExtra: string read FInfoExtra write FInfoExtra;

  end;

  // ************************************************************************ //
  // XML       : DatosSalida, global, <complexType>
  // Namespace : urn:wsRestriccionIntf
  // ************************************************************************ //
  DatosSalida = class(TRemotable)
  private
    FCOD_RTA: string;
    FCOD_DETALLE_RTA: string;
    FOBSERVACIONES: string;
  published
    property COD_RTA: string read FCOD_RTA write FCOD_RTA;
    property COD_DETALLE_RTA: string read FCOD_DETALLE_RTA
      write FCOD_DETALLE_RTA;
    property OBSERVACIONES: string read FOBSERVACIONES write FOBSERVACIONES;
  end;

  // ************************************************************************ //
  // XML       : DatosEntrada, global, <complexType>
  // Namespace : urn:wsRestriccionIntf
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
    property USUARIO: string read FUSUARIO write FUSUARIO;
    property CLAVE: string read FCLAVE write FCLAVE;
    property OPERADOR: string read FOPERADOR write FOPERADOR;
    property CODPAIS: string read FCODPAIS write FCODPAIS;
    property NOMBRE1: string read FNOMBRE1 write FNOMBRE1;
    property NOMBRE2: string read FNOMBRE2 write FNOMBRE2;
    property APELLIDO1: string read FAPELLIDO1 write FAPELLIDO1;
    property APELLIDO2: string read FAPELLIDO2 write FAPELLIDO2;
    property NUMDOC: string read FNUMDOC write FNUMDOC;
    property PUESTOCONTROL: string read FPUESTOCONTROL write FPUESTOCONTROL;
    property TIPODOC: string read FTIPODOC write FTIPODOC;
    property EMISORDOC: string read FEMISORDOC write FEMISORDOC;
    property FECHANAC: string read FFECHANAC write FFECHANAC;
    property GENERO: string read FGENERO write FGENERO;
    property NACIONALIDAD: string read FNACIONALIDAD write FNACIONALIDAD;
    property NUMEROIDENIFICACION: string read FNUMEROIDENIFICACION
      write FNUMEROIDENIFICACION;
    property PASO: string read FPASO write FPASO;
  end;

  // ************************************************************************ //
  // Namespace : urn:wsRestriccionIntf-IwsRestriccion
  // soapAction: urn:wsRestriccionIntf-IwsRestriccion#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : IwsRestriccionbinding
  // service   : IwsRestriccionservice
  // port      : IwsRestriccionPort
  // URL       : http://172.16.192.151/cgi-bin/wsimpedimentosargentina/wsimpedimentosargentina/soap/IwsRestriccion
  // ************************************************************************ //
  IwsRestriccion = interface(IInvokable)
    ['{EB219DA4-239F-B09C-A8D6-DD790734174F}']
    function buscarRestricciones(const Apellidos: string; const Nombres: string;
      const FECHANAC: string; const nroDoc: string; const nrolibreta: string;
      const GENERO: string; const TIPODOC: string; const paisEmisorDoc: string;
      const NACIONALIDAD: string;const fechaVTO: string): TRespuesta; stdcall;
    function ConsultaImpedimentosArgentina(const consulta: DatosEntrada)
      : DatosSalida; stdcall;
  end;

function GetIwsRestriccion2(Addr: string = '';HTTPRIO: THTTPRIO = nil): IwsRestriccion;

implementation

uses System.SysUtils, uGlobal;

function GetIwsRestriccion2(Addr: string; HTTPRIO: THTTPRIO)
  : IwsRestriccion;
const
  defSvc = 'IwsRestriccionservice';
  defPrt = 'IwsRestriccionPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;

  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try

    THTTPRIO(RIO).HTTPWebNode.ConnectTimeout := 6000 * 2;
    THTTPRIO(RIO).HTTPWebNode.SendTimeout := 6000 * 2;
    THTTPRIO(RIO).HTTPWebNode.ReceiveTimeout := 6000 * 2;

    Result := (RIO as IwsRestriccion);
    if false then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end
    else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;

initialization

{ IwsRestriccion }
InvRegistry.RegisterInterface(TypeInfo(IwsRestriccion),
  'urn:wsRestriccionIntf-IwsRestriccion', 'utf-8');
InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IwsRestriccion),
  'urn:wsRestriccionIntf-IwsRestriccion#%operationName%');
RemClassRegistry.RegisterXSClass(TRespuesta, 'urn:wsRestriccionIntf',
  'TRespuesta');
RemClassRegistry.RegisterXSClass(DatosSalida, 'urn:wsRestriccionIntf',
  'DatosSalida');
RemClassRegistry.RegisterXSClass(DatosEntrada, 'urn:wsRestriccionIntf',
  'DatosEntrada');

end.
