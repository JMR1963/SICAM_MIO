unit uGNAws;

interface

uses
  Ora, TRANSITOSGNAIntf;

type
  TOraQry = class
  private
    Conn : TOraSession;
    Qry : TOraQuery;
    TotalRecords : Longint;
    function GetWhere(c : TConsulta; var pol, pas, pint : String) : String;
    function GetWhereNew(c : TConsultaNew; var pol, pas, pint: String) : String;
    procedure SetSQL(c : TConsulta);
    procedure SetSQLNew(c : TConsultaNew);
    procedure SetSQL2(fecha: string; matricula : string); //; transitoDireccion : string
    function CheckRequestData(c : TConsulta) : Boolean;
    function CheckRequestDataNew(c : TConsultaNew) : Boolean;
    function CheckUser(c : TConsulta) : Boolean;
    function CheckString(s : String) : Boolean;
    function GetResponse : TRespuesta;
    function GetResponseStr : String;
    function GetResponseAmpliada : TRespuestaAmpliada;
    function ExecAux(c : TConsulta) : Boolean;
    function ExecAuxNew(c : TConsultaNew) : Boolean;
    function ExecAux2(fecha: string; matricula : string) : Boolean;  //transitoDireccion : string



    procedure Open;
    procedure Close;
  public
    constructor Create;
    constructor Create2;
    destructor Destroy; override;
    function Exec(c : TConsulta) : TRespuesta;

    function ExecStr(c : TConsulta) : String;
    function ExecQry(fecha: string; matricula : string) : TRespuesta; //; transitoDireccion : string
    function ExecNew(c : TConsultaNew) : TRespuesta;

    function ExecAmpliada(c : TConsulta) : TRespuestaAmpliada;
  end;

implementation

uses
  System.SysUtils, Xml.XMLDoc, Xml.XMLIntf, Data.DB;

// Agrega una condicion para AS INT y OL.
function TOraQry.GetWhere(c : TConsulta; var pol, pas, pint : String) : String;
var
  tempol : array [1..5] of String;
  tempint : array [1..3] of String;
  tempas : array [1..3] of String;
  s1, s2, t1, t2 : String;

  procedure InitArray(a : array of String);
  // Inicializa un array de strings de cualquier longitud con strings vac�os.
  var
    i : Integer;
  begin
    for i := Low(a) to High(a) do
      a[i] := '';
  end;

  function AssignAux(s1, s2 : String) : String;
  // Funci�n auxiliar.
  var
    value : String;
  begin
    Result := '';
    value := Trim(s2);
    if value <> '' then
      Result := Format('%s LIKE ''%s%%''', [s1, value]);
  end;

  function Implode(a : array of String; s : String) : String;
  // Agrega un string "s" entre cada par de elementos de "a".
  var
    i, l, h : Integer;
  begin
    Result := '';
    l := Low(a);
    h := High(a);
    if h - l > 0 then
      Result := a[0];
    for i := l + 1 to h do
      if a[i] <> '' then
        if Result = '' then
          Result := Result + a[i]
        else
          Result := Result + s + a[i]
  end;

