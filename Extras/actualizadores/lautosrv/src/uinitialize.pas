unit uInitialize;

interface

uses
  Winapi.Windows;

function InitializeService(var specificerror: Integer): Integer;

procedure CleanupService;

implementation

uses
  Winapi.WinSvc, System.IniFiles, System.SysUtils, System.Classes, System.StrUtils, System.SyncObjs, uConsts, uGlobal,
  uUtils;

function InitTables: Boolean;
  {
  Realiza la carga de información de las tablas desde el archivo de parámetros.
  Retorna True si todo salió bien, False en caso contrario.
}
var
  pfile: TextFile;  // Archivo y ruta de archivo de parámetros
  line: string;
  idx: Integer;
begin
  Result := False;
  try
    // Abrir archivo de parámetros para las consultas
    AssignFile(pfile, Format(FILENAME_DF, [g_workingdir, PARAMS_FILE_NAME]));
    Reset(pfile);
  except
    Exit;
  end;
  try
    idx := 0;
    while not Eof(pfile) do
    begin
      repeat  // Ignorar líneas en blanco
        ReadLn(pfile, line);
      until line <> '';
      SetLength(g_tables, Length(g_tables) + 1);
      // Las próximas líneas no deben estar vacías
      g_tables[idx].tablename := line;  // Cargar nombre de tabla
      ReadLn(pfile, line);  // Leer y cargar nombre de los campos de la tabla
      g_tables[idx].tablefields := line;
      ReadLn(pfile, line);  // Leer y cargar tipos de los campos de la tabla
      g_tables[idx].tableparams := line;
      ReadLn(pfile, line);  // Leer y cargar total de campos
      g_tables[idx].fieldcount := StrToInt(line);
      ReadLn(pfile, line);  // Leer y cargar total de campos que conforman la clave
      g_tables[idx].keyfcount := StrToInt(line);
      idx := idx + 1;
    end;
    Result := True;
  except
  end;
  CloseFile(pfile);
end;

function GetField(baseline: string; len: Integer; var offset: Integer): string;
var
  p: Integer;
begin
  Result := '';
  p := PosEx(',', baseline, offset);
  if p = 0 then
  begin
    if offset <= len then
    begin
      Result := Copy(baseline, offset, len - offset + 1);
      offset := len + 1;
    end
  end
  else
  begin
    Result := Copy(baseline, offset, p - offset);
    offset := p + 1;
  end;
end;

function ReadBases(inifile: TInifile; var baselist: TList): Boolean;
var
  pbi: PTBaseInfo;
  baseline: string;
  i, offset, len: Integer;
begin
  i := 1;
  Result := False;
  while not Result do
  begin
    // Cada línea de base de datos contiene el path de la base,
    baseline := inifile.ReadString(SEC_BASE, 'basename' + IntToStr(i), '');
    if baseline = '' then
      Result := True
    else
    begin
      offset := 1;
      New(pbi);
      len := Length(baseline);
      pbi^.path := GetField(baseline, len, offset);
      pbi^.user := GetField(baseline, len, offset);
      pbi^.password := GetField(baseline, len, offset);
      pbi^.charset := GetField(baseline, len, offset);
        // Verificar datos mandatorios para una conexión a base de datos.
      if (pbi^.path = '') or (pbi^.user = '') or (pbi^.password = '') then
      begin
        if pbi^.path = '' then
          WriteLog(Format(LOG_NULL_DATA_BASE_DATA, ['ruta de base de datos', 'basename', i]));
        if pbi^.user = '' then
          WriteLog(Format(LOG_NULL_DATA_BASE_DATA, ['usuario', 'basename', i]));
        if pbi^.password = '' then
          WriteLog(Format(LOG_NULL_DATA_BASE_DATA, ['password', 'basename', i]));
        Dispose(pbi);
        Result := False;
      end;
      // Si no existe charset usar uno por defecto.
      if pbi^.charset = '' then
      begin
        WriteLog(Format(LOG_DEFAULT_DB_CHARSET_MISSING, [pbi^.path, DEFAULT_DB_CHARSET]));
        pbi^.charset := DEFAULT_DB_CHARSET;
      end;
      // Agregar info de base a la lista.
      baselist.Add(pbi);
      i := i + 1;
    end
  end;
end;

function InitializeService(var specificerror: Integer): Integer;
  {
  Realiza todas las tareas de inicialización del servicio como el temporizador, lectura del archivo
  de configuración, registro de ícono, etc.
}
const
  BUF_SIZE = 4096;
var
  inifile: TIniFile;
  smhandle: SC_HANDLE;
  shandle: SC_HANDLE;
  qsc: PQueryServiceConfig;
  bytesneeded: DWORD;
  len: Integer;
