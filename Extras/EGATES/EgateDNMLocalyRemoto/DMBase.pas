{
Hay componentes IBX que se deben eliminar para pasarlos a sus equivalentes en FireDAC/Oracle
Se colocaron los componentes FireDAC y se trasncribieron todas las directivas posibles.
Falta definir la base de datos de Oracle para la conexion y completar las
definiciones de los store procedure y tables y los tipos de campos los parametros
}

unit DMBase;

interface

uses
  System.SysUtils, System.Classes, IBX.IBDatabase, Data.DB, EGateMgrWSIntf,
  IBX.IBCustomDataSet,
  IBX.IBQuery, IBX.IBStoredProc, IBX.IBTable, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type

  PersonData2 = class(PersonData)
  private
    FTRANSPORTE: string;
    FTIPO_PASAJERO: string;
    FPOSEE_IMPEDIMENTO: string;
    FFACE_SCORE: Integer;
    FDACTILAR_SCORE: Integer;
    FFECHA_EXPIRACION: string;
    FVUELO: string;
  published
    property TRANSPORTE: string read FTRANSPORTE write FTRANSPORTE;
    property TIPO_PASAJERO: string read FTIPO_PASAJERO write FTIPO_PASAJERO;
    property POSEE_IMPEDIMENTO: string read FPOSEE_IMPEDIMENTO
      write FPOSEE_IMPEDIMENTO;
    property FACE_SCORE: Integer read FFACE_SCORE write FFACE_SCORE;
    property DACTILAR_SCORE: Integer read FDACTILAR_SCORE write FDACTILAR_SCORE;
    property FECHA_EXPIRACION: string read FFECHA_EXPIRACION
      write FFECHA_EXPIRACION;
    property VUELO: string read FVUELO write FVUELO;
  end;

  TDMBaseIB = class(TDataModule)
    bdMain: TIBDatabase;
    trnMain: TIBTransaction;
    qry_PERSON_DATA: TIBQuery;
    SPINSTRANSACTION: TIBStoredProc;
    qryI_PERSON_DATA: TIBQuery;
    SPINSTRANRESULT: TIBStoredProc;
    qryRestricciones: TIBQuery;
    qryI_TRANSACTION_CLOSURE: TIBQuery;
    qryFACE_SCORE: TIBQuery;
    qryDACTILAR_SCORE: TIBQuery;
    ibtblConfiguracion: TIBTable;
    ibtblConfiguracionID: TIntegerField;
    ibtblConfiguracionCLAVE: TIBStringField;
    ibtblConfiguracionVALOR: TIBStringField;
    ibtblConfiguracionNOTAS: TIBStringField;
    qry_IDLOC: TIBQuery;
    qry1: TIBQuery;
    qry2: TIBQuery;
    SPINSEVENTO: TIBStoredProc;
    qry3: TIBQuery;
    qryPersonFlight: TIBQuery;
    qry_INS_MANIFIESTO: TIBQuery;
    bdMain_: TFDConnection;
    trmMain_: TFDTransaction;
    qry1_: TFDQuery;
    qry2_: TFDQuery;
    qry3_: TFDQuery;
    qry_IDLOC_: TFDQuery;
    qryDACTILAR_SCORE_: TFDQuery;
    qryFACE_SCORE_: TFDQuery;
    qryPersonFlight_: TFDQuery;
    qry_INS_MANIFIESTO_: TFDCommand;
    qryI_TRANSACTION_CLOSURE_: TFDCommand;
    qryRestricciones_: TFDCommand;
    qry_PERSON_DATA_: TFDQuery;
    qryI_PERSON_DATA_: TFDCommand;
    SPINSTRANSACTION_: TFDStoredProc;
    INSEVENTO_: TFDStoredProc;
    SPINSTRANRESULT_: TFDStoredProc;
    ibtblConfiguracion_: TFDTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure inicializar;
    function DBPersonData(transactionId: string): PersonData2;
    procedure BDInstTrans(PIDTRAN, PEGATE, PSENTIDO: string;
      Pidgate_log: Integer);
    procedure BDInstResult(PTRANSACTIONID: string; PERROR, PRESCODE: Integer;
      PSTATUS: string);
    procedure DBInstPersona(transactionId: string; P: PersonData2; MRZ: string);
    procedure DBRestriccion(transactionId, TRANSPORTE, TIPO_PASAJERO,
      POSEE_IMPEDIMENTO: string);
    procedure DBTRANSACTION_CLOSURE(transactionId: string;
      MANUAL_OPENED, ELEGIBILIDAD: Integer);
    procedure BDFACE_SCORE(transactionId: string; SCORE: Integer);
    procedure BDDACTILAR_SCORE(transactionId: string; SCORE: Integer);
    function DBSentido(egateID: string): string;
    function DBUsuarios(egateID: string; var usuario: string;
      var IdGate_log: Integer): Boolean;
    procedure DBTransaction(transactionId: string;
      var sentido, usuario: string);
    function DBGroupDirection(unGrupo: string): string;
    function DBChangeGroupDirection(unGrupo: string): string;
    procedure CargarConf;
    procedure DBINSEVENTO(PTRANSACTIONID:string;
                          PEVENTTYPE:Integer;
                          PFECHA:TDateTime;
                          PEVENTDESC:string);

    function DBEgateIP(egateID:string):string;
    function DBFechaHora:TDateTime;
    function DBLstGroup:GrupoArray;
    function DBSetPersonFlight(transactionId: string; Flight: string):Integer;
    function DBInstManifiesto(transactionId: string; nombre: string):Integer;
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

