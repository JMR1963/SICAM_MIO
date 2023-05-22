// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://semaforowcf.azurewebsites.net/SemaforoCL.asmx?wsdl
//  >Import : http://semaforowcf.azurewebsites.net/SemaforoCL.asmx?wsdl>0
// Encoding : utf-8
// Codegen  : [wfProcessHeaders-, wfForceSOAP11+, wfForceSOAP12+]
// Version  : 1.0
// (30/8/2019 11:08:39 - - $Rev: 69934 $)
// ************************************************************************ //

unit SemaforoCL;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns,ufixWs;

const
  IS_OPTN = $0001;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]

  VerifyRequest        = class;                 { "http://investigaciones.cl/semaforo"[GblCplx] }
  ProceedRequest       = class;                 { "http://investigaciones.cl/semaforo"[GblCplx] }
  VerifyResponse       = class;                 { "http://investigaciones.cl/semaforo"[GblCplx] }
  DespachosChileRequest = class;                { "http://investigaciones.cl/semaforo"[GblCplx] }
  WriteResponse        = class;                 { "http://investigaciones.cl/semaforo"[GblCplx] }
  ProceedResponse      = class;                 { "http://investigaciones.cl/semaforo"[GblCplx] }
  DespachosChileResponse = class;               { "http://investigaciones.cl/semaforo"[GblCplx] }
  WriteRequest         = class;                 { "http://investigaciones.cl/semaforo"[GblCplx] }



  // ************************************************************************ //
  // XML       : VerifyRequest, global, <complexType>
  // Namespace : http://investigaciones.cl/semaforo
  // ************************************************************************ //
  VerifyRequest = class(TRemotable)
  private
    FTipoDocumento: string;
    FTipoDocumento_Specified: boolean;
    FNumeroDocumento: string;
    FNumeroDocumento_Specified: boolean;
    FRun: string;
    FRun_Specified: boolean;
    FPaisDocumento: string;
    FPaisDocumento_Specified: boolean;
    FApellidoPaterno: string;
    FApellidoPaterno_Specified: boolean;
    FApellidoMaterno: string;
    FApellidoMaterno_Specified: boolean;
    FPrimerNombre: string;
    FPrimerNombre_Specified: boolean;
    FSegundoNombre: string;
    FSegundoNombre_Specified: boolean;
    FNacionalidad: string;
    FNacionalidad_Specified: boolean;
    FFechaNacimiento: string;
    FFechaNacimiento_Specified: boolean;
    FGenero: string;
    FGenero_Specified: boolean;
    procedure SetTipoDocumento(Index: Integer; const Astring: string);
    function  TipoDocumento_Specified(Index: Integer): boolean;
    procedure SetNumeroDocumento(Index: Integer; const Astring: string);
    function  NumeroDocumento_Specified(Index: Integer): boolean;
    procedure SetRun(Index: Integer; const Astring: string);
    function  Run_Specified(Index: Integer): boolean;
    procedure SetPaisDocumento(Index: Integer; const Astring: string);
    function  PaisDocumento_Specified(Index: Integer): boolean;
    procedure SetApellidoPaterno(Index: Integer; const Astring: string);
    function  ApellidoPaterno_Specified(Index: Integer): boolean;
    procedure SetApellidoMaterno(Index: Integer; const Astring: string);
    function  ApellidoMaterno_Specified(Index: Integer): boolean;
    procedure SetPrimerNombre(Index: Integer; const Astring: string);
    function  PrimerNombre_Specified(Index: Integer): boolean;
    procedure SetSegundoNombre(Index: Integer; const Astring: string);
    function  SegundoNombre_Specified(Index: Integer): boolean;
    procedure SetNacionalidad(Index: Integer; const Astring: string);
    function  Nacionalidad_Specified(Index: Integer): boolean;
    procedure SetFechaNacimiento(Index: Integer; const Astring: string);
    function  FechaNacimiento_Specified(Index: Integer): boolean;
    procedure SetGenero(Index: Integer; const Astring: string);
    function  Genero_Specified(Index: Integer): boolean;
  published
    property TipoDocumento:   string  Index (IS_OPTN) read FTipoDocumento write SetTipoDocumento stored TipoDocumento_Specified;
    property NumeroDocumento: string  Index (IS_OPTN) read FNumeroDocumento write SetNumeroDocumento stored NumeroDocumento_Specified;
    property Run:             string  Index (IS_OPTN) read FRun write SetRun stored Run_Specified;
    property PaisDocumento:   string  Index (IS_OPTN) read FPaisDocumento write SetPaisDocumento stored PaisDocumento_Specified;
    property ApellidoPaterno: string  Index (IS_OPTN) read FApellidoPaterno write SetApellidoPaterno stored ApellidoPaterno_Specified;
    property ApellidoMaterno: string  Index (IS_OPTN) read FApellidoMaterno write SetApellidoMaterno stored ApellidoMaterno_Specified;
    property PrimerNombre:    string  Index (IS_OPTN) read FPrimerNombre write SetPrimerNombre stored PrimerNombre_Specified;
    property SegundoNombre:   string  Index (IS_OPTN) read FSegundoNombre write SetSegundoNombre stored SegundoNombre_Specified;
    property Nacionalidad:    string  Index (IS_OPTN) read FNacionalidad write SetNacionalidad stored Nacionalidad_Specified;
    property FechaNacimiento: string  Index (IS_OPTN) read FFechaNacimiento write SetFechaNacimiento stored FechaNacimiento_Specified;
    property Genero:          string  Index (IS_OPTN) read FGenero write SetGenero stored Genero_Specified;
  end;



  // ************************************************************************ //
  // XML       : ProceedRequest, global, <complexType>
  // Namespace : http://investigaciones.cl/semaforo
  // ************************************************************************ //
  ProceedRequest = class(TRemotable)
  private
    FTipoDocumento: string;
    FTipoDocumento_Specified: boolean;
    FNumeroDocumento: string;
    FNumeroDocumento_Specified: boolean;
    FPaisDocumento: string;
    FPaisDocumento_Specified: boolean;
    FObservacion: string;
    FObservacion_Specified: boolean;
    FFuncionario: string;
    FFuncionario_Specified: boolean;
    FStatus: string;
    FStatus_Specified: boolean;
    procedure SetTipoDocumento(Index: Integer; const Astring: string);
    function  TipoDocumento_Specified(Index: Integer): boolean;
    procedure SetNumeroDocumento(Index: Integer; const Astring: string);
    function  NumeroDocumento_Specified(Index: Integer): boolean;
    procedure SetPaisDocumento(Index: Integer; const Astring: string);
    function  PaisDocumento_Specified(Index: Integer): boolean;
    procedure SetObservacion(Index: Integer; const Astring: string);
    function  Observacion_Specified(Index: Integer): boolean;
    procedure SetFuncionario(Index: Integer; const Astring: string);
    function  Funcionario_Specified(Index: Integer): boolean;
    procedure SetStatus(Index: Integer; const Astring: string);
    function  Status_Specified(Index: Integer): boolean;
  published
    property TipoDocumento:   string  Index (IS_OPTN) read FTipoDocumento write SetTipoDocumento stored TipoDocumento_Specified;
    property NumeroDocumento: string  Index (IS_OPTN) read FNumeroDocumento write SetNumeroDocumento stored NumeroDocumento_Specified;
    property PaisDocumento:   string  Index (IS_OPTN) read FPaisDocumento write SetPaisDocumento stored PaisDocumento_Specified;
    property Observacion:     string  Index (IS_OPTN) read FObservacion write SetObservacion stored Observacion_Specified;
    property Funcionario:     string  Index (IS_OPTN) read FFuncionario write SetFuncionario stored Funcionario_Specified;
    property Status:          string  Index (IS_OPTN) read FStatus write SetStatus stored Status_Specified;
  end;



  // ************************************************************************ //
  // XML       : VerifyResponse, global, <complexType>
  // Namespace : http://investigaciones.cl/semaforo
  // ************************************************************************ //
  VerifyResponse = class(TRemotable)
  private
    FAod: string;
    FAod_Specified: boolean;
    FCvm: string;
    FCvm_Specified: boolean;
    procedure SetAod(Index: Integer; const Astring: string);
    function  Aod_Specified(Index: Integer): boolean;
    procedure SetCvm(Index: Integer; const Astring: string);
    function  Cvm_Specified(Index: Integer): boolean;
  published
    property Aod: string  Index (IS_OPTN) read FAod write SetAod stored Aod_Specified;
    property Cvm: string  Index (IS_OPTN) read FCvm write SetCvm stored Cvm_Specified;
  end;



  // ************************************************************************ //
  // XML       : DespachosChileRequest, global, <complexType>
  // Namespace : http://investigaciones.cl/semaforo
  // ************************************************************************ //
  DespachosChileRequest = class(TRemotable)
  private
    FFINI: string;
    FFINI_Specified: boolean;
    FFFIN: string;
    FFFIN_Specified: boolean;
    procedure SetFINI(Index: Integer; const Astring: string);
    function  FINI_Specified(Index: Integer): boolean;
    procedure SetFFIN(Index: Integer; const Astring: string);
    function  FFIN_Specified(Index: Integer): boolean;
  published
    property FINI: string  Index (IS_OPTN) read FFINI write SetFINI stored FINI_Specified;
    property FFIN: string  Index (IS_OPTN) read FFFIN write SetFFIN stored FFIN_Specified;
  end;



  // ************************************************************************ //
  // XML       : WriteResponse, global, <complexType>
  // Namespace : http://investigaciones.cl/semaforo
  // ************************************************************************ //
  WriteResponse = class(TRemotable)
  private
    FStatus: Integer;
    FDescripcion: string;
    FDescripcion_Specified: boolean;
    procedure SetDescripcion(Index: Integer; const Astring: string);
    function  Descripcion_Specified(Index: Integer): boolean;
  published
    property Status:      Integer  read FStatus write FStatus;
    property Descripcion: string   Index (IS_OPTN) read FDescripcion write SetDescripcion stored Descripcion_Specified;
  end;



  // ************************************************************************ //
  // XML       : ProceedResponse, global, <complexType>
  // Namespace : http://investigaciones.cl/semaforo
  // ************************************************************************ //
  ProceedResponse = class(TRemotable)
  private
    FStatus: Integer;
    FDescripcion: string;
    FDescripcion_Specified: boolean;
    procedure SetDescripcion(Index: Integer; const Astring: string);
    function  Descripcion_Specified(Index: Integer): boolean;
  published
    property Status:      Integer  read FStatus write FStatus;
    property Descripcion: string   Index (IS_OPTN) read FDescripcion write SetDescripcion stored Descripcion_Specified;
  end;



  // ************************************************************************ //
  // XML       : DespachosChileResponse, global, <complexType>
  // Namespace : http://investigaciones.cl/semaforo
  // ************************************************************************ //
  DespachosChileResponse = class(TRemotable)
  private
    FStatus: Integer;
    FDescripcion: string;
    FDescripcion_Specified: boolean;
    FData: string;
    FData_Specified: boolean;
    procedure SetDescripcion(Index: Integer; const Astring: string);
    function  Descripcion_Specified(Index: Integer): boolean;
    procedure SetData(Index: Integer; const Astring: string);
    function  Data_Specified(Index: Integer): boolean;
  published
    property Status:      Integer  read FStatus write FStatus;
    property Descripcion: string   Index (IS_OPTN) read FDescripcion write SetDescripcion stored Descripcion_Specified;
    property Data:        string   Index (IS_OPTN) read FData write SetData stored Data_Specified;
  end;



  // ************************************************************************ //
  // XML       : WriteRequest, global, <complexType>
  // Namespace : http://investigaciones.cl/semaforo
  // ************************************************************************ //
  WriteRequest = class(TRemotable)
  private
    FData: string;
    FData_Specified: boolean;
    FFechaCierre: string;
    FFechaCierre_Specified: boolean;
    procedure SetData(Index: Integer; const Astring: string);
    function  Data_Specified(Index: Integer): boolean;
    procedure SetFechaCierre(Index: Integer; const Astring: string);
    function  FechaCierre_Specified(Index: Integer): boolean;
  published
    property Data:        string  Index (IS_OPTN) read FData write SetData stored Data_Specified;
    property FechaCierre: string  Index (IS_OPTN) read FFechaCierre write SetFechaCierre stored FechaCierre_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://investigaciones.cl/semaforo
  // soapAction: http://investigaciones.cl/semaforo/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : SemaforoLegacySoap12
  // service   : SemaforoLegacy
  // port      : SemaforoLegacySoap12
  // URL       : http://semaforowcf.azurewebsites.net/SemaforoCL.asmx
  // ************************************************************************ //
  SemaforoLegacySoap = interface(IInvokable)
  ['{3CAED4C2-DCF3-D11F-14FE-3AD2A1D84F53}']
    function  Verificar(const request: VerifyRequest): VerifyResponse; stdcall;
    function  Proceder(const request: ProceedRequest): ProceedResponse; stdcall;
    function  RegistraViaje(const request: WriteRequest): WriteResponse; stdcall;
    function  DespachosChile(const request: DespachosChileRequest): DespachosChileResponse; stdcall;
  end;

function GetSemaforoLegacySoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil; timeout:integer=5000): SemaforoLegacySoap;


implementation
  uses System.SysUtils;

function GetSemaforoLegacySoap(UseWSDL: Boolean; Addr: string;  HTTPRIO: THTTPRIO; timeout:integer): SemaforoLegacySoap;
const
  defWSDL = '';//'http://semaforowcf.azurewebsites.net/SemaforoCL.asmx?wsdl';
  defURL  = '';//'http://semaforowcf.azurewebsites.net/SemaforoCL.asmx';
  defSvc  = 'SemaforoLegacy';
  defPrt  = 'SemaforoLegacySoap12';
var
  RIO: THTTPRIO;
  d : twsdemora;
begin
  Result := nil;

  d := TWSDemora.Create;

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

    rio.HTTPWebNode.OnBeforePost :=   d.configureHttpRequest;

    Result := (RIO as SemaforoLegacySoap);
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


procedure VerifyRequest.SetTipoDocumento(Index: Integer; const Astring: string);
begin
  FTipoDocumento := Astring;
  FTipoDocumento_Specified := True;
end;

function VerifyRequest.TipoDocumento_Specified(Index: Integer): boolean;
begin
  Result := FTipoDocumento_Specified;
end;

procedure VerifyRequest.SetNumeroDocumento(Index: Integer; const Astring: string);
begin
  FNumeroDocumento := Astring;
  FNumeroDocumento_Specified := True;
