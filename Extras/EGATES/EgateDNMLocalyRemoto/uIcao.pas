unit uIcao;

interface

uses
  Controls, Classes;

const
  ICAO_LINES = 3 - 1;
  ICAO_CHARS = 44 - 1;
  RESERVE = 10;

  BINARY_SECTION = 1000;
  BINARY_FULL = 1001;
  IDS_GREY_IMAGE = 1002;
  ALL_IMAGES = 1003;
  DONT_CARE = 1010;

  DOC_TYPE_INVALID = -1;
  DOC_EMISOR_INVALID = -2;
  SURNAME_INVALID = -3;
  NAME_INVALID = -4;
  NATIONALITY_INVALID = -5;
  DOC_NUMBER_INVALID = -6;
  DATE_OF_BIRTH_INVALID = -7;
  SEX_INVALID = -8;
  DATE_OF_EXPIRY_INVALID = -9;
  OPTIONAL_DATA_EXCEED_LENGTH = -10;

type

  TICAOLINES = PACKED ARRAY [0 .. ICAO_LINES,
    0 .. ICAO_CHARS + RESERVE] OF BYTE;
  PTICAOLINES = ^TICAOLINES;


  // ************************************************************************************************ //
  // Existen dos tipos básicos de documento. MROTD1 (Machine Readable Official Travel Document Type   //
  // 1). Una tarjeta que cumple con lo definido por el standard ISO 7810 para tarjetas tipo ID-1. La  //
  // MRZ (Marchine Readable Zone, que es la zona que lee el escanner) contiene tres líneas de texto   //
  // OCR-B de 30 caracteres cada una.                                                                 //
  // MROTD2 (Machine Readable Official Document Type 2). Una tarjeta que cumple con lo especificado   //
  // en el standard ISO 7810 para tarjetas tipo ID-2. La MRZ contiene dos líneas de texto OCR-B con   //
  // 36 caracteres cada una.                                                                          //
  // Los documentos con dos líneas pueden ser pasaportes (MRP : Machine Readable Passport), las visas //
  // (MRV : Machine Readable Visa), de las cuales existen dos tipos: MRV-A (de tamaño pequeño) y      //
  // MRV-B de tamaño más grande que la anterior.                                                      //
  // ************************************************************************************************ //

  MRZ_2L = record
    // El tipo de documento está compuesto de dos caracteres. Si se utiliza sólo el primero deberá
    // completarse el segundo con un caracter de relleno (<).
    doc_type: array [0 .. 1] of BYTE;
    // El país emisor del documento está compuesto de 3 caracteres. Debe cumplir con la especificación
    // ISO-3166 alpha-3, códigos de 3 caracteres.
    doc_emisor: array [0 .. 2] of BYTE;
    // Los apellidos y nombres deben entrar en los 39 caracteres restantes de los 44 que contiene la primer
    // línea de la MRZ (machine readable zone). Los apellidos se separan con '<', lo mismo los nombres. Entre
    // apellidos y nombres existen dos caracteres de relleno (<).
    sur_and_name: array [0 .. 38] of BYTE;
    // El número de documento ocupa 9 caracteres. En caso de que se exceda la cantidad de 9 caracteres, los
    // caracteres restantes se ponen en el campo de información opcional.
    doc_number: array [0 .. 8] of BYTE;
    doc_number_check: BYTE;
    // Los caracteres extra del número de documento no son parte del ICAO pero se agregan para saber
    // que parte de los datos opcionales pertenecen a éste campo y que parte al número de documento.
    doc_extra_chars: BYTE;
    // La nacionalidad debe cumplir con las mismas consideraciones del tipo de documento.
    nationality: array [0 .. 2] of BYTE;
    // Para las fechas se utiliza el formato YYMMDD donde, YY son los últimos dos dígitos del año, MM el mes
    // (si es un único dígito se agrega un cero delante), DD es el día de nacimiento (ídem al mes).
    date_of_birth: array [0 .. 5] of BYTE;
    dob_check: BYTE;
    sex: BYTE;
    date_of_expiry: array [0 .. 5] of BYTE;
    doe_check: BYTE;
    // Información adicional utilizada por el país emisor del documento.
    optional_data: array [0 .. 13] of BYTE;
    optional_data_check: BYTE;
    composite_check: BYTE;
  end;

  MRZ_3L = record
    // El tipo de documento está compuesto por dos caracteres de los cuales puede utilizarse sólo uno y
    // completar el otro con un caracter de relleno.
    doc_type: array [0 .. 1] of BYTE;
    // El emisor del documento está compuesto por 3 caracteres de acuerdo con la especificación
    // ISO-3166 alpha-3 que lista los paises en una forma abreviada.
    doc_emisor: array [0 .. 2] of BYTE;
    // El número de documento es un campo con un máximo de 9 caracteres. Esto no limita el máximo de
    // caracteres que el documento puede tener. En efecto si el documento tiene más de 9 caracteres los
    // caracteres exedentes pasan al primer campo de datos opcionales (el de la primer línea) más el dígito
    // verificador del documento más un caracter de relleno.
    doc_number: array [0 .. 8] of BYTE;
    // Dígito verificador del número de documento.
    doc_number_check: BYTE;
    // Número de caracteres que no entraron en el campo de número de documento.
    doc_extra_chars: BYTE;
    // Primer campo de información adicional. Primer línea, desde posición 16 hasta posición 30.
    optional_data_1: array [0 .. 14] of BYTE;
    // Fecha de nacimiento con formato YYMMDD.
    date_of_birth: array [0 .. 5] of BYTE;
    dob_check: BYTE;
    // Sexo. Puede ser 'M', 'F' o '<'.
    sex: BYTE;
    // Idem a fecha de nacimiento.
    date_of_expiry: array [0 .. 5] of BYTE;
    doe_check: BYTE;
    // Nacionalidad. Idem a país emisor.
    nationality: array [0 .. 2] of BYTE;
    // Segundo campo de datos opcionales. Segunda línea, desde posición 19 hasta posición 29.
    optional_data_2: array [0 .. 10] of BYTE;
    // Dígito verificador compuesto. Que tiene en cuenta a la primera y segunda línea.
    composite_check: BYTE;
    // Apellidos y nombres. Tercera línea.
    sur_and_name: array [0 .. 29] of BYTE;
  end;

function GenerateMRZ_2LIcao(ICAO_LINES: TICAOLINES; var icao: MRZ_2L)
  : Integer; overload;
function GenerateMRZ_2LIcao(doc_type, doc_emisor, surnames, names, doc_number,
  nationality, sex, optional_data, date_of_birth, date_of_expiry: AnsiString;
  var icao: MRZ_2L): Integer; overload;
function GetPrintableMRZ_2LIcao(icao: MRZ_2L): AnsiString;
function GetPrintableMRZ_2LIcao2L(icao: MRZ_2L): TStringList;
procedure ExtractFromMRZ_2LIcao(var doc_type, doc_emisor, surnames, names,
  doc_number, nationality, sex, optional_data, date_of_birth,
  date_of_expiry: AnsiString; icao: MRZ_2L);
function GenerateMRZ_3LIcao(ICAO_LINES: TICAOLINES; var icao: MRZ_3L)
  : Integer; overload;
function GenerateMRZ_3LIcao(doc_type, doc_emisor, surnames, names, doc_number,
  nationality, sex, optional_data_line1, optional_data_line2, date_of_birth,
  date_of_expiry: AnsiString; var icao: MRZ_3L): Integer; overload;
function GetPrintableMRZ_3LIcao(icao: MRZ_3L): AnsiString;
function GetPrintableMRZ_3LIcao3L(icao: MRZ_3L): TStringList;
procedure ExtractFromMRZ_3LIcao(var doc_type, doc_emisor, surnames, names,
  doc_number, nationality, sex, optional_data_line1, optional_data_line2,
  date_of_birth, date_of_expiry: AnsiString; icao: MRZ_3L);

implementation

