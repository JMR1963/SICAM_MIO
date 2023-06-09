unit SqlOracleManage;

interface

uses
    vcl.forms , system.Classes, data.DB, DBAccess, Ora,MemDS, xml.XMLIntf, system.StrUtils,
    WsListaControlIntf,
    winapi.ActiveX, system.IniFiles, uglobal, vcl.dialogs, soap.SOAPHTTPClient, data.Win.adodb, IpuenteUry1;

type
  ResultadoConsulta = XML_RESPUESTA_NEW;
  Persona = XML_CONSULTA_NEW;

  TSqlOracle = class
  private


    HTTPRIO1: THTTPRIO;
    FPassword: String;
    FUsername: String;
    FServer: String;
    FIndividuo: Persona;
    FResultado: ResultadoConsulta;
    FFuente: TESTATMANYSOURCES_NEW;
    OraSession: TOraSession;
    OraSession2: TOraSession;
    OraSession3: TOraSession;
    OraQuery: TOraQuery;
    OraQuery2: TOraQuery;
    OraQuery3: TOraQuery;
    OraStoredProc : TOraStoredProc;
    OraStoredProc2 : TOraStoredProc;



   procedure generarTxT2(path, resultado:string);

    procedure SetSql(pSql: TStrings);
    function GetSql: TStrings;
    procedure SetStoredProcName(pStore: String);
    procedure SetStoredProcName2(pStore: String);
    function GetStoredProcName: String;
    function GetStoredProcName2: String;

    function SetStringConnection: Integer;
    function SetStringConnection2: Integer;
    function SetStringConnection3: Integer;
    procedure WriteRowXML(var XmlRootNode: IXMLNode; Fields: TFieldList);

    procedure FixNames(Name: String; var Str1, Str2: String);
    function IsFucked(Str: String): Integer;
    function ParseName(Str: String):TStringList;


    function yaloconsulte( Individuo: Persona; pais_solicitante:string ; var cod_rta, cod_detalle_rta: integer ; Var color : string) : boolean;

    procedure ConsultaCOL(Individuo: Persona; var Resultado: ResultadoConsulta; var Error: Boolean);   (*jpb COL - 20150720*)


    function limpiar(NUMDOC: string) : string;
    function dameNombreApellidosYdoc(NumDoc, apellido1,apellido2, nombre1, nombre2 : string): integer;
    function StrCOL2resultadoConsulta(iNDIVIDUO: PERSONA): ResultadoConsulta; (*jpb COL - 20150720*)

    procedure ConsultaINT(Individuo: Persona; var Resultado: ResultadoConsulta; var Error: Boolean);
    function RequiereDoblecontrol( unaNacionalidad, unEmisorDoc: string ) : boolean;
    function StrINT2resultadoConsulta(Individuo: Persona; color : string): ResultadoConsulta;

    function consultoProfiles(Individuo: Persona; sentido: string) : boolean;
    procedure ConsultaPRF(Individuo: Persona; var Resultado: ResultadoConsulta; var Error: Boolean);
    function StrPROFILEresultadoConsulta(Individuo: Persona): ResultadoConsulta;




    procedure conectarASQLServer(var paso: string);

    function consultoPorAPENOMyFECHANAC(Individuo: Persona) : boolean;
    function consultoPorDOC(doc, emisor_doc: string) : boolean;


    procedure ConsultaFPE(Individuo: Persona; var Resultado: ResultadoConsulta; var Error: Boolean);
    function StrFPEresultadoConsulta(Individuo: Persona): ResultadoConsulta;


    // by pipo 20180413
    procedure conectarANominas;
    procedure ConsultaURY(Individuo: Persona; var Resultado: ResultadoConsulta; var Error: Boolean);
    function consultoPorUruguay(Individuo: Persona; var positivo : boolean ) : boolean;
    function StrURYresultadoConsulta(Individuo: Persona): ResultadoConsulta;
  public



    constructor Create;
    destructor Destroy; override;

    function Connect (Username, Password, Server: String): Integer;
    function connect2(Username, Password, Server: String): Integer;
    function connect3(Username, Password, Server: String): Integer;

    procedure Ejecutar;
    property Individuo: Persona read FIndividuo write FIndividuo;
    property Resultado: ResultadoConsulta read FResultado write FResultado;
    property Fuente: TESTATMANYSOURCES_NEW read Ffuente write FFuente;
    property Username: String read Fusername write FUsername;
    property Password: String read Fpassword write FPassword;
    property Server: String read FServer write FServer;
    property Sql: Tstrings read GetSql write SetSql;
    property storedProcName: string read GetStoredProcName write SetStoredProcName;



    function insertarLog(paisconsulta : string;
                         Individuo  : XML_CONSULTA_NEW ;
                         ColorRestri : string; (*Solo Interpol, resto NULL*)
                         codError, codRespuesta , tiempo_espera: integer) : boolean;
    function insertarLog_rta(Individuo  : XML_CONSULTA_NEW ; codRespuesta , codError   : string) : boolean;
    //procedure HTTPRIO1BeforeExecute(const MethodName: String;   var SOAPRequest: WideString);
    procedure HTTPRIO1BeforeExecuteAlfa(const MethodName: string; Request: TStream);


    function dameNombreApellidosYfechas(individuo: XML_CONSULTA_NEW): integer;
    function procesarSolicitud(individuo: XML_CONSULTA_NEW) : TRESPUESTA_ARG;


    function CalcularNombreApellidoYDOC(individuo: XML_CONSULTA_NEW;queDocMiro : integer): integer;
    function CalcularSoloDOC(individuo: XML_CONSULTA_NEW): integer;



  end;

Var
  SoapRequest:String;


implementation

uses
  System.Variants, System.SysUtils, XML.XmlDoc,  UcheckConn, System.Win.ComObj, System.DateUtils,
  consultaArgentina, IpuenteInterpol1;

/////////////////////////////////////////////////////////////////
/////**************   JPB -  Inicio    ********************//////
/////////////////////////////////////////////////////////////////

procedure TSqlOracle.generarTxT2(path, resultado:string);
var
  F: TextFile;
begin
  try
    AssignFile( F, path);
  //  REwrite( F );

    If not FileExists(path) then
      Rewrite(f);

    Append(f);

    //escribirRegistroBURe(f);

    WriteLn( F, resultado);

    CloseFile( F );
  except
  end;
end;


/////////////////////////////////////////////////////////////////
//////////****************   JPB -  fin    **************////////
/////////////////////////////////////////////////////////////////


function TSqlOracle.ParseName(Str: String): TStringList;
// Toma un apellido compuesto y lo  transforma en una lista de apellidos
var
  i: Integer;
  aux: String;
  list: TStringList;
begin
  list := TStringList.create;
  for i := 1 to Length(Str) do
  begin
    if (i=Length(Str)) and (aux='')then
    begin
      aux := Copy(Str, i, 1);
      list.Add(aux)
    end
    else
      if ((Str[i]=' ')or (i=Length(Str))) and (aux<>'') then
      begin
        if (i=Length(Str)) then
          aux := aux + Copy(Str, i, 1);
        list.Add(aux);
        aux := '';
      end
      else
        if (Str[i]<>' ') then
          aux := aux + copy(Str, i, 1);
  end;
  Result := list;
end;

function TSqlOracle.IsFucked(Str: String): Integer;
var
  i: Integer;
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
  if Length(Str) = 1 then
    Result := 0
  else
  begin
    for i := Low(FuckWords) to High(FuckWords) do
    begin
      if FuckWords[i] = Str then
      begin
        Result := 0;
        Exit;
      end;
    end;
    for i := Low(FuckAfterWords) to High(FuckAfterWords) do
    begin
      if FuckAfterWords[i] = Str then
      begin
        Result := 1;
        Exit;
      end;
    end;
      Result := -1;
  end;
end;

procedure TSqlOracle.FixNames(Name: String; var Str1, Str2: String);
var
  names : TStringList;
  lastFucked: Boolean;
  i: Integer;
begin
  lastFucked := True;
  names := ParseName(name);
  for i := 0 to names.Count-1 do
  begin
    if lastFucked then
    begin
      if i=0 then
        Str1 := names.Strings[i]
      else
        Str1 := Trim(str1+' '+names.Strings[i]);
      lastFucked:=(isFucked(names.Strings[i]) =0) ;
    end
    else
    begin
      lastFucked := False;
      if (isFucked(names.Strings[i]) =1)then
        if(i = 0) then
          Str1 := names.Strings[i]
        else
          Str1 := Trim(str1+' '+names.Strings[i])
      else
        if(i = 0) then
          Str1 := names.Strings[i]
        else
          Str2 := Trim(str2+' '+ names.Strings[i])
   end;
  end;
  FreeAndNil(Names);
end;

function TSqlOracle.connect(Username, Password, Server: String): Integer;
begin
  Result := 1;
  try
    FUsername := Username;
    FPassword := Password;
    FServer := Server;
    SetStringConnection;
    OraSession.Open;
  except
    Result := -1;
  end;
end;


function TSqlOracle.connect2(Username, Password, Server: String): Integer;
begin
  Result := 1;
  try
    FUsername := Username;
    FPassword := Password;
    FServer := Server;
    SetStringConnection2;
    OraSession2.Open;
  except
    Result := -1;
  end;
end;

function TSqlOracle.connect3(Username, Password, Server: String): Integer;
begin
  Result := 1;
  try
    FUsername := Username;
    FPassword := Password;
    FServer := Server;
    SetStringConnection3;
    OraSession3.Open;
  except
    Result := -1;
  end;
end;


constructor TSqlOracle.Create;
var  ini: TIniFile;
begin
  inherited;
  OraSession := TOraSession.Create(nil);
  ini := TIniFile.Create('.\config.ini');
  uglobal.SERVER:= ini.ReadString('CONFIG','SERVER','N');
  connect('marrese', '25dmayo', uglobal.SERVER);
  if OraSession.Connected then
  begin
    OraQuery := TOraQuery.Create(nil);
    OraQuery.Session := OraSession;
  end;


end;



destructor TSqlOracle.destroy;
begin
  FreeAndNil(OraSession);
  FreeAndNil(OraQuery);
  inherited;
end;

procedure TSqlOracle.WriteRowXML(var XmlRootNode: IXMLNode; Fields: TFieldList);
var
  i: Integer;
  xmlChild: IXMLNode;
begin
  xmlChild := XmlRootNode.AddChild('ROW');
  for i := 0 to Fields.Count-1 do
    XmlChild.AddChild(fields[i].FieldName).Text := Fields[i].AsString;
end;

procedure TSqlOracle.Ejecutar;
var
  resultadoonsultaemporaria: ResultadoConsulta;
  dimension: Integer;
  error: Boolean;
