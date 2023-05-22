// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.0.48/cgi-bin/wsrenaper/prjrenaper/wsdl/IwsRenaper
// Encoding : utf-8
// Version  : 1.0
// (11/11/2019 15:47:54 - 1.33.2.5)
// ************************************************************************ //

unit IwsRenaper1;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns, ufixWS;

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

  direccion            = class;                 { "urn:Umini" }
  ciudadano            = class;                 { "urn:Umini" }
  ciudadanoYDetalle    = class;                 { "urn:Umini" }
  DatosSalida          = class;                 { "urn:migracioneswsdl" }
  salidaVto            = class;                 { "urn:wsRenaperIntf" }
  DatosEntradaM2DNM    = class;                 { "urn:wsRenaperIntf" }
  personaDNm           = class;                 { "urn:wsRenaperIntf" }
  DatosSalidaM2DNM     = class;                 { "urn:wsRenaperIntf" }



  // ************************************************************************ //
  // Namespace : urn:Umini
  // ************************************************************************ //
  direccion = class(TRemotable)
  private
    Fpais: WideString;
    Fprovincia: WideString;
    Fmunicipio: WideString;
    Fciudad: WideString;
    Fcalle: WideString;
    Fnumero: WideString;
    Fpiso: WideString;
    Fdepartamento: WideString;
    Ftelefono: WideString;
    FTel_fijo: WideString;
    Fcaracteristica: WideString;
  published
    property pais: WideString read Fpais write Fpais;
    property provincia: WideString read Fprovincia write Fprovincia;
    property municipio: WideString read Fmunicipio write Fmunicipio;
    property ciudad: WideString read Fciudad write Fciudad;
    property calle: WideString read Fcalle write Fcalle;
    property numero: WideString read Fnumero write Fnumero;
    property piso: WideString read Fpiso write Fpiso;
    property departamento: WideString read Fdepartamento write Fdepartamento;
    property telefono: WideString read Ftelefono write Ftelefono;
    property Tel_fijo: WideString read FTel_fijo write FTel_fijo;
    property caracteristica: WideString read Fcaracteristica write Fcaracteristica;
  end;

  adirecciones = array of direccion;            { "urn:Umini" }


  // ************************************************************************ //
  // Namespace : urn:Umini
  // ************************************************************************ //
  ciudadano = class(TRemotable)
  private
    FidPers: WideString;
    Fnrodni: WideString;
    Fsexo: WideString;
    Fapellido: WideString;
    Fnombres: WideString;
    Ffechanac: WideString;
    Fbiometria: WideString;
    Fnacionalidad: WideString;
    Fdirecciones: adirecciones;
  public
    destructor Destroy; override;
  published
    property idPers: WideString read FidPers write FidPers;
    property nrodni: WideString read Fnrodni write Fnrodni;
    property sexo: WideString read Fsexo write Fsexo;
    property apellido: WideString read Fapellido write Fapellido;
    property nombres: WideString read Fnombres write Fnombres;
    property fechanac: WideString read Ffechanac write Ffechanac;
    property biometria: WideString read Fbiometria write Fbiometria;
    property nacionalidad: WideString read Fnacionalidad write Fnacionalidad;
    property direcciones: adirecciones read Fdirecciones write Fdirecciones;
  end;

  ciudadanos = array of ciudadano;              { "urn:Umini" }


  // ************************************************************************ //
  // Namespace : urn:Umini
  // ************************************************************************ //
  ciudadanoYDetalle = class(TRemotable)
  private
    FidPers: WideString;
    Fnrodni: WideString;
    Fsexo: WideString;
    Fapellido: WideString;
    Fnombres: WideString;
    Ffechanac: WideString;
    Fbiometria: WideString;
    Fnacionalidad: WideString;
    Fdirecciones: adirecciones;
    FnumeroError: Integer;
    Ffoto: WideString;
    FdescripcionError: WideString;
    FhuellaWsq: WideString;
  public
    destructor Destroy; override;
  published
    property idPers: WideString read FidPers write FidPers;
    property nrodni: WideString read Fnrodni write Fnrodni;
    property sexo: WideString read Fsexo write Fsexo;
    property apellido: WideString read Fapellido write Fapellido;
    property nombres: WideString read Fnombres write Fnombres;
    property fechanac: WideString read Ffechanac write Ffechanac;
    property biometria: WideString read Fbiometria write Fbiometria;
    property nacionalidad: WideString read Fnacionalidad write Fnacionalidad;
    property direcciones: adirecciones read Fdirecciones write Fdirecciones;
    property numeroError: Integer read FnumeroError write FnumeroError;
    property foto: WideString read Ffoto write Ffoto;
    property descripcionError: WideString read FdescripcionError write FdescripcionError;
    property huellaWsq: WideString read FhuellaWsq write FhuellaWsq;
  end;

  ciudadanosYDetalle = array of ciudadanoYDetalle;   { "urn:Umini" }


  // ************************************************************************ //
  // Namespace : urn:migracioneswsdl
  // ************************************************************************ //
  DatosSalida = class(TRemotable)
  private
    FidPersona: Integer;
    Fapelldio: WideString;
    Fnombres: WideString;
    Fdni: WideString;
    Fsexo: WideString;
    FfechaDeNacimiento: WideString;
    Ffoto: WideString;
    FnroError: Integer;
    FdescripcionError: WideString;
    FhuellaWsq: WideString;
  published
    property idPersona: Integer read FidPersona write FidPersona;
    property apelldio: WideString read Fapelldio write Fapelldio;
    property nombres: WideString read Fnombres write Fnombres;
    property dni: WideString read Fdni write Fdni;
    property sexo: WideString read Fsexo write Fsexo;
    property fechaDeNacimiento: WideString read FfechaDeNacimiento write FfechaDeNacimiento;
    property foto: WideString read Ffoto write Ffoto;
    property nroError: Integer read FnroError write FnroError;
    property descripcionError: WideString read FdescripcionError write FdescripcionError;
    property huellaWsq: WideString read FhuellaWsq write FhuellaWsq;
  end;



  // ************************************************************************ //
  // Namespace : urn:wsRenaperIntf
  // ************************************************************************ //
  salidaVto = class(TRemotable)
  private
    Fvto: WideString;
    Ferror: Integer;
    FDescripcionerror: WideString;
  published
    property vto: WideString read Fvto write Fvto;
    property error: Integer read Ferror write Ferror;
    property Descripcionerror: WideString read FDescripcionerror write FDescripcionerror;
  end;



  // ************************************************************************ //
  // Namespace : urn:wsRenaperIntf
  // ************************************************************************ //
  DatosEntradaM2DNM = class(TRemotable)
  private
    FprimerApellido: WideString;
    FprimerNombre: WideString;
    FfechaNacimiento: WideString;
  published
    property primerApellido: WideString read FprimerApellido write FprimerApellido;
    property primerNombre: WideString read FprimerNombre write FprimerNombre;
    property fechaNacimiento: WideString read FfechaNacimiento write FfechaNacimiento;
  end;



  // ************************************************************************ //
  // Namespace : urn:wsRenaperIntf
  // ************************************************************************ //
  personaDNm = class(TRemotable)
  private
    Fdni: Integer;
    Fsexo: WideString;
  published
    property dni: Integer read Fdni write Fdni;
    property sexo: WideString read Fsexo write Fsexo;
  end;

  personasArrayDNM = array of personaDNm;       { "urn:wsRenaperIntf" }


  // ************************************************************************ //
  // Namespace : urn:wsRenaperIntf
  // ************************************************************************ //
  DatosSalidaM2DNM = class(TRemotable)
  private
    Fcodigo: Integer;
    Fmensaje: WideString;
    Fpersonas: personasArrayDNM;
  public
    destructor Destroy; override;
  published
    property codigo: Integer read Fcodigo write Fcodigo;
    property mensaje: WideString read Fmensaje write Fmensaje;
    property personas: personasArrayDNM read Fpersonas write Fpersonas;
  end;


  // ************************************************************************ //
  // Namespace : urn:wsRenaperIntf-IwsRenaper
  // soapAction: urn:wsRenaperIntf-IwsRenaper#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IwsRenaperbinding
  // service   : IwsRenaperservice
  // port      : IwsRenaperPort
  // URL       : http://172.16.0.48/cgi-bin/wsrenaper/prjrenaper/soap/IwsRenaper
  // ************************************************************************ //
  IwsRenaper = interface(IInvokable)
  ['{4967D4A7-8B3F-B2C1-A5D7-59C16B11FBB5}']
    function  consultaCiudadanosDniSexo(const nroDni: WideString; const sexo: WideString): ciudadanos; stdcall;
    function  consultaCiudadanosNombre(const apellido: WideString; const nombre: WideString; const nacimiento: WideString): ciudadanos; stdcall;
    function  consultaCiudadanosDetalle(const id: WideString): DatosSalida; stdcall;
    function  consultaCiudadanosXML(const apellido: WideString; const nombre: WideString; const nacimiento: WideString): WideString; stdcall;
    function  consultaUnificada(const nroDni: WideString; const sexo: WideString): ciudadanosYDetalle; stdcall;
    function  VtoDOC(const nroDni: WideString; const sexo: WideString; const tipoDOC: WideString): salidaVto; stdcall;
    function  obtenerMatriculaSexoDNM(const DatosEntrada: DatosEntradaM2DNM): DatosSalidaM2DNM; stdcall;
  end;