uses
  System.IniFiles, uGlobal, EgateFunciones;

procedure StartTransaction(Trn: TIBTransaction);
{
  Comienza una transacci�n si la misma no se encuentra ya en progreso.
}
begin
  if not Trn.InTransaction then
    Trn.StartTransaction;
end;

procedure Commit(Trn: TIBTransaction);
begin
  if Trn.InTransaction then
    Trn.Commit;
end;

procedure Rollback(Trn: TIBTransaction);
begin
  // Generalmente la parte del commit de una transacci�n se pone dentro de un try ... except. No pasa lo
  // mismo con el rollback. El rollback se pone entre el except ... end del bloque. Por lo tanto si se
  // produce una excepci�n antes del rollback, la misma no ser� trapeada. Por esta raz�n el try ... except
  // del rollback est� dentro de esta funci�n.
  try
    if Trn.InTransaction then
      Trn.Rollback;
  except
  end;
end;

procedure TDMBaseIB.BDDACTILAR_SCORE(transactionId: string; SCORE: Integer);
begin
  try
    StartTransaction(trnMain);

    qryDACTILAR_SCORE.SQL.Text :=
      'UPDATE PERSON_DATA set DACTILAR_SCORE = :DACTILAR_SCORE where TRANSACTIONID = :TRANSACTIONID';
    qryDACTILAR_SCORE.ParamByName('TRANSACTIONID').AsString := transactionId;
    qryDACTILAR_SCORE.ParamByName('DACTILAR_SCORE').AsInteger := SCORE;
    qryDACTILAR_SCORE.ExecSQL;

    Commit(trnMain);
  except
    on E: Exception do
    begin
      Rollback(trnMain);
      raise Exception.Create(E.Message);
    end;
  end;

end;

procedure TDMBaseIB.BDFACE_SCORE(transactionId: string; SCORE: Integer);
begin
  try
    StartTransaction(trnMain);

    qryFACE_SCORE.SQL.Text :=
      'UPDATE PERSON_DATA set FACE_SCORE = :FACE_SCORE where TRANSACTIONID = :TRANSACTIONID';
    qryFACE_SCORE.ParamByName('TRANSACTIONID').AsString := transactionId;
    qryFACE_SCORE.ParamByName('FACE_SCORE').AsInteger := SCORE;
    qryFACE_SCORE.ExecSQL;

    Commit(trnMain);
  except
    on E: Exception do
    begin
      Rollback(trnMain);
      raise Exception.Create(E.Message);
    end;
  end;

