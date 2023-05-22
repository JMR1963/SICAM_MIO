// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://servicios.migracion.gob.bo/wsArgentina/wsImpedimentosBolivia.asmx?wsdl
//  >Import : http://servicios.migracion.gob.bo/wsArgentina/wsImpedimentosBolivia.asmx?wsdl>0
// Encoding : utf-8
// Version  : 1.0
// (29/09/2016 17:40:07 - - $Rev: 69934 $)
// ************************************************************************ //

unit wsImpedimentosBolivia;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

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

  DatosEntrada         = class;                 { "http://tempuri.org/"[GblCplx] }
  DatosSalida          = class;                 { "http://tempuri.org/"[GblCplx] }



  // ************************************************************************ //
  // XML       : DatosEntrada, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  DatosEntrada = class(TRemotable)
  private
    FUSUARIO: string;
    FUSUARIO_Specified: boolean;
    FCLAVE: string;
    FCLAVE_Specified: boolean;
    FOPERADOR: string;
    FOPERADOR_Specified: boolean;
    FCODPAIS: string;
    FCODPAIS_Specified: boolean;
    FNOMBRE1: string;
    FNOMBRE1_Specified: boolean;
    FNOMBRE2: string;
    FNOMBRE2_Specified: boolean;
    FAPELLIDO1: string;
    FAPELLIDO1_Specified: boolean;
    FAPELLIDO2: string;
    FAPELLIDO2_Specified: boolean;
    FNUMDOC: string;
    FNUMDOC_Specified: boolean;
    FPUESTOCONTROL: string;
    FPUESTOCONTROL_Specified: boolean;
    FTIPODOC: string;
    FTIPODOC_Specified: boolean;
    FEMISORDOC: string;
    FEMISORDOC_Specified: boolean;
    FFECHANAC: string;
    FFECHANAC_Specified: boolean;
    FGENERO: string;
    FGENERO_Specified: boolean;
    FNACIONALIDAD: string;
    FNACIONALIDAD_Specified: boolean;
    FNUMEROIDENIFICACION: string;
    FNUMEROIDENIFICACION_Specified: boolean;
    procedure SetUSUARIO(Index: Integer; const Astring: string);
    function  USUARIO_Specified(Index: Integer): boolean;
    procedure SetCLAVE(Index: Integer; const Astring: string);
    function  CLAVE_Specified(Index: Integer): boolean;
    procedure SetOPERADOR(Index: Integer; const Astring: string);
    function  OPERADOR_Specified(Index: Integer): boolean;
    procedure SetCODPAIS(Index: Integer; const Astring: string);
    function  CODPAIS_Specified(Index: Integer): boolean;
    procedure SetNOMBRE1(Index: Integer; const Astring: string);
    function  NOMBRE1_Specified(Index: Integer): boolean;
    procedure SetNOMBRE2(Index: Integer; const Astring: string);
    function  NOMBRE2_Specified(Index: Integer): boolean;
    procedure SetAPELLIDO1(Index: Integer; const Astring: string);
    function  APELLIDO1_Specified(Index: Integer): boolean;
    procedure SetAPELLIDO2(Index: Integer; const Astring: string);
    function  APELLIDO2_Specified(Index: Integer): boolean;
    procedure SetNUMDOC(Index: Integer; const Astring: string);
    function  NUMDOC_Specified(Index: Integer): boolean;
    procedure SetPUESTOCONTROL(Index: Integer; const Astring: string);
    function  PUESTOCONTROL_Specified(Index: Integer): boolean;
    procedure SetTIPODOC(Index: Integer; const Astring: string);
    function  TIPODOC_Specified(Index: Integer): boolean;
    procedure SetEMISORDOC(Index: Integer; const Astring: string);
    function  EMISORDOC_Specified(Index: Integer): boolean;
    procedure SetFECHANAC(Index: Integer; const Astring: string);
    function  FECHANAC_Specified(Index: Integer): boolean;
    procedure SetGENERO(Index: Integer; const Astring: string);
    function  GENERO_Specified(Index: Integer): boolean;
    procedure SetNACIONALIDAD(Index: Integer; const Astring: string);
    function  NACIONALIDAD_Specified(Index: Integer): boolean;
    procedure SetNUMEROIDENIFICACION(Index: Integer; const Astring: string);
    function  NUMEROIDENIFICACION_Specified(Index: Integer): boolean;
  published
    property USUARIO:             string  Index (IS_OPTN) read FUSUARIO write SetUSUARIO stored USUARIO_Specified;
    property CLAVE:               string  Index (IS_OPTN) read FCLAVE write SetCLAVE stored CLAVE_Specified;
    property OPERADOR:            string  Index (IS_OPTN) read FOPERADOR write SetOPERADOR stored OPERADOR_Specified;
    property CODPAIS:             string  Index (IS_OPTN) read FCODPAIS write SetCODPAIS stored CODPAIS_Specified;
    property NOMBRE1:             string  Index (IS_OPTN) read FNOMBRE1 write SetNOMBRE1 stored NOMBRE1_Specified;
    property NOMBRE2:             string  Index (IS_OPTN) read FNOMBRE2 write SetNOMBRE2 stored NOMBRE2_Specified;
    property APELLIDO1:           string  Index (IS_OPTN) read FAPELLIDO1 write SetAPELLIDO1 stored APELLIDO1_Specified;
    property APELLIDO2:           string  Index (IS_OPTN) read FAPELLIDO2 write SetAPELLIDO2 stored APELLIDO2_Specified;
    property NUMDOC:              string  Index (IS_OPTN) read FNUMDOC write SetNUMDOC stored NUMDOC_Specified;
    property PUESTOCONTROL:       string  Index (IS_OPTN) read FPUESTOCONTROL write SetPUESTOCONTROL stored PUESTOCONTROL_Specified;
    property TIPODOC:             string  Index (IS_OPTN) read FTIPODOC write SetTIPODOC stored TIPODOC_Specified;
    property EMISORDOC:           string  Index (IS_OPTN) read FEMISORDOC write SetEMISORDOC stored EMISORDOC_Specified;
    property FECHANAC:            string  Index (IS_OPTN) read FFECHANAC write SetFECHANAC stored FECHANAC_Specified;
    property GENERO:              string  Index (IS_OPTN) read FGENERO write SetGENERO stored GENERO_Specified;
    property NACIONALIDAD:        string  Index (IS_OPTN) read FNACIONALIDAD write SetNACIONALIDAD stored NACIONALIDAD_Specified;
    property NUMEROIDENIFICACION: string  Index (IS_OPTN) read FNUMEROIDENIFICACION write SetNUMEROIDENIFICACION stored NUMEROIDENIFICACION_Specified;
  end;



  // ************************************************************************ //
  // XML       : DatosSalida, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  DatosSalida = class(TRemotable)
  private
    FCOD_RTA: string;
    FCOD_RTA_Specified: boolean;
    FCOD_DETALLE_RTA: string;
    FCOD_DETALLE_RTA_Specified: boolean;
    procedure SetCOD_RTA(Index: Integer; const Astring: string);
    function  COD_RTA_Specified(Index: Integer): boolean;
    procedure SetCOD_DETALLE_RTA(Index: Integer; const Astring: string);
    function  COD_DETALLE_RTA_Specified(Index: Integer): boolean;
  published
    property COD_RTA:         string  Index (IS_OPTN) read FCOD_RTA write SetCOD_RTA stored COD_RTA_Specified;
    property COD_DETALLE_RTA: string  Index (IS_OPTN) read FCOD_DETALLE_RTA write SetCOD_DETALLE_RTA stored COD_DETALLE_RTA_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/ConsultaImpedimentosBolivia
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : wsImpedimentosBoliviaSoap
  // service   : wsImpedimentosBolivia
  // port      : wsImpedimentosBoliviaSoap
  // URL       : http://servicios.migracion.gob.bo/wsArgentina/wsImpedimentosBolivia.asmx
  // ************************************************************************ //
  wsImpedimentosBoliviaSoap = interface(IInvokable)
  ['{AC63E05F-4A20-A7A6-F494-56F0FE8EFC1F}']
    function  ConsultaImpedimentosBolivia(const Consulta: DatosEntrada): DatosSalida; stdcall;
  end;

function GetwsImpedimentosBoliviaSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): wsImpedimentosBoliviaSoap;


implementation
  uses System.SysUtils;

function GetwsImpedimentosBoliviaSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): wsImpedimentosBoliviaSoap;
const
  defWSDL = ''; //http://servicios.migracion.gob.bo/wsArgentina/wsImpedimentosBolivia.asmx?wsdl
  defURL  = ''; //http://servicios.migracion.gob.bo/wsArgentina/wsImpedimentosBolivia.asmx
  defSvc  = 'wsImpedimentosBolivia';
  defPrt  = 'wsImpedimentosBoliviaSoap';
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
    Result := (RIO as wsImpedimentosBoliviaSoap);
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


procedure DatosEntrada.SetUSUARIO(Index: Integer; const Astring: string);
begin
  FUSUARIO := Astring;
  FUSUARIO_Specified := True;
end;

function DatosEntrada.USUARIO_Specified(Index: Integer): boolean;
begin
  Result := FUSUARIO_Specified;
end;

procedure DatosEntrada.SetCLAVE(Index: Integer; const Astring: string);
begin
  FCLAVE := Astring;
  FCLAVE_Specified := True;
end;

function DatosEntrada.CLAVE_Specified(Index: Integer): boolean;
begin
  Result := FCLAVE_Specified;