end;

function VerifyRequest.NumeroDocumento_Specified(Index: Integer): boolean;
begin
  Result := FNumeroDocumento_Specified;
end;

procedure VerifyRequest.SetRun(Index: Integer; const Astring: string);
begin
  FRun := Astring;
  FRun_Specified := True;
end;

function VerifyRequest.Run_Specified(Index: Integer): boolean;
begin
  Result := FRun_Specified;
end;

procedure VerifyRequest.SetPaisDocumento(Index: Integer; const Astring: string);
begin
  FPaisDocumento := Astring;
  FPaisDocumento_Specified := True;
end;

function VerifyRequest.PaisDocumento_Specified(Index: Integer): boolean;
begin
  Result := FPaisDocumento_Specified;
end;

procedure VerifyRequest.SetApellidoPaterno(Index: Integer; const Astring: string);
begin
  FApellidoPaterno := Astring;
  FApellidoPaterno_Specified := True;
end;

function VerifyRequest.ApellidoPaterno_Specified(Index: Integer): boolean;
begin
  Result := FApellidoPaterno_Specified;
end;

procedure VerifyRequest.SetApellidoMaterno(Index: Integer; const Astring: string);
begin
  FApellidoMaterno := Astring;
  FApellidoMaterno_Specified := True;
end;