uses
  SysUtils, StrUtils;

const
  ALPHA_CHARS = ['a' .. 'z', 'A' .. 'Z'];
  NUMERIC_CHARS = ['0' .. '9'];
  SPECIAL_CHARS = [' ', '<'];

  // Caracteres extendidos no utilizados en ICAO que son reemplazados.
  EXTENDED_CHARS: array [0 .. 41] of AnsiChar = ('Á', 'À', 'Â', 'Ä', 'Å', 'Ã',
    'Ç', 'É', 'È', 'Ê', 'Ë', 'I', 'Í', 'Ì', 'Î', 'Ï', 'Ñ', 'Ñ', 'Ø', 'Ó', 'Ò',
    'Ô', 'Ö', 'Õ', 'Š', 'Ú', 'Ù', 'Û', 'Ü', 'Ü', 'Ý', 'Ÿ', 'Ž', 'Þ', 'Æ', 'Œ',
    'ß', 'A', 'Þ', 'V', 'V', 'I');

  // Caracteres con los que se reemplazan a los caracteres extendidos.
  ICAO_MAPPINGS: array [0 .. 41] of String[3] = ('A', 'A', 'A', 'AE', 'AA', 'A',
    'C', 'E', 'E', 'E', 'OE', 'I', 'I', 'I', 'I', 'I', 'NXX', 'N', 'O', 'O',
    'O', 'O', 'OE', 'O', 'S', 'U', 'U', 'U', 'UE', 'UXX', 'Y', 'Y', 'Z', 'TH',
    'AE', 'OE', 'SS', 'A', 'B', 'V', 'V', 'I');

function ToUpper(ch: AnsiChar): AnsiChar;
begin
  case ch of
    'a' .. 'z':
      Result := AnsiChar(Ord(ch) - 32);
    #129:
      Result := #154;
    #130:
      Result := #144;
    #132:
      Result := #142;
    #134:
      Result := #143;
    #145:
      Result := #146;
    #148:
      Result := #153;
    #164:
      Result := #165;
  else
    Result := ch;
  end;
end;

function TestAndGetNumber(var str: AnsiString; var num: Integer): Boolean;
{
  Verifica que str contenga un valor numérico exeptuando los caracteres especiales (espacio y '<'), los
  cuales son válidos. Si str es vacío, es válido y la función devuelve True. Se supone que str no supera
  los 2 caracteres de longitud.

  [In/Out]
  str : Ansistring a testear.

  [Out]
  num : Número devuelto en caso de que str contenga uno válido.

  [Result]
  Devuelve True si str contiene un número válido, caracteres numéricos o especiales (los cuales son
  ignorados), False en caso de encontrarse cualquier otro caracter.
}
var
  i, len: Integer;
  aux: AnsiString;
begin
  Result := True;
  // i := 1;
  len := Length(str);
  // Devolvemos un Ansistring de dos caracteres. Salvo que str contenga algún caracter inválido con lo cual
  // abortamos el proceso saliendo del bucle for.
  for i := 1 to 2 do
    if i <= len then
    begin
      if str[i] in NUMERIC_CHARS then
        aux := aux + str[i]
      else if str[i] in SPECIAL_CHARS then
      begin
        if str[i] <> '<' then
          str[i] := '<'
      end
      else
      begin
        Result := False;
        Exit;
      end;
    end
    else
      str := str + '<';
  if Length(aux) > 0 then
    num := StrToInt(aux);
end;

function GetNextWeight(w: Integer): Integer;
{
  Devuelve el próximo peso del pasado por parámetro.
}
begin
  case w of
    7:
      Result := 3;
    3:
      Result := 1;
    1:
      Result := 7;
  end;
end;

function GetCheckDigit(stream: AnsiString): BYTE;
{
  Devuelve el dígito verificador después de aplicar el algoritmo a stream.
  El stream tiene todos sus caracteres normalizados para aplicar el algoritmo.

  [In]

  stream : Ansistring con caracteres normalizados para ICAO. Es decir no contienen caracteres no ASCII.
  count : Total de bytes en el stream.

  [Return]
  Dígito verificador entre 0 y 9.
}
var
  i: Integer;
  wheight: Integer;
  sum: Integer;
  value: Integer;
  len: Integer;
begin
  i := 1;
  wheight := 7;
  sum := 0;
  len := Length(stream);
  Result := 0;
  while i <= len do
  begin
    if stream[i] in ALPHA_CHARS then
      value := Ord(stream[i]) - 55
    else if stream[i] in NUMERIC_CHARS then
      value := Ord(stream[i]) - 48
    else
      value := 0;
    sum := sum + value * wheight;
    wheight := GetNextWeight(wheight);
    i := i + 1;
  end;
  Result := BYTE(sum mod 10);
end;

procedure FillField(var _result: AnsiString; field_text: AnsiString;
  field_len: Integer);
{
  Completa _result con field_text + caracteres de relleno (<) hasta llegar a la cantidad indicada por
  field_len.

  [In]
  field_text : Texto que se completa con caracteres de relleno.
  field_len : Longitud total a la que se debe llegar completando con caracteres de relleno.

  [Out]
  _result : Ansistring que contiene a field_text más los caracteres de relleno.
}
var
  how_many: Integer;
begin
  _result := '';
  if (field_len < 0) or (Length(field_text) > field_len) then
    Exit;
  how_many := field_len - Length(field_text);
  _result := field_text + DupeString('<', how_many);
end;

function Test(var str: AnsiString; accept_alpha, accept_numeric,
  accept_special: Boolean): Boolean;
{
  Verifica que str cumpla con los determinantes accept_numeric, accept_numeric y accept_special.

  [In]
  accept_alpha : Si es True se verifica que cada caracter de str sea alfanumérico, si es False no se
  verifica.
  accept_numeric : Si es True se verifica que cada caracter de str sea numérico, si es False no se
  verifica.
  accept_special : Si es True se verifica que cada caracter de str sea especial (espacio y '<'), si es
  False no se verifica.

  [In/Out]
  str : Resultado de haber procesado str donde se pasan todos los caracteres a upper-case y los espacios
  son reemplazados con el caracter de relleno.

  [Return]
  True si str cumple con los condicionales accept_alpha, accept_numeric y accept_special, False en caso
  contrario.
}
var
  i, len: Integer;
begin
  len := Length(str);
  i := 1;
  Result := True;
  while (i <= len) and Result do
  begin
    if str[i] in ALPHA_CHARS then
    begin
      Result := accept_alpha;
      if Result then
        str[i] := ToUpper(str[i]);
    end
    else if str[i] in NUMERIC_CHARS then
      Result := accept_numeric
    else if str[i] in SPECIAL_CHARS then
    begin
      Result := accept_special;
      if Result and (str[i] = ' ') then
        str[i] := '<';
    end
    else
      Result := False;
    i := i + 1;
  end;
end;

