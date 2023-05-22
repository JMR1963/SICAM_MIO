// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.192.151/cgi-bin/wstransitosarchivo/wstransitosarchivo/wsdl/IWSTransitos
// >Import : http://172.16.192.151/cgi-bin/wstransitosarchivo/wstransitosarchivo/wsdl/IWSTransitos>0
// Encoding : utf-8
// Version  : 1.0
// (18/06/2019 16:09:27 - - $Rev: 69934 $)
// ************************************************************************ //

unit IWSTransitos1;

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
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  ttransitoFile = class; { "urn:WSTransitosIntf"[GblCplx] }
  tarchivo = class; { "urn:WSTransitosIntf"[GblCplx] }
  tusuario = class; { "urn:WSTransitosIntf"[GblCplx] }
  tconsulta = class; { "urn:WSTransitosIntf"[GblCplx] }

  // ************************************************************************ //
  // XML       : ttransitoFile, global, <complexType>
  // Namespace : urn:WSTransitosIntf
  // ************************************************************************ //
  ttransitoFile = class(TRemotable)
  private
    Farchivo: string;
    Forganismo: string;
    Ffecha: string;
  published
    property archivo: string read Farchivo write Farchivo;
    property organismo: string read Forganismo write Forganismo;
    property fecha: string read Ffecha write Ffecha;
  end;

  // ************************************************************************ //
  // XML       : tarchivo, global, <complexType>
  // Namespace : urn:WSTransitosIntf
  // ************************************************************************ //
  tarchivo = class(TRemotable)
  private
    FFileStr: string;
    FFileName: string;
  published
    property FileStr: string read FFileStr write FFileStr;
    property FileName: string read FFileName write FFileName;
  end;

  // ************************************************************************ //
  // XML       : tusuario, global, <complexType>
  // Namespace : urn:WSTransitosIntf
  // ************************************************************************ //
  tusuario = class(TRemotable)
  private
    Fuser: string;
    Fpassword: string;
  published
    property user: string read Fuser write Fuser;
    property password: string read Fpassword write Fpassword;
  end;

  // ************************************************************************ //
  // XML       : tconsulta, global, <complexType>
  // Namespace : urn:WSTransitosIntf
  // ************************************************************************ //
  tconsulta = class(TRemotable)
  private
    Fdia: string;
    Forganismo: string;
  published
    property dia: string read Fdia write Fdia;
    property organismo: string read Forganismo write Forganismo;
  end;

  // ************************************************************************ //
  // Namespace : urn:WSTransitosIntf-IWSTransitos
  // soapAction: urn:WSTransitosIntf-IWSTransitos#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : IWSTransitosbinding
  // service   : IWSTransitosservice
  // port      : IWSTransitosPort
  // URL       : http://172.16.192.151/cgi-bin/wstransitosarchivo/wstransitosarchivo/soap/IWSTransitos
  // ************************************************************************ //
  IWSTransitos = interface(IInvokable)
    ['{D5490B73-9F31-00CB-7784-4597D08CFCB3}']
    function ArgentinosPaso(const dia: string): string; stdcall;
    function ExtrangerosPaso(const dia: string): string; stdcall;
    function TodosPaso(const dia: string): string; stdcall;
    function guardarRestricciones(const transitos: ttransitoFile)
      : Boolean; stdcall;
    function guardarRestriccionesxml(const transitos: ttransitoFile)
      : Boolean; stdcall;
    function Argentinos(const dia: string): string; stdcall;
    function enviarSolicitud(const transitos: ttransitoFile;
      const NRO_ENVIO: string): Boolean; stdcall;
    function obtenerRespuestaSolicitud(const consulta: tconsulta;
      const NRO_ENVIO: string): ttransitoFile; stdcall;
    function validarUsuarioOrganismo(const usuario: tusuario): Boolean; stdcall;
    function Enviar_Transitos_SICaM(const transitos: ttransitoFile)
      : Boolean; stdcall;
    function enviarManifiestoUry(const archivo: tarchivo): string; stdcall;
    function enviarManifiestoCHL(const archivo: tarchivo): string; stdcall;
    function enviarManifiestoPryBol(const archivo: tarchivo): string; stdcall;
  end;

//function GetIWSTransitos(UseWSDL: Boolean = System.False; Addr: string = '';
  //HTTPRIO: THTTPRIO = nil): IWSTransitos;


function GetIWSTransitos2(Addr:string;HTTPRIO: THTTPRIO = nil): IWSTransitos;

implementation

uses System.SysUtils, uGlobal, ufixWS;

function GetIWSTransitos2(Addr:string;HTTPRIO: THTTPRIO = nil): IWSTransitos;
const
  defSvc = 'IWSTransitosservice';
  defPrt = 'IWSTransitosPort';
