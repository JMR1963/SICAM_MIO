unit uHttp;

interface

function CreateHTTPComponent: Boolean;

procedure FreeHTTPComponent;

function HttpGetFile(var msg: string; filename: string): Integer;

implementation

uses
  System.SysUtils, System.Classes, IdHTTP, IdException, IdSSLOpenSSL, uConsts, uGlobal, uUtils;

var
  // Variable para conexión http
  httpclient: TIdHTTP;
  hndsckt: TIdSSLIOHandlerSocketOpenSSL;

function CreateHTTPComponent: Boolean;
begin
  Result := False;
  try
    // Cliente para conexión http
    httpclient := TIdHTTP.Create(nil);
    httpclient.Request.BasicAuthentication := g_httpbscauth;
    httpclient.Request.Username := g_httpuser;
    httpclient.Request.Password := g_httppswrd;
//    httpclient.AuthRetries := 10;
    httpclient.ReadTimeout := g_httpreadtimeout;

    if g_httpprotocol = '' then
      WriteLog(LOG_HTTP_PROTOCOL_NOT_FOUND)
    else if UpperCase(g_httpprotocol) = 'HTTPS' then
    begin
      hndsckt := TIdSSLIOHandlerSocketOpenSSL.Create(httpclient);
      httpclient.IOHandler := hndsckt;
    end
    else if UpperCase(g_httpprotocol) <> 'HTTP' then
      WriteLog(Format(LOG_HTTP_INVALID_PROTOCOL, [g_httpprotocol]));

    httpclient.ProxyParams.BasicAuthentication := g_proxybscauth;
    httpclient.ProxyParams.ProxyServer := g_proxyid;
    httpclient.ProxyParams.ProxyUsername := g_proxyuser;
    httpclient.ProxyParams.ProxyPassword := g_proxypswrd;
    httpclient.ProxyParams.ProxyPort := g_proxyport;
    Result := True;
  except
    WriteLog(LOG_HTTP_COMPONENT_CREATION_FAILED);
  end;
end;

procedure FreeHTTPComponent;
begin
  try
    if Assigned(httpclient) then
      FreeAndNil(httpclient);
  except
  end;
end;

procedure HandleHTTPErrors(var msg: string; E: EIdException; var code: Integer);
  {
  Maneja las excepciones de la conexión HTTP.
  msg : Mensaje de status que se devuelve.
  E : Excepción generada.
}
begin
  code := httpclient.Response.ResponseCode;
    // La excepción de archivo no encontrado no se toma como un error. Es el único código que se devuelve.
  if code <> HTTP_FILE_NOT_FOUND then
  begin
    // Log de la causa de la exepción HTTP
    msg := LOG_HTTP_ERROR + '-' + StringReplace(E.Message, END_OF_LINE, '', [rfReplaceAll, rfIgnoreCase]);
    code := HTTP_FILE_ERROR;
  end;
end;

procedure HandleFileCreationError(var msg: string; E: EFCreateError);
begin
  msg := LOG_CREATION_FILE_ERROR + '-' + E.Message;
end;

function GetConfirmationFile(var msg: string; filename: string): Integer;
var
  fstream: TFileStream;
begin
  Result := HTTP_FILE_ERROR;
  fstream := nil;
  try
    fstream := TFileStream.Create(Format(FILENAME_DDFE, [g_workingdir, INCOMMING_DIR, filename, CONFIRMATION_FILE_EXT]),
      fmCreate);
    httpclient.Get(Format(HTTP_GET_STRING, [g_httpprotocol, g_httpsrvid, g_httprespath, filename, CONFIRMATION_FILE_EXT]),
      fstream);
    Result := HTTP_FILE_DOWNLOADED;
  except
    on E: EIdException do
      HandleHTTPErrors(msg, E, Result);
    on E: EFCreateError do
      HandleFileCreationError(msg, E);
  end;

  if fstream <> nil then
    fstream.Free;
  // Borramos el archivo de confirmación ya que sólo lo utilizamos como medio de saber si
  // el correspondiente archivo de lista de control esta correctamente generado.
  DeleteFile(Format(FILENAME_DDFE, [g_workingdir, INCOMMING_DIR, filename, CONFIRMATION_FILE_EXT]));
end;

function HttpGetFile(var msg: string; filename: string): Integer;
var
  fstream: TFileStream;   // Stream para el archivo a bajar
begin
  { Inicializar con un valor conocido }
  Result := HTTP_FILE_ERROR;
  fstream := nil;

  // ignoreconffile indica si se debe tener en cuenta los archivos de confirmación (*.cnf).
  if not g_ignoreconffile then
  begin
    // Primero bajamos el archivo de confirmación (*.cnf) el cual nos indica que el archivo de
    // lista de control (*.txt) está generado completamente.
    Result := GetConfirmationFile(msg, filename);
      // Si no pudimos bajar el archivo de confirmación, salimos con el código que
    if Result <> HTTP_FILE_DOWNLOADED then
      Exit;
  end;

  try
    // Crear stream para el archivo a bajar
    fstream := TFileStream.Create(Format(FILENAME_DDFE, [g_workingdir, INCOMMING_DIR, filename, LIST_FILE_EXT]),
      fmCreate);
    httpclient.Get(Format(HTTP_GET_STRING, [g_httpprotocol, g_httpsrvid, g_httprespath, filename, LIST_FILE_EXT]),
      fstream);  // Bajar archivo desde el servidor HTTP
    // Log indicando que se bajó un archivo
    msg := LOG_FILE_DOWNLOADED + '->' + filename;
    Result := HTTP_FILE_DOWNLOADED;
  except
    on E: EIdException do
      HandleHTTPErrors(msg, E, Result);
    on E: EFCreateError do
      HandleFileCreationError(msg, E);
  end;

  if fstream <> nil then  // Liberar stream. Free testea si fstream es nil
    fstream.Free;
  // Borrar el archivo sin contenido creado por el file stream
  if (Result = HTTP_FILE_NOT_FOUND) or (Result = HTTP_FILE_ERROR) then
    DeleteFile(Format(FILENAME_DDFE, [g_workingdir, INCOMMING_DIR, filename, LIST_FILE_EXT]));
end;

end.

