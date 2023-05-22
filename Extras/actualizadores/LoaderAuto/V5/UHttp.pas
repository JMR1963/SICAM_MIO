unit uHttp;

interface

uses
  System.SysUtils, System.Classes, uResourceString, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  IdException{$IFDEF DIAL_UP}, DialUp{$ENDIF};

type
  THttpDtMdl = class(TDataModule)
    ClientIdHTTP: TIdHTTP;
  private
    { Private declarations }
    procedure HandleHTTPErrors(var Msg: string; E: EIdException; var Code: Integer);
    procedure HandleFileCreationError(var Msg: string; E: EFCreateError);
  public
    { Public declarations }
    procedure HTTPInitialize(HostIP: string; SrvPath: string; Password: string; UserName: string; ProxyPort: Integer;
      ProxyId: string; ProxyUN: string; ProxyPW: string; SrvBscAuth: Boolean; ProxyBscAuth: Boolean);
    function HttpGetFile(var Msg: string; IncDir: string; FName: string; Ext: string): Integer;
  end;

var
  HttpDtMdl: THttpDtMdl;

implementation
{$R *.dfm}

uses
  uCommon;

type
  { Contiene información a cerca del servidor al que se quiere conectar }
  THttpSrvInfo = record
    Protocol: string;
    SrvPath: string;
    HostIp: string;
    SrvPass: string;
    SrvUser: string;
  end;

var
  HttpSrvInfo: THttpSrvInfo;  // Almacena la información del Host a conectarse

procedure THttpDtMdl.HandleHTTPErrors(var Msg: string; E: EIdException; var Code: Integer);
  {
  Maneja las excepciones de la conexión HTTP.
  Msg: Mensaje de status que se devuelve.
  E: Excepción generada.
  Ok: Indica si la exepción fue provocada por que el archivo a bajar no fue encontrado, en este caso
      toma valor True. Si la excepción se produjo por otro motivo, toma valor False.
}
begin
  { Retornar el código devuelto por la respuesta del servidor }
  Code := ClientIdHTTP.Response.ResponseCode;
  { La excepción de archivo no encontrado no se toma como un error }
  if Code <> HTTP_FILE_NOT_EXIST then
    { Log de la causa de la exepción HTTP }
    Msg := LOG_HTTP_ERROR + LOG_DELIMITER + E.Message + LOG_DELIMITER + DateTimeToStr(Now);
end;

procedure THttpDtMdl.HandleFileCreationError(var Msg: string; E: EFCreateError);
begin
  Msg := LOG_CREATION_FILE_ERROR + LOG_DELIMITER + E.Message + LOG_DELIMITER + DateTimeToStr(Now);
end;

procedure THttpDtMdl.HTTPInitialize(HostIP: string; SrvPath: string; Password: string; UserName: string; ProxyPort:
  Integer; ProxyId: string; ProxyUN: string; ProxyPW: string; SrvBscAuth: Boolean; ProxyBscAuth: Boolean);
  {
  Realiza la inicialización de la conexión HTTP.
  Devuelve True si la inicialización concluyó con éxito, False en caso contrario.
}
begin
  { Protocolo a utilizar (HTTP en este caso) }
  HttpSrvInfo.Protocol := HTTP_PROTOCOL;
  { Ruta del recurso en el servidor HTTP }
  HttpSrvInfo.SrvPath := SrvPath;
  { Nombre o IP del host HTTP }
  HttpSrvInfo.HostIp := HostIP;
  { Password para usuario en el servidor HTTP }
  HttpSrvInfo.SrvPass := Password;
  { Nombre de usuario en el servidor HTTP }
  HttpSrvInfo.SrvUser := UserName;
  { Puerto de conexión al servidor proxy }
  ClientIdHTTP.ProxyParams.ProxyPort := ProxyPort;
  { IP o nombre del servidor proxy }
  ClientIdHTTP.ProxyParams.ProxyServer := ProxyId;
  { Nombre de usuario en el servidor proxy }
  ClientIdHTTP.ProxyParams.ProxyUsername := ProxyUN;
  { Password para usuario en el servidor proxy }
  ClientIdHTTP.ProxyParams.ProxyPassword := ProxyPW;
  { Realizar basic authentication en el Host }
  ClientIdHTTP.Request.BasicAuthentication := SrvBscAuth;
  { Realizar basic authentication en el Proxy }
  ClientIdHTTP.ProxyParams.BasicAuthentication := ProxyBscAuth;
end;

function THttpDtMdl.HttpGetFile(var Msg: string; IncDir: string; FName: string; Ext: string): Integer;
var
  Fstrm: TFileStream;   // Stream para el archivo a bajar
  Temp: string;
begin
  { Inicializar con un valor conocido }
  Result := 0;
  Result := HTTP_FILE_DOWNLOADED;
  Fstrm := nil;
  try
    { Crear stream para el archivo a bajar }
    Fstrm := TFileStream.Create(IncDir + FName + Ext, fmCreate);
    Temp := Format(HTTP_GET_STRING, [HttpSrvInfo.Protocol, HttpSrvInfo.SrvUser, HttpSrvInfo.SrvPass, HttpSrvInfo.HostIp,
      HttpSrvInfo.SrvPath, FName, Ext]);
    { Bajar archivo desde el servidor HTTP }
    ClientIdHTTP.Get(Temp, Fstrm);
    { Log indicando que se bajó un archivo }
    Msg := LOG_FILE_DOWNLOADED + LOG_DELIMITER + FName + LOG_DELIMITER + DateTimeToStr(Now);
    Result := HTTP_FILE_DOWNLOADED;
  except
    on E: EIdException do
      HandleHTTPErrors(Msg, E, Result);
    on E: EFCreateError do
      HandleFileCreationError(Msg, E);
  end;
  { Liberar stream. Free testea si fStrm es nil }
  if Fstrm <> nil then
    Fstrm.Free;
  { Si no se encontró el archivo ... }
  if Result = HTTP_FILE_NOT_EXIST then
    { ... borrar el archivo sin contenido creado por el file stream }
    DeleteFile(IncDir + FName + Ext);
end;

end.