function TestExtendedChar(ch: AnsiString; var index: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  index := -1;
  for i := Low(EXTENDED_CHARS) to High(EXTENDED_CHARS) do
    if ch = EXTENDED_CHARS[i] then
    begin
      index := i;
      Result := True;
      Exit;
    end;
end;

function TestDocType(var doc_type: AnsiString): Boolean;
begin
  // Tipo de documento acepta caracteres alfanuméricos, numéricos y especiales.
  Result := Test(doc_type, True, True, True);
end;

function TestCountry(var country: AnsiString): Boolean;
begin
  // Tanto el país emisor como la nacionalidad deben ser caracteres alfanuméricos y numéricos.
  Result := Test(country, True, False, True);
end;

function TestDate(var _date: AnsiString): Boolean;
{
  Verifica que una fecha cumpla con el formato de fecha de ICAO (YYMMDD) y que la misma sea una fecha
  válida. Tambien son válidos los caracteres especiales (espacio y '<'). Los espacios son reemplazados por
  caracteres de relleno.

  [In]
  _date : Fecha a validar. Se asume una longitud de 6 caracteres o menos.

  [Result]
  True si la fecha es válida, False en caso contrario.
}
var
  day, month, year: Integer;
  sday, smonth, syear: AnsiString;
  dummy: TDateTime;
begin
  Result := False;
  year := -1;
  month := -1;
  day := -1;
  syear := Copy(_date, 1, 2);
  smonth := Copy(_date, 3, 2);
  sday := Copy(_date, 5, 2);
  // Se testea primero que los caracteres que componen la fecha sean numéricos o especiales.
  if not(TestAndGetNumber(syear, year) and TestAndGetNumber(smonth, month) and
    TestAndGetNumber(sday, day)) then
    Exit;
  // Testeamos que componente de la fecha falta y lo reemplazamos con un valor válido para
  // chequear que la fecha sea correcta.
  // Si el año es 1900 ó 2000 ó 3000, entonces year = 0. Ponemos year = 1900 para que funcione
  // TryEncodeDate la cual falla si year = 0 a pesar de ser un año válido.
  if (year = -1) or (year = 0) then
    year := 1900;
  // 1900 es un año válido, lo tomamos como base si falta el año.
  if (month = -1) then
    month := 1; // El mes de enero seguro es válido para cualquier valor de año.
  if (day = -1) then
    day := 1; // El día primero de mes es válido para cualquiera de los doce meses.
  Result := TryEncodeDate(year, month, day, dummy);
  if Result then
    _date := syear + smonth + sday;
end;

function TestDocNumber(var doc_number: AnsiString): Boolean;
begin
  Result := Test(doc_number, True, True, True);
end;

function TestSex(var sex: AnsiString): Boolean;
begin
  if (sex = '') or (sex = ' ') then
    sex := '<';
  sex := UpperCase(sex);
  Result := (sex = 'M') or (sex = 'F') or (sex = '<');
end;

function TestOptionalData(var optional_data: AnsiString): Boolean;
begin
  Result := Test(optional_data, True, True, True);
end;

function Normalize(var text: AnsiString): Boolean;
var
  len, i, j, k: Integer;
  transformed_text: AnsiString;
begin
  Result := False;
  i := 1;
  k := 0;
  len := Length(text);
  transformed_text := '';
  for i := 1 to len do
    if text[i] in ALPHA_CHARS then
    begin
      // Los caracteres ASCII son pasados a mayúsculas.
      transformed_text := transformed_text + UpperCase(text[i])[1];
      k := k + 1;
    end
    else if (text[i] in NUMERIC_CHARS) then
      // Los caracteres numéricos no son válidos. Salimos con Result = False.
      Exit
    else if TestExtendedChar(AnsiString(AnsiUpperCase(text[i])[1]), j) then
    begin
      // En caso de caracteres no ASCII, son reemplazados por una secuencia de caracteres ASCII.
      transformed_text := transformed_text + ICAO_MAPPINGS[j];
      k := k + Length(ICAO_MAPPINGS[j]);
    end
    else if ((text[i] = '-') or (text[i] = ' ')) and
      ((k > 0) and (transformed_text[k] <> '<')) then
    begin
      // El guión y el espacio se reemplazan por el caracter de relleno.
      // Teniendo en cuenta de que el caracter anterior no sea ya de relleno.
      transformed_text := transformed_text + '<';
      k := k + 1;
    end;
  // Por último cualquier signo de puntuación o caracter que no entra en las anteriores categorías,
  // es ignorado.
  // Como no sabemos cuantos caracteres de relleno o blancos quedan al final de text, transformed_text puede
  // quedar con un caracter de relleno de más al final.
  if (transformed_text <> '') and (transformed_text[k] = '<') then
    transformed_text := Copy(transformed_text, 1, k - 1);
  // Si pasamos por aquí es porque transformed_text está normalizado y con caracteres válidos.
  // Copiamos el texto normalizado a su origen.
  text := transformed_text;
  Result := True;
end;

function Fit(_surnames, _names: AnsiString; _count: Integer): AnsiString;
{
  Ajusta los nombres y apellidos de manera que entren en el espacio indicado por count. Se tienen en cuenta
  los caracteres de relleno.
}

  function Head(names: AnsiString): AnsiString;
  // Obtiene el primer subAnsistring de la cadena
  // se supone separado por uno o mas blancos
  // En el caso de que sean nombres retorna el primero
  var
    i, len: Integer;
  begin
    Result := '';
    i := 1;
    len := Length(names);
    if len <> 0 then
    begin
      // Elimino los blancos al principio del Ansistring
      while (names[i] = ' ') and (len >= i) do
        i := i + 1;
      // Tomo los caracteres hasta elm primer espacio
      while (names[i] <> ' ') and (len >= i) do
      begin
        Result := Result + names[i];
        i := i + 1;
      end;
    end;
  end;

  function Tail(names: AnsiString): AnsiString;
  // Retorna el subAnsistring formado por todos los Ansistring menos el primero
  // quita el primer nombre y retorna el resto
  var
    i, len: Integer;
  begin
    len := Length(names);
    Result := '';
    i := 1;
    if len <> 0 then
    begin
      // Elimina los blancos al principio de la cadena
      while (names[i] = ' ') and (len >= i) do
        i := i + 1;
      // Excluye el primer subAnsistring
      while (names[i] <> ' ') and (len >= i) do
        i := i + 1;
      // Toma el resto del Ansistring
      if (len <> i) then
        for i := i to len do
          Result := Result + names[i];
    end;
  end;

  procedure CompleteWithFillChar(var surname: AnsiString; count: Integer);
  // Completa el resto del icao con el caracter de relleno '<'
  var
    i, chars: Integer;
  begin
    chars := count - Length(surname);
    for i := 1 to chars do
      surname := surname + '<';
  end;

  procedure FillWithName(var surname, name: AnsiString; count: Integer);
  var
    i, j: Integer;
    straux: AnsiString;
  begin
    straux := '';
    straux := Head(name) + '<';
    while (name <> '') and (Length(straux) + Length(surname) <= count) do
    begin
      surname := surname + straux;
      name := Tail(name);
      straux := Head(name) + '<';
    end;
    if (name <> '') then
    begin
      i := count - Length(surname);
      if (Length(surname) = count) then
      begin
        surname[Length(surname) - 1] := '<';
        surname[Length(surname)] := straux[1];
      end
      else
        for j := 1 to i do
          surname := surname + straux[j];
    end;
    i := count - Length(surname);
    CompleteWithFillChar(surname, i);
  end;

  procedure FitSurname(var FitSurname, surname, name: AnsiString;
    count: Integer);
  var
    i, j: Integer;
    straux: AnsiString;
  begin
    FitSurname := '';
    straux := Head(surname) + '<';
    while (surname <> '') and (Length(straux) + Length(FitSurname) < count) do
    begin
      FitSurname := FitSurname + straux;
      surname := Tail(surname);
      straux := Head(surname) + '<';
    end;

    if surname <> '' then
    begin
      i := 1;
      j := count - Length(FitSurname) - 3;
      for i := 1 to j do
        FitSurname := FitSurname + straux[i];
      FitSurname := FitSurname + '<<';
    end
    else
      FitSurname := FitSurname + '<';
    FillWithName(FitSurname, name, count);
  end;

begin
  FitSurname(Result, _surnames, _names, _count);
end;

function GetDocTypeAsAnsistring(icao: MRZ_2L): AnsiString; overload;
begin
  SetLength(Result, 2);
  Move(icao.doc_type, Result[1], 2);
end;

function GetDocEmisorAsAnsistring(icao: MRZ_2L): AnsiString; overload;
begin
  SetLength(Result, 3);
  Move(icao.doc_emisor, Result[1], 3);
end;

function GetSurnamesAndNamesAsAnsistring(icao: MRZ_2L): AnsiString; overload;
begin
  SetLength(Result, 39);
  Move(icao.sur_and_name, Result[1], 39);
end;

function GetDocNumberAndCheckAsAnsistring(icao: MRZ_2L): AnsiString; overload;
{
  Devuelve el número de documento y el dígito verificador correspondiente si el número tiene una longitud
  de 9 o menos caracteres.
  Devuelve los 9 primeros dígitos del documento y un caracter de relleno si el número excede los 9
  caracteres.
}
begin
  SetLength(Result, 10);
  Move(icao.doc_number, Result[1], 9);
  // Si el total de caracteres supera los 9 devolvemos un caracter de relleno en el décimo caracter, si no
  // sumamos 48 al dígito verificador para convertirlo en caracter ASCII.
  if icao.doc_extra_chars = 0 then
    Result[10] := AnsiChar(icao.doc_number_check + 48)
  else
    Result[10] := '<';
end;

function GetNationalityAsAnsistring(icao: MRZ_2L): AnsiString; overload;
begin
  SetLength(Result, 3);
  Move(icao.nationality, Result[1], 3);
end;

function GetDateOfBirthAndCheckAsAnsistring(icao: MRZ_2L): AnsiString; overload;
{
  Devuelve la fecha de nacimiento y el dígito verificador correspondiente como Ansistring.
}
begin
  SetLength(Result, 7);
  Move(icao.date_of_birth, Result[1], 6);
  Result[7] := AnsiChar(icao.dob_check + 48);
end;

function GetSexAsAnsistring(icao: MRZ_2L): AnsiString; overload;
begin
  SetLength(Result, 1);
  Move(icao.sex, Result[1], 1);
end;

function GetDateOfExpiryAndCheckAsAnsistring(icao: MRZ_2L): AnsiString;
  overload;
begin
  SetLength(Result, 7);
  Move(icao.date_of_expiry, Result[1], 6);
  Result[7] := AnsiChar(icao.doe_check + 48);
end;

function GetOptionalDataAsAnsistringAndCheck(icao: MRZ_2L): AnsiString;
begin
  SetLength(Result, 15);
  Move(icao.optional_data, Result[1], 14);
  Result[15] := AnsiChar(icao.optional_data_check + 48);
end;

function GetCompositeCheck(icao: MRZ_2L): AnsiString; overload;
begin
  SetLength(Result, 1);
  Result[1] := AnsiChar(icao.composite_check + 48);
end;

function CopyField(field: array of BYTE; count: Integer): AnsiString;
var
  i: Integer;
  eof: Boolean;
begin
  i := 0;
  eof := False;
  Result := '';
  while (i < count) and not eof do
    if Char(field[i]) = '<' then
      eof := True
    else
    begin
      Result := Result + Char(field[i]);
      i := i + 1;
    end;
end;

function CopySurnames(field: array of BYTE; count: Integer): AnsiString;
var
  i: Integer;
  eof: Boolean;
begin
  i := 0;
  eof := False;
  Result := '';
  // Copiamos caracteres mientras no lleguemos al final o hasta encontrar el fin de los apellidos (<<).
  while (i < count) and not eof do
    // Un caracter de relleno puede significar simplemente la separación entre apellidos o el comienzo
    // del separador entre apellidos y nombres (<<).
    if Char(field[i]) = '<' then
    begin
      // En caso de NO estar al final del campo (caracter 39) testeamos el próximo caracter, en busca del
      // final de los apellidos (<<).
      if (i < count - 1) and (Char(field[i + 1]) = '<') then
        eof := True
      else
      begin
        // Si no estamos al final y el próximo caracter no es uno de relleno (<), el caracter de relleno (<)
        // indicado por i se debe reemplazar por un espacio.
        if i < count - 1 then
          Result := Result + ' ';
        i := i + 1;
      end;
    end
    else
    begin
      Result := Result + Char(field[i]);
      i := i + 1;
    end;
end;

function CopyNames(field: array of BYTE; count: Integer): AnsiString;
var
  i: Integer;
  bof, eof: Boolean;
begin
  i := 0;
  bof := False;
  eof := False;
  Result := '';
  // Buscamos primero el comienzo de los nombres que está a continuación de dos caracteres de relleno.
  while (i < count) and not bof do
  begin
    if Char(field[i]) = '<' then
      if (i < count - 1) and (Char(field[i + 1]) = '<') then
        bof := True;
    i := i + 1;
  end;
  // Tener en cuenta que el campo completo puede estar lleno de caracteres de relleno en caso de que no
  // exista información en este campo.
  if bof then
  begin
    // Ajustar i para que apunte al comienzo de los nombres.
    i := i + 1;
    while (i < count) and not eof do
      if Char(field[i]) = '<' then
      begin
        if (i < count - 1) and (Char(field[i + 1]) = '<') then
          eof := True
        else
        begin
          if i < count - 1 then
            Result := Result + ' ';
          i := i + 1;
        end;
      end
      else
      begin
        Result := Result + Char(field[i]);
        i := i + 1;
      end;
  end;
end;

function CopyDocNumber(doc_extra_chars: BYTE;
  doc_number, optional_data: array of BYTE): AnsiString;
begin
  Result := CopyField(doc_number, 9);
  // Agregamos los posibles caracteres adicionales que se encuentran en el campo de datos opcionales.
  if doc_extra_chars > 0 then
  begin
    // Se copian los caracteres extra menos el dígito verificador del documento.
    SetLength(Result, Length(Result) + doc_extra_chars - 1);
    Move(optional_data, Result[10], doc_extra_chars - 1);
  end;
end;

function CopyOptionalData(doc_extra_chars: BYTE; optional_data: array of BYTE)
  : AnsiString;
begin
  // Los datos opcionales pueden contener caracteres de relleno entre medio. Por ejemplo : aaa<bbb<ccc,
  // con lo cual copiamos el campo entero reemplazando los caracteres de relleno por blancos y haciendo un
  // trim al resultado.
  SetLength(Result, 14);
  if doc_extra_chars = 0 then
    Move(optional_data, Result[1], 14)
  else
    Move(optional_data[doc_extra_chars + 2], Result[1],
      14 - doc_extra_chars - 2);
  // Reemplazamos los caracteres de relleno por blancos.
  Result := stringReplace(Result, '<', ' ', [rfReplaceAll, rfIgnoreCase]);
  // Quitamos los blancos a izquierda y derecha.
  Result := Trim(Result);
end;

function CopyDate(_date: array of BYTE): AnsiString;
begin
  SetLength(Result, 6);
  Move(_date, Result[1], 6);
end;

function ComposeDocType(icao: MRZ_2L): AnsiString; overload;
begin
  Result := CopyField(icao.doc_type, 2);
end;

function ComposeDocEmisor(icao: MRZ_2L): AnsiString; overload;
begin
  Result := CopyField(icao.doc_emisor, 3);
end;

function ComposeSurnames(icao: MRZ_2L): AnsiString; overload;
begin
  Result := CopySurnames(icao.sur_and_name, 39);
end;

function ComposeNames(icao: MRZ_2L): AnsiString; overload;
begin
  Result := CopyNames(icao.sur_and_name, 39);
end;

function ComposeDocNumber(icao: MRZ_2L): AnsiString; overload;
begin
  Result := CopyDocNumber(icao.doc_extra_chars, icao.doc_number,
    icao.optional_data);
end;

function ComposeNationality(icao: MRZ_2L): AnsiString; overload;
begin
  Result := CopyField(icao.nationality, 3);
end;

function ComposeSex(icao: MRZ_2L): AnsiString; overload;
begin
  Result := CopyField(icao.sex, 1);
end;

function ComposeOptionalData(icao: MRZ_2L): AnsiString;
begin
  Result := CopyOptionalData(icao.doc_extra_chars, icao.optional_data);
end;

function ComposeDateOfBirth(icao: MRZ_2L): AnsiString; overload;
begin
  Result := CopyDate(icao.date_of_birth);
end;

function ComposeDateOfExpiry(icao: MRZ_2L): AnsiString; overload;
begin
  Result := CopyDate(icao.date_of_expiry);
end;

procedure GetDocCheckAndExtraCharsMRZ_2L(optional_data: TICAOLINES;
  var dnc, dec: BYTE);
var
  i: BYTE;
  eof: Boolean;
begin
  i := 0;
  eof := False;
  while (i < 14) and not eof do
  begin
    if Char(optional_data[1, 28 + i]) = '<' then
      eof := True
    else
      i := i + 1;
  end;
  dnc := optional_data[1, 27 + i] - 48;
  dec := i;
end;

{ ------------------------------- Funciones que se exportan ------------------------------- }

function GenerateMRZ_2LIcao(ICAO_LINES: TICAOLINES; var icao: MRZ_2L): Integer;
{
  Genera un ICAO de dos líneas (MRZ_2L) a partir de las líneas tomadas del scanner (icao_lines).
  Se supone que icao_lines contiene la información de un documento con dos líneas de información.

  [In]
  icao_lines : Líneas leidas desde un scanner que representan el ICAO de un documento de dos líneas.
  El contenido de la misma se compone de caracteres ASCII.

  [Out]
  icao : ICAO generado de dos líneas.

  [Result]
  En caso de error en alguno de los campos, se devuelve un código de error indicando que campo falló.
}
begin
  Result := 0;
  { TODO : Agregar chequeo de icao_lines }
  // Tipo de documento.
  Move(ICAO_LINES[0, 0], icao.doc_type, 2);
  // Emisor del documento.
  Move(ICAO_LINES[0, 2], icao.doc_emisor, 3);
  // Apellidos y nombres.
  Move(ICAO_LINES[0, 5], icao.sur_and_name, 39);
  // Número de documento.
  Move(ICAO_LINES[1, 0], icao.doc_number, 9);
  // Si encontramos un caracter de relleno aquí el resto del número de documento está en el campo de datos
  // opcionales.
  if Char(ICAO_LINES[1, 9]) = '<' then
    // Copiamos check del número de documento y caracteres extras del documento.
    GetDocCheckAndExtraCharsMRZ_2L(ICAO_LINES, icao.doc_number_check,
      icao.doc_extra_chars)
  else
  begin
    Move(ICAO_LINES[1, 9], icao.doc_number_check, 1);
    icao.doc_extra_chars := 0;
  end;
  // Nacionalidad.
  Move(ICAO_LINES[1, 10], icao.nationality, 3);
  // Fecha de nacimiento.
  Move(ICAO_LINES[1, 13], icao.date_of_birth, 6);
  // Check de la fecha de nacimiento.
  Move(ICAO_LINES[1, 19], icao.dob_check, 1);
  icao.dob_check := icao.dob_check - 48;
  // Sexo.
  Move(ICAO_LINES[1, 20], icao.sex, 1);
  // Fecha de vencimiento del documento.
  Move(ICAO_LINES[1, 21], icao.date_of_expiry, 6);
  // Check de la fecha de vencimiento.
  Move(ICAO_LINES[1, 27], icao.doe_check, 1);
  icao.doe_check := icao.doe_check - 48;
  // Datos opcionales.
  Move(ICAO_LINES[1, 28], icao.optional_data, 14);
  // Check de datos opcionales.
  Move(ICAO_LINES[1, 42], icao.optional_data_check, 1);
  icao.optional_data_check := icao.optional_data_check - 48;
  // Check compuesto.
  Move(ICAO_LINES[1, 43], icao.composite_check, 1);
  icao.composite_check := icao.composite_check - 48;
end;

function GenerateMRZ_2LIcao(doc_type, doc_emisor, surnames, names, doc_number,
  nationality, sex, optional_data, date_of_birth, date_of_expiry: AnsiString;
  var icao: MRZ_2L): Integer;
{
  Genera un icao (MRZ_2L).

  [In]

  doc_type : Tipo de documento. Máximo 2 caracteres.
  doc_emisor : País emisor del documento. Máximo 3 caracteres.
  surnames : Apellidos separados por espacios.
  names : Nombres separados por espacios.
  doc_number : Número del documento.
  nationality : Nacionalidad del dueño del documento. Máximo 3 caracteres.
  sex : Sexo. 1 caracter ('M', 'F' o '<')
  optional_data : Datos opcionales.
  date_of_birth : Fecha de nacimiento.
  date_of_expiry : Fecha de vencimiento del documento.

  [Out]

  icao : ICAO generado con los datos de entrada.

  [Return]

  Código de error indicando en que parte de los datos hay fallos. Cero si está todo ok.
}
var
  aux, aux2: AnsiString;
begin
  Result := 0;
  // Inicializamos la estructura ICAO.
  FillChar(icao, 89, 0);
  // La longitud del tipo de documento no debe ser mayor a dos caracteres.
  // Los caracteres válidos para el tipo son alfanuméricos, numéricos o especiales (espacio y <).
  if (Length(doc_type) > 2) or (not TestDocType(doc_type)) then
  begin
    Result := DOC_TYPE_INVALID;
    Exit;
  end;
  // Completar campo con los caracteres de relleno que corresponda
  FillField(aux, doc_type, 2);
  // Copiamos tipo documento a la estructura
  Move(aux[1], icao.doc_type, 2);
  // La longitud del país emisor del documento no debe superar los 3 caracteres.
  // Los caracteres válidos son alfanuméricos y especiales.
  if (Length(doc_emisor) > 3) or (not TestCountry(doc_emisor)) then
  begin
    Result := DOC_EMISOR_INVALID;
    Exit;
  end;
  // Completar con relleno donde corresponda.
  FillField(aux, doc_emisor, 3);
  // Copiamos emisor del documento a la estructura
  Move(aux[1], icao.doc_emisor, 3);
  // Normalizamos apellidos y nombres. Los caracteres no ASCII se reemplazan por series de caracteres ASCII.
  // Se truncan los apellidos y nombres que excedan el máximo permitido de 39 caracteres entre ambos.
  // Los caracteres numéricos no estan permitidos.
  // Los caracteres '-' se reemplazan por caracteres de relleno '<'.
  // Los apóstrofes (') se ignoran como así cualquier otro signo de puntuación.
  if not Normalize(surnames) then
  begin
    Result := SURNAME_INVALID;
    Exit;
  end;
  if not Normalize(names) then
  begin
    Result := NAME_INVALID;
    Exit;
  end;
  // Truncamos los apellidos y nombres a 39 caracteres.
  aux2 := Fit(surnames, names, 39);
  // Copiamos apellidos y nombres. Completamos el campo con caracteres de relleno si es necesario.
  // El total de caracteres para apellidos y nombres es de 39.
  FillField(aux, aux2, 39);
  Move(aux[1], icao.sur_and_name, 39);
  // Testeamos la validez del número de documento.
  if not TestDocNumber(doc_number) then
  begin
    Result := DOC_NUMBER_INVALID;
    Exit;
  end;
  // Si el documento tiene más de 9 caracteres se copiarán los nueve primeros más un caracter de relleno
  // y los restantes pasan al campo de datos opcionales más el dígito verificador y un caracter de relleno.
  // En caso de que el documento tenga 9 o menos caracteres se copian en el campo más el dígito verificador
  // y se completa con caracteres de relleno.
  if Length(doc_number) > 9 then
  begin
    icao.doc_extra_chars := Length(doc_number) - 9;
    Move(doc_number[1], icao.doc_number, 9);
  end
  else
  begin
    icao.doc_extra_chars := 0;
    FillField(aux, doc_number, 9);
    Move(aux[1], icao.doc_number, 9);
  end;
  icao.doc_number_check := GetCheckDigit(doc_number);
  // La longitud de la nacionalidad no debe exceder los 3 caracteres al igual que el emisor del documento.
  if (Length(nationality) > 3) or (not TestCountry(nationality)) then
  begin
    Result := NATIONALITY_INVALID;
    Exit;
  end;
  // Completar con relleno donde corresponda.
  FillField(aux, nationality, 3);
  // Copiamos la nacionalidad. No lleva dígito verificador.
  Move(aux[1], icao.nationality, 3);
  // La fecha de nacimiento no debe sobrepasar los 6 caracteres. En caso de que no se conozca alguna
  // información de la fecha de nacimiento, como por ejemplo el mes, los caracteres deben estar en blanco
  // o poner en su lugar caracteres de relleno.
  if (Length(date_of_birth) > 6) or (not TestDate(date_of_birth)) then
  begin
    Result := DATE_OF_BIRTH_INVALID;
    Exit;
  end;
  // Copiamos fecha de nacimiento más dígito verificador.
  Move(date_of_birth[1], icao.date_of_birth, 6);
  icao.dob_check := GetCheckDigit(date_of_birth);
  // En el caso del sexo se admiten, F para femenino, M para masculino y cualquier otro caracter alfanumérico
  // o especial se toma como sexo desconocido y se reemplaza por un caracter de relleno (<).
  // Si el sexo excede la longitud de 1 caracter se toma como inválido lo mismo si se trata de un caracter
  // numérico.
  if (Length(sex) > 1) or (not TestSex(sex)) then
  begin
    Result := SEX_INVALID;
    Exit;
  end;
  // Copiamos el sexo.
  Move(sex[1], icao.sex, 1);
  // La fecha de vencimiento del documento debe cumplir con las mismas restricciones que la fecha de
  // nacimiento.
  if (Length(date_of_expiry) > 6) or (not TestDate(date_of_expiry)) then
  begin
    Result := DATE_OF_EXPIRY_INVALID;
    Exit;
  end;
  // Copiamos fecha de vencimiento del documento más dígito verificador.
  Move(date_of_expiry[1], icao.date_of_expiry, 6);
  icao.doe_check := GetCheckDigit(date_of_expiry);
  // Si bien se permite cualquier combinación de caracteres y números. Los caracteres no ASCII no están
  // permitidos en los datos opcionales
  if (not TestOptionalData(optional_data)) or
  // La información adicional puede ser cualquier combinación de caracteres válidos o números que no exceda
  // la cantidad de 14 caracteres para lo que ISO define como ID1.
  // Los datos opcionales no pueden exceder los 14 caracteres.
    (Length(optional_data) > 14) or
  // En el caso de que el número de documento exceda los 9 caracteres y existan datos opcionales, la suma
  // del excedente del documento más el dígito verificador más un caracter de relleno más los datos
  // opcionales, no deben exceder los 14 caracteres.
    ((Length(optional_data) > 0) and (icao.doc_extra_chars > 0) and
    ((icao.doc_extra_chars + 2 + Length(optional_data)) > 14)) or
  // Si el número de documento excede los 9 caracteres pero no tenemos información adicional, la suma del
  // excedente del número de documento más el dígito verificador no deben exceder los 14 caracteres.
    ((icao.doc_extra_chars > 0) and (Length(optional_data) = 0) and
    (icao.doc_extra_chars + 1 > 14)) then
  begin
    Result := OPTIONAL_DATA_EXCEED_LENGTH;
    Exit;
  end;
  // A esta altura estamos seguros de que los datos entran en su respectivo lugar.
  aux2 := '';
  if icao.doc_extra_chars > 0 then
    // Copiamos los caracteres del número de documento que exceden los 9 caracteres.
    // El dígito verificador aqui queda expresado como un caracter ASCII en lugar de un byte.
    aux2 := Copy(doc_number, 10, icao.doc_extra_chars) +
      Char(icao.doc_number_check + 48);
  if Length(optional_data) > 0 then
  begin
    // Agregamos un caracter de relleno entre el exceso del número de documento y los datos opcionales.
    if icao.doc_extra_chars > 0 then
      aux2 := aux2 + '<';
    aux2 := aux2 + optional_data;
  end;
  // Agregamos el posible relleno.
  FillField(aux, aux2, 14);
  // Se calcula el dígito verificador de los datos opcionales que puede contener información del número de
  // documento más el dígito verificador del mismo y se agrega al ICAO.
  Move(aux[1], icao.optional_data, 14);
  icao.optional_data_check := GetCheckDigit(aux);
  // Por último se calcula el dígito verificador compuesto con los caracteres 45 a 54, 58 a 64 y 66 a 87 del
  // ICAO generado hasta aquí.
  icao.composite_check := GetCheckDigit(GetDocNumberAndCheckAsAnsistring(icao) +
    GetDateOfBirthAndCheckAsAnsistring(icao) +
    GetDateOfExpiryAndCheckAsAnsistring(icao));
end;

function GetPrintableMRZ_2LIcao(icao: MRZ_2L): AnsiString;
{
  Convierte un ICAO (MRZ_2L) a Ansistring para su impresión.

  [In]

  Icao a convertir.
}
begin
  Result := GetDocTypeAsAnsistring(icao) + GetDocEmisorAsAnsistring(icao) +
    GetSurnamesAndNamesAsAnsistring(icao) + GetDocNumberAndCheckAsAnsistring
    (icao) + GetNationalityAsAnsistring(icao) +
    GetDateOfBirthAndCheckAsAnsistring(icao) + GetSexAsAnsistring(icao) +
    GetDateOfExpiryAndCheckAsAnsistring(icao) +
    GetOptionalDataAsAnsistringAndCheck(icao) + GetCompositeCheck(icao);
end;

function GetPrintableMRZ_2LIcao2L(icao: MRZ_2L): TStringList;
{
  Convierte un ICAO (MRZ_2L) en una versión imprimible.

  [In]
  icao : ICAO a convertir.

  [Result]
  Se devuelve un Ansistring-list con dos líneas de texto de 44 caracteres cada uno según la especificación
  ISO-9330 para documentos tipo ID1.
}
begin
  Result := TStringList.Create;
  Result.Add(GetDocTypeAsAnsistring(icao) + GetDocEmisorAsAnsistring(icao) +
    GetSurnamesAndNamesAsAnsistring(icao));
  Result.Add(GetDocNumberAndCheckAsAnsistring(icao) + GetNationalityAsAnsistring
    (icao) + GetDateOfBirthAndCheckAsAnsistring(icao) + GetSexAsAnsistring(icao)
    + GetDateOfExpiryAndCheckAsAnsistring(icao) +
    GetOptionalDataAsAnsistringAndCheck(icao) + GetCompositeCheck(icao));
end;

procedure ExtractFromMRZ_2LIcao(var doc_type, doc_emisor, surnames, names,
  doc_number, nationality, sex, optional_data, date_of_birth,
  date_of_expiry: AnsiString; icao: MRZ_2L);
{
  Devuelve las partes componentes del ICAO.

  [In]

  icao : ICAO a diseccionar.

  [Out]

  doc_type : Tipo de documento.
  doc_emisor : País emisor del documento.
  surnames : Apellidos separados por espacios.
  names : Nombres separados por espacios.
  doc_number : Número de documento.
  nationality : Nacionalidad del dueño del documento.
  sex : Sexo.
  optional_data : Datos opcionales.
  date_of_birth : Fecha de nacimiento.
  date_of_expiry : Fecha de vencimiento del documento.
}
begin
  doc_type := ComposeDocType(icao);
  doc_emisor := ComposeDocEmisor(icao);
  surnames := ComposeSurnames(icao);
  names := ComposeNames(icao);
  doc_number := ComposeDocNumber(icao);
  nationality := ComposeNationality(icao);
  sex := ComposeSex(icao);
  optional_data := ComposeOptionalData(icao);
  date_of_birth := ComposeDateOfBirth(icao);
  date_of_expiry := ComposeDateOfExpiry(icao);
end;

{ ------------------------------------------- ICAO de 3 líneas ------------------------------------------- }

function GetDocTypeAsAnsistring(icao: MRZ_3L): AnsiString; overload;
begin
  SetLength(Result, 2);
  Move(icao.doc_type, Result[1], 2);
end;

function GetDocEmisorAsAnsistring(icao: MRZ_3L): AnsiString; overload;
begin
  SetLength(Result, 3);
  Move(icao.doc_emisor, Result[1], 3);
end;

function GetDocNumberAndCheckAsAnsistring(icao: MRZ_3L): AnsiString; overload;
begin
  SetLength(Result, 10);
  Move(icao.doc_number, Result[1], 9);
  if icao.doc_extra_chars = 0 then
    Result[10] := AnsiChar(icao.doc_number_check + 48)
  else
    Result[10] := '<';
end;

function GetOptionalDataLine1AsAnsistring(icao: MRZ_3L): AnsiString;
begin
  SetLength(Result, 15);
  Move(icao.optional_data_1, Result[1], 15);
end;

function GetDateOfBirthAndCheckAsAnsistring(icao: MRZ_3L): AnsiString; overload;
begin
  SetLength(Result, 7);
  Move(icao.date_of_birth, Result[1], 6);
  Result[7] := AnsiChar(icao.dob_check + 48);
end;

function GetSexAsAnsistring(icao: MRZ_3L): AnsiString; overload;
begin
  SetLength(Result, 1);
  Move(icao.sex, Result[1], 1);
end;

function GetDateOfExpiryAndCheckAsAnsistring(icao: MRZ_3L): AnsiString;
  overload;
begin
  SetLength(Result, 7);
  Move(icao.date_of_expiry, Result[1], 6);
  Result[7] := AnsiChar(icao.doe_check + 48);
end;

function GetNationalityAsAnsistring(icao: MRZ_3L): AnsiString; overload;
begin
  SetLength(Result, 3);
  Move(icao.nationality, Result[1], 3);
end;

function GetOptionalDataLine2AsAnsistring(icao: MRZ_3L): AnsiString;
begin
  SetLength(Result, 11);
  Move(icao.optional_data_2, Result[1], 11);
end;

function GetCompositeCheck(icao: MRZ_3L): AnsiString; overload;
begin
  SetLength(Result, 1);
  Result[1] := AnsiChar(icao.composite_check + 48);
end;

function GetSurnamesAndNamesAsAnsistring(icao: MRZ_3L): AnsiString; overload;
begin
  SetLength(Result, 30);
  Move(icao.sur_and_name, Result[1], 30);
end;

function ComposeDocType(icao: MRZ_3L): AnsiString; overload;
begin
  Result := CopyField(icao.doc_type, 2);
end;

function ComposeDocEmisor(icao: MRZ_3L): AnsiString; overload;
begin
  Result := CopyField(icao.doc_emisor, 3);
end;

function ComposeSurnames(icao: MRZ_3L): AnsiString; overload;
begin
  Result := CopySurnames(icao.sur_and_name, 30);
end;

function ComposeNames(icao: MRZ_3L): AnsiString; overload;
begin
  Result := CopyNames(icao.sur_and_name, 30);
end;

function ComposeDocNumber(icao: MRZ_3L): AnsiString; overload;
begin
  Result := CopyDocNumber(icao.doc_extra_chars, icao.doc_number,
    icao.optional_data_1);
end;

function ComposeNationality(icao: MRZ_3L): AnsiString; overload;
begin
  Result := CopyField(icao.nationality, 3);
end;

function ComposeSex(icao: MRZ_3L): AnsiString; overload;
begin
  Result := CopyField(icao.sex, 1);
end;

function ComposeOptionalDataLine1(icao: MRZ_3L): AnsiString;
begin
  // Los datos opcionales pueden contener caracteres de relleno entre medio. Por ejemplo : aaa<bbb<ccc,
  // con lo cual copiamos el campo entero reemplazando los caracteres de relleno por blancos y haciendo un
  // trim al resultado.
  SetLength(Result, 15);
  if icao.doc_extra_chars = 0 then
    Move(icao.optional_data_1, Result[1], 15)
  else
    // +2 por el dígito verificador del documento más un caracter de relleno que hace las veces de
    // separador.
    Move(icao.optional_data_1[icao.doc_extra_chars + 2], Result[1],
      15 - icao.doc_extra_chars - 2);
  // Reemplazamos los caracteres de relleno por blancos.
  Result := stringReplace(Result, '<', ' ', [rfReplaceAll, rfIgnoreCase]);
  // Quitamos los blancos a izquierda y derecha.
  Result := Trim(Result);
end;

function ComposeOptionalDataLine2(icao: MRZ_3L): AnsiString;
begin
  SetLength(Result, 11);
  // Copiamos la información adicional de la segunda línea de un icao de 3 líneas. Son 11 caracteres.
  Move(icao.optional_data_2, Result[1], 11);
  // Reemplazamos los caracteres de relleno por blancos.
  Result := stringReplace(Result, '<', ' ', [rfReplaceAll, rfIgnoreCase]);
  // Quitamos los blancos a izquierda y derecha.
  Result := Trim(Result);
end;

function ComposeDateOfBirth(icao: MRZ_3L): AnsiString; overload;
begin
  Result := CopyDate(icao.date_of_birth);
end;

function ComposeDateOfExpiry(icao: MRZ_3L): AnsiString; overload;
begin
  Result := CopyDate(icao.date_of_expiry);
end;

procedure GetDocCheckAndExtraCharsMRZ_3L(optional_data: TICAOLINES;
  var dnc, dec: BYTE);
var
  i: BYTE;
  eof: Boolean;
begin
  i := 0;
  eof := False;
  while (i < 15) and not eof do
  begin
    if Char(optional_data[0, 15 + i]) = '<' then
      eof := True
    else
      i := i + 1;
  end;
  dnc := optional_data[0, 14 + i] - 48;
  dec := i;
end;

function GenerateMRZ_3LIcao(ICAO_LINES: TICAOLINES; var icao: MRZ_3L)
  : Integer; overload;
begin
  Result := 0;
  { TODO : Agregar chequeo de campos desde icao_lines }
  Move(ICAO_LINES[0, 0], icao.doc_type, 2);
  Move(ICAO_LINES[0, 2], icao.doc_emisor, 3);
  Move(ICAO_LINES[0, 5], icao.doc_number, 9);
  // Copiar caracteres extra del número de documento si existen.
  if Char(ICAO_LINES[0, 14]) = '<' then
    GetDocCheckAndExtraCharsMRZ_3L(ICAO_LINES, icao.doc_number_check,
      icao.doc_extra_chars)
  else
  begin
    Move(ICAO_LINES[0, 14], icao.doc_number_check, 1);
    icao.doc_extra_chars := 0;
  end;
  Move(ICAO_LINES[0, 15], icao.optional_data_1, 15);
  Move(ICAO_LINES[1, 0], icao.date_of_birth, 6);
  icao.dob_check := ICAO_LINES[1, 6];
  icao.dob_check := icao.dob_check - 48;
  Move(ICAO_LINES[1, 7], icao.sex, 1);
  Move(ICAO_LINES[1, 8], icao.date_of_expiry, 6);
  icao.doe_check := ICAO_LINES[1, 14];
  icao.doe_check := icao.doe_check - 48;
  Move(ICAO_LINES[1, 15], icao.nationality, 3);
  Move(ICAO_LINES[1, 18], icao.optional_data_2, 11);
  icao.composite_check := ICAO_LINES[1, 29];
  icao.composite_check := icao.composite_check - 48;
  Move(ICAO_LINES[2, 0], icao.sur_and_name, 30);
end;

function GenerateMRZ_3LIcao(doc_type, doc_emisor, surnames, names, doc_number,
  nationality, sex, optional_data_line1, optional_data_line2, date_of_birth,
  date_of_expiry: AnsiString; var icao: MRZ_3L): Integer;
var
  aux, aux2: AnsiString;
begin
  Result := 0;
  FillChar(icao, 90, 0);
  if (Length(doc_type) > 2) or (not TestDocType(doc_type)) then
  begin
    Result := DOC_TYPE_INVALID;
    Exit;
  end;
  FillField(aux, doc_type, 2);
  Move(aux[1], icao.doc_type, 2);
  if (Length(doc_emisor) > 3) or (not TestCountry(doc_emisor)) then
  begin
    Result := DOC_EMISOR_INVALID;
    Exit;
  end;
  FillField(aux, doc_emisor, 3);
  Move(aux[1], icao.doc_emisor, 3);
  // Testear documento.
  if not TestDocNumber(doc_number) then
  begin
    Result := DOC_NUMBER_INVALID;
    Exit;
  end;
  // Si el documento tiene más de 9 caracteres se copiarán los nueve primeros más un caracter de relleno
  // y los restantes pasan al primer campo de datos (primer línea) opcionales más el dígito verificador y
  // un caracter de relleno.
  // En caso de que el documento tenga 9 o menos caracteres se copian en el campo más el dígito verificador
  // y se completa con caracteres de relleno.
  if Length(doc_number) > 9 then
  begin
    icao.doc_extra_chars := Length(doc_number) - 9;
    Move(doc_number[1], icao.doc_number, 9);
  end
  else
  begin
    icao.doc_extra_chars := 0;
    FillField(aux, doc_number, 9);
    Move(aux[1], icao.doc_number, 9);
  end;
  icao.doc_number_check := GetCheckDigit(doc_number);
  // Si bien se permite cualquier combinación de caracteres y números. Los caracteres no ASCII no están
  // permitidos en los datos opcionales
  if (not TestOptionalData(optional_data_line1)) or
  // La información adicional del primer campo (primer línea) puede ser cualquier combinación de
  // caracteres válidos o números que no exceda la cantidad de 15 caracteres para lo que ISO define
  // como ID2.
  // Los datos opcionales no pueden exceder los 15 caracteres para éste campo.
    (Length(optional_data_line1) > 30) or
  // En el caso de que el número de documento exceda los 9 caracteres y existan datos opcionales, la suma
  // del excedente del documento más el dígito verificador más un caracter de relleno más los datos
  // opcionales, no deben exceder los 15 caracteres.
    ((Length(optional_data_line1) > 0) and (icao.doc_extra_chars > 0) and
    ((icao.doc_extra_chars + 2 + Length(optional_data_line1)) > 30)) or
  // Si el número de documento excede los 9 caracteres pero no tenemos información adicional, la suma del
  // excedente del número de documento más el dígito verificador no deben exceder los 15 caracteres.
    ((icao.doc_extra_chars > 0) and (Length(optional_data_line1) = 0) and
    (icao.doc_extra_chars + 1 > 30)) then
  begin
    Result := OPTIONAL_DATA_EXCEED_LENGTH;
    Exit;
  end;
  // A esta altura estamos seguros de que los datos entran en su respectivo lugar.
  aux2 := '';
  if icao.doc_extra_chars > 0 then
    // Copiamos los caracteres del número de documento que exceden los 9 caracteres.
    // El dígito verificador aqui queda expresado como un caracter ASCII en lugar de un byte.
    aux2 := Copy(doc_number, 10, icao.doc_extra_chars) +
      Char(icao.doc_number_check + 48);
  if Length(optional_data_line1) > 0 then
  begin
    // Agregamos un caracter de relleno entre el exceso del número de documento y los datos opcionales.
    if icao.doc_extra_chars > 0 then
      aux2 := aux2 + '<';
    aux2 := aux2 + optional_data_line1;
  end;
  // Agregamos el posible relleno.
  FillField(aux, aux2, 15);
  Move(aux[1], icao.optional_data_1, 15);
  // Fecha de nacimiento.
  if (Length(date_of_birth) > 6) or (not TestDate(date_of_birth)) then
  begin
    Result := DATE_OF_BIRTH_INVALID;
    Exit;
  end;
  Move(date_of_birth[1], icao.date_of_birth, 6);
  icao.dob_check := GetCheckDigit(date_of_birth);
  if (Length(sex) > 1) or (not TestSex(sex)) then
  begin
    Result := SEX_INVALID;
    Exit;
  end;
  Move(sex[1], icao.sex, 1);
  if (Length(date_of_expiry) > 6) or (not TestDate(date_of_expiry)) then
  begin
    Result := DATE_OF_EXPIRY_INVALID;
    Exit;
  end;
  Move(date_of_expiry[1], icao.date_of_expiry, 6);
  icao.doe_check := GetCheckDigit(date_of_expiry);
  if (Length(nationality) > 3) or (not TestCountry(nationality)) then
  begin
    Result := NATIONALITY_INVALID;
    Exit;
  end;
  FillField(aux, nationality, 3);
  Move(aux[1], icao.nationality, 3);
  if (Length(optional_data_line2) > 11) or
    (not TestOptionalData(optional_data_line2)) then
  begin
    Result := OPTIONAL_DATA_EXCEED_LENGTH;
    Exit;
  end;
  FillField(aux, optional_data_line2, 11);
  Move(aux[1], icao.optional_data_2, 11);
  icao.composite_check :=
    GetCheckDigit(doc_number + Char(icao.doc_number_check + 48) +
    optional_data_line1 + date_of_birth + Char(icao.dob_check + 48) +
    date_of_expiry + Char(icao.doe_check + 48) + optional_data_line2);
  if not Normalize(surnames) then
  begin
    Result := SURNAME_INVALID;
    Exit;
  end;
  if not Normalize(names) then
  begin
    Result := NAME_INVALID;
    Exit;
  end;
  aux2 := Fit(surnames, names, 30);
  FillField(aux, aux2, 30);
  Move(aux[1], icao.sur_and_name, 30);
end;

function GetPrintableMRZ_3LIcao(icao: MRZ_3L): AnsiString;
begin
  Result := GetDocTypeAsAnsistring(icao) + GetDocEmisorAsAnsistring(icao) +
    GetDocNumberAndCheckAsAnsistring(icao) + GetOptionalDataLine1AsAnsistring
    (icao) + GetDateOfBirthAndCheckAsAnsistring(icao) + GetSexAsAnsistring(icao)
    + GetDateOfExpiryAndCheckAsAnsistring(icao) + GetNationalityAsAnsistring
    (icao) + GetOptionalDataLine2AsAnsistring(icao) + GetCompositeCheck(icao) +
    GetSurnamesAndNamesAsAnsistring(icao);
end;

function GetPrintableMRZ_3LIcao3L(icao: MRZ_3L): TStringList;
begin
  Result := TStringList.Create;
  Result.Add(GetDocTypeAsAnsistring(icao) + GetDocEmisorAsAnsistring(icao) +
    GetDocNumberAndCheckAsAnsistring(icao) +
    GetOptionalDataLine1AsAnsistring(icao));
  Result.Add(GetDateOfBirthAndCheckAsAnsistring(icao) + GetSexAsAnsistring(icao)
    + GetDateOfExpiryAndCheckAsAnsistring(icao) + GetNationalityAsAnsistring
    (icao) + GetOptionalDataLine2AsAnsistring(icao) + GetCompositeCheck(icao));
  Result.Add(GetSurnamesAndNamesAsAnsistring(icao));
end;

procedure ExtractFromMRZ_3LIcao(var doc_type, doc_emisor, surnames, names,
  doc_number, nationality, sex, optional_data_line1, optional_data_line2,
  date_of_birth, date_of_expiry: AnsiString; icao: MRZ_3L);
begin
  doc_type := ComposeDocType(icao);
  doc_emisor := ComposeDocEmisor(icao);
  surnames := ComposeSurnames(icao);
  names := ComposeNames(icao);
  doc_number := ComposeDocNumber(icao);
  nationality := ComposeNationality(icao);
  sex := ComposeSex(icao);
  optional_data_line1 := ComposeOptionalDataLine1(icao);
  optional_data_line2 := ComposeOptionalDataLine2(icao);
  date_of_birth := ComposeDateOfBirth(icao);
  date_of_expiry := ComposeDateOfExpiry(icao);
end;

end.
