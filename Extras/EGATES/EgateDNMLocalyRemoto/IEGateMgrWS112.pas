// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://localhost:8080/wsdl/IEGateMgrWS
//  >Import : http://localhost:8080/wsdl/IEGateMgrWS>0
//  >Import : http://localhost:8080/wsdl/IEGateMgrWS>1
// Version  : 1.0
// (16/08/2019 15:10:08 - - $Rev: 69934 $)
// ************************************************************************ //

unit IEGateMgrWS112;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns,Classes;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"[Gbl]

  Transaction          = class;                 { "http://common.egate.sol.nec.com.ar"[GblCplx] }
  PersonData           = class;                 { "http://common.egate.sol.nec.com.ar"[GblCplx] }
  TransactionClosure   = class;                 { "http://common.egate.sol.nec.com.ar"[GblCplx] }
  TransactionError     = class;                 { "http://common.egate.sol.nec.com.ar"[GblCplx] }
  Event                = class;                 { "http://common.egate.sol.nec.com.ar"[GblCplx] }
  TransactionResult    = class;                 { "http://common.egate.sol.nec.com.ar"[GblCplx] }
  BiometricData        = class;                 { "http://common.egate.sol.nec.com.ar"[GblCplx] }
  DocumentImage        = class;                 { "http://common.egate.sol.nec.com.ar"[GblCplx] }
  FaceData             = class;                 { "http://common.egate.sol.nec.com.ar"[GblCplx] }

  ArrayOf_tns1_Event = array of Event;          { "http://ws.egate.sol.nec.com.ar"[GblCplx] }
  ArrayOf_tns1_TransactionError = array of TransactionError;   { "http://ws.egate.sol.nec.com.ar"[GblCplx] }
  ArrayOf_tns1_DocumentImage = array of DocumentImage;   { "http://ws.egate.sol.nec.com.ar"[GblCplx] }


  // ************************************************************************ //
  // XML       : Transaction, global, <complexType>
  // Namespace : http://common.egate.sol.nec.com.ar
  // ************************************************************************ //
  Transaction = class(TRemotable)
  private
    FMRZ: string;
    FdocumentImages: ArrayOf_tns1_DocumentImage;
    FegateId: string;
    FgateGroup: string;
    FtransactionId: string;
  public
    destructor Destroy; override;
  published
    property MRZ:            string                      read FMRZ write FMRZ;
    property documentImages: ArrayOf_tns1_DocumentImage  read FdocumentImages write FdocumentImages;
    property egateId:        string                      read FegateId write FegateId;
    property gateGroup:      string                      read FgateGroup write FgateGroup;
    property transactionId:  string                      read FtransactionId write FtransactionId;
  end;



  // ************************************************************************ //
  // XML       : PersonData, global, <complexType>
  // Namespace : http://common.egate.sol.nec.com.ar
  // ************************************************************************ //
  PersonData = class(TRemotable)
  private
    Fdob: string;
    FdocNumber: string;
    FdocType: string;
    FfirstName: string;
    FissuingCountry: string;
    FlastName: string;
    Fnationality: string;
    FpassportNumber: string;
    Fsex: string;
    FsubDocType: string;
  published
    property dob:            string  read Fdob write Fdob;
    property docNumber:      string  read FdocNumber write FdocNumber;
    property docType:        string  read FdocType write FdocType;
    property firstName:      string  read FfirstName write FfirstName;
    property issuingCountry: string  read FissuingCountry write FissuingCountry;
    property lastName:       string  read FlastName write FlastName;
    property nationality:    string  read Fnationality write Fnationality;
    property passportNumber: string  read FpassportNumber write FpassportNumber;
    property sex:            string  read Fsex write Fsex;
    property subDocType:     string  read FsubDocType write FsubDocType;
  end;



  // ************************************************************************ //
  // XML       : TransactionClosure, global, <complexType>
  // Namespace : http://common.egate.sol.nec.com.ar
  // ************************************************************************ //
  TransactionClosure = class(TRemotable)
  private
    FegateId: string;
    FeventLog: ArrayOf_tns1_Event;
    FfaceMatchHit: Integer;
    FfaceMatchScore: Integer;
    FlocalElegibilityFailed: Integer;
    FmanualDoorOpened: Integer;
    FtransactionId: string;
  public
    destructor Destroy; override;
  published
    property egateId:                string              read FegateId write FegateId;
    property eventLog:               ArrayOf_tns1_Event  read FeventLog write FeventLog;
    property faceMatchHit:           Integer             read FfaceMatchHit write FfaceMatchHit;
    property faceMatchScore:         Integer             read FfaceMatchScore write FfaceMatchScore;
    property localElegibilityFailed: Integer             read FlocalElegibilityFailed write FlocalElegibilityFailed;
    property manualDoorOpened:       Integer             read FmanualDoorOpened write FmanualDoorOpened;
    property transactionId:          string              read FtransactionId write FtransactionId;
  end;



  // ************************************************************************ //
  // XML       : TransactionError, global, <complexType>
  // Namespace : http://common.egate.sol.nec.com.ar
  // ************************************************************************ //
  TransactionError = class(TRemotable)
  private
    FerrorCode: Integer;
    FerrorDescription: string;
    FerrorName: string;
  published
    property errorCode:        Integer  read FerrorCode write FerrorCode;
    property errorDescription: string   read FerrorDescription write FerrorDescription;
    property errorName:        string   read FerrorName write FerrorName;
  end;



  // ************************************************************************ //
  // XML       : Event, global, <complexType>
  // Namespace : http://common.egate.sol.nec.com.ar
  // ************************************************************************ //
  Event = class(TRemotable)
  private
    Fdate: TXSDateTime;
    FeventDesc: string;
    FeventType: Integer;
  public
    destructor Destroy; override;
  published
    property date:      TXSDateTime  read Fdate write Fdate;
    property eventDesc: string       read FeventDesc write FeventDesc;
    property eventType: Integer      read FeventType write FeventType;
  end;



  // ************************************************************************ //
  // XML       : TransactionResult, global, <complexType>
  // Namespace : http://common.egate.sol.nec.com.ar
  // ************************************************************************ //
  TransactionResult = class(TRemotable)
  private
    FpersonData: PersonData;
    FtransactionErrors: ArrayOf_tns1_TransactionError;
    FtransactionId: string;
    FtransactionResultCode: Integer;
    FtransactionStatus: string;
  public
    destructor Destroy; override;
  published
    property personData:            PersonData                     read FpersonData write FpersonData;
    property transactionErrors:     ArrayOf_tns1_TransactionError  read FtransactionErrors write FtransactionErrors;
    property transactionId:         string                         read FtransactionId write FtransactionId;
    property transactionResultCode: Integer                        read FtransactionResultCode write FtransactionResultCode;
    property transactionStatus:     string                         read FtransactionStatus write FtransactionStatus;
  end;



  // ************************************************************************ //
  // XML       : BiometricData, global, <complexType>
  // Namespace : http://common.egate.sol.nec.com.ar
  // ************************************************************************ //
  BiometricData = class(TRemotable)
  private
    Fallowed: Boolean;
    FfaceImage: TByteDynArray;
    FfingerprintImage: TByteDynArray;
    Ftransport: string;
  published
    property allowed:          Boolean        read Fallowed write Fallowed;
    property faceImage:        TByteDynArray  read FfaceImage write FfaceImage;
    property fingerprintImage: TByteDynArray  read FfingerprintImage write FfingerprintImage;
    property transport:        string         read Ftransport write Ftransport;
  end;



  // ************************************************************************ //
  // XML       : DocumentImage, global, <complexType>
  // Namespace : http://common.egate.sol.nec.com.ar
  // ************************************************************************ //
  DocumentImage = class(TRemotable)
  private
    FdocumentImageType: Integer;
    Fimage: TByteDynArray;
  published
    property documentImageType: Integer        read FdocumentImageType write FdocumentImageType;
    property image:             TByteDynArray  read Fimage write Fimage;
  end;



  // ************************************************************************ //
  // XML       : FaceData, global, <complexType>
  // Namespace : http://common.egate.sol.nec.com.ar
  // ************************************************************************ //
  FaceData = class(TRemotable)
  private
    FegateId: string;
    Ffeature: TByteDynArray;
    Fimage: TByteDynArray;
    FtransactionId: string;
  published
    property egateId:       string         read FegateId write FegateId;
    property feature:       TByteDynArray  read Ffeature write Ffeature;
    property image:         TByteDynArray  read Fimage write Fimage;
    property transactionId: string         read FtransactionId write FtransactionId;
  end;


  // ************************************************************************ //
  // Namespace : http://ws.egate.sol.nec.com.ar
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : IEGateMgrWSbinding
  // service   : IEGateMgrWSservice
  // port      : IEGateMgrWSPort
  // URL       : http://localhost:8080/soap/IEGateMgrWS
  // ************************************************************************ //
  IEGateMgrWS = interface(IInvokable)
  ['{8958C337-74F6-A8D3-25EF-DB88C58189F7}']
    function  test(const a: string): string; stdcall;
    function  getBiometricData(const t: Transaction): BiometricData; stdcall;
    function  doMatch(const transaction: Transaction; const image: TByteDynArray): Integer; stdcall;
    function  closeTransaction(const t: TransactionClosure): TransactionResult; stdcall;
    function  initTransaction(const t: Transaction): TransactionResult; stdcall;
    function  watchListSearch(const fa: FaceData): Boolean; stdcall;
  end;

  TDebug = class
    procedure HTTPRIO1BeforeExecute(const MethodName: string; SOAPRequest: TStream);
    procedure HTTPRIO1AfterExecute(const MethodName: string; SOAPResponse: TStream);
  end;


