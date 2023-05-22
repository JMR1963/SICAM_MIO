// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.100.192.62:8080/wsdl/IwsRenaper
//  >Import : http://10.100.192.62:8080/wsdl/IwsRenaper>0
//  >Import : http://10.100.192.62:8080/wsdl/IwsRenaper>1
//  >Import : http://10.100.192.62:8080/wsdl/IwsRenaper>2
// Version  : 1.0
// (17/4/2023 22:04:11 - - $Rev: 108085 $)
// ************************************************************************ //

unit IwsRenaper1;

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
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  DatosSalidaM2DNM     = class;                 { "urn:wsRenaperIntf"[GblCplx] }
  personaDNm           = class;                 { "urn:wsRenaperIntf"[GblCplx] }
  DatosEntradaM2DNM    = class;                 { "urn:wsRenaperIntf"[GblCplx] }
  DatosSalida          = class;                 { "urn:migracioneswsdl"[GblCplx] }
  salidaVto            = class;                 { "urn:wsRenaperIntf"[GblCplx] }
  ciudadano            = class;                 { "urn:Umini"[GblCplx] }
  ciudadanoYDetalle    = class;                 { "urn:Umini"[GblCplx] }
  direccion            = class;                 { "urn:Umini"[GblCplx] }

  personasArrayDNM = array of personaDNm;       { "urn:wsRenaperIntf"[GblCplx] }


  // ************************************************************************ //
  // XML       : DatosSalidaM2DNM, global, <complexType>
  // Namespace : urn:wsRenaperIntf
  // ************************************************************************ //
  DatosSalidaM2DNM = class(TRemotable)
  private
    Fcodigo: Integer;
    Fmensaje: string;
    Fpersonas: personasArrayDNM;
  public
    destructor Destroy; override;
  published
    property codigo:   Integer           read Fcodigo write Fcodigo;
    property mensaje:  string            read Fmensaje write Fmensaje;
    property personas: personasArrayDNM  read Fpersonas write Fpersonas;
  end;



  // ************************************************************************ //
  // XML       : personaDNm, global, <complexType>
  // Namespace : urn:wsRenaperIntf
  // ************************************************************************ //
  personaDNm = class(TRemotable)
  private
    Fdni: Integer;
    Fsexo: string;
    Fnombre: string;
    Fapellido: string;
    FfechaNacimiento: string;
  published
    property dni:             Integer  read Fdni write Fdni;
    property sexo:            string   read Fsexo write Fsexo;
    property nombre:          string   read Fnombre write Fnombre;
    property apellido:        string   read Fapellido write Fapellido;
    property fechaNacimiento: string   read FfechaNacimiento write FfechaNacimiento;
  end;



  // ************************************************************************ //
  // XML       : DatosEntradaM2DNM, global, <complexType>
  // Namespace : urn:wsRenaperIntf
  // ************************************************************************ //
  DatosEntradaM2DNM = class(TRemotable)
  private
    FprimerApellido: string;
    FprimerNombre: string;
    FanioNacimiento: string;
  published
    property primerApellido: string  read FprimerApellido write FprimerApellido;
    property primerNombre:   string  read FprimerNombre write FprimerNombre;
    property anioNacimiento: string  read FanioNacimiento write FanioNacimiento;
  end;



  // ************************************************************************ //
  // XML       : DatosSalida, global, <complexType>
  // Namespace : urn:migracioneswsdl
  // ************************************************************************ //
  DatosSalida = class(TRemotable)
  private
    FidPersona: Integer;
    Fapelldio: string;
    Fnombres: string;
    Fdni: string;
    Fsexo: string;
    FfechaDeNacimiento: string;
    Ffoto: string;
    FnroError: Integer;
    FdescripcionError: string;
    FhuellaWsq: string;
  published
    property idPersona:         Integer  read FidPersona write FidPersona;
    property apelldio:          string   read Fapelldio write Fapelldio;
    property nombres:           string   read Fnombres write Fnombres;
    property dni:               string   read Fdni write Fdni;
    property sexo:              string   read Fsexo write Fsexo;
    property fechaDeNacimiento: string   read FfechaDeNacimiento write FfechaDeNacimiento;
    property foto:              string   read Ffoto write Ffoto;
    property nroError:          Integer  read FnroError write FnroError;
    property descripcionError:  string   read FdescripcionError write FdescripcionError;
    property huellaWsq:         string   read FhuellaWsq write FhuellaWsq;
  end;



  // ************************************************************************ //
  // XML       : salidaVto, global, <complexType>
  // Namespace : urn:wsRenaperIntf
  // ************************************************************************ //
  salidaVto = class(TRemotable)
  private
    Fvto: string;
    Ferror: Integer;
    FDescripcionerror: string;
  published
    property vto:              string   read Fvto write Fvto;
    property error:            Integer  read Ferror write Ferror;
    property Descripcionerror: string   read FDescripcionerror write FDescripcionerror;
  end;

  ciudadanos = array of ciudadano;              { "urn:Umini"[GblCplx] }
  adirecciones = array of direccion;            { "urn:Umini"[GblCplx] }


  // ************************************************************************ //
  // XML       : ciudadano, global, <complexType>
  // Namespace : urn:Umini
  // ************************************************************************ //
  ciudadano = class(TRemotable)
  private
    FidPers: string;
    Fnrodni: string;
    Fsexo: string;
    Fapellido: string;
    Fnombres: string;
    Ffechanac: string;
    Fbiometria: string;
    Fnacionalidad: string;
    Fdirecciones: adirecciones;
  public
    destructor Destroy; override;
  published
    property idPers:       string        read FidPers write FidPers;
    property nrodni:       string        read Fnrodni write Fnrodni;
    property sexo:         string        read Fsexo write Fsexo;
    property apellido:     string        read Fapellido write Fapellido;
    property nombres:      string        read Fnombres write Fnombres;
    property fechanac:     string        read Ffechanac write Ffechanac;
    property biometria:    string        read Fbiometria write Fbiometria;
    property nacionalidad: string        read Fnacionalidad write Fnacionalidad;
    property direcciones:  adirecciones  read Fdirecciones write Fdirecciones;
  end;



  // ************************************************************************ //
  // XML       : ciudadanoYDetalle, global, <complexType>
  // Namespace : urn:Umini
  // ************************************************************************ //
  ciudadanoYDetalle = class(TRemotable)
  private
    FidPers: string;
    Fnrodni: string;
    Fsexo: string;
    Fapellido: string;
    Fnombres: string;
    Ffechanac: string;
    Fbiometria: string;
    Fnacionalidad: string;
    Fdirecciones: adirecciones;
    FnumeroError: Integer;
    Ffoto: string;
    FdescripcionError: string;
    FhuellaWsq: string;
    FemisionPasaporte: string;
    FvencimientoPasaporte: string;
    FdniProgenitor1: string;
    FdniProgenitor2: string;
    FemisionDNI: string;
    FvencimientoDNI: string;
    Femail: string;
    Fejemplar: string;
    Fnro_tramite: string;
  public
    destructor Destroy; override;
  published
    property idPers:               string        read FidPers write FidPers;
    property nrodni:               string        read Fnrodni write Fnrodni;
    property sexo:                 string        read Fsexo write Fsexo;
    property apellido:             string        read Fapellido write Fapellido;
    property nombres:              string        read Fnombres write Fnombres;
    property fechanac:             string        read Ffechanac write Ffechanac;
    property biometria:            string        read Fbiometria write Fbiometria;
    property nacionalidad:         string        read Fnacionalidad write Fnacionalidad;
    property direcciones:          adirecciones  read Fdirecciones write Fdirecciones;
    property numeroError:          Integer       read FnumeroError write FnumeroError;
    property foto:                 string        read Ffoto write Ffoto;
    property descripcionError:     string        read FdescripcionError write FdescripcionError;
    property huellaWsq:            string        read FhuellaWsq write FhuellaWsq;
    property emisionPasaporte:     string        read FemisionPasaporte write FemisionPasaporte;
    property vencimientoPasaporte: string        read FvencimientoPasaporte write FvencimientoPasaporte;
    property dniProgenitor1:       string        read FdniProgenitor1 write FdniProgenitor1;
    property dniProgenitor2:       string        read FdniProgenitor2 write FdniProgenitor2;
    property emisionDNI:           string        read FemisionDNI write FemisionDNI;
    property vencimientoDNI:       string        read FvencimientoDNI write FvencimientoDNI;
    property email:                string        read Femail write Femail;
    property ejemplar:             string        read Fejemplar write Fejemplar;
    property nro_tramite:          string        read Fnro_tramite write Fnro_tramite;
  end;

  ciudadanosYDetalle = array of ciudadanoYDetalle;   { "urn:Umini"[GblCplx] }


  // ************************************************************************ //
  // XML       : direccion, global, <complexType>
  // Namespace : urn:Umini
  // ************************************************************************ //
  direccion = class(TRemotable)
  private
    Fpais: string;
    Fprovincia: string;
    Fmunicipio: string;
    Fciudad: string;
    Fcalle: string;
    Fnumero: string;
    Fpiso: string;
    Fdepartamento: string;
    Ftelefono: string;
    FTel_fijo: string;
    Fcaracteristica: string;
    Fcpostal: string;
    Fbarrio: string;
    Fmonoblock: string;
    Fmail: string;
  published
    property pais:           string  read Fpais write Fpais;
    property provincia:      string  read Fprovincia write Fprovincia;
    property municipio:      string  read Fmunicipio write Fmunicipio;
    property ciudad:         string  read Fciudad write Fciudad;
    property calle:          string  read Fcalle write Fcalle;
    property numero:         string  read Fnumero write Fnumero;
    property piso:           string  read Fpiso write Fpiso;
    property departamento:   string  read Fdepartamento write Fdepartamento;
    property telefono:       string  read Ftelefono write Ftelefono;
    property Tel_fijo:       string  read FTel_fijo write FTel_fijo;
    property caracteristica: string  read Fcaracteristica write Fcaracteristica;
    property cpostal:        string  read Fcpostal write Fcpostal;
    property barrio:         string  read Fbarrio write Fbarrio;
    property monoblock:      string  read Fmonoblock write Fmonoblock;
    property mail:           string  read Fmail write Fmail;
  end;


  // ************************************************************************ //
  // Namespace : urn:wsRenaperIntf-IwsRenaper
  // soapAction: urn:wsRenaperIntf-IwsRenaper#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : IwsRenaperbinding
  // service   : IwsRenaperservice
  // port      : IwsRenaperPort
  // URL       : http://10.100.192.62:8080/soap/IwsRenaper
  // ************************************************************************ //
  IwsRenaper = interface(IInvokable)
  ['{4967D4A7-8B3F-B2C1-A5D7-59C16B11FBB5}']
    function  consultaCiudadanosDniSexo(const nroDni: string; const sexo: string): ciudadanos; stdcall;
    function  consultaCiudadanosNombre(const apellido: string; const nombre: string; const nacimiento: string): ciudadanos; stdcall;
    function  consultaCiudadanosDetalle(const id: string): DatosSalida; stdcall;
    function  consultaCiudadanosXML(const apellido: string; const nombre: string; const nacimiento: string): string; stdcall;
    function  consultaUnificada(const nroDni: string; const sexo: string): ciudadanosYDetalle; stdcall;
    function  VtoDOC(const nroDni: string; const sexo: string; const tipoDOC: string): salidaVto; stdcall;
    function  obtenerMatriculaSexoDNM(const DatosEntrada: DatosEntradaM2DNM): DatosSalidaM2DNM; stdcall;
  end;