end;

procedure DatosEntrada.SetOPERADOR(Index: Integer; const Astring: string);
begin
  FOPERADOR := Astring;
  FOPERADOR_Specified := True;
end;

function DatosEntrada.OPERADOR_Specified(Index: Integer): boolean;
begin
  Result := FOPERADOR_Specified;
end;

procedure DatosEntrada.SetCODPAIS(Index: Integer; const Astring: string);
begin
  FCODPAIS := Astring;
  FCODPAIS_Specified := True;
end;

function DatosEntrada.CODPAIS_Specified(Index: Integer): boolean;
begin
  Result := FCODPAIS_Specified;
end;

procedure DatosEntrada.SetNOMBRE1(Index: Integer; const Astring: string);
begin
  FNOMBRE1 := Astring;
  FNOMBRE1_Specified := True;
end;

function DatosEntrada.NOMBRE1_Specified(Index: Integer): boolean;
begin
  Result := FNOMBRE1_Specified;
end;

procedure DatosEntrada.SetNOMBRE2(Index: Integer; const Astring: string);
begin
  FNOMBRE2 := Astring;
  FNOMBRE2_Specified := True;
end;

function DatosEntrada.NOMBRE2_Specified(Index: Integer): boolean;
begin
  Result := FNOMBRE2_Specified;
end;

procedure DatosEntrada.SetAPELLIDO1(Index: Integer; const Astring: string);
begin
  FAPELLIDO1 := Astring;
  FAPELLIDO1_Specified := True;
end;

function DatosEntrada.APELLIDO1_Specified(Index: Integer): boolean;
begin
  Result := FAPELLIDO1_Specified;
end;

procedure DatosEntrada.SetAPELLIDO2(Index: Integer; const Astring: string);
begin
  FAPELLIDO2 := Astring;
  FAPELLIDO2_Specified := True;
end;

function DatosEntrada.APELLIDO2_Specified(Index: Integer): boolean;
begin
  Result := FAPELLIDO2_Specified;
end;

procedure DatosEntrada.SetNUMDOC(Index: Integer; const Astring: string);
begin
  FNUMDOC := Astring;
  FNUMDOC_Specified := True;
end;

function DatosEntrada.NUMDOC_Specified(Index: Integer): boolean;
begin
  Result := FNUMDOC_Specified;
end;