function VerifyRequest.ApellidoMaterno_Specified(Index: Integer): boolean;
begin
  Result := FApellidoMaterno_Specified;
end;

procedure VerifyRequest.SetPrimerNombre(Index: Integer; const Astring: string);
begin
  FPrimerNombre := Astring;
  FPrimerNombre_Specified := True;
end;

function VerifyRequest.PrimerNombre_Specified(Index: Integer): boolean;
begin
  Result := FPrimerNombre_Specified;
end;

procedure VerifyRequest.SetSegundoNombre(Index: Integer; const Astring: string);
begin
  FSegundoNombre := Astring;
  FSegundoNombre_Specified := True;
end;

function VerifyRequest.SegundoNombre_Specified(Index: Integer): boolean;
begin
  Result := FSegundoNombre_Specified;
end;

procedure VerifyRequest.SetNacionalidad(Index: Integer; const Astring: string);
begin
  FNacionalidad := Astring;
  FNacionalidad_Specified := True;
end;

function VerifyRequest.Nacionalidad_Specified(Index: Integer): boolean;
begin
  Result := FNacionalidad_Specified;
end;

procedure VerifyRequest.SetFechaNacimiento(Index: Integer; const Astring: string);
begin
  FFechaNacimiento := Astring;
  FFechaNacimiento_Specified := True;
