{ SOAP WebModule }
unit UWSActuaciones;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Soap.InvokeRegistry, soap.WSDLIntf, System.TypInfo,
  Soap.WebServExp, soap.WSDLBind, XML.XMLSchema, Soap.WSDLPub, Soap.SOAPPasInv, soap.SOAPHTTPPasInv,
  Soap.SOAPHTTPDisp, soap.WebBrokerSOAP;

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

//http://delphi.about.com/library/bluc/text/uc050601a.htm

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  WSDLHTMLPublish1.ServiceInfo(Sender, Request, Response, Handled);
end;

end.
