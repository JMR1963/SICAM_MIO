unit uExtra;

interface

uses
  System.IniFiles, System.UITypes, System.IOUtils, uCommon, uResourceString;


procedure SetWorkPath(WP: string);

function ProcessIniFile: Boolean;

function MainBooble : boolean;

implementation

uses
  Winapi.Windows, System.Classes, System.SysUtils, Vcl.Forms, Vcl.Dialogs, IdException, uUtils, udmOracle, uHttp
  {$IFDEF DIAL_UP}, UDialup{$ENDIF}; // quitar en otra versi�n que no trabaje con data module

var
  LogFile: TextFile;
  WrkPth: string;

procedure SetWorkPath(WP: string);
begin
  WrkPth := WP;
end;

function CreateLogFile: Boolean;
var
  FileName: string;
{
  Crea un archivo log de informaci�n sobre las operaciones.
}
begin
  Result := False;
  try
    if not TDirectory.Exists(WrkPth + LOGS_DIR) then
      TDirectory.CreateDirectory(WrkPth + LOGS_DIR);
    DateTimeToString(FileName, 'yyyymmddhhnnss', Now);
    FileName := WrkPth + LOGS_DIR + FileName + LOG_FILE_EXT;
    AssignFile(LogFile, FileName);

    ReWrite(LogFile);
    Result := True;
  except
    MessageDlg(MSG_LOG_FILE_FAILED, mtWarning, [mbOk], 0);
  end;
end;

function ProcessIniFile: Boolean;
{
  Procesa el archivo de inicializaci�n *.ini.
  Si el proceso tuvo �xito devuelve True, caso contrario devuelve False.
}
var
  inifile: TIniFile;
begin
  try
    inifile := TIniFile.Create(WrkPth + INI_FILE_NAME);
  except
    Result := False;
    Exit;
  end;
  try
    Base.Values[BASE_NAME] := inifile.ReadString(SEC_BASE, BASE_NAME, '');
    Base.Values[USER_NAME] := inifile.ReadString(SEC_BASE, USER_NAME, '');
    Base.Values[PASSWORD] := inifile.ReadString(SEC_BASE, PASSWORD, '');

    Http.Values[_ACTIVE] := BoolToStr(inifile.ReadBool(SEC_HTTP, _ACTIVE, True), True);
    Http.Values[SERVER_IP] := inifile.ReadString(SEC_HTTP, SERVER_IP, '');
    Http.Values[USER_NAME] := inifile.ReadString(SEC_HTTP, USER_NAME, '');
    Http.Values[PASSWORD] := inifile.ReadString(SEC_HTTP, PASSWORD, '');
    Http.Values[RES_PATH] := inifile.ReadString(SEC_HTTP, RES_PATH, '');
    Http.Values[BASIC_AUTH] := BoolToStr(inifile.ReadBool(SEC_HTTP, BASIC_AUTH, True), True);

    local.Values[TIMER_TIME] := IntToStr(inifile.ReadInteger(SEC_LOCAL, TIMER_TIME, 3600000));

    Proxy.Values[PORT] := IntToStr(inifile.ReadInteger(SEC_PROXY, PORT, 0));
    Proxy.Values[ID] := inifile.ReadString(SEC_PROXY, ID, '');
    Proxy.Values[USER_NAME] := inifile.ReadString(SEC_PROXY, USER_NAME, '');
    Proxy.Values[PASSWORD] := inifile.ReadString(SEC_PROXY, PASSWORD, '');
    Proxy.Values[BASIC_AUTH] := BoolToStr(inifile.ReadBool(SEC_PROXY, BASIC_AUTH, False), True);

    Dialup.Values[_ACTIVE] := BoolToStr(inifile.ReadBool(SEC_DIALUP, _ACTIVE, False), True);
    Dialup.Values[SERVER_IP] := inifile.ReadString(SEC_DIALUP, SERVER_IP, '');
    Dialup.Values[CONNECTION] := inifile.ReadString(SEC_DIALUP, CONNECTION, '');

    inifile.Free;
  except
    Result := False;
    Exit;
  end;
  Result := True;
end;

