unit uDatabase;

interface

uses
  Data.DB, uGlobal, Ora, DBAccess;

function CreateDataBaseComponents(pl: PTLog; pbi: PTBaseInfo; ptc: PTDBComponents): Boolean;

procedure FreeDataBaseComponents(ptc: PTDBComponents);

function OpenDataBaseConection(database: TOraSession): Boolean;

procedure CloseDatabaseConnection(database: TOraSession);

function GetLastFile(log: PTLog; transaction: TOraSession; querylastfilesp: TOraQuery; var abort: Boolean): string;

procedure ProcessListFile(log: PTLog; trn: TOraSession; insfilesp, updfilesp: TOraStoredProc; allopqry: TOraQuery;
  filename: string; var abort, fileok: Boolean);

implementation

uses
  System.SysUtils, System.Classes, uConsts, uUtils;

function CreateDataBaseComponents(pl: PTLog; pbi: PTBaseInfo; ptc: PTDBComponents): Boolean;
begin
  Result := False;
  try
    // Inicializar en "nil".
    ptc^.database := nil;
   // ptc^.transaction := nil;
    ptc^.insertfilesp := nil;
    ptc^.updatefilesp := nil;
    ptc^.querylastfilesp := nil;
    ptc^.alloperationsqry := nil;
    // Creación de los componentes de conexión con la base de datos
    ptc^.database := TOraSession.Create(nil);
    ptc^.transaction := TOraSession.Create(nil);
    ptc^.insertfilesp := TOraStoredProc.Create(nil);
    ptc^.updatefilesp := TOraStoredProc.Create(nil);
    ptc^.querylastfilesp := TOraQuery.Create(nil);
    ptc^.alloperationsqry := TOraQuery.Create(nil);
    // Inicializar
    {  Configuracion propia de una coneccion a Interbase no va mas.
    Ahora se conecta a oracle }
    ptc^.database.LoginPrompt := False;
    ptc^.database.Server := pbi^.path;
    ptc^.database.Username := pbi^.user;
    ptc^.database.Password := pbi^.password;

    //ptc^.transaction.Params.Clear;
    //ptc^.transaction.AllowAutoStart := False;
    //ptc^.transaction.DefaultAction := TARollback;
    //ptc^.transaction.Session := ptc^.database;
    //ptc^.transaction.Params.Add('read_committed');
    //ptc^.transaction.Params.Add('rec_version');
    //ptc^.transaction.Params.Add('nowait');
    ptc^.insertfilesp.Session := ptc^.database;
//    ptc^.insertfilesp := ptc^.;
    ptc^.insertfilesp.StoredProcName := 'SIGER.INSARCHIVOPROCESADO';

    ptc^.insertfilesp.Params.CreateParam(ftString, 'PNOMBREARCHIVO', ptInput);
    ptc^.insertfilesp.Params.CreateParam(ftDate, 'PFECHA', ptInput);
    ptc^.insertfilesp.Params.CreateParam(ftInteger, 'PCORRECTOS', ptInput);
    ptc^.insertfilesp.Params.CreateParam(ftInteger, 'PERRONEOS', ptInput);
    ptc^.insertfilesp.Params.CreateParam(ftString, 'PCONFIRMADO', ptInput);
    ptc^.insertfilesp.Params.CreateParam(ftInteger, 'PIDPROCESADO', ptOutput);

    ptc^.updatefilesp.Session := ptc^.database;
   // ptc^.updatefilesp := ptc^.transaction;
    ptc^.updatefilesp.StoredProcName := 'SIGER.UPDARCHIVOSPROCESADOS';
    ptc^.updatefilesp.Params.CreateParam(ftInteger, 'PIDPROCESADO', ptInput);
    ptc^.updatefilesp.Params.CreateParam(ftInteger, 'PCORRECTOS', ptInput);
    ptc^.updatefilesp.Params.CreateParam(ftInteger, 'PERRONEOS', ptInput);
    ptc^.updatefilesp.Params.CreateParam(ftString, 'PCONFIRMADO', ptInput);

    ptc^.querylastfilesp.Session := ptc^.database;
   // ptc^.querylastfilesp := ptc^.transaction;
    ptc^.querylastfilesp.sql.Text := 'SELECT SIGER.CLTULTIMOPROCESADO as ultimo FROM DUAL';
    ptc^.alloperationsqry.Session := ptc^.database;
