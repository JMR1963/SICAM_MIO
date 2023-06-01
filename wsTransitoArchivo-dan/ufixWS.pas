unit ufixWS;

interface

uses System.SysUtils, Soap.SOAPHTTPTrans, WinApi.WinInet;

type
  TWSDemora=class
  public
    FconnectTimeoutMS,FsendTimeoutMS,FreceiveTimeoutMS:Integer;
    procedure configureHttpRequest(const HTTPReqResp: THTTPReqResp; Data: Pointer);
  end;

implementation

uses Variants;

procedure TWSDemora.configureHttpRequest(const HTTPReqResp: THTTPReqResp; Data: Pointer);
begin
  FconnectTimeoutMS := FconnectTimeoutMS;
  FsendTimeoutMS    := FconnectTimeoutMS;
  FreceiveTimeoutMS := FconnectTimeoutMS;
  if FconnectTimeoutMS <1000 then
  begin
    FconnectTimeoutMS := 5000;
    FsendTimeoutMS    := 5000;
    FreceiveTimeoutMS := 5000;
  end;
  InternetSetOption(Data, INTERNET_OPTION_CONNECT_TIMEOUT, Pointer(@FconnectTimeoutMS), SizeOf(FconnectTimeoutMS));
  InternetSetOption(Data, INTERNET_OPTION_SEND_TIMEOUT, Pointer(@FsendTimeoutMS), SizeOf(FsendTimeoutMS));
  InternetSetOption(Data, INTERNET_OPTION_RECEIVE_TIMEOUT, Pointer(@FreceiveTimeoutMS), SizeOf(FreceiveTimeoutMS));
end;

end.