procedure ProcessListFile(listFile: string; var Abort, FileOk: Boolean);
{
  Procesa un archivo *.txt que contine la actualizaci�n de la tabla
  ListaControl.
}
begin
  { Procesar el archivo de lista control }
  dmOracle.ProccessCmdCtrlList(LogFile, WrkPth + INCOMMING_DIR, listFile, LIST_FILE_EXT, Abort, FileOk);
end;

function CalculateNextFileName(lastFile: string): string;
var
  Year: Integer;
  Month: Integer;
  Day: Integer;
  Hour: Integer;
begin
  SDecodeDate(lastFile, Year, Month, Day, Hour);
  { Si no es la �ltima hora ... }
  if Hour <> LAST_HOUR then
    { ... aumentar en uno la hora ... }
    Hour := Hour + 1
  else
  begin
    { Es la �ltima hora, inicializarla }
    Hour := FIRST_HOUR;
    { Si no es el �ltimo d�a del mes que corresponda (tine en cuenta a�o bisiesto) ... }
    if Day <> LastDays[IsLeap(Year), Month] then
      { ... aumentar en uno el d�a ... }
      Day := Day + 1
    else
    begin
      { Es el �ltimo d�a del mes, ponerlo a uno (indicando pr�ximo mes) }
      Day := 1;
      { Si no es el �ltimo mes del a�o ... }
      if Month <> LAST_MONTH then
        { ... aumentar en uno el mes ... }
        Month := Month + 1
      else
      begin
        { Es el �ltimo mes, ponerlo en uno e incrementar en uno el a�o }
        Month := 1;
        Year := Year + 1;
      end
    end
  end; { del primer else }
  Result := SEncodeDate(Year, Month, Day, Hour);
end;

function GetNextFilesFromServer(LastFile: string): Boolean;
{
  Transfiere el pr�ximo archivo siguiente a lastFile, desde el servidor
  hacia el directorio INCOMMING_DIR.
  lastFile indica el �ltimo archivo procesado.
  nextFile es el pr�ximo archivo a procesar.
  Devuelve True en caso de haber encontrado un archivo, False en caso contrario.
}
var
  FileName: string;
  ActualDate: string;
  Msg: string;
  COMPAREDATES, SomeError: Boolean;  // Indica si hubo alg�n error al bajar alg�n archivo
  Code: Integer;       // C�digo de la operaci�n HTTP

begin
  { Por defecto no se ha procesado a�n ning�n archivo }
  Result := False;
  SomeError := False;
  { Tomar la fecha actual. A�o + Mes + D�a + Hora }
  DateTimeToString(ActualDate, 'yyyymmddhh', Now);
  { Si la tabla de archivos procesados est� vac�a ... }
  if LastFile = '' then
    { ... cargar la fecha actual }
    FileName := ActualDate
  else
    { Calcular cual ser� el nombre del pr�ximo archivo }
    FileName := CalculateNextFileName(LastFile);
  { Bajar desde el servidor HTTP el o los pr�ximo/s archivo/s.
    Prueba a partir del �ltimo procesado hasta la fecha actual }
    COMPAREDATES :=  (SCompareDates(FileName, ActualDate) <= 0);
  while (SCompareDates(FileName, ActualDate) <= 0) and not SomeError do
  begin
    { Bajar archivo y obtener c�digo de la operaci�n }
    Code := HttpDtMdl.HttpGetFile(Msg, INCOMMING_DIR, FileName, LIST_FILE_EXT);
    { Testear si se baj� el archivo o si no existe dicho archivo }
    if (Code = HTTP_FILE_DOWNLOADED) or (Code = HTTP_FILE_NOT_EXIST) then
    begin
      { Pr�ximo archivo a buscar en el servidor HTTP }
      FileName := CalculateNextFileName(FileName);
      { Si se baj� alg�n archivo ... }
      if Code = HTTP_FILE_DOWNLOADED then
        { ... marcarlo }
        Result := True;
    end
    else
      { ... marcar error para salir }
      SomeError := True;
    { Si el archivo no existe no se toma como error. Por lo tanto no hay log }
    if Code <> HTTP_FILE_NOT_EXIST then
      { ... log con el respectivo mensaje de error }
      WriteLn(LogFile, Msg);
  end;
