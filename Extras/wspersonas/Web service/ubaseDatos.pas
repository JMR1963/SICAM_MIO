unit ubaseDatos;

interface

uses
    WinApi.Windows, System.Classes, Data.DB, memDS, Vcl.dialogs, webusersicamIntf,
    OraCall, DBAccess, Ora, Datasnap.Provider, OraProvider;


  type
    TbaseDatos =  class
  private
    FOraSession: TOraSession;
    Fparametros : tstrings;
    function getConnected: boolean;
    function getServer: string;
    function getUsername : string;

    procedure setConnected(bStatus: boolean);
    procedure setServer(strServer: string);
    procedure setUsername(name: string);
    procedure setPassword(pass: string);
    function getTstrings: Tstrings;
    procedure setTstrings(const Value: Tstrings);
    function getParametros: tstrings;
    procedure setParametros(const Value: tstrings);
  public
    ForaQuery: TOraQuery;
    property connected: boolean read getConnected write setConnected;
    property server   : string  read getServer    write setServer;
    property username : string  read getUsername  write setUsername;
    property password : string  write setPassword;
    property sql : Tstrings read getTstrings write setTstrings;
    property parametros : tstrings read getParametros write setParametros;
    function executeSql: string;
    function executeSql2: string;
    function executeNewSql(max : integer): arrayResultadoConsulta;
    procedure asignarParametros2;
    procedure FixNames(name:string;var str1,str2:String);
    function ParseName(str:string):TStringList;
    function IsFucked(str:string):integer;
    constructor create(); reintroduce;
    destructor destroy(); reintroduce;

    procedure asignarParametros();
  end;

implementation

uses SysUtils;
{ TbaseDatos }

procedure TbaseDatos.asignarParametros();
var
  i:integer;
begin
  for i:=0 to Fparametros.Count-1 do
    ForaQuery.Params[i].asString := Fparametros.Strings[i];
end;

constructor TbaseDatos.create;
begin
  FOraSession := TOraSession.Create(nil);
  ForaQuery := TOraQuery.Create(nil);
  ForaQuery.Session := FOraSession;
  Fparametros := TStringList.Create;
end;

destructor TbaseDatos.destroy;
begin
  FreeAndNil(FOraSession);
  FreeAndNil(Foraquery);
  FreeAndNil(fparametros);
end;

function TbaseDatos.executeSql: string;
begin
  try
    FOraSession.StartTransaction;
    ForaQuery.Close;
    asignarParametros;
    ForaQuery.open;
    FOraSession.Commit;
    if not ForaQuery.IsEmpty then
    begin
      result := result + ForaQuery.fieldByName('APELLIDO1').asstring  + ',';
      result := result + ForaQuery.fieldByName('APELLIDO2').asstring  + ',';
      result := result + ForaQuery.fieldByName('NOMBRE1').asstring    + ',';
      result := result + ForaQuery.fieldByName('NOMBRE2').asstring    + ',';
      result := result + ForaQuery.fieldByName('SEXO').asstring       + ',';
      result := result + ForaQuery.fieldByName('DOCVENCIMIENTO').asstring + ',';
      result := result + ForaQuery.fieldByName('DOCNUMERO').asstring      + ',';
      result := result + ForaQuery.fieldByName('DOCTIPO').asstring        + ',';
      result := result + ForaQuery.fieldByName('DOCSUBTIPO').asstring     + ',';
      result := result + ForaQuery.fieldByName('PAISEMISOR').asstring     + ',';
      result := result + ForaQuery.fieldByName('FECNAC').asstring         + ',';
      result := result + ForaQuery.fieldByName('NACIONALIDAD').asstring   + ',';

    end;
    except
      result := ',,,,,,,,,,,,';
    end;
end;

function TbaseDatos.executeSql2: string;
//La misma consulta pero sobre una vista
var
  nombre1, apellido1: string;
  nombre2, apellido2: string;
begin
  try
    FOraSession.StartTransaction;
    ForaQuery.Close;
    asignarParametros2;
    ForaQuery.open;
    if not ForaQuery.IsEmpty then
    begin
      nombre1   := ForaQuery.fieldByName('NOMBRE1').asstring;
      nombre2   := ForaQuery.fieldByName('NOMBRE2').asstring;
      apellido1 := ForaQuery.fieldByName('APELLIDO1').asstring;
      apellido2 := ForaQuery.fieldByName('APELLIDO2').asstring;

      if (nombre2 = '') and (apellido2 = '') then
      begin
        FixNames(nombre1, nombre1, nombre2);
        fixnames(apellido1, apellido1, apellido2);
      end;



      result := result + apellido1  + ',';
      result := result + apellido2  + ',';
      result := result + nombre1    + ',';
      result := result + nombre2    + ',';



      result := result + ForaQuery.fieldByName('SEXO').asstring           + ',';
      result := result + ForaQuery.fieldByName('DOCVENCIMIENTO').asstring + ',';
      result := result + ForaQuery.fieldByName('DOCNUMERO').asstring      + ',';
      result := result + ForaQuery.fieldByName('DOCTIPO').asstring        + ',';
      result := result + Fparametros.Strings[2]                           + ',';
      result := result + ForaQuery.fieldByName('PAISEMISOR').asstring     + ',';
      result := result + ForaQuery.fieldByName('FECNAC').asstring         + ',';
      result := result + ForaQuery.fieldByName('NACIONALIDAD').asstring   + ',';
    end;
    except
      result := ',,,,,,,,,,,,';
    end;
end;

function TbaseDatos.executeNewSql(max : integer): arrayResultadoConsulta;
{
  FECHA_CRUCE,
  TIPO_DOC,
  EMISOR_DOC,
  NUM_DOC,
  APELLIDO1,
  APELLIDO2,
  NOMBRE1,
  NOMBRE2,
  SEXO,
  FECHA_NAC,
  NACIONALIDAD,
  PASO_CRUCE
}
var
  i: integer;
  r: arrayResultadoConsulta;
  count : integer;
