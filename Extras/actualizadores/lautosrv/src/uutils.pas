unit uUtils;

interface

uses
  uGlobal;

procedure WriteLog(log: string); overload;

procedure WriteLog(pl: PTLog; logmsg: string); overload;

procedure SDecodeDate(dt: string; var year, month, day, hour: Integer);

function SEncodeDate(year, month, day, hour: Integer): string;

function SCompareDates(dt1, dt2: string): Integer;

function IsLeap(year: Integer): Boolean;

function CalculatePrevFileName(afile: string): string;

function CalculateNextFileName(afile: string): string;

implementation

uses
  System.SysUtils, System.SyncObjs, uConsts;

procedure HandleInOutError(var logfile: TextFile; E: EInOutError; var Result: Boolean);
  {
  Result entra con valor False!
}
begin
  // ErrorCode = 2 indica que el archivo no existe.
  if E.ErrorCode = 2 then
  begin
    // Cuidado con la re-excepción!
    try
      // Crear el archivo.
      ReWrite(logfile);
    except
      Exit;
    end;
    Result := True;
  end;
end;

function OpenFileAux(var logfile: TextFile; filename: string): Boolean;
begin
  Result := False;
  try
    // El archivo de logs del servicio se encuentra en el directorio donde éste reside.
    AssignFile(logfile, filename);
      // Se intenta abrir el archivo para anexar información. Falla si no existe. Y en tal
    // caso se lo crea.
    Append(logfile);
    Result := True;
  except
    // Manejo de excepción. Nos interesa saber si el archivo existe.
    on E: EInOutError do
      HandleInOutError(logfile, E, Result);
  end;
end;

procedure WriteLog(log: string);
  {
  Log NO thread safe.
  Crea o abre, en caso de que ya exista, un archivo para logs. El servicio informará
  todo lo acontecido en este archivo.
  El archivo es abierto y cerrado para que el log sea visualizado inmediatamente si
  se abre el archivo con un editor de texto.
}
begin
  if OpenFileAux(g_logfile, Format(FILENAME_DFE, [g_workingdir, LOG_FILE_NAME, LOG_FILE_EXT])) then
  begin
    Writeln(g_logfile, Format(LOG_GENERAL, [DateTimeToStr(Now), log]));
    CloseFile(g_logfile);
  end;
end;

procedure WriteLog(pl: PTLog; logmsg: string);
begin
  // Cada hilo guarda un archivo en la ruta indicada por: el directorio donde reside el
  // servicio (g_workingdir), el directorio de logs (LOG_DIRECTORY) y el directorio de la
  // consulta actual (g_logdir).
  if OpenFileAux(pl^.logfile, Format(FILENAME_DDDFE, [g_workingdir, LOG_DIRECTORY, g_logdir, pl^.filename, LOG_FILE_EXT]))
    then
  begin
    Writeln(pl^.logfile, Format(LOG_GENERAL, [DateTimeToStr(Now), logmsg]));
    CloseFile(pl^.logfile);
  end;
end;

function FillWithLeftZeros(line: string; maxlen: Integer): string;
  {
  Completa con ceros a izquierda el string line hasta que su longitud llegue a ser la misma que maxlen.
  Retorna un nuevo string.
}
var
  index: Integer;
begin
  Result := '';
  for index := 1 to maxlen - Length(line) do
    Result := Result + '0';
  Result := Result + line;
end;

procedure SDecodeDate(dt: string; var year, month, day, hour: Integer);
  {
  Decodifica una fecha (Formato: AAAAMMDDNN).
  Devuelve el año, mes, día y hora en year, month, day y hour respectivamente.
}
begin
  year := StrToInt(Copy(dt, 1, 4));
  month := StrToInt(Copy(dt, 5, 2));
  day := StrToInt(Copy(dt, 7, 2));
  hour := StrToInt(Copy(dt, 9, 2));
end;

