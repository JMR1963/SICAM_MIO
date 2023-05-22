// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://190.226.229.142:8888/WSDNM/services/ServicioConsulta?wsdl
//  >Import : http://190.226.229.142:8888/WSDNM/services/ServicioConsulta?wsdl>0
//  >Import : http://190.226.229.142:8888/WSDNM/services/ServicioConsulta?wsdl>1
//  >Import : http://190.226.229.142:8888/WSDNM/services/ServicioConsulta?wsdl>2
// Encoding : UTF-8
// Version  : 1.0
// (25/6/2018 16:25:45 - - $Rev: 69934 $)
// ************************************************************************ //

unit ServicioConsulta;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_NLBL = $0004;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  ConsultarServicioMaritimoResponse = class;    { "http://transport.buquebus.com/xsd"[GblCplx] }
  Persona              = class;                 { "http://model.buquebus.com/xsd"[GblCplx] }
  ConsultarServicioMaritimoRequest = class;     { "http://transport.buquebus.com/xsd"[GblCplx] }
  ServicioMaritimo     = class;                 { "http://model.buquebus.com/xsd"[GblCplx] }
  Resultado            = class;                 { "http://model.buquebus.com/xsd"[GblCplx] }
  Error                = class;                 { "http://model.buquebus.com/xsd"[GblCplx] }



  // ************************************************************************ //
  // XML       : ConsultarServicioMaritimoResponse, global, <complexType>
  // Namespace : http://transport.buquebus.com/xsd
  // ************************************************************************ //
  ConsultarServicioMaritimoResponse = class(TRemotable)
  private
    Ferror: Error;
    Ferror_Specified: boolean;
    Fresultado: Resultado;
    Fresultado_Specified: boolean;
    FservicioMaritimo: ServicioMaritimo;
    FservicioMaritimo_Specified: boolean;
    procedure Seterror(Index: Integer; const AError: Error);
    function  error_Specified(Index: Integer): boolean;
    procedure Setresultado(Index: Integer; const AResultado: Resultado);
    function  resultado_Specified(Index: Integer): boolean;
    procedure SetservicioMaritimo(Index: Integer; const AServicioMaritimo: ServicioMaritimo);
    function  servicioMaritimo_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property error:            Error             Index (IS_OPTN or IS_NLBL) read Ferror write Seterror stored error_Specified;
    property resultado:        Resultado         Index (IS_OPTN or IS_NLBL) read Fresultado write Setresultado stored resultado_Specified;
    property servicioMaritimo: ServicioMaritimo  Index (IS_OPTN or IS_NLBL) read FservicioMaritimo write SetservicioMaritimo stored servicioMaritimo_Specified;
  end;



  // ************************************************************************ //
  // XML       : Persona, global, <complexType>
  // Namespace : http://model.buquebus.com/xsd
  // ************************************************************************ //
  Persona = class(TRemotable)
  private
    Fapellido1: string;
    Fapellido1_Specified: boolean;
    Fapellido2: string;
    Fapellido2_Specified: boolean;
    FfechaNac: string;
    FfechaNac_Specified: boolean;
    Fnombres1: string;
    Fnombres1_Specified: boolean;
    Fnombres2: string;
    Fnombres2_Specified: boolean;
    FnroDoc: string;
    FnroDoc_Specified: boolean;
    FnroLibreta: string;
    FnroLibreta_Specified: boolean;
    procedure Setapellido1(Index: Integer; const Astring: string);
    function  apellido1_Specified(Index: Integer): boolean;
    procedure Setapellido2(Index: Integer; const Astring: string);
    function  apellido2_Specified(Index: Integer): boolean;
    procedure SetfechaNac(Index: Integer; const Astring: string);
    function  fechaNac_Specified(Index: Integer): boolean;
    procedure Setnombres1(Index: Integer; const Astring: string);
    function  nombres1_Specified(Index: Integer): boolean;
    procedure Setnombres2(Index: Integer; const Astring: string);
    function  nombres2_Specified(Index: Integer): boolean;
    procedure SetnroDoc(Index: Integer; const Astring: string);
    function  nroDoc_Specified(Index: Integer): boolean;
    procedure SetnroLibreta(Index: Integer; const Astring: string);
    function  nroLibreta_Specified(Index: Integer): boolean;
  published
    property apellido1:  string  Index (IS_OPTN or IS_NLBL) read Fapellido1 write Setapellido1 stored apellido1_Specified;
    property apellido2:  string  Index (IS_OPTN or IS_NLBL) read Fapellido2 write Setapellido2 stored apellido2_Specified;
    property fechaNac:   string  Index (IS_OPTN or IS_NLBL) read FfechaNac write SetfechaNac stored fechaNac_Specified;
    property nombres1:   string  Index (IS_OPTN or IS_NLBL) read Fnombres1 write Setnombres1 stored nombres1_Specified;
    property nombres2:   string  Index (IS_OPTN or IS_NLBL) read Fnombres2 write Setnombres2 stored nombres2_Specified;
    property nroDoc:     string  Index (IS_OPTN or IS_NLBL) read FnroDoc write SetnroDoc stored nroDoc_Specified;
    property nroLibreta: string  Index (IS_OPTN or IS_NLBL) read FnroLibreta write SetnroLibreta stored nroLibreta_Specified;
  end;



  // ************************************************************************ //
  // XML       : ConsultarServicioMaritimoRequest, global, <complexType>
  // Namespace : http://transport.buquebus.com/xsd
  // ************************************************************************ //
  ConsultarServicioMaritimoRequest = class(TRemotable)
  private
    Fpersona: Persona;
    Fpersona_Specified: boolean;
    procedure Setpersona(Index: Integer; const APersona: Persona);
    function  persona_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property persona: Persona  Index (IS_OPTN or IS_NLBL) read Fpersona write Setpersona stored persona_Specified;
  end;



  // ************************************************************************ //
  // XML       : ServicioMaritimo, global, <complexType>
  // Namespace : http://model.buquebus.com/xsd
  // ************************************************************************ //
  ServicioMaritimo = class(TRemotable)
  private
    FnumeroServicioMaritimo: string;
    FnumeroServicioMaritimo_Specified: boolean;
    procedure SetnumeroServicioMaritimo(Index: Integer; const Astring: string);
    function  numeroServicioMaritimo_Specified(Index: Integer): boolean;
  published
    property numeroServicioMaritimo: string  Index (IS_OPTN or IS_NLBL) read FnumeroServicioMaritimo write SetnumeroServicioMaritimo stored numeroServicioMaritimo_Specified;
  end;



  // ************************************************************************ //
  // XML       : Resultado, global, <complexType>
  // Namespace : http://model.buquebus.com/xsd
  // ************************************************************************ //
  Resultado = class(TRemotable)
  private
    Fdescripcion: string;
    Fdescripcion_Specified: boolean;
    Festado: Integer;
    Festado_Specified: boolean;
    procedure Setdescripcion(Index: Integer; const Astring: string);
    function  descripcion_Specified(Index: Integer): boolean;
    procedure Setestado(Index: Integer; const AInteger: Integer);
    function  estado_Specified(Index: Integer): boolean;
  published
    property descripcion: string   Index (IS_OPTN or IS_NLBL) read Fdescripcion write Setdescripcion stored descripcion_Specified;
    property estado:      Integer  Index (IS_OPTN) read Festado write Setestado stored estado_Specified;
  end;



  // ************************************************************************ //
  // XML       : Error, global, <complexType>
  // Namespace : http://model.buquebus.com/xsd
  // ************************************************************************ //
  Error = class(TRemotable)
  private
    Fdescripcion: string;
    Fdescripcion_Specified: boolean;
    Fid: Integer;
    Fid_Specified: boolean;
    procedure Setdescripcion(Index: Integer; const Astring: string);
    function  descripcion_Specified(Index: Integer): boolean;
    procedure Setid(Index: Integer; const AInteger: Integer);
    function  id_Specified(Index: Integer): boolean;
  published
    property descripcion: string   Index (IS_OPTN or IS_NLBL) read Fdescripcion write Setdescripcion stored descripcion_Specified;
    property id:          Integer  Index (IS_OPTN) read Fid write Setid stored id_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://servicios.buquebus.com
  // soapAction: urn:%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : ServicioConsultaSoap11Binding
  // service   : ServicioConsulta
  // port      : ServicioConsultaHttpsSoap11Endpoint
  // URL       : https://190.226.229.142/WSDNM/services/ServicioConsulta.ServicioConsultaHttpsSoap11Endpoint/
  // ************************************************************************ //
  ServicioConsultaPortType = interface(IInvokable)
  ['{5BD8F463-4CE7-A6E4-D99C-1AEB794A7EFD}']
    function  servicioMaritimo(const apellido1: string; const apellido2: string; const nombres1: string; const nombres2: string; const nroDoc: string; const nroLibreta: string; 
                               const fechaNac: string): string; stdcall;
    function  consultarServicioMaritimo(const request: ConsultarServicioMaritimoRequest): ConsultarServicioMaritimoResponse; stdcall;
  end;

function GetServicioConsultaPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ServicioConsultaPortType;


implementation
  uses System.SysUtils;

function GetServicioConsultaPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ServicioConsultaPortType;
const
  //defWSDL = 'http://190.226.229.142:8888/WSDNM/services/ServicioConsulta?wsdl';
  //defURL  = 'http://190.226.229.142:8888/WSDNM/services/ServicioConsulta.ServicioConsultaHttpsSoap11Endpoint/';
  defSvc  = 'ServicioConsulta';
  defPrt  = 'ServicioConsultaHttpsSoap11Endpoint';
var
  RIO: THTTPRIO;
  defWSDL ,  defURL :string;
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



    Result := (RIO as ServicioConsultaPortType);
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


destructor ConsultarServicioMaritimoResponse.Destroy;
begin
  System.SysUtils.FreeAndNil(Ferror);
  System.SysUtils.FreeAndNil(Fresultado);
  System.SysUtils.FreeAndNil(FservicioMaritimo);
  inherited Destroy;
end;

procedure ConsultarServicioMaritimoResponse.Seterror(Index: Integer; const AError: Error);
begin
  Ferror := AError;
  Ferror_Specified := True;
end;

function ConsultarServicioMaritimoResponse.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

procedure ConsultarServicioMaritimoResponse.Setresultado(Index: Integer; const AResultado: Resultado);
begin
  Fresultado := AResultado;
  Fresultado_Specified := True;