end;

procedure TDMBaseIB.BDInstResult(PTRANSACTIONID: string;
  PERROR, PRESCODE: Integer; PSTATUS: string);
begin
  try
    StartTransaction(trnMain);

    SPINSTRANRESULT.ParamByName('PTRANSACTIONID').AsString := PTRANSACTIONID;
    SPINSTRANRESULT.ParamByName('PERROR').AsInteger := PERROR;
    SPINSTRANRESULT.ParamByName('PRESCODE').AsInteger := PRESCODE;
    SPINSTRANRESULT.ParamByName('PSTATUS').AsString := PSTATUS;
    SPINSTRANRESULT.ExecProc;

    Commit(trnMain);
  except
    on E: Exception do
    begin
      Rollback(trnMain);
      raise Exception.Create(E.Message);
    end;

  end;
end;

procedure TDMBaseIB.BDInstTrans(PIDTRAN, PEGATE, PSENTIDO: string;
  Pidgate_log: Integer);
begin
  try
    StartTransaction(trnMain);

    SPINSTRANSACTION.ParamByName('PIDTRAN').AsString := PIDTRAN;
    SPINSTRANSACTION.ParamByName('PEGATE').AsString := PEGATE;
    SPINSTRANSACTION.ParamByName('PSENTIDO').AsString := PSENTIDO;
    SPINSTRANSACTION.ParamByName('PIDGATE_LOG').AsInteger := Pidgate_log;
    SPINSTRANSACTION.ExecProc;

    Commit(trnMain);
  except
    on E: Exception do
    begin
      Rollback(trnMain);
      raise Exception.Create(E.Message);
    end;
  end;

end;

procedure TDMBaseIB.CargarConf;
begin
  try
    StartTransaction(trnMain);
    ibtblConfiguracion.Open;
    while not ibtblConfiguracion.Eof do
    begin
      case ibtblConfiguracion.FieldByName('ID').AsInteger of
        0:
          IDLOC := ibtblConfiguracion.FieldByName('valor').Value;
        1:
          wsRestriccionEntrada := ibtblConfiguracion.FieldByName('valor').Value;
        2:
          wsRestriccionSalida := ibtblConfiguracion.FieldByName('valor').Value;
        3:
          wsBiometric := ibtblConfiguracion.FieldByName('valor').Value;
        4:
          wsfingerMatch := ibtblConfiguracion.FieldByName('valor').Value;
        5:
          wstransitosarchivoEntrada := ibtblConfiguracion.FieldByName
            ('valor').Value;
        6:
          wstransitosarchivoSalida := ibtblConfiguracion.FieldByName
            ('valor').Value;
        7:
          wsbiometricdevices := ibtblConfiguracion.FieldByName('valor').Value;
        10:
          TIPO_MEDIO_TRANSPORTE := ibtblConfiguracion.FieldByName
            ('valor').Value;

        20:wsbiometric2 := ibtblConfiguracion.FieldByName('valor').Value;
        21:wsfingerMatch2 := ibtblConfiguracion.FieldByName('valor').Value;
      end;
      ibtblConfiguracion.Next;
    end;
    ibtblConfiguracion.Close;

    Commit(trnMain);
  except
    on E: Exception do
    begin
      Rollback(trnMain);
      raise Exception.Create(E.Message);
    end;

  end;
end;

procedure TDMBaseIB.DataModuleCreate(Sender: TObject);
begin
  inicializar;
end;

function TDMBaseIB.DBChangeGroupDirection(unGrupo: string): string;
begin
  Result := DBGroupDirection(unGrupo);

  if Result = 'ERROR' then
    Exit;

  try
    StartTransaction(trnMain);
    qry1.Close;
    qry1.SQL.Clear;
    qry1.SQL.Text :=
      'UPDATE GRUPOS_PUERTAS set SENTIDO = :SENTIDO where GRUPO = :GRUPO ';
    qry1.ParamByName('GRUPO').AsString := unGrupo;
    qry1.ParamByName('SENTIDO').AsString := iif(Result = 'E', 'S', 'E');
    qry1.ExecSQL;
    Commit(trnMain);
  finally
    Rollback(trnMain);
  end;

  Result := iif(Result = 'E', 'S', 'E');