begin
  Result := STS_FAILED;
  specificerror := 0;
  g_terminated := False;

  // El directorio donde se encuentran los archivos de configuración y de parámetros es el mismo donde se
  // encuentra el ejecutable del servicio
  smhandle := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if smhandle = 0 then
  begin
    specificerror := SE_OPEN_SRV_MANAGER_FAILED;
    Exit;
  end
  else
  begin
    shandle := OpenService(smhandle, CNT_SERVICE_NAME, SERVICE_QUERY_CONFIG);
    if shandle = 0 then
    begin
      specificerror := SE_OPEN_SERVICE_FAILED;
      Exit;
    end
    else
    begin
      GetMem(qsc, BUF_SIZE);
      if not QueryServiceConfig(shandle, qsc, BUF_SIZE, bytesneeded) then
      begin
        specificerror := SE_QUERING_SERVICE_FAILED;
        Exit;
      end
      else
        g_workingdir := ExtractFileDir(string(qsc.lpBinaryPathName));
      FreeMem(qsc);
      CloseServiceHandle(shandle);
    end;
    CloseServiceHandle(smhandle);
  end;

  len := Length(g_workingdir);
  // Quitar barra final.
  if (g_workingdir[len] = '\') or (g_workingdir[len] = '/') then
    g_workingdir := Copy(g_workingdir, 1, len - 1);

  // Log indicando comienzo de servicio.
  WriteLog(LOG_SERVICE_INITIATED);

  try
    g_baselist := TList.Create;
    inifile := TIniFile.Create(Format(FILENAME_DF, [g_workingdir, INI_FILE_NAME]));
    try
      // Leer lista de bases de datos. ReadBases() se encarga de los logs en caso de error.
      if not ReadBases(inifile, g_baselist) then
        Exit;
      g_httpactive := inifile.ReadBool(SEC_HTTP, 'active', True);
      g_httpprotocol := inifile.ReadString(SEC_HTTP, 'protocol', '');
      g_httpsrvid := inifile.ReadString(SEC_HTTP, 'id', '');
      g_httpuser := inifile.ReadString(SEC_HTTP, 'username', '');
      g_httppswrd := inifile.ReadString(SEC_HTTP, 'password', '');
      g_httprespath := inifile.ReadString(SEC_HTTP, 'resourcepath', '');
      g_httpbscauth := inifile.ReadBool(SEC_HTTP, 'basicauthentication', True);
      g_httpreadtimeout := inifile.ReadInteger(SEC_HTTP, 'readtimeout', 10000);
      g_ignoreconffile := inifile.ReadBool(SEC_LOCAL, 'ignoreconfirmationfile', False);
      g_startminutes := inifile.ReadInteger(SEC_LOCAL, 'startminutes', 0);
      g_timertime := inifile.ReadInteger(SEC_LOCAL, 'timertime', 3600000);
      g_proxyport := inifile.ReadInteger(SEC_PROXY, 'port', 0);
      g_proxyid := inifile.ReadString(SEC_PROXY, 'id', '');
      g_proxyuser := inifile.ReadString(SEC_PROXY, 'username', '');
      g_proxypswrd := inifile.ReadString(SEC_PROXY, 'password', '');
      g_proxybscauth := inifile.ReadBool(SEC_PROXY, 'basicauthentication', False);
      g_dialupactive := inifile.ReadBool(SEC_DIALUP, 'active', False);
      g_dialupconn := inifile.ReadString(SEC_DIALUP, 'connection', '');

      // Agregado: 30/08/2007 -------------------------------------
      g_xmlbasename := inifile.ReadString(SEC_XML, 'basename', '');
      g_xmlbaseuser := inifile.ReadString(SEC_XML, 'baseuser', '');
      g_xmlbasepwd := inifile.ReadString(SEC_XML, 'basepwd', '');
      g_xmlbasechrset := inifile.ReadString(SEC_XML, 'basecharset', '');
      g_xmlactive := inifile.ReadBool(SEC_XML, 'active', False);
      g_xmlsrvip := inifile.ReadString(SEC_XML, 'serverip', '');
      g_xmluser := inifile.ReadString(SEC_XML, 'username', '');
      g_xmlpswrd := inifile.ReadString(SEC_XML, 'password', '');
      g_xmlputpath := inifile.ReadString(SEC_XML, 'putpath', '');
        // ---------------------------------------------------------
    finally
      inifile.Free;
    end;
  except
    specificerror := SE_READING_INI_FILE_FAILED;
    Exit;
  end;
  // Crear temporizador
  g_timeratt.nLength := SizeOf(SECURITY_ATTRIBUTES);
  g_timeratt.lpSecurityDescriptor := nil;
  g_timeratt.bInheritHandle := TRUE;
  g_timer := CreateWaitableTimer(@g_timeratt, FALSE, nil);
  if g_timer = 0 then
  begin
    specificerror := SE_TIMER_CREATION_FAILED;
    Exit;
  end;
  // Inicializar lista de tablas
  if not InitTables then
  begin
    specificerror := SE_LOAD_TABLES_FAILED;
    Exit;
  end;
  Result := NO_ERROR; // Código de no error de Windows
end;

procedure CleanupService;
begin
  // Log indicando fin de servicio.
  WriteLog(LOG_SERVICE_TERMINATED);

  if g_timer <> 0 then
    CloseHandle(g_timer);
  if g_baselist <> nil then
    g_baselist.Free;
end;

end.