begin
  try
    FOraSession.StartTransaction;
    ForaQuery.Close;
    ForaQuery.open;

    ForaQuery.Last;
    count := ForaQuery.FetchRows;

    SetLength(result, count);

    for i:=0 to count-1 do
    begin
      result[i] := tResultConsultaNew.Create;

      result[i].fecha_cruce := ForaQuery.fieldbyname('fecha_cruce').asstring;
      result[i].tipo_doc    := ForaQuery.fieldbyname('tipo_doc').asstring;;
     // result[i].emisor_doc  := ForaQuery.fieldbyname('emisor_doc').asstring;;
      result[i].num_doc     := ForaQuery.fieldbyname('nro_doc').asstring;;
      result[i].apellido1   := ForaQuery.fieldbyname('apellido1').asstring;;
      result[i].apellido2   := ForaQuery.fieldbyname('apellido2').asstring;;
      result[i].nombre1     := ForaQuery.fieldbyname('nombre1').asstring;;
      result[i].nombre2     := ForaQuery.fieldbyname('nombre2').asstring;;
      result[i].sexo        := ForaQuery.fieldbyname('sexo').asstring;;
      result[i].fecha_nac   := ForaQuery.fieldbyname('fecha_nac').asstring;;
      result[i].nacionalidad:= ForaQuery.fieldbyname('nacionalidad').asstring;;
      result[i].paso_cruce  := ForaQuery.fieldbyname('paso_cruce').asstring;
      ForaQuery.Next;
    end;

  except
  //  result := ',,,,,,,,,,,,';
  end;
end;

function TbaseDatos.getConnected: boolean;
begin
  result := ForaSession.connected;
end;

function TbaseDatos.getParametros: tstrings;
begin

end;

function TbaseDatos.getServer: string;
begin
  result := FOraSession.Server;
end;

function TbaseDatos.getTstrings: Tstrings;
begin
  result := ForaQuery.SQL;
end;

function TbaseDatos.getUsername: string;
begin
  result := FOraSession.Username;
end;

procedure TbaseDatos.setConnected(bStatus: boolean);
begin
  //fix
  //try
  FOraSession.Open;
  //ForaSession.connected := bStatus;
end;

procedure TbaseDatos.setParametros(const Value: tstrings);
var
  i : integer;
begin
  for i:=0 to value.Count-1 do
    Fparametros.Add(value.Strings[i]);
end;

procedure TbaseDatos.setPassword(pass: string);
begin
  FOraSession.Password := pass;
end;

procedure TbaseDatos.setServer(strServer: string);
begin
  FOraSession.Server := strServer;
end;

procedure TbaseDatos.setTstrings(const Value: Tstrings);
var
  i : integer;
begin
  for i:=0 to value.Count-1 do
    ForaQuery.SQL.Add(value.Strings[i]);
end;

procedure TbaseDatos.setUsername(name: string);
begin
  FOraSession.Username := name;
end;



procedure TbaseDatos.asignarParametros2;
var
  i:integer;
begin
  //for i:=0 to Fparametros.Count-1 do
    ForaQuery.Params[0].asString := Fparametros.Strings[0];
    ForaQuery.Params[1].asString := Fparametros.Strings[1];
    ForaQuery.Params[2].asString := Fparametros.Strings[3];
end;


function TbaseDatos.ParseName(str:string):TStringList;
//Toma un apellido compuesto y lo  transforma en una lista de apellidos
var
  i:integer;
  aux:string;
  list:TStringList;
begin
  list:=TStringList.create;
  for i :=1 to (length(str)) do
  begin
    if (i=length(str)) and (aux='')then
    begin
      aux:=copy(str,i,1);
      list.add(aux)
    end
    else
      if ((str[i]=' ')or (i=length(str)))and(aux<>'') then
      begin
        if (i=length(str)) then
          aux:=aux + copy(str,i,1);
        list.add(aux);
        aux:='';
      end
      else
        if (str[i]<>' ') then
          aux:=aux + copy(str,i,1);
  end;
  result:=list;
end;


function TbaseDatos.IsFucked(str:string):integer;
  var i:integer;
const
  { Palabras comunes al principio del apellido }
  FuckWords : array[0..15] of string =

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
  FuckAfterWords : array[0..16] of string =

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
    for i := low(FuckWords) to high(FuckWords) do
    begin
      if FuckWords[i] = str then
      begin
        result:=0;
        exit;
      end;
    end;
    for i := low(FuckAfterWords) to high(FuckAfterWords) do
    begin
      if FuckAfterWords[i] = str then
      begin
        result:=1;
        exit;
      end;
    end;
      result:=-1;
  end;
end;



procedure TbaseDatos.FixNames(name:string;var str1,str2:String);
var
  names : TStringList;
  lastFucked:boolean;
  i:integer;
begin
  lastFucked:=true;
  names := parseName(name);
  for i:=0 to names.Count-1 do begin
    if lastFucked then
    begin
      if i=0 then
        str1:=names.Strings[i]
      else
        str1:=trim(str1+' '+names.Strings[i]);
      lastFucked:=(isFucked( names.Strings[i]) =0) ;
    end
    else
    begin
      lastFucked:=false;
      if (isFucked( names.Strings[i]) =1)then
        if(i = 0) then
          str1:=names.Strings[i]
        else
          str1:=trim(str1+' '+names.Strings[i])
      else
        if(i = 0) then
          str1:=names.Strings[i]
        else
          str2:=trim(str2+' '+ names.Strings[i])
   end;
  end;
  FreeAndNil(Names);
end;


end.