begin
  Result := '';
  InitArray(tempol);
  InitArray(tempas);
  InitArray(tempint);

	if c.NUMDOC > 10 then
	begin
    tempol[1] := Format('RDOCNUMEROENTERO = %d', [c.NUMDOC]);
		tempas[1] := Format('RDOCNUMEROENTERO = %d', [c.NUMDOC]);
		tempint[1] := Format('RDOCNUMEROENTERO = %d', [c.NUMDOC]);
  end;

  tempol[2] := AssignAux('NOMBRE1', c.NOMBRE1);
  tempol[3] := AssignAux('NOMBRE2', c.NOMBRE2);
  tempol[4] := AssignAux('APELLIDO1', c.APELLIDO1);
  tempol[5] := AssignAux('APELLIDO2', c.APELLIDO2);

  s1 := Trim(c.APELLIDO1);
  s2 := Trim(c.APELLIDO2);
  t1 := '';
  t2 := '';
  if (s1 <> '') or (s2 <> '') then
  begin
    if s1 <> '' then
    begin
      t1 := s1 + '%';
      t2 := s1 + '%';
    end;
    if s2 <> '' then
    begin
      t1 := t1 + ' %' + s2 + '%';
      t2 := t2 + '%' + s2 + '%';
    end;
    tempint[2] := 'APELLIDOS LIKE ''' + t1 + '''';
     tempas[2]:= tempint[2];
  end;

  s1 := Trim(c.NOMBRE1);
  s2 := Trim(c.NOMBRE2);
	if (s1 <> '') or (s2 <> '') then
	begin
    t1 := '';
    if s1 <> '' then
    begin
      t1 := s1 + '%';
      t2 := t2 + '%' + s1 + '%';
    end;
    if s2 <> '' then
    begin
      t1 := t1 + ' %' + s2 + '%';
      t2 := t2 + '%' + s2 + '%';
    end;
    tempint[3] := 'NOMBRES LIKE ''' + t1 + '''';
    tempas[3]:= tempint[3];
  end;

 // if t2 <> '' then
	//	tempas[2] := 'APELLIDOS LIKE ''' + t2 + '''';

  pol := Implode(tempol, ' AND ');
  pas := Implode(tempas, ' AND ');
  pint := Implode(tempint, ' AND ');
end;




function TOraQry.GetWhereNew(c : TConsultaNew; var pol, pas, pint: String) : String;
var
  tempol : array [1..7] of String;
  tempint : array [1..5] of String;
  tempas : array [1..4] of String;
  s1, s2, t1, t2 : String;

  procedure InitArray(a : array of String);
  // Inicializa un array de strings de cualquier longitud con strings vac�os.
  var
    i : Integer;
  begin
    for i := Low(a) to High(a) do
      a[i] := '';
  end;

  function AssignAux(s1, s2 : String) : String;
  // Funci�n auxiliar.
  var
    value : String;
  begin
    Result := '';
    value := Trim(s2);
    if value <> '' then
      Result := Format('%s LIKE ''%s%%''', [s1, value]);
  end;

  function Implode(a : array of String; s : String) : String;
  // Agrega un string "s" entre cada par de elementos de "a".
  var
    i, l, h : Integer;
  begin
    Result := '';
    l := Low(a);
    h := High(a);
    if h - l > 0 then
      Result := a[0];
    for i := l + 1 to h do
      if a[i] <> '' then
        if Result = '' then
          Result := Result + a[i]
        else
          Result := Result + s + a[i]
  end;

