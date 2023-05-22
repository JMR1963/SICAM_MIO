unit ubaseDatos;

interface

uses
    WinApi.Windows, System.Classes, Data.DB, Ora, MemDS, DBAccess, Provider, OraProvider, vcl.Dialogs,
    WsServiciosMaritimosIntf, System.SysUtils, Vcl.Forms;

  type
    TbaseDatos =  class
  private
    FOraSession: TOraSession;
    ForaQuery: TOraQuery;
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
    property connected: boolean read getConnected write setConnected;
    property server   : string  read getServer    write setServer;
    property username : string  read getUsername  write setUsername;
    property password : string  write setPassword;
    property sql : Tstrings read getTstrings write setTstrings;
    property parametros : tstrings read getParametros write setParametros;
    function getServicios(paso:integer;fecha1, fecha2: string): Tservicios;     {getServicios}
    function setAprobado(servicio: integer;username:string): boolean;
    function setAprobadoYQ(servicio: integer;username:string): boolean;
    function setEstado(servicio:integer; estado: Testado; username:string): boolean;
    function setDiferido(servicio:integer; observacion:string; username:string; fecha_declarada:string):string;
    function getJurisdiccionFromPaso(paso: integer): integer;
    function getServiciosLocalesYOtros(paso:integer;fecha1, fecha2: string): Tservicios;
    function catalogosPasosFronterizos: TpasosFronterizos;
    function catalogosTasas:Ttasas;
    function catalogoTipoBuque: TtipoBuques;
    function catalogoServicioMaritimo: tServiciosMaritimos;
    function confirmarServicio(idServicio:integer; updServicio:TudpServicio): string;
    function fechaIntervencion(servicio: integer): string;
    function fechaProcesando(servicio: integer): string;
    function fechaHoraNominas: String;

    constructor create(); reintroduce;
    destructor destroy(); reintroduce;
  end;

implementation

  //{$Define TESTMODE}
  {$Define PRODUCCION}


uses System.Math, System.DateUtils;
{ TbaseDatos }

function TbaseDatos.setAprobado(servicio: integer;username:string): boolean;
begin
  try
    result := True;
    FOraSession.Username := 'SMARUSR';
    FOraSession.Password := 'USRSMAR';
    {$IfDef TESTMODE}
    FOraSession.Server   := 'NOMINAS_DESA';
    {$Else}
    FOraSession.Server   := 'NOMINAS';
    {$EndIf}

    FOraSession.Connected := true;
    FOraSession.StartTransaction;
    ForaQuery.Close;

    ForaQuery.SQL.Add('update servicios_maritimos.servicio set aprobado = ''t'', fecha_aprobado = sysdate, ');
    ForaQuery.SQL.Add('usuario_aprobado = :username  ');
    ForaQuery.SQL.Add('where nro_solicitud = :servicio ');

    ForaQuery.ParamByName('servicio').AsInteger := servicio;
    ForaQuery.ParamByName('username').AsString := username;

    ForaQuery.SQL.SaveToFile(ExtractFilePath(application.ExeName)  + 'sql1.txt');
    ForaQuery.ExecSQL;
    ForaQuery.Connection.Commit;
  except
    result := False;
    ForaQuery.connection.rollback;
  end
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

function TbaseDatos.getservicios(paso:integer;fecha1, fecha2: string): Tservicios;
var
  i: integer;
  fecha: Tdatetime;
  fechaDeclarada: string;
begin
  try
    FOraSession.Username := 'SMARUSR';
    FOraSession.Password := 'USRSMAR';

    {$IfDef TESTMODE}
    FOraSession.Server   := 'NOMINAS_DESA';
    {$Else}
    FOraSession.Server   := 'NOMINAS';
    {$EndIf}

    FOraSession.Connected := true;
    ForaQuery.Close;

    ForaQuery.SQL.Add('select * from servicios_maritimos.servicio serv ');
    ForaQuery.SQL.Add('inner join catalogos.vw_cat_cab_pasos pasos on serv.puerto_declarado = pasos.idpaso ');
    ForaQuery.SQL.Add('inner join servicios_maritimos.buque buque on serv.BUQUE_DECLARADO = buque.CODIGO ');
    ForaQuery.SQL.Add('inner join registros_conexos.empresa_maritimo em on em.id_empresa = buque.EMPRESA ');
    ForaQuery.SQL.Add('left JOIN CATALOGOS.CAT_SOBRETASA SOBRETASA ON SERV.SOBRETASA_DECLARADA   = SOBRETASA.CODIGO ');
    ForaQuery.SQL.Add('left join catalogos.cat_servicio_maritimo cat_serv on cat_serv.CODIGO = serv.SERVICIO_DECLARADO ');
    ForaQuery.SQL.Add('where FECHA_INICIO_DECLARADA between to_date(:fecha1, ''ddmmyyyyhh24miss'') and to_date(:fecha2, ''ddmmyyyyhh24miss'') ');
    ForaQuery.SQL.Add(' and  jurisdiccion = ((select jurisdiccion from catalogos.vw_cat_cab_pasos where idpaso  = :paso)) order by FECHA_INICIO_DECLARADA');


    ForaQuery.ParamByName('fecha1').AsString := fecha1;
    ForaQuery.ParamByName('fecha2').AsString := fecha2;
    ForaQuery.ParamByName('paso').AsInteger  := paso;

    ForaQuery.SQL.SaveToFile(ExtractFilePath(application.ExeName)  + 'sql.txt');

    ForaQuery.open;

    if ForaQuery.IsEmpty then
      result := NIL
    else
    begin
      i:= 0;
      while not ForaQuery.Eof do
      begin
        SetLength(result, i + 1);
        result[i] := servicios.Create;
        Result[i].numero_solicitud  := ForaQuery.fieldbyname('NRO_SOLICITUD').AsInteger;
        Result[i].autorizado        := ForaQuery.fieldbyname('APROBADO').AsString;
        Result[i].estado            := ForaQuery.fieldbyname('ESTADO').AsString;
        //---moco
        fecha :=  ForaQuery.fieldbyname('FECHA_INICIO_DECLARADA').Value;
        DateTimeTostring(fechaDeclarada, 'dd/mm/YYYY hh:nn:ss' , fecha);
        result[i].fecha_declarada := fechaDeclarada;
        //---
        Result[i].nombreBuque       := ForaQuery.fieldbyname('DESCRIPCION_1').AsString;
        Result[i].matricula         := ForaQuery.fieldbyname('MATRICULA').AsString;
        Result[i].diferido          := ForaQuery.fieldbyname('DIFERIDO').AsString;
        Result[i].puerto            := ForaQuery.fieldbyname('DESCRIPCION').AsString;
        Result[i].empresa           := ForaQuery.fieldbyname('DESCRIPCION_2').AsString;
        Result[i].sentido           := ForaQuery.fieldbyname('TIPO_CRUCE_DECLARADO').AsString;
        result[i].idEmpresa         := ForaQuery.fieldbyname('ID_EMPRESA').AsString;
        Result[i].totalTripulantes  := ForaQuery.fieldbyname('TRIPULANTES_DECLARADO').AsInteger;
        result[i].totalPasajeros    := ForaQuery.fieldbyname('PASAJEROS_DECLARADO').AsInteger;
        result[i].sobretasa         := ForaQuery.fieldbyname('DESCRIPCION_3').AsString;
        {PUERTO SON ID ENTEROS fix ASINTEGER}
        result[i].puertoIntermedio1     := ForaQuery.fieldbyname('PUERTO_INTERMEDIO_1_DECLARADO').AsString;
        result[i].puertoIntermedio2     := ForaQuery.fieldbyname('PUERTO_INTERMEDIO_2_DECLARADO').AsString;
        result[i].puertoIntermedio3     := ForaQuery.fieldbyname('PUERTO_INTERMEDIO_3_DECLARADO').AsString;
        result[i].puertoIntermedio4     := ForaQuery.fieldbyname('PUERTO_INTERMEDIO_4_DECLARADO').AsString;
        result[i].puertoIntermedio5     := ForaQuery.fieldbyname('PUERTO_INTERMEDIO_5_DECLARADO').AsString;
        result[i].puertoFinal           := ForaQuery.fieldbyname('PUERTO_DESTINO_FINAL_DECLARADO').AsString;
        result[i].servicio              := ForaQuery.fieldbyname('DESCRIPCION_4').AsString;
        result[i].EXENTOS_DECLARADOS    := ForaQuery.fieldbyname('EXENTOS_DECLARADOS').AsInteger;
        ForaQuery.Next;
        inc(i);
      end;
    end;
  except
    result := Nil;
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



