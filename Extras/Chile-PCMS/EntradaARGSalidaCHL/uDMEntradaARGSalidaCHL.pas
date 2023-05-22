unit uDMEntradaARGSalidaCHL;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBQuery, IBDatabase, RxMemDS,
  DBClient,NetConn;

type
  TDMSem = class(TDataModule)
    bdMain: TIBDatabase;
    trnMain: TIBTransaction;
    qryValidate: TIBQuery;
    tblArch: TClientDataSet;
    tblArcharchivo: TStringField;
    tblArchcont: TIntegerField;
    tblArchFECHA_HORA: TStringField;
    tblArchFuncionario: TStringField;
    tblArchObservacion: TStringField;
    tblArchNumeroDocumento: TStringField;
    tblArchCodigoPaisEmisor: TStringField;
    tblArchFlag: TBooleanField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    { Private declarations }
  public
    SicamDB,descrip:String;
    Paso:Integer;
    con :  TNetConnection;
    GLOBAL_UserName : String;
    GLOBAL_NetConUserName : String;
    GLOBAL_NetConPassword : String;
    GLOBAL_NetConActivo : Boolean;
    GLOBAL_NetConRemoteName : String;
    GLOBAL_SemPath : String;
    GLOBAL_WSValSemaforo : String;
    GLOBAL_CONTADOR : Integer;
    GLOBAL_WSListaControlCHL: string;
    GLOBAL_WSListaControl: string;

    LsSemArch:TStringList;

    { Public declarations }
    procedure inicializar;
    function ValidarUsuario(usr : String; edgid : Integer; pwd : String) : Integer;

    function completoListaDeSemArchivos(aPath:String):Boolean;

    procedure agregarArchTabla(aPath:String);

    procedure refrescoTabla;

    procedure ordenoCampo(aCampo:String);

    procedure renombroArch(aPath,nombre,ext:String); 

  end;

var
  DMSem: TDMSem;

implementation

{$R *.dfm}

uses Windows,IniFiles,Variants;


type
	MD5Count = array[0..1] of DWORD;
	MD5State = array[0..3] of DWORD;
	MD5Block = array[0..15] of DWORD;
	MD5CBits = array[0..7] of byte;
	MD5Digest = array[0..15] of byte;
	MD5Buffer = array[0..63] of byte;
	MD5Context = record
		State: MD5State;
		Count: MD5Count;
		Buffer: MD5Buffer;
	end;

// Initialize given Context
procedure MD5Init(var Context: MD5Context);
begin
	with Context do begin
		State[0] := $67452301;
		State[1] := $efcdab89;
		State[2] := $98badcfe;
		State[3] := $10325476;
		Count[0] := 0;
		Count[1] := 0;
		ZeroMemory(@Buffer, SizeOf(MD5Buffer));
	end;
end;

// Encode Count bytes at Source into (Count / 4) DWORDs at Target
procedure Encode(Source, Target: pointer; Count: longword);
var
	S: PByte;
	T: PDWORD;
	I: longword;
begin
	S := Source;
	T := Target;
	for I := 1 to Count div 4 do begin
		T^ := S^;
		inc(S);
		T^ := T^ or (S^ shl 8);
		inc(S);
		T^ := T^ or (S^ shl 16);
		inc(S);
		T^ := T^ or (S^ shl 24);
		inc(S);
		inc(T);
	end;
end;

// Decode Count DWORDs at Source into (Count * 4) Bytes at Target
procedure Decode(Source, Target: pointer; Count: longword);
var
	S: PDWORD;
	T: PByte;
	I: longword;
begin
	S := Source;
	T := Target;
	for I := 1 to Count do begin
		T^ := S^ and $ff;
		inc(T);
		T^ := (S^ shr 8) and $ff;
		inc(T);
		T^ := (S^ shr 16) and $ff;
		inc(T);
		T^ := (S^ shr 24) and $ff;
		inc(T);
		inc(S);
	end;
end;

