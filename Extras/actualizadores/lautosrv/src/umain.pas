unit uMain;

interface

uses
  SysUtils, System.Classes, Winapi.Windows, uGlobal, uDatabase;

procedure DoProcess(baselist: TList);

implementation

uses
  Data.DB, uConsts, uUtils, uHttp, Ora {$IFDEF DIAL_UP}, uDialup{$ENDIF};

function NewDBRecord: PTDBRecord;
begin
  New(Result);
  New(Result^.pbi);
  New(Result^.pdbc);
  New(Result^.pl);
end;

procedure DisposeDBRecord(pdbr: PTDBRecord);
begin
  Dispose(pdbr^.pbi);
  Dispose(pdbr^.pdbc);
  Dispose(pdbr^.pl);
  Dispose(pdbr);
end;

function GetPlural(i: Integer): string;
begin
  Result := '';
  if i <> 1 then
    Result := 's';
end;

procedure ProccessIncommingFiles(log: PTLog; trn: torasession; insfilesp, updfilesp: TOraStoredProc; allopqry: TOraQuery;
  lastfile: string);
  {
  Procesa el o los archivo/s del directorio INCOMMING.
  lastfile : Es el último archivo procesado y confirmado.
}
var
  actualfile: string;
  abort: Boolean;      // Aborto del procesamiento de archivos
  fileok: Boolean;     // Indica si el archivo actual a procesar salió Ok
  goprocess: Boolean;
  count: Integer;
begin
  abort := False;
  count := 0;

  // Tomar próximo archivo al último procesado para.
  actualfile := CalculateNextFileName(lastfile);
    // En caso de que se procesen archivos desde el directorio Incomming en forma manual (sin bajarlos
  // vía HTTP), "g_maxfile" estará vacía. Por lo tanto debemos tomar la fecha actual como máxima.
  if g_maxfile = '' then
    DateTimeToString(g_maxfile, 'yyyymmddhh', Now);
      // Cuando "actualfile" supera a "maxfile" no tenemos más archivos por los que buscar.
  while actualfile <= g_maxfile do
  begin
    // Puede que exista un hueco de archivos entre el último procesado y el primer archivo
    // en el directorio INCOMMING_DIR. Se deben saltear los archivos en este hueco y cualquiera
    // que no exista en INCOMMING_DIR.
    if FileExists(Format(FILENAME_DDFE, [g_workingdir, INCOMMING_DIR, actualfile, LIST_FILE_EXT])) then
    begin
      // Si se trabaja en forma manual (httpactive = False) debe testearse si el archivo txt encontrado por
      // FindFirst es mayor que el último archivo procesado confirmado (lastfile). En caso de que sea menor o
      // igual no se procesa.
      // En caso de que se trabaje de forma automática (httpactive = True) el proceso que baja los archivos
      // desde el servidor http ya se encarga de bajar los archivos a partir de lastfile por lo cual no es
      // necesario comparar las fechas.

      if g_httpactive then
        goprocess := True
      else if SCompareDates(actualfile, lastfile) <= 0 then
      begin
        WriteLog(log, Format(LOG_FILE_MINOR_EQ_LASTFILE, [actualfile, lastfile]));
        goprocess := False;
      end
      else
        goprocess := True;

      if goprocess then
      begin
        WriteLog(log, Format(LOG_ATTEMP_PROCESS_FILE, [actualfile]));
        // Procesamos el archivo actual
        ProcessListFile(log, trn, insfilesp, updfilesp, allopqry, actualfile, abort, fileok);
          // Chequar si hubo algún error. Si es asi terminamos el proceso de archivos.
        if abort or not fileok then
          Exit;
      end;
      // Incremento de cuenta de archivos.
      count := count + 1;
    end;
    // Próximo archivo.
    actualfile := CalculateNextFileName(actualfile);
  end;

  ProcessListFile(log, trn, insfilesp, updfilesp, allopqry, actualfile, abort, fileok);
  if count = 0 then
    WriteLog(log, LOG_NO_FILES_PROCESSED)
  else
    WriteLog(log, Format(LOG_FILES_PROCESSED, [count, GetPlural(count)]));
end;

function GetNextFilesFromServer(lastfile: string): Boolean;
  {
  Transfiere el próximo archivo siguiente a lastfile, desde el servidor hacia el directorio INCOMMING_DIR.
  Devuelve True en caso de haber encontrado un archivo, False en caso contrario.
}
var
  filename: string;
  actualdate: string;
  minfile, maxfile: string;
  msg: string;
  someerror: Boolean;  // Indica si hubo algún error al bajar algún archivo
  code: Integer;       // Código de la operación HTTP