function GetIEGateMgrWS(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IEGateMgrWS;


implementation
  uses System.SysUtils,UTest;




function GetIEGateMgrWS(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IEGateMgrWS;
const

  defSvc  = 'IEGateMgrWSservice';
  defPrt  = 'IEGateMgrWSPort';

var
  defWSDL, defURL:string;

//  defWSDL = 'http://172.16.192.151:8080/wsdl/IEGateMgrWS';
//  defURL  = 'http://172.16.192.151:8080/soap/IEGateMgrWS';

  RIO: THTTPRIO;
  D:TDebug;
begin

  defWSDL := 'http://10.100.121.78:'+Form1.edtWSP.Text+'/wsdl/IEGateMgrWS'; //MI PC
  defURL  := 'http://10.100.121.78:'+Form1.edtWSP.Text+'/soap/IEGateMgrWS';


  D:=TDebug.Create;
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

  RIO.OnAfterExecute := D.HTTPRIO1AfterExecute;
  RIO.OnBeforeExecute := D.HTTPRIO1BeforeExecute;

  try
    Result := (RIO as IEGateMgrWS);
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


destructor Transaction.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FdocumentImages)-1 do
    System.SysUtils.FreeAndNil(FdocumentImages[I]);
  System.SetLength(FdocumentImages, 0);
  inherited Destroy;
end;

destructor TransactionClosure.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FeventLog)-1 do
    System.SysUtils.FreeAndNil(FeventLog[I]);
  System.SetLength(FeventLog, 0);
  inherited Destroy;