var
	PADDING: MD5Buffer = (
		$80, $00, $00, $00, $00, $00, $00, $00,
		$00, $00, $00, $00, $00, $00, $00, $00,
		$00, $00, $00, $00, $00, $00, $00, $00,
		$00, $00, $00, $00, $00, $00, $00, $00,
		$00, $00, $00, $00, $00, $00, $00, $00,
		$00, $00, $00, $00, $00, $00, $00, $00,
		$00, $00, $00, $00, $00, $00, $00, $00,
		$00, $00, $00, $00, $00, $00, $00, $00
	);

function F(x, y, z: DWORD): DWORD;
begin
	Result := (x and y) or ((not x) and z);
end;

function G(x, y, z: DWORD): DWORD;
begin
	Result := (x and z) or (y and (not z));
end;

function H(x, y, z: DWORD): DWORD;
begin
	Result := x xor y xor z;
end;

function I(x, y, z: DWORD): DWORD;
begin
	Result := y xor (x or (not z));
end;

procedure rot(var x: DWORD; n: BYTE);
begin
	x := (x shl n) or (x shr (32 - n));
end;

procedure FF(var a: DWORD; b, c, d, x: DWORD; s: BYTE; ac: DWORD);
begin
	inc(a, F(b, c, d) + x + ac);
	rot(a, s);
	inc(a, b);
end;

procedure GG(var a: DWORD; b, c, d, x: DWORD; s: BYTE; ac: DWORD);
begin
	inc(a, G(b, c, d) + x + ac);
	rot(a, s);
	inc(a, b);
end;

procedure HH(var a: DWORD; b, c, d, x: DWORD; s: BYTE; ac: DWORD);
begin
	inc(a, H(b, c, d) + x + ac);
	rot(a, s);
	inc(a, b);
end;

procedure II(var a: DWORD; b, c, d, x: DWORD; s: BYTE; ac: DWORD);
begin
	inc(a, I(b, c, d) + x + ac);
	rot(a, s);
	inc(a, b);
end;

// Transform State according to first 64 bytes at Buffer
procedure Transform(Buffer: pointer; var State: MD5State);
var
	a, b, c, d: DWORD;
	Block: MD5Block;
