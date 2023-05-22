unit uFunciones;// Funciones hechas por Adrián

interface
uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,Dialogs,
     StrUtils,winsock,Printers,jpeg,StdCtrls,TlHelp32,ShFolder, ShlObj,DateUtils,
     uFirmaDll;

    //*************************** VALIDACIONES ***************************//

    // Valida que la fecha se una fecha apropiada -- Adrián
    Function ValidarFecha(fecha:string): String;

    // Valida que la fecha se una Hora apropiada -- Adrián
    Function ValidarHora(Hora:string): String;

    // Validamos los diferentes tipos de tipeo -- Adrián
    // El #8 es el 'Borrar', #13 'ENTER' y #32 'Espacio'

    // TIPEO DE LETRAS
    //Admite solo Letras
    Function ValidarSoloLetras(Key:Char):Boolean;
    //No admite ' '
    Function ValidarSoloLetrasUsuario(Key:Char):Boolean;
    //Admite ' - '
    Function ValidarLetrasGuion(Key:Char):Boolean;
    //Admite ' / '
    Function ValidarLetrasBarra(Key:Char):Boolean;
    //Admite ' / ' y ' - '
    Function ValidarLetrasFull(Key:Char):Boolean;

    // TIPEO DE NUMEROS
    //Admite solo numeros
    Function ValidarSoloNumeros(Key:Char):Boolean;
    //Admite ' - '
    Function ValidarNumerosGuion(Key:Char):Boolean;
    //Admite ' / '
    Function ValidarNumerosBarra(Key:Char):Boolean;
    //Admite ' / ' y ' - '
    Function ValidarNumerosFull(Key:Char):Boolean;

    //TIPEO ALFANUMERICO
    //Admite letras y numeros
    Function ValidarLetrasNumeros(Key:Char):Boolean;
    //Admite ' - '
    Function ValidarLetrasNumerosGuion(Key:Char):Boolean;
    //Admite ' / '
    Function ValidarLetrasNumerosBarra(Key:Char):Boolean;
    //Admite ' / ' y ' - '
    Function ValidarLetrasNumerosFull(Key:Char):Boolean;
  
    // Como el Memo no tiene la opcion UpperCase la Simulamos.. Adrián
    Function PasarMayusMemo(Key:Char):Char;

    //*************************** FUNCIONES ***************************//

    // Calcula la cantidad de años que tiene la persona -- Adrián
    Function CalcularAnios(Fecha_Nac:String):String;

    // Devulve la primer palabra que encuentra antes de un espacio 
    Function DamePrimerPalabra(Frase:String):String;

    // Devuelve la ip de la máquina
    Function ObtenerIPMaquina:String;

    (* En nombre pasas el todo el nombre completo y te divide en "Nombre1"(str1)
       y "Nombre2"(str2) *)
    Procedure CorregirNombresApellidos(nombre: string; var str1, str2: String);

    //Devuelve una lista de strings (Saca los espacios y devuleve la palabras) -- Adrián
    Function SepararPalabras(str:string):TStringList;

    //Devuelve el mes en letras (Todo Mayúscula)
    Function DameMesEnLetras(mes:integer):String;

    //Devuelve la primer letra Mayúscula
    Function PrimeraMayuscula(palabra:string):String;

    //Devuelve la fecha pasada en text. Puede tener hora (no la tiene en cuenta)
    Function DameFechaEnLetras(fecha:String):String;

    //Elimina el elmento pasado por item
    Procedure BorrarItem(var v:array of integer;var cantidad_registros:integer;item:integer;Pos:integer);overload;
    Procedure BorrarItem(var v:array of string;var cantidad_registros:integer;item:string;Pos:integer);overload;

    //Te dice la primera posición donde se encuentre el item pasado por parametro
    Function DamePosItemEnVector(v:array of integer;item:integer):Integer;overload;
    Function DamePosItemEnVector(v:array of string;item:string):Integer;overload;

    //Reemplzar los caracteres que se encuentran en la frase
    Procedure ReemplazarCaracter(var Frase:String;Caracter_A_Borrar:char;Caracter_Final:Char);

    //Insertamos el item en la posicion
    Procedure InsertarItem(var v:array of string;CantidadDatos:integer;Pos:Integer;Item:String);overload;
    Procedure InsertarItem(var v:array of integer;CantidadDatos:integer;Pos:Integer;Item:integer);overload;
    
    //Cambiamos la posicion del item en el vector y trasladamos el resto
    Procedure CambiarPosItem(var v:array of string;CantidadDatos:integer;Vieja_Pos,Nueva_Pos:Integer);overload;
    Procedure CambiarPosItem(var v:array of integer;CantidadDatos:integer;Vieja_Pos,Nueva_Pos:Integer);overload;

    //Ordenamos el vector de menor a mayor
    Procedure OrdenarVectorAsc(var v:array of string;CantidadDatos:integer);overload;
    Procedure OrdenarVectorAsc(var v:array of integer;CantidadDatos:integer);overload;

    //Ordenamos el vector de mayor a menor
    Procedure OrdenarVectorDes(var v:array of string;CantidadDatos:integer);overload;
    Procedure OrdenarVectorDes(var v:array of integer;CantidadDatos:integer);overload;

    (* Devuelve una lista de strings con la frase que estan seperadas por el
       caracter pasado como parámetro *)
    Function Explode(caracter:char;frase:string):TStringList;

    (* Completa a la izquierda el caracter pasado por parametro hasta llegar a la
       cantidad_total de la palabra*)
    Procedure CompletarPalabraIzq(Cantidad_Total:Integer;CaracterACompletar:Char;
                                  var Palabra:String);

    (* Completa a la izquierda el caracter pasado por parametro hasta llegar a la
       cantidad_total de la palabra*)
    Procedure CompletarPalabraDer(Cantidad_Total:Integer;CaracterACompletar:Char;
                                  var Palabra:String);

    (* Sacamos los espacios en blanco esten donde esten *)
    Function QuitarEspacios(Palabra:string):String;

    //Devuelve en nombre de la impresora que esta por defecto
    function impresoraDefecto : string;

    //Devuelve una lista con los nombres de los impresoras disponibles
    function impresorasDisponibles : TStrings;

    //Guarda el texto en el path pasado
    procedure GuardarLog(path,texto: string);

    //Devuelve el BMP de la imagen JPG
    Function ConvertirJPGaBMP(JPG:TJPEGImage):TBitmap;

    //Elimina todo lo que este dentro de la carpeta pasada por parámetro
    Function DelTree(const Directory: TFileName):boolean;

    //Si devuelve '0' es por que esta cerrado
    function obtenerCantidadEjecuciones(Aplicacion: string): integer;

    //Se le agrega '\' si no la tiene a la dirección
    function normalizoDir(aDir:String):String;

    //Da la dirección de mis documentos 
    function DameDirMisDocumentos:String;

    //Convierte el string a PAnsiChar
    function strtoPAnsiChar(stringVar : string) : PAnsiChar;

    //Tamaño de un archivo. Se usa para Firma PDF
    function Get_File_Size(const FileName: string): TULargeInteger;

    //Te da la ip del path pasado por parámetro
    Function ExtractIPPath(path:string):String;

    //Extrae el recurso
    function ExtractShared(Path: string): string;

    //Abre un Dialog para los pdf
    Function AbrirBusquedaPDF(PathInicio:String):String;

    //Devuelve el nombre del archivo pasado en el path
    Function DameNombreArchivo(path:String):string;

    //Se valida que este insertada una tarjeta y a su vez que la tarjeta pertenezca al usuario pasado
    Function ValidarTarjeta(Usuario:PChar):boolean;

    //Arma el path con el Expediente. El nombre del archivo solo se concatena
    Function ArmarPath(NroExpediente,NombreArchivo:string):string;

    function DameDirCarpetaUsuario:String;
    function DameUsuarioLogueadoenPC: string;

    Function DameTamanoArchivo(archivo:string):String;