begin
  Result := '';
  InitArray(tempol);
  InitArray(tempas);
  InitArray(tempint);

	if c.NUMDOC > 10 then
	begin
    tempol[1] := Format('RDOCNUMEROENTERO = %d', [c.NUMDOC]);
		tempas[1] := Format('RDOCNUMEROENTERO = %d', [c.NUMDOC]);
		tempint[1] := Format('RDOCNUMEROENTERO = %d', [c.NUMDOC]);
  end;

  tempol[2] := AssignAux('NOMBRE1', c.NOMBRE1);
  tempol[3] := AssignAux('NOMBRE2', c.NOMBRE2);
  tempol[4] := AssignAux('APELLIDO1', c.APELLIDO1);
  tempol[5] := AssignAux('APELLIDO2', c.APELLIDO2);
	tempol[6] := Format('NACIONALIDAD = ''%s''', [c.NACIONALIDAD]);
  tempol[7] := Format('FECHA_NAC = to_date(''%s'',''dd/mm/yyyy'')', [c.FECHANAC]);



	tempint[2] := Format('NACIONALIDAD = ''%s''', [c.NACIONALIDAD]);
  tempint[3] := Format('FECHA_NAC = to_date(''%s'',''dd/mm/yyyy'')', [c.FECHANAC]);
  s1 := Trim(c.APELLIDO1);
  s2 := Trim(c.APELLIDO2);
  t1 := '';
  t2 := '';
  if (s1 <> '') or (s2 <> '') then
  begin
    if s1 <> '' then
    begin
      t1 := s1 + '%';
      t2 := s1 + '%';
    end;
    if s2 <> '' then
    begin
      t1 := t1 + ' %' + s2 + '%';
      t2 := t2 + '%' + s2 + '%';
    end;
    tempint[4] := 'APELLIDOS LIKE ''' + t1 + '''';
  end;


  s1 := Trim(c.NOMBRE1);
  s2 := Trim(c.NOMBRE2);
	if (s1 <> '') or (s2 <> '') then
	begin
    t1 := '';
    if s1 <> '' then
    begin
      t1 := s1 + '%';
      t2 := t2 + '%' + s1 + '%';
    end;
    if s2 <> '' then
    begin
      t1 := t1 + ' %' + s2 + '%';
      t2 := t2 + '%' + s2 + '%';
    end;
    tempint[5] := 'NOMBRES LIKE ''' + t1 + '''';
  end;


  

	tempas[2] := Format('NACIONALIDAD = ''%s''', [c.NACIONALIDAD]);
  tempas[3] := Format('FECHA_NAC = to_date(''%s'',''dd/mm/yyyy'')', [c.FECHANAC]);
  if t2 <> '' then
		tempas[4] := 'APELLIDOS LIKE ''' + t2 + '''';

  pol := Implode(tempol, ' AND ');
  pas := Implode(tempas, ' AND ');
  pint := Implode(tempint, ' AND ');
end;

// Setea el SQL statment.
procedure TOraQry.SetSQL(c : TConsulta);
var
  aux, wol, was, wint : String;
begin
  aux := '';
  // creo los where
	GetWhere(c, wol, was, wint);

	//-----------------------------OL
  aux := 'SELECT TRIM(APELLIDO1 || '' '' || APELLIDO2) AS APELLIDOS,' +
	       'TRIM(NOMBRE1 || '' '' || NOMBRE2) AS NOMBRES,SEXO,NACIONALIDAD,TIPO_DOC,' +
	       'NRO_DOC,FECHA_CRUCE,PASO_CRUCE,TIPO_CRUCE, PAIS_EMISOR, PROCEDENCIA_DESTINO, IDENTIFICADOR_TRANSPORTE, FECHA_NAC FROM ' +
         'V_WEB_SERVICE_OL WHERE ' + wol + ' AND ESTADO = ''ACEPTADO'' UNION ALL ' +
	       //------------------------------------

         //-----------------------------AS
	       'SELECT APELLIDOS,NOMBRES,SEXO,NACIONALIDAD,TIPO_DOC,NRO_DOC,FECHA_CRUCE,' +
         'PASO_CRUCE,TIPO_CRUCE, PAIS_EMISOR, PROCEDENCIA_DESTINO, IDENTIFICADOR_TRANSPORTE, FECHA_NAC  FROM ' +
         'V_WEB_SERVICE_AS WHERE ' + was + ' AND ESTADO = ''ACEPTADO'' UNION ALL ' +

         'SELECT APELLIDOS,NOMBRES,SEXO,NACIONALIDAD,TIPO_DOC,NRO_DOC,FECHA_CRUCE,' +
         'PASO_CRUCE,TIPO_CRUCE, PAIS_EMISOR, PROCEDENCIA_DESTINO, IDENTIFICADOR_TRANSPORTE , FECHA_NAC  FROM ' +
         'V_WEB_SERVICE_INT WHERE ' + wint + ' AND ESTADO = ''ACEPTADO'' ORDER BY FECHA_CRUCE DESC';

         //-------------------------
  Qry.SQL.Clear;
  Qry.SQL.Add('SELECT APELLIDOS,NOMBRES,SEXO,NACIONALIDAD,TIPO_DOC,NRO_DOC,');
  Qry.SQL.Add('TO_CHAR(FECHA_CRUCE,''dd/mm/yyyy hh24:mi:ss'') AS FECHA_CRUCE,');
	Qry.SQL.Add('PASO_CRUCE,TIPO_CRUCE, PAIS_EMISOR, PROCEDENCIA_DESTINO, IDENTIFICADOR_TRANSPORTE, FECHA_NAC   FROM (' + aux + ') WHERE ROWNUM <=501');
  //Qry.SQL.SaveToFile('./sql.txt');
end;


procedure TOraQry.SetSQLNew(c : TConsultaNew);
var
  aux, wol, was, wint : String;
begin
  aux := '';
  // creo los where
	GetWherenew(c, wol, was, wint);

	//-----------------------------OL
  aux := 'SELECT TRIM(APELLIDO1 || '' '' || APELLIDO2) AS APELLIDOS,' +
	       'TRIM(NOMBRE1 || '' '' || NOMBRE2) AS NOMBRES,SEXO,NACIONALIDAD,TIPO_DOC,' +
	       'NRO_DOC,FECHA_CRUCE,PASO_CRUCE,TIPO_CRUCE, FECHA_NAC  FROM ' +
         'V_WEB_SERVICE_OL WHERE ' + wol + ' AND ESTADO = ''ACEPTADO'' ';

      {
         UNION ALL ' +
	       //------------------------------------

         //-----------------------------AS
	       'SELECT APELLIDOS,NOMBRES,SEXO,NACIONALIDAD,TIPO_DOC,NRO_DOC,FECHA_CRUCE,' +
         'PASO_CRUCE,TIPO_CRUCE FROM ' +
         'V_WEB_SERVICE_AS WHERE ' + was + ' AND ESTADO = ''ACEPTADO'' UNION ALL ' +

         'SELECT APELLIDOS,NOMBRES,SEXO,NACIONALIDAD,TIPO_DOC,NRO_DOC,FECHA_CRUCE,' +
         'PASO_CRUCE,TIPO_CRUCE FROM ' +
         'V_WEB_SERVICE_INT WHERE ' + wint + ' AND ESTADO = ''ACEPTADO'' ORDER BY FECHA_CRUCE DESC';
      }
         //-------------------------
  Qry.SQL.Clear;
  Qry.SQL.Add('SELECT APELLIDOS,NOMBRES,SEXO,NACIONALIDAD,TIPO_DOC,NRO_DOC,');
  Qry.SQL.Add('TO_CHAR(FECHA_CRUCE,''dd/mm/yyyy hh24:mi:ss'') AS FECHA_CRUCE,');
	Qry.SQL.Add('PASO_CRUCE,TIPO_CRUCE, FECHA_NAC  FROM (' + aux + ') WHERE ROWNUM <=501');
  //Qry.SQL.SaveToFile('./sql.txt');
end;


procedure TOraQry.SetSQL2(fecha: string; matricula : string);   //; transitoDireccion : string
var sql : string;
begin
  sql := 'SELECT trim(RAPELLIDO1 ||'' ''|| RAPELLIDO2) AS APELLIDOS, trim(RNOMBRE1 ||'' ''|| RNOMBRE2) AS NOMBRES, ' +
         'RSEXO AS SEXO, RNACIONALIDAD AS NACIONALIDAD, RDOCTIPO AS TIPO_DOC, RDOCNUMERO AS NRO_DOC, ' +
         'RTRANSITOFECHA AS FECHA_CRUCE, RTRANSITOPASO AS PASO_CRUCE, RTRANSITOPASOTIPO AS TIPO_CRUCE, FECHA_NAC  ' +
         'FROM TRAVEL_OWNER.TRAN_OL_SICAM T1 ' +
         'WHERE RTRANSITOFECHA BETWEEN TO_DATE (''' + fecha + ' 00:00:00'', ''dd-mm-yyyy hh24:mi:ss'' ) ' +
         'AND TO_DATE (''' + fecha +'  23:59:59'', ''dd-mm-yyyy hh24:mi:ss'' ) ' +
        // 'AND RTRANSITODIRECCION = '+ QuotedStr(AnsiUpperCase(transitoDireccion)) + ' ' +
         'AND ( '+
         //(RVEHICULOPATENTE = '+ QuotedStr(AnsiUpperCase(matricula))+') or
         ' (RVUELODESC = '+ QuotedStr(AnsiUpperCase(matricula))+')'
         //(RBUQUEDESC = '+ QuotedStr(AnsiUpperCase(matricula))+')
         +')'+
         'AND T1.FECHAREGISTRO = ( SELECT MAX (T2.FECHAREGISTRO) FROM TRAVEL_OWNER.TRAN_OL_SICAM T2 '+
         'WHERE T1.IDLOC = T2.IDLOC AND T1.IDTRANSITO = T2.IDTRANSITO AND T1.RTRANSITOFECHA = T2.RTRANSITOFECHA '+
         'GROUP BY T2.IDLOC, T2.IDTRANSITO, T2.RTRANSITOFECHA)ORDER BY FECHA_CRUCE DESC';
  Qry.SQL.Clear;
  qry.SQL.Add(sql);
  //qry.SQL.SaveToFile('./chota.sql');