function TbaseDatos.setEstado(servicio: integer; estado: Testado; username:string): boolean;
var
  estadoStr: string;
begin
  try
    result := True;
    FOraSession.Username := 'SMARUSR';
    FOraSession.Password := 'USRSMAR';

    {$IfDef TESTMODE}
    FOraSession.Server   := 'NOMINAS_DESA';
    {$Else}
    FOraSession.Server   := 'NOMINAS';
    {$EndIf}

    FOraSession.Connected := true;
    FOraSession.StartTransaction;
    ForaQuery.Close;

    ForaQuery.SQL.Add('update servicios_maritimos.servicio set ');
    if estado = PROCESANDO then //si lo paso a procesando le pongo la fecha.
    begin
      ForaQuery.SQL.Add('FECHA_PROCESANDO = SYSDATE, ');
      ForaQuery.SQL.Add('USUARIO_PROCESANDO = :PUSERNAME, ');
    end;
    ForaQuery.SQL.Add('estado = :estado where nro_solicitud = :servicio ');

    case estado of
      SOLICITADO  : estadoStr := 's';
      CANCELADO   : estadoStr := 'c';
      INTERVENIDO : estadoStr := 'i';
      PROCESANDO  : estadoStr := 'p';
    end;
    ForaQuery.ParamByName('servicio').AsInteger := servicio;
    ForaQuery.ParamByName('estado').AsString := estadoStr;
    if estado = PROCESANDO then
      ForaQuery.ParamByName('PUSERNAME').AsString := username;

    ForaQuery.SQL.SaveToFile(ExtractFilePath(application.ExeName)  + 'sql2.txt');
    ForaQuery.ExecSQL;
    ForaQuery.Connection.Commit;
  except
    result := False;
    ForaQuery.connection.rollback;
  end
end;


function TbaseDatos.getJurisdiccionFromPaso(paso: integer): integer;
begin
  FOraSession.Username := 'SERVMUSR';
  FOraSession.Password := 'USRSERVM';

  {$IfDef TESTMODE}
  FOraSession.Server   := 'NOMINAS_DESA';
  {$Else}
  FOraSession.Server   := 'NOMINAS';
  {$EndIf}


  FOraSession.Connected := true;
  ForaQuery.Close;

  ForaQuery.SQL.Add('select jurisdiccion from catalogos.vw_cat_cab_pasos where idpaso  = :paso');
  ForaQuery.ParamByName('paso').AsInteger := paso;
  ForaQuery.open;

  if ForaQuery.IsEmpty then
    result := -1
  else
    result := ForaQuery.fieldbyname('JURISDICCION').AsInteger;
end;

function TbaseDatos.setDiferido(servicio: integer; observacion:string; username:string; fecha_declarada:string): string;
begin
  try
    result := '';
    FOraSession.Username := 'SMARUSR';
    FOraSession.Password := 'USRSMAR';

    {$IfDef TESTMODE}
    FOraSession.Server   := 'NOMINAS_DESA';
    {$Else}
    FOraSession.Server   := 'NOMINAS';
    {$EndIf}


    FOraSession.Connected := true;
    ForaQuery.Close;
    ForaQuery.SQL.Clear;
    FOraSession.StartTransaction;

    ForaQuery.SQL.Add('update servicios_maritimos.servicio set ');
    ForaQuery.SQL.Add('diferido = ''t'', ');
    ForaQuery.SQL.Add('USUARIO_DIFERIDO = :PUSERNAME, ');
    ForaQuery.SQL.Add('FECHA_DIFERIDO = sysdate, ');

    //No va por orden de JC
    //ForaQuery.SQL.Add('fecha_diferido_declarada = :PFECHA_DECLARADA, ');


    ForaQuery.SQL.Add('observacion_diferido = :POBSERVACION ');
    ForaQuery.SQL.Add('where nro_solicitud = :servicio ');

    ForaQuery.ParamByName('servicio').AsInteger := servicio;
    ForaQuery.ParamByName('POBSERVACION').asstring := observacion;
    ForaQuery.ParamByName('PUSERNAME').asstring := username;


    ForaQuery.SQL.SaveToFile('diferido.txt');

    ForaQuery.ExecSQL;
    ForaQuery.Connection.Commit;

  except
    on e: exception do
    begin
      result := e.Message;
      ForaQuery.Connection.Rollback;
    end;
  end;
end;


function TbaseDatos.getServiciosLocalesYOtros(paso: integer; fecha1, fecha2: string): Tservicios;
var
  i: integer;
  jurisdiccion : integer;
  fecha: Tdatetime;
  fechaDeclarada: string;