begin
	Encode(Buffer, @Block, 64);
	a := State[0];
	b := State[1];
	c := State[2];
	d := State[3];
	FF (a, b, c, d, Block[ 0],  7, $d76aa478);
	FF (d, a, b, c, Block[ 1], 12, $e8c7b756);
	FF (c, d, a, b, Block[ 2], 17, $242070db);
	FF (b, c, d, a, Block[ 3], 22, $c1bdceee);
	FF (a, b, c, d, Block[ 4],  7, $f57c0faf);
	FF (d, a, b, c, Block[ 5], 12, $4787c62a);
	FF (c, d, a, b, Block[ 6], 17, $a8304613);
	FF (b, c, d, a, Block[ 7], 22, $fd469501);
	FF (a, b, c, d, Block[ 8],  7, $698098d8);
	FF (d, a, b, c, Block[ 9], 12, $8b44f7af);
	FF (c, d, a, b, Block[10], 17, $ffff5bb1);
	FF (b, c, d, a, Block[11], 22, $895cd7be);
	FF (a, b, c, d, Block[12],  7, $6b901122);
	FF (d, a, b, c, Block[13], 12, $fd987193);
	FF (c, d, a, b, Block[14], 17, $a679438e);
	FF (b, c, d, a, Block[15], 22, $49b40821);
	GG (a, b, c, d, Block[ 1],  5, $f61e2562);
	GG (d, a, b, c, Block[ 6],  9, $c040b340);
	GG (c, d, a, b, Block[11], 14, $265e5a51);
	GG (b, c, d, a, Block[ 0], 20, $e9b6c7aa);
	GG (a, b, c, d, Block[ 5],  5, $d62f105d);
	GG (d, a, b, c, Block[10],  9,  $2441453);
	GG (c, d, a, b, Block[15], 14, $d8a1e681);
	GG (b, c, d, a, Block[ 4], 20, $e7d3fbc8);
	GG (a, b, c, d, Block[ 9],  5, $21e1cde6);
	GG (d, a, b, c, Block[14],  9, $c33707d6);
	GG (c, d, a, b, Block[ 3], 14, $f4d50d87);
	GG (b, c, d, a, Block[ 8], 20, $455a14ed);
	GG (a, b, c, d, Block[13],  5, $a9e3e905);
	GG (d, a, b, c, Block[ 2],  9, $fcefa3f8);
	GG (c, d, a, b, Block[ 7], 14, $676f02d9);
	GG (b, c, d, a, Block[12], 20, $8d2a4c8a);
	HH (a, b, c, d, Block[ 5],  4, $fffa3942);
	HH (d, a, b, c, Block[ 8], 11, $8771f681);
	HH (c, d, a, b, Block[11], 16, $6d9d6122);
	HH (b, c, d, a, Block[14], 23, $fde5380c);
	HH (a, b, c, d, Block[ 1],  4, $a4beea44);
	HH (d, a, b, c, Block[ 4], 11, $4bdecfa9);
	HH (c, d, a, b, Block[ 7], 16, $f6bb4b60);
	HH (b, c, d, a, Block[10], 23, $bebfbc70);
	HH (a, b, c, d, Block[13],  4, $289b7ec6);
	HH (d, a, b, c, Block[ 0], 11, $eaa127fa);
	HH (c, d, a, b, Block[ 3], 16, $d4ef3085);
	HH (b, c, d, a, Block[ 6], 23,  $4881d05);
	HH (a, b, c, d, Block[ 9],  4, $d9d4d039);
	HH (d, a, b, c, Block[12], 11, $e6db99e5);
	HH (c, d, a, b, Block[15], 16, $1fa27cf8);
	HH (b, c, d, a, Block[ 2], 23, $c4ac5665);
	II (a, b, c, d, Block[ 0],  6, $f4292244);
	II (d, a, b, c, Block[ 7], 10, $432aff97);
	II (c, d, a, b, Block[14], 15, $ab9423a7);
	II (b, c, d, a, Block[ 5], 21, $fc93a039);
	II (a, b, c, d, Block[12],  6, $655b59c3);
	II (d, a, b, c, Block[ 3], 10, $8f0ccc92);
	II (c, d, a, b, Block[10], 15, $ffeff47d);
	II (b, c, d, a, Block[ 1], 21, $85845dd1);
	II (a, b, c, d, Block[ 8],  6, $6fa87e4f);
	II (d, a, b, c, Block[15], 10, $fe2ce6e0);
	II (c, d, a, b, Block[ 6], 15, $a3014314);
	II (b, c, d, a, Block[13], 21, $4e0811a1);
	II (a, b, c, d, Block[ 4],  6, $f7537e82);
	II (d, a, b, c, Block[11], 10, $bd3af235);
	II (c, d, a, b, Block[ 2], 15, $2ad7d2bb);
	II (b, c, d, a, Block[ 9], 21, $eb86d391);
	inc(State[0], a);
	inc(State[1], b);
	inc(State[2], c);
	inc(State[3], d);
end;

procedure MD5Update(var Context: MD5Context; Input: pChar; Length: longword);
var
	Index: longword;
	PartLen: longword;
	I: longword;
begin
	with Context do begin
		Index := (Count[0] shr 3) and $3f;
		inc(Count[0], Length shl 3);
		if Count[0] < (Length shl 3) then inc(Count[1]);
		inc(Count[1], Length shr 29);
	end;
	PartLen := 64 - Index;
	if Length >= PartLen then begin
		CopyMemory(@Context.Buffer[Index], Input, PartLen);
		Transform(@Context.Buffer, Context.State);
		I := PartLen;
		while I + 63 < Length do begin
			Transform(@Input[I], Context.State);
			inc(I, 64);
		end;
		Index := 0;
	end else I := 0;
	CopyMemory(@Context.Buffer[Index], @Input[I], Length - I);
end;

// Finalize given Context, create Digest and zeroize Context
procedure MD5Final(var Context: MD5Context; var Digest: MD5Digest);
var
	Bits: MD5CBits;
	Index: longword;
	PadLen: longword;