end;

function VerifyRequest.FechaNacimiento_Specified(Index: Integer): boolean;
begin
  Result := FFechaNacimiento_Specified;
end;

procedure VerifyRequest.SetGenero(Index: Integer; const Astring: string);
begin
  FGenero := Astring;
  FGenero_Specified := True;
end;

function VerifyRequest.Genero_Specified(Index: Integer): boolean;
begin
  Result := FGenero_Specified;
end;

procedure ProceedRequest.SetTipoDocumento(Index: Integer; const Astring: string);
begin
  FTipoDocumento := Astring;
  FTipoDocumento_Specified := True;
end;

function ProceedRequest.TipoDocumento_Specified(Index: Integer): boolean;
begin
  Result := FTipoDocumento_Specified;
end;

procedure ProceedRequest.SetNumeroDocumento(Index: Integer; const Astring: string);
begin
  FNumeroDocumento := Astring;
  FNumeroDocumento_Specified := True;
end;

function ProceedRequest.NumeroDocumento_Specified(Index: Integer): boolean;
begin
  Result := FNumeroDocumento_Specified;
end;

procedure ProceedRequest.SetPaisDocumento(Index: Integer; const Astring: string);
begin
  FPaisDocumento := Astring;
  FPaisDocumento_Specified := True;
end;

function ProceedRequest.PaisDocumento_Specified(Index: Integer): boolean;
begin
  Result := FPaisDocumento_Specified;
end;

procedure ProceedRequest.SetObservacion(Index: Integer; const Astring: string);
begin
  FObservacion := Astring;
  FObservacion_Specified := True;
end;

function ProceedRequest.Observacion_Specified(Index: Integer): boolean;
begin
  Result := FObservacion_Specified;
end;

procedure ProceedRequest.SetFuncionario(Index: Integer; const Astring: string);
begin
  FFuncionario := Astring;
  FFuncionario_Specified := True;
end;

function ProceedRequest.Funcionario_Specified(Index: Integer): boolean;
begin
  Result := FFuncionario_Specified;
end;

procedure ProceedRequest.SetStatus(Index: Integer; const Astring: string);
begin
  FStatus := Astring;
  FStatus_Specified := True;
end;

function ProceedRequest.Status_Specified(Index: Integer): boolean;
begin
  Result := FStatus_Specified;
end;

procedure VerifyResponse.SetAod(Index: Integer; const Astring: string);
begin
  FAod := Astring;
  FAod_Specified := True;
end;

function VerifyResponse.Aod_Specified(Index: Integer): boolean;
begin
  Result := FAod_Specified;
end;

procedure VerifyResponse.SetCvm(Index: Integer; const Astring: string);
begin
  FCvm := Astring;
  FCvm_Specified := True;
end;

function VerifyResponse.Cvm_Specified(Index: Integer): boolean;
begin
  Result := FCvm_Specified;
end;

procedure DespachosChileRequest.SetFINI(Index: Integer; const Astring: string);
begin
  FFINI := Astring;
  FFINI_Specified := True;
end;

function DespachosChileRequest.FINI_Specified(Index: Integer): boolean;
begin
  Result := FFINI_Specified;
end;

procedure DespachosChileRequest.SetFFIN(Index: Integer; const Astring: string);
begin
  FFFIN := Astring;
  FFFIN_Specified := True;
end;