end;

function TDMBaseIB.DBEgateIP(egateID: string): string;
begin
  try
    StartTransaction(trnMain);
    qry1.Close;
    qry1.SQL.Clear;
    qry1.SQL.Text :=
      'select * '
      + '  from PUERTAS '
      + ' Where egateid = :egateid  ';
    qry1.ParamByName('egateid').AsString := egateID;
    qry1.Open;

    if qry1.IsEmpty then
    begin
      Result := '';
      Exit;
    end;

    Result := qry1.FieldByName('IP').AsString;

    Commit(trnMain);
  finally
    Rollback(trnMain);
  end;
end;

function TDMBaseIB.DBFechaHora: TDateTime;
begin
  try
    StartTransaction(trnMain);
    qry1.Close;
    qry1.SQL.Clear;
    qry1.SQL.Text := 'SELECT CURRENT_TIMESTAMP AS fechaHora FROM RDB$DATABASE';
    qry1.Open;
    Result := qry1.FieldByName('fechaHora').AsDateTime;
    Commit(trnMain);
  except
    Result := Now;
    Rollback(trnMain);
  end;
end;

function TDMBaseIB.DBGroupDirection(unGrupo: string): string;
begin
  try
    StartTransaction(trnMain);
    qry1.Close;
    qry1.SQL.Clear;
    qry1.SQL.Text := 'SELECT * FROM GRUPOS_PUERTAS where GRUPO = :GRUPO ';
    qry1.ParamByName('GRUPO').AsString := unGrupo;
    qry1.Open;
    if qry1.IsEmpty then
    begin
      Result := 'ERROR';
      Exit;
    end;
    Result := qry1.FieldByName('SENTIDO').AsString;
    Commit(trnMain);
  except
    Rollback(trnMain);
  end;
end;

procedure TDMBaseIB.DBINSEVENTO(PTRANSACTIONID: string; PEVENTTYPE: Integer;
  PFECHA: TDateTime; PEVENTDESC: string);
begin
  try
    StartTransaction(trnMain);
    SPINSEVENTO.ParamByName('PTRANSACTIONID').Value := PTRANSACTIONID;
    SPINSEVENTO.ParamByName('PEVENTTYPE').Value := PEVENTTYPE;
    SPINSEVENTO.ParamByName('PFECHA').Value := PFECHA;
    SPINSEVENTO.ParamByName('PEVENTDESC').Value := Copy(PEVENTDESC,1,99);
    SPINSEVENTO.ExecProc;
    Commit(trnMain);
  except
    Rollback(trnMain);
  end;
end;

function TDMBaseIB.DBInstManifiesto(transactionId, nombre: string): Integer;
begin
  try

    StartTransaction(trnMain);

    qry_INS_MANIFIESTO.SQL.Text :=
      'INSERT INTO MANIFIESTOS (TRANSACTIONID, NOMBRE,FECHA) VALUES (:TRANSACTIONID, :NOMBRE, :FECHA);';
    qry_INS_MANIFIESTO.ParamByName('TRANSACTIONID').AsString := transactionId;
    qry_INS_MANIFIESTO.ParamByName('NOMBRE').AsString := NOMBRE;
    qry_INS_MANIFIESTO.ParamByName('FECHA').AsDateTime := Now;
    qry_INS_MANIFIESTO.ExecSQL;

    Commit(trnMain);
    Result := 0;
  except
    on E: Exception do
    begin
      grabarEnArchivoLog('DBInstManifiesto:'+e.Message);
      Rollback(trnMain);
      Result := -2
    end;
  end;
end;

procedure TDMBaseIB.DBInstPersona(transactionId: string; P: PersonData2;
  MRZ: String);
