unit ufixWS;

interface

uses SysUtils, SOAPHTTPTrans, WinInet;

type
  TWSDemora = class
  public
    FconnectTimeoutMS, FsendTimeoutMS, FreceiveTimeoutMS: Integer;
    procedure configureHttpRequest(const HTTPReqResp: THTTPReqResp;
      Data: Pointer);
  end;

implementation

uses Variants;

procedure TWSDemora.configureHttpRequest(const HTTPReqResp: THTTPReqResp;
  Data: Pointer);
begin
  FconnectTimeoutMS := FconnectTimeoutMS;
  FsendTimeoutMS := FconnectTimeoutMS;
  FreceiveTimeoutMS := FconnectTimeoutMS;
  FconnectTimeoutMS := 6000 * 5;
  FsendTimeoutMS := 6000 * 5;
  FreceiveTimeoutMS := 6000 * 5;
  InternetSetOption(Data, INTERNET_OPTION_CONNECT_TIMEOUT,
    Pointer(@FconnectTimeoutMS), SizeOf(FconnectTimeoutMS));
  InternetSetOption(Data, INTERNET_OPTION_SEND_TIMEOUT,
    Pointer(@FsendTimeoutMS), SizeOf(FsendTimeoutMS));
  InternetSetOption(Data, INTERNET_OPTION_RECEIVE_TIMEOUT,
    Pointer(@FreceiveTimeoutMS), SizeOf(FreceiveTimeoutMS));
end;

end.