end;

// Check de request data.
function TOraQry.CheckRequestData(c : TConsulta) : Boolean;
var
  cond : Integer;

  function CheckAux(s : String; var c : Integer) : Boolean;
  // Si "s"='' -> "Result"=True pero no se incrementa el contador de condiciones "c".
  // Si "s" no es correcta -> "Result"=False y tampoco se incrementa "c".
  // "c" es incrementado si "s"<>'' y es correcta.
  begin
    if s = '' then
      Result := True
    else
    begin
      Result := CheckString(s);
      if Result then
        c := c + 1;
    end;
  end;

begin
  Result := False;
	cond := 0;
	// Verifico las adenas
  if not CheckString(c.USUARIO) then
    Exit;
  if not CheckString(c.CLAVE) then
    Exit;
  if not CheckString(c.OPERADOR) then
    Exit;
  // Los cinco datos siguientes son opcionales
  if not CheckAux(c.NOMBRE1, cond) then
    Exit;
  if not CheckAux(c.NOMBRE2, cond) then
    Exit;
  if not CheckAux(c.APELLIDO1, cond) then
    Exit;
  if not CheckAux(c.APELLIDO2, cond) then
    Exit;
  if c.NUMDOC >= 10 then
    cond := 2;
  Result := cond >= 2;