implementation


        //*************************** VALIDACIONES ***************************//

// Valida que la fecha se una fecha apropiada -- Adrián
Function ValidarFecha(fecha:string): String;
var dia,mes,anio,str:String;
    ok:Boolean;
begin
     str  := '';

     if not (fecha = '  /  /    ') then
     begin
       ok   := True;
       dia  :=  LeftStr(fecha,2);
       mes  :=  AnsiMidStr(fecha,4,2);
       anio :=  AnsiMidStr(fecha,7,4);

       if (dia = '  ') or (mes = '  ') or (anio ='   ') then
          str := '- Error en la fecha'
       else
       begin
           if ((StrToInt(dia)>31) or (StrToInt(dia)=0) or ( dia = '00')) and ok then
           begin
               str := 'Error en el dia';
               ok := False;
           end;

           if ((StrToInt(mes)>12) or (StrToInt(mes)=0) or ( mes = '00')) and ok then
           begin
               str := 'Error en el mes';
               ok := False;
           end;

           // '1880' es la edad mínima que se toma
           if ((StrToInt(anio) < 1850) or (StrToInt(anio)=0) or
              ( anio = '0000') or (StrToInt(anio) > YearOf(Now))) and ok then
           begin
               str := 'Error en el Año';
               ok := False;
           end;

           if ((StrToInt(mes)= 2) and (StrToInt(dia)>29)) and ok then
               str := 'El mes de Febrero no tiene más de 29 dias';
       end;
     end;
     
     Result := str;
end;

// Valida que la fecha se una hora apropiada -- Adrián
Function ValidarHora(Hora:string): String;
var h,min,seg:integer;
begin
   //Inicializamos en blanco
   Result := '';

   if not(hora = '  :  :  ') then
   begin
     //Sacamos los ':' y obtenemos hora,min y seg
     Hora := StringReplace(Hora,':','',[rfReplaceAll, rfIgnoreCase]);
     h   :=  StrToInt(LeftStr(Hora,2));
     min :=  StrToInt(AnsiMidStr(Hora,3,4));
     seg :=  StrToInt(AnsiMidStr(Hora,5,6));

     if not ((h <= 24) and (h >= 0)) then
      Result := 'Error en la hora';

     if (Result = '') and not ((min >= 0) and (min<= 59)) then
      Result := 'Error en los minutos';

     if (Result = '') and not ((seg >= 0) and (seg<= 59)) then
      Result := 'Error en los segundos';
   end;

end;

//*****************************************************************************//

