unit uUtils;
interface
  function FillWithLeftZeros(Line : String; MaxLen : Integer) : String;
  function InvertDayAndMonth(aDate: String) : String;
  function IsLeap(Year : Integer) : Boolean;
  function SCompareDates(Dt1, Dt2 : String) : Integer;
  function SEncodeDate(Year, Month, Day, Hour : Integer) : String;
  function TestPassword(Pwd : String) : Boolean;

  procedure SDecodeDate(Dt : String; var Year, Month, Day, Hour : Integer);

 implementation
uses
  Vcl.Dialogs, System.SysUtils, System.UITypes, uResourceString;
function TestPassword(Pwd : String) : Boolean;
{
  Testea que el password sea alfanumérico y que no sea nulo.
}
var
  ind, dummy, code : Integer;
  numeric, alpha :   Boolean;
begin
  Result := False;
  numeric := False;
  alpha := False;
  if Pwd = ''
  then begin
    MessageDlg(MSG_PASSWORDMISSED, mtError, [mbOk], 0);
    Exit;
  end;
  { Testear por clave alfanumérica }
  for ind := 1 to Length(Pwd)
  do begin
    Val(Copy(Pwd, ind, 1), dummy, code);
    if code = 0   // Testear por número
    then
      numeric := True;
    if code <> 0  // Testear por alfabético
    then
      alpha := True;
  end;
  if alpha and numeric
  then
    Result := True
  else
    MessageDlg(MSG_PWDNOALPHANUMERIC, mtError, [mbOk], 0);
end;
function FillWithLeftZeros(Line: String; MaxLen: Integer): String;
{
  Completa con ceros a izquierda el string Line hasta que su longitud llegue a ser la
  misma que MaxLen. Retorna un nuevo string.
}
var
  Index: Integer;
begin
  Result := '';
  for Index := 1 to MaxLen - Length(Line)
  do
    Result := Result + '0';
  Result := Result + Line;
end;
function IsLeap(Year : Integer) : Boolean;
begin
  Result := ((Year and 3) = 0) and ((Year mod 100 > 0) or (Year mod 400 = 0));
end;
procedure SDecodeDate(Dt : String; var Year, Month, Day, Hour : Integer);
{
  Decodifica una fecha (Formato: AAAAMMDDNN).
  Devuelve el año, mes, día y hora en Year, Month, Day y Hour respectivamente.
}
begin
  Year  := StrToInt(Copy(Dt, 1, 4));
  Month := StrToInt(Copy(Dt, 5, 2));
  Day   := StrToInt(Copy(Dt, 7, 2));
  Hour  := StrToInt(Copy(Dt, 9, 2));
end;
function SEncodeDate(Year, Month, Day, Hour : Integer) : String;
{
  Codifica una fecha (Formato: AAAAMMDDNN).
  Year, Month, Day y Hour son el año, mes, día y hora respectivamente.
}
begin
  Result := FillWithLeftZeros(IntToStr(Year), 4) +
            FillWithLeftZeros(IntToStr(Month), 2) +
            FillWithLeftZeros(IntToStr(Day), 2) +
            FillWithLeftZeros(IntToStr(Hour), 2);
end;
function SCompareDates(Dt1, Dt2 : String) : Integer;
{
  Compara Dt1 con Dt2. (Formato: AAAAMMDDNN).
  Devuelve -1 si Dt1 < Dt2, 0 si Dt1 = Dt2 y 1 si Dt1 > Dt2.
}
var
  Year1, Year2 : Integer;
  Month1, Month2 : Integer;
  Day1, Day2 : Integer;
  Hour1, Hour2 : Integer;
begin
  SDecodeDate(Dt1, Year1, Month1, Day1, Hour1);
  SDecodeDate(Dt2, Year2, Month2, Day2, Hour2);
  if Year1 < Year2                // Comparar años
  then
    Result := -1                  // < 0 si Dt1 > Dt2
  else
    if Year1 > Year2
    then
      Result := 1                 // > 0 si Dt1 > Dt2
    else
      if Month1 < Month2          // Comparar meses si años iguales
      then
        Result := -1
      else
        if Month1 > Month2
        then
          Result := 1
        else
          if Day1 < Day2          // Comparar días si meses iguales
          then
            Result := -1
          else
            if Day1 > Day2
            then
              Result := 1
            else
              if Hour1 < Hour2  // Comparar horas si días iguales
              then
                Result := -1
              else
                if Hour1 > Hour2
                then
                  Result := 1
                else
                  Result := 0;  // 0 si Dt1 = Dt2
end;
function InvertDayAndMonth(aDate : String) : String;
{
  Toma una fecha aDate (Formato: DD/MM/AAAA o MM/DD/AAAA) e invierte el día y el
  mes.
}
begin
  Result := Copy(aDate, 4, 2) + Copy(aDate, 3, 1) + Copy(aDate, 1, 2) +
            Copy(aDate, 6, 1) + Copy(aDate, 7, 4);
end;
end.
