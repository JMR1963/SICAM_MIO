unit udmOracle;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DBClient, Datasnap.Provider, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.OracleWrapper, vcl.Dialogs,
  {
  FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.Oracle,
  FireDAC.Phys.OracleDef, FireDAC.ConsoleUI.Wait, FireDAC.Comp.Client, Data.DB, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
}
  uResourceString, uCommon;

type
  TTableInfo = record
    TableName: string;     // Nombre de la tabla
    TableFields: string;   // Campos de la tabla
    TableParams: string;   // Tipos de los campos de la tabla
    FieldCount: Integer;   // Total de campos
    KeyFCount: Integer;    // Total de campos que conforman la clave de la tabla
  end;

type
  TdmOracle = class(TDataModule)
    conOracle: TFDConnection;
    trnOracle: TFDTransaction;
    cmdSql: TFDCommand;
    spArchivoProcesado: TFDStoredProc;
    cw: TFDGUIxWaitCursor;
  private
    Tables: array of TTableInfo;
    function GetField(Line: string; var Pos: Integer; Delim: string; var IsLast: Boolean): string;
    function GetTableName(Token: string): string;
    function GetToken(var Line, Token: string): Boolean;
    function VerifyTableName(TblName: string; var TblInfo: TTableInfo): Boolean;

    procedure Commit(Trn: TFDTransaction);
    procedure ExecuteCommand(cmd, values: string);
    procedure HandleDataBaseErrors(var Abort: Boolean);
    procedure MakeValues(Field, Pre, Prm: string; var Values: string; Delim: string; IsLast: Boolean);
    procedure ProcessDeletes(var ListFile: TextFile; var LogFile: TextFile; var Token: string; var TokenOk: Boolean; var
      TblInfo: TTableInfo; var LineNumber, Deleted, BadLines: Integer; var Abort: Boolean);
    procedure ProcessInserts(var ListFile: TextFile; var LogFile: TextFile; var Token: string; var TokenOk: Boolean; var
      TblInfo: TTableInfo; var LineNumber, Inserted, BadLines: Integer; var Abort: Boolean);
    procedure ProcessUpdates(var ListFile: TextFile; var LogFile: TextFile; var Token: string; var TokenOk: Boolean; var
      TblInfo: TTableInfo; var LineNumber, Updated, BadLines: Integer; var Abort: Boolean);
    procedure Rollback(Trn: TFDTransaction);
    procedure TestIntegrity(var ListFile: TextFile; var Line: string; var Token: string; var TokenOk, NoMore: Boolean;
      var LineNumber: Integer);
    procedure WriteErrorLine(var LogFile: TextFile; Msg: string; var BdLns: Integer; Line: Integer; Abort: Boolean);
    procedure WriteResume(var LogFile: TextFile; How, Bad: Integer; Msg: string; Abort: Boolean);

  public
    function ConnectToDataBase(bdpath: string): string;
    function GetLastFile(var LogFile: TextFile; var Abort: Boolean): string;
    function InitTables(ParamPath: string): Boolean;
    procedure ProccessCmdCtrlList(var LogFile: TextFile; ListPath, FileName, Ext: string; var Abort, FileOk: Boolean);//
  end;

var
  dmOracle: TdmOracle;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdmOracle }

procedure TdmOracle.Commit(Trn: TFDTransaction);
begin
//  if Trn.Connection.InTransaction then
  Trn.Commit;
end;

function TdmOracle.ConnectToDataBase(bdpath: string): string;
begin
  Result := '';
  with conOracle do
  begin
    try
// (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
// (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = orcl)))

      Params.Database := bdpath;
      Params.Username := Base.Values[USER_NAME];
      Params.Password := Base.Values[PASSWORD];
      if not Connected then
        Open;

    except
      on E: Exception do
        Result := E.Message;
    end;
  end;
end;

function TdmOracle.GetField(Line: string; var Pos: Integer; Delim: string; var IsLast: Boolean): string;
  {
  Devuelve un campo leido desde Line a partir del caracter indicado por Pos.
  In Params:
    Line: Desde donde se leen los campos.
    Pos: Posici�n a partir de la cual se leen los campos.
    Delim: Caracter delimitador de campos.
  Out Params:
    IsLast: Indica si es el �ltimo campo en la l�nea.
}
var
  FldOk: Boolean;
  Ch: string;
