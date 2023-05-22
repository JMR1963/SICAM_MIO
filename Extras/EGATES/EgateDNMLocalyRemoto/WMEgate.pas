unit WMEgate;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp, Soap.InvokeRegistry,
  Soap.WSDLIntf, System.TypInfo, Soap.WebServExp, Soap.WSDLBind, Xml.XMLSchema,
  Soap.WSDLPub, Soap.SOAPPasInv, Soap.SOAPHTTPPasInv, Soap.SOAPHTTPDisp,
  Soap.WebBrokerSOAP;

type
  TWebModule1 = class(TWebModule)
    HTTPSoapDispatcher1: THTTPSoapDispatcher;
    HTTPSoapPascalInvoker1: THTTPSoapPascalInvoker;
    WSDLHTMLPublish1: TWSDLHTMLPublish;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
  private
    { Private declarations }
    doRta:Boolean;
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

uses Soap.OpConvertOptions,EgateFunciones;

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

var id:Integer=0;



procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  WSDLHTMLPublish1.ServiceInfo(Sender, Request, Response, Handled);
end;


procedure TWebModule1.WebModuleCreate(Sender: TObject);
begin
  if WSConf1 then begin
    HTTPSoapPascalInvoker1.Converter.Options := HTTPSoapPascalInvoker1.Converter.Options - [soSendMultiRefObj];
  end;
end;

end.