begin
  CoInitialize(nil);
  error := FALSE;

  // Siempre viene una fuente
  SetLength(FFuente, 1);
  FFuente[0] := TESTATSOURCE_NEW.Create;
  FFuente[0].FUENTES := FIndividuo.FUENTES;
  FFuente[0].ESTADO  := 'T';



  //Consulta COL       (*jpb COL - 20150720*)
  try
    if pos('COL', individuo.FUENTES) <> 0 then
    begin
      begin
        ConsultaCOL(individuo, Fresultado, error);
        if error then
          fuente[0].ESTADO  := 'E';
      end
    end;
  except
    Ffuente[0].ESTADO  := 'E';
  end;
  //FIN COL


  //Consulta INT       (*jpb INT - 20160610*)
  try
    if pos('XPO', individuo.FUENTES) <> 0 then
    begin
      begin
        ConsultaINT(individuo, Fresultado, error);
        if error then
          fuente[0].ESTADO  := 'E';
      end
    end;
  except
    Ffuente[0].ESTADO  := 'E';
  end;
  //FIN INT

  //Consulta INT       (*jpb INT - 20160610*)
  try
    if pos('PRF', individuo.FUENTES) <> 0 then
    begin
      begin
        ConsultaPRF(individuo, Fresultado, error);
        if error then
          fuente[0].ESTADO  := 'E';
      end
    end;
  except
    Ffuente[0].ESTADO  := 'E';
  end;
  //FIN PRF


  //Consulta INT       (*jpb INT - 20160610*)
  try
    if pos('FPE', individuo.FUENTES) <> 0 then
    begin
      begin
        ConsultaFPE(individuo, Fresultado, error);
        if error then
          fuente[0].ESTADO  := 'E';
      end
    end;
  except
    Ffuente[0].ESTADO  := 'E';
  end;
  //FIN FPE

  //Consulta URY       (*PIPO URY - 20180413*)
    try
    if pos('URY', individuo.FUENTES) <> 0 then
    begin
      begin
        ConsultaURY(individuo, Fresultado, error);
        if error then
          fuente[0].ESTADO  := 'E';
      end
    end;
  except
    Ffuente[0].ESTADO  := 'E';
  end;
  //FIN URY
end;

function TSqlOracle.GetSql: TStrings;
begin
  Result := OraQuery.SQL;
end;


PROCEDURE TSqlOracle.setSql(pSQL:TStrings);
begin
  OraQuery.SQL := pSQL;
end;


function TSqlOracle.GetStoredProcName: String;
begin
  Result := OrastoredProc.StoredProcName;
end;


function TSqlOracle.GetStoredProcName2: String;
begin
  Result := OrastoredProc2.StoredProcName;
end;


procedure TSqlOracle.SetStoredProcName(pStore: String);
begin
  OraStoredProc.StoredProcName := pStore;
end;


procedure TSqlOracle.SetStoredProcName2(pStore: String);
begin
  OraStoredProc2.StoredProcName := pStore;
end;

function TSqlOracle.SetStringConnection: Integer;
//chequea que esten seteados los parametros necesarios para realizar la conneccion
//inicia la conneccion. Retorna 1 si todo ok, retorna -1 si algo falla
begin
  try
    Result := 1;
    if(FPassword <> NullAsStringValue) or
      (FUsername <> NullAsStringValue) or
      (FServer <> NullAsStringValue) then
    begin
      OraSession.Username:= FUsername;
      OraSession.Password:= FPassword;
      OraSession.Server:= FServer;
    end
    else
      Result := -1;
  except
    Result := -1;
  end;
end;


function TSqlOracle.SetStringConnection2: Integer;
//chequea que esten seteados los parametros necesarios para realizar la conneccion
//inicia la conneccion. Retorna 1 si todo ok, retorna -1 si algo falla
begin
  try
    Result := 1;
    if(FPassword <> NullAsStringValue) or
      (FUsername <> NullAsStringValue) or
      (FServer <> NullAsStringValue) then
    begin
      OraSession2.Username:= FUsername;
      OraSession2.Password:= FPassword;
      OraSession2.Server:= FServer;
    end
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function TSqlOracle.SetStringConnection3: Integer;
//chequea que esten seteados los parametros necesarios para realizar la conneccion
//inicia la conneccion. Retorna 1 si todo ok, retorna -1 si algo falla
begin
  try
    Result := 1;
    if(FPassword <> NullAsStringValue) or
      (FUsername <> NullAsStringValue) or
      (FServer <> NullAsStringValue) then
    begin
      OraSession3.Username:= FUsername;
      OraSession3.Password:= FPassword;
      OraSession3.Server:= FServer;
    end
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function TSqlOracle.insertarLog(paisconsulta : string;
                                Individuo  : XML_CONSULTA_NEW ;
                                ColorRestri : string; (*Solo Interpol, resto NULL*)
                                codError, codRespuesta, tiempo_espera : integer) : boolean;
var OperadorAux : string;
begin
  TRY
    OraStoredProc := TOraStoredProc.Create(nil);
    OraStoredProc.Session := OraSession;
    OraStoredProc.StoredProcName:= 'SIGER.PR_INSERT_LOG_WEBSERVICE';

    if Pos('-',Individuo.OPERADOR) <> 0 then
      OperadorAux := copy(Individuo.OPERADOR,1,Pos('-',Individuo.OPERADOR)-1)
    else
      OperadorAux := Individuo.OPERADOR;

    if not OraSession.InTransaction then
    begin
      OraSession.StartTransaction;
      with OraStoredProc do
      begin
        Params.CreateParam(ftString,'p_tipo_documento',ptInput) ;
        Params.CreateParam(ftString,'p_numero_documento',ptInput);
        Params.CreateParam(ftString,'p_emisor_documento',ptInput);
        Params.CreateParam(ftString,'p_primer_nombre',ptInput);
        Params.CreateParam(ftString,'p_otros_nombres',ptInput);
        Params.CreateParam(ftString,'p_primer_apellido',ptInput);
        Params.CreateParam(ftString,'p_otros_apellidos',ptInput);
        Params.CreateParam(ftString,'p_fecha_nacimiento',ptInput);
        Params.CreateParam(ftString,'p_genero',ptInput);
        Params.CreateParam(ftString,'p_nacionalidad',ptInput);
        Params.CreateParam(ftString,'p_numero_identificacion',ptInput);
        Params.CreateParam(ftString,'p_pais_solicitante',ptInput);
        Params.CreateParam(ftInteger,'p_codigo_respuesta',ptInput);
        Params.CreateParam(ftInteger,'p_codigo_error_respuesta',ptInput);

        Params.CreateParam(ftString,'p_operador',ptInput);
        Params.CreateParam(ftString,'p_puesto_control',ptInput);
        Params.CreateParam(ftString,'p_color',ptInput);
        Params.CreateParam(ftInteger,'p_tiempo_respuesta',ptInput);


        IF UpperCase(Individuo.TIPODOC) <> '' then
          ParamByName('p_tipo_documento').Value :=  UpperCase(Individuo.TIPODOC)
        else
          ParamByName('p_tipo_documento').Value :='';
        ParamByName('p_numero_documento').Value := UpperCase(Individuo.NUMDOC);
        ParamByName('p_emisor_documento').Value := UpperCase(Individuo.EMISORDOC);
        ParamByName('p_primer_nombre').Value := UpperCase(Individuo.NOMBRE1);
        ParamByName('p_otros_nombres').Value := UpperCase(Individuo.NOMBRE2);
        ParamByName('p_primer_apellido').Value :=UpperCase(Individuo.APELLIDO1);
        ParamByName('p_otros_apellidos').Value :=UpperCase(Individuo.APELLIDO2);
        IF  Individuo.FECHANAC = '' THEN
        BEGIN
          Individuo.FECHANAC := '01/01/1900';
        END;
        ParamByName('p_fecha_nacimiento').Value :=UpperCase(Individuo.FECHANAC);
        ParamByName('p_genero').Value :=UpperCase(Individuo.GENERO);
        ParamByName('p_nacionalidad').Value := UpperCase(Individuo.NACIONALIDAD);
        ParamByName('p_numero_identificacion').Value :=UpperCase(Individuo.NUMEROIDENIFICACION);
        ParamByName('p_pais_solicitante').Value := UpperCase(paisconsulta);

        ParamByName('p_operador').Value :=UpperCase(OperadorAux) ;
        ParamByName('p_puesto_control').Value := UpperCase(Individuo.PASO);
        if ColorRestri <> '' then
          ParamByName('p_color').Value := UpperCase(ColorRestri)
        else
          ParamByName('p_color').Value := NullAsStringValue;
        ParamByName('p_tiempo_respuesta').Value := tiempo_espera;

        ParamByName('p_codigo_respuesta').Value :=codRespuesta;
        ParamByName('p_codigo_error_respuesta').Value := codError;



        ExecSQL;
      end;
      OraSession.Commit;

    end;
  except
    OraSession.Rollback;
    generarTxT2('.\logProcesoInsertLog.txt',formatdatetime('dd/mm/yyyy HH:mm:ss',now)+' - '+ UpperCase(Individuo.NUMDOC)+' - '+UpperCase(Individuo.FECHANAC)+' - '+  UpperCase(Individuo.APELLIDO1)+' '+ UpperCase(Individuo.NOMBRE1)+' - '+ inttostr(codRespuesta)+' '+ inttostr(codError)+' - '+UpperCase(Individuo.PASO));
  end;
  FreeAndNil(OraStoredProc);
end;


function TSqlOracle.insertarLog_rta(Individuo  : XML_CONSULTA_NEW ; codRespuesta , codError : string) : boolean;
begin


  TRY
    OraStoredProc2 := TOraStoredProc.Create(nil);
    OraStoredProc2.Session := OraSession;
    OraStoredProc2.StoredProcName:= 'SIGER.PR_INSERT_LOG_WEBSERVICE_RTA';
    if not OraSession.InTransaction then
    begin
      OraSession.StartTransaction;
      with OraStoredProc2 do
      begin
          Params.CreateParam(ftString,'p_tipo_documento',ptInput) ;
          Params.CreateParam(ftString,'p_numero_documento',ptInput);
          Params.CreateParam(ftString,'p_emisor_documento',ptInput);
          Params.CreateParam(ftString,'p_primer_nombre',ptInput);
          Params.CreateParam(ftString,'p_otros_nombres',ptInput);
          Params.CreateParam(ftString,'p_primer_apellido',ptInput);
          Params.CreateParam(ftString,'p_otros_apellidos',ptInput);
          Params.CreateParam(ftString,'p_fecha_nacimiento',ptInput);
          Params.CreateParam(ftString,'p_genero',ptInput);
          Params.CreateParam(ftString,'p_nacionalidad',ptInput);
          Params.CreateParam(ftString,'p_numero_identificacion',ptInput);
          Params.CreateParam(ftInteger,'p_codigo_respuesta',ptInput);
          Params.CreateParam(ftInteger,'p_codigo_error_respuesta',ptInput);
          Params.CreateParam(ftString,'p_usuario_pregunta',ptInput);
          Params.CreateParam(ftString,'p_operador',ptInput);


          ParamByName('p_tipo_documento').Value :=  UpperCase(Individuo.TIPODOC);
          ParamByName('p_numero_documento').Value := UpperCase(Individuo.NUMDOC);
          ParamByName('p_emisor_documento').Value := UpperCase(Individuo.EMISORDOC);
          ParamByName('p_primer_nombre').Value := UpperCase(Individuo.NOMBRE1);
          ParamByName('p_otros_nombres').Value := UpperCase(Individuo.NOMBRE2);
          ParamByName('p_primer_apellido').Value :=UpperCase(Individuo.APELLIDO1);
          ParamByName('p_otros_apellidos').Value :=UpperCase(Individuo.APELLIDO2);
          IF  Individuo.FECHANAC = '' THEN
          BEGIN
            Individuo.FECHANAC := '01/01/1900';
          END;
          ParamByName('p_fecha_nacimiento').Value :=UpperCase(Individuo.FECHANAC);
          ParamByName('p_genero').Value :=UpperCase(Individuo.GENERO);
          ParamByName('p_nacionalidad').Value := UpperCase(Individuo.NACIONALIDAD);
          ParamByName('p_numero_identificacion').Value :=UpperCase(Individuo.NUMEROIDENIFICACION);
          ParamByName('p_codigo_respuesta').Value :=strtoint(codRespuesta);
          ParamByName('p_codigo_error_respuesta').Value := strtoint(codError);
          ParamByName('p_usuario_pregunta').Value := UpperCase(Individuo.USUARIO);
          ParamByName('p_operador').Value := UpperCase(Individuo.OPERADOR);
          ExecSQL;
      end;
      OraSession.Commit;
    end;
  except
    OraSession.Rollback;
  end;
  FreeAndNil(OraStoredProc2);