begin
  try
    jurisdiccion := getJurisdiccionFromPaso(paso);
    ForaQuery.SQL.Clear;
    FOraSession.Username := 'SERVMUSR';
    FOraSession.Password := 'USRSERVM';

    {$IfDef TESTMODE}
    FOraSession.Server   := 'NOMINAS_DESA';
    {$Else}
    FOraSession.Server   := 'NOMINAS';
    {$EndIf}

    FOraSession.Connected := true;
    ForaQuery.Close;

    ForaQuery.SQL.Text := 'SELECT TO_CHAR (SERV.SICAM_FECHA_INICIO_PROCESO, ''dd/mm/yyyy hh24:mi:ss'')' +
                          ' AS FECHA_PROCESANDO, ' +
                          ' SERV.PUERTO_DESTINO_ORIGEN, ' +
                          ' SERV.ESTADO, ' +
                          ' SERV.NRO_SERVICIO, ' +
                          ' SERV.AGENCIA_FECHA_REGISTRO, ' +
                          ' AGENCIA_TIPO_SERVICIO, ' +
                          ' SERV.INCISO_P_AUTORIZADO AS AUTORIZADO, ' +
                          ' SERV.AGENCIA_TOTAL_TRIPULANTES, ' +
                          ' SERV.AGENCIA_TOTAL_PASAJEROS, ' +
                          ' SERV.AGENCIA_TOTAL_EXENTOS, ' +
                          ' SERV.ID_PUERTO_ATENCION AS PUERTO_DESTINO_FINAL_DECLARADO, ' +
                          ' SERV.SICAM_APELLIDO_AGENCIA, ' +
                          ' SERV.SICAM_NOMBRE_AGENCIA, ' +
                          ' SERV.ID_PUERTO_INTERMEDIO_1, ' +
                          ' SERV.ID_PUERTO_INTERMEDIO_2, ' +
                          ' SERV.ID_PUERTO_INTERMEDIO_3, ' +
                          ' SERV.ID_PUERTO_INTERMEDIO_4, ' +
                          ' SERV.ID_PUERTO_INTERMEDIO_5, ' +
                          ' SERV.ID_PAIS_ORIGEN_DESTINO, ' +
                          ' SERV.AGENCIA_FECHA_DECLARADA, ' +
                          ' JURISDICCION, ' +
                          ' BUQUE.DESCRIPCION AS BUQUE_DESCRIPCION, ' +
                          ' MATRICULA, ' +
                          ' BUQUE.EMPRESA, ' +
                          ' PASOS.DESCRIPCION_FUENTES, ' +
                          ' TIPO_CRUCE, ' +
                          ' EM.ID_EMPRESA, ' +
                          ' SOBRETASA.DESCRIPCION AS SOBRETASADESC, ' +
                          ' EM.DESCRIPCION_ABREVIADA AS DESCRIPCION_EMPRESA, ' +
                          ' EM.ETIQUETA AS ETIQUETA_EMPRESA, ' +
                          ' BUQUE.TIPO_BUQUE AS TIPO_BUQUE, ' +
                          ' PAIS.DESCRIPCION_SICAM, ' +
                          ' PAIS.CODIGO_SICAM ' +
                          ' FROM SERVICIOSMARITIMOS.SERVICIO SERV ' +
                          ' INNER JOIN (select distinct idpaso, jurisdiccion, DESCRIPCION_FUENTES from CATALOGOS.VW_CAT_CAB_PASOS ) PASOS ' +
                          ' ON SERV.ID_PUERTO_ATENCION = PASOS.IDPASO ' +
                          ' INNER JOIN CATALOGOS.CAT_PAISES PAIS ' +
                          ' ON SERV.ID_PAIS_ORIGEN_DESTINO = PAIS.CODIGO_SICAM ' +
                          ' AND PAIS.FLAG = ''t'' ' +
                          ' INNER JOIN SERVICIOSMARITIMOS.BUQUE BUQUE ' +
                          ' ON SERV.ID_BUQUE = BUQUE.CODIGO ' +
                          ' INNER JOIN REGISTROS_CONEXOS.EMPRESA_MARITIMO EM ' +
                          ' ON EM.ID_EMPRESA = BUQUE.EMPRESA ' +
                          ' LEFT JOIN SERVICIOSMARITIMOS.CAT_SOBRETASA SOBRETASA ' +
                          ' ON SERV.SICAM_ID_SOBRETASA = SOBRETASA.CODIGO ' +
                          ' WHERE (ESTADO = ''s'' AND JURISDICCION = :PJURISDICCION) ' +
                          ' OR ( ( (AGENCIA_FECHA_DECLARADA BETWEEN SYSDATE - 3 AND SYSDATE + 1 ' +
                          ' AND JURISDICCION = :PJURISDICCION) ' +
                          ' OR (ESTADO = ''p'' AND JURISDICCION = :PJURISDICCION))) ' +
                          ' OR (AGENCIA_FECHA_DECLARADA BETWEEN SYSDATE - 3 AND SYSDATE + 1 ' +
                          ' AND ESTADO = ''p'' AND ( (:PJURISDICCION = ' +
                          ' (SELECT JURISDICCION FROM CATALOGOS.VW_CAT_CAB_PASOS ' +
                          ' WHERE IDPASO = SERV.ID_PUERTO_INTERMEDIO_1)) ' +
                          ' OR (:PJURISDICCION = (SELECT JURISDICCION ' +
                          ' FROM CATALOGOS.VW_CAT_CAB_PASOS ' +
                          ' WHERE IDPASO = SERV.ID_PUERTO_INTERMEDIO_2)) ' +
                          ' OR (:PJURISDICCION = (SELECT JURISDICCION ' +
                          ' FROM CATALOGOS.VW_CAT_CAB_PASOS WHERE IDPASO = SERV.ID_PUERTO_INTERMEDIO_3)) ' +
                          ' OR (:PJURISDICCION = ' +
                          ' (SELECT JURISDICCION FROM CATALOGOS.VW_CAT_CAB_PASOS ' +
                          ' WHERE IDPASO = SERV.ID_PUERTO_INTERMEDIO_4)) ' +
                          ' OR (:PJURISDICCION = (SELECT JURISDICCION ' +
                          ' FROM CATALOGOS.VW_CAT_CAB_PASOS ' +
                          ' WHERE IDPASO = SERV.ID_PUERTO_INTERMEDIO_5)))) ' +
                          ' ORDER BY nro_servicio desc ';

    //ForaQuery.ParamByName('fecha1').AsString := fecha1;
    //ForaQuery.ParamByName('fecha2').AsString := fecha2;
    ForaQuery.ParamByName('pjurisdiccion').AsInteger := jurisdiccion;
    ForaQuery.SQL.SaveToFile(ExtractFilePath(application.ExeName)  + 'sql3.txt');
    ForaQuery.open;

    if ForaQuery.IsEmpty then
      result := NIL
    else
    begin
      i:= 0;
      while not ForaQuery.Eof do
      begin
        SetLength(result, i + 1);
        result[i] := servicios.Create;
        Result[i].numero_solicitud    := ForaQuery.fieldbyname('NRO_SERVICIO').AsInteger;
        Result[i].autorizado          := ForaQuery.fieldbyname('AUTORIZADO').AsString;
        Result[i].estado              := ForaQuery.fieldbyname('ESTADO').AsString;
          //---moco
        fecha :=  ForaQuery.fieldbyname('AGENCIA_FECHA_REGISTRO').Value;
        DateTimeTostring(fechaDeclarada, 'dd/mm/YYYY hh:nn:ss' , fecha);
        result[i].fecha_declarada := fechaDeclarada;
        //---

        //Result[i].fecha_declarada     := ForaQuery.fieldbyname('FECHA_INICIO_DECLARADA').asString;
        Result[i].nombreBuque         := ForaQuery.fieldbyname('BUQUE_DESCRIPCION').AsString;
        Result[i].matricula           := ForaQuery.fieldbyname('MATRICULA').AsString;
        //Result[i].diferido            := ForaQuery.fieldbyname('DIFERIDO').AsString;
        Result[i].puerto              := ForaQuery.fieldbyname('PUERTO_DESTINO_ORIGEN').AsString;
        Result[i].empresa             := ForaQuery.fieldbyname('EMPRESA').AsString;
        Result[i].sentido             := ForaQuery.fieldbyname('TIPO_CRUCE').AsString;
        result[i].idEmpresa           := ForaQuery.fieldbyname('ID_EMPRESA').AsString;
        Result[i].totalTripulantes    := ForaQuery.fieldbyname('AGENCIA_TOTAL_TRIPULANTES').AsInteger;
        result[i].totalPasajeros      := ForaQuery.fieldbyname('AGENCIA_TOTAL_PASAJEROS').AsInteger;
        result[i].sobretasa           := ForaQuery.fieldbyname('SOBRETASADESC').AsString;
        result[i].puertoIntermedio1   := ForaQuery.fieldbyname('ID_PUERTO_INTERMEDIO_1').AsString;
        result[i].puertoIntermedio2   := ForaQuery.fieldbyname('ID_PUERTO_INTERMEDIO_2').AsString;
        result[i].puertoIntermedio3   := ForaQuery.fieldbyname('ID_PUERTO_INTERMEDIO_3').AsString;
        result[i].puertoIntermedio4   := ForaQuery.fieldbyname('ID_PUERTO_INTERMEDIO_4').AsString;
        result[i].puertoIntermedio5   := ForaQuery.fieldbyname('ID_PUERTO_INTERMEDIO_5').AsString;
        result[i].puertoFinal         := ForaQuery.fieldbyname('PUERTO_DESTINO_FINAL_DECLARADO').AsString;
        result[i].servicio            := ForaQuery.fieldbyname('AGENCIA_TIPO_SERVICIO').AsString;
        result[i].jurisdiccion        := ForaQuery.fieldbyname('JURISDICCION').AsInteger;
        Result[i].descripcion_empresa := ForaQuery.fieldbyname('DESCRIPCION_EMPRESA').AsString;
        result[i].tipo_buque          := ForaQuery.fieldbyname('TIPO_BUQUE').asInteger;
        result[i].FECHA_PROCESANDO    := ForaQuery.fieldbyname('FECHA_PROCESANDO').AsString;
        result[i].EXENTOS_DECLARADOS  := ForaQuery.fieldbyname('AGENCIA_TOTAL_EXENTOS').AsInteger;
        ForaQuery.Next;
        inc(i);
      end;
    end;
  except
  end;