end;

function ConsultarServicioMaritimoResponse.resultado_Specified(Index: Integer): boolean;
begin
  Result := Fresultado_Specified;
end;

procedure ConsultarServicioMaritimoResponse.SetservicioMaritimo(Index: Integer; const AServicioMaritimo: ServicioMaritimo);
begin
  FservicioMaritimo := AServicioMaritimo;
  FservicioMaritimo_Specified := True;
end;

function ConsultarServicioMaritimoResponse.servicioMaritimo_Specified(Index: Integer): boolean;
begin
  Result := FservicioMaritimo_Specified;
end;

procedure Persona.Setapellido1(Index: Integer; const Astring: string);
begin
  Fapellido1 := Astring;
  Fapellido1_Specified := True;
end;

function Persona.apellido1_Specified(Index: Integer): boolean;
begin
  Result := Fapellido1_Specified;
end;

procedure Persona.Setapellido2(Index: Integer; const Astring: string);
begin
  Fapellido2 := Astring;
  Fapellido2_Specified := True;
end;

function Persona.apellido2_Specified(Index: Integer): boolean;
begin
  Result := Fapellido2_Specified;
end;

procedure Persona.SetfechaNac(Index: Integer; const Astring: string);
begin
  FfechaNac := Astring;
  FfechaNac_Specified := True;
end;

function Persona.fechaNac_Specified(Index: Integer): boolean;
begin
  Result := FfechaNac_Specified;
end;

procedure Persona.Setnombres1(Index: Integer; const Astring: string);
begin
  Fnombres1 := Astring;
  Fnombres1_Specified := True;
end;

function Persona.nombres1_Specified(Index: Integer): boolean;
begin
  Result := Fnombres1_Specified;
end;

procedure Persona.Setnombres2(Index: Integer; const Astring: string);
begin
  Fnombres2 := Astring;
  Fnombres2_Specified := True;
end;

function Persona.nombres2_Specified(Index: Integer): boolean;
begin
  Result := Fnombres2_Specified;
end;

procedure Persona.SetnroDoc(Index: Integer; const Astring: string);
begin
  FnroDoc := Astring;
  FnroDoc_Specified := True;
end;

function Persona.nroDoc_Specified(Index: Integer): boolean;
begin
  Result := FnroDoc_Specified;
end;

procedure Persona.SetnroLibreta(Index: Integer; const Astring: string);
begin
  FnroLibreta := Astring;
  FnroLibreta_Specified := True;
end;

function Persona.nroLibreta_Specified(Index: Integer): boolean;
begin
  Result := FnroLibreta_Specified;
end;

