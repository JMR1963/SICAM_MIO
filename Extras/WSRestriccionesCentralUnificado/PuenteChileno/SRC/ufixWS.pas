unit ufixWS;

interface

uses System.SysUtils, Soap.SOAPHTTPTrans, WinApi.WinInet, System.Net.HttpClient;

type
  TWSDemora=class
  timeout : integer;
  public
    FconnectTimeoutMS,FsendTimeoutMS,FreceiveTimeoutMS:Integer;
    procedure configureHttpRequest(const HTTPReqResp: THTTPReqResp; Client: THTTPClient);
  end;

implementation

procedure TWSDemora.configureHttpRequest(const HTTPReqResp: THTTPReqResp; Client: THTTPClient);
var
  Data:Pointer;
begin
  FconnectTimeoutMS := timeout;
  FsendTimeoutMS    := timeout;
  FreceiveTimeoutMS := timeout;
  InternetSetOption(Data, INTERNET_OPTION_CONNECT_TIMEOUT, Pointer(@FconnectTimeoutMS), SizeOf(FconnectTimeoutMS));
  InternetSetOption(Data, INTERNET_OPTION_SEND_TIMEOUT, Pointer(@FsendTimeoutMS), SizeOf(FsendTimeoutMS));
  InternetSetOption(Data, INTERNET_OPTION_RECEIVE_TIMEOUT, Pointer(@FreceiveTimeoutMS), SizeOf(FreceiveTimeoutMS));
end;

end.
 