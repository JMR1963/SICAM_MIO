// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\Documents and Settings\mgranaras\Escritorio\AA2000\wsaa2000\FlightsOp.xml
//  >Import : C:\Documents and Settings\mgranaras\Escritorio\AA2000\wsaa2000\FlightsOp.xml:0
// Encoding : UTF-8
// Version  : 1.0
// (14/08/2007 18:58:50 - - $Rev: 5569 $)
// ************************************************************************ //

unit uAA2000;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, system.Types, Soap.XSBuiltIns, Soap.SOAPHTTPTrans, WinApi.WinInet;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_NLBL = $0004;
  IS_UNQL = $0008;
  IS_ATTR = $0010;
  IS_TEXT = $0020;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"

  FlightOp             = class;                 { "https://www.tams.com.ar/"[GblCplx] }

  ArrayOfFlightOp = array of FlightOp;          { "https://www.tams.com.ar/"[GblCplx] }

  Puntero = Pointer;
  // ************************************************************************ //
  // XML       : FlightOp, global, <complexType>
  // Namespace : https://www.tams.com.ar/
  // ************************************************************************ //
  FlightOp = class(TRemotable)
  private
    FAirline: WideString;
    FAirline_Specified: boolean;
    FId_Airline: WideString;
    FId_Airline_Specified: boolean;
    FFlight: WideString;
    FFlight_Specified: boolean;
    FMovTp: WideString;
    FMovTp_Specified: boolean;
    FDestino: WideString;
    FDestino_Specified: boolean;
    FDestDesc: WideString;
    FDestDesc_Specified: boolean;
    FOrigen: WideString;
    FOrigen_Specified: boolean;
    FOrigDesc: WideString;
    FOrigDesc_Specified: boolean;
    FStda: WideString;
    FStda_Specified: boolean;
    FAtda: WideString;
    FAtda_Specified: boolean;
    FVia: WideString;
    FVia_Specified: boolean;
    FPax: WideString;
    FPax_Specified: boolean;
    procedure SetAirline(Index: Integer; const AWideString: WideString);
    function  Airline_Specified(Index: Integer): boolean;
    procedure SetId_Airline(Index: Integer; const AWideString: WideString);
    function  Id_Airline_Specified(Index: Integer): boolean;
    procedure SetFlight(Index: Integer; const AWideString: WideString);
    function  Flight_Specified(Index: Integer): boolean;
    procedure SetMovTp(Index: Integer; const AWideString: WideString);
    function  MovTp_Specified(Index: Integer): boolean;
    procedure SetDestino(Index: Integer; const AWideString: WideString);
    function  Destino_Specified(Index: Integer): boolean;
    procedure SetDestDesc(Index: Integer; const AWideString: WideString);
    function  DestDesc_Specified(Index: Integer): boolean;
    procedure SetOrigen(Index: Integer; const AWideString: WideString);
    function  Origen_Specified(Index: Integer): boolean;
    procedure SetOrigDesc(Index: Integer; const AWideString: WideString);
    function  OrigDesc_Specified(Index: Integer): boolean;
    procedure SetStda(Index: Integer; const AWideString: WideString);
    function  Stda_Specified(Index: Integer): boolean;
    procedure SetAtda(Index: Integer; const AWideString: WideString);
    function  Atda_Specified(Index: Integer): boolean;
    procedure SetVia(Index: Integer; const AWideString: WideString);
    function  Via_Specified(Index: Integer): boolean;
    procedure SetPax(Index: Integer; const AWideString: WideString);
    function  Pax_Specified(Index: Integer): boolean;
  published
    property Airline:    WideString  Index (IS_OPTN) read FAirline write SetAirline stored Airline_Specified;
    property Id_Airline: WideString  Index (IS_OPTN) read FId_Airline write SetId_Airline stored Id_Airline_Specified;
    property Flight:     WideString  Index (IS_OPTN) read FFlight write SetFlight stored Flight_Specified;
    property MovTp:      WideString  Index (IS_OPTN) read FMovTp write SetMovTp stored MovTp_Specified;
    property Destino:    WideString  Index (IS_OPTN) read FDestino write SetDestino stored Destino_Specified;
    property DestDesc:   WideString  Index (IS_OPTN) read FDestDesc write SetDestDesc stored DestDesc_Specified;
    property Origen:     WideString  Index (IS_OPTN) read FOrigen write SetOrigen stored Origen_Specified;
    property OrigDesc:   WideString  Index (IS_OPTN) read FOrigDesc write SetOrigDesc stored OrigDesc_Specified;
    property Stda:       WideString  Index (IS_OPTN) read FStda write SetStda stored Stda_Specified;
    property Atda:       WideString  Index (IS_OPTN) read FAtda write SetAtda stored Atda_Specified;
    property Via:        WideString  Index (IS_OPTN) read FVia write SetVia stored Via_Specified;
    property Pax:        WideString  Index (IS_OPTN) read FPax write SetPax stored Pax_Specified;
  end;


  // ************************************************************************ //
  // Namespace : https://www.tams.com.ar/
  // soapAction: https://www.tams.com.ar/GetFlightsOp
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : FlightsOpSoap
  // service   : FlightsOp
  // port      : FlightsOpSoap
  // URL       : https://www.tams.com.ar/servicios/FlightsOp.asmx
  // ************************************************************************ //
  FlightsOpSoap = interface(IInvokable)
  ['{5731F5DF-9ED9-B7C0-F1D7-417D0553375F}']
    function GetFlightsOp(const idarpt: String): ArrayOfFlightOp; stdcall;
  end;