// TIPEO DE LETRAS
//Admite solo letras
Function ValidarSoloLetras(Key:Char):Boolean;
Var Ok:Boolean;
Begin
  ok := True;

  if not (Key in ['a'..'z','A'..'Z','ñ','Ñ',#8,#13,#32]) then
    Ok := False;

  Result := Ok;
End;

//No admite ' '
Function ValidarSoloLetrasUsuario(Key:Char):Boolean;
Var Ok:Boolean;
Begin
  ok := True;

  if not (Key in ['a'..'z','A'..'Z','ñ',#8,#13]) then
    Ok := False;

  Result := Ok;
End;
//Admite ' - '
Function ValidarLetrasGuion(Key:Char):Boolean;
Var Ok:Boolean;
Begin
  ok := True;
  if not (Key in ['a'..'z','A'..'Z','ñ','Ñ',#8,#13,#32,'-']) then
    Ok := False;

  Result := Ok;
End;

//Admite ' / '
Function ValidarLetrasBarra(Key:Char):Boolean;
Var Ok:Boolean;
Begin
  ok := True;
  if not (Key in ['a'..'z','A'..'Z','ñ','Ñ',#8,#13,#32,'/']) then
    Ok := False;

  Result := Ok;
End;

//Admite ' / ' y ' - '
Function ValidarLetrasFull(Key:Char):Boolean;
Var Ok:Boolean;
Begin
  ok := True;
  if not (Key in ['a'..'z','A'..'Z','ñ','Ñ',#8,#13,#32,'/','-']) then
    Ok := False;

  Result := Ok;
End;

//*****************************************************************************//

// TIPEO DE NUMEROS
//Admiete solo numeros
Function ValidarSoloNumeros(Key:Char):Boolean;
Var Ok:Boolean;
Begin
  ok := True;

  if not (Key in ['0'..'9',#8,#13]) then
    Ok := False;

  Result := Ok;
End;

//Admite ' - '
Function ValidarNumerosGuion(Key:Char):Boolean;
Var Ok:Boolean;
Begin
  ok := True;

  if not (Key in ['0'..'9','-',#8,#13,#32]) then
    Ok := False;

  Result := Ok;
End;

//Admite ' / '
Function ValidarNumerosBarra(Key:Char):Boolean;
Var Ok:Boolean;
Begin
  ok := True;

  if not (Key in ['0'..'9','/',#8,#13,#32]) then
    Ok := False;

  Result := Ok;
End;

//Admite ' / ' y ' - '
Function ValidarNumerosFull(Key:Char):Boolean;
Var Ok:Boolean;
Begin
  ok := True;

  if not (Key in ['0'..'9','/','-',#8,#13,#32]) then
    Ok := False;

  Result := Ok;
End;
//*****************************************************************************//

// TIPEO DE ALFANUMERICO
//Admite letras y numeros
Function ValidarLetrasNumeros(Key:Char):Boolean;
Var Ok:Boolean;
Begin
  ok := True;

  if not (Key in ['a'..'z','A'..'Z','ñ','Ñ','0'..'9',#8,#13,#32]) then
    Ok := False;

  Result := Ok;
End;

//Admite ' - '
Function ValidarLetrasNumerosGuion(Key:Char):Boolean;
Var Ok:Boolean;
Begin
  ok := True;
  if not (Key in ['a'..'z','A'..'Z','ñ','Ñ','0'..'9',#8,#13,#32,'-']) then
    Ok := False;

  Result := Ok;
End;

//Admite ' / '
Function ValidarLetrasNumerosBarra(Key:Char):Boolean;
Var Ok:Boolean;
Begin
  ok := True;
  if not (Key in ['a'..'z','A'..'Z','ñ','Ñ','0'..'9',#8,#13,#32,'/']) then
    Ok := False;

  Result := Ok;
End;

//Admite ' / ' y ' - '
Function ValidarLetrasNumerosFull(Key:Char):Boolean;
Var Ok:Boolean;
Begin
  ok := True;
  if not (Key in ['a'..'z','A'..'Z','ñ','Ñ','0'..'9',#8,#13,#32,'/','-']) then
    Ok := False;

  Result := Ok;
End;

// Como el Memo no tiene la opcion UpperCase la Simulamos.. Adrián
Function PasarMayusMemo(Key:Char):Char;
Var C:Char;
Begin

   Case key of
    'a'..'z': C := upCase(key);
    'ñ': C := 'Ñ';
    'á': C := 'A';
    'é': C := 'E';
    'í': C := 'I';
    'ó': C := 'O';
    'ú': C := 'U';
    else
      C := Key;
   end;

   Result := C;
end;

//*************************** FUNCIONES ***************************//

Function CalcularAnios(Fecha_Nac:String):String;
var Desde,Hasta,Edad:String;
Begin
    // Calculamos la edad -- Adrián
    Desde := AnsiLeftStr(Fecha_Nac,10);
    Hasta := AnsiLeftStr(DateToStr(Now),10);

    Edad := inttostr(trunc(strtodate(Hasta)-strtodate(Desde))) ;

    Result := Edad;
End;

// Devulve la primer palabra que encuentra antes de un espacio -- Adrián
Function DamePrimerPalabra(Frase:String):String;
Begin
    Result := AnsiLeftStr(Frase,(AnsiPos(' ',Frase)));
End;


// Devuelve la ip de la máquina
Function ObtenerIPMaquina : string;
type
  TaPInAddr = array [0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe : PHostEnt;
  pptr : PaPInAddr;
  Buffer : array [0..63] of char;
  I : Integer;
  GInitData : TWSADATA;
Begin

  WSAStartup($101, GInitData);
  Result := '';
  GetHostName(Buffer, SizeOf(Buffer));
  phe := GetHostByName(buffer);

  if phe = nil then Exit;
    pptr := PaPInAddr(Phe^.h_addr_list);

  I := 0;

  while pptr^[I] <> nil do
  begin
    result:=StrPas(inet_ntoa(pptr^[I]^));
    Inc(I);
  end;

  WSACleanup;
End;

(* En nombre pasas el todo el nombre completo y te divide en "Nombre1"(str1)
   y "Nombre2"(str2) *)
Procedure CorregirNombresApellidos(nombre: string; var str1, str2: String);
//*******************************************************//
function PalabrasComunes(str:string):integer;
var i:integer;
const
  { Palabras comunes al principio del apellido }
  Principio : array[0..15] of string =

  ('DE',
   'LAS',
   'LOS',
   'DA',
   'LA',
   'DEL',
   'VAN',
   'VON',
   'DER',
   'MC',
   'MAC',
   'JR',
   'DI',
   'AL',
   'DOS',
   'DO');

  { Palabras comunes al final del apellido }
  Fin : array[0..16] of string =

  ('JR',
   'JUNIOR',
   'I',
   'II',
   'III',
   'IV',
   'V',
   'VI',
   'VII',
   'VIII',
   'IX',
   'X',
   'XI',
   'XII',
   'XIII',
   'XIV',
   'XV');
begin
  { Itero verificando si el string coincide con alguna palabra en ambos casos }
  if Length(str) = 1 then
    Result:=0
  else
  begin

    for i := low(Principio) to high(Principio) do
    begin
      if Principio[i] = str then
      begin
        result:=0;
        exit;
      end;
    end;

    for i := low(Fin) to high(Fin) do
    begin

      if Fin[i] = str then
      begin
        result:=1;
        exit;
      end;

    end;

    result:=-1;
  end;
end;
//*******************************************************//
var
  nombres : TStringList;
  ok:boolean;
  i:integer;
begin

  ok:=true;
  nombres := SepararPalabras(nombre);

  for i:=0 to nombres.Count-1 do begin
    if ok then
    begin

      if i=0 then
        str1 := nombres.Strings[i]
      else
        str1 := trim(str1 + ' ' + nombres.Strings[i]);

      ok := (PalabrasComunes(nombres.Strings[i]) = 0) ;

    end
    else
    begin

      ok := false;

      if (PalabrasComunes(nombres.Strings[i]) = 1)then

        if(i = 0) then
          str1 := nombres.Strings[i]
        else
          str1:=trim(str1 + ' ' + nombres.Strings[i])

      else

        if(i = 0) then
          str1:=nombres.Strings[i]
        else
          str2:=trim(str2 + ' ' + nombres.Strings[i])
          
   end;
  end;
  
  FreeAndNil(Nombres);
end;

//Devuelve una lista de strings (Saca los espacios y devuleve la palabras) -- Adrián
Function SepararPalabras(str:string):TStringList;
var
  i:integer;
  aux:string;
  lista:TStringList;
begin
  lista := TStringList.create;

  for i := 1 to (length(str)) do
  begin

    if (i = length(str)) and (aux = '')then
    begin
      aux := copy(str,i,1);
      lista.add(aux)
    end
    else
      if ((str[i]=' ')or ( i = length(str))) and (aux<>'') then
      begin
        if (i = length(str)) then
          aux := aux + copy(str,i,1);
        lista.add(aux);
        aux := '';
      end
      else
        if (str[i] <> ' ') then
          aux := aux + copy(str,i,1);

  end;

  result:=lista;
end;

//Se usa en 'CorregirNombresApellidos'


//Devuelve la primer letra Mayúscula
Function DameMesEnLetras(mes:integer):String;
var m:String;
begin

   case mes of
    1 : m := 'ENERO';
    2 : m := 'FEBRERO';
    3 : m := 'MARZO';
    4 : m := 'ABRIL';
    5 : m := 'MAYO';
    6 : m := 'JUNIO';
    7 : m := 'JULIO';
    8 : m := 'AGOSTO';
    9 : m := 'SEPTIEMBRE';
    10 : m := 'OCTUBRE';
    11 : m := 'NOVIEMBRE';
    12 : m := 'DICIEMBRE';
   else
     m := 'MES NO VALIDO';
   end;

   Result := m;
   
end;

//Devuelve la primer letra Mayúscula
Function PrimeraMayuscula(palabra:string):String;
begin
   Result := UpperCase(palabra[1]) + LowerCase(AnsiMidStr(palabra,2,Length(palabra)-1));
end;

//Devuelve la fecha pasada en text. Puede tener hora (no la tiene en cuenta)
Function DameFechaEnLetras(fecha:String):String;
var aux:string;
begin

  aux := ValidarFecha(fecha);
  if Length(aux) = 0 then
  begin
    //Sacamos la hora si es que tiene
    fecha := DamePrimerPalabra(fecha);
    //Si tiene barra o guion se lo sacamos
    fecha := LeftStr(fecha,12);
    aux := StringReplace(fecha,'/','',[rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux,'-','',[rfReplaceAll, rfIgnoreCase]);

    Result := LeftStr(Aux,2) + ' de ' + PrimeraMayuscula(DameMesEnLetras(StrToInt(AnsiMidStr(aux,3,2)))) +
              ' de ' + RightStr(aux,4);
  end
  else
    Result := aux;

end;

Procedure BorrarItem(var v:array of integer;var cantidad_registros:integer;item:integer;Pos:integer);overload;
var i:integer;
begin
   i := 0;

   if (Pos = -1) then
     //Buscamos hasta encontrar el item que estamos buscando
     while (Pos = -1) and (i <= cantidad_registros) do
     begin
      if (v[i] = item) then
       pos := i;

      Inc(i);
     end;

   //Si encontro la posicion del item
   if not (pos = -1) then
   begin
     //Todos meno el último
     if (pos < cantidad_registros) then
     begin
       for i := pos to cantidad_registros do
         v[i] := v[i + 1];
     end
     else
       //Ultimo registro
       v[pos] := -1;

     Dec(cantidad_registros);
   end;
   
end;

Procedure BorrarItem(var v:array of string;var cantidad_registros:integer;item:string;Pos:integer);overload;
var i:integer;
begin
   i := 0;

   if (pos = -1) then
     //Buscamos hasta encontrar el item que estamos buscando
     while (pos = -1) and (i <= cantidad_registros) do
     begin
       if (v[i] = item) then
       pos := i;

       Inc(i);
     end;

   //Si encontro la posicion del item
   if not (pos = -1) then
   begin
     //Todos menos el último
     if (pos < cantidad_registros) then
     begin
       for i := pos to cantidad_registros do
         v[i] := v[i + 1];
     end
     else
       //Ultimo registro
       v[pos] := '';

     Dec(cantidad_registros);
   end;
end;

Function DamePosItemEnVector(v:array of integer;item:integer):Integer;overload;
var i:integer;
begin
    Result := -1;
    i := 0;

    while (Result = -1) and (i<= length(v)) do
    begin
      if v[i] = item then
        Result := i;

      Inc(i);
    end;

end;

Function DamePosItemEnVector(v:array of string;item:string):Integer;overload;
var i:integer;
begin
    Result := -1;
    i := 0;

    while (Result = -1) and (i<= length(v)) do
    begin
      if v[i] = item then
        Result := i;

      Inc(i);
    end;

end;

Procedure ReemplazarCaracter(var Frase:String;Caracter_A_Borrar:char;Caracter_Final:Char);
var i:integer;
begin
    if (Length(Frase) <= 0) then Exit;

    for i := 0 to length(Frase) do
      if (Frase[i] = Caracter_A_Borrar) then
        Frase[i] := Caracter_Final;    
end;

Procedure InsertarItem(var v:array of string;CantidadDatos:integer;Pos:Integer;Item:String);overload;
var i:integer;
begin

   //OJO que el ultimo elemento se pierde en caso de tener datos
   if (CantidadDatos >= Length(v)) then
     for i := CantidadDatos downto Pos do
        v[i] := v[i-1]
   else
     for i := CantidadDatos + 1 downto Pos do
        v[i] := v[i-1];

   V[Pos] := item;

end;

Procedure InsertarItem(var v:array of Integer;CantidadDatos:integer;Pos:Integer;Item:Integer);overload;
var i:integer;
begin

   //OJO que el ultimo elemento se pierde en caso de tener datos
    if (CantidadDatos >= Length(v)) then
      for i := CantidadDatos downto Pos do
        v[i] := v[i-1]
    else
      for i := CantidadDatos + 1 downto Pos do
        v[i] := v[i-1];

    V[Pos] := item;

end;

Procedure CambiarPosItem(var v:array of string;CantidadDatos:integer;Vieja_Pos,Nueva_Pos:Integer);overload;
var i:integer;
    aux:string;
begin
   if (Vieja_Pos > CantidadDatos) then
    Abort;

   //Guardamos el registro de la vieja posicion
   aux := v[Vieja_Pos];

   //OJO que el ultimo elemento se pierde en caso de tener datos 
   for i := Vieja_Pos downto Nueva_Pos do
      v[i] := v[i-1];

   V[Nueva_Pos] := aux;    

end;

Procedure CambiarPosItem(var v:array of integer;CantidadDatos:integer;Vieja_Pos,Nueva_Pos:Integer);overload;
var i:integer;
    aux:integer;
begin

   if (Vieja_Pos > CantidadDatos) then
    Abort;

   //Guardamos el registro de la vieja posicion
   aux := v[Vieja_Pos];

   //OJO que el ultimo elemento se pierde en caso de tener datos
   for i := Vieja_Pos downto Nueva_Pos do
      v[i] := v[i-1];

   V[Nueva_Pos] := aux;

end;

Procedure OrdenarVectorAsc(var v:array of string;CantidadDatos:integer);overload;
var
    x, y: integer;
    aux :string;
begin

    for x := 1 to CantidadDatos - 1 do
    begin
      if (v[x] = '') then
      begin
        for y := x to CantidadDatos - 1 do
          v[CantidadDatos] := '';

        Dec(CantidadDatos);
      end;
    end;

    for x := 1 to CantidadDatos do //Metodo de burbuja
    begin
      for y := 1 to CantidadDatos - 1 do
      begin
        if v[y] > v[y+1] then
        begin
            aux := v[y];
            v[y] := v[y+1];
            v[y+1] := aux;
        end;
      end;
    end;

end;

Procedure OrdenarVectorAsc(var v:array of integer;CantidadDatos:integer);overload;
var
    x, y,aux: integer;
begin

    for x := 1 to CantidadDatos - 1 do
    begin
      if (v[x] = 0) then
      begin
        for y := x to CantidadDatos - 1 do
          v[CantidadDatos] := 0;

        Dec(CantidadDatos);
      end;
    end;

    for x := 1 to CantidadDatos do //Metodo de burbuja
    begin
      for y := 1 to CantidadDatos - 1 do
      begin
        if v[y] > v[y+1] then
        begin
            aux := v[y];
            v[y] := v[y+1];
            v[y+1] := aux;
        end;
      end;
    end;

end;

Procedure OrdenarVectorDes(var v:array of string;CantidadDatos:integer);overload;
var
    x, y: integer;
    aux :string;
begin

    for x := 1 to CantidadDatos - 1 do
    begin
      if (v[x] = '') then
      begin
        for y := x to CantidadDatos - 1 do
          v[CantidadDatos] := '';

        Dec(CantidadDatos);
      end;
    end;

    for x := 1 to CantidadDatos do //Metodo de burbuja
    begin
      for y := 1 to CantidadDatos - 1 do
      begin
        if v[y] < v[y+1] then
        begin
            aux := v[y];
            v[y] := v[y+1];
            v[y+1] := aux;
        end;
      end;
    end;

end;

Procedure OrdenarVectorDes(var v:array of integer;CantidadDatos:integer);overload;
var
    x, y, aux: integer;
begin

    for x := 1 to CantidadDatos - 1 do
    begin
      if (v[x] = 0) then
      begin
        for y := x to CantidadDatos - 1 do
          v[CantidadDatos] := 0; 

        Dec(CantidadDatos);
      end;
    end;

    for x := 1 to CantidadDatos do //Metodo de burbuja
    begin
      for y := 1 to CantidadDatos - 1 do
      begin
        if v[y] < v[y+1] then
        begin
            aux := v[y];
            v[y] := v[y+1];
            v[y+1] := aux;
        end;
      end;
    end;

end;

Function Explode(caracter:char;frase:string):TStringList;
var lista:TStringList;
begin

  lista := TStringList.Create;
  lista.Delimiter := caracter; // Es la separación de cada elemento
  lista.DelimitedText := frase; // El texto

  result := lista;
end;

(* Completa a la izquierda el caracter pasado por parametro hasta llegar a la
     cantidad_total de la palabra*)
Procedure CompletarPalabraIzq(Cantidad_Total:Integer;CaracterACompletar:Char;
                              var Palabra:String);
var str:String;
    v:array of char;
    i,j,cantidad:integer;
begin
   try

     (* Nos fijamos si la cantidad total es menor al largo de la palabra + 1
        salimos del proceso por que no hay que completar nada... *)
     if Cantidad_Total < (Length(Palabra) + 1) then
     begin
       str := Palabra;
       Exit;
     end;

     (* Le ponemos el largo total que va a tener el vector *)
     SetLength(v,Cantidad_Total);

     (* Cantidad de caracteres insertados *)
     cantidad := 0;

     (* Completamos los caracteres *)
     for i := 0 to (Cantidad_Total - (Length(Palabra)))-1 do
     begin
       v[i] := CaracterACompletar;
       Inc(cantidad);
     end;

     (* Agregamos la palabra *)
     For j := 1 to (Length(Palabra)) do
     begin
       v[cantidad] := Palabra[j];
       Inc(cantidad);
     end;

     (* Re-armamos el string *)
     for i := 0 to Cantidad_Total - 1 do
       str := str + v[i];

   finally
     Palabra := str;
   end;

end;

(* Completa a la derecha el caracter pasado por parametro hasta llegar a la
     cantidad_total de la palabra*)
Procedure CompletarPalabraDer(Cantidad_Total:Integer;CaracterACompletar:Char;
                              var Palabra:String);
var str:String;
    v:array of char;
    i,j,cantidad:integer;
begin
   try

     (* Nos fijamos si la cantidad total es menor al largo de la palabra + 1
        salimos del proceso por que no hay que completar nada... *)
     if Cantidad_Total < (Length(Palabra) + 1) then
     begin
       str := Palabra;
       Exit;
     end;

     (* Le ponemos el largo total que va a tener el vector *)
     SetLength(v,Cantidad_Total);

     (* Cantidad de caracteres insertados *)
     cantidad := 0;

     (* Agregamos la palabra *)
     For j := 1 to (Length(Palabra)) do
     begin
       v[cantidad] := Palabra[j];
       Inc(cantidad);
     end;

     (* Completamos los caracteres *)
     for i := 0 to (Cantidad_Total - (Length(Palabra)))-1 do
     begin
       v[cantidad] := CaracterACompletar;
       Inc(cantidad);
     end;

     (* Re-armamos el string *)
     for i := 0 to Cantidad_Total - 1 do
       str := str + v[i];
       
   finally
     Palabra := str;
   end;

end;

(* Sacamos los espacios en blanco esten donde esten *)
Function QuitarEspacios(Palabra:string):String;
begin
   Result := StringReplace(Palabra,' ','',[rfReplaceAll, rfIgnoreCase]);
end;

//Devuelve en nombre de la impresora que esta por defecto
function impresoraDefecto : string;
begin
  if (Printer.PrinterIndex > 0) then
    result := Printer.Printers [Printer.PrinterIndex]
  else
    Result := 'No hay impresora por defecto';
end;

//Devuelve una lista con los nombres de los impresoras disponibles
function impresorasDisponibles : TStrings;
begin
    Result := Printer.Printers;;
end;

procedure GuardarLog(path,texto: string);
var F:textfile;
begin
   AssignFile(F,path);

   if FileExists(path) then
     Append(F)
   else
     Rewrite(F);
     
   Writeln(F,texto);
   CloseFile(F);
end;

Function ConvertirJPGaBMP(JPG:TJPEGImage):TBitmap;
var bmp:TBitmap;
begin
    bmp := TBitmap.Create;
    bmp.Assign(JPG);
    Result := bmp;
end;

function DelTree(const Directory: TFileName):boolean;
var
  DrivesPathsBuff: array[0..1024] of char;
  DrivesPaths: string;
  len: longword;
  ShortPath: array[0..MAX_PATH] of char;
  dir: TFileName;
//**************************************************//
procedure rDelTree(const Directory: TFileName);
// Recursively deletes all files and directories
// inside the directory passed as parameter.
var
  SearchRec: TSearchRec;
  Attributes: LongWord;
  ShortName, FullName: TFileName;
  pname: pchar;
begin
  if FindFirst(Directory + '*', faAnyFile and not faVolumeID,
     SearchRec) = 0 then begin
    try
      repeat // Processes all files and directories
        if SearchRec.FindData.cAlternateFileName[0] = #0 then
          ShortName := SearchRec.Name
        else
          ShortName := SearchRec.FindData.cAlternateFileName;
        FullName := Directory + ShortName;
        if (SearchRec.Attr and faDirectory) <> 0 then begin
          // It's a directory
          if (ShortName <> '.') and (ShortName <> '..') then
            rDelTree(FullName + '\');
        end else begin
          // It's a file
          pname := PChar(FullName);
          Attributes := GetFileAttributes(pname);
          if Attributes = $FFFFFFFF then
            raise EInOutError.Create(SysErrorMessage(GetLastError));
          if (Attributes and FILE_ATTRIBUTE_READONLY) <> 0 then
            SetFileAttributes(pname, Attributes and not
              FILE_ATTRIBUTE_READONLY);
          if Windows.DeleteFile(pname) = False then
            raise EInOutError.Create(SysErrorMessage(GetLastError));
        end;
      until FindNext(SearchRec) <> 0;
    except
      FindClose(SearchRec);
      raise;
    end;
    FindClose(SearchRec);
  end;

  if Pos(#0 + Directory + #0, DrivesPaths) = 0 then begin
    // if not a root directory, remove it
    pname := PChar(Directory);
    Attributes := GetFileAttributes(pname);
    if Attributes = $FFFFFFFF then
      raise EInOutError.Create(SysErrorMessage(GetLastError));
    if (Attributes and FILE_ATTRIBUTE_READONLY) <> 0 then
      SetFileAttributes(pname, Attributes and not
        FILE_ATTRIBUTE_READONLY);
    if Windows.RemoveDirectory(pname) = False then begin
      raise EInOutError.Create(SysErrorMessage(GetLastError));
    end;
  end;
end;
//**************************************************//
begin
  try
    if not DirectoryExists(Directory) then
     raise Exception.Create('Directorio no existe');

    DrivesPathsBuff[0] := #0;
    len := GetLogicalDriveStrings(1022, @DrivesPathsBuff[1]);
    if len = 0 then
      raise EInOutError.Create(SysErrorMessage(GetLastError));
    SetString(DrivesPaths, DrivesPathsBuff, len + 1);
    DrivesPaths := Uppercase(DrivesPaths);
    len := GetShortPathName(PChar(Directory), ShortPath, MAX_PATH);
    if len = 0 then
      raise EInOutError.Create(SysErrorMessage(GetLastError));
    SetString(dir, ShortPath, len);
    dir := Uppercase(dir);
    rDelTree(IncludeTrailingBackslash(dir));
    Result := True;
  except
    Result := False;
  end;
end;

function obtenerCantidadEjecuciones(Aplicacion: string): integer;
var
  aSnapshotHandle: THandle;
  aProcessEntry32: TProcessEntry32;
  Ejecuciones: Integer;
  bContinue: BOOL;
  proceso: string;
begin
  ejecuciones := 0;
  aSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  aProcessEntry32.dwSize := SizeOf(aProcessEntry32);
  bContinue := Process32First(aSnapshotHandle, aProcessEntry32);
  while Integer(bContinue) <> 0 do
  begin
    proceso := upperCase(ExtractFileName(aProcessEntry32.szExeFile));
    if Pos(proceso, UpperCase(Aplicacion)) > 0 then
      ejecuciones := ejecuciones + 1;
    bContinue := Process32Next(aSnapshotHandle, aProcessEntry32);
  end;
  CloseHandle(aSnapshotHandle);
  result := ejecuciones;
end;

function normalizoDir(aDir:String):String;
begin
  Result := aDir;

  if aDir[Length(aDir)]<>'\' then
    Result := aDir + '\';
end;

function DameDirMisDocumentos:String;
const
  SHGFP_TYPE_CURRENT = 0;
var
  Buffer: array[0..MAX_PATH] of Char;
begin
  SHGetFolderPath(0,CSIDL_PERSONAL, 0, SHGFP_TYPE_CURRENT, Buffer);
  //CSIDL_PERSONAL = es la variable que indica que carpeta queremos obtener
  Result := Buffer;
end;

function strtoPAnsiChar(stringVar : string) : PAnsiChar;
Var
  AnsString : AnsiString;
  InternalError : Boolean;
begin
  InternalError := false;
  Result := '';
  try
    if stringVar <> '' Then
    begin
       AnsString := AnsiString(StringVar);
       Result := PAnsiChar(PAnsiString(AnsString));
    end;
  Except
    InternalError := true;
  end;
  if InternalError or (String(Result) <> stringVar) then
  begin
    Raise Exception.Create('Conversion from string to PAnsiChar failed!');
  end;
end;

function Get_File_Size(const FileName: string): TULargeInteger;
var
  Find: THandle;
  Data: TWin32FindData;
begin
  Result.QuadPart := -1;
  Find := FindFirstFile(PChar(FileName), Data);
  if (Find <> INVALID_HANDLE_VALUE) then
  begin
    Result.LowPart  := Data.nFileSizeLow;
    Result.HighPart := Data.nFileSizeHigh;
    Windows.FindClose(Find);
  end;
end;

//Te da la ip del path pasado por parámetro
Function ExtractIPPath(path:string):String;
var
  b, p: Integer;
begin
  Result := '';

  if Copy(path, 1, 2) = '\\' then
    b := 3
  else
    b := 1;

  p := PosEx('\', path, b);
  
  if p = 0 then
    p := Length(path) + 1;

  Result := Copy(path, b, p - b);
end;

//Extrae el recurso
function ExtractShared(Path: string): string;
var
  b, p:Integer;
begin

  Result := '';

  if Copy(Path, 1, 2) = '\\' then
    b := 3
  else
    b := 1;

  p := PosEx('\', Path, b);

  {if p > 0 then
  begin
    p := p + 1;
    q := PosEx('\', Path, p);

    if q = 0 then
      q := Length(Path) + 1;

    Result := Copy(Path, p, q - p);
  end;}

  if p > 0 then
  begin
    Inc(p);
    Result := AnsiMidStr(Path,p,(Length(Path)-p)+1);
  end;

end;

Function AbrirBusquedaPDF(PathInicio:String):String;
var Dir:TOpenDialog;
begin
    Result := '';

    dir := TOpenDialog.Create(nil);

    if DirectoryExists(PathInicio)then
      dir.InitialDir := PathInicio
    else
      dir.InitialDir := 'C:\';

    dir.Filter:= 'PDF Files|*.pdf';

    if dir.Execute then
      Result := dir.FileName;

    dir.Free;
end;

//Devuelve el nombre del archivo pasado en el path
Function DameNombreArchivo(path:String):string;
begin
    Result := ExtractFileName(path);
end;

Function ValidarTarjeta(Usuario:PChar):boolean;
var ok,esusuario:boolean;
begin
    //Se carga la dll para el uso de la tarjeta
    cargarDllFirma;
    
    ok := True;
    esusuario := False;

    while ok and not(esusuario) do
    begin
      //Validación si la tarjeta esta insertada en la máquina
      if not(estaTarjeta) then
        while not(estaTarjeta) and ok do
          if (MessageDlg('Inserte la tarjeta para continuar.', mtError,
             [mbOK, mbCancel], 0) = mrCancel) then
            ok := False;

      if ok then
      begin
        if not ExisteUsuario(Usuario) then
          MessageDlg('La tarjeta no pertenece al usuario logueado o ' + #13 +
                     'el certificado esta vencido',mtError,[mbOK],0)
        else
          esusuario := True;
      end
      else
        esusuario := True;

    end;

    Result := ok and esusuario;
end;

//Arma el path con el Expediente. El nombre del archivo solo se concatena
Function ArmarPath(NroExpediente,NombreArchivo:string):string;
var n:string;
    x:integer;
begin
    Result := '';

    (* Generamos path de donde guardar o buscar el archivo
       Son los primeros 4 dígitos divido 1000 completado con '0' al principio *)

     n := AnsiMidStr(NroExpediente,0,length(NroExpediente)-4);
     x :=  (StrToInt(n) div 1000);
     n := FormatFloat('0000', x);

     Result := AnsiRightStr(NroExpediente,4) + '\' + n + '\' + NroExpediente +
               '\' + NombreArchivo;

end;

function DameDirCarpetaUsuario:String;
const
  SHGFP_TYPE_CURRENT = 0;
var
  Buffer: array[0..MAX_PATH] of Char;
  str:string;
begin
  SHGetFolderPath(0,CSIDL_PERSONAL, 0, SHGFP_TYPE_CURRENT, Buffer);
  //CSIDL_PERSONAL = es la variable que indica que carpeta queremos obtener
  str := buffer;
  str := AnsiMidStr(str,0,(Length(str)-10));
  Result := str;
end;

function DameUsuarioLogueadoenPC: string;
var
  buffer: array[0..255] of char;
  size: dword;
begin
  size := 256;
  if GetUserName(buffer, size) then
    Result := buffer
  else
    Result := ''
end;

Function DameTamanoArchivo(archivo:string):String;
  function cuantosbytes(archivo: string): string;
  var
    FHandle: integer;
  begin
    FHandle := FileOpen(archivo, 0);
    try
      Result := floattostr(getfilesize(FHandle,nil));
    finally
      FileClose(FHandle);
    end;
  end;
begin
  Result := cuantosbytes(archivo);
end;


end.


