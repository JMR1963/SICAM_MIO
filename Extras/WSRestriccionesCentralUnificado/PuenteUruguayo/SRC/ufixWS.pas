unit ufixWS;

interface

uses SysUtils,SOAPHTTPTrans,WinInet;

type
  TWSDemora=class
  timeout : integer;
  public
    FconnectTimeoutMS,FsendTimeoutMS,FreceiveTimeoutMS:Integer;
    procedure configureHttpRequest(const HTTPReqResp: THTTPReqResp; Data: Pointer);
  end;

implementation

procedure TWSDemora.configureHttpRequest(const HTTPReqResp: THTTPReqResp; Data: Pointer);
begin
  FconnectTimeoutMS := timeout;
  FsendTimeoutMS    := timeout;
  FreceiveTimeoutMS := timeout;
  InternetSetOption(Data, INTERNET_OPTION_CONNECT_TIMEOUT, Pointer(@FconnectTimeoutMS), SizeOf(FconnectTimeoutMS));
  InternetSetOption(Data, INTERNET_OPTION_SEND_TIMEOUT, Pointer(@FsendTimeoutMS), SizeOf(FsendTimeoutMS));
  InternetSetOption(Data, INTERNET_OPTION_RECEIVE_TIMEOUT, Pointer(@FreceiveTimeoutMS), SizeOf(FreceiveTimeoutMS));
end;

end.
 