end;

{

function TbaseDatos.getServiciosLocalesYOtros(paso: integer; fecha1, fecha2: string): Tservicios;
var
  i: integer;
  jurisdiccion : integer;
  fecha: Tdatetime;
  fechaDeclarada: string;
begin
  try
    jurisdiccion := getJurisdiccionFromPaso(paso);
    ForaQuery.SQL.Clear;
    FOraSession.Username := 'SMARUSR';
    FOraSession.Password := 'USRSMAR';

    {$IfDef TESTMODE
    FOraSession.Server   := 'NOMINAS_DESA';
    {$Else
    FOraSession.Server   := 'NOMINAS';
    {$EndIf

    FOraSession.Connected := true;
    ForaQuery.Close;


    ForaQuery.SQL.Add('SELECT  SERV.FECHA_PROCESANDO , SERV.ESTADO, SERV.APROBADO, serv.nro_solicitud, serv.servicio_declarado, ');
    ForaQuery.SQL.Add('serv.sobretasa_declarada, serv.tripulantes_declarado, ');
    ForaQuery.SQL.Add('serv.pasajeros_declarado, serv.apellido_firmante, ');
    ForaQuery.SQL.Add('serv.nombre_firmante, serv.puerto_intermedio_1_declarado, ');
    ForaQuery.SQL.Add('serv.puerto_intermedio_2_declarado, ');
    ForaQuery.SQL.Add('serv.puerto_intermedio_3_declarado, ');
    ForaQuery.SQL.Add('serv.puerto_intermedio_4_declarado, ');
    ForaQuery.SQL.Add('serv.puerto_intermedio_5_declarado, ');
    ForaQuery.SQL.Add('serv.puerto_destino_final_declarado, serv.observacion, ');
    ForaQuery.SQL.Add('serv.fecha_inicio_declarada, jurisdiccion, ');
    ForaQuery.SQL.Add('buque.descripcion as buque_descripcion, matricula, ');
    ForaQuery.SQL.Add('diferido, buque.empresa, pasos.descripcion_fuentes, ');
    ForaQuery.SQL.Add('TIPO_CRUCE_DECLARADO, em.id_empresa, sobretasa.descripcion as sobretasa_descripcion, ');
    ForaQuery.SQL.Add('cat_serv.descripcion as cat_descripcion, em.descripcion as descripcion_empresa, buque.tipo_buque as tipo_buque ');


    ForaQuery.SQL.Add('FROM servicios_maritimos.servicio serv INNER JOIN catalogos.vw_cat_cab_pasos pasos ');
    ForaQuery.SQL.Add('ON serv.puerto_declarado = pasos.idpaso ');
    ForaQuery.SQL.Add('INNER JOIN servicios_maritimos.buque buque ');
    ForaQuery.SQL.Add('ON serv.buque_declarado = buque.codigo ');
    ForaQuery.SQL.Add('INNER JOIN registros_conexos.empresa_maritimo em ');
    ForaQuery.SQL.Add('ON em.id_empresa = buque.empresa ');
    ForaQuery.SQL.Add('LEFT JOIN CATALOGOS.CAT_SOBRETASA SOBRETASA ' );
    ForaQuery.SQL.Add('ON SERV.SOBRETASA_DECLARADA   = SOBRETASA.CODIGO ');
    ForaQuery.SQL.Add('left join catalogos.cat_servicio_maritimo cat_serv ');
    ForaQuery.SQL.Add('on cat_serv.CODIGO = serv.SERVICIO_DECLARADO ');

    ForaQuery.SQL.Add('WHERE ((fecha_inicio_declarada BETWEEN TO_DATE (:fecha1, ''ddmmyyyyhh24miss'') ');
    ForaQuery.SQL.Add('AND TO_DATE (:fecha2, ''ddmmyyyyhh24miss'' ) and jurisdiccion = :pjurisdiccion) or ');

    ForaQuery.SQL.Add('(estado = ''p'' and jurisdiccion = :pjurisdiccion))  ');




    ForaQuery.SQL.Add('union all ');

    ForaQuery.SQL.Add('SELECT   SERV.FECHA_PROCESANDO, SERV.ESTADO, SERV.APROBADO, serv.nro_solicitud, serv.servicio_declarado, ');
    ForaQuery.SQL.Add('serv.sobretasa_declarada, serv.tripulantes_declarado, ');
    ForaQuery.SQL.Add('serv.pasajeros_declarado, serv.apellido_firmante, ');
    ForaQuery.SQL.Add('serv.nombre_firmante, serv.puerto_intermedio_1_declarado, ');
    ForaQuery.SQL.Add('serv.puerto_intermedio_2_declarado, ');
    ForaQuery.SQL.Add('serv.puerto_intermedio_3_declarado, ');
    ForaQuery.SQL.Add('serv.puerto_intermedio_4_declarado, ');
    ForaQuery.SQL.Add('serv.puerto_intermedio_5_declarado, ');
    ForaQuery.SQL.Add('serv.puerto_destino_final_declarado, serv.observacion, ');
    ForaQuery.SQL.Add('serv.fecha_inicio_declarada, jurisdiccion,  ');
    ForaQuery.SQL.Add('buque.descripcion as buque_descripcion, matricula, ');
    ForaQuery.SQL.Add('diferido, buque.empresa, pasos.descripcion_fuentes,  ');
    ForaQuery.SQL.Add('TIPO_CRUCE_DECLARADO, em.id_empresa, sobretasa.descripcion as sobretasa_descripcion,  ');
    ForaQuery.SQL.Add('cat_serv.descripcion as cat_descripcion, em.descripcion as descripcion_empresa, buque.tipo_buque as tipo_buque ');


    ForaQuery.SQL.Add('FROM servicios_maritimos.servicio serv INNER JOIN catalogos.vw_cat_cab_pasos pasos ');
    ForaQuery.SQL.Add('ON serv.puerto_declarado = pasos.idpaso ');
    ForaQuery.SQL.Add('INNER JOIN servicios_maritimos.buque buque ');
    ForaQuery.SQL.Add('ON serv.buque_declarado = buque.codigo ');
    ForaQuery.SQL.Add('INNER JOIN registros_conexos.empresa_maritimo em ');
    ForaQuery.SQL.Add('ON em.id_empresa = buque.empresa ');
    ForaQuery.SQL.Add('LEFT JOIN CATALOGOS.CAT_SOBRETASA SOBRETASA ' );
    ForaQuery.SQL.Add('ON SERV.SOBRETASA_DECLARADA   = SOBRETASA.CODIGO ');
    ForaQuery.SQL.Add('left join catalogos.cat_servicio_maritimo cat_serv ');
    ForaQuery.SQL.Add('on cat_serv.CODIGO = serv.SERVICIO_DECLARADO ');

    ForaQuery.SQL.Add('WHERE fecha_inicio_declarada BETWEEN TO_DATE (:fecha1, ''ddmmyyyyhh24miss'' ) ');
    ForaQuery.SQL.Add('AND TO_DATE (:fecha2, ''ddmmyyyyhh24miss'' ) ');
    ForaQuery.SQL.Add('AND estado = ''p'' ');
    ForaQuery.SQL.Add('AND (   (:pjurisdiccion = (SELECT jurisdiccion ');
    ForaQuery.SQL.Add('FROM catalogos.vw_cat_cab_pasos ');
    ForaQuery.SQL.Add('WHERE idpaso = serv.puerto_intermedio_1_declarado)) ');
    ForaQuery.SQL.Add('OR (:pjurisdiccion = (SELECT jurisdiccion ');
    ForaQuery.SQL.Add('FROM catalogos.vw_cat_cab_pasos ');
    ForaQuery.SQL.Add('WHERE idpaso = serv.puerto_intermedio_2_declarado)) ');
    ForaQuery.SQL.Add('OR (:pjurisdiccion = (SELECT jurisdiccion ');
    ForaQuery.SQL.Add('FROM catalogos.vw_cat_cab_pasos ');
    ForaQuery.SQL.Add('WHERE idpaso = serv.puerto_intermedio_3_declarado)) ');
    ForaQuery.SQL.Add('OR (:pjurisdiccion = (SELECT jurisdiccion ');
    ForaQuery.SQL.Add('FROM catalogos.vw_cat_cab_pasos ');
    ForaQuery.SQL.Add('WHERE idpaso = serv.puerto_intermedio_4_declarado)) ');
    ForaQuery.SQL.Add('OR (:pjurisdiccion = (SELECT jurisdiccion ');
    ForaQuery.SQL.Add('FROM catalogos.vw_cat_cab_pasos ');
    ForaQuery.SQL.Add('WHERE idpaso = serv.puerto_intermedio_5_declarado))) ');
    ForaQuery.SQL.Add('ORDER BY fecha_inicio_declarada ');

    ForaQuery.ParamByName('fecha1').AsString := fecha1;
    ForaQuery.ParamByName('fecha2').AsString := fecha2;
    ForaQuery.ParamByName('pjurisdiccion').AsInteger := jurisdiccion;
    ForaQuery.SQL.SaveToFile('./sql.txt');
    ForaQuery.open;

    if ForaQuery.IsEmpty then
      result := NIL
    else
    begin
      i:= 0;
      while not ForaQuery.Eof do
      begin
        SetLength(result, i + 1);
        result[i] := servicios.Create;
        Result[i].numero_solicitud    := ForaQuery.fieldbyname('NRO_SOLICITUD').AsInteger;
        Result[i].autorizado          := ForaQuery.fieldbyname('APROBADO').AsString;
        Result[i].estado              := ForaQuery.fieldbyname('ESTADO').AsString;
          //---moco
        fecha :=  ForaQuery.fieldbyname('FECHA_INICIO_DECLARADA').Value;
        DateTimeTostring(fechaDeclarada, 'dd/mm/YYYY hh:nn:ss' , fecha);
        result[i].fecha_declarada := fechaDeclarada;
        //---

        //Result[i].fecha_declarada     := ForaQuery.fieldbyname('FECHA_INICIO_DECLARADA').asString;
        Result[i].nombreBuque         := ForaQuery.fieldbyname('BUQUE_DESCRIPCION').AsString;
        Result[i].matricula           := ForaQuery.fieldbyname('MATRICULA').AsString;
        Result[i].diferido            := ForaQuery.fieldbyname('DIFERIDO').AsString;
        Result[i].puerto              := ForaQuery.fieldbyname('descripcion_fuentes').AsString;
        Result[i].empresa             := ForaQuery.fieldbyname('EMPRESA').AsString;
        Result[i].sentido             := ForaQuery.fieldbyname('TIPO_CRUCE_DECLARADO').AsString;
        result[i].idEmpresa           := ForaQuery.fieldbyname('ID_EMPRESA').AsString;
        Result[i].totalTripulantes    := ForaQuery.fieldbyname('TRIPULANTES_DECLARADO').AsInteger;
        result[i].totalPasajeros      := ForaQuery.fieldbyname('PASAJEROS_DECLARADO').AsInteger;
        result[i].sobretasa           := ForaQuery.fieldbyname('SOBRETASA_DESCRIPCION').AsString;
        result[i].puertoIntermedio1   := ForaQuery.fieldbyname('PUERTO_INTERMEDIO_1_DECLARADO').AsString;
        result[i].puertoIntermedio2   := ForaQuery.fieldbyname('PUERTO_INTERMEDIO_2_DECLARADO').AsString;
        result[i].puertoIntermedio3   := ForaQuery.fieldbyname('PUERTO_INTERMEDIO_3_DECLARADO').AsString;
        result[i].puertoIntermedio4   := ForaQuery.fieldbyname('PUERTO_INTERMEDIO_4_DECLARADO').AsString;
        result[i].puertoIntermedio5   := ForaQuery.fieldbyname('PUERTO_INTERMEDIO_5_DECLARADO').AsString;
        result[i].puertoFinal         := ForaQuery.fieldbyname('PUERTO_DESTINO_FINAL_DECLARADO').AsString;
        result[i].servicio            := ForaQuery.fieldbyname('CAT_DESCRIPCION').AsString;
        result[i].jurisdiccion        := ForaQuery.fieldbyname('JURISDICCION').AsInteger;
        Result[i].descripcion_empresa := ForaQuery.fieldbyname('DESCRIPCION_EMPRESA').AsString;
        result[i].tipo_buque          := ForaQuery.fieldbyname('TIPO_BUQUE').asInteger;
        result[i].FECHA_PROCESANDO    := ForaQuery.fieldbyname('FECHA_PROCESANDO').AsString;

        ForaQuery.Next;
        inc(i);
      end;
    end;
  except
  end;
end;

}

function TbaseDatos.catalogosPasosFronterizos: TpasosFronterizos;
var
  i:  integer;
begin
  try
    FOraSession.Username := 'SMARUSR';
    FOraSession.Password := 'USRSMAR';

    {$IfDef TESTMODE}
    FOraSession.Server   := 'NOMINAS_DESA';
    {$Else}
    FOraSession.Server   := 'NOMINAS';
    {$EndIf}

    FOraSession.Connected := true;
    ForaQuery.Close;
    ForaQuery.SQL.Clear;

    ForaQuery.SQL.Add('select * from catalogos.vw_cat_cab_pasos where tipopaso = ''M'' ');

    ForaQuery.open;

    if ForaQuery.IsEmpty then
      result := NIL
    else
    begin
      i:=0;
      while not ForaQuery.Eof do
      begin
        if (ForaQuery.fieldbyname('PADRON').asstring <> 'H' ) and
          ( (ForaQuery.fieldbyname('OPERADOR').asstring = 'DNM') or
            (ForaQuery.fieldbyname('OPERADOR').asstring = 'GNA') or
            (ForaQuery.fieldbyname('OPERADOR').asstring = 'PNA')
          ) then
        begin
          SetLength(result, i + 1);
          result[i]                 := TpasoFronterizo.Create;
          result[i].IdPaso          := ForaQuery.fieldbyname('IDPASO').AsInteger;
          result[i].Descripcion     := ForaQuery.fieldbyname('DESCRIPCION').AsString;
          result[i].DescripcionReso := ForaQuery.fieldbyname('DESCRIPCION_RESO').AsString;
          result[i].Jurisdiccion    := ForaQuery.fieldbyname('JURISDICCION').AsInteger;
          result[i].Padron          := ForaQuery.fieldbyname('PADRON').value;
          result[i].IdProvincia     := ForaQuery.fieldbyname('IDPROVINCIA').AsInteger;
          result[i].Operador        := ForaQuery.fieldbyname('OPERADOR').asString;
          result[i].CodigoDispo     := ForaQuery.fieldbyname('CODIGO_DISPO').asString;
          result[i].Informatizado   := ForaQuery.fieldbyname('INFORMATIZADO').asString;
          result[i].TipoPaso        := ForaQuery.fieldbyname('TIPOPASO').asString;
          inc(i);
          ForaQuery.Next;
        end
        else
        begin
          ForaQuery.Next;
        end;

      end;
    end;
  except
    result := NIL
  END;
end;

function TbaseDatos.catalogosTasas: Ttasas;
var
  i:  integer;
begin
  try
    FOraSession.Username := 'SMARUSR';
    FOraSession.Password := 'USRSMAR';

    {$IfDef TESTMODE}
    FOraSession.Server   := 'NOMINAS_DESA';
    {$Else}
    FOraSession.Server   := 'NOMINAS';
    {$EndIf}

    FOraSession.Connected := true;
    ForaQuery.Close;
    ForaQuery.SQL.Clear;
    ForaQuery.SQL.Add('select * from catalogos.cat_sobretasa ');
    ForaQuery.open;

    if ForaQuery.IsEmpty then
      result := NIL
    else
    begin
      i:= 0;
      while not ForaQuery.Eof do
      begin
        SetLength(result, i + 1);
        result[i]                 := Ttasa.Create;
        result[i].codigo          := ForaQuery.fieldbyname('CODIGO').AsInteger;
        result[i].Descripcion     := ForaQuery.fieldbyname('DESCRIPCION').AsString;
        inc(i);
        ForaQuery.Next;
      end
    end;
  except
    result := nil;
  END;
end;

function TbaseDatos.catalogoTipoBuque: TtipoBuques;
var
  i:  integer;
begin
  try
    FOraSession.Username := 'SMARUSR';
    FOraSession.Password := 'USRSMAR';

    {$IfDef TESTMODE}
    FOraSession.Server   := 'NOMINAS_DESA';
    {$Else}
    FOraSession.Server   := 'NOMINAS';
    {$EndIf}

    FOraSession.Connected := true;
    ForaQuery.Close;
    ForaQuery.SQL.Clear;
    ForaQuery.SQL.Add('select * from catalogos.cat_tipo_buque ');
    ForaQuery.open;

    if ForaQuery.IsEmpty then
      result := NIL
    else
    begin
      i:= 0;
      while not ForaQuery.Eof do
      begin
        SetLength(result, i + 1);
        result[i]                 := Ttipobuque.Create;
        result[i].codigo          := ForaQuery.fieldbyname('CODIGO').AsInteger;
        result[i].Descripcion     := ForaQuery.fieldbyname('DESCRIPCION').AsString;
        result[i].flag            := ForaQuery.fieldbyname('FLAG').AsBoolean;
        inc(i);
        ForaQuery.Next;
      end;
    end;
  except
    result := nil;
  END;
end;

function TbaseDatos.catalogoServicioMaritimo: tServiciosMaritimos;
var
  i:  integer;
begin
  try
    FOraSession.Username := 'SMARUSR';
    FOraSession.Password := 'USRSMAR';

    {$IfDef TESTMODE}
    FOraSession.Server   := 'NOMINAS_DESA';
    {$Else}
    FOraSession.Server   := 'NOMINAS';
    {$EndIf}

    FOraSession.Connected := true;
    ForaQuery.Close;
    ForaQuery.SQL.Clear;
    ForaQuery.SQL.Add('select * from catalogos.cat_servicio_maritimo ');
    ForaQuery.open;

    if ForaQuery.IsEmpty then
      result := NIL
    else
    begin
      i:= 0;
      while not ForaQuery.Eof do
      begin
        SetLength(result, i + 1);
        result[i]                 := tservicioMaritimo.Create;
        result[i].codigo          := ForaQuery.fieldbyname('CODIGO').AsInteger;
        result[i].Descripcion     := ForaQuery.fieldbyname('DESCRIPCION').AsString;
        result[i].tipoBuque       := ForaQuery.fieldbyname('TIPO_BUQUE').AsInteger;
        inc(i);
        ForaQuery.Next;
      end;
    end;
  except
    result := nil;
  END;
end;

function TbaseDatos.confirmarServicio(idServicio: integer; updServicio: TudpServicio): string;
begin
  try
    result := '';
    FOraSession.Username := 'SMARUSR';
    FOraSession.Password := 'USRSMAR';

    {$IfDef TESTMODE}
    FOraSession.Server   := 'NOMINAS_DESA';
    {$Else}
    FOraSession.Server   := 'NOMINAS';
    {$EndIf}

    FOraSession.Connected := true;
    FOraSession.StartTransaction;
    ForaQuery.Close;
    ForaQuery.SQL.Clear;

    ForaQuery.SQL.Add('UPDATE servicios_maritimos.servicio ');
    ForaQuery.SQL.Add('SET servicio_confirmado = :pservicio_confirmado, ');
    ForaQuery.SQL.Add(' estado = ''i'', ');
    if updServicio.sobretasa <> -1 then {si es -1 no hay sobretasa}
      ForaQuery.SQL.Add('sobretasa_confirmada = :psobretasa_confirmada, ');
    ForaQuery.SQL.Add('tripulantes_confirmado = :ptripulantes_confirmados, ');
    ForaQuery.SQL.Add('pasajeros_confirmado = :ppasajeros_confirmado, ');
    ForaQuery.SQL.Add('PUERTO_DEST_FINAL_CONFIRMADO = :PPUERTO_DEST_FINAL_CONFIRMADO, ');
    ForaQuery.SQL.Add('OBSERVACION = :POBSERVACION, ');

    //si el que intervino no modifico la fecha -> sysdate
    if updServicio.fechaFinalDeclarada = updServicio.fecha_registro then
    begin
      ForaQuery.SQL.Add('FECHA_FINAL_CONFIRMADA = sysdate, '); {to_date(:fecha1, ''ddmmyyyyhh24miss'')}
      ForaQuery.SQL.Add('fecha_confirmacion = sysdate, ');     {to_date(:fecha1, ''ddmmyyyyhh24miss'')}
    end
    else
    begin //si modifico la fecha se coloca la que declaro
      ForaQuery.SQL.Add('FECHA_FINAL_CONFIRMADA = to_date(:PFECHAFINAL, ''dd/mm/yyyy hh24:mi''),  '); {to_date(:fecha1, ''ddmmyyyyhh24miss'')}
      ForaQuery.SQL.Add('fecha_confirmacion = sysdate, '); {to_date(:fecha1, ''ddmmyyyyhh24miss'')}
    end;

    ForaQuery.SQL.Add('usuario_confirmacion = :pusuario_confirmacion, ');
    ForaQuery.SQL.Add('apellido_firmante = :papellido_firmante, ');
    ForaQuery.SQL.Add('nombre_firmante = :pnombre_firmante, ');
    ForaQuery.SQL.Add('puerto_intermedio_1_confirmado = :pintermedio_1_confirmado, ');
    ForaQuery.SQL.Add('puerto_intermedio_2_confirmado = :pintermedio_2_confirmado, ');
    ForaQuery.SQL.Add('puerto_intermedio_3_confirmado = :pintermedio_3_confirmado, ');
    ForaQuery.SQL.Add('puerto_intermedio_4_confirmado = :pintermedio_4_confirmado, ');
    ForaQuery.SQL.Add('puerto_intermedio_5_confirmado = :pintermedio_5_confirmado, ');
    ForaQuery.SQL.Add('FECHA_TOPE_RECLAMO       = to_date(:PFECHA_TOPE_RECLAMO , ''dd/mm/yyyy hh24:mi''), ');
    //ForaQuery.SQL.Add('FECHA_PROCESANDO  = to_date(:PFECHA_INICIO_CONFIRMADA , ''dd/mm/yyyy hh24:mi''), ');
    ForaQuery.SQL.Add('APENOM_USERNAME_FIRMANTE = :PAPENOM_USERNAME_FIRMANTE, ');
    ForaQuery.SQL.Add('EXENTOS_CONFIRMADO = :PEXENTOS_CONFIRMADO, ');  //PEXENTOS_CONFIRMADO
    ForaQuery.SQL.Add('FECHA_TOPE_CANCELACION   = to_date(:PFECHA_TOPE_CANCELACION, ''dd/mm/yyyy hh24:mi'')');
    ForaQuery.SQL.Add('WHERE nro_solicitud = :pnro_solicitud ');
    ForaQuery.SQL.SaveToFile('update.txt');

    {

    if updServicio.servicio = 1 then //harcodeado hasta que se modifique la version de sicam
      updServicio.servicio := 2;

    }

    ForaQuery.ParamByName('pservicio_confirmado').Value     := updServicio.servicio;

    if updServicio.sobretasa <> -1 then {si es -1 no hay sobretasa}
      ForaQuery.ParamByName('psobretasa_confirmada').Value  := updServicio.sobretasa;
    ForaQuery.ParamByName('ptripulantes_confirmados').Value := updServicio.tripulantes;
    ForaQuery.ParamByName('ppasajeros_confirmado').Value    := updServicio.pasajeros;
    ForaQuery.ParamByName('PPUERTO_DEST_FINAL_CONFIRMADO').Value    := updServicio.puertoFinal;
    ForaQuery.ParamByName('POBSERVACION').Value             := updServicio.observacion;

    ForaQuery.ParamByName('pusuario_confirmacion').Value    := updServicio.usuario;
    ForaQuery.ParamByName('papellido_firmante').Value       := updServicio.apellidoFirmante;
    ForaQuery.ParamByName('pnombre_firmante').Value         := updServicio.nombreFirmante;
    ForaQuery.ParamByName('pintermedio_1_confirmado').Value := updServicio.puertoIntermedio1;
    ForaQuery.ParamByName('pintermedio_2_confirmado').Value := updServicio.puertoIntermedio2;
    ForaQuery.ParamByName('pintermedio_3_confirmado').Value := updServicio.puertoIntermedio3;
    ForaQuery.ParamByName('pintermedio_4_confirmado').Value := updServicio.puertoIntermedio4;
    ForaQuery.ParamByName('pintermedio_5_confirmado').Value := updServicio.puertoIntermedio5;
    ForaQuery.ParamByName('pnro_solicitud').Value           := updServicio.nroSolicitud;
    ForaQuery.ParamByName('PFECHA_TOPE_CANCELACION').Value  := updServicio.fechaTopeCancelacion;
    ForaQuery.ParamByName('PFECHA_TOPE_RECLAMO').Value      := updServicio.fechaTopeReclamo;
    //ForaQuery.ParamByName('PFECHA_INICIO_CONFIRMADA').Value := updServicio.fechaInicioConfirmada;
    ForaQuery.ParamByName('PAPENOM_USERNAME_FIRMANTE').Value:= updServicio.APENOM_USERNAME_FIRMANTE;
    ForaQuery.ParamByName('PEXENTOS_CONFIRMADO').AsInteger  := updServicio.EXENTOS_CONFIRMADOS;
    if not(updServicio.fechaFinalDeclarada = updServicio.fecha_registro) then
      ForaQuery.ParamByName('PFECHAFINAL').Value              := updServicio.fechaFinalDeclarada;
    //ForaQuery.ParamByName('pfecha_confirmacion').AsString   := updServicio.fecha_registro;

    ForaQuery.SQL.SaveToFile('update.txt');
    ForaQuery.ExecSQL;

    FOraSession.Commit;
  except
    on e: exception do
    begin
      result := e.Message;
      FOraSession.Rollback;
    end;
  end;
END;

function TbaseDatos.fechaIntervencion(servicio: integer): string;
var
  estadoStr: string;
begin
  try
    result := '';
    FOraSession.Username := 'SMARUSR';
    FOraSession.Password := 'USRSMAR';

    {$IfDef TESTMODE}
    FOraSession.Server   := 'NOMINAS_DESA';
    {$Else}
    FOraSession.Server   := 'NOMINAS';
    {$EndIf}

    FOraSession.Connected := true;
    ForaQuery.Close;

    ForaQuery.SQL.Add('select to_char(fecha_confirmacion,''dd/mm/yyyy hh24:mi:ss'')as fecha_confirmacion from servicios_maritimos.servicio where ');
    ForaQuery.SQL.Add(' nro_solicitud = :servicio ');

    ForaQuery.ParamByName('servicio').AsInteger := servicio;
    ForaQuery.Open;

    if not ForaQuery.IsEmpty then
      result := ForaQuery.fieldbyname('fecha_confirmacion').Value;

  except
    result := '';
  end
end;

function TbaseDatos.fechaHoraNominas: String;
begin
try
    result := '';
    FOraSession.Username := 'SMARUSR';
    FOraSession.Password := 'USRSMAR';

    {$IfDef TESTMODE}
    FOraSession.Server   := 'NOMINAS_DESA';
    {$Else}
    FOraSession.Server   := 'NOMINAS';
    {$EndIf}

    FOraSession.Connected := true;
    ForaQuery.Close;

    ForaQuery.SQL.Add('select to_char(sysdate, ''dd/mm/yyyy hh24:mi:ss'') as now from dual ');

    ForaQuery.Open;

    result := ForaQuery.fieldbyname('now').asstring;

  except
    result := '';
  end

end;

function TbaseDatos.setAprobadoYQ(servicio: integer; username: string): boolean;
begin
  try
    result := True;
    FOraSession.Username := 'SMARUSR';
    FOraSession.Password := 'USRSMAR';
    {$IfDef TESTMODE}
    FOraSession.Server   := 'NOMINAS_DESA';
    {$Else}
    FOraSession.Server   := 'NOMINAS';
    {$EndIf}

    FOraSession.Connected := true;
    FOraSession.StartTransaction;
    ForaQuery.Close;

    ForaQuery.SQL.Add('update servicios_maritimos.servicio set aprobado = ''t'', fecha_aprobado = sysdate, ');
    ForaQuery.SQL.Add('usuario_aprobado = :username, servicio_declarado = 2 ');
    ForaQuery.SQL.Add('where nro_solicitud = :servicio ');

    ForaQuery.ParamByName('servicio').AsInteger := servicio;
    ForaQuery.ParamByName('username').AsString := username;

    ForaQuery.SQL.SaveToFile('./sql.txt');
    ForaQuery.ExecSQL;
    ForaQuery.Connection.Commit;
  except
    result := False;
    ForaQuery.connection.rollback;
  end
end;

function TbaseDatos.fechaProcesando(servicio: integer): string;
begin
  try
    result := '';
    FOraSession.Username := 'SMARUSR';
    FOraSession.Password := 'USRSMAR';

    {$IfDef TESTMODE}
    FOraSession.Server   := 'NOMINAS_DESA';
    {$Else}
    FOraSession.Server   := 'NOMINAS';
    {$EndIf}

    FOraSession.Connected := true;
    ForaQuery.Close;

    ForaQuery.SQL.Add('select to_char(fecha_procesando,''dd/mm/yyyy hh24:mi:ss'')as fecha_procesando from servicios_maritimos.servicio where ');
    ForaQuery.SQL.Add(' nro_solicitud = :servicio ');

    ForaQuery.ParamByName('servicio').AsInteger := servicio;
    ForaQuery.Open;

    if not ForaQuery.IsEmpty then
      result := ForaQuery.fieldbyname('fecha_procesando').Value;

  except
    result := '';
  end

end;

end.