begin
  Result := '';
  FldOk := False;
  { Mientras no haya un campo disponible ... }
  while not FldOk do
  begin
    Ch := Copy(Line, Pos, 1);
    { Si no se encontr� el delimitador o el final del string ... }
    if (Ch <> Delim) then
      { ... copiar al resultado y pasar al pr�ximo char ... }
      Result := Result + Ch
    else
      { ... en otro caso, campo listo }
      FldOk := True;
    if Ch <> '' then
      Pos := Pos + 1
    else
      FldOk := True;
  end;
  { Indicar si es el �ltimo campo }
  IsLast := Ch = '';
end;

function TdmOracle.GetLastFile(var LogFile: TextFile; var Abort: Boolean): string;
  {
  Devuelve el nombre del �ltimo archivo de lista control procesado.
  Si la transacci�n termin� bien, Status toma valor True, caso contrario
  valor False.
  Formato de nombre de archivo:
    AAAAMMDDXX
    AAAA: A�o
    MM:   Mes
    DD:   D�a
    XX:   N�mero de secuencia
}
begin
  Abort := False;
  try
    Result := conOracle.ExecSQLScalar('SELECT MAX(NOMBREARCHIVO) NOMBREARCHIVO FROM ARCHIVOSPROCESADOS WHERE CONFIRMADO = :CONF',
      ['T']);
  except
    on E: EOCINativeException do
    begin
      HandleDataBaseErrors(Abort);
      WriteLn(LogFile, LOG_DB_ERROR + LOG_DELIMITER + E.Message + LOG_DELIMITER + DateTimeToStr(Now) + END_OF_LINE);
    end;
  end;
end;

function TdmOracle.GetTableName(Token: string): string;
  {
  Devuelve el nombre de la tabla.
  In Params:
    Token: Un token cualquiera.
  Function Out: El nombre de la tabla.
}
begin
  { Devolver lo que queda de quitar los enclosers }
  Result := Copy(Token, 2, Length(Token) - 2);
end;

function TdmOracle.GetToken(var Line, Token: string): Boolean;
  {
  Busca un token y lo devuelve en Token.
  La funci�n devuelve True en caso de encontrar un Token, False en caso
  contrario. Tambi�n devuelve True en caso de que la longitud de Line sea cero.
  In Params:
    Line: L�nea de texto para buscar el token.
  Function Out: El token encontrado si hay alguno.
}
var
  Idx: Integer;    // Indice para recorrer la l�nea
  LineLen: Integer;    // Longitud de la l�nea
  TkFounded: Boolean;    // Indica si se encontr� un Token encloser
  TkBad: Boolean;    // Indica que el Token no es v�lido
  TkBeg: Integer;    // Indicador de inicio de token
begin
  Idx := 1;
  LineLen := Length(Line);
  TkFounded := False;
  TkBad := False;
  { TkBeg en cero indica que no se encotr� el comienzo del token }
  TkBeg := 0;
  { Hasta que encuentre un token o se termine la l�nea }
  while (Idx <= LineLen) and not TkFounded and not TkBad do
  begin
    { TkBeg > 0 significa se encontr� el principio del token.
      TkBeg apunta a la posici�n donde se encontro el token encloser }
    if (TkBeg > 0) and (Copy(Line, Idx, 1) = TOKEN_ENCLOSER) then
    begin
      { Token encontrado }
      TkFounded := True;
      { Copiar token para devolver }
      Token := Copy(Line, TkBeg, Idx - TkBeg + 1);
    end
    else
      { ... el caracter le�do no es un encloser ... }
      if TkBeg > 0 then
        { ... probar con el siguiente }
      Idx := Idx + 1
    else if (Copy(Line, Idx, 1) = TOKEN_ENCLOSER) then
    begin
      TkBeg := Idx;       // Guardar comienzo del token
      Idx := Idx + 1;
    end
    else
      TkBad := True;  // Cualquier otro caracter. Token no v�lido
  end;
  Result := TkFounded and not TkBad and (Idx = LineLen);
end;

procedure TdmOracle.HandleDataBaseErrors(var Abort: Boolean);
begin
  if not conOracle.connected then
  begin
    Abort := True;
    Exit;
  end;

  try
    trnOracle.Rollback;
    Abort := False;
  except
    Abort := True;
  end;
end;

function TdmOracle.InitTables(ParamPath: string): Boolean;
{
  Realiza la carga de informaci�n de las tablas desde el archivo de par�metros.
  Retorna True si todo sali� bien, False en caso contrario.
}
var
  PrmFile: TextFile;  // Archivo y ruta de archivo de par�metros
  Line: string;
  Idx: Integer;