end;

procedure MakeProcess(fileName: string; var Abort: Boolean);
var
  FileOk: Boolean;
begin
  { Procesar archivo }
  ProcessListFile(ChangeFileExt(fileName, ''), Abort, FileOk);
  if not Abort and FileOk then
    { Copiar el archivo ya procesado a la carpeta de procesados. Sobreescribe en caso que exista }
    CopyFile(PWideChar(WrkPth + INCOMMING_DIR + fileName), PWideChar(WrkPth + PROCESSED_DIR + fileName), LongBool(False));
end;

procedure ProccessIncommingFiles;
var
  SearchRec: TSearchRec;
  res: Integer;
  Abort: Boolean;
{
  Procesa el o los archivo/s del directorio INCOMMING.
}
begin
  Abort := False;
  res := FindFirst(WrkPth + INCOMMING_DIR + '*' + LIST_FILE_EXT, faArchive, SearchRec);
  while (res = 0) and not Abort do
  begin
    WriteLn(LogFile, LOG_FILE_PREPARED + LOG_DELIMITER + ChangeFileExt(SearchRec.Name, '') + LOG_DELIMITER +
      DateTimeToStr(Now) + END_OF_LINE);
    MakeProcess(SearchRec.Name, Abort);
    if not Abort then
    begin
      { Borrar archivo una vez procesado }
      DeleteFile(WrkPth + INCOMMING_DIR + SearchRec.Name);
      res := FindNext(SearchRec);
    end;
  end;
  FindClose(SearchRec);
end;

procedure FreeDataModules;
begin
  if Assigned(dmOracle) then
    dmOracle.Free;
{$IFDEF DIAL_UP}
  if Assigned(DialupDtMdl) then
    DialupDtMdl.Free;
{$ENDIF}
  if Assigned(HttpDtMdl) then
    HttpDtMdl.Free;
end;

function MainBooble: boolean;
var
  lastFile: string;        // Ultimo archivo procesado
  error : string;
  abort: Boolean;
  counterTries: Integer;
  someFile: Boolean;
  RLogFile: Boolean;
  httpActive: Boolean;     // Los archivos se bajan desde servidor remoto si est� en True. Los
                            // archivos se bajan al directorio incomming manualmente si est� en
                            // False.
{$IFDEF DIAL_UP}
  dialupActive: Boolean;   // Se realiza una conexi�n dial-up antes de bajar los archivos si est�
                            // en True. No se realiza conexi�n dial-up si est� en False.
{$ENDIF}
//  dupresult: Boolean;
//  dmessage: string;
  targetip: string;        // Ip a la que se conecta el actualizador. Puede ser la del proxy en
                            // caso de salir por LAN. O puede ser la del servidor vista desde
                            // Internet en caso de conexi�n dial-up.