begin
	Decode(@Context.Count, @Bits, 2);
	Index := (Context.Count[0] shr 3) and $3f;
	if Index < 56 then PadLen := 56 - Index else PadLen := 120 - Index;
	MD5Update(Context, @PADDING, PadLen);
	MD5Update(Context, @Bits, 8);
	Decode(@Context.State, @Digest, 4);
	ZeroMemory(@Context, SizeOf(MD5Context));
end;



// Create digest of given Message
function MD5String(M: string): MD5Digest;
var
	Context: MD5Context;
begin
	MD5Init(Context);
	MD5Update(Context, pChar(M), length(M));
	MD5Final(Context, Result);
end;


procedure StartTransaction( Trn : TIBTransaction );
{
  Comienza una transacción si la misma no se encuentra ya en progreso.
}
begin
  if not Trn.InTransaction then
    Trn.StartTransaction;
end;

procedure Commit(trn : TIBTransaction);
begin
  if trn.InTransaction then
    trn.Commit;
end;

procedure Rollback(trn : TIBTransaction);
begin
  // Generalmente la parte del commit de una transacción se pone dentro de un try ... except. No pasa lo
  // mismo con el rollback. El rollback se pone entre el except ... end del bloque. Por lo tanto si se
  // produce una excepción antes del rollback, la misma no será trapeada. Por esta razón el try ... except
  // del rollback está dentro de esta función.
  try
    if trn.InTransaction then
      trn.Rollback;
  except
  end;
end;


// Create hex representation of given Digest
function MD5Print(D: MD5Digest): string;
var
	I: byte;
const
	Digits: array[0..15] of char =
		('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f');
begin
	Result := '';
	for I := 0 to 15 do Result := Result + Digits[(D[I] shr 4) and $0f] + Digits[D[I] and $0f];
end;


function TDMSem.ValidarUsuario(usr : String; edgid : Integer; pwd : String) : Integer;
{
  [In]

    usr : Nombre de usuario al cual se le busca la clave
    edgid : ID de paso fronterizo al cual el usuario hace el login
    pwd : Clave a buscar en la base para el usuario ingresado

  [Result]

    -1 : Error
    -2 : La clave ingresada como parámetro no coincide con la de la base
    -3 : El usuario ingresado no existe en la base
    -4 : El usuario debe cambiar la contraseña antes de continuar.
    El resto de los resultados verlos de la tabla USUARIOSESTADOS
}
const
  MD5_123456 = 'e10adc3949ba59abbe56e057f20f883e';
  MD5_A1B2C3D4 = 'a780009e2fe12e462094a2fee53be835';
var
  pwrd : String;
  _state : Integer;
  count : Longint;
begin
  Result := -1;

  GLOBAL_UserName := usr;

  bdMain.Open;
  try
    with qryValidate do
      try
        StartTransaction(Transaction);
        Close;
        ParamByName('PIDPASO').Value := edgid;
        ParamByName('PNOMBREUSUARIO').Value := AnsiUpperCase(usr);
        Open;
        pwrd := FieldByName('CLAVESISTEMA').AsString;
        _state := FieldByName('IDUSUARIOSESTADOS').AsInteger;
        count := RecordCount;
        // Si la consulta no trae registros, el usuario no existe en la base
        if count = 0 then
          Result := -3
        else
        if pwrd = MD5Print(MD5String(pwd)) then
      //  if true = true then
        begin
          if (pwrd = MD5_123456) or (pwrd = MD5_A1B2C3D4)  then
            // El usuario debe cambiar la contraseña (123456) antes de continuar.
            Result := -4
          else
            Result := _state; // Notar que los estados de los usuarios parten a partir del ID 1
        end                   // En caso de que la clave coincida con la base o si la función termina en error,
        else                  // se devuelven valores que no entran en conflicto con los ID de estados de usuario
          Result := -2;
        Commit(Transaction);
      except
        Rollback(Transaction);
      end;
    finally
      bdMain.Close;
    end;
end;

//-----------------------------------------------------------------------------------------

function norDir(aDir:String):string;
begin
  Result := aDir;
  if aDir[length(aDir)]<>'\' then
    Result := aDir+'\';
end;