end;


function TOraQry.CheckRequestDataNew(c : TConsultaNew) : Boolean;
var
  cond : Integer;

  function CheckAux(s : String; var c : Integer) : Boolean;
  // Si "s"='' -> "Result"=True pero no se incrementa el contador de condiciones "c".
  // Si "s" no es correcta -> "Result"=False y tampoco se incrementa "c".
  // "c" es incrementado si "s"<>'' y es correcta.
  begin
    if s = '' then
      Result := True
    else
    begin
      Result := CheckString(s);
      if Result then
        c := c + 1;
    end;
  end;

begin
  Result := False;
	cond := 0;
	// Verifico las adenas
  if not CheckString(c.USUARIO) then
    Exit;
  if not CheckString(c.CLAVE) then
    Exit;
  if not CheckString(c.OPERADOR) then
    Exit;
  // Los cinco datos siguientes son opcionales
  if not CheckAux(c.NOMBRE1, cond) then
    Exit;
  if not CheckAux(c.NOMBRE2, cond) then
    Exit;
  if not CheckAux(c.APELLIDO1, cond) then
    Exit;
  if not CheckAux(c.APELLIDO2, cond) then
    Exit;
  if c.NUMDOC >= 10 then
    cond := 2;
  Result := cond >= 2;
end;




// Chequea usuario y contrasenia.
function TOraQry.CheckUser(c : TConsulta) : Boolean;
begin
  Result := (Trim(c.USUARIO) = 'GENDARMERIA') and (Trim(c.CLAVE) = 'G3ND4');
end;

function IsAlphaNumeric(s : String) : Boolean;
var
  i, len : Integer;
begin
  Result := False;
  len := Length(s);
  for i := 1 to len do
    if not (s[i] in ['a'..'z', 'A'..'Z', '0'..'9', '�', '�', '�', '�']) then
      Exit;
  Result := True;
end;

// Chequea una cadena alfanumerica.
function TOraQry.CheckString(s : String) : Boolean;
begin
  Result := (Length(Trim(s)) >= 2) and IsAlphaNumeric(s);