function DespachosChileRequest.FFIN_Specified(Index: Integer): boolean;
begin
  Result := FFFIN_Specified;
end;

procedure WriteResponse.SetDescripcion(Index: Integer; const Astring: string);
begin
  FDescripcion := Astring;
  FDescripcion_Specified := True;
end;

function WriteResponse.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

procedure ProceedResponse.SetDescripcion(Index: Integer; const Astring: string);
begin
  FDescripcion := Astring;
  FDescripcion_Specified := True;
end;

function ProceedResponse.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

procedure DespachosChileResponse.SetDescripcion(Index: Integer; const Astring: string);
begin
  FDescripcion := Astring;
  FDescripcion_Specified := True;
end;

function DespachosChileResponse.Descripcion_Specified(Index: Integer): boolean;
begin
  Result := FDescripcion_Specified;
end;

procedure DespachosChileResponse.SetData(Index: Integer; const Astring: string);
begin
  FData := Astring;
  FData_Specified := True;
end;

function DespachosChileResponse.Data_Specified(Index: Integer): boolean;
begin
  Result := FData_Specified;
end;

procedure WriteRequest.SetData(Index: Integer; const Astring: string);
begin
  FData := Astring;
  FData_Specified := True;
end;

function WriteRequest.Data_Specified(Index: Integer): boolean;
begin
  Result := FData_Specified;
end;

procedure WriteRequest.SetFechaCierre(Index: Integer; const Astring: string);
begin
  FFechaCierre := Astring;
  FFechaCierre_Specified := True;
end;

function WriteRequest.FechaCierre_Specified(Index: Integer): boolean;
begin
  Result := FFechaCierre_Specified;
end;

initialization
  { SemaforoLegacySoap }
  InvRegistry.RegisterInterface(TypeInfo(SemaforoLegacySoap), 'http://investigaciones.cl/semaforo', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(SemaforoLegacySoap), 'http://investigaciones.cl/semaforo/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(SemaforoLegacySoap), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(SemaforoLegacySoap), ioSOAP12);
  { SemaforoLegacySoap.Verificar }
  InvRegistry.RegisterMethodInfo(TypeInfo(SemaforoLegacySoap), 'Verificar', '',
                                 '[ReturnName="VerificarResult"]', IS_OPTN);
  { SemaforoLegacySoap.Proceder }
  InvRegistry.RegisterMethodInfo(TypeInfo(SemaforoLegacySoap), 'Proceder', '',
                                 '[ReturnName="ProcederResult"]', IS_OPTN);
  { SemaforoLegacySoap.RegistraViaje }
  InvRegistry.RegisterMethodInfo(TypeInfo(SemaforoLegacySoap), 'RegistraViaje', '',
                                 '[ReturnName="RegistraViajeResult"]', IS_OPTN);
  { SemaforoLegacySoap.DespachosChile }
  InvRegistry.RegisterMethodInfo(TypeInfo(SemaforoLegacySoap), 'DespachosChile', '',
                                 '[ReturnName="DespachosChileResult"]', IS_OPTN);
  RemClassRegistry.RegisterXSClass(VerifyRequest, 'http://investigaciones.cl/semaforo', 'VerifyRequest');
  RemClassRegistry.RegisterXSClass(ProceedRequest, 'http://investigaciones.cl/semaforo', 'ProceedRequest');
  RemClassRegistry.RegisterXSClass(VerifyResponse, 'http://investigaciones.cl/semaforo', 'VerifyResponse');
  RemClassRegistry.RegisterXSClass(DespachosChileRequest, 'http://investigaciones.cl/semaforo', 'DespachosChileRequest');
  RemClassRegistry.RegisterXSClass(WriteResponse, 'http://investigaciones.cl/semaforo', 'WriteResponse');
  RemClassRegistry.RegisterXSClass(ProceedResponse, 'http://investigaciones.cl/semaforo', 'ProceedResponse');
  RemClassRegistry.RegisterXSClass(DespachosChileResponse, 'http://investigaciones.cl/semaforo', 'DespachosChileResponse');
  RemClassRegistry.RegisterXSClass(WriteRequest, 'http://investigaciones.cl/semaforo', 'WriteRequest');

end.