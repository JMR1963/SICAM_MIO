{ SOAP WebModule }
unit ListaControl;

interface

uses
  system.SysUtils, system.Classes, web.HTTPApp, soap.InvokeRegistry, soap.WSDLIntf, system.TypInfo,
  soap.WebServExp, soap.WSDLBind, xml.XMLSchema, soap.WSDLPub, soap.SOAPPasInv, soap.SOAPHTTPPasInv,
  soap.SOAPHTTPDisp, soap.WebBrokerSOAP;

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
    function getRemoteIp: String;
  end;

var
  WebModule1: TWebModule1;

implementation


{$R *.dfm}

function TWebModule1.getRemoteIp: String;
begin
  Result:= Request.RemoteAddr;
end;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  WSDLHTMLPublish1.ServiceInfo(Sender, Request, Response, Handled);
end;

end.