begin
  try
    StartTransaction(trnMain);
    qryI_PERSON_DATA.ParamByName('TRANSACTIONID').Value := transactionId;
    qryI_PERSON_DATA.ParamByName('DOC_TIPO').Value := P.docType;
    qryI_PERSON_DATA.ParamByName('DOC_SUBTIPO').Value := P.subDocType;
    qryI_PERSON_DATA.ParamByName('DOC_NUMERO').Value := P.docNumber;
    qryI_PERSON_DATA.ParamByName('NOMBRE').Value := P.firstName;
    qryI_PERSON_DATA.ParamByName('APELLIDO').Value := P.lastName;
    qryI_PERSON_DATA.ParamByName('ISSUING_COUNTRY').Value := P.issuingCountry;
    qryI_PERSON_DATA.ParamByName('NACIONALIDAD').Value := P.nationality;
    qryI_PERSON_DATA.ParamByName('PASAPORTE').Value := P.passportNumber;
    qryI_PERSON_DATA.ParamByName('SEXO').Value := P.sex;
    qryI_PERSON_DATA.ParamByName('TRANSPORTE').Value := 'X';
    qryI_PERSON_DATA.ParamByName('TIPO_PASAJERO').Value := 'X';
    qryI_PERSON_DATA.ParamByName('FECHA_NAC').Value := P.dob;
    qryI_PERSON_DATA.ParamByName('FECHA_EXPIRACION').Value :=
      P.FECHA_EXPIRACION;
    qryI_PERSON_DATA.ParamByName('POSEE_IMPEDIMENTO').Value := 'X';
    qryI_PERSON_DATA.ParamByName('MRZ').Value := MRZ;
    qryI_PERSON_DATA.ExecSQL;

    Commit(trnMain);
  except
    Rollback(trnMain);
  end;

end;

function TDMBaseIB.DBLstGroup: GrupoArray;
var
  cant,i:Integer;
  gr:Grupo;
begin
  try
    StartTransaction(trnMain);
    qry3.Close;
    qry3.SQL.Text := 'select count(1) as Cant from GRUPOS_PUERTAS';
    qry3.Open;

    cant := qry3.FieldByName('Cant').AsInteger;
    Commit(trnMain);

    SetLength(Result,cant);

    StartTransaction(trnMain);
    qry3.Close;
    qry3.SQL.Text := 'select * from GRUPOS_PUERTAS';
    qry3.Open;
    i:=0;
    while not qry3.Eof do
    begin
      gr := Grupo.Create;
      gr.IDGRUPO := qry3.FieldByName('IDGRUPO').AsString;
      gr.DESCRIPCION := qry3.FieldByName('DESCRIPCION').AsString;
      gr.SENTIDO := qry3.FieldByName('SENTIDO').AsString;
      gr.ESTADO := qry3.FieldByName('ESTADO').AsInteger=1;

      Result[i]:= gr;

      i:=i+1;
      qry3.Next;
    end;
    Commit(trnMain);

  except
    on E: Exception do
    begin
      Rollback(trnMain);
      raise Exception.Create(E.Message);
    end;
  end;

//ssss
end;