//    ptc^.alloperationsqry := ptc^.transaction;
    Result := True
  except
    on E: Exception do
      WriteLog(pl, LOG_EXCEPTION_RAISED + '-' + StringReplace(E.Message, END_OF_LINE, '', [rfReplaceAll, rfIgnoreCase]));
  end;
end;

procedure FreeDataBaseComponentsAux(c: TComponent);
begin
  try
    if Assigned(c) then
      c.Free;
  except
  end;
end;

procedure FreeDataBaseComponents(ptc: PTDBComponents);
begin
  FreeDataBaseComponentsAux(ptc^.database);
  FreeDataBaseComponentsAux(ptc^.transaction);
  FreeDataBaseComponentsAux(ptc^.insertfilesp);
  FreeDataBaseComponentsAux(ptc^.updatefilesp);
  FreeDataBaseComponentsAux(ptc^.querylastfilesp);
  FreeDataBaseComponentsAux(ptc^.alloperationsqry);
end;

function OpenDataBaseConection(database: TOraSession): Boolean;
begin
  Result := False;
  try
    database.Open;
    Result := True;
  except
  end;
end;

procedure CloseDatabaseConnection(database: TOraSession);
begin
  try
    if database.Connected then
      database.Close;
  except
  end;
end;

procedure Start(trn: TOraSession);
begin
  if not trn.InTransaction then
    trn.StartTransaction;
end;

procedure Commit(trn: TOraSession);
begin
  if trn.InTransaction then
    trn.Commit;
end;

procedure Rollback(trn: TOraSession);
begin
  if trn.InTransaction then
    trn.Rollback;
end;

procedure HandleExceptions(log: PTLog; transaction: TOraSession; E: Exception; var abort: Boolean);
begin
  // StringReplace : quita cualquier fin de línea
  WriteLog(log, LOG_EXCEPTION_RAISED + '-' + StringReplace(E.Message, END_OF_LINE, '', [rfReplaceAll, rfIgnoreCase]));
  try
    Rollback(transaction);
    abort := False;
  except
    abort := True;
  end;
end;

procedure HandleExceptionsLog(log: PTLog; transaction: TOraSession; E: Exception; var badlines: Integer; linenumber:
  Integer; var abort: Boolean);
begin
  WriteLog(log, LOG_EXCEPTION_RAISED + '-' + StringReplace(E.Message, END_OF_LINE, '', [rfReplaceAll, rfIgnoreCase]) +
    '-' + IntToStr(linenumber));
  try
    Rollback(transaction);
    badlines := badlines + 1;
    abort := False;
  except
    abort := True;
  end;
end;

procedure WriteResume(log: PTLog; how, bad: Integer; msg: string; abort: Boolean);
begin
  { Log total insertadas y en mal estado }
  WriteLog(log, Format(LOG_WRITE_RESUME, [msg, IntToStr(how), IntToStr(bad)]));
  if abort then
    WriteLog(log, LOG_OPERATION_ABORTED);
end;

function GetLastFile(log: PTLog; transaction: TOraSession; querylastfilesp: TOraquery; var abort: Boolean): string;
begin
  try
    querylastfilesp.Open;

    if not querylastfilesp.IsEmpty then
      Result := querylastfilesp.Fieldbyname('ultimo').Value;
    abort := False;

  except
    on E: Exception do
    begin
      HandleExceptions(log, transaction, E, abort);
    end;
  end;
end;

function GetToken(var line, token: string): Boolean;
  {
  Busca un token y lo devuelve en token.
  La función devuelve True en caso de encontrar un Token, False en caso contrario. También devuelve True
  en caso de que la longitud de line sea cero.
  [In]
    line: Línea de texto para buscar el token.
  [Result]
    El token encontrado si hay alguno.
}
var
  idx: Integer;        // Indice para recorrer la línea
  linelen: Integer;    // Longitud de la línea
  tkfounded: Boolean;  // Indica si se encontró un Token encloser
  tkbad: Boolean;      // Indica que el Token no es válido
  tkbeg: Integer;      // Indicador de inicio de token