destructor ConsultarServicioMaritimoRequest.Destroy;
begin
  System.SysUtils.FreeAndNil(Fpersona);
  inherited Destroy;
end;

procedure ConsultarServicioMaritimoRequest.Setpersona(Index: Integer; const APersona: Persona);
begin
  Fpersona := APersona;
  Fpersona_Specified := True;
end;

function ConsultarServicioMaritimoRequest.persona_Specified(Index: Integer): boolean;
begin
  Result := Fpersona_Specified;
end;

procedure ServicioMaritimo.SetnumeroServicioMaritimo(Index: Integer; const Astring: string);
begin
  FnumeroServicioMaritimo := Astring;
  FnumeroServicioMaritimo_Specified := True;
end;

function ServicioMaritimo.numeroServicioMaritimo_Specified(Index: Integer): boolean;
begin
  Result := FnumeroServicioMaritimo_Specified;
end;

procedure Resultado.Setdescripcion(Index: Integer; const Astring: string);
begin
  Fdescripcion := Astring;
  Fdescripcion_Specified := True;
end;

function Resultado.descripcion_Specified(Index: Integer): boolean;
begin
  Result := Fdescripcion_Specified;
end;

procedure Resultado.Setestado(Index: Integer; const AInteger: Integer);
begin
  Festado := AInteger;
  Festado_Specified := True;
end;

function Resultado.estado_Specified(Index: Integer): boolean;
begin
  Result := Festado_Specified;
end;

procedure Error.Setdescripcion(Index: Integer; const Astring: string);
begin
  Fdescripcion := Astring;
  Fdescripcion_Specified := True;
end;

function Error.descripcion_Specified(Index: Integer): boolean;
begin
  Result := Fdescripcion_Specified;
end;

procedure Error.Setid(Index: Integer; const AInteger: Integer);
begin
  Fid := AInteger;
  Fid_Specified := True;
end;

function Error.id_Specified(Index: Integer): boolean;
begin
  Result := Fid_Specified;
end;

initialization
  { ServicioConsultaPortType }
  InvRegistry.RegisterInterface(TypeInfo(ServicioConsultaPortType), 'http://servicios.buquebus.com', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ServicioConsultaPortType), 'urn:%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ServicioConsultaPortType), ioDocument);
  { ServicioConsultaPortType.servicioMaritimo }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServicioConsultaPortType), 'servicioMaritimo', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(ServicioConsultaPortType), 'servicioMaritimo', 'apellido1', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(ServicioConsultaPortType), 'servicioMaritimo', 'apellido2', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(ServicioConsultaPortType), 'servicioMaritimo', 'nombres1', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(ServicioConsultaPortType), 'servicioMaritimo', 'nombres2', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(ServicioConsultaPortType), 'servicioMaritimo', 'nroDoc', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(ServicioConsultaPortType), 'servicioMaritimo', 'nroLibreta', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(ServicioConsultaPortType), 'servicioMaritimo', 'fechaNac', '',
                                '', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(ServicioConsultaPortType), 'servicioMaritimo', 'return', '',
                                '', IS_NLBL);
  { ServicioConsultaPortType.consultarServicioMaritimo }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServicioConsultaPortType), 'consultarServicioMaritimo', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(ServicioConsultaPortType), 'consultarServicioMaritimo', 'request', '',
                                '[Namespace="http://transport.buquebus.com/xsd"]', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(ServicioConsultaPortType), 'consultarServicioMaritimo', 'return', '',
                                '[Namespace="http://transport.buquebus.com/xsd"]', IS_NLBL);
  RemClassRegistry.RegisterXSClass(ConsultarServicioMaritimoResponse, 'http://transport.buquebus.com/xsd', 'ConsultarServicioMaritimoResponse');
  RemClassRegistry.RegisterXSClass(Persona, 'http://model.buquebus.com/xsd', 'Persona');
  RemClassRegistry.RegisterXSClass(ConsultarServicioMaritimoRequest, 'http://transport.buquebus.com/xsd', 'ConsultarServicioMaritimoRequest');
  RemClassRegistry.RegisterXSClass(ServicioMaritimo, 'http://model.buquebus.com/xsd', 'ServicioMaritimo');
  RemClassRegistry.RegisterXSClass(Resultado, 'http://model.buquebus.com/xsd', 'Resultado');
  RemClassRegistry.RegisterXSClass(Error, 'http://model.buquebus.com/xsd', 'Error');

end.