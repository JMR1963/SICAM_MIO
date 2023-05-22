// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\Users\lquadraccia\Desktop\j\nec.xml
//  >Import : C:\Users\lquadraccia\Desktop\j\nec.xml>0
// Encoding : ISO-8859-1
// Version  : 1.0
// (03/06/2019 19:14:31 - - $Rev: 69934 $)
// ************************************************************************ //

unit nec;

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
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"[Gbl]

  Transaction          = class;                 { "urn:EGateMgrWSIntf"[GblCplx] }
  PersonData           = class;                 { "urn:EGateMgrWSIntf"[GblCplx] }
  TransactionError     = class;                 { "urn:EGateMgrWSIntf"[GblCplx] }
  TransactionClousere  = class;                 { "urn:EGateMgrWSIntf"[GblCplx] }
  Event                = class;                 { "urn:EGateMgrWSIntf"[GblCplx] }
  TDocumentImage       = class;                 { "urn:EGateMgrWSIntf"[GblCplx] }
  FaceData             = class;                 { "urn:EGateMgrWSIntf"[GblCplx] }
  BiometricData        = class;                 { "urn:EGateMgrWSIntf"[GblCplx] }
  TransactionResult    = class;                 { "urn:EGateMgrWSIntf"[GblCplx] }

  TEvent     = array of Event;                  { "urn:EGateMgrWSIntf"[GblCplx] }
  TDocumentImages = array of TDocumentImage;    { "urn:EGateMgrWSIntf"[GblCplx] }


  // ************************************************************************ //
  // XML       : Transaction, global, <complexType>
  // Namespace : urn:EGateMgrWSIntf
  // ************************************************************************ //
  Transaction = class(TRemotable)
  private
    FtransactionId: string;
    FegateID: string;
    FMRZ: string;
    FDocumentImages: TDocumentImages;
  public
    destructor Destroy; override;
  published
    property transactionId:  string           read FtransactionId write FtransactionId;
    property egateID:        string           read FegateID write FegateID;
    property MRZ:            string           read FMRZ write FMRZ;
    property DocumentImages: TDocumentImages  read FDocumentImages write FDocumentImages;
  end;



  // ************************************************************************ //
  // XML       : PersonData, global, <complexType>
  // Namespace : urn:EGateMgrWSIntf
  // ************************************************************************ //
  PersonData = class(TRemotable)
  private
    FfirtName: string;
    FlastName: string;
    Fdob: string;
    FdocNumber: string;
    FpassportNumber: string;
    FdocType: string;
    FsubDoeType: string;
    FissuingCountry: string;
    Fnationality: string;
    Fsex: string;
  published
    property firtName:       string  read FfirtName write FfirtName;
    property lastName:       string  read FlastName write FlastName;
    property dob:            string  read Fdob write Fdob;
    property docNumber:      string  read FdocNumber write FdocNumber;
    property passportNumber: string  read FpassportNumber write FpassportNumber;
    property docType:        string  read FdocType write FdocType;
    property subDoeType:     string  read FsubDoeType write FsubDoeType;
    property issuingCountry: string  read FissuingCountry write FissuingCountry;
    property nationality:    string  read Fnationality write Fnationality;
    property sex:            string  read Fsex write Fsex;
  end;



  // ************************************************************************ //
  // XML       : TransactionError, global, <complexType>
  // Namespace : urn:EGateMgrWSIntf
  // ************************************************************************ //
  TransactionError = class(TRemotable)
  private
    FerrorCode: string;
    FerrorName: string;
    FerrorDescription: string;
  published
    property errorCode:        string  read FerrorCode write FerrorCode;
    property errorName:        string  read FerrorName write FerrorName;
    property errorDescription: string  read FerrorDescription write FerrorDescription;
  end;



  // ************************************************************************ //
  // XML       : TransactionClousere, global, <complexType>
  // Namespace : urn:EGateMgrWSIntf
  // ************************************************************************ //
  TransactionClousere = class(TRemotable)
  private
    Ftransactionld: string;
    Fegateld: string;
    FfaceMatchScore: Integer;
    FmanualDoorOpened: Integer;
    FeventLog: TEvent;
    FlocalElegibilityFailed: Integer;
    FfaceMatchHit: Integer;
  public
    destructor Destroy; override;
  published
    property transactionld:          string   read Ftransactionld write Ftransactionld;
    property egateld:                string   read Fegateld write Fegateld;
    property faceMatchScore:         Integer  read FfaceMatchScore write FfaceMatchScore;
    property manualDoorOpened:       Integer  read FmanualDoorOpened write FmanualDoorOpened;
    property eventLog:               TEvent   read FeventLog write FeventLog;
    property localElegibilityFailed: Integer  read FlocalElegibilityFailed write FlocalElegibilityFailed;
    property faceMatchHit:           Integer  read FfaceMatchHit write FfaceMatchHit;
  end;



  // ************************************************************************ //
  // XML       : Event, global, <complexType>
  // Namespace : urn:EGateMgrWSIntf
  // ************************************************************************ //
  Event = class(TRemotable)
  private
    FeventType: Integer;
    Fdate: TXSDateTime;
    FeventDesc: string;
  public
    destructor Destroy; override;
  published
    property eventType: Integer      read FeventType write FeventType;
    property date:      TXSDateTime  read Fdate write Fdate;
    property eventDesc: string       read FeventDesc write FeventDesc;
  end;

  TTransactionError = array of TransactionError;   { "urn:EGateMgrWSIntf"[GblCplx] }
  TPersonData = array of PersonData;            { "urn:EGateMgrWSIntf"[GblCplx] }


  // ************************************************************************ //
  // XML       : TDocumentImage, global, <complexType>
  // Namespace : urn:EGateMgrWSIntf
  // ************************************************************************ //
  TDocumentImage = class(TRemotable)
  private
    FdocumentImageType: Integer;
    FImage: TByteDynArray;
  published
    property documentImageType: Integer        read FdocumentImageType write FdocumentImageType;
    property Image:             TByteDynArray  read FImage write FImage;
  end;



  // ************************************************************************ //
  // XML       : FaceData, global, <complexType>
  // Namespace : urn:EGateMgrWSIntf
  // ************************************************************************ //
  FaceData = class(TRemotable)
  private
    Fimage: TByteDynArray;
    Ftransactionld: string;
    Fegateld: string;
    Ffeature: TByteDynArray;
  published
    property image:         TByteDynArray  read Fimage write Fimage;
    property transactionld: string         read Ftransactionld write Ftransactionld;
    property egateld:       string         read Fegateld write Fegateld;
    property feature:       TByteDynArray  read Ffeature write Ffeature;
  end;



  // ************************************************************************ //
  // XML       : BiometricData, global, <complexType>
  // Namespace : urn:EGateMgrWSIntf
  // ************************************************************************ //
  BiometricData = class(TRemotable)
  private
    Fallowed: Boolean;
    Ftransport: string;
    Ffingerprintlmage: TByteDynArray;
    Ffacelmage: TByteDynArray;
  published
    property allowed:          Boolean        read Fallowed write Fallowed;
    property transport:        string         read Ftransport write Ftransport;
    property fingerprintlmage: TByteDynArray  read Ffingerprintlmage write Ffingerprintlmage;
    property facelmage:        TByteDynArray  read Ffacelmage write Ffacelmage;
  end;



  // ************************************************************************ //
  // XML       : TransactionResult, global, <complexType>
  // Namespace : urn:EGateMgrWSIntf
  // ************************************************************************ //
  TransactionResult = class(TRemotable)
  private
    Ftransactionld: string;
    FtransactionStatus: string;
    FtransactionResultCode: Integer;
    FtransactionErrors: TTransactionError;
    FPersonData: TPersonData;
  public
    destructor Destroy; override;
  published
    property transactionld:         string             read Ftransactionld write Ftransactionld;
    property transactionStatus:     string             read FtransactionStatus write FtransactionStatus;
    property transactionResultCode: Integer            read FtransactionResultCode write FtransactionResultCode;
    property transactionErrors:     TTransactionError  read FtransactionErrors write FtransactionErrors;
    property PersonData:            TPersonData        read FPersonData write FPersonData;
  end;


  // ************************************************************************ //
  // Namespace : urn:EGateMgrWSIntf-IEGateMgrWS
  // soapAction: urn:EGateMgrWSIntf-IEGateMgrWS#%operationName%
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
    function  InitTransaction(const transaction: Transaction): TransactionResult; stdcall;
    function  getBiometricData(const transactionId: string; const egateId: string; const MRZ: string): BiometricData; stdcall;
    function  doMatch(const transaction: Transaction; const image: TByteDynArray): Integer; stdcall;
    function  watchListSearch(const faceData: FaceData): Boolean; stdcall;
    function  closeTransaction(const transactionClousere: TransactionClousere): TransactionResult; stdcall;
  end;

