// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://172.16.0.48/cgi-bin/wsbiometricdevices/wsbiometricdevices/wsdl/Iwsbiometricdevices
//  >Import : http://172.16.0.48/cgi-bin/wsbiometricdevices/wsbiometricdevices/wsdl/Iwsbiometricdevices>0
// Encoding : utf-8
// Version  : 1.0
// (05/06/2019 14:24:12 - - $Rev: 69934 $)
// ************************************************************************ //

unit Iwsbiometricdevices1;

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

  TResponse            = class;                 { "urn:wsbiometricdevicesIntf"[GblCplx] }
  TPerson              = class;                 { "urn:wsbiometricdevicesIntf"[GblCplx] }



  // ************************************************************************ //
  // XML       : TResponse, global, <complexType>
  // Namespace : urn:wsbiometricdevicesIntf
  // ************************************************************************ //
  TResponse = class(TRemotable)
  private
    Fcode: AnsiString;
    FdescriptionCode: AnsiString;
    FdataSource: AnsiString;
    FfingerWsq: AnsiString;
    FfaseJpg: AnsiString;
  published
    property code:            AnsiString  read Fcode write Fcode;
    property descriptionCode: AnsiString  read FdescriptionCode write FdescriptionCode;
    property dataSource:      AnsiString  read FdataSource write FdataSource;
    property fingerWsq:       AnsiString  read FfingerWsq write FfingerWsq;
    property faseJpg:         AnsiString  read FfaseJpg write FfaseJpg;
  end;



  // ************************************************************************ //
  // XML       : TPerson, global, <complexType>
  // Namespace : urn:wsbiometricdevicesIntf
  // ************************************************************************ //
  TPerson = class(TRemotable)
  private
    Fdoc_type: string;
    Fissuing_country: string;
    Fsub_doc_type: string;
    Fnationality: string;
    Fnumber: string;
    Fsex: string;
  published
    property doc_type:        string  read Fdoc_type write Fdoc_type;
    property issuing_country: string  read Fissuing_country write Fissuing_country;
    property sub_doc_type:    string  read Fsub_doc_type write Fsub_doc_type;
    property nationality:     string  read Fnationality write Fnationality;
    property number:          string  read Fnumber write Fnumber;
    property sex:             string  read Fsex write Fsex;
  end;


  // ************************************************************************ //
  // Namespace : urn:wsbiometricdevicesIntf-Iwsbiometricdevices
  // soapAction: urn:wsbiometricdevicesIntf-Iwsbiometricdevices#getBiometricData
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : Iwsbiometricdevicesbinding
  // service   : Iwsbiometricdevicesservice
  // port      : IwsbiometricdevicesPort
  // URL       : http://172.16.0.48/cgi-bin/wsbiometricdevices/wsbiometricdevices/soap/Iwsbiometricdevices
  // ************************************************************************ //
  Iwsbiometricdevices = interface(IInvokable)
  ['{90F8A68C-9AC9-1D5B-D964-674D677C0C63}']
    function  getBiometricData(const person: TPerson): TResponse; stdcall;
  end;

function GetIwsbiometricdevices(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): Iwsbiometricdevices;


implementation
  uses System.SysUtils,uGlobal;

function GetIwsbiometricdevices(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): Iwsbiometricdevices;
const
  defSvc  = 'Iwsbiometricdevicesservice';
  defPrt  = 'IwsbiometricdevicesPort';
var
  RIO: THTTPRIO;
begin
  Addr := wsbiometricdevices;

  Result := nil;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as Iwsbiometricdevices);
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
  { Iwsbiometricdevices }
  InvRegistry.RegisterInterface(TypeInfo(Iwsbiometricdevices), 'urn:wsbiometricdevicesIntf-Iwsbiometricdevices', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(Iwsbiometricdevices), 'urn:wsbiometricdevicesIntf-Iwsbiometricdevices#getBiometricData');
  RemClassRegistry.RegisterXSClass(TResponse, 'urn:wsbiometricdevicesIntf', 'TResponse');
  RemClassRegistry.RegisterXSClass(TPerson, 'urn:wsbiometricdevicesIntf', 'TPerson');

end.