end;


 (*jpb COL - 20150720*)

//procedure TSqlOracle.HTTPRIO1BeforeExecute(const MethodName: String; var SOAPRequest: WideString);
procedure TSqlOracle.HTTPRIO1BeforeExecuteAlfa(const MethodName: string; Request: TStream);
var  a, b,c,d,e :AnsiString;
  x:string;
begin
  a:=StringReplace(MethodName,'<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">','<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">',[rfReplaceAll] );
  b:=StringReplace(a,'consultarPersona','ser:consultarPersona',[rfReplaceAll] );
  c:=StringReplace(b, 'xmlns="http://servicio.migracion.gov.co/','xmlns:ser="http://servicio.migracion.gov.co/',[rfReplaceAll] );
  d:=StringReplace(c, 'xsd:','',[rfReplaceAll] ) ;
  e:=StringReplace(d, 'SOAP-ENV','soapenv',[rfReplaceAll] ) ;
  x:=StringReplace(d, 'xsd','',[rfReplaceAll] );
  SoapRequest:=x;
end;


function TSqlOracle.yaloconsulte( Individuo: Persona; pais_solicitante:string ; var cod_rta, cod_detalle_rta: integer; Var color : string ) : boolean;
begin
   Result := false;
   with  OraQuery do
   begin
    close;
    sql.Clear;
    sql.Add(
              'select * '+
              'from SIGER.LOG_WEBSERVICE '+
              'where '+
              'tipo_documento = UPPER(:unTipoDoc) and '+
              'numero_documento = UPPER(:unNroDoc) and '+
              'emisor_documento = UPPER(:unEmisorDoc) and '+
              'Fecha_nacimiento = TO_DATE(:unaFechaNac,''DD/MM/YYYY'') and '+
              'nacionalidad = UPPER(:unaNacionalidad) and '+
              'Pais_Solicitante =  UPPER(:unPaisSolicitante) and '+
              'codigo_respuesta <> 0 and '+
              //'sysdate - fecha_consulta < 0.084 '+
              'fecha_consulta > (sysdate - 2/24) '+
              'order by fecha_consulta desc '
            );
    parambyname('unTipoDoc').asstring:=Individuo.TIPODOC;
    parambyname('unNroDoc').asstring:=Individuo.NUMDOC;
    parambyname('unEmisorDoc').asstring:=Individuo.EMISORDOC;
    parambyname('unaFechaNac').asstring:=Individuo.FECHANAC;
    parambyname('unaNacionalidad').asstring:=Individuo.NACIONALIDAD;
    parambyname('unPaisSolicitante').asstring:=pais_solicitante;
    open;
    if not IsEmpty then
    begin
      First;
      Result := true;
      cod_rta := fieldbyname('codigo_respuesta').AsInteger;
      cod_detalle_rta := fieldbyname('codigo_error_respuesta').AsInteger;
      if fieldbyname('color').AsString = '' then
        color := ''
      else
        color := fieldbyname('color').AsString;
    end
   end;
end;


procedure TSqlOracle.ConsultaCOL(
  Individuo: Persona;
  var Resultado: ResultadoConsulta;
  var Error: Boolean);
Const
  P='HTTP';

var
  //ws : ConsultaAlianzaArgentina;
  ws : AlianzaArgentinaService;
  str: respuestaAlianza;
  color : string;


  (* estas dos variables se reeplazan por la clase del Ws de los Colombianos!  *)
  CodRespuesta, codDetalleRespuesta: integer;

  function dateOtravuelta(unafecha: string): string;
  begin
    result := copy(unafecha,7,4)+'/'+copy(unafecha,4,2)+'/'+ copy(unafecha,1,2);
  end;
begin
  error := False;
  (* estas dos variables se reeplazan por la clase del Ws de los Colombianos!  *)
  CodRespuesta:= -1;
  codDetalleRespuesta:= -1;
  if yaloconsulte(Individuo, 'COL',CodRespuesta, codDetalleRespuesta, color) then
  begin
    if CodRespuesta = 2 then
        Resultado := StrCOL2resultadoConsulta(Individuo); //Si hubo coincidencia en el ws de COLOMBIA
  end
  else
  begin
    try


      HTTPRIO1 := THTTPRIO.Create(nil);
      HTTPRIO1.WSDLLocation := 'http://172.20.3.115:8011/AlianzaPacifico/consultaArgentina?wsdl';
      HTTPRIO1.HTTPWebNode.UserName := 'ArgentinaDNM';
      HTTPRIO1.HTTPWebNode.Password :='4rg3nt1naDNM';
      HTTPRIO1.HTTPWebNode.UseUTF8InHeader := true;
      HTTPRIO1.OnBeforeExecute := HTTPRIO1BeforeExecuteAlfa;
      str := respuestaAlianza.Create;
      IF Individuo.TIPODOC <> '' THEN
      begin
        str := (HTTPRIO1 as AlianzaArgentinaService).consultarPersona(Individuo.TIPODOC,
                                   Individuo.NUMDOC,
                                   Individuo.EMISORDOC,
                                   Individuo.NUMEROIDENIFICACION,
                                   Individuo.NOMBRE1,
                                   Individuo.NOMBRE2,
                                   Individuo.APELLIDO1,
                                   Individuo.APELLIDO2,
                                   Individuo.FECHANAC,
                                   Individuo.GENERO,
                                   Individuo.NACIONALIDAD,
                                   'ARG', (*CODIGO DE PAIS*)
                                   Individuo.PASO);
        if str.codigoError > -1 then   // ES ERROR MIO (O SEA DE DNM ARG)
        begin
          insertarLog('COL', Individuo, '', str.codigoError, str.codigoRespuesta,-1);

          IF str.codigoRespuesta > 1 THEN
            Resultado := StrCOL2resultadoConsulta(Individuo); //Si hubo coincidencia en el ws de COLOMBIA
        end
        else
          Error := True;
      end
      else
      begin
        Individuo.TIPODOC := 'P';
        str := (HTTPRIO1 as AlianzaArgentinaService).consultarPersona(Individuo.TIPODOC,
                                   Individuo.NUMDOC,
                                   Individuo.EMISORDOC,
                                   Individuo.NUMEROIDENIFICACION,
                                   Individuo.NOMBRE1,
                                   Individuo.NOMBRE2,
                                   Individuo.APELLIDO1,
                                   Individuo.APELLIDO2,
                                   Individuo.FECHANAC,
                                   Individuo.GENERO,
                                   Individuo.NACIONALIDAD,
                                   'ARG', (*CODIGO DE PAIS*)
                                   Individuo.PASO);

        if str.codigoError > -1 then   // ES ERROR MIO (O SEA DE DNM ARG)
        begin
          insertarLog('COL', Individuo, '', str.codigoError, str.codigoRespuesta,-1);
          case str.codigoRespuesta of
            1 : begin
                   Individuo.TIPODOC := 'ID';
                   str := (HTTPRIO1 as AlianzaArgentinaService).consultarPersona(Individuo.TIPODOC,
                                                   Individuo.NUMDOC,
                                                   Individuo.EMISORDOC,
                                                   Individuo.NUMEROIDENIFICACION,
                                                   Individuo.NOMBRE1,
                                                   Individuo.NOMBRE2,
                                                   Individuo.APELLIDO1,
                                                   Individuo.APELLIDO2,
                                                   Individuo.FECHANAC,
                                                   Individuo.GENERO,
                                                   Individuo.NACIONALIDAD,
                                                   'ARG', (*CODIGO DE PAIS*)
                                                   Individuo.PASO);

                    if str.codigoError > -1 then   // ES ERROR MIO (O SEA DE DNM ARG)
                    begin
                      insertarLog('COL', Individuo, '', str.codigoError, str.codigoRespuesta,-1);
                      if str.codigoRespuesta > 1 then
                        Resultado := StrCOL2resultadoConsulta(Individuo); //Si hubo coincidencia en el ws de COLOMBIA
                    end
                    else
                      Error := True;
                end;
            2 : begin
                  Resultado := StrCOL2resultadoConsulta(Individuo); //Si hubo coincidencia en el ws de COLOMBIA
                end;
          end;
        end
        else
          Error := True;

      end;
      FreeAndNil(HTTPRIO1);
    except
      Error := True;
    end;
  end;
end;




function TSqlOracle.StrCOL2resultadoConsulta(Individuo: Persona): ResultadoConsulta;
var
  tempfecha: String;
  i, j : Integer;
begin
      SetLength(Result,1);
      I:=0;
      Result[i]:= Restriccion.Create;

      Result[i].FUENTE                :=  'COL';

      Result[i].DESC_TIPO_DOC         :=  '';

      if iNDIVIDUO.TIPODOC <> '' then
        Result[i].DOCTIPO               :=  iNDIVIDUO.TIPODOC
      else
        Result[i].DOCTIPO               :=  '';

      if iNDIVIDUO.NUMDOC <> '' then
          Result[i].NUM_DOC:= iNDIVIDUO.NUMDOC
      else
        Result[i].NUM_DOC:=   '';

      Result[i].PAIS_EMISOR_DOC       :=  'COLOMBIA';
      if iNDIVIDUO.APELLIDO1 <> '' then
        Result[i].APELLIDO              :=  iNDIVIDUO.APELLIDO1;
      if iNDIVIDUO.APELLIDO2 <> '' then
        Result[i].APELLIDO2             :=  iNDIVIDUO.APELLIDO2;
      if iNDIVIDUO.NOMBRE1 <> '' then
        Result[i].NOMBRE             :=  iNDIVIDUO.NOMBRE1;
      if iNDIVIDUO.NOMBRE2 <> '' then
        Result[i].NOMBRE2  :=  iNDIVIDUO.NOMBRE2;
      Result[i].NACIONALIDAD          :=  'COLOMBIANA';

      if iNDIVIDUO.FECHANAC <> '' then
          Result[i].FECHA_NAC := iNDIVIDUO.FECHANAC;



      (*Ver el tema del sexo*)
      Result[i].SEXO                :=  iNDIVIDUO.GENERO;
      Result[i].DESC_TIPO_RESTRICCION :=  'ALERTAS';   (*VERRRRRRRRRRRRRRRR*)

      Result[i].EXPED_DNM             :=  '';
      Result[i].DESC_RESTRICCION      :=  'ALERTAS COLOMBIA' ; (* VER*)

      Result[i].DESC_CAUSA            :=  '';
      Result[i].DESC_INSTRUCCION      :=  '';
      Result[i].DESC_TIPO_JUSTICIA    :=  'ALERTAS';
      Result[i].DESC_PROVINCIA        :=  '';
      Result[i].DESC_JUZGADOS         :=  'MIGRACION COLOMBIA';
      Result[i].DESC_LOCALIDAD        :=  '';

      Result[i].JUZGADO               :=  '';
      Result[i].SECRETARIA            :=  '';
      Result[i].SALA                  :=  '';
      Result[i].DESTINO               :=  '';
      Result[i].FECHA_DESDE           :=  '';
      Result[i].FECHA_HASTA           :=  '';
      Result[i].FEC_RECEP_DNM         :=  '';
      Result[i].DESC_ENTIDAD          :=  'MIGRACION';
      Result[i].NRO_DISPO             :=  '';
      Result[i].NRO_NOTA              :=  '';
      Result[i].ACTA                  :=  '';
      Result[i].DESC_DELEGACION       :=  '';
      Result[i].FECHA_SALIDA          :=  '';
      Result[i].FECHA_BAJA            :=  '';
      //Result[i].OBSERVACIONES         :=  'COMUNIQUESE CON LA D.I.M.';
      //Result[i].OBSERVACIONES         :=  UpperCase('Previo a autorizar el ingreso al Territorio Nacional, comunicarse al Departamento de Informacion, Asistencia y Cooperacion (DIAC) a los telefonos 011-4874-2323 o 011-4874-2324');
      Result[i].OBSERVACIONES         :=  UpperCase('Previo a autorizar el Movimiento Migratorio, comunicarse al Departamento de Informaci�n, Asistencia y Cooperaci�n (DIAC) a los tel�fonos 011-4874-2323 o 011-4874-2324');

      Result[i].FOTO                  :=  '';