begin
  idx := 1;
  linelen := Length(line);
  tkfounded := False;
  tkbad := False;
  // TkBeg en cero indica que no se encotró el comienzo del token
  tkbeg := 0;
  // Hasta que encuentre un token o se termine la línea
  while (idx <= linelen) and not tkfounded and not tkbad do
  begin
    // tkbeg > 0 significa se encontró el principio del token.
    // tkbeg apunta a la posición donde se encontro el token encloser
    if (tkbeg > 0) and (Copy(line, idx, 1) = TOKEN_ENCLOSER) then
    begin
      tkfounded := True;  // Token encontrado
      token := Copy(line, tkbeg, idx - tkbeg + 1);  // Copiar token para devolver
    end
    else if tkbeg > 0 then // ... el caracter leído no es un encloser ...
      idx := idx + 1  // ... probar con el siguiente
    else if (Copy(line, idx, 1) = TOKEN_ENCLOSER) then
    begin
      tkbeg := idx;       // Guardar comienzo del token
      idx := idx + 1;
    end
    else
      tkbad := True;  // Cualquier otro caracter. Token no válido
  end;
  Result := tkfounded and not tkbad and (idx = linelen);
end;

function GetField(line: string; var pos: Integer; delim: string; var islast: Boolean): string;
  {
  Devuelve un campo leido desde line a partir del caracter indicado por pos.
  [In]
    line : Desde donde se leen los campos.
    pos : Posición a partir de la cual se leen los campos.
    delim : Caracter delimitador de campos.
  [Out]
    islast : Indica si es el último campo en la línea.
}
var
  fldok: Boolean;
  ch: string;
begin
  Result := '';
  fldok := False;
  while not fldok do  // Mientras no haya un campo disponible ...
  begin
    ch := Copy(line, pos, 1); // Si no se encontró el delimitador o el final del string ...
    if (ch <> delim) then  // ... copiar al resultado y pasar al próximo char ...
      Result := Result + ch
    else  // ... en otro caso, campo listo
      fldok := True;
    if ch <> '' then
      pos := pos + 1
    else
      fldok := True;
  end;
  islast := ch = '';  // Indicar si es el último campo
end;

procedure TestIntegrity(var listfile: TextFile; var line: string; var token: string; var tokenok, nomore: Boolean; var
  linenumber: Integer);
{
  Módulo auxiliar para los módulos de inserción, actualización y borrado.
}
begin
  if Eof(listfile) then // Testear fin de archivo. Esto no debería ocurrir
  begin
    token := '';
    tokenok := False;
    nomore := True;
  end
  else
  begin
    linenumber := linenumber + 1; // Contar línea leida
    ReadLn(listfile, line); // Leer próxima línea a procesar
    if GetToken(line, token) then // Si esta línea no contiene un Token ...
    begin
      tokenok := True;
      nomore := True;
    end;
  end;
end;

function GetTableName(token: string): string;
  {
  Devuelve el nombre de la tabla.
  [In]
    token : Un token cualquiera.
  [Result]
    El nombre de la tabla.
}
begin
  // Devolver lo que queda de quitar los enclosers
  Result := Copy(token, 2, Length(token) - 2);
end;

function VerifyTableName(tablename: string; var tblinfo: uglobal.TTableInfo): Boolean;
  {
  Verifica que un nombre de tabla dado exista en el archivo de parámetros.
  Basado en una búsqueda dicotómica.
  [In]
    tablename : Nombre de la tabla a buscar.
  [Out]
    tblinfo : Información de la tabla encontrada.
  [Result]
    Devuelve True si se encontró la tabla, False en caso contrario.
}
var
  tblfounded: Boolean;
  inf, sup, cent: Integer;