begin
  Result := false;
  counterTries := 0;
  someFile := False;
  httpActive := StrToBool(Http.Values[_ACTIVE]);
{$IFDEF DIAL_UP}
  dialupActive := StrToBool(Dialup.Values[_ACTIVE]);
{$ENDIF}
  { Crear archivo log }
  RLogFile := CreateLogFile;
  try
    { Crear el m�dulo de datos }
    dmOracle := TdmOracle.Create(nil);
    { M�dulo dial-up }
{$IFDEF DIAL_UP}
    if dialupActive then
      DialupDtMdl := TDialupDtMdl.Create(nil);
{$ENDIF}
    { M�dulo de conexi�n HTTP }
    if httpActive then
      HttpDtMdl := THttpDtMdl.Create(nil);
  except
    { Liberar posibles datamodules }
    FreeDataModules;
    { Log: error al crear el m�dulo de datos }
    if RLogFile then
    begin
      WriteLn(LogFile, LOG_DTMDL_CREATION_FAILED + LOG_DELIMITER + DateTimeToStr(Now));
      { Cerrar logs }
      CloseFile(LogFile);
    end;
    Exit;
  end;
  { Inicilizar conexi�n dial-up }
{$IFDEF DIAL_UP}
  if dialupActive then
  begin
    DialupDtMdl.DialupInitialize(Dialup.Values[CONNECTION]);
    targetip := Dialup.Values[SERVER_IP];
  end
  else
{$ENDIF}
    targetip := Http.Values[SERVER_IP];
  { Inicializar la conexi�n HTTP }
  if httpActive then
    HttpDtMdl.HTTPInitialize(targetip,                              // IP target
      Http.Values[RES_PATH],                 // Ruta del recurso en el servidor HTTP
      Http.Values[PASSWORD],                 // Contrase�a en el servidor
      Http.Values[USER_NAME],                // Nombre de usuario en el servidor
      StrToInt(Proxy.Values[PORT]),          // Puerto de escucha del proxy
      Proxy.Values[ID],                      // IP o nombre DNS del proxy
      Proxy.Values[USER_NAME],               // Usuario en el proxy
      Proxy.Values[PASSWORD],                // Contrase�a en el proxy
      StrToBool(Http.Values[BASIC_AUTH]),    // Server basic authentication
      StrToBool(Proxy.Values[BASIC_AUTH]));  // Proxy basic authentication
  if RLogFile then
    { Log de intento de conexi�n con la base de datos }
    WriteLn(LogFile, LOG_ATTEMP_TO_CONECT_DATA_BASE + LOG_DELIMITER + DateTimeToStr(Now));
  { Conectar con la base de datos ... }
  error := dmOracle.ConnectToDataBase(Base.Values[BASE_NAME]);
  if (Error <> '')  then
  begin
    { ... si falla, log y salir }
    if RLogFile then
    begin
      WriteLn(LogFile, Error + LOG_DELIMITER + DateTimeToStr(Now));
      CloseFile(LogFile);
    end;
    Exit;
  end;
  if RLogFile then
    { Log de conexi�n con base de datos establecida }
    WriteLn(LogFile, LOG_CONECTED_TO_DATA_BASE + LOG_DELIMITER + DateTimeToStr(Now));
  { Inicializar informaci�n de tablas }
  if not dmOracle.InitTables(WrkPth) then
  begin
    if RLogFile then
    begin
      { Si hubo problemas ... log }
      WriteLn(LogFile, LOG_TBL_INIT_FAILED + LOG_DELIMITER + DateTimeToStr(Now));
      CloseFile(LogFile);
    end;
    Exit;
  end;
  { Realizamos la conexi�n dial-up en este momento. Antes de cualquier requerimiento http }
{$IFDEF DIAL_UP}
  if dialupActive then
  begin
    dupresult := DialupDtMdl.DialupConnect(dmessage);
    if RLogFile then
      WriteLn(LogFile, dmessage);
    if not dupresult then
      Exit;
  end;
{$ENDIF}
  { Obtener el nombre del �ltimo archivo procesado. S�lo si la carga no es manual }
  if httpActive then
    lastFile := dmOracle.GetLastFile(LogFile, abort)
  else
    abort := False;
  if not abort then
  begin
    { Intentar hasta bajar el archivo o se exceda el m�ximo de intentos }
    while (counterTries < MAX_INTENTS) and not someFile do
    begin
      if httpActive then
        { Bajar el o los pr�ximo/s archivo/s a procesar }
        someFile := GetNextFilesFromServer(lastFile)
      else
        someFile := True;
      { Si se bajo algun archivo ... }
      if someFile then
        ProccessIncommingFiles; // ... procesarlo
      counterTries := counterTries + 1;
    end;
    { Si no se bajo ning�n archivo, grabar log }
    if not someFile then
      WriteLn(LogFile, LOG_NO_FILES_DOWNLOADED + LOG_DELIMITER + DateTimeToStr(Now));
  end; { del primer if }
  try
    { Liberar recursos del m�dulo de datos y conexi�n HTTP }
    { Si se produce una desconexi�n de la base de datos, la siguiente l�nea genera una exepci�n
      que no es manejada por el data module }
{$IFDEF DIAL_UP}
    if dialupActive then
      DialupDtMdl.DialupDisconnect;
{$ENDIF}
    { Liberar datamodules }
    FreeDataModules;
  except
  end;
  Result := true;
  { Si se pudo crear el archivo log, cerrarlo }
  if RLogFile then
    CloseFile(LogFile);
end;

end.