procedure DatosEntrada.SetPUESTOCONTROL(Index: Integer; const Astring: string);
begin
  FPUESTOCONTROL := Astring;
  FPUESTOCONTROL_Specified := True;
end;

function DatosEntrada.PUESTOCONTROL_Specified(Index: Integer): boolean;
begin
  Result := FPUESTOCONTROL_Specified;
end;

procedure DatosEntrada.SetTIPODOC(Index: Integer; const Astring: string);
begin
  FTIPODOC := Astring;
  FTIPODOC_Specified := True;
end;

function DatosEntrada.TIPODOC_Specified(Index: Integer): boolean;
begin
  Result := FTIPODOC_Specified;
end;

procedure DatosEntrada.SetEMISORDOC(Index: Integer; const Astring: string);
begin
  FEMISORDOC := Astring;
  FEMISORDOC_Specified := True;
end;

function DatosEntrada.EMISORDOC_Specified(Index: Integer): boolean;
begin
  Result := FEMISORDOC_Specified;
end;

procedure DatosEntrada.SetFECHANAC(Index: Integer; const Astring: string);
begin
  FFECHANAC := Astring;
  FFECHANAC_Specified := True;
end;

function DatosEntrada.FECHANAC_Specified(Index: Integer): boolean;
begin
  Result := FFECHANAC_Specified;
end;

procedure DatosEntrada.SetGENERO(Index: Integer; const Astring: string);
begin
  FGENERO := Astring;
  FGENERO_Specified := True;
end;

function DatosEntrada.GENERO_Specified(Index: Integer): boolean;
begin
  Result := FGENERO_Specified;
end;

procedure DatosEntrada.SetNACIONALIDAD(Index: Integer; const Astring: string);
begin
  FNACIONALIDAD := Astring;
  FNACIONALIDAD_Specified := True;
end;

function DatosEntrada.NACIONALIDAD_Specified(Index: Integer): boolean;
begin
  Result := FNACIONALIDAD_Specified;
end;

procedure DatosEntrada.SetNUMEROIDENIFICACION(Index: Integer; const Astring: string);
begin
  FNUMEROIDENIFICACION := Astring;
  FNUMEROIDENIFICACION_Specified := True;
end;

function DatosEntrada.NUMEROIDENIFICACION_Specified(Index: Integer): boolean;
begin
  Result := FNUMEROIDENIFICACION_Specified;
end;

procedure DatosSalida.SetCOD_RTA(Index: Integer; const Astring: string);
begin
  FCOD_RTA := Astring;
  FCOD_RTA_Specified := True;
end;

function DatosSalida.COD_RTA_Specified(Index: Integer): boolean;
begin
  Result := FCOD_RTA_Specified;
end;

procedure DatosSalida.SetCOD_DETALLE_RTA(Index: Integer; const Astring: string);
begin
  FCOD_DETALLE_RTA := Astring;
  FCOD_DETALLE_RTA_Specified := True;
end;

function DatosSalida.COD_DETALLE_RTA_Specified(Index: Integer): boolean;
begin
  Result := FCOD_DETALLE_RTA_Specified;
end;

initialization
  { wsImpedimentosBoliviaSoap }
  InvRegistry.RegisterInterface(TypeInfo(wsImpedimentosBoliviaSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(wsImpedimentosBoliviaSoap), 'http://tempuri.org/ConsultaImpedimentosBolivia');
  InvRegistry.RegisterInvokeOptions(TypeInfo(wsImpedimentosBoliviaSoap), ioDocument);
  { wsImpedimentosBoliviaSoap.ConsultaImpedimentosBolivia }
  InvRegistry.RegisterMethodInfo(TypeInfo(wsImpedimentosBoliviaSoap), 'ConsultaImpedimentosBolivia', '',
                                 '[ReturnName="ConsultaImpedimentosBoliviaResult"]', IS_OPTN);
  RemClassRegistry.RegisterXSClass(DatosEntrada, 'http://tempuri.org/', 'DatosEntrada');
  RemClassRegistry.RegisterXSClass(DatosSalida, 'http://tempuri.org/', 'DatosSalida');

end.