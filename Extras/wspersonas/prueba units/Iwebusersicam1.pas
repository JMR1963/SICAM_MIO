// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.192.111/cgi-bin/wspersonas/wspersonas/wsdl/Iwebusersicam
// Encoding : utf-8
// Version  : 1.0
// (28/06/2013 02:53:54 p.m. - 1.33.2.5)
// ************************************************************************ //

unit Iwebusersicam1;

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

  TTransit             = class;                 { "urn:webusersicamIntf" }
  TImagesTransit       = class;                 { "urn:webusersicamIntf" }



  // ************************************************************************ //
  // Namespace : urn:webusersicamIntf
  // ************************************************************************ //
  TTransit = class(TRemotable)
  private
    FFechaCruce: WideString;
    FPasoCruce: WideString;
    FTipoCruce: WideString;
    FDiasPermanencia: WideString;
    FApellido1: WideString;
    FApellido2: WideString;
    FNombre1: WideString;
    FNombre2: WideString;
    FSexo: WideString;
    FDocVenc: WideString;
    FDocNro: WideString;
    FDocTipo: WideString;
    FDocPaisEmisor: WideString;
    FFechaNac: WideString;
    FNacionalidad: WideString;
    FDocSubTipo: WideString;
    FIdTranOlSicam: WideString;
  published
    property FechaCruce: WideString read FFechaCruce write FFechaCruce;
    property PasoCruce: WideString read FPasoCruce write FPasoCruce;
    property TipoCruce: WideString read FTipoCruce write FTipoCruce;
    property DiasPermanencia: WideString read FDiasPermanencia write FDiasPermanencia;
    property Apellido1: WideString read FApellido1 write FApellido1;
    property Apellido2: WideString read FApellido2 write FApellido2;
    property Nombre1: WideString read FNombre1 write FNombre1;
    property Nombre2: WideString read FNombre2 write FNombre2;
    property Sexo: WideString read FSexo write FSexo;
    property DocVenc: WideString read FDocVenc write FDocVenc;
    property DocNro: WideString read FDocNro write FDocNro;
    property DocTipo: WideString read FDocTipo write FDocTipo;
    property DocPaisEmisor: WideString read FDocPaisEmisor write FDocPaisEmisor;
    property FechaNac: WideString read FFechaNac write FFechaNac;
    property Nacionalidad: WideString read FNacionalidad write FNacionalidad;
    property DocSubTipo: WideString read FDocSubTipo write FDocSubTipo;
    property IdTranOlSicam: WideString read FIdTranOlSicam write FIdTranOlSicam;
  end;

  aTransitos = array of TTransit;               { "urn:webusersicamIntf" }


  // ************************************************************************ //
  // Namespace : urn:webusersicamIntf
  // ************************************************************************ //
  TImagesTransit = class(TRemotable)
  private
    FNombreFacial: WideString;
    FFileFacial: WideString;
    FNombreDactilar: WideString;
    FDescripcionDactilar: WideString;
    FFileDactilar: WideString;
    FErrorCode: WideString;
  published
    property NombreFacial: WideString read FNombreFacial write FNombreFacial;
    property FileFacial: WideString read FFileFacial write FFileFacial;
    property NombreDactilar: WideString read FNombreDactilar write FNombreDactilar;
    property DescripcionDactilar: WideString read FDescripcionDactilar write FDescripcionDactilar;
    property FileDactilar: WideString read FFileDactilar write FFileDactilar;
    property ErrorCode: WideString read FErrorCode write FErrorCode;
  end;

  aImagesTransit = array of TImagesTransit;     { "urn:webusersicamIntf" }

  // ************************************************************************ //
  // Namespace : urn:webusersicamIntf-Iwebusersicam
  // soapAction: urn:webusersicamIntf-Iwebusersicam#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : Iwebusersicambinding
  // service   : Iwebusersicamservice
  // port      : IwebusersicamPort
  // URL       : http://172.16.192.111/cgi-bin/wspersonas/wspersonas/soap/Iwebusersicam
  // ************************************************************************ //
  Iwebusersicam = interface(IInvokable)
  ['{AD7BF515-9AC6-73B3-9A8B-5FF2E51981DD}']
    //function  findPerson(const id: WideString; const pais: WideString; const subTipoDoc: WideString; const nroDocumento: WideString): WideString; stdcall;
    function  findPersonAndTransit(const id: WideString; const pais: WideString; const subTipoDoc: WideString; const nroDocumento: WideString): aTransitos; stdcall;
    //function  usuarios_pasos(const usuario: WideString; const documentonro: WideString; const clavesistema: WideString; const apellidos: WideString; const nombres: WideString; const pasold: WideString; const pasonew: WideString; const idusuariostipos: WideString; const credencial: WideString): WideString; stdcall;
    //function  findImagesTransit(const id: WideString; const pais: WideString; const subTipoDoc: WideString; const nroDocumento: WideString): aImagesTransit; stdcall;
  end;

function GetIwebusersicam(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): Iwebusersicam;


implementation

function GetIwebusersicam(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): Iwebusersicam;
const
  defWSDL = 'http://10.10.10.67/cgi-bin/wspersonas/wspersonas/wsdl/Iwebusersicam';
  defURL  = 'http://10.10.10.67/cgi-bin/wspersonas/wspersonas/soap/Iwebusersicam';
  defSvc  = 'Iwebusersicamservice';
  defPrt  = 'IwebusersicamPort';
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
    Result := (RIO as Iwebusersicam);
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
  InvRegistry.RegisterInterface(TypeInfo(Iwebusersicam), 'urn:webusersicamIntf-Iwebusersicam', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(Iwebusersicam), 'urn:webusersicamIntf-Iwebusersicam#%operationName%');
  RemClassRegistry.RegisterXSClass(TTransit, 'urn:webusersicamIntf', 'TTransit');
  RemClassRegistry.RegisterXSInfo(TypeInfo(aTransitos), 'urn:webusersicamIntf', 'aTransitos');
  RemClassRegistry.RegisterXSClass(TImagesTransit, 'urn:webusersicamIntf', 'TImagesTransit');
  RemClassRegistry.RegisterXSInfo(TypeInfo(aImagesTransit), 'urn:webusersicamIntf', 'aImagesTransit');

end. 