function SEncodeDate(year, month, day, hour: Integer): string;
  {
  Codifica una fecha (Formato: AAAAMMDDNN).
  year, month, day y hour son el año, mes, día y hora respectivamente.
}
begin
  Result := FillWithLeftZeros(IntToStr(year), 4) + FillWithLeftZeros(IntToStr(month), 2) + FillWithLeftZeros(IntToStr(day),
    2) + FillWithLeftZeros(IntToStr(hour), 2);
end;

function SCompareDates(dt1, dt2: string): Integer;
  {
  Compara dt1 con dt2. (Formato: AAAAMMDDNN).
  Devuelve -1 si dt1 < dt2, 0 si dt1 = dt2 y 1 si dt1 > dt2.
}
var
  year1, year2: Integer;
  month1, month2: Integer;
  day1, day2: Integer;
  hour1, hour2: Integer;
begin
  SDecodeDate(dt1, year1, month1, day1, hour1);
  SDecodeDate(dt2, year2, month2, day2, hour2);
  if year1 < year2 then         // Comparar años
    Result := -1                // < 0 si Dt1 > Dt2
  else if year1 > year2 then
    Result := 1                 // > 0 si Dt1 > Dt2
  else if month1 < month2 then  // Comparar meses si años iguales
    Result := -1
  else if month1 > month2 then
    Result := 1
  else if day1 < day2 then      // Comparar días si meses iguales
    Result := -1
  else if day1 > day2 then
    Result := 1
  else if hour1 < hour2 then    // Comparar horas si días iguales
    Result := -1
  else if hour1 > hour2 then
    Result := 1
  else
    Result := 0;                // 0 si Dt1 = Dt2
end;

function IsLeap(year: Integer): Boolean;
begin
  Result := ((year and 3) = 0) and ((year mod 100 > 0) or (year mod 400 = 0));
end;

function CalculatePrevFileName(afile: string): string;
var
  year: Integer;
  month: Integer;
  day: Integer;
  hour: Integer;
begin
  SDecodeDate(afile, year, month, day, hour);
  if hour > FIRST_HOUR then // Si no es la hora primera ...
    hour := hour - 1        // ... decrementar en uno la hora ...
  else
  begin                // Es la hora primera, inicializarla
    hour := LAST_HOUR;
    // Si no es el primer día del mes que corresponda ...
    if day > 1 then
      day := day - 1  // ... decrementar en uno el día (no importa si el año es bisiesto) ...
    else
    begin
      if month > 1 then     // Si no es el mes primero ...
        month := month - 1  // ... decrementar en uno el mes ...
      else
      begin
        // Es el primer mes, ponerlo en uno y decrementar en uno el año
        month := LAST_MONTH;
        year := year - 1;
      end;
      // Una vez calculado el mes, podemos calcular el día tomando el último día del
      // mes, teniendo en cuenta el año bisiesto
      day := lastdays[IsLeap(year), month];
    end
  end;
  Result := SEncodeDate(year, month, day, hour);
end;

function CalculateNextFileName(afile: string): string;
var
  year: Integer;
  month: Integer;
  day: Integer;
  hour: Integer;
begin
  SDecodeDate(afile, year, month, day, hour);
  if hour <> LAST_HOUR then // Si no es la última hora ...
    hour := hour + 1  // ... aumentar en uno la hora ...
  else
  begin  // Es la última hora, inicializarla
    hour := FIRST_HOUR;
    // Si no es el último día del mes que corresponda (tine en cuenta año bisiesto) ...
    if day <> lastdays[IsLeap(year), month] then
      day := day + 1  // ... aumentar en uno el día ...
    else
    begin
      // Es el último día del mes, ponerlo a uno (indicando próximo mes)
      day := 1;
      if month <> LAST_MONTH then // Si no es el último mes del año ...
        month := month + 1  // ... aumentar en uno el mes ...
      else
      begin
        // Es el último mes, ponerlo en uno e incrementar en uno el año
        month := 1;
        year := year + 1;
      end
    end
  end;
  Result := SEncodeDate(year, month, day, hour);
end;

end.