end;



function TSqlOracle.consultoProfiles(Individuo: Persona; sentido: string) : boolean;
var edad : string;
begin
   Result := false;
   with  OraQuery do
   begin
     close;
     sql.Clear;
     sql.LoadFromFile('.\Perfiles_dnm.sql');
     parambyname('unEmisorDoc').asstring:=Individuo.EMISORDOC;
     edad :=  inttostr(trunc(MonthsBetween(now, strtodate(Individuo.FECHANAC))/12));
     parambyname('edad').asstring:=edad;
     parambyname('unaNacionalidad').asstring:=Individuo.NACIONALIDAD;
     parambyname('unSentido').asstring:=sentido;
     open;
     if not IsEmpty then
        Result := True;
   end;
end;





procedure TSqlOracle.ConsultaPRF(
  Individuo: Persona;
  var Resultado: ResultadoConsulta;
  var Error: Boolean);

var sentido,Straux  :string;
    j,i,ii:integer;


begin
  try
    Error:= false;

    Straux :='';
    j:=0;
    i:=0;
    ii:=0;
    Straux :=Individuo.OPERADOR;
    While (i <= length(Individuo.OPERADOR))  do
    begin
      if (Individuo.OPERADOR[i] = '-') then
      begin
        case j of
          5: sentido:=copy(Straux,1, ii-1 );
        end;
        ii:=0;
        Straux := copy(Individuo.OPERADOR, i+1, length(Individuo.OPERADOR));
        j:=j+1;
      end;
      ii:=ii+1;
      i:= i+1;
    end;
    if consultoProfiles(Individuo, sentido) then
      Resultado:=  StrPROFILEresultadoConsulta(Individuo);
  except
    Error:= true;
  end;
end;



function TSqlOracle.StrPROFILEresultadoConsulta(Individuo: Persona): ResultadoConsulta;
var
  tempfecha: String;
  i, j : Integer;
begin
      SetLength(Result,1);
      I:=0;
      Result[i]:= Restriccion.Create;

      Result[i].FUENTE                :=  'PRF';

      Result[i].DESC_TIPO_DOC         :=  '';

      if iNDIVIDUO.TIPODOC <> '' then
        Result[i].DOCTIPO               :=  iNDIVIDUO.TIPODOC
      else
        Result[i].DOCTIPO               :=  '';

      if iNDIVIDUO.NUMDOC <> '' then
          Result[i].NUM_DOC:= iNDIVIDUO.NUMDOC
      else
        Result[i].NUM_DOC:=   '';

      Result[i].PAIS_EMISOR_DOC       :=  ''; // se lo saque yo (JPB), Colombia lo tiene
      if iNDIVIDUO.APELLIDO1 <> '' then
        Result[i].APELLIDO              :=  iNDIVIDUO.APELLIDO1;
      if iNDIVIDUO.APELLIDO2 <> '' then
        Result[i].APELLIDO2             :=  iNDIVIDUO.APELLIDO2;
      if iNDIVIDUO.NOMBRE1 <> '' then
        Result[i].NOMBRE             :=  iNDIVIDUO.NOMBRE1;
      if iNDIVIDUO.NOMBRE2 <> '' then
        Result[i].NOMBRE2  :=  iNDIVIDUO.NOMBRE2;
      Result[i].NACIONALIDAD          :=  Individuo.NACIONALIDAD; // 'COLOMBIANA';

      if iNDIVIDUO.FECHANAC <> '' then
          Result[i].FECHA_NAC := iNDIVIDUO.FECHANAC;

      (*Ver el tema del sexo*)
      Result[i].SEXO                :=  iNDIVIDUO.GENERO;
      Result[i].DESC_TIPO_RESTRICCION :=  'ALERTAS';

      Result[i].EXPED_DNM             :=  '';
      Result[i].DESC_RESTRICCION      :=  'PERFIL DE INTERES';

      Result[i].DESC_CAUSA            :=  '';
      Result[i].DESC_INSTRUCCION      :=  '';
      Result[i].DESC_TIPO_JUSTICIA    :=  'ALERTAS';
      Result[i].DESC_PROVINCIA        :=  '';
      Result[i].DESC_JUZGADOS         :=  'DNM';
      Result[i].DESC_LOCALIDAD        :=  '';
      Result[i].JUZGADO               :=  '';
      Result[i].SECRETARIA            :=  '';
      Result[i].SALA                  :=  '';
      Result[i].DESTINO               :=  '';
      Result[i].FECHA_DESDE           :=  '';
      Result[i].FECHA_HASTA           :=  '';
      Result[i].FEC_RECEP_DNM         :=  '';
      Result[i].DESC_ENTIDAD          :=  'DNM';
      Result[i].NRO_DISPO             :=  '';
      Result[i].NRO_NOTA              :=  '';
      Result[i].ACTA                  :=  '';
      Result[i].DESC_DELEGACION       :=  '';
      Result[i].FECHA_SALIDA          :=  '';
      Result[i].FECHA_BAJA            :=  '';
      //Result[i].OBSERVACIONES         :=  'COMUNIQUESE CON LA D.I.M.';
      //Result[i].OBSERVACIONES         :=  UpperCase('Previo a autorizar el Ingreso/egreso al/del Territorio Nacional, comunicarse al DIAC a los telefonos 011-4874-2323 o 011-4874-2324');
      //Result[i].OBSERVACIONES         :=    UpperCase('Tomar contacto con INTERPOL al tel: 011-43465753 / Cel 011-1545280662 o 011-1531970914 - poseen whatsapp. Adem�s enviar mail a cnc@interpol.gov.ar.');
      Result[i].OBSERVACIONES         :=    UpperCase('Sujeto con perfil seleccionado. Deber� ajustarse a las instrucciones impartidas en la circular vigente.');
      Result[i].FOTO                  :=  ''; // Color de la restriccion
end;



function TSqlOracle.consultoPorAPENOMyFECHANAC(Individuo: Persona) : boolean;
var AUX_apellido : string;
begin
  Result := false;
  with  oraQuery2 do
  begin

    close;
    sql.Clear;
    sql.LoadFromFile('.\FPE_PorApeNomyfechaNac.sql');

    if Individuo.APELLIDO2 <> '' then
      AUX_apellido := trim(Individuo.APELLIDO1) + ' ' +trim(Individuo.APELLIDO2)
    else
      AUX_apellido := trim(Individuo.APELLIDO1);

    //Prepared:= true;

    parambyname('apellido').Value:=AUX_apellido;
    parambyname('nombre').Value:=trim(Individuo.NOMBRE1);
    parambyname('fecha').Value:= Individuo.FECHANAC;  //copy(Individuo.FECHANAC,7,4)+'-'+copy(Individuo.FECHANAC,4,2)+'-'+copy(Individuo.FECHANAC,1,2);

    open;
    if not IsEmpty then
       Result := True;
  end;
end;


function TSqlOracle.consultoPorDOC(doc, emisor_doc: string) : boolean;
begin
  Result := false;
  with  oraQuery2 do
  begin
    close;
    sql.Clear;
    sql.LoadFromFile('.\FPE_porDOC.sql');
    Prepared:= true;
    parambyname('Nro_doc').Value:=doc;
    parambyname('unPaisEmisor').Value:=emisor_doc;
    open;
    if not IsEmpty then
      Result := True;
  end;
end;

procedure TSqlOracle.conectarASQLServer(var paso: string);
begin

 
  OraSession2 := TOraSession.Create(nil);
  //connect2('APISQL_FPE_USR', 'usrfpeapisql', uglobal.serverAPI);
  connect2('APISQL', 'APISQL', uglobal.serverAPI);
  if OraSession2.Connected then
  begin
    oraQuery2 := TOraQuery.Create(nil);
    oraQuery2.Session := OraSession2;
  end;


   { ADOConnection1 :=  TADOConnection.create(nil);
    ADOConnection1.IsolationLevel :=  ilReadCommitted;
    ADOConnection1.LoginPrompt := false;
    ADOConnection1.Mode := cmRead;
    ADOConnection1.Provider:='SQLOLEDB.1';
    ADOConnection1.ConnectionString := 'Provider=SQLOLEDB.1;Password=userapi;Persist Security Info=True;User ID=apiuser;Initial Catalog=ATSG;Data Source='+serverAPI+';Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID= ;Use Encryption for Data=False;Tag with column collation when possible=False';
    ADOConnection1.Connected := true;
    ADOQuery1 := TADOQuery.Create(nil);
    ADOQuery1.Connection := ADOConnection1;   }
end;



procedure TSqlOracle.ConsultaFPE(
  Individuo: Persona;
  var Resultado: ResultadoConsulta;
  var Error: Boolean);
  var paso, inicio: string;