Function valorNodoXML(aXML,aNodo: String): String;

  function ExtractTextInsideGivenTagEx(const Tag, Text: string): string;
  var
    StartPos1, StartPos2, EndPos: integer;
    i: Integer;
  begin
    result := '';
    StartPos1 := Pos('<' + Tag, Text);
    EndPos := Pos('</' + Tag + '>', Text);
    StartPos2 := 0;
    for i := StartPos1 + length(Tag) + 1 to EndPos do
      if Text[i] = '>' then
     begin
        StartPos2 := i + 1;
        break;
      end;


    if (StartPos2 > 0) and (EndPos > StartPos2) then
      result := Copy(Text, StartPos2, EndPos - StartPos2);
  end;

begin
  Result := '';
  if aXML='' then
    Exit;
  Result := ExtractTextInsideGivenTagEx(UpperCase(aNodo),UpperCase(aXML));
end;




procedure TDMSem.inicializar;


  function GetWSDir : String;
  const
    BUFFER_SIZE = 2048;
  var
    buffer : PAnsiChar;
    len : DWORD;
  begin
    Result := '';
    GetMem(buffer, BUFFER_SIZE);
    FillChar(buffer^, BUFFER_SIZE, 0);
    len := GetModuleFileName(0, buffer, BUFFER_SIZE);
    if len > 0 then
    begin
      SetLength(Result, len);
      Move(buffer^, Result[1], len);
    end;
    FreeMem(buffer);
  end;

var
  inifile:TIniFile;
begin

  inifile := TIniFile.Create(Format('%sSICAM7.ini', [ExtractFilePath(GetWSDir)]));
  try
    SicamDB := inifile.ReadString('Data Base', 'basedatos', 'svdesarrollo10:c:\Basedatos\sicam.gdb');
  finally
    inifile.Free;
  end;

  inifile := TIniFile.Create(Format('%sSICAM.ini', [ExtractFilePath(GetWSDir)]));
  try
    Paso := inifile.ReadInteger('LoadReg', 'numero', -1);
    descrip := inifile.ReadString('LoadReg','descripcion','');
  finally
    inifile.Free;
  end;


  inifile := TIniFile.Create(Format('%sconfig.ini', [ExtractFilePath(GetWSDir)]));
  try
    GLOBAL_NetConUserName := inifile.ReadString('NetCon','NetConUserName','migraciones\adminapli');
    GLOBAL_NetConPassword := inifile.ReadString('NetCon','NetConPassword','Genius2012');
    GLOBAL_NetConActivo := inifile.ReadBool('NetCon','NetConActivo',False);
    //GLOBAL_NetConRemoteName := inifile.ReadString('NetCon','NetConRemoteName','');
    GLOBAL_SemPath := inifile.ReadString('SEMAFORO','PATH','\\172.16.192.111\Recursos\Semaforo');
    GLOBAL_WSValSemaforo := inifile.ReadString('WS','URL_ValSemaforo','http://172.16.192.151/cgi-bin/WSValidarSemaforo/WSValidarSemaforo/wsdl/IWSValidarSemaforo');
    GLOBAL_WSListaControl := inifile.ReadString('WS','Lista_Control','http://10.170.140.7:82/cgi-bin/wsimpedimentosargentina/wsimpedimentosargentina/soap/IwsRestriccion');
    GLOBAL_WSListaControlCHL := inifile.ReadString('WS','Lista_ControlCHL','http://ip/cgi-bin/wsRestriccionUnificado/WsListaControlUnificado/wsdl/IWsListaControl_Unif');

  finally
    inifile.Free;
  end;


  bdMain.Connected := False;
  bdMain.DatabaseName := SicamDB;

  LsSemArch := TStringList.Create;


  con := TNetConnection.Create(nil);
  con.UserName := GLOBAL_NetConUserName;
  con.Password := GLOBAL_NetConPassword;
  con.RemoteName := GLOBAL_SemPath;


{    con.UserName := 'migraciones\ventanilla_unica';
    con.Password := 'V3nt4n1ll4un1c4';
//    con.RemoteName := '\\172.16.192.111\ExpedienteDigital'; // desarrollo!!!
}
  con.ResourceType := rtDisk;

  if (pos('\\',GLOBAL_SemPath) in [1..3])and GLOBAL_NetConActivo then
    con.Connect;


  GLOBAL_CONTADOR := 0;

  tblArch.CreateDataSet;

  //GLOBAL_SemPath := 'C:\test\';