var
  RIO: THTTPRIO;
  defWSDL, defURL: string;
  d: TWSDemora;
begin

  Result := nil;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as IWSTransitos);

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

{
function GetIWSTransitos(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO)
  : IWSTransitos;
const
  defSvc = 'IWSTransitosservice';
  defPrt = 'IWSTransitosPort';
var
  RIO: THTTPRIO;
  defWSDL, defURL: string;
  d: TWSDemora;
begin
  Addr := wstransitosarchivoEntradaSalida;

  Result := nil;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as IWSTransitos);

    if UseWSDL then
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
}

initialization

{ IWSTransitos }
InvRegistry.RegisterInterface(TypeInfo(IWSTransitos),
  'urn:WSTransitosIntf-IWSTransitos', 'utf-8');
InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IWSTransitos),
  'urn:WSTransitosIntf-IWSTransitos#%operationName%');
RemClassRegistry.RegisterXSClass(ttransitoFile, 'urn:WSTransitosIntf',
  'ttransitoFile');
RemClassRegistry.RegisterXSClass(tarchivo, 'urn:WSTransitosIntf', 'tarchivo');
RemClassRegistry.RegisterXSClass(tusuario, 'urn:WSTransitosIntf', 'tusuario');
RemClassRegistry.RegisterXSClass(tconsulta, 'urn:WSTransitosIntf', 'tconsulta');

end.

  implementation

uses System.SysUtils, DMAFIS, Classes, dialogs, ufixWS;

type
  TtestC = class
    procedure RiomBeforeExecute(const MethodName: string; SOAPRequest: TStream);
  end;

function GetIWSAfisCentral(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO)
  : IWSAfisCentral;
const
  // defWSDL = 'http://172.16.192.151/cgi-bin/WSAfisCentral/WSAfisCentral/wsdl/IWSAfisCentral';
  // defURL  = 'http://172.16.192.151/cgi-bin/WSAfisCentral/WSAfisCentral/soap/IWSAfisCentral';
  defSvc = 'IWSAfisCentralservice';
  defPrt = 'IWSAfisCentralPort';
var
  RIO: THTTPRIO;
  defURL, defWSDL: string;
  // t:TtestC;
  d: TWSDemora;
begin
  // t := TtestC.Create;
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := '' // defWSDL
    else
      Addr := WSAfis;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;

  d := TWSDemora.Create;
  RIO.HTTPWebNode.OnBeforePost := d.configureHttpRequest;


  // RIO.OnBeforeExecute := t.RiomBeforeExecute;

  try
    Result := (RIO as IWSAfisCentral);
    if UseWSDL then
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

destructor TDatosRespuesta.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FPersonas) - 1 do
    System.SysUtils.FreeAndNil(FPersonas[I]);
  System.SetLength(FPersonas, 0);
  inherited Destroy;
end;

destructor TPersona.Destroy;
begin
  System.SysUtils.FreeAndNil(FDatos);
  inherited Destroy;
end;

{ TtestC }

procedure TtestC.RiomBeforeExecute(const MethodName: string;
  SOAPRequest: TStream);
var
  sTmp: TStringList;

begin

  // sTmp:=TStringList.Create;
  // SOAPRequest.Position := 0;
  // sTmp.LoadFromStream(SOAPRequest);
  // ShowMessage(sTmp.Text);
  // sTmp.Text := StringReplace(sTmp.Text,'blablaa','bla',[RfReplaceAll]);
  // sTmp.SaveToStream(SOAPRequest);
  // blaa blaa...
end;

initialization

{ IWSAfisCentral }
InvRegistry.RegisterInterface(TypeInfo(IWSAfisCentral),
  'urn:WSAfisCentralIntf-IWSAfisCentral', '');
InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IWSAfisCentral),
  'urn:WSAfisCentralIntf-IWSAfisCentral#%operationName%');
RemClassRegistry.RegisterXSInfo(TypeInfo(TVectorPersonas),
  'urn:WSAfisCentralIntf', 'TVectorPersonas');
RemClassRegistry.RegisterXSClass(TDatosPersona, 'urn:WSAfisCentralIntf',
  'TDatosPersona');
RemClassRegistry.RegisterXSInfo(TypeInfo(TDedos), 'urn:WSAfisCentralIntf',
  'TDedos');
RemClassRegistry.RegisterXSClass(TDatosRespuesta, 'urn:WSAfisCentralIntf',
  'TDatosRespuesta');
RemClassRegistry.RegisterXSClass(TPersona, 'urn:WSAfisCentralIntf', 'TPersona');

end.