function GetIwsRenaper(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IwsRenaper;


implementation
  uses System.SysUtils;

function GetIwsRenaper(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IwsRenaper;
const
  defWSDL = 'http://10.100.192.62:8080/wsdl/IwsRenaper';
  defURL  = 'http://10.100.192.62:8080/soap/IwsRenaper';
  defSvc  = 'IwsRenaperservice';
  defPrt  = 'IwsRenaperPort';
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


destructor DatosSalidaM2DNM.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fpersonas)-1 do
    System.SysUtils.FreeAndNil(Fpersonas[I]);
  System.SetLength(Fpersonas, 0);
  inherited Destroy;
end;

destructor ciudadano.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdirecciones)-1 do
    System.SysUtils.FreeAndNil(Fdirecciones[I]);
  System.SetLength(Fdirecciones, 0);
  inherited Destroy;
end;

destructor ciudadanoYDetalle.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdirecciones)-1 do
    System.SysUtils.FreeAndNil(Fdirecciones[I]);
  System.SetLength(Fdirecciones, 0);
  inherited Destroy;
end;

initialization
  { IwsRenaper }
  InvRegistry.RegisterInterface(TypeInfo(IwsRenaper), 'urn:wsRenaperIntf-IwsRenaper', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IwsRenaper), 'urn:wsRenaperIntf-IwsRenaper#%operationName%');
  RemClassRegistry.RegisterXSInfo(TypeInfo(personasArrayDNM), 'urn:wsRenaperIntf', 'personasArrayDNM');
  RemClassRegistry.RegisterXSClass(DatosSalidaM2DNM, 'urn:wsRenaperIntf', 'DatosSalidaM2DNM');
  RemClassRegistry.RegisterXSClass(personaDNm, 'urn:wsRenaperIntf', 'personaDNm');
  RemClassRegistry.RegisterXSClass(DatosEntradaM2DNM, 'urn:wsRenaperIntf', 'DatosEntradaM2DNM');
  RemClassRegistry.RegisterXSClass(DatosSalida, 'urn:migracioneswsdl', 'DatosSalida');
  RemClassRegistry.RegisterXSClass(salidaVto, 'urn:wsRenaperIntf', 'salidaVto');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ciudadanos), 'urn:Umini', 'ciudadanos');
  RemClassRegistry.RegisterXSInfo(TypeInfo(adirecciones), 'urn:Umini', 'adirecciones');
  RemClassRegistry.RegisterXSClass(ciudadano, 'urn:Umini', 'ciudadano');
  RemClassRegistry.RegisterXSClass(ciudadanoYDetalle, 'urn:Umini', 'ciudadanoYDetalle');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ciudadanosYDetalle), 'urn:Umini', 'ciudadanosYDetalle');
  RemClassRegistry.RegisterXSClass(direccion, 'urn:Umini', 'direccion');

end.