end;

function TOraQry.GetResponse : TRespuesta;
var
  rf : TRespuestaFilas;
begin
  SetLength(Result, TotalRecords);

  Qry.First;
  while not Qry.Eof do
  begin
    rf := TRespuestaFilas.Create;

    rf.APELLIDOS := Qry.FieldByName('APELLIDOS').AsString;
    rf.NOMBRES := Qry.FieldByName('NOMBRES').AsString;
    rf.SEXO := Qry.FieldByName('SEXO').AsString;
    rf.NACIONALIDAD := Qry.FieldByName('NACIONALIDAD').AsString;
    rf.TIPO_DOC := Qry.FieldByName('TIPO_DOC').AsString;
    rf.NRO_DOC := Qry.FieldByName('NRO_DOC').AsString;
    rf.FECHA_CRUCE := Qry.FieldByName('FECHA_CRUCE').AsString;
    rf.PASO_CRUCE := Qry.FieldByName('PASO_CRUCE').AsString;
    rf.TIPO_CRUCE := Qry.FieldByName('TIPO_CRUCE').AsString;
    rf.FECHA_NACIMIENTO := Qry.FieldByName('FECHA_NAC').AsString;

    Result[Qry.RecNo-1] := rf;

    Qry.Next;
  end;
end;

function TOraQry.GetResponseStr : String;
var
  doc : TXMLDocument;
  node : IXMLNode;

  procedure WriteXMLRow(var rootnode : IXMLNode; fields : TFieldList);
  var
    i : Integer;
    node : IXMLNode;
  begin
    node := rootnode.AddChild('ROW');

    (**) 
    // antes tenia menos -1. Para mantener lo mismo que antes,
    //dado que se agregaron 3 datos nuevos los sumo y paso a restar -4

    for i := 0 to fields.Count - 4 (**) do
      node.AddChild(fields[i].FieldName).text := fields[i].AsString;
  end;

begin
  doc := TXMLDocument.Create(Qry);
  doc.Active:= True;
  doc.Version:= '1.0';
  doc.Encoding:= 'iso-8859-1';
  node := doc.AddChild('RESULTADO');
  Qry.First;
  while not Qry.Eof do
  begin
    WriteXMLRow(node, Qry.FieldList);
    Qry.Next;
  end;
  Result := doc.XML.Text;
  doc.Free;
end;

function TOraQry.GetResponseAmpliada: TRespuestaAmpliada;
var
  rf : TRespuestaAmpliadaFilas;
begin

  SetLength(Result, TotalRecords);

  Qry.First;
  while not Qry.Eof do
  begin
    rf := TRespuestaAmpliadaFilas.Create;

    rf.APELLIDOS := Qry.FieldByName('APELLIDOS').AsString;
    rf.NOMBRES := Qry.FieldByName('NOMBRES').AsString;
    rf.SEXO := Qry.FieldByName('SEXO').AsString;
    rf.NACIONALIDAD := Qry.FieldByName('NACIONALIDAD').AsString;
    rf.TIPO_DOC := Qry.FieldByName('TIPO_DOC').AsString;
    rf.NRO_DOC := Qry.FieldByName('NRO_DOC').AsString;
    rf.FECHA_CRUCE := Qry.FieldByName('FECHA_CRUCE').AsString;
    rf.PASO_CRUCE := Qry.FieldByName('PASO_CRUCE').AsString;
    rf.TIPO_CRUCE := Qry.FieldByName('TIPO_CRUCE').AsString;

    rf.PAIS_EMISO_DOC := Qry.FieldByName('PAIS_EMISOR').AsString;
    rf.PROCEDENCIA_DETINO := Qry.FieldByName('PROCEDENCIA_DESTINO').AsString;
    rf.IDENTIFICADOR_TRANSPORTE := Qry.FieldByName('IDENTIFICADOR_TRANSPORTE').AsString;
    rf.FECHA_NACIMIENTO := Qry.FieldByName('FECHA_NAC').AsString;


    Result[Qry.RecNo-1] := rf;

    Qry.Next;
  end;