end;



procedure TDMSem.DataModuleCreate(Sender: TObject);
begin
  inicializar;
end;



function TDMSem.completoListaDeSemArchivos(aPath: String): Boolean;
var
  sr : TSearchRec;
begin
  LsSemArch.Clear;

  if FindFirst(norDir(aPath) + '*.log', faAnyFile, sr ) = 0 then
    repeat
      LsSemArch.Add(sr.Name);
    until findNext(sr)<>0;

  SysUtils.FindClose(sr) ;
end;

procedure TDMSem.agregarArchTabla(aPath:String);
var
  a:Integer;
  nom:String;
  bm:String;

  function ContArch(nombre:String):String;
  var
    sl:TStringList;
  begin
    sl := TStringList.Create;
    try
      sl.LoadFromFile(norDir(aPath)+nombre);
      Result := sl.Text;
    finally
      sl.Free;
    end;
  end;

var
  cont:String;

begin
  if not tblArch.Active then
    tblArch.Open;



  bm := tblArch.Bookmark;
  tblArch.DisableControls;
  Inc(GLOBAL_CONTADOR);

  for a:=0 to LsSemArch.Count-1 do
  begin
    nom := LsSemArch.Strings[a];

    if tblArch.Locate('archivo',nom,[]) then
    begin
      tblArch.Edit;
      tblArch.FieldByName('cont').AsInteger := GLOBAL_CONTADOR;
      tblArch.Post;
    end
    else
    begin
      cont := UpperCase(ContArch(nom));

      tblArch.Append;
      tblArch.FieldByName('archivo').AsString := nom;
      tblArch.FieldByName('cont').AsInteger := GLOBAL_CONTADOR;
      tblArch.FieldByName('FECHA_HORA').AsString := valorNodoXML(cont,'FECHA_HORA');
      tblArch.FieldByName('CodigoPaisEmisor').AsString := valorNodoXML(cont,'CodigoPaisEmisor');
      tblArch.FieldByName('NumeroDocumento').AsString := valorNodoXML(cont,'NumeroDocumento');
      tblArch.FieldByName('Flag').AsBoolean := valorNodoXML(cont,'Flag')='1';
      if valorNodoXML(cont,'Flag')='1'then          
        tblArch.FieldByName('Observacion').AsString := 'TRANSITO ACEPTADO POR SUPERVISOR DE PDI: '+valorNodoXML(cont,'Funcionario')+ ' SEGUN OBSERVACION: '+ valorNodoXML(cont,'Observacion')
       else
        tblArch.FieldByName('Observacion').AsString := 'TRANSITO DENEGADO POR SUPERVISOR DE PDI: '+valorNodoXML(cont,'Funcionario')+ ' SEGUN OBSERVACION: '+ valorNodoXML(cont,'Observacion');

      tblArch.FieldByName('Funcionario').AsString := valorNodoXML(cont,'Funcionario');
      tblArch.Post;
    end;
  end;


  tblArch.First;
  while not tblArch.Eof do
  begin
    if tblArch.FieldByName('cont').AsInteger<GLOBAL_CONTADOR then
      tblArch.Delete
    else
      tblArch.Next;
  end;

  try
    tblArch.Bookmark := bm;
  except
    tblArch.First;
  end;
  tblArch.EnableControls;
end;

procedure TDMSem.refrescoTabla;
begin
    completoListaDeSemArchivos(GLOBAL_SemPath);
  agregarArchTabla(GLOBAL_SemPath);
end;

procedure TDMSem.ordenoCampo(aCampo: String);
begin
  tblArch.IndexFieldNames := aCampo;
  tblArch.Close;
  tblArch.Open;
  refrescoTabla;
end;

procedure TDMSem.renombroArch(aPath, nombre, ext: String);
var
  s:String;
begin
  s := nombre;
  s := ChangeFileExt(s, ext);

  RenameFile(norDir(aPath)+nombre,norDir(aPath)+s);
end;

end.