begin
  tblfounded := False;
  inf := 0;
  cent := 0;
  sup := Length(g_tables);
  while not tblfounded and (inf <= sup) do
  begin
    cent := (sup + inf) div 2;  // Buscar centro del subvector
    if tablename = g_tables[cent].tablename then  // Comparar tabla del vector contra el nombre de la tabla
      tblfounded := True
    else if tablename < g_tables[cent].tablename then  // Verificar en que subvector debe seguir la búsqueda
      sup := cent - 1
    else
      inf := cent + 1;
  end;
  if tblfounded then  // Si se encontró la tabla buscada, devolverla
    tblinfo := g_tables[cent];
  Result := tblfounded;
end;

procedure MakeValues(field, pre, prm: string; var values: string; delim: string; islast: Boolean);
  {
  Devuelve en value la concatenación de pre + field + ','. Esto último siempre y cuando islast tenga
  valor False. field será encerrado entre comillas simples dependiendo del valor de prm.
}
begin
  if UpperCase(field) = NULL_VALUE then // Si es un valor nulo ...
    values := values + pre + field  // ... agregarlo como está
  else if field = '' then  // ... si es vacío interpretarlo como NULL
    values := values + pre + NULL_VALUE
  else if prm = INTEGER_FIELD then // ... si el valor esperado es tipo entero ...
    values := values + pre + field  // ... se agrega el valor como está
  else
        // ... si el valor esperado es tipo string o fecha y hora ...
    if (prm = STRING_FIELD) or (prm = DATE_TIME_FIELD) then
    if (prm = STRING_FIELD) then
      values := values + pre + '''' + field + '''' // ... agregar las comillas necesarias en SQL
    else
      values := values + pre + field; // ... agregar las comillas necesarias en SQL

  if not islast then  // Si no es último campo, agregar separador
    values := values + delim;
end;

function ReplaceParam(prm: string): string;
begin
  if prm = INTEGER_FIELD then
    Result := 'Integer'
  else if prm = DATE_TIME_FIELD then
    Result := 'DateTime'
  else
    Result := 'Desconocido';
end;

function CheckParam(log: PTLog; value, prm: string; var badlines: Integer; linenumber: Integer): Boolean;
  {
  Chequea la validez del valor "value" con tipo definido en "prm". Si el valor no corresponde con el
  tipo se incrementa la cuenta en "badlines" y se agrega una línea al log. En tal caso la función retorna
  False. Si el valor corresponde con el tipo, retorna True.
}
var
  ai64: Int64;
  ai: Integer;
begin
  Result := True;
  // Si es vacío no lo tomamos como inválido
  if (value = '') or (value = NULL_VALUE) then
    Exit;

  if prm = INTEGER_FIELD then
    Result := TryStrToInt64(value, ai64)
  else if prm = DATE_TIME_FIELD then
  begin
    // Sólo se chequea la longitud (8 caracteres) y que el día, mes y año sean enteros. Para evitar
    // que una cadena de caracteres cualquiera ingrese como válida.
    // Si la fecha aún no es válida, el motor se encarga de generar una excepción.
    Result := (Length(value) = 10) and TryStrToInt(Copy(value, 1, 2), ai) and TryStrToInt(Copy(value, 4, 2), ai) and
      TryStrToInt(Copy(value, 7, 4), ai);
  end;

  if not Result then
  begin
    badlines := badlines + 1;
    WriteLog(log, Format(LOG_VALUE_WRONG_TYPE, [value, ReplaceParam(prm)]) + '-' + IntToStr(linenumber));
  end;
end;

procedure ProcessInserts(log: PTLog; transaction: TOraSession; alloperationsqry: TOraQuery; var listfile: TextFile; var
  token: string; var tokenok: Boolean; var tblinfo: uglobal.TTableInfo; var linenumber, inserted, badlines: Integer; var
  abort: Boolean);
  {
  Inserta las líneas leidas desde listfile en la tabla indicada por tablename.
  [In]
    listfile: Archivo que contiene las líneas a insertar en lista control.
    tblinfo: Información a cerca de la tabla donde se inserta.
  [Out]
    token : Si se encuentra un token se devuelve aquí
    tokenok : Indica que se encontró un token al terminar de procesar los inserts
    linenumber : Contador de las líneas del archivo
    inserted : Total de líneas insertadas en esta tabla
    badlines : Total de líneas con errores en esta tabla
    abort : Indica si debe abortarse el proceso
}
var
  temp: string;
  prm: string;
  value: string;
  line: string;
  clause: string;
  nomore: Boolean;
  idx: Integer;
  psvle: Integer;    // Posición del campo dentro de la línea
  psprm: Integer;    // Posición del parámetro dentro de la línea de parámetros
  islast: Boolean;   // Indica último campo