function GetFlightsOpSoap(UseWSDL : Boolean;
                          Protocol,
                          IPAddress,
                          Path,
                          ProxyIP,
                          ProxyPort : String;
                          HTTPRIO : THTTPRIO) : FlightsOpSoap;
                      
implementation

uses
  System.SysUtils, vcl.Dialogs;

function GetFlightsOpSoap(UseWSDL : Boolean;
                          Protocol,
                          IPAddress,
                          Path,
                          ProxyIP,
                          ProxyPort : String;
                          HTTPRIO : THTTPRIO) : FlightsOpSoap;
const
  defSvc  = 'FlightsOp';
  defPrt  = 'FlightsOpSoap';
var
  RIO: THTTPRIO;
  Addr : String;
begin
  Result := nil;
  if UseWSDL then
    Addr := Format('%s://%s/%s?WSDL', [Protocol, IPAddress, Path])
  else
    Addr := Format('%s://%s/%s', [Protocol, IPAddress, Path]);
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    if (ProxyIP <> '') and (ProxyPort <> '') then
      RIO.HTTPWebNode.Proxy := Format('%s:%s', [ProxyIP, ProxyPort]);
    Result := (RIO as FlightsOpSoap);
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

procedure FlightOp.SetAirline(Index: Integer; const AWideString: WideString);
begin
  FAirline := AWideString;
  FAirline_Specified := True;
end;

function FlightOp.Airline_Specified(Index: Integer): boolean;
begin
  Result := FAirline_Specified;
end;

procedure FlightOp.SetId_Airline(Index: Integer; const AWideString: WideString);
begin
  FId_Airline := AWideString;
  FId_Airline_Specified := True;
end;

function FlightOp.Id_Airline_Specified(Index: Integer): boolean;
begin
  Result := FId_Airline_Specified;
end;

procedure FlightOp.SetFlight(Index: Integer; const AWideString: WideString);
begin
  FFlight := AWideString;
  FFlight_Specified := True;
end;

function FlightOp.Flight_Specified(Index: Integer): boolean;
begin
  Result := FFlight_Specified;
end;

procedure FlightOp.SetMovTp(Index: Integer; const AWideString: WideString);
begin
  FMovTp := AWideString;
  FMovTp_Specified := True;
end;

function FlightOp.MovTp_Specified(Index: Integer): boolean;
begin
  Result := FMovTp_Specified;
end;

procedure FlightOp.SetDestino(Index: Integer; const AWideString: WideString);
begin
  FDestino := AWideString;
  FDestino_Specified := True;
end;

function FlightOp.Destino_Specified(Index: Integer): boolean;
begin
  Result := FDestino_Specified;
end;

procedure FlightOp.SetDestDesc(Index: Integer; const AWideString: WideString);
begin
  FDestDesc := AWideString;
  FDestDesc_Specified := True;
end;

function FlightOp.DestDesc_Specified(Index: Integer): boolean;
begin
  Result := FDestDesc_Specified;
end;

procedure FlightOp.SetOrigen(Index: Integer; const AWideString: WideString);
begin
  FOrigen := AWideString;
  FOrigen_Specified := True;
end;

function FlightOp.Origen_Specified(Index: Integer): boolean;
begin
  Result := FOrigen_Specified;
end;

procedure FlightOp.SetOrigDesc(Index: Integer; const AWideString: WideString);
begin
  FOrigDesc := AWideString;
  FOrigDesc_Specified := True;
end;

function FlightOp.OrigDesc_Specified(Index: Integer): boolean;
begin
  Result := FOrigDesc_Specified;
end;

procedure FlightOp.SetStda(Index: Integer; const AWideString: WideString);
begin
  FStda := AWideString;
  FStda_Specified := True;
end;

function FlightOp.Stda_Specified(Index: Integer): boolean;
begin
  Result := FStda_Specified;
end;

procedure FlightOp.SetAtda(Index: Integer; const AWideString: WideString);
begin
  FAtda := AWideString;
  FAtda_Specified := True;
end;

function FlightOp.Atda_Specified(Index: Integer): boolean;
begin
  Result := FAtda_Specified;
end;

procedure FlightOp.SetVia(Index: Integer; const AWideString: WideString);
begin
  FVia := AWideString;
  FVia_Specified := True;
end;

function FlightOp.Via_Specified(Index: Integer): boolean;
begin
  Result := FVia_Specified;
end;

procedure FlightOp.SetPax(Index: Integer; const AWideString: WideString);
begin
  FPax := AWideString;
  FPax_Specified := True;
end;

function FlightOp.Pax_Specified(Index: Integer): boolean;
begin
  Result := FPax_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(FlightsOpSoap), 'https://www.tams.com.ar/', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(FlightsOpSoap), 'https://www.tams.com.ar/GetFlightsOp');
  InvRegistry.RegisterInvokeOptions(TypeInfo(FlightsOpSoap), ioDocument);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfFlightOp), 'https://www.tams.com.ar/', 'ArrayOfFlightOp');
  RemClassRegistry.RegisterXSClass(FlightOp, 'https://www.tams.com.ar/', 'FlightOp');

end.
