unit Ufunciones;

interface

uses
    WinApi.Windows, system.Classes, IdHTTP, system.SysUtils, system.StrUtils, IdException,
    IdStack, IdExceptionCore, Soap.SOAPHTTPTrans, winApi.WinInet, System.Net.HttpClient;

type
  TWSDemora=class
  public
    FconnectTimeoutMS,FsendTimeoutMS,FreceiveTimeoutMS:Integer;
    HTTPWebNode: THTTPReqResp;
    procedure configureHttpRequest(const HTTPReqResp: THTTPReqResp; Client: THTTPClient);
  end;

function TestHTTPConnection(ipaddress,
                            proxyip,
                            proxyuser,
                            proxypass : String;
                            proxyport,
                            timeout : Integer;
                            testconnection : Boolean) : Boolean;

Var
  TIMEOUT: INTEGER;


implementation

procedure TWSDemora.configureHttpRequest(const HTTPReqResp: THTTPReqResp; Client: THTTPClient);
Var
  Data:Pointer;
begin
  InternetSetOption(Data, INTERNET_OPTION_CONNECT_TIMEOUT, Pointer(@FconnectTimeoutMS), SizeOf(FconnectTimeoutMS));
  InternetSetOption(Data, INTERNET_OPTION_SEND_TIMEOUT, Pointer(@FsendTimeoutMS), SizeOf(FsendTimeoutMS));
  InternetSetOption(Data, INTERNET_OPTION_RECEIVE_TIMEOUT, Pointer(@FreceiveTimeoutMS), SizeOf(FreceiveTimeoutMS));
end;



function TestHTTPConnection(ipaddress,
                            proxyip,
                            proxyuser,
                            proxypass : String;
                            proxyport,
                            timeout : Integer;
                            testconnection : Boolean) : Boolean;
var
  http : TIdHTTP;
begin
  Result := not testconnection;
  // Si no hay que chequar la conexi�n HTTP salimos.
  if Result then
    Exit;

  try
    http := TIdHTTP.Create(nil);
    try
      http.Request.Host := ipaddress;
      if proxyip <> '' then
      begin
        http.ProxyParams.ProxyServer := proxyip;
        http.ProxyParams.ProxyPort := proxyport;
      end;
      http.ProxyParams.BasicAuthentication := proxyuser <> '';
      if http.ProxyParams.BasicAuthentication then
      begin
        http.ProxyParams.ProxyUsername := proxyuser;
        http.ProxyParams.ProxyPassword := proxypass;
      end;
      http.ConnectTimeout := timeout*1000;
      http.Get(Format('http://%s/', [ipaddress]));
      Result := True;
    finally
      http.Free;
    end;
  except
    // S�lo una excepci�n timeout indicando que el destino est� inalcanzable
    // se considera error.
    on e : EIdConnectTimeout do
      Exit;

    on e : EIdSocketError do
      Result:= e.LastError = 10038;

    // Cualquier otra excepci�n NO es considerada error.
    on e : EIdException do
      Result := True;
  end;
end;


procedure configureHttpRequest(const HTTPReqResp: THTTPReqResp; Data: Pointer);
var
  FconnectTimeoutMS, FsendTimeoutMS, FreceiveTimeoutMS: integer;
begin
  FconnectTimeoutMS := 1000;
  FsendTimeoutMS    := 1000;
  FreceiveTimeoutMS := 1000;
  InternetSetOption(Data, INTERNET_OPTION_CONNECT_TIMEOUT,  Pointer(@FconnectTimeoutMS),  SizeOf(FconnectTimeoutMS));
  InternetSetOption(Data, INTERNET_OPTION_SEND_TIMEOUT,     Pointer(@FsendTimeoutMS),     SizeOf(FsendTimeoutMS));
  InternetSetOption(Data, INTERNET_OPTION_RECEIVE_TIMEOUT,  Pointer(@FreceiveTimeoutMS),  SizeOf(FreceiveTimeoutMS));
end;




end.
 