function TDMBaseIB.DBPersonData(transactionId: string): PersonData2;
begin
  Result := nil;
  try
    StartTransaction(trnMain);
    qry_PERSON_DATA.Close;
    qry_PERSON_DATA.SQL.Clear;
    qry_PERSON_DATA.SQL.Text :=
      'SELECT * FROM PERSON_DATA WHERE transactionId = ' +
      QuotedStr(transactionId);
    qry_PERSON_DATA.Open;

    if qry_PERSON_DATA.IsEmpty then
      Exit;

    Result := PersonData2.Create;
    with Result do
    begin
      docType := qry_PERSON_DATA.FieldByName('DOC_TIPO').Value;
      subDocType := qry_PERSON_DATA.FieldByName('DOC_SUBTIPO').Value;
      docNumber := qry_PERSON_DATA.FieldByName('DOC_NUMERO').Value;
      firstName := qry_PERSON_DATA.FieldByName('NOMBRE').Value;
      lastName := qry_PERSON_DATA.FieldByName('APELLIDO').Value;
      issuingCountry := qry_PERSON_DATA.FieldByName('ISSUING_COUNTRY').Value;
      nationality := qry_PERSON_DATA.FieldByName('NACIONALIDAD').Value;
      passportNumber := qry_PERSON_DATA.FieldByName('PASAPORTE').Value;
      sex := qry_PERSON_DATA.FieldByName('SEXO').Value;
      dob := qry_PERSON_DATA.FieldByName('FECHA_NAC').AsString;
      TRANSPORTE := qry_PERSON_DATA.FieldByName('TRANSPORTE').AsString;
      TIPO_PASAJERO := qry_PERSON_DATA.FieldByName('TIPO_PASAJERO').AsString;
      POSEE_IMPEDIMENTO := qry_PERSON_DATA.FieldByName
        ('POSEE_IMPEDIMENTO').AsString;
      FECHA_EXPIRACION := qry_PERSON_DATA.FieldByName
        ('FECHA_EXPIRACION').AsString;
      try
        FACE_SCORE := qry_PERSON_DATA.FieldByName('FACE_SCORE').AsInteger;
        DACTILAR_SCORE := qry_PERSON_DATA.FieldByName('DACTILAR_SCORE')
          .AsInteger;
      except
      end;

      try
        VUELO := qry_PERSON_DATA.FieldByName('VUELO').AsString;
      except
        VUELO := '';
      end;
    end;

    Commit(trnMain);
  except
    Rollback(trnMain);
  end;
end;

procedure TDMBaseIB.DBRestriccion(transactionId, TRANSPORTE, TIPO_PASAJERO,
  POSEE_IMPEDIMENTO: string);
begin
  try
    StartTransaction(trnMain);
    qryRestricciones.ParamByName('TRANSACTIONID').AsString := transactionId;
    qryRestricciones.ParamByName('TRANSPORTE').AsString := TRANSPORTE;
    qryRestricciones.ParamByName('TIPO_PASAJERO').AsString := TIPO_PASAJERO;
    qryRestricciones.ParamByName('POSEE_IMPEDIMENTO').AsString :=
      POSEE_IMPEDIMENTO;
    qryRestricciones.ExecSQL;

    Commit(trnMain);
  except
    on E: Exception do
    begin
      Rollback(trnMain);
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TDMBaseIB.DBSentido(egateID: string): string;
begin
  try
    StartTransaction(trnMain);
    qry1.Close;
    qry1.SQL.Clear;
    qry1.SQL.Text :=
      'select puertas.egateid, puertas.ip,grupos_puertas.grupo, grupos_puertas.estado, grupos_puertas.sentido from grupos_puertas '
      + '    inner join puertas on (grupos_puertas.idgrupo = puertas.idgrupo) '
      + ' Where puertas.egateid = :egateid and grupos_puertas.ESTADO=1 ';
    qry1.ParamByName('egateid').AsString := egateID;
    qry1.Open;

    if qry1.IsEmpty then
    begin
      Result := '';
      Exit;
    end;

    Result := qry1.FieldByName('sentido').AsString;

    Commit(trnMain);
  finally
    Rollback(trnMain);
  end;
end;

function TDMBaseIB.DBSetPersonFlight(transactionId, Flight: string): Integer;
begin
  try

    StartTransaction(trnMain);

    qryPersonFlight.SQL.Text :=
      'UPDATE PERSON_DATA set TRANSPORTE = :TRANSPORTE where TRANSACTIONID = :TRANSACTIONID';
    qryPersonFlight.ParamByName('TRANSACTIONID').AsString := transactionId;
    qryPersonFlight.ParamByName('TRANSPORTE').AsString := Flight;
    qryPersonFlight.ExecSQL;

    Commit(trnMain);
    Result := 0;
  except
    on E: Exception do
    begin
      Rollback(trnMain);
      Result := -2
    end;
  end;
end;

procedure TDMBaseIB.DBTransaction(transactionId: string;
  var sentido, usuario: string);