begin
  try
    { Abrir archivo de par�metros para las consultas }
    AssignFile(PrmFile, ParamPath + PARAMS_FILE_NAME + PARAMS_FILE_EXT);
    Reset(PrmFile);
  except
    { Indicar error en la carga }
    Result := False;
    Exit;
  end;
  { Cargar el vector de informaci�n de tablas }
  try
    Idx := 0;
    { Indica cuantas tablas para cargar }
    while not Eof(PrmFile) do
    begin
      { Ignorar l�neas en blanco }
      repeat
        ReadLn(PrmFile, Line);
      until Line <> '';
      SetLength(Tables, Length(Tables) + 1);
      { Las pr�ximas l�neas no deben estar vac�as }
      { Cargar nombre de tabla }
      Tables[Idx].TableName := Line;
      { Leer y cargar nombre de los campos de la tabla }
      ReadLn(PrmFile, Line);
      Tables[Idx].TableFields := Line;
      { Leer y cargar tipos de los campos de la tabla }
      ReadLn(PrmFile, Line);
      Tables[Idx].TableParams := Line;
      { Leer y cargar total de campos }
      ReadLn(PrmFile, Line);
      Tables[Idx].FieldCount := StrToInt(Line);
      { Leer y cargar total de campos que conforman la clave }
      ReadLn(PrmFile, Line);
      Tables[Idx].KeyFCount := StrToInt(Line);
      Idx := Idx + 1;
    end;
    { Si todo bien ... }
    Result := True;
  except
    { Marcar cualquier error }
    Result := False;
  end;
  { Una vez cargado el vector de tablas. Cerrar el archivo de par�metros }
  CloseFile(PrmFile);
end;

procedure TdmOracle.MakeValues(Field, Pre, Prm: string; var Values: string; Delim: string; IsLast: Boolean);
{
  Devuelve en Value la concatenaci�n de Pre + Field + ','. Esto �ltimo siempre y cuando IsLast tenga
  valor False. Field ser� encerrado entre comillas simples dependiendo del valor de Prm.
}
begin
  { Si es un valor nulo ... }
  if UpperCase(Field) = NULL_VALUE then
    { ... agregarlo como est� }
    Values := Values + Pre + Field
  else
    { ... si es vac�o interpretarlo como NULL }
    if Field = '' then
    Values := Values + Pre + NULL_VALUE
  else
      { ... si el valor esperado es tipo entero ... }
    if Prm = INTEGER_FIELD then
        { ... se agrega el valor como est� }
    Values := Values + Pre + Field
  else
       { ... si el valor esperado es tipo string ... }
    if (Prm = STRING_FIELD) then
          { ... agregar las comillas necesarias en SQL }
    Values := Values + Pre + QuotedStr(Field)
  else
       { ... si el valor esperado es tipo fecha y hora ... }
    if (Prm = DATE_TIME_FIELD) then
          { ... agregar las comillas necesarias en SQL }
    Values := Values + Pre + 'TO_DATE(' + QuotedStr(Field) + ',' + QuotedStr('MM/DD/YYYY') + ')';


  { Si no es �ltimo campo, agregar separador }
  if not IsLast then
    Values := Values + Delim;
end;

