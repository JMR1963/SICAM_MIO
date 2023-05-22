unit UcheckConn;

interface

uses
   winapi.Windows, system.Classes, IdHTTP, system.SysUtils, IdStack, IdExceptionCore, IdException;



function TestHTTPConnection(ipaddress,
                            proxyip,
                            proxyuser,
                            proxypass : String;
                            proxyport,
                            timeout : Integer) : Boolean;



implementation

function TestHTTPConnection(ipaddress,
                            proxyip,
                            proxyuser,
                            proxypass : String;
                            proxyport,
                            timeout : Integer) : Boolean;
var
  http : TIdHTTP;
begin
  Result := False;
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

end.
 