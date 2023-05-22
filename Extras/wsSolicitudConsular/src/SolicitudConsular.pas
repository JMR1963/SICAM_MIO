{ SOAP WebModule }
unit SolicitudConsular;

interface

uses
  System.SysUtils, System.Classes, web.HTTPApp, Soap.InvokeRegistry, Soap.WSDLIntf, system.TypInfo,
  Soap.WebServExp, soap.WSDLBind, XML.XMLSchema, Soap.WSDLPub, Soap.SOAPPasInv, Soap.SOAPHTTPPasInv,
  Soap.SOAPHTTPDisp, Soap.WebBrokerSOAP;

type
  TWebModule1 = class(TWebModule)
    HTTPSoapDispatcher1: THTTPSoapDispatcher;
    HTTPSoapPascalInvoker1: THTTPSoapPascalInvoker;
    WSDLHTMLPublish1: TWSDLHTMLPublish;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModule1: TWebModule1;

implementation

{$R *.dfm}

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  WSDLHTMLPublish1.ServiceInfo(Sender, Request, Response, Handled);
end;

end.