procedure TdmOracle.ProccessCmdCtrlList(var LogFile: TextFile; ListPath, FileName, Ext: string; var Abort, FileOk:
  Boolean);
  {
  Realiza la carga de las tablas que contienen la informaci�n de las restricciones.
  [In]
    LogFile:  Archivo de informaci�n sobre las operaciones (log).
    ListPath: Ruta donde se encuentra el archivo de par�metros para las
              operaciones sobre tablas (insert's, update's y delete's).
    FileName: Archivo de par�metros para las operaciones.
    Ext:      Extensi�n del archivo.
  [Out]
    Abort:    Indica si se aborta el procesamiento del archivo actual y de los archivos que quedan
              por procesar. Por ejemplo si se pierde la conexi�n con la base de datos.
    FileOk:   Indica si el archivo se proces� correctamente.
}
var
  BadLines: Integer;    // L�neas con errores por tabla
  BeginOk: Boolean;    // Indicador de datos v�lidos
  Deleted: Integer;    // L�neas borradas por tabla
  EndOk: Boolean;    // Indicador de fin de datos v�lidos
  EofOk: Boolean;    // Indicador de fin de archivo
  IdProccessed: Integer;    // Identificador de nuevo archivo en la base
  Inserted: Integer;    // L�neas insertadas por tabla
  Line: string;     // Auxiliar
  LineNumber: Integer;    // Contador de l�neas en archivo
  ListFile: TextFile;   // Archivo lista control
  TableName: string;     // Tabla en proceso
  TableOk: Boolean;    // Indicador de tabla
  TblInfo: TTableInfo; // Informaci�n sobre la tabla
  Token: string;     // Auxiliar para tokens
  TokenOk: Boolean;    // Indicador de token disponible
  TotalBad: Integer;    // Total l�neas con errores
  TotalDel: Integer;    // Total l�neas borradas
  TotalIns: Integer;    // Total l�neas insertadas
  TotalUpd: Integer;    // Total l�neas actualizadas
  Updated: Integer;    // L�neas actualizadas por tabla
begin
  Abort := False;
  FileOk := False;
  try
    { Abrir archivo de actualizaci�n de lista control }
    AssignFile(ListFile, ListPath + FileName + Ext);
    Reset(ListFile);
  except
    { Si hubo problemas ... log }
    WriteLn(LogFile, LOG_LST_FILE_FAILED + LOG_DELIMITER + FileName + Ext + LOG_DELIMITER + DateTimeToStr(Now));
    Exit;
  end;
  try
    with spArchivoProcesado do
    begin
      ParamByName('PNOMBREARCHIVO').Value := FileName;
      ParamByName('PFECHA').Value := Now;
      ParamByName('PCORRECTOS').Value := 0;
      ParamByName('PERRONEOS').Value := 0;
      ParamByName('PCONFIRMADO').Value := 'F';
      ExecProc;
      IdProccessed := ParamByName('RIDPROCESADO').AsInteger;
    end;

  except
    on E: EOCINativeException do
    begin

      HandleDataBaseErrors(Abort);
      WriteLn(LogFile, LOG_LST_FILE_INS_FAILED + LOG_DELIMITER + E.Message + LOG_DELIMITER + FileName + LOG_DELIMITER +
        DateTimeToStr(Now) + END_OF_LINE);
      { Cerrar ambos archivos }
      CloseFile(ListFile);
      { Error con la base de datos. Abortamos el procesamiento de los archivos }
      Exit;
    end;
  end;

  { Indicadores en False }
  EofOk := False;
  BeginOk := False;
  EndOk := False;
  TableOk := False;
  TokenOk := False;
  { Contadores en cero }
  LineNumber := 0;
  TotalIns := 0;
  TotalUpd := 0;
  TotalDel := 0;
  TotalBad := 0;
  { Bucle principal de proceso }
  while not (EofOk or EndOk or Abort) do
  begin
    { Esta condici�n no est� en el while para dar la posibilidad de que se pase por el bucle una
      vez m�s a�n despu�s de que se encuentre el fin de archivo }
    EofOk := Eof(ListFile);
    { Si no hay token disponible ... }
    if not (TokenOk or EofOk) then
    begin
      LineNumber := LineNumber + 1;
      { Leer pr�xima l�nea }
      ReadLn(ListFile, Line);
      { ... buscar alg�n token para la l�nea actual del archivo a procesar }
      if not GetToken(Line, Token) then
      begin
        { ... si no se encontr� un token en esta l�nea ... error }
        WriteLn(LogFile, LOG_TOKEN_UNKNOWN + LOG_LINE_NUMBER + LOG_DELIMITER + IntToStr(LineNumber) + LOG_DELIMITER +
          DateTimeToStr(Now));
        CloseFile(ListFile);
        Exit;
      end;
    end;
    { Ignorar case de los caracteres que componen el token }
    Token := UpperCase(Token);
    { Testear que token se encontr�. Ignorar case de las letras }
    if Token = CTRL_LIST_BEGIN then
    begin
      { Marcar que comenz� la parte de datos del archivo }
      BeginOk := True;
    end
    else if Token = CTRL_LIST_END then
    begin
        { Fin de los datos. Listo para salir. Todo Ok }
      EndOk := True;
      FileOk := True;
    end
    else if Token = CTRL_LIST_INSERT then
    begin
      if BeginOk and TableOk and not EofOk then
      begin
            { Insertar l�neas del archivo en tabla }
        ProcessInserts(ListFile, LogFile, Token, TokenOk, TblInfo, LineNumber, Inserted, BadLines, Abort);
          { Actualizar totales }
        TotalIns := TotalIns + Inserted;
        TotalBad := TotalBad + BadLines;
      end
      else
      begin
            { Lugar equivocado para este token }
        WriteLn(LogFile, LOG_TOKEN_BAD_PLACE + LOG_DELIMITER + Token + LOG_DELIMITER + LOG_LINE_NUMBER + IntToStr(LineNumber)
          + LOG_DELIMITER + DateTimeToStr(Now));
        CloseFile(ListFile);
        Exit;
      end;
    end
    else if Token = CTRL_LIST_UPDATE then
    begin
      if BeginOk and TableOk and not EofOk then
      begin
            { Actualizar tablas seg�n datos del archivo }
        ProcessUpdates(ListFile, LogFile, Token, TokenOk, TblInfo, LineNumber, Updated, BadLines, Abort);
          { Actualizar totales }
        TotalUpd := TotalUpd + Updated;
        TotalBad := TotalBad + BadLines;
      end
      else
      begin
            { Lugar equivocado para este token }
        WriteLn(LogFile, LOG_TOKEN_BAD_PLACE + LOG_DELIMITER + Token + LOG_LINE_NUMBER + LOG_DELIMITER + IntToStr(LineNumber)
          + LOG_DELIMITER + DateTimeToStr(Now));
        CloseFile(ListFile);
        Exit;
      end;
    end
    else if Token = CTRL_LIST_DELETE then
    begin
      if BeginOk and TableOk and not EofOk then
      begin
              { Borrar l�neas de las tablas segun datos de archivo }
        ProcessDeletes(ListFile, LogFile, Token, TokenOk, TblInfo, LineNumber, Deleted, BadLines, Abort);
          { Actualizar totales }
        TotalDel := TotalDel + Deleted;
        TotalBad := TotalBad + BadLines;
      end
      else
      begin
              { Lugar equivocado para este token }
        WriteLn(LogFile, LOG_TOKEN_BAD_PLACE + LOG_DELIMITER + Token + LOG_LINE_NUMBER + IntToStr(LineNumber) +
          LOG_DELIMITER + DateTimeToStr(Now));
        CloseFile(ListFile);
        Exit;
      end;
    end
    else
    begin // En otro caso deber�a tratarse de un nombre de tabla
            { Obtener nombre de la tabla }
      TableName := GetTableName(Token);
            { Si el nombre de la tabla no es una l�nea vac�a ... }
      if TableName <> '' then
      begin
              { Verificar que la tabla existe en el archivo de par�metros }
        if VerifyTableName(TableName, TblInfo) then
        begin
                { Encabezado logs. Dejar una l�nea intermedia en blanco }
          WriteLn(LogFile, LOG_TABLE_NAME + LOG_DELIMITER + TableName + END_OF_LINE + END_OF_LINE);
            { Indicar que se encontr� una tabla }
          TableOk := True;
                { Indicar que se debe leer el pr�ximo token }
          TokenOk := False;
        end { de if VerifyTableName(TableName, TblInfo) }
        else
        begin
                { La tabla no existe, ... log }
          WriteLn(LogFile, LOG_TABLE_NOT_EXIST + LOG_DELIMITER + TableName + LOG_DELIMITER + LOG_LINE_NUMBER +
            LOG_DELIMITER + IntToStr(LineNumber) + LOG_DELIMITER + DateTimeToStr(Now));
          CloseFile(ListFile);
          Exit;
        end;
      end; { de if TableName <> '' }
    end;
  end; { del while }
  if not Abort then
    { Si el archivo est� correctamente cerrado ... }
    { O si el archivo est� vac�o (EofOk = True y EndOk = False) }
    if EndOk or EofOk then
    begin
      { Log con informaci�n del resultado de las operaciones }
      WriteLn(LogFile, LOG_LIST_FILE + LOG_DELIMITER + FileName + LOG_DELIMITER + LOG_TOTAL_LINES + LOG_DELIMITER +
        IntToStr(TotalIns + TotalUpd + TotalDel + TotalBad) + LOG_DELIMITER + LOG_BAD_LINES + LOG_DELIMITER + IntToStr(TotalBad)
        + LOG_DELIMITER + LOG_INSERTED_LINES + LOG_DELIMITER + IntToStr(TotalIns) + LOG_DELIMITER + LOG_UPDATED_LINES +
        LOG_DELIMITER + IntToStr(TotalUpd) + LOG_DELIMITER + LOG_DELETED_LINES + LOG_DELIMITER + IntToStr(TotalDel) +
        LOG_DELIMITER + DateTimeToStr(Now) + END_OF_LINE);
      { Actualizar encabezado }
      try
        with conOracle do
        begin
          Transaction.StartTransaction;
          ExecSQL('UPDATE ARCHIVOSPROCESADOS SET CORRECTOS = :PCORRECTOS, ERRONEOS = :PERRONEOS, CONFIRMADO = :PCONFIRMADO WHERE IDPROCESADO = :PIDPROCESADO',
            [TotalIns + TotalUpd + TotalDel, TotalBad, 'T', IdProccessed]);
          Transaction.Commit;
        end;
      except
        on E: EOCINativeException do
        begin
          HandleDataBaseErrors(Abort);
          WriteLn(LogFile, LOG_UPDATE_FAILURE + LOG_DELIMITER + DateTimeToStr(Now) + END_OF_LINE);
          CloseFile(ListFile);
          Exit;
        end;
      end;
    end
    else
      { Log indicando que el archivo no est� correcto }
      WriteLn(LogFile, LOG_WRONG_LIST_FILE + LOG_DELIMITER + FileName + Ext + LOG_DELIMITER + DateTimeToStr(Now));
        { Cerrar archivo de lista control }
  CloseFile(ListFile);
end;

procedure TdmOracle.ExecuteCommand(cmd, values: string);
var
  str: string;
begin
  str := Format(cmd, [values]);

  with cmdSql do
  begin
    Transaction.StartTransaction;

    cmdSql.CommandText.Add(str);

    cmdSql.Execute();
    Transaction.Commit;

  end;

end;

procedure TdmOracle.ProcessDeletes(var ListFile, LogFile: TextFile; var Token: string; var TokenOk: Boolean; var TblInfo:
  TTableInfo; var LineNumber, Deleted, BadLines: Integer; var Abort: Boolean);
var
  Line: string;
  Key: string;
  Temp: string;
  FName: string;
  Value: string;
  Prm: string;
  NoMore: Boolean;
  IsLast: Boolean;
  Idx: Integer;
  PsNm: Integer;
  PsVle: Integer;
  PsPrm: Integer;
begin
  Temp := Format(CLT_DELETE, [TblInfo.TableName, '%s']);
  Deleted := 0;
  BadLines := 0;
  NoMore := False;
  Abort := False;
  while not (NoMore or Abort) do
  begin
    TestIntegrity(ListFile, Line, Token, TokenOk, NoMore, LineNumber);

    if not NoMore then
    try
      cmdSql.CommandText.Clear;
      PsNm := 1;
      PsVle := 1;
      PsPrm := 1;
      Key := '';
        { Obtener clave }
      for Idx := 1 to TblInfo.KeyFCount do
      begin
        FName := GetField(TblInfo.TableFields, PsNm, PRMS_DELIMITER, IsLast);
        Value := GetField(Line, PsVle, FIELD_DELIMITER, IsLast);
        Prm := GetField(TblInfo.TableParams, PsPrm, PRMS_DELIMITER, IsLast);
        MakeValues(Value, FName + '=', Prm, Key, ' AND ', Idx = TblInfo.KeyFCount);
      end;

      ExecuteCommand(Temp, Key);

      Deleted := Deleted + 1;
    except
      on E: EOCINativeException do
      begin
        HandleDataBaseErrors(Abort);
        WriteErrorLine(LogFile, E.Message, BadLines, LineNumber, Abort);
      end;
    end; { del try ... except }
  end; { del while }
  { Log total insertadas y en mal estado }
  WriteResume(LogFile, Deleted, BadLines, LOG_DELETED_LINES, Abort);
end;

procedure TdmOracle.ProcessInserts(var ListFile, LogFile: TextFile; var Token: string; var TokenOk: Boolean; var TblInfo:
  TTableInfo; var LineNumber, Inserted, BadLines: Integer; var Abort: Boolean);
  {
  Inserta las l�neas leidas desde ListFile en la tabla indicada por TableName.
  In Params:
    ListFile: Archivo que contiene las l�neas a insertar en lista control.
    LogLine: L�nea auxiliar que lleva un log de las inserciones.
    TTableInfo: Informaci�n a cerca de la tabla donde se inserta.
  Out Params:
    Token: Si se encuentra un token se devuelve aqu�.
    TokenOk: Indica que se encontr� un token al terminar de procesar los inserts.
    LineNumber: Contador de las l�neas del archivo.
    Inserted: Total de l�neas insertadas en esta tabla.
    BadLines: Total de l�neas con errores en esta tabla.
  In/Out Params:
    Flag: Indica que operaciones se efectuaron sobre determinada tabla.
}
var
  Temp: string;
  Prm: string;
  Value: string;
  Line: string;
  Clause: string;
  NoMore: Boolean;
  Idx: Integer;
  PsVle: Integer;    // Posici�n del campo dentro de la l�nea
  PsPrm: Integer;    // Posici�n del par�metro dentro de la l�nea de par�metros
  IsLast: Boolean;    // Indica �ltimo campo.
begin
  Temp := Format(CLT_INSERT, [TblInfo.TableName, TblInfo.TableFields, '%s']); // Dejar lugar para los valores
  Inserted := 0;
  BadLines := 0;
  NoMore := False;
  Abort := False;
  while not (NoMore or Abort) do
  begin
    TestIntegrity(ListFile, Line, Token, TokenOk, NoMore, LineNumber);
    if not NoMore then
    try
        { Borrar anterior query }
      cmdSql.CommandText.Clear;
        { Apuntar al principio de las l�neas }
      PsVle := 1;
      PsPrm := 1;
      Clause := '';
        { Armar valores para la consulta }
      for Idx := 1 to TblInfo.FieldCount do
      begin
          { Obtener pr�ximo valor }
        Value := GetField(Line, PsVle, FIELD_DELIMITER, IsLast);
          { Obtener pr�ximo par�metro para el anterior valor }
        Prm := GetField(TblInfo.TableParams, PsPrm, PRMS_DELIMITER, IsLast);
          { Armar valores que ser�n pasados al insert }
        MakeValues(Value, '', Prm, Clause, ',', IsLast);
      end;  { del for }

      ExecuteCommand(Temp, Clause);

      Inserted := Inserted + 1;
    except
      on E: EOCINativeException do
      begin
        HandleDataBaseErrors(Abort);
        WriteErrorLine(LogFile, Format(Temp, [Clause]), BadLines, LineNumber, Abort);
        WriteErrorLine(LogFile, E.Message, BadLines, LineNumber, Abort);
      end
      else
        ;
    end; { del try ... except }
  end; { del while }
  WriteResume(LogFile, Inserted, BadLines, LOG_INSERTED_LINES, Abort);
end;

procedure TdmOracle.ProcessUpdates(var ListFile, LogFile: TextFile; var Token: string; var TokenOk: Boolean; var TblInfo:
  TTableInfo; var LineNumber, Updated, BadLines: Integer; var Abort: Boolean);
var
  Key: string;
  Temp: string;
  Line: string;
  Clause: string;
  FName: string;
  Value: string;
  Prm: string;
  NoMore: Boolean;
  IsLast: Boolean;
  Idx: Integer;
  PsNm: Integer;
  PsVle: Integer;
  PsPrm: Integer;
begin
  Temp := Format(CLT_UPDATE, [TblInfo.TableName, '%s',     // Dejar lugar para los campos y valores
    '%s']); // Dejar lugar para el id de tabla
  Updated := 0;
  BadLines := 0;
  NoMore := False;
  Abort := False;
  while not (NoMore or Abort) do
  begin
    TestIntegrity(ListFile, Line, Token, TokenOk, NoMore, LineNumber);
    if not NoMore then
    try
        { Borrar anterior query }
      cmdSql.CommandText.Clear;
      PsVle := 1;
      PsPrm := 1;
      PsNm := 1;
      Clause := '';
      Key := '';
        { Tomar la clave de la tabla }
      for Idx := 1 to TblInfo.KeyFCount do
      begin
          { Nombre del campo }
        FName := GetField(TblInfo.TableFields, PsNm, PRMS_DELIMITER, IsLast);
          { Valor del campo }
        Value := GetField(Line, PsVle, FIELD_DELIMITER, IsLast);
          { Tipo del campo }
        Prm := GetField(TblInfo.TableParams, PsPrm, PRMS_DELIMITER, IsLast);
          { Armar clave. No poner la coma en el �ltimo campo }
        MakeValues(Value, FName + '=', Prm, Key, ' AND ', Idx = TblInfo.KeyFCount);
      end;
        { Obtener valores a actualizar }
      for Idx := TblInfo.KeyFCount + 1 to TblInfo.FieldCount do
      begin
        FName := GetField(TblInfo.TableFields, PsNm, PRMS_DELIMITER, IsLast);
          { Obtener pr�ximo valor }
        Value := GetField(Line, PsVle, FIELD_DELIMITER, IsLast);
          { Obtener pr�ximo par�metro para el anterior valor }
        Prm := GetField(TblInfo.TableParams, PsPrm, PRMS_DELIMITER, IsLast);
          { Obtener valores para el update }
        MakeValues(Value, FName + '=', Prm, Clause, ',', IsLast);
      end; { del for }

      ExecuteCommand(Temp, Clause);

      Updated := Updated + 1;
    except
      on E: EOCINativeException do
      begin
        HandleDataBaseErrors(Abort);
        WriteErrorLine(LogFile, Format(Temp, [Clause]), BadLines, LineNumber, Abort);
        WriteErrorLine(LogFile, E.Message, BadLines, LineNumber, Abort);
      end
      else
        ;
    end; { del try ... except }
  end; { del while }
  { Log Total insertadas y en mal estado }
  WriteResume(LogFile, Updated, BadLines, LOG_UPDATED_LINES, Abort);
end;

procedure TdmOracle.Rollback(Trn: TFDTransaction);
begin
  if Trn.Connection.InTransaction then
    Trn.Rollback;
end;

procedure TdmOracle.TestIntegrity(var ListFile: TextFile; var Line, Token: string; var TokenOk, NoMore: Boolean; var
  LineNumber: Integer);
{
  M�dulo auxiliar para los m�dulos de inserci�n, actualizaci�n y borrado.
}
begin
  { Testear fin de archivo. Esto no deber�a ocurrir }
  if Eof(ListFile) then
  begin
    Token := '';
    TokenOk := False;
    NoMore := True;
  end
  else
  begin
    { Contar l�nea leida }
    LineNumber := LineNumber + 1;
    { Leer pr�xima l�nea a procesar }
    ReadLn(ListFile, Line);
    { Si esta l�nea no contiene un Token ... }
    if GetToken(Line, Token) then
    begin
      TokenOk := True;
      NoMore := True;
    end;
  end;
end;

function TdmOracle.VerifyTableName(TblName: string; var TblInfo: TTableInfo): Boolean;
{
  Verifica que un nombre de tabla dado exista en el archivo de par�metros.
  Basado en una b�squeda dicot�mica.
  Devuelve True si se encontr� la tabla, False en caso contrario.
  In Params:
    PrmFile: Archivo de par�metros.
    TblName: Nombre de la tabla a buscar.
  Out Params:
    TblInfo: Informaci�n de la tabla encontrada.
}
var
  TblFounded: Boolean;
  Inf, Sup, Cent: Integer;
begin
  TblFounded := False;
  Inf := 1;
  Sup := Length(Tables);
  Cent := 0;
  while not TblFounded and (Inf <= Sup) do
  begin
    { Buscar centro del subvector }
    Cent := (Sup + Inf) div 2;
    { Comparar tabla del vector contra el nombre de la tabla }
    if TblName = Tables[Cent].TableName then
      TblFounded := True
    else
      { Verificar en que subvector debe seguir la b�squeda }
      if TblName < Tables[Cent].TableName then
      Sup := Cent - 1
    else
      Inf := Cent + 1;
  end;
  { Si se encontr� la tabla buscada, devolverla }
  if TblFounded then
    TblInfo := Tables[Cent];
  Result := TblFounded;
end;

procedure TdmOracle.WriteErrorLine(var LogFile: TextFile; Msg: string; var BdLns: Integer; Line: Integer; Abort: Boolean);
begin
  if not Abort then
    BdLns := BdLns + 1; // Contar l�nea con errores
  { Log de la l�nea erronea }
  WriteLn(LogFile, #$9 + LOG_DB_ERROR + LOG_DELIMITER + DateTimeToStr(Now) + LOG_DELIMITER +
    { Quitar cualquier fin de l�nea }
    StringReplace(Msg, END_OF_LINE, '', [rfReplaceAll, rfIgnoreCase]) + LOG_DELIMITER + LOG_LINE_NUMBER + LOG_DELIMITER
    + IntToStr(Line) + END_OF_LINE);
end;

procedure TdmOracle.WriteResume(var LogFile: TextFile; How, Bad: Integer; Msg: string; Abort: Boolean);
begin
  { Log total insertadas y en mal estado }
  WriteLn(LogFile, #$9 + Msg + LOG_DELIMITER + IntToStr(How) + LOG_DELIMITER + LOG_BAD_LINES + LOG_DELIMITER + IntToStr(Bad)
    + END_OF_LINE);
  if Abort then
    WriteLn(LogFile, LOG_OPERATION_ABORTED + LOG_DELIMITER + DateTimeToStr(Now));
end;

end.