function GetIwsRenaper(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IwsRenaper;


implementation

function GetIwsRenaper(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IwsRenaper;
const
  //defWSDL = 'http://172.16.0.48/cgi-bin/wsrenaper/prjrenaper/wsdl/IwsRenaper';
  //defURL  = 'http://172.16.0.48/cgi-bin/wsrenaper/prjrenaper/soap/IwsRenaper';
  defSvc  = 'IwsRenaperservice';
  defPrt  = 'IwsRenaperPort';
var
  RIO: THTTPRIO;
  defWSDL ,  defURL :string;
  d : twsdemora;
begin
  Result := nil;
  d := TWSDemora.Create; //jpb
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
    rio.HTTPWebNode.OnBeforePost :=   d.configureHttpRequest; //JPB
    Result := (RIO as IwsRenaper);
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


destructor ciudadano.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Fdirecciones)-1 do
    if Assigned(Fdirecciones[I]) then
      Fdirecciones[I].Free;
  SetLength(Fdirecciones, 0);
  inherited Destroy;
end;

destructor ciudadanoYDetalle.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Fdirecciones)-1 do
    if Assigned(Fdirecciones[I]) then
      Fdirecciones[I].Free;
  SetLength(Fdirecciones, 0);
  inherited Destroy;
end;

destructor DatosSalidaM2DNM.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Fpersonas)-1 do
    if Assigned(Fpersonas[I]) then
      Fpersonas[I].Free;
  SetLength(Fpersonas, 0);
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(IwsRenaper), 'urn:wsRenaperIntf-IwsRenaper', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IwsRenaper), 'urn:wsRenaperIntf-IwsRenaper#%operationName%');
  RemClassRegistry.RegisterXSClass(direccion, 'urn:Umini', 'direccion');
  RemClassRegistry.RegisterXSInfo(TypeInfo(adirecciones), 'urn:Umini', 'adirecciones');
  RemClassRegistry.RegisterXSClass(ciudadano, 'urn:Umini', 'ciudadano');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ciudadanos), 'urn:Umini', 'ciudadanos');
  RemClassRegistry.RegisterXSClass(ciudadanoYDetalle, 'urn:Umini', 'ciudadanoYDetalle');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ciudadanosYDetalle), 'urn:Umini', 'ciudadanosYDetalle');
 // RemClassRegistry.RegisterXSClass(DatosSalida, 'urn:migracioneswsdl', 'DatosSalida');
  RemClassRegistry.RegisterXSClass(salidaVto, 'urn:wsRenaperIntf', 'salidaVto');
  RemClassRegistry.RegisterXSClass(DatosEntradaM2DNM, 'urn:wsRenaperIntf', 'DatosEntradaM2DNM');
  RemClassRegistry.RegisterXSClass(personaDNm, 'urn:wsRenaperIntf', 'personaDNm');
  RemClassRegistry.RegisterXSInfo(TypeInfo(personasArrayDNM), 'urn:wsRenaperIntf', 'personasArrayDNM');
  RemClassRegistry.RegisterXSClass(DatosSalidaM2DNM, 'urn:wsRenaperIntf', 'DatosSalidaM2DNM');

end. 