begin
  try
    StartTransaction(trnMain);
    qry1.Close;
    qry1.SQL.Clear;
    qry1.SQL.Text :=
      'select egate_transaction.sentido, gate_log.usuario, egate_transaction.egateid '
      + ' from egate_transaction ' +
      ' inner join gate_log on (egate_transaction.idgate_log = gate_log.idgate_log) '
      + ' where TRANSACTIONID = :TRANSACTIONID ';
    qry1.ParamByName('TRANSACTIONID').AsString := transactionId;
    qry1.Open;

    sentido := qry1.FieldByName('sentido').AsString;
    usuario := qry1.FieldByName('usuario').AsString;

    Commit(trnMain);
  finally
    Rollback(trnMain);
  end;
end;

procedure TDMBaseIB.DBTRANSACTION_CLOSURE(transactionId: string;
  MANUAL_OPENED, ELEGIBILIDAD: Integer);
begin
  try
    StartTransaction(trnMain);
    qryI_TRANSACTION_CLOSURE.ParamByName('TRANSACTIONID').AsString :=
      transactionId;
    qryI_TRANSACTION_CLOSURE.ParamByName('MANUAL_OPENED').AsInteger :=
      MANUAL_OPENED;
    qryI_TRANSACTION_CLOSURE.ParamByName('ELEGIBILIDAD').AsInteger :=
      ELEGIBILIDAD;
    qryI_TRANSACTION_CLOSURE.ExecSQL;

    Commit(trnMain);
  except
    on E: Exception do
    begin
      Rollback(trnMain);
      raise Exception.Create(E.Message);
    end;

  end;
end;

function TDMBaseIB.DBUsuarios(egateID: string; var usuario: string;
  var IdGate_log: Integer): Boolean;
begin
  usuario := '';
  IdGate_log := -1;
  try
    StartTransaction(trnMain);
    qry1.Close;
    qry1.SQL.Clear;
    qry1.SQL.Text :=
//      ' select puertas.egateid, puertas.idgrupo, gate_log.usuario, gate_log.activo, gate_log.idgate_log '
//      + ' from gate_log inner join puertas on (gate_log.idgrupo = puertas.idgrupo) '
//      + ' Where puertas.egateid = :egateid and gate_log.activo=1 ';

    ' select puertas.egateid, puertas.idgrupo, gate_log.usuario, gate_log.activo, gate_log.idgate_log, grupos_puertas.estado, '+
    '    grupos_puertas.idgrupo from gate_log inner join puertas on (gate_log.idgrupo = puertas.idgrupo) '+
    '   inner join grupos_puertas on (puertas.idgrupo = grupos_puertas.idgrupo) '+
    ' where  (gate_log.activo = 1) and (grupos_puertas.estado = 1) and puertas.egateid = :egateid ';


    qry1.ParamByName('egateid').AsString := egateID;
    qry1.Open;

    qry1.Last;
    if qry1.IsEmpty then
    begin
      Result := False;
      Exit;
    end;
    qry1.Last;

    usuario := qry1.FieldByName('usuario').AsString;
    IdGate_log := qry1.FieldByName('idgate_log').AsInteger;

    Result := True;
    Commit(trnMain);
  finally
    Rollback(trnMain);
  end;
end;

procedure TDMBaseIB.inicializar;
var
  inifile: TIniFile;
begin
  bdMain.Connected := False;

  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    GLOBAL_DB := inifile.ReadString('Data Base', 'basedatos',
      '');
    // '10.170.15.8:D:\Basedatos\sicam.gdb');
  finally
    inifile.Free;
  end;

  bdMain.DatabaseName := GLOBAL_DB;
  bdMain.Open;
  trnMain.Active := True;

  CargarConf;
end;

end.




CREATE TABLE MANIFIESTOS (
    TRANSACTIONID  VARCHAR(60) NOT NULL,
    NOMBRE         VARCHAR(20),
    FECHA          TIMESTAMP
);



/******************************************************************************/
/***                              Primary Keys                              ***/
/******************************************************************************/

ALTER TABLE MANIFIESTOS ADD CONSTRAINT PK_MANIFIESTOS PRIMARY KEY (TRANSACTIONID);