label
  nextrow;
begin
  temp := Format(CLT_INSERT, ['siger.' + tblinfo.tablename, tblinfo.tablefields, '%s']); // Dejar lugar para los valores
  inserted := 0;
  badlines := 0;
  nomore := False;
  abort := False;
  while not (nomore or abort) do
  begin
nextrow:
    TestIntegrity(listfile, line, token, tokenok, nomore, linenumber);
    if not nomore then
    begin
      // Apuntar al principio de las líneas
      psvle := 1;
      psprm := 1;
      clause := '';
      for idx := 1 to tblinfo.fieldcount do // Armar valores para la consulta
      begin
        value := GetField(line, psvle, FIELD_DELIMITER, islast);  // Obtener próximo valor
        // Obtener próximo parámetro para el anterior valor
        prm := GetField(tblinfo.tableparams, psprm, PRMS_DELIMITER, islast);

        // Chequear validez de "value"
        if not CheckParam(log, value, prm, badlines, linenumber) then
          goto nextrow;
        //Nuevo, oracle....La fecha hay que castearla
        if prm = DATE_TIME_FIELD then
          value := 'to_date(' + '''' + value + '''' + ',' + '''MM/DD/YYYY''' + ')';

        // Armar valores que serán pasados al insert
        MakeValues(value, '', prm, clause, ',', islast);
      end;
      try
        alloperationsqry.SQL.Clear; // Borrar anterior query
        alloperationsqry.SQL.Add(Format(temp, [clause]));
        Start(transaction);
        alloperationsqry.ExecSQL; // Ejecutar sql. ExecSQL es mejor que open en inserciones
        Commit(transaction);
        inserted := inserted + 1; // Nueva línea insertada
      except
        on E: Exception do
        begin
          HandleExceptionsLog(log, transaction, E, badlines, linenumber, abort);
          custom_log('error: ' + alloperationsqry.SQL.Text);
        end;
      end;
    end;
  end;
  WriteResume(log, inserted, badlines, 'Insertadas', abort);
end;

procedure ProcessUpdates(log: PTLog; transaction: TOraSession; alloperationsqry: TOraQuery; var listfile: TextFile; var
  token: string; var tokenok: Boolean; var tblinfo: uglobal.TTableInfo; var linenumber, updated, badlines: Integer; var
  abort: Boolean);
var
  key: string;
  temp: string;
  line: string;
  clause: string;
  fname: string;
  value: string;
  prm: string;
  nomore: Boolean;
  islast: Boolean;
  idx: Integer;
  psnm: Integer;
  psvle: Integer;
  psprm: Integer;
label
  nextrow;
begin
  temp := Format(CLT_UPDATE, ['siger.' + tblinfo.tablename, '%s',     // Dejar lugar para los campos y valores
    '%s']);  // Dejar lugar para el id de tabla
  updated := 0;
  badlines := 0;
  nomore := False;
  abort := False;
  while not (nomore or abort) do
  begin
nextrow:
    TestIntegrity(listfile, line, token, tokenok, nomore, linenumber);
    if not nomore then
    begin
      psvle := 1;
      psprm := 1;
      psnm := 1;
      clause := '';
      key := '';
      for idx := 1 to tblinfo.KeyFCount do  // Tomar la clave de la tabla
      begin
        fname := GetField(tblinfo.tablefields, psnm, PRMS_DELIMITER, islast); // Nombre del campo
        value := GetField(line, psvle, FIELD_DELIMITER, islast);  // Valor del campo
        prm := GetField(tblinfo.tableparams, psprm, PRMS_DELIMITER, islast);  // Tipo del campo
        // Armar clave. No poner la coma en el último campo
        MakeValues(value, fname + '=', prm, key, ' AND ', idx = tblinfo.keyfcount);
      end;
      for idx := tblinfo.keyfcount + 1 to tblinfo.fieldcount do // Obtener valores a actualizar
      begin
        fname := GetField(tblinfo.tablefields, psnm, PRMS_DELIMITER, islast);
        value := GetField(line, psvle, FIELD_DELIMITER, islast);  // Obtener próximo valor
        // Obtener próximo parámetro para el anterior valor
        prm := GetField(tblinfo.tableparams, psprm, PRMS_DELIMITER, islast);
        // Chequear validez de "value"
        if not CheckParam(log, value, prm, badlines, linenumber) then
          goto nextrow;
        MakeValues(value, fname + '=', prm, clause, ',', islast); // Obtener valores para el update
      end;
      try
        alloperationsqry.SQL.Clear; // Borrar anterior query
        alloperationsqry.SQL.Add(Format(temp, [clause, key]));  // Cargar query para update
        Start(transaction);
        alloperationsqry.ExecSQL;
        Commit(transaction);
        updated := updated + 1; // Nueva línea insertada
      except
        on E: Exception do
          HandleExceptionsLog(log, transaction, E, badlines, linenumber, abort);
      end;
    end;
  end;
  WriteResume(log, updated, badlines, 'Actualizadas', abort);
end;

procedure ProcessDeletes(log: PTLog; transaction: TOraSession; alloperationsqry: TOraQuery; var listfile: TextFile; var
  token: string; var tokenok: Boolean; var tblinfo: uglobal.TTableInfo; var linenumber, deleted, badlines: Integer; var
  abort: Boolean);
var
  line: string;
  key: string;
  temp: string;
  fname: string;
  value: string;
  prm: string;
  nomore: Boolean;
  islast: Boolean;
  idx: Integer;
  psnm: Integer;
  psvle: Integer;
  psprm: Integer;
label
  nextrow;
begin
  temp := Format(CLT_DELETE, ['siger.' + tblinfo.tablename, '%s']);
  deleted := 0;
  badlines := 0;
  nomore := False;
  abort := False;
  while not (nomore or abort) do
  begin
nextrow:
    TestIntegrity(listfile, line, token, tokenok, nomore, linenumber);
    if not nomore then
    begin
      psnm := 1;
      psvle := 1;
      psprm := 1;
      key := '';
      for idx := 1 to tblinfo.KeyFCount do  // Obtener clave
      begin
        fname := GetField(tblinfo.tablefields, psnm, PRMS_DELIMITER, islast);
        value := GetField(line, psvle, FIELD_DELIMITER, islast);
        prm := GetField(tblinfo.tableparams, psprm, PRMS_DELIMITER, islast);
        // Chequear validez de "value"
        if not CheckParam(log, value, prm, badlines, linenumber) then
          goto nextrow;
        MakeValues(value, fname + '=', prm, key, ' AND ', idx = tblinfo.keyfcount);
      end;
      try
        alloperationsqry.SQL.Clear;
        alloperationsqry.SQL.Add(Format(temp, [key]));  // Cargar query para delete
        Start(transaction);
        alloperationsqry.ExecSQL;
        Commit(transaction);
        deleted := deleted + 1; // Incrementar borradas
      except
        on E: Exception do
          HandleExceptionsLog(log, transaction, E, badlines, linenumber, abort);
      end;
    end;
  end;
  WriteResume(log, deleted, badlines, 'Borradas', abort);
end;

procedure ProcessListFile(log: PTLog; trn: TOraSession; insfilesp, updfilesp: TOraStoredProc; allopqry: TOraQuery;
  filename: string; var abort, fileok: Boolean);
  {
  Realiza la carga de las tablas que contienen la información de las restricciones.
  [In]
    filename: Archivo de parámetros para las operaciones.
  [Out]
    abort:    Indica si se aborta el procesamiento del archivo actual y de los archivos que quedan
              por procesar. Por ejemplo si se pierde la conexión con la base de datos.
    fileok:   Indica si el archivo se procesó correctamente.
}
var
  tablename: string;     // Tabla en proceso
  tblinfo: uglobal.TTableInfo; // Información sobre la tabla
  line: string;     // Auxiliar
  linenumber: Integer;    // Contador de líneas en archivo
  token: string;     // Auxiliar para tokens
  idproccessed: Integer;    // Identificador de nuevo archivo en la base
  listfile: TextFile;   // Archivo lista control
  eofok: Boolean;    // Indicador de fin de archivo
  beginok: Boolean;    // Indicador de datos válidos
  endok: Boolean;    // Indicador de fin de datos válidos
  tableok: Boolean;    // Indicador de tabla
  tokenok: Boolean;    // Indicador de token disponible
  totalins: Integer;    // Total líneas insertadas
  totalupd: Integer;    // Total líneas actualizadas
  totaldel: Integer;    // Total líneas borradas
  totalbad: Integer;    // Total líneas con errores
  badlines: Integer;    // Líneas con errores por tabla
  inserted: Integer;    // Líneas insertadas por tabla
  updated: Integer;    // Líneas actualizadas por tabla
  deleted: Integer;    // Líneas borradas por tabla
begin
  abort := False;
  fileok := False;

  try
    // Abrir archivo de actualización de lista control este va menos el harcode
    AssignFile(listfile, Format(FILENAME_DDFE, [g_workingdir, INCOMMING_DIR, filename, LIST_FILE_EXT]));
    Reset(listfile);
  except
    WriteLog(log, LOG_OPEN_LIST_FILE_FAILED + '-' + filename + LIST_FILE_EXT);
    Exit;
  end;

  try
    insfilesp.Connection.StartTransaction;
    insfilesp.close;
    insfilesp.Prepare;
    insfilesp.PrepareSQL;
    // Insertar registro del archivo de lista de control en la base de datos
    insfilesp.ParamByName('PNOMBREARCHIVO').AsString := filename;
    insfilesp.ParamByName('PFECHA').AsDateTime := Now;
    // Los erroneos y correctos se actualizan después
    insfilesp.ParamByName('PCORRECTOS').AsInteger := 0;
    insfilesp.ParamByName('PERRONEOS').AsInteger := 0;
      // El archivo no está confirmado hasta que se termina el proceso
    insfilesp.ParamByName('PCONFIRMADO').AsString := 'F';
    insfilesp.Execute;
    // Tomar identificador del archivo en proceso
    insfilesp.Connection.Commit;
    idproccessed := insfilesp.ParamByName('PIDPROCESADO').AsInteger;
  except
    on E: Exception do
    begin
      HandleExceptions(log, trn, E, abort);
      CloseFile(listfile);
      Exit;
    end;
  end;

  // Indicadores en False
  eofok := False;
  beginok := False;
  endok := False;
  tableok := False;
  tokenok := False;
  // Contadores en cero
  linenumber := 0;
  totalins := 0;
  totalupd := 0;
  totaldel := 0;
  totalbad := 0;
  //Bucle principal de proceso
  while not (eofok or endok or abort) do
  begin
    // Esta condición no está en el while para dar la posibilidad de que se pase por el bucle una
    // vez más aún después de que se encuentre el fin de archivo
    eofok := Eof(listfile);
    // Si no hay token disponible ...
    if not (tokenok or eofok) then
    begin
      linenumber := linenumber + 1;
      { Leer próxima línea }
      ReadLn(listfile, line);
      // ... buscar algún token para la línea actual del archivo a procesar
      if not GetToken(line, token) then
      begin
        // ... si no se encontró un token en esta línea ... error
        WriteLog(log, Format(LOG_TOKEN_UNKNOWN, [IntToStr(linenumber)]));
        CloseFile(listfile);
        Exit;
      end;
    end;
    // Ignorar case de los caracteres que componen el token
    token := UpperCase(token);
    // Testear que token se encontró. Ignorar case de las letras
    if token = CTRL_LIST_BEGIN then
    begin
      // Marcar que comenzó la parte de datos del archivo
      beginok := True;
    end
    else if token = CTRL_LIST_END then
    begin
        // Fin de los datos. Listo para salir. Todo Ok
      endok := True;
      fileok := True;
    end
    else if token = CTRL_LIST_INSERT then
    begin
      if beginok and tableok and not eofok then
      begin
            // Insertar líneas del archivo en tabla
        ProcessInserts(log, trn, allopqry, listfile, token, tokenok, tblinfo, linenumber, inserted, badlines, abort);
          // Actualizar totales
        totalins := totalins + inserted;
        totalbad := totalbad + badlines;
      end
      else
      begin
            // Lugar equivocado para este token
        WriteLog(log, Format(LOG_TOKEN_IN_BAD_PLACE, [token, IntToStr(linenumber)]));
        CloseFile(listfile);
        Exit;
      end;
    end
    else if token = CTRL_LIST_UPDATE then
    begin
      if beginok and tableok and not eofok then
      begin
            // Actualizar tablas según datos del archivo
        ProcessUpdates(log, trn, allopqry, listfile, token, tokenok, tblinfo, linenumber, updated, badlines, abort);
          // Actualizar totales
        totalupd := totalupd + updated;
        totalbad := totalbad + badlines;
      end
      else
      begin
            // Lugar equivocado para este token
        WriteLog(log, Format(LOG_TOKEN_IN_BAD_PLACE, [token, IntToStr(linenumber)]));
        CloseFile(listfile);
        Exit;
      end;
    end
    else if token = CTRL_LIST_DELETE then
    begin
      if beginok and tableok and not eofok then
      begin
              // Borrar líneas de las tablas segun datos de archivo
        ProcessDeletes(log, trn, allopqry, listfile, token, tokenok, tblinfo, linenumber, deleted, badlines, abort);
          // Actualizar totales
        totaldel := totaldel + deleted;
        totalbad := totalbad + badlines;
      end
      else
      begin
              // Lugar equivocado para este token
        WriteLog(log, Format(LOG_TOKEN_IN_BAD_PLACE, [token, IntToStr(linenumber)]));
        CloseFile(listfile);
        Exit;
      end;
    end
    else
    begin // En otro caso debería tratarse de un nombre de tabla
      tablename := GetTableName(token); // Obtener nombre de la tabla
      if tablename <> ''  // Si el nombre de la tabla no es una línea vacía ...
        then
      begin
              // Verificar que la tabla existe en el archivo de parámetros
        if VerifyTableName(tablename, tblinfo) then
        begin
                // Log de nombre de tabla
          WriteLog(log, Format(LOG_TABLE_NAME, [tablename]));
                // Indicar que se encontró una tabla
          tableok := True;
                // Indicar que se debe leer el próximo token
          tokenok := False;
        end
        else
        begin
                // La tabla no existe
          WriteLog(log, Format(LOG_TABLE_NOT_EXIST, [tablename, linenumber]));
          CloseFile(listfile);
          Exit;
        end;
      end;
    end;
  end;
  if not abort then
    // Si el archivo está correctamente cerrado ...
    // O si el archivo está vacío (eofok = True y endOk = False)
    if endok or eofok then
    begin
      // Log con información del resultado de las operaciones
      WriteLog(log, Format(LOG_FILE_COMPLETED, [filename, totalins + totalupd + totaldel + totalbad, totalbad, totalins,
        totalupd, totaldel]));
      // Actualizar archivo en base de datos
      try
        custom_log(IntToStr(idproccessed));

        updfilesp.Close;
        updfilesp.Connection.StartTransaction;
        updfilesp.Prepare;
        updfilesp.PrepareSQL;

        updfilesp.ParamByName('PIDPROCESADO').AsInteger := idproccessed;
        updfilesp.ParamByName('PCORRECTOS').AsInteger := totalins + totalupd + totaldel;
        updfilesp.ParamByName('PERRONEOS').AsInteger := totalbad;
        updfilesp.ParamByName('PCONFIRMADO').AsString := 'T';
        updfilesp.Execute;
        updfilesp.Connection.Commit;
      except
        on E: Exception do
        begin
          HandleExceptions(log, trn, E, abort);
          CloseFile(listfile);
          Exit;
        end;
      end;
    end
    else
      // Log indicando que el archivo no está correcto
      WriteLog(log, Format(LOG_WRONG_LIST_FILE, [filename]));
  // Cerrar archivo de lista control
  CloseFile(listfile);
end;

end.