begin
  try
    Error:= false;

    conectarASQLServer(paso);
    inicio := formatdatetime('dd/mm/yyyy HH:mm:ss',now);
    if consultoPorAPENOMyFECHANAC(Individuo) then
    begin
      Resultado:=  StrFPEresultadoConsulta(Individuo);
      ForceDirectories('.\'+formatdatetime('yyyy',now)+'\'+formatdatetime('mm',now)+'\'+formatdatetime('dd',now));
      generarTxT2('.\'+formatdatetime('yyyy',now)+'\'+formatdatetime('mm',now)+'\'+formatdatetime('dd',now)+'\logProcesoHSPD6.txt',formatdatetime('dd/mm/yyyy HH:mm:ss',now)+' - '+ UpperCase(Individuo.NUMDOC)+' - '+UpperCase(Individuo.FECHANAC)+' - '+  UpperCase(Individuo.APELLIDO1)+' '+ UpperCase(Individuo.NOMBRE1)+' - '+ UpperCase(Individuo.PASO))
    end
    else
    begin
      if consultoPorDOC(Individuo.NUMDOC, Individuo.EMISORDOC) then
      begin

        Resultado:=  StrFPEresultadoConsulta(Individuo);
        ForceDirectories('.\'+formatdatetime('yyyy',now)+'\'+formatdatetime('mm',now)+'\'+formatdatetime('dd',now));
        generarTxT2('.\'+formatdatetime('yyyy',now)+'\'+formatdatetime('mm',now)+'\'+formatdatetime('dd',now)+'\logProcesoHSPD6.txt',formatdatetime('dd/mm/yyyy HH:mm:ss',now)+' - '+ UpperCase(Individuo.NUMDOC)+' - '+UpperCase(Individuo.FECHANAC)+' - '+  UpperCase(Individuo.APELLIDO1)+' '+ UpperCase(Individuo.NOMBRE1)+' - '+ UpperCase(Individuo.PASO))
      end
      else
      begin
        if uppercase(Individuo.EMISORDOC) <> 'DEU' then  // jpb - se saca a pedido de control la consulta por libreta para documnetos Alemanes
        begin
          if consultoPorDOC(Individuo.NUMEROIDENIFICACION, Individuo.EMISORDOC ) then
          begin
            Resultado:=  StrFPEresultadoConsulta(Individuo);
            ForceDirectories('.\'+formatdatetime('yyyy',now)+'\'+formatdatetime('mm',now)+'\'+formatdatetime('dd',now));
            generarTxT2('.\'+formatdatetime('yyyy',now)+'\'+formatdatetime('mm',now)+'\'+formatdatetime('dd',now)+'\logProcesoHSPD6.txt',formatdatetime('dd/mm/yyyy HH:mm:ss',now)+' - '+ UpperCase(Individuo.NUMDOC)+' - '+UpperCase(Individuo.FECHANAC)+' - '+  UpperCase(Individuo.APELLIDO1)+' '+ UpperCase(Individuo.NOMBRE1)+' - '+ UpperCase(Individuo.PASO))
          end;
        end;
      end;
    end;
    //generarTxT2('.\logHSPD6.txt','INICIO:' + ' - ' + incio + ' - ' + 'FIN:' + formatdatetime('dd/mm/yyyy HH:mm:ss',now)+' - '+ UpperCase(Individuo.NUMDOC)+' - '+UpperCase(Individuo.FECHANAC)+' - '+  UpperCase(Individuo.APELLIDO1)+' '+ UpperCase(Individuo.NOMBRE1)+' - '+ UpperCase(Individuo.PASO) + ' - ' + e.Message);
  except
    on e: exception do
    begin
      Error:= true;
      generarTxT2('.\logErrorHSPD6.txt',formatdatetime('dd/mm/yyyy HH:mm:ss',now)+' - '+ UpperCase(Individuo.NUMDOC)+' - '+UpperCase(Individuo.FECHANAC)+' - '+  UpperCase(Individuo.APELLIDO1)+' '+ UpperCase(Individuo.NOMBRE1)+' - '+ UpperCase(Individuo.PASO) + ' - ' + e.Message);
      {ForceDirectories('.\'+formatdatetime('yyyy',now)+'\'+formatdatetime('mm',now)+'\'+formatdatetime('dd',now));
      generarTxT2('.\'+formatdatetime('yyyy',now)+'\'+formatdatetime('mm',now)+'\'+formatdatetime('dd',now)+'\logProcesoAPI.txt',formatdatetime('dd/mm/yyyy HH:mm:ss',now)+' - '+ UpperCase(Individuo.NUMDOC)+' - '+UpperCase(Individuo.FECHANAC)+' - '+  UpperCase(Individuo.APELLIDO1)+' '+ UpperCase(Individuo.NOMBRE1));}
    end
  end;
end;





function TSqlOracle.StrFPEresultadoConsulta(Individuo: Persona): ResultadoConsulta;


var
  tempfecha: String;
  i, j : Integer;

  color : string;


  (* estas dos variables se reeplazan por la clase del Ws de los Colombianos!  *)
  CodRespuesta, codDetalleRespuesta: integer;


  restriccionesNoArgentinas : integer;
begin

    with oraQuery2 do
    begin



      First;
      restriccionesNoArgentinas := 0 ;
      for i := 0 to RecordCount - 1 do
      begin
        if (fieldbyname('nacionalidad').asstring <> 'ARGENTINA') then
          restriccionesNoArgentinas := restriccionesNoArgentinas+1;
        next;
      end;

      SetLength(Result,restriccionesNoArgentinas);

      First;

      J := 0;

      for i := 0 to RecordCount - 1 do
      begin
        if (fieldbyname('nacionalidad').asstring <> 'ARGENTINA') and ( j < restriccionesNoArgentinas) then
        begin
          Result[j]:= Restriccion.Create;
          Result[j].FUENTE                :=  'FPE';
          Result[j].DESC_TIPO_DOC         :=  '';
          if fieldbyname('type').asstring <> '' then
          begin
            Result[j].DOCTIPO :=  fieldbyname('type').asstring;
            Result[j].NUM_DOC := iNDIVIDUO.NUMDOC;
          end
          else
          begin
            Result[j].DOCTIPO:=  '';
            Result[j].NUM_DOC:= '';
          end;
          if fieldbyname('PAIS_DOCUMENTO').asstring <> '' then
            Result[j].PAIS_EMISOR_DOC       :=fieldbyname('PAIS_DOCUMENTO').asstring
          else
              Result[j].PAIS_EMISOR_DOC       :='';
          if fieldbyname('lastname').asstring <> '' then
            Result[j].APELLIDO              :=  fieldbyname('lastname').asstring ;
          if fieldbyname('firstname').asstring <> ''then
            Result[j].NOMBRE             :=  fieldbyname('firstname').asstring;
          if fieldbyname('middlename').asstring <> '' then
            Result[j].NOMBRE2  :=  fieldbyname('middlename').asstring;
          Result[j].NACIONALIDAD          :=  fieldbyname('nacionalidad').asstring;
          if not fieldbyname('dob').IsNull then
              Result[j].FECHA_NAC :=  fieldbyname('dob').asstring    //    copy(fieldbyname('dob').asstring,9,2)+'/'+copy(fieldbyname('dob').asstring,6,2)+'/'+copy(fieldbyname('dob').asstring,1,4)
          else
            Result[j].FECHA_NAC :='';
          (*Ver el tema del sexo*)
          Result[j].SEXO                :=  iNDIVIDUO.GENERO;
          Result[j].DESC_TIPO_RESTRICCION :=  'ALERTAS';
          Result[j].EXPED_DNM             :=  '';
          Result[j].DESC_RESTRICCION      :=  UpperCase('Novedad IMR 181')  ;
          Result[j].DESC_CAUSA            :=  '';
          Result[j].DESC_INSTRUCCION      :=  '';
          Result[j].DESC_TIPO_JUSTICIA    :=  'ALERTAS';
          Result[j].DESC_PROVINCIA        :=  '';
          Result[j].DESC_JUZGADOS         :=  UpperCase('Novedad IMR 181');
          Result[j].DESC_LOCALIDAD        :=  '';
          Result[j].JUZGADO               :=  '';
          Result[j].SECRETARIA            :=  '';
          Result[j].SALA                  :=  '';
          Result[j].DESTINO               :=  '';
          Result[j].FECHA_DESDE           :=  '';
          Result[j].FECHA_HASTA           :=  '';
          Result[j].FEC_RECEP_DNM         :=  '';
          Result[j].DESC_ENTIDAD          :=  UpperCase('Novedad IMR 181');
          Result[j].NRO_DISPO             :=  '';
          Result[j].NRO_NOTA              :=  '';
          Result[j].ACTA                  :=  '';
          Result[j].DESC_DELEGACION       :=  '';
          Result[j].FECHA_SALIDA          :=  '';
          Result[j].FECHA_BAJA            :=  '';
          Result[j].OBSERVACIONES         :=  UpperCase('No alertar al pasajero - Dar aviso inmediato al DIAC (011) 4874-2323 / 4874-2324 - Novedad IMR 181. Invocar FPE ID: '+fieldbyname('FpeId').asstring);
          Result[j].FOTO                  :=  ''; // Color de la restriccion
          j:=j+1;
        end;
        Next;

      end;
      if not yaloconsulte(Individuo, 'FPE', CodRespuesta, codDetalleRespuesta, color) then
        insertarLog('FPE',Individuo,'ROJO',0,2,-1);
    end;
end;


//ConsultaINT       (*jpb INT - 20160610*);

procedure TSqlOracle.ConsultaINT(
  Individuo: Persona;
  var Resultado: ResultadoConsulta;
  var Error: Boolean);
var ws : IpuenteInterpol;
    cons : datosConsultaInterpol;
    res : respuestaInterpol;
    Straux : string;

    I,J,ii : integer;

    rta, detalle_rta : integer;
    color: string;

    tiempo: integer;
    fechaini, fechafin : Tdatetime;

    docAux : string;
    docIdenAux : string;

  function dateOtravuelta(unafecha: string): string;
  begin
    result := copy(unafecha,7,4)+Copy(unafecha,4,2)+copy(unafecha,1,2);
  end;

begin
  try
    res:= respuestaInterpol.Create;
    error := False;

    if (Individuo.EMISORDOC = 'CHL') and (Individuo.TIPODOC = 'ID') and (Individuo.NUMEROIDENIFICACION <> '') then
    begin
      docIdenAux := Individuo.NUMEROIDENIFICACION;
      docAux := Individuo.NUMDOC;
      Individuo.NUMDOC := Individuo.NUMEROIDENIFICACION;
      Individuo.NUMEROIDENIFICACION := docAux;
    end;




    cons := datosConsultaInterpol.Create;

    cons.nombre := trim(Individuo.NOMBRE1);
    if trim(Individuo.NOMBRE2) <> '' then
      cons.nombre := cons.nombre +' '+ trim(Individuo.NOMBRE2);

    cons.apellido:=trim(Individuo.APELLIDO1);
    if trim(Individuo.APELLIDO2) <> '' then
      cons.apellido := cons.apellido +' '+ trim(Individuo.APELLIDO2);

    cons.fechaNacimiento:= dateOtravuelta(Individuo.FECHANAC) ;
    if Copy(Individuo.TIPODOC, 1,1 ) = 'P' then
      cons.tipoDoc:='P'
    else
      cons.tipoDoc:='I';
    cons.nroDoc:=Individuo.NUMDOC ;

    if uppercase(Individuo.EMISORDOC) = 'DEU' Then  // Nac o Pais emisor
    begin
        cons.pais := 'D';
    end
    else
    begin
      cons.pais:=Individuo.EMISORDOC;
    end;

    cons.genero:=Individuo.GENERO;

    Straux :='';
    j:=0;
    i:=0;
    ii:=0;
    Straux :=Individuo.OPERADOR;
    While (i <= length(Individuo.OPERADOR))  do
    begin

      if (Individuo.OPERADOR[i] = '-') then
      begin
        case j of
          0: cons.usuario:=copy(Straux,1, ii-1 );
          1: cons.usuarioDoc:=copy(Straux,1, ii-1 );
          2: cons.usuarioApellido:=copy(Straux,1, ii-1 );
          3: cons.usuarioNombre:=copy(Straux,1, ii-1 );
          4: cons.usuarioJerarquia:=copy(Straux,1, ii-1 );
          5: cons.transito:=copy(Straux,1, ii-1 );

        end;
        ii:=0;
        Straux := copy(Individuo.OPERADOR, i+1, length(Individuo.OPERADOR));
        j:=j+1;
      end;
      ii:=ii+1;
      i:= i+1;
    end;
    //cons.usuarioDepenId:=copy(Straux,1, ii-1 );
    cons.usuarioDepenId:='';



    cons.usuarioDepen:=Individuo.PASO;
    cons.usuarioTipoDoc:='DNI';
    cons.usuarioIp:='200.45.226.1';

    if yaloconsulte(Individuo,'XPO',rta, detalle_rta, color) then
    begin
      if (rta = 2) or  (UpperCase( DesdeDondeLlamamos) = 'WWW') then
          Resultado := StrINT2resultadoConsulta(Individuo, color); //Si hubo coincidencia en el ws de COLOMBIA

    end
    else
    begin



      ws:= GetIpuenteInterpol(false,UGLOBAL.wSInterpol );

      fechaini := now;
      res:= ws.ConsultaInterpol(cons);
      fechafin := now;

      tiempo:= MilliSecondsBetween(fechaini, fechafin);

      { Simulo un ROJO 
      res.COD_DETALLE_RTA := '0';
      res.COD_RTA := '2';
      res.COLOR := 'ROJO';   }

      if strtoint(res.COD_DETALLE_RTA) > -1 then
      begin
        insertarLog('XPO', Individuo, res.COLOR, strtoint(res.COD_DETALLE_RTA), strtoint(res.COD_RTA),tiempo);
        IF (strtoint(res.COD_RTA) > 1) or (UpperCase( DesdeDondeLlamamos) = 'WWW') THEN
          Resultado := StrINT2resultadoConsulta(Individuo, res.COLOR); //Si hubo coincidencia en el ws de COLOMBIA
      end
      else
      begin
        Error := True;
        insertarLog('XPO', Individuo, 'ERROR', 1, -1000, tiempo);
        if (UpperCase( DesdeDondeLlamamos) = 'WWW') THEN
          Resultado := StrINT2resultadoConsulta(Individuo, 'ERROR');
      end;
    end;
  except
      Error := true;
      insertarLog('XPO', Individuo, 'ERROR', 2,-1000,-1);
      if (UpperCase( DesdeDondeLlamamos) = 'WWW') THEN
        Resultado := StrINT2resultadoConsulta(Individuo, 'ERROR');
  end
end;



function TSqlOracle.RequiereDoblecontrol( unaNacionalidad, unEmisorDoc: string ) : boolean;
begin
   Result := false;
   with  OraQuery do
   begin
    close;
    sql.Clear;
    sql.Add(  'select doble_Control '+
              'from catalogos.cat_paises '+
              'where '+
              'codigo = UPPER(:unaNacionalidad)  '+
              ' UNION ALL '+ 
              'select doble_Control '+
              'from catalogos.cat_paises '+
              'where '+
              'codigo = UPPER(:unEmisorDoc) '+
              ' ORDER BY 1 DESC '
           );
    parambyname('unEmisorDoc').asstring:=unEmisorDoc;
    parambyname('unaNacionalidad').asstring:=unaNacionalidad;
    open;
    if not IsEmpty then
    begin
      First;
      Result := LowerCase(fieldbyname('doble_Control').asstring) = 't';
    end
   end;
end;



function TSqlOracle.StrINT2resultadoConsulta(Individuo: Persona; color : string): ResultadoConsulta;
var
  tempfecha: String;
  i, j : Integer;
begin
      SetLength(Result,1);
      I:=0;
      Result[i]:= Restriccion.Create;

      Result[i].FUENTE                :=  'XPO';

      Result[i].DESC_TIPO_DOC         :=  '';

      if iNDIVIDUO.TIPODOC <> '' then
        Result[i].DOCTIPO               :=  iNDIVIDUO.TIPODOC
      else
        Result[i].DOCTIPO               :=  '';

      if iNDIVIDUO.NUMDOC <> '' then
          Result[i].NUM_DOC:= iNDIVIDUO.NUMDOC
      else
        Result[i].NUM_DOC:=   '';

      Result[i].PAIS_EMISOR_DOC       :=  ''; // se lo saque yo (JPB), Colombia lo tiene
      if iNDIVIDUO.APELLIDO1 <> '' then
        Result[i].APELLIDO              :=  iNDIVIDUO.APELLIDO1;
      if iNDIVIDUO.APELLIDO2 <> '' then
        Result[i].APELLIDO2             :=  iNDIVIDUO.APELLIDO2;
      if iNDIVIDUO.NOMBRE1 <> '' then
        Result[i].NOMBRE             :=  iNDIVIDUO.NOMBRE1;
      if iNDIVIDUO.NOMBRE2 <> '' then
        Result[i].NOMBRE2  :=  iNDIVIDUO.NOMBRE2;
      Result[i].NACIONALIDAD          :=  Individuo.NACIONALIDAD; // 'COLOMBIANA';

      if iNDIVIDUO.FECHANAC <> '' then
          Result[i].FECHA_NAC := iNDIVIDUO.FECHANAC;



      (*Ver el tema del sexo*)
      Result[i].SEXO                :=  iNDIVIDUO.GENERO;
      Result[i].DESC_TIPO_RESTRICCION :=  'ALERTAS';

      Result[i].EXPED_DNM             :=  '';
      Result[i].DESC_RESTRICCION      :=  'ALERTAS INTERPOL - CIRCULAR '+UpperCase(Color) ;

      Result[i].DESC_CAUSA            :=  '';
      Result[i].DESC_INSTRUCCION      :=  '';
      Result[i].DESC_TIPO_JUSTICIA    :=  'ALERTAS';
      Result[i].DESC_PROVINCIA        :=  '';
      Result[i].DESC_JUZGADOS         :=  'INTERPOL';
      Result[i].DESC_LOCALIDAD        :=  '';

      Result[i].JUZGADO               :=  '';
      Result[i].SECRETARIA            :=  '';
      Result[i].SALA                  :=  '';
      Result[i].DESTINO               :=  '';
      Result[i].FECHA_DESDE           :=  '';
      Result[i].FECHA_HASTA           :=  '';
      Result[i].FEC_RECEP_DNM         :=  '';
      Result[i].DESC_ENTIDAD          :=  'INTERPOL';
      Result[i].NRO_DISPO             :=  '';
      Result[i].NRO_NOTA              :=  '';
      Result[i].ACTA                  :=  '';
      Result[i].DESC_DELEGACION       :=  '';
      Result[i].FECHA_SALIDA          :=  '';
      Result[i].FECHA_BAJA            :=  '';
      //Result[i].OBSERVACIONES         :=  'COMUNIQUESE CON LA D.I.M.';
      //Result[i].OBSERVACIONES         :=  UpperCase('Previo a autorizar el Ingreso/egreso al/del Territorio Nacional, comunicarse al DIAC a los telefonos 011-4874-2323 o 011-4874-2324');

      if UpperCase(color) <> ('VERDE') then
      begin
        if  RequiereDoblecontrol(Individuo.NACIONALIDAD, Individuo.EMISORDOC) then
          Result[i].OBSERVACIONES         :=    UpperCase('Enviar email a cnc@interpol.gov.ar con copia a DIAC@migraciones.gov.ar - Resolver solo con la respuesta del DIAC')
        else
          Result[i].OBSERVACIONES         :=    UpperCase('Tomar contacto con INTERPOL al tel: 011-43465753 / Cel 011-1545280662 o 011-1531970914 - poseen whatsapp. Ademas enviar email a cnc@interpol.gov.ar.');
      end
      else
      begin
          Result[i].OBSERVACIONES         := '';
      end;

      Result[i].FOTO                  :=  ''; // Color de la restriccion
end;



//FIN Interpol





function TSqlOracle.dameNombreApellidosYfechas(individuo: XML_CONSULTA_NEW): integer;
var consulta : AnsiString;
    parametros : integer;
begin
  Result :=0;
  try
    with OraQuery do
    begin
      parametros :=0;
      Close;
      SQL.CLEAR;
      sql.LoadFromFile('.\restri.sql');
      consulta := sql.Text;
      consulta := consulta + ' where fecha_nac = to_date(:unaFechaNac,''dd/mm/yyyy'') '+
                             ' and apellido = :unApellido '+
                             ' and nombre = :unNombre';

     { if (Individuo.APELLIDO2 <> '')  and (individuo.NOMBRE2 <> '') then
      begin
        parametros :=4;
        consulta := consulta + ' and Apellido2 LIKE :unApellido2 ||''%'' ';
        consulta := consulta + ' and nombre2 like :unNombre2 ||''%'' ';
      end
      else
      begin

        if (Trim(Individuo.APELLIDO2) <> '')  then
        begin
          parametros :=5;
          consulta := consulta + ' and Apellido2 LIKE :unApellido2 ||''%'' ';
          //consulta := consulta + ' and nombre2 is null' ;
        end ;
        {else
        begin
          IF (Trim(individuo.NOMBRE2) <> '') then
          begin
            parametros :=6;
            //consulta := consulta + ' and Apellido2 is null';
            consulta := consulta + ' and nombre2 like :unNombre2 ||'+'%';
          end;
          //else
            //consulta := consulta + ' and Apellido2 is null and  nombre2 is null ';
        end;

         IF (Trim(individuo.NOMBRE2) <> '') then
          begin
            parametros :=6;
            //consulta := consulta + ' and Apellido2 is null';
            consulta := consulta + ' and nombre2 like :unNombre2 ||''%'' ';
          end;
      end;         }


      sql.Clear;
      sql.Add(consulta);
      ParamByName('unApellido').value := Individuo.APELLIDO1;
      ParamByName('unNombre').Value := individuo.NOMBRE1;
      ParamByName('unaFechaNac').Value := individuo.FECHANAC;
     { case parametros of

        4 : begin
              ParamByName('unApellido2').value := Individuo.APELLIDO2;
              ParamByName('unNombre2').value := Individuo.NOMBRE2;
            end;
        5 : begin
              ParamByName('unApellido2').value := Individuo.APELLIDO2;
            end;
        6 : begin
              ParamByName('unNombre2').value := Individuo.NOMBRE2;
            end;
      end;       }

      Open;
      //sql.SaveToFile('.\PRUEBA-dameNombreApellidosYfechas-V2.txt');
      Result := fieldbyname('total').AsInteger;
    end;
  except
    Result := -1;
  end;
end;





function TSqlOracle.dameNombreApellidosYdoc(NumDoc, apellido1,apellido2, nombre1, nombre2 : string): integer;
var consulta : AnsiString;
    parametros : integer;
begin
  Result :=0;
  try
    with OraQuery do
    begin
      parametros :=0;
      Close;
      sql.Clear;
      sql.LoadFromFile('.\restri.sql');
      consulta := sql.Text;
      consulta := consulta + ' where NUM_DOC = :unNumDoc ';//+
                             //' and apellido = :unApellido '+
                             //' and nombre = :unNombre';


    {  if (APELLIDO2 <> '')  and (NOMBRE2 <> '') then
      begin
        parametros :=4;
        consulta := consulta + ' and Apellido2 LIKE :unApellido2 ||''%'' ';
        consulta := consulta + ' and nombre2 LIKE :unNombre2 ||''%'' ';
      end
      else
      begin
        if (Trim(APELLIDO2) <> '')  then
        begin
          parametros :=5;
          consulta := consulta + ' and Apellido2 LIKE :unApellido2 ||''%'' ';
          //consulta := consulta + ' and nombre2 is null' ;
        end;
        {else
        begin
          IF (Trim(NOMBRE2) <> '') then
          begin
            parametros :=6;
            //consulta := consulta + ' and Apellido2 is null';
            consulta := consulta + ' and nombre2 LIKE :unNombre2 ||''%'' ';
          end;
          //else
            //consulta := consulta + ' and Apellido2 is null and  nombre2 is null ';
        end;

        IF (Trim(NOMBRE2) <> '') then
          begin
            parametros :=6;
            //consulta := consulta + ' and Apellido2 is null';
            consulta := consulta + ' and nombre2 LIKE :unNombre2 ||''%'' ';
          end;


      end;   }


      sql.Clear;
      sql.Add(consulta);
      //ParamByName('unApellido').value := APELLIDO1;
      //ParamByName('unNombre').Value := NOMBRE1;
      ParamByName('unNumDoc').Value := NUMDOC;
     { case parametros of
        4 : begin
              ParamByName('unApellido2').value := APELLIDO2;
              ParamByName('unNombre2').value := NOMBRE2;
            end;
        5 : begin
              ParamByName('unApellido2').value := APELLIDO2;
            end;
        6 : begin
              ParamByName('unNombre2').value := NOMBRE2;
            end;
      end;       }
      //sql.SaveToFile('.\PRUEBA-dameNombreApellidosYdoc-V2.txt');
      Open;
      Result := fieldbyname('total').AsInteger;
    end;
  except
    Result := -1;
  end;
end;


function TSqlOracle.limpiar(NUMDOC: string) : string;
var aux : string;
    i : integer;
begin
  for i := 0 to length(numdoc) do
  begin
    if numdoc[i] in ['0'..'9']  then
      aux := aux + numdoc[i];
  end;
  Result := aux;
end;

function TSqlOracle.CalcularNombreApellidoYDOC(individuo: XML_CONSULTA_NEW; queDocMiro : integer): integer;
var res : integer;
    doc : string;
begin
  result := 0;
  if queDocMiro = 1 then
    doc := individuo.NUMDOC
  else
  begin
    if individuo.NUMEROIDENIFICACION <> '' then
    doc := individuo.NUMEROIDENIFICACION
  end;

  if doc <> '' then
  BEGIN
    res := dameNombreApellidosYdoc(trim(doc),individuo.APELLIDO1, individuo.APELLIDO2, individuo.NOMBRE1, individuo.NOMBRE2 );
    if (res <= 0) and (limpiar(doc) <> doc)then
    begin

      res := dameNombreApellidosYdoc(limpiar(doc), individuo.APELLIDO1, individuo.APELLIDO2, individuo.NOMBRE1, individuo.NOMBRE2);
    end;
  END;
  result := res;
end;




function TSqlOracle.procesarSolicitud(individuo: XML_CONSULTA_NEW) : TRESPUESTA_ARG;
var NAF, NAD, NAI,ND : integer;
begin
  Result:= TRESPUESTA_ARG.Create;
  if (individuo.TIPODOC <> '') and (individuo.NUMDOC <> '') and  (individuo.EMISORDOC <> '') and (individuo.NOMBRE1 <> '') and
     (individuo.APELLIDO1 <> '') and (individuo.FECHANAC <> '') and (individuo.GENERO <> '')  and (individuo.NACIONALIDAD <> '')  then
  begin
    NAF := dameNombreApellidosYfechas(individuo);
    case NAF of
      -1 : begin
              Result.COD_RTA := '0';
              Result.COD_DETALLE_RTA := '1';  // Error en la busqueda Por nombre y apellido y fecha Nac
           end;
       0 : begin
             NAD := CalcularNombreApellidoYDOC(individuo,1);   (*1 = nro doc*)
             case NAD of
              -1 : begin
                      Result.COD_RTA := '0';
                      Result.COD_DETALLE_RTA := '1';  // Error en la busqueda Por nombre y apellido y Nro Doc
                   end;
              0  :begin
                   NAI := CalcularNombreApellidoYDOC(individuo,2); (*1 = nro de identificacion*)
                   case NAI of
                    -1 : begin
                            Result.COD_RTA := '0';
                            Result.COD_DETALLE_RTA := '1';  // Error en la busqueda Por nombre y apellido y Nro Doc
                         end;
                    0  :begin
                        {  ND:=CalcularSoloDOC(individuo);
                          case ND of
                            -1: begin
                                  Result.COD_RTA := '0';
                                  Result.COD_DETALLE_RTA := '1';  // Error en la busqueda Nro Doc
                                end ;
                             0: begin
                                  Result.COD_RTA := '1';
                                  Result.COD_DETALLE_RTA := '0';// 1 - 0 ---> "NO EXISTEN" coincidencia
                                end;
                          else
                             begin
                                Result.COD_RTA := '2';
                                Result.COD_DETALLE_RTA := '0'; // 2 - 0 ---> Hay coincidencia

                             end;
                          end;
                               }
                          Result.COD_RTA := '1';
                          Result.COD_DETALLE_RTA := '0';// 1 - 0 ---> "NO EXISTEN" coincidencia

                        end;
                   else
                     begin
                       Result.COD_RTA := '2';
                       Result.COD_DETALLE_RTA := '0'; // 2 - 0 ---> Hay coincidencia
                     end;
                   end;
                 end;
               else
               begin
                 Result.COD_RTA := '2';
                 Result.COD_DETALLE_RTA := '0'; // 2 - 0 ---> Hay coincidencia
               end;
             end;
           end;
      else
      begin
        Result.COD_RTA := '2';
        Result.COD_DETALLE_RTA := '0';     // 2 - 0 ---> Hay coincidencia
      end;
    end;
    insertarLog_rta(individuo, Result.COD_RTA, Result.COD_detalle_rta);
  end
  else
  begin
    Result.COD_RTA := '0';
    Result.COD_DETALLE_RTA := '1'; // Faltan datos b�sicos para la b�squeda
  end;
end;

procedure TSqlOracle.ConsultaURY(Individuo: Persona;
  var Resultado: ResultadoConsulta; var Error: Boolean);
var  CodRespuesta, codDetalleRespuesta : Integer;
   color : string;
   positivo : Boolean;

begin
try
    Error:= False;
    positivo := False;
   // conectarANominas;
    if NOT yaloconsulte(Individuo, 'URY', CodRespuesta, codDetalleRespuesta, color) then
    BEGIN
      if consultoPorUruguay(Individuo, positivo) then
      begin
        if positivo then
          Resultado:=  StrURYresultadoConsulta(Individuo);
      end;
    end
    else
      IF color = 'ROJO' then
        Resultado:=  StrURYresultadoConsulta(Individuo);

  except on e: exception do
    begin
      Error:= True;
      generarTxT2('.\logErrorURY.txt',formatdatetime('dd/mm/yyyy HH:mm:ss',now)+' - '+ UpperCase(Individuo.NUMDOC)+' - '+UpperCase(Individuo.FECHANAC)+' - '+  UpperCase(Individuo.APELLIDO1)+' '+ UpperCase(Individuo.NOMBRE1)+' - '+ UpperCase(Individuo.PASO)+' - Error: '+e.Message);
      {ForceDirectories('.\'+formatdatetime('yyyy',now)+'\'+formatdatetime('mm',now)+'\'+formatdatetime('dd',now));
      generarTxT2('.\'+formatdatetime('yyyy',now)+'\'+formatdatetime('mm',now)+'\'+formatdatetime('dd',now)+'\logProcesoAPI.txt',formatdatetime('dd/mm/yyyy HH:mm:ss',now)+' - '+ UpperCase(Individuo.NUMDOC)+' - '+UpperCase(Individuo.FECHANAC)+' - '+  UpperCase(Individuo.APELLIDO1)+' '+ UpperCase(Individuo.NOMBRE1));}
    end;
  end;
end;

procedure TSqlOracle.conectarANominas;
var   ini: TIniFile;
begin                                              
  OraSession3 := TOraSession.Create(nil);
  ini := TIniFile.Create('.\config.ini');
  uglobal.SERVER:= ini.ReadString('CONFIG','SERVER','N');
  connect3('marrese', '25dmayo', uglobal.SERVER);
  if OraSession3.Connected then
  begin
    oraQuery3 := TOraQuery.Create(nil);
    oraQuery3.Session := OraSession3;
  end;

end;

function TSqlOracle.consultoPorUruguay(Individuo: Persona; var positivo : boolean): boolean;
var ws : IpuenteUry;
    a :  consultaPuenteURY;
    b : respuestaURY;

 function dameUser(operador : string ) : string ;
 var
    Straux :string;
    j,i,ii : integer;
 begin
   Straux :='';
    j:=0;
    i:=0;
    ii:=0;
    Straux :=OPERADOR;
    While (i <= length(OPERADOR))  do
    begin
      if (OPERADOR[i] = '-') then
      begin
        case j of
          0: result:=copy(Straux,1, ii-1 );
        end;
        ii:=0;
        Straux := copy(OPERADOR, i+1, length(OPERADOR));
        j:=j+1;
      end;
      ii:=ii+1;
      i:= i+1;
    end;
 end;

begin
    Result := False;

    try
       ws := GetIpuenteUry(False,WSURY);
       a:= consultaPuenteURY.Create;
       b:= respuestaURY.Create;
       a.NOMBRES := Individuo.NOMBRE1;
       if Individuo.NOMBRE2 <> '' then
         a.NOMBRES := a.NOMBRES + ' '+ Individuo.NOMBRE2;
       a.APELLIDOS := Individuo.APELLIDO1;
       if Individuo.APELLIDO2 <> '' then
         a.APELLIDOS := a.APELLIDOS + ' '+ Individuo.APELLIDO2;
       a.NUMDOC := Individuo.NUMDOC;
       a.PUESTOCONTROL := Individuo.PASO;
       a.TIPODOC := Individuo.TIPODOC;
       a.EMISORDOC := Individuo.EMISORDOC;
       a.FECHANAC := Individuo.FECHANAC;
       a.GENERO := Individuo.GENERO;
       a.NACIONALIDAD := Individuo.NACIONALIDAD;
       a.NUMEROIDENTIFICACION := Individuo.NUMEROIDENIFICACION;
       a.USER := dameUser(Individuo.OPERADOR);
       b := ws.consultarPuenteUry(a);
       CASE strtoint(b.COD_RTA) OF
         0 : insertarLog('URY',Individuo,'ERROR',0,0,-1);
         1 : insertarLog('URY',Individuo,'VERDE',0,1,-1);

         2 :BEGIN
              insertarLog('URY',Individuo,'ROJO',0,2,-1);
              positivo:= True;
            end;

         -1 : insertarLog('URY',Individuo,'ERROR',1,-1000,-1);
       end;
       Result := true;
    except
      insertarLog('URY',Individuo,'ERROR',2,-1000,-1);
      ForceDirectories('.\'+formatdatetime('yyyy',now)+'\'+formatdatetime('mm',now)+'\'+formatdatetime('dd',now)+'\'+UpperCase(Individuo.PASO));
      generarTxT2('.\'+formatdatetime('yyyy',now)+'\'+formatdatetime('mm',now)+'\'+formatdatetime('dd',now)+'\'+UpperCase(Individuo.PASO)+'\'+Individuo.NUMDOC+'.txt',formatdatetime('dd/mm/yyyy HH:mm:ss',now)+' - '+ UpperCase(Individuo.NUMDOC)+' - '+UpperCase(Individuo.FECHANAC)+' - '+  UpperCase(Individuo.APELLIDO1)+' '+ UpperCase(Individuo.NOMBRE1)+' - '+ UpperCase(Individuo.PASO));
    end;







 {Result := False;
  with  OraQuery3 do
  begin



    Close;
    SQL.Clear;
    SQL.LoadFromFile('.\URY_PorExacta.sql');

    //sql.Text := 'SELECT * FROM SIGER.URUGUAY_RESTRICCIONES';

    Prepared:= True;
    // consulto con el numero de documento
    ParamByName('apellido').Value:=Trim(Individuo.APELLIDO1);
    ParamByName('nombre').Value:=Trim(Individuo.NOMBRE1);
    ParamByName('fecha').Value:= Individuo.FECHANAC;
    ParamByName('documento').Value:=Trim(Individuo.NUMDOC);
    ParamByName('emisor_doc').Value:=Trim(Individuo.EMISORDOC);

    Open;
    // si no encontre nada, pruebo con el numero de identificacion.
    if IsEmpty then
      begin
        if (Trim(Individuo.NUMEROIDENIFICACION)<> NullAsStringValue) and  (Trim(Individuo.NUMEROIDENIFICACION)<> trim(Individuo.NUMDOC))then
          begin
            Close;
            Prepared := True;
            ParamByName('apellido').Value:=Trim(Individuo.APELLIDO1);
            ParamByName('nombre').Value:=Trim(Individuo.NOMBRE1);
            ParamByName('fecha').Value:= Individuo.FECHANAC;
            ParamByName('documento').Value:=Trim(Individuo.NUMEROIDENIFICACION);
            ParamByName('emisor_doc').Value:=Trim(Individuo.EMISORDOC);
            Open;
          end;
      end;


    ForceDirectories('.\'+formatdatetime('yyyy',now)+'\'+formatdatetime('mm',now)+'\'+formatdatetime('dd',now)+'\'+UpperCase(Individuo.PASO));
    generarTxT2('.\'+formatdatetime('yyyy',now)+'\'+formatdatetime('mm',now)+'\'+formatdatetime('dd',now)+'\'+UpperCase(Individuo.PASO)+'\'+ParamByName('documento').Value+'.txt',formatdatetime('dd/mm/yyyy HH:mm:ss',now)+' - '+ UpperCase(Individuo.NUMDOC)+' - '+UpperCase(Individuo.FECHANAC)+' - '+  UpperCase(Individuo.APELLIDO1)+' '+ UpperCase(Individuo.NOMBRE1)+' - '+ UpperCase(Individuo.PASO)+' - '+      IfThen(IsEmpty,'SIN COINCIDENCIAS','CON COINCIDENCIAS'));

    if not IsEmpty then
       Result := True;
  end;  }
end;

function TSqlOracle.StrURYresultadoConsulta(
  Individuo: Persona): ResultadoConsulta;


var
  tempfecha: String;
  i, j : Integer;

  color : string;

  CodRespuesta, codDetalleRespuesta: integer;

begin
  I:=0;
  SetLength(Result,1);
  Result[i]:= Restriccion.Create;
  Result[i].FUENTE                :=  'URY';
  Result[i].DESC_TIPO_DOC         :=  '';
  Result[i].DOCTIPO:=  Individuo.TIPODOC;
  Result[i].NUM_DOC:= Individuo.NUMDOC;
  Result[i].PAIS_EMISOR_DOC       :=Individuo.EMISORDOC;
  Result[i].APELLIDO              :=  Individuo.APELLIDO1;
  Result[i].APELLIDO2              :=  Individuo.APELLIDO2;
  Result[i].NOMBRE             :=  Individuo.NOMBRE1;
  Result[i].NOMBRE2  :=  Individuo.NOMBRE2;
  Result[i].NACIONALIDAD          :=  Individuo.NACIONALIDAD;
  Result[i].FECHA_NAC :=  Individuo.FECHANAC;
  (*Ver el tema del sexo*)
  Result[i].SEXO                :=  iNDIVIDUO.GENERO;
  Result[i].DESC_TIPO_RESTRICCION :=  'IMPEDIMENTOS URUGUAY';
  Result[i].EXPED_DNM             :=  '';
  Result[i].DESC_RESTRICCION      :=  'IMPEDIMENTOS URUGUAY';
  Result[i].DESC_CAUSA            :=  '';
  Result[i].DESC_INSTRUCCION      :=  'CONTACTARSE CON AUTORIDADES MIGRATORIAS DE URUGUAY';
  Result[i].DESC_TIPO_JUSTICIA    :=  'IMPEDIMENTOS URUGUAY';
  Result[i].DESC_PROVINCIA        :=  '';
  Result[i].DESC_JUZGADOS         :=  '';
  Result[i].DESC_LOCALIDAD        :=  '';
  Result[i].JUZGADO               :=  '';
  Result[i].SECRETARIA            :=  '';
  Result[i].SALA                  :=  '';
  Result[i].DESTINO               :=  '';
  Result[i].FECHA_DESDE           :=  '';
  Result[i].FECHA_HASTA           :=  '';
  Result[i].FEC_RECEP_DNM         :=  '';
  Result[i].DESC_ENTIDAD          :=  'IMPEDIMENTOS URUGUAY';
  Result[i].NRO_DISPO             :=  '';
  Result[i].NRO_NOTA              :=  '';
  Result[i].ACTA                  :=  '';
  Result[i].DESC_DELEGACION       :=  '';
  Result[i].FECHA_SALIDA          :=  '';
  Result[i].FECHA_BAJA            :=  '';
  Result[i].OBSERVACIONES         :=  '';
  Result[i].FOTO                  :=  ''; // Color de la restriccion
end;

(*
function TSqlOracle.StrURYresultadoConsulta(
  Individuo: Persona): ResultadoConsulta;


var
  tempfecha: String;
  i, j : Integer;

  color : string;

  CodRespuesta, codDetalleRespuesta: integer;

begin

    with oraQuery3 do
      begin
      SetLength(Result,RecordCount);
      First;
      for i := 0 to RecordCount - 1 do
      begin
        Result[i]:= Restriccion.Create;

        Result[i].FUENTE                :=  'URY';

        Result[i].DESC_TIPO_DOC         :=  '';

        if fieldbyname('tipo_doc').asstring <> '' then
        begin
          Result[i].DOCTIPO :=  fieldbyname('tipo_doc').AsString;
          Result[i].NUM_DOC := fieldbyname('num_doc').AsString;
        end
        else
        begin
          Result[i].DOCTIPO:=  '';
          Result[i].NUM_DOC:= '';
        end;


        if fieldbyname('PAIS_DOC').asstring <> '' then
          Result[i].PAIS_EMISOR_DOC       :=fieldbyname('PAIS_DOC').AsString
        else
            Result[i].PAIS_EMISOR_DOC       :='';



        if fieldbyname('APELLIDO').asstring <> '' then
          Result[i].APELLIDO              :=  fieldbyname('APELLIDO').asstring ;

        if fieldbyname('APELLIDO2').asstring <> '' then
          Result[i].APELLIDO2              :=  fieldbyname('APELLIDO2').asstring ;
        if fieldbyname('NOMBRE').asstring <> ''then
          Result[i].NOMBRE             :=  fieldbyname('NOMBRE').asstring;
        if fieldbyname('NOMBRE2').asstring <> '' then
          Result[i].NOMBRE2  :=  fieldbyname('NOMBRE2').asstring;

        Result[i].NACIONALIDAD          :=  fieldbyname('nacionalidad').asstring;

        if not fieldbyname('FECHA_NAC').IsNull then
            Result[i].FECHA_NAC :=  fieldbyname('FECHA_NAC').asstring
        else
          Result[i].FECHA_NAC :='';




        Result[i].SEXO                :=  iNDIVIDUO.GENERO;
        Result[i].DESC_TIPO_RESTRICCION :=  'IMPEDIMENTOS URUGUAY';

        Result[i].EXPED_DNM             :=  '';
        Result[i].DESC_RESTRICCION      :=  'IMPEDIMENTOS URUGUAY';

        Result[i].DESC_CAUSA            :=  '';
        Result[i].DESC_INSTRUCCION      :=  'CONTACTARSE CON AUTORIDADES MIGRATORIAS DE URUGUAY';
        Result[i].DESC_TIPO_JUSTICIA    :=  'IMPEDIMENTOS URUGUAY';
        Result[i].DESC_PROVINCIA        :=  '';
        Result[i].DESC_JUZGADOS         :=  '';
        Result[i].DESC_LOCALIDAD        :=  '';

        Result[i].JUZGADO               :=  '';
        Result[i].SECRETARIA            :=  '';
        Result[i].SALA                  :=  '';
        Result[i].DESTINO               :=  '';
        Result[i].FECHA_DESDE           :=  '';
        Result[i].FECHA_HASTA           :=  '';
        Result[i].FEC_RECEP_DNM         :=  '';
        Result[i].DESC_ENTIDAD          :=  'IMPEDIMENTOS URUGUAY';
        Result[i].NRO_DISPO             :=  '';
        Result[i].NRO_NOTA              :=  '';
        Result[i].ACTA                  :=  '';
        Result[i].DESC_DELEGACION       :=  '';
        Result[i].FECHA_SALIDA          :=  '';
        Result[i].FECHA_BAJA            :=  '';
        Result[i].OBSERVACIONES         :=  'IMPEDIMENTO INFORMADO POR URUGUAY: '+ fieldbyname('OBSERVACIONES').asstring ;
        Result[i].FOTO                  :=  ''; // Color de la restriccion
        Next;
      end;
      if not yaloconsulte(Individuo, 'URY', CodRespuesta, codDetalleRespuesta, color) then
        insertarLog('URY',Individuo,'ROJO',0,2,-1);
    end;
end; *)

function TSqlOracle.CalcularSoloDOC(individuo: XML_CONSULTA_NEW): integer;
var consulta : AnsiString;
    parametros : integer;
begin
  Result :=0;
  try
    with OraQuery do
    begin
      parametros :=0;
      Close;
      sql.Clear;
      sql.LoadFromFile('.\restri.sql');
      consulta := sql.Text;
      consulta := consulta + ' where NUM_DOC = :unNumDoc ';

      sql.Clear;
      sql.Add(consulta);
      ParamByName('unNumDoc').Value := individuo.NUMDOC;

      //sql.SaveToFile('.\PRUEBA-dameNombreApellidosYdoc-V2.txt');
      Open;
      Result := fieldbyname('total').AsInteger;
    end;
  except
    Result := -1;
  end;
end;

end.