function GetIEGateMgrWS(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IEGateMgrWS;


implementation
  uses System.SysUtils;

function GetIEGateMgrWS(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IEGateMgrWS;
const
  defWSDL = 'C:\Users\lquadraccia\Desktop\j\nec.xml';
  defURL  = 'http://localhost:8080/soap/IEGateMgrWS';
  defSvc  = 'IEGateMgrWSservice';
  defPrt  = 'IEGateMgrWSPort';
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
  for I := 0 to System.Length(FDocumentImages)-1 do
    System.SysUtils.FreeAndNil(FDocumentImages[I]);
  System.SetLength(FDocumentImages, 0);
  inherited Destroy;
end;

destructor TransactionClousere.Destroy;
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
  for I := 0 to System.Length(FPersonData)-1 do
    System.SysUtils.FreeAndNil(FPersonData[I]);
  System.SetLength(FPersonData, 0);
  inherited Destroy;
end;

initialization
  { IEGateMgrWS }
  InvRegistry.RegisterInterface(TypeInfo(IEGateMgrWS), 'urn:EGateMgrWSIntf-IEGateMgrWS', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IEGateMgrWS), 'urn:EGateMgrWSIntf-IEGateMgrWS#%operationName%');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TEvent), 'urn:EGateMgrWSIntf', 'TEvent');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TDocumentImages), 'urn:EGateMgrWSIntf', 'TDocumentImages');
  RemClassRegistry.RegisterXSClass(Transaction, 'urn:EGateMgrWSIntf', 'Transaction');
  RemClassRegistry.RegisterXSClass(PersonData, 'urn:EGateMgrWSIntf', 'PersonData');
  RemClassRegistry.RegisterXSClass(TransactionError, 'urn:EGateMgrWSIntf', 'TransactionError');
  RemClassRegistry.RegisterXSClass(TransactionClousere, 'urn:EGateMgrWSIntf', 'TransactionClousere');
  RemClassRegistry.RegisterXSClass(Event, 'urn:EGateMgrWSIntf', 'Event');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TTransactionError), 'urn:EGateMgrWSIntf', 'TTransactionError');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TPersonData), 'urn:EGateMgrWSIntf', 'TPersonData');
  RemClassRegistry.RegisterXSClass(TDocumentImage, 'urn:EGateMgrWSIntf', 'TDocumentImage');
  RemClassRegistry.RegisterXSClass(FaceData, 'urn:EGateMgrWSIntf', 'FaceData');
  RemClassRegistry.RegisterXSClass(BiometricData, 'urn:EGateMgrWSIntf', 'BiometricData');
  RemClassRegistry.RegisterXSClass(TransactionResult, 'urn:EGateMgrWSIntf', 'TransactionResult');

end.