end;


constructor TOraQry.Create;
begin
  inherited Create;
  Conn := TOraSession.Create(nil);
  Conn.Server := 'BCSHQ5';
  Conn.Username := 'WEB_SERVICE';
  Conn.Password := 'WEB';
  Qry := TOraQuery.Create(nil);
  Qry.Session := Conn;
end;
constructor TOraQry.Create2;
begin
  inherited Create;
  Conn := TOraSession.Create(nil);
  Conn.Server := 'BCSHQ8';
  Conn.Username := 'TRAVEL_OWNER';
  Conn.Password := 'tulkas';
  Qry := TOraQuery.Create(nil);
  Qry.Session := Conn;
end;

destructor TOraQry.Destroy;
begin
  Conn.Free;
  Qry.Free;
  inherited Destroy;
end;

// Consulta de transitos.
function TOraQry.ExecAux(c : TConsulta) : Boolean;
begin
  Result := False;

{  if not CheckUser(c) then
    Exit;
 No va en la version actual del ws}
  if not CheckRequestData(c) then
    Exit;

  SetSQL(c);

  Open;

  // Forzar a que "RecordCount" tome su m�ximo valor.
  Qry.Last;
  // Esta variable se utiliza en otro m�todo. Se setea aqu� por conveniencia ya
  // que con el Last() ponemos "RecordCount" en el �ltimo registro.
  TotalRecords := Qry.RecordCount;
  // Si hay 500 o mas registros retorno.
{
	if TotalRecords > 500 then
		Exit;
}
  Result := True;
end;


function TOraQry.ExecAuxNew(c : TConsultaNew) : Boolean;
begin
  Result := False;

{  if not CheckUser(c) then
    Exit;
 No va en la version actual del ws}
  if not CheckRequestDataNew(c) then
    Exit;

  SetSQLNew(c);

  Open;

  // Forzar a que "RecordCount" tome su m�ximo valor.
  Qry.Last;
  // Esta variable se utiliza en otro m�todo. Se setea aqu� por conveniencia ya
  // que con el Last() ponemos "RecordCount" en el �ltimo registro.
  TotalRecords := Qry.RecordCount;
  // Si hay 500 o mas registros retorno.
{
	if TotalRecords > 500 then
		Exit;
}
  Result := True;
end;


function TOraQry.ExecAux2(fecha: string; matricula : string) : Boolean; //; transitoDireccion : string
begin
  Result := False;
	{if not CheckRequestData2(c) then
    Exit;}
  SetSQL2(fecha, matricula ); //, transitoDireccion
  //QRY.SQL.SaveToFile('.\WSGNA.TXT');
  Open;
  Qry.Last;
  TotalRecords := Qry.RecordCount;
  Result := True;
end;

procedure TOraQry.Open;
begin
  if not Conn.Connected then
    Conn.Connect;
  Qry.Open;
end;

procedure TOraQry.Close;
begin
  Qry.Close;
  if Conn.Connected then
    Conn.Disconnect;
end;

function TOraQry.Exec(c : TConsulta) : TRespuesta;
begin
  if not ExecAux(c) then
    Exit;
  Result := GetResponse;
  Close;
end;

function TOraQry.ExecAmpliada(c : TConsulta) : TRespuestaAmpliada;
begin
  if not ExecAux(c) then
    Exit;
  Result := GetResponseAmpliada;
  Close;
end;



function TOraQry.ExecNew(c : TConsultaNew) : TRespuesta;
begin
  if not ExecAuxNew(c) then
    Exit;
  Result := GetResponse;
  Close;
end;

function TOraQry.ExecStr(c : TConsulta) : String;
begin
  if not ExecAux(c) then
    Exit;
  Result := GetResponseStr;
  Close;
end;

function TOraQry.ExecQry(fecha: string; matricula : string) : TRespuesta; //; transitoDireccion : string
begin
  if not ExecAux2(fecha, matricula) then //, transitoDireccion
    exit;
  result := GetResponse;
  Close;
end;

end.
