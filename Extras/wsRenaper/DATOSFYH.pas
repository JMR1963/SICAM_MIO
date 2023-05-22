// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.10.99.8/CHUTROFINAL/ws/DATOSFYH.php?wsdl
//  >Import : http://10.10.99.8/CHUTROFINAL/ws/DATOSFYH.php?wsdl:0
// Encoding : ISO-8859-1
// Version  : 1.0
// (20/12/2016 16:00:09 - - $Rev: 10138 $)
// ************************************************************************ //

unit DATOSFYH;

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
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  DatosEntrada         = class;                 { "urn:mininteriorwsdl"[GblCplx] }
  DatosSalida          = class;                 { "urn:mininteriorwsdl"[GblCplx] }



  // ************************************************************************ //
  // XML       : DatosEntrada, global, <complexType>
  // Namespace : urn:mininteriorwsdl
  // ************************************************************************ //
  DatosEntrada = class(TRemotable)
  private
    Fdni: Integer;
    Fsexo: WideString;
  published
    property dni:  Integer     read Fdni write Fdni;
    property sexo: WideString  read Fsexo write Fsexo;
  end;



  // ************************************************************************ //
  // XML       : DatosSalida, global, <complexType>
  // Namespace : urn:mininteriorwsdl
  // ************************************************************************ //
  DatosSalida = class(TRemotable)
  private
    FID_TRAMITE_PRINCIPAL: Integer;
    FID_TRAMITE_TARJETA_REIMPRESA: Integer;
    FEJEMPLAR: WideString;
    FVENCIMIENTO: WideString;
    FEMISION: WideString;
    Fapellido: WideString;
    Fnombres: WideString;
    FfechaNacimiento: WideString;
    Fcuil: WideString;
    Fcalle: WideString;
    Fnumero: WideString;
    Fpiso: WideString;
    Fdepartamento: WideString;
    Fcpostal: WideString;
    Fbarrio: WideString;
    Fmonoblock: WideString;
    Fciudad: WideString;
    Fmunicipio: WideString;
    Fprovincia: WideString;
    Fpais: WideString;
    FcodigoError: Integer;
    Fcodigof: Integer;
    Fmensaf: WideString;
    Forigenf: WideString;
    Ffechaf: WideString;
    Fidciudadano: WideString;
    Ffoto: WideString;
    Fhuella1: WideString;
    FdenominacionHuella1: WideString;
    FmanoHuella1: WideString;
    Fhuella2: WideString;
    FdenominacionHuella2: WideString;
    FmanoHuella2: WideString;
    FnroError: Integer;
    FdescripcionError: WideString;
  published
    property ID_TRAMITE_PRINCIPAL:         Integer     read FID_TRAMITE_PRINCIPAL write FID_TRAMITE_PRINCIPAL;
    property ID_TRAMITE_TARJETA_REIMPRESA: Integer     read FID_TRAMITE_TARJETA_REIMPRESA write FID_TRAMITE_TARJETA_REIMPRESA;
    property EJEMPLAR:                     WideString  read FEJEMPLAR write FEJEMPLAR;
    property VENCIMIENTO:                  WideString  read FVENCIMIENTO write FVENCIMIENTO;
    property EMISION:                      WideString  read FEMISION write FEMISION;
    property apellido:                     WideString  read Fapellido write Fapellido;
    property nombres:                      WideString  read Fnombres write Fnombres;
    property fechaNacimiento:              WideString  read FfechaNacimiento write FfechaNacimiento;
    property cuil:                         WideString  read Fcuil write Fcuil;
    property calle:                        WideString  read Fcalle write Fcalle;
    property numero:                       WideString  read Fnumero write Fnumero;
    property piso:                         WideString  read Fpiso write Fpiso;
    property departamento:                 WideString  read Fdepartamento write Fdepartamento;
    property cpostal:                      WideString  read Fcpostal write Fcpostal;
    property barrio:                       WideString  read Fbarrio write Fbarrio;
    property monoblock:                    WideString  read Fmonoblock write Fmonoblock;
    property ciudad:                       WideString  read Fciudad write Fciudad;
    property municipio:                    WideString  read Fmunicipio write Fmunicipio;
    property provincia:                    WideString  read Fprovincia write Fprovincia;
    property pais:                         WideString  read Fpais write Fpais;
    property codigoError:                  Integer     read FcodigoError write FcodigoError;
    property codigof:                      Integer     read Fcodigof write Fcodigof;
    property mensaf:                       WideString  read Fmensaf write Fmensaf;
    property origenf:                      WideString  read Forigenf write Forigenf;
    property fechaf:                       WideString  read Ffechaf write Ffechaf;
    property idciudadano:                  WideString  read Fidciudadano write Fidciudadano;
    property foto:                         WideString  read Ffoto write Ffoto;
    property huella1:                      WideString  read Fhuella1 write Fhuella1;
    property denominacionHuella1:          WideString  read FdenominacionHuella1 write FdenominacionHuella1;
    property manoHuella1:                  WideString  read FmanoHuella1 write FmanoHuella1;
    property huella2:                      WideString  read Fhuella2 write Fhuella2;
    property denominacionHuella2:          WideString  read FdenominacionHuella2 write FdenominacionHuella2;
    property manoHuella2:                  WideString  read FmanoHuella2 write FmanoHuella2;
    property nroError:                     Integer     read FnroError write FnroError;
    property descripcionError:             WideString  read FdescripcionError write FdescripcionError;
  end;


  // ************************************************************************ //
  // Namespace : urn:miniteriorwsdl
  // soapAction: urn:mininteriorwsdl#obtenerUltimoEjemplar
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : mininteriorwsdlBinding
  // service   : mininteriorwsdl
  // port      : mininteriorwsdlPort
  // URL       : http://10.10.99.8/CHUTROFINAL/ws/DATOSFYH.php
  // ************************************************************************ //
  mininteriorwsdlPortType = interface(IInvokable)
  ['{52F048FF-A578-F381-19F0-44C1BA3317AA}']
    function  obtenerUltimoEjemplar(const DatosEntrada: DatosEntrada): DatosSalida; stdcall;
  end;

function GetmininteriorwsdlPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): mininteriorwsdlPortType;


implementation
  uses SysUtils;

function GetmininteriorwsdlPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): mininteriorwsdlPortType;
const
  defWSDL = 'http://10.10.99.8/CHUTROFINAL/ws/DATOSFYH.php?wsdl';
  defURL  = 'http://10.10.99.8/CHUTROFINAL/ws/DATOSFYH.php';
  defSvc  = 'mininteriorwsdl';
  defPrt  = 'mininteriorwsdlPort';
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
    Result := (RIO as mininteriorwsdlPortType);
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
  InvRegistry.RegisterInterface(TypeInfo(mininteriorwsdlPortType), 'urn:miniteriorwsdl', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(mininteriorwsdlPortType), 'urn:mininteriorwsdl#obtenerUltimoEjemplar');
  RemClassRegistry.RegisterXSClass(DatosEntrada, 'urn:mininteriorwsdl', 'DatosEntrada');
  RemClassRegistry.RegisterXSClass(DatosSalida, 'urn:mininteriorwsdl', 'DatosSalida');

end.