end;

destructor Event.Destroy;
begin
  System.SysUtils.FreeAndNil(Fdate);
  inherited Destroy;
end;

destructor TransactionResult.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FtransactionErrors)-1 do
    System.SysUtils.FreeAndNil(FtransactionErrors[I]);
  System.SetLength(FtransactionErrors, 0);
  System.SysUtils.FreeAndNil(FpersonData);
  inherited Destroy;
end;

{ TDebug }

procedure archivo(nom,m,dato:String);
var
  strL:TStringList;
begin
  strL:=TStringList.Create;
  try
    if FileExists(nom) then
      strL.LoadFromFile(nom);

    strL.Text :=strL.Text + #13#10 + '************ '+m+' ****************'+#13#10+dato;

    strL.SaveToFile(nom);
  finally
    strL.Free;
  end;

end;


procedure TDebug.HTTPRIO1AfterExecute(const MethodName: string;
  SOAPResponse: TStream);
var
  StrStr: TStringStream;
begin
  StrStr := TStringStream.Create('');
  try
    StrStr.CopyFrom(SOAPResponse, 0);
    archivo('SOAPResponse.txt',MethodName,StrStr.DataString);
  finally
    StrStr.Free;
  end;
end;

procedure TDebug.HTTPRIO1BeforeExecute(const MethodName: string;
  SOAPRequest: TStream);
var
  StrStr: TStringStream;
begin
  StrStr := TStringStream.Create('');
  try
    StrStr.CopyFrom(SOAPRequest, 0);
    archivo('SOAPRequest.txt',MethodName,StrStr.DataString);
  finally
    StrStr.Free;
  end;

end;

initialization
  { IEGateMgrWS }
  InvRegistry.RegisterInterface(TypeInfo(IEGateMgrWS), 'http://ws.egate.sol.nec.com.ar', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IEGateMgrWS), '');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOf_tns1_Event), 'http://ws.egate.sol.nec.com.ar', 'ArrayOf_tns1_Event');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOf_tns1_TransactionError), 'http://ws.egate.sol.nec.com.ar', 'ArrayOf_tns1_TransactionError');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOf_tns1_DocumentImage), 'http://ws.egate.sol.nec.com.ar', 'ArrayOf_tns1_DocumentImage');
  RemClassRegistry.RegisterXSClass(Transaction, 'http://common.egate.sol.nec.com.ar', 'Transaction');
  RemClassRegistry.RegisterXSClass(PersonData, 'http://common.egate.sol.nec.com.ar', 'PersonData');
  RemClassRegistry.RegisterXSClass(TransactionClosure, 'http://common.egate.sol.nec.com.ar', 'TransactionClosure');
  RemClassRegistry.RegisterXSClass(TransactionError, 'http://common.egate.sol.nec.com.ar', 'TransactionError');
  RemClassRegistry.RegisterXSClass(Event, 'http://common.egate.sol.nec.com.ar', 'Event');
  RemClassRegistry.RegisterXSClass(TransactionResult, 'http://common.egate.sol.nec.com.ar', 'TransactionResult');
  RemClassRegistry.RegisterXSClass(BiometricData, 'http://common.egate.sol.nec.com.ar', 'BiometricData');
  RemClassRegistry.RegisterXSClass(DocumentImage, 'http://common.egate.sol.nec.com.ar', 'DocumentImage');
  RemClassRegistry.RegisterXSClass(FaceData, 'http://common.egate.sol.nec.com.ar', 'FaceData');

end.