begin
  Result := False;      // Por defecto no se ha procesado aún ningún archivo
  someerror := False;
  minfile := '';
  maxfile := '';

  // Si la tabla de archivos procesados está vacía no bajamos ningun archivo.
  if lastfile = '' then
    Exit;

  // Si tenemos minimo archivo tomamos a éste como máximo a buscar.
  if g_minfile = '' then
    DateTimeToString(actualdate, 'yyyymmddhh', Now)  // Tomar la fecha actual. Año + Mes + Día + Hora
  else
    actualdate := CalculatePrevFileName(g_minfile);

  filename := CalculateNextFileName(lastfile);  // Calcular cual será el nombre del próximo archivo

  // Bajar desde el servidor HTTP el o los próximo/s archivo/s
  // Prueba a partir del último procesado hasta la fecha actual
  while (SCompareDates(filename, actualdate) <= 0) and not someerror do
  begin
    // Bajar archivo y obtener código de la operación
    code := HttpGetFile(msg, filename);
    // Actualizar mínimo y máximo archivo procesado.
    if minfile = '' then
      minfile := filename;
    // Si "filename" > "maxfile", actualizamos "maxfile".
    if (maxfile = '') or (SCompareDates(filename, maxfile) = 1) then
      maxfile := filename;
    // Testear si se bajó el archivo o si no existe dicho archivo
    if (code = HTTP_FILE_DOWNLOADED) or (code = HTTP_FILE_NOT_FOUND) then
    begin
      filename := CalculateNextFileName(filename);  // Próximo archivo a buscar en el servidor HTTP
      if code = HTTP_FILE_DOWNLOADED then  // Si se bajó algún archivo ...
        Result := True; // ... marcarlo
    end
    else
      someerror := True;  // ... marcar error para salir
    // Si el archivo no existe no se toma como error. Por lo tanto no hay log
    if code <> HTTP_FILE_NOT_FOUND then
      WriteLog(msg);  // ... log con el respectivo mensaje de error
  end;
  // Actualizar mínimo y máximo globales.
  if (g_minfile = '') or (SCompareDates(minfile, g_minfile) = -1) then
    g_minfile := minfile;
  if (g_maxfile = '') or (SCompareDates(maxfile, g_maxfile) = 1) then
    g_maxfile := maxfile;
end;

procedure ProcessBase(pbi: PTBaseInfo; id: Integer);
var
  pdbr: PTDBRecord;
  lastfile: string;
  abort: Boolean;
begin
  pdbr := NewDBRecord;
  pdbr^.pbi^.path := pbi^.path;
  pdbr^.pbi^.user := pbi^.user;
  pdbr^.pbi^.password := pbi^.password;
  pdbr^.pbi^.charset := pbi^.charset;
  pdbr^.pl^.filename := IntToStr(id);
  // Crear componentes para conexión de base de datos.
  if not CreateDataBaseComponents(pdbr^.pl, pdbr^.pbi, pdbr^.pdbc) then
  begin
    FreeDataBaseComponents(pdbr^.pdbc);
    WriteLog(pdbr^.pl, LOG_DATABASE_COMPONENTS_FAILED);
    Exit;
  end;
  // Comenzamos conexión con la base de datos
  WriteLog(pdbr^.pl, Format(LOG_ATTEMP_CONNECT_DATABASE, [pdbr^.pbi^.path]));
  if not OpenDataBaseConection(pdbr^.pdbc^.database) then
  begin
    FreeDataBaseComponents(pdbr^.pdbc);
    WriteLog(pdbr^.pl, Format(LOG_DATABASE_CONNECT_FAILED, [pdbr^.pbi^.path]));
    Exit;
  end;
  WriteLog(pdbr^.pl, Format(LOG_DATABASE_CONNECTED, [pdbr^.pbi^.path]));

  // Obtener el nombre del último archivo procesado.
  lastfile := GetLastFile(pdbr^.pl, pdbr^.pdbc^.database, pdbr^.pdbc^.querylastfilesp, abort);

  // Error al consultar ?
  if abort then
  begin
    CloseDatabaseConnection(pdbr^.pdbc^.database);
    FreeDataBaseComponents(pdbr^.pdbc);
    Exit;
  end;
  // Informar último archivo procesado.
  WriteLog(pdbr^.pl, Format(LOG_LAST_CONTROL_LIST_FILE, [lastfile]));

  // Sólo se bajan nuevos archivos, si el próximo archivo al mínimo archivo procesado en la base, es
  // menor al mínimo archivo bajado vía HTTP.
  if (g_minfile = '') or (SCompareDates(CalculateNextFileName(lastfile), g_minfile) = -1) then
  begin
    // Una vez que se tiene el mínimo archivo de lista de control, bajar los archivos vía
    // HTTP.
    if g_httpactive then
    begin
      if not CreateHTTPComponent then
      begin
        FreeHTTPComponent;
        Exit;
      end;
      // Sólo si tenemos la opción de conexión http activa creamos la conexión dial-up en caso de que ésta
      // también esté seleccionada. Si la opción http no está activa no es necesario ninguna conexión dial-up
      // ya que el actualizador funciona en modo manual.
{$IFDEF DIAL_UP}
      if g_dialupactive then
      begin
        if not CreateDialupComponent then
        begin
          FreeDialupComponent;
          WriteLog(LOG_DIALUP_COMPONENT_FAILED);
          Exit;
        end;
      end;
{$ENDIF}
    end;
{$IFDEF DIAL_UP}
    // Conectamos vía dial-up
    if g_httpactive and g_dialupactive then
      if Dial then
      begin
        WriteLog(LOG_DIALUP_CONNECTED)
      end
      else
      begin
        FreeHTTPComponent;
        FreeDialupComponent;
        WriteLog(LOG_DIALUP_FAILED);
        Exit;
      end;
{$ENDIF}
    if g_httpactive then
      // Bajar el o los próximo/s archivo/s a procesar
      g_somefile := GetNextFilesFromServer(lastfile);
    // Si no se bajo ningún archivo, grabar log
    if g_httpactive and not g_somefile then
      WriteLog(LOG_NO_FILES_DOWNLOADED);
{$IFDEF DIAL_UP}
    // Descolgar si estamos en una conexión dial-up.
    if g_httpactive and g_dialupactive then
      Hangup;
    // No necesitamos más estos componentes.
    FreeDialupComponent;

{$ENDIF}
    FreeHTTPComponent;
  end;

  // Se procesan los archivos si la carga es manual o si existe algún archivo bajado
  if not g_httpactive or g_somefile then
    ProccessIncommingFiles(pdbr^.pl, pdbr^.pdbc^.database, pdbr^.pdbc^.insertfilesp, pdbr^.pdbc^.updatefilesp, pdbr^.pdbc
      ^.alloperationsqry, lastfile);

  // Cerrar conexión con base de datos.
  CloseDatabaseConnection(pdbr^.pdbc^.database);
  // Liberar comoponentes de conexión a base de datos.
  FreeDataBaseComponents(pdbr^.pdbc);
  // Log de terminación.
  WriteLog(pdbr^.pl, Format(LOG_LEAVING_PROCESS, [pdbr^.pbi^.path]));
  // Liberar memoria.
  DisposeDBRecord(pdbr);
end;

procedure MoveFiles;
var
  searchrec: TSearchRec;
  res: Integer;
begin
  res := FindFirst(Format(FILENAME_DDFE, [g_workingdir, INCOMMING_DIR, '*', LIST_FILE_EXT]), faArchive,
    searchrec);
  while (res = 0) do
  begin
    CopyFile(PWideChar(Format(FILENAME_DDF, [g_workingdir, INCOMMING_DIR, searchrec.Name])), PWideChar(Format(FILENAME_DDF,
      [g_workingdir, PROCESSED_DIR, searchrec.Name])), LongBool(False));
    DeleteFile(PWideChar(Format(FILENAME_DDF, [g_workingdir, INCOMMING_DIR, searchrec.Name])));
    res := FindNext(searchrec);
  end;
  SysUtils.FindClose(searchrec);
end;

procedure DoProcess(baselist: TList);
var
  dirname: string;
  i: Integer;
begin
  WriteLog(LOG_PROCESS_BEGIN);

  g_somefile := False;
  g_minfile := '';
  g_maxfile := '';
  // Crear una carpeta con nombre de la fecha y hora actuales, donde se guardarán todos
  // los logs de los distintos hilos que se ejecuten.
  DateTimeToString(dirname, 'yyyymmddhhmmss', Now);
  if (not CreateDirectory(PWideChar(Format(FILENAME_DDF, [g_workingdir, LOG_DIRECTORY, dirname])), nil)) then
  begin
    WriteLog(Format(LOG_CREATE_LOG_DIRECTORY_FAILED, [dirname]));
    Exit;
  end;

  WriteLog(Format(LOG_LOG_DIRECTORY_CREATED, [dirname]));

  // Debemos agregar una barra al directorio de logs despues de haberlo creado
  g_logdir := dirname;
  // Iniciar hilos.
  for i := 0 to baselist.Count - 1 do
    ProcessBase(baselist[i], i);

  //if g_xmlactive then
  //  ProcessTransits(logfile, pbi^.path);

  WriteLog(LOG_MOVING_FILES);
  // Movemos los archivos desde el directorio INCOMMING al directorio PROCESSED.
  MoveFiles;
end;

end.

