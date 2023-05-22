{
  [ Agregado: 30/08/2007 ]

  Esta unidad a sido agregada para la generación de un archivo con formato XML con los tránsitos
  que no han sido actualizados en central. Pensado para aquellos pasos que no poseen un vínculo
  directo con central.
  Los archivos con formato XML generados son enviados a central vía HTTP.

  Nota: Una mejor forma de hacer esto es generando un servicio aparte para las tareas antes
  mencionadas evitando mezclar las tareas del actualizador de lista de control con la generación
  y envío de los archivos con tránsitos sin actualizar en central.
}

unit uTransits;

interface

uses
  uGlobal;

  function ProcessTransits(log : PTLog; basename : String) : Boolean;

implementation

uses
  uutils, uconsts, Classes, Windows, SysUtils, IBDatabase, IBStoredProc, Provider, DBClient,
  DB, StrUtils, IBQuery, IdFTP, UDatosFuentes, UGlobalFunctions, DateUtils, IdException;

var
  glb_id_loc : String;
  glb_buffer : Array[1..8192] of Byte;

procedure SetDataBase(var db : TIBDatabase; name, user, pwd, charset : String);
begin
  db.Params.Clear;
  db.LoginPrompt := False;
  db.DatabaseName := name;
  db.Params.Add(Format('user_name=%s', [user]));
  db.Params.Add(Format('password=%s', [pwd]));
  db.Params.Add(Format('lc_ctype=%s', [charset]));
end;

procedure SetTransaction(var trn : TIBTransaction; db : TIBDataBase);
begin
  trn.Params.Clear;
  trn.DefaultDatabase := db;
  trn.Params.Add('read_committed');
  trn.Params.Add('rec_version');
  trn.Params.Add('nowait');
end;

procedure OpenDataBaseConection(db : TIBDatabase);
begin
  if db.Connected then
    Exit;
  db.Open;
end;

procedure CloseDatabaseConnection(db : TIBDatabase);
begin
  if db.Connected then
    db.Close;
end;

procedure Start(trn : TIBTransaction);
begin
  if not trn.InTransaction then
    trn.StartTransaction;
end;

procedure Commit(trn : TIBTransaction);
begin
  if trn.InTransaction then
    trn.Commit;
end;

procedure Rollback(trn : TIBTransaction);
begin
  if trn.InTransaction then
    trn.Rollback;
end;

procedure SetNull(p : TParam);
begin
  p.Clear;
  p.Bound := True;
end;

procedure QueryIdLoc(qry : TIBQuery);
begin
  glb_id_loc := '';
  try
    Start(qry.Transaction);
    qry.Open;
    if not qry.FieldByName('ID_LOC').IsNull then
      glb_id_loc := qry.FieldByName('ID_LOC').AsString;
    Commit(qry.Transaction);
  except
    Rollback(qry.Transaction);
    raise Exception.Create('Error al consultar el IDLOC.');
  end;
end;

procedure QueryTransits(qry : TIBQuery; cds : TClientDataSet);
begin
  try
    Start(qry.Transaction);
    cds.Params.Clear;
    cds.FetchParams;
    SetNull(cds.Params.ParamByName('PFECHADESDE'));
    SetNull(cds.Params.ParamByName('PFECHAHASTA'));
    cds.Params.ParamByName('PACTUALIZADO').Value := 'F';
    cds.Open;
    Commit(qry.Transaction);
  except
    Rollback(qry.Transaction);
    raise Exception.Create('Fallo al consultar los tránsitos.');
  end;
end;

procedure PutInFileStream(s : String; xmlfile : TFileStream);
begin
  StrCopy(@glb_buffer, PChar(s));
  xmlfile.Write(glb_buffer, Length(s));
end;

procedure PutXMLRow(cds : TClientDataSet; xmlfile : TFileStream);
var
  f : Integer;
  s : String;
begin
  PutInFileStream('<ROW ', xmlfile);
  for f := 0 to cds.Fields.Count - 1 do
    if not cds.Fields[f].IsBlob then
    begin
      if cds.Fields[f].DataType in [ftDate, ftTime, ftDateTime] then
      begin
        if cds.Fields[f].IsNull then
          s := Format('%s=""', [cds.Fields[f].DisplayName])
        else
        begin
          DateTimeToString(s, 'dd/mm/yyyy hh:nn:ss', cds.Fields[f].AsDateTime);
          s := Format('%s="%s"', [cds.Fields[f].DisplayName, s]);
        end;
      end
      else
        s := Format('%s="%s"', [cds.Fields[f].DisplayName, cds.Fields[f].AsString]);

      if f < cds.Fields.Count - 1 then
        s := s + ' ';

      PutInFileStream(s, xmlfile);
    end;
  PutInFileStream('/>', xmlfile);
end;

procedure PutXMLRows(cds : TClientDataset; xmlfile : TFileStream);
begin
  while not cds.Eof do
  begin
    PutXMLRow(cds, xmlfile);
    cds.Next;
  end;
end;

procedure PutXMLHeader(xmlfile : TFileStream);
begin
  PutInFileStream('<?xml version="1.0" encoding="ISO-8859-1"?>', xmlfile);
end;

procedure PutXMLRootFirstTag(xmlfile : TFileStream);
begin
  PutInFileStream('<DOCUMENTO>', xmlfile);
end;

procedure PutXMLRootLastTag(xmlfile : TFileStream);
begin
  PutInFileStream('</DOCUMENTO>', xmlfile);
end;

procedure PutXMLTypes(cds : TClientDataSet; xmlfile : TFileStream);
var
  f : Integer;
begin
  PutInFileStream('<TYPES ', xmlfile);
  for f := 0 to cds.Fields.Count - 1 do
    // Ignorar campos nulos.
    if not cds.Fields[f].IsBlob then
      PutInFileStream(Format('%s="%d"%s', [cds.Fields[f].DisplayName,
                                           Integer(cds.Fields[f].DataType),
                                           ifThen(f < cds.Fields.Count - 1, ' ', '')]), xmlfile);
  PutInFileStream('/>', xmlfile);
end;

procedure PutXMLFirstTag(xmlfile : TFileStream);
begin
  PutInFileStream('<TRANSITOS>', xmlfile);
end;

procedure PutXMLLastTag(xmlfile : TFileStream);
begin
  PutInFileStream('</TRANSITOS>', xmlfile);
end;

procedure GenerateXMLFile(cds : TClientDataSet);
var
  xmlfile : TFileStream;
  filename : String;
begin
  DateTimeToString(filename, 'yyyymmddhhnnss', Now);
  xmlfile := TFileStream.Create(g_workingdir + XML_GEN_DIR + filename + XML_EXT, fmCreate);
  PutXMLHeader(xmlfile);
  PutXMLRootFirstTag(xmlfile);
  PutXMLTypes(cds, xmlfile);
  PutXMLFirstTag(xmlfile);
  PutXMLRows(cds, xmlfile);
  PutXMLLastTag(xmlfile);
  PutXMLRootLastTag(xmlfile);
  xmlfile.Free;
end;

procedure MoveXMLFile(filename : String);
begin
  MoveFileEx(PAnsiChar(g_workingdir + XML_GEN_DIR + filename + XML_EXT),
             PAnsiChar(g_workingdir + XML_SENT_DIR + filename + XML_EXT),
             MOVEFILE_REPLACE_EXISTING or MOVEFILE_WRITE_THROUGH);
end;

procedure TestDir(ftp : TIdFTP);
begin
  try
    ftp.ChangeDir(glb_id_loc);
  except
    on E : EIdProtocolReplyError do
      if E.ReplyErrorCode = FTP_ACTION_NOT_TAKEN then
      begin
        ftp.MakeDir(glb_id_loc);
        ftp.ChangeDir(glb_id_loc);
      end
      else
        raise Exception.Create('Error de conexión con servidor FTP.');
  end;
end;

procedure SendXMLFiles;
var
  ftp : TIdFTP;
  searchrec : TSearchRec;
  sfile : TMemoryStream;
  r : Integer;
begin
  // El envío de los archivos con formato XML se hace a través de FTP.
  ftp := TIdFTP.Create(nil);
  sfile := TMemoryStream.Create;
  // Host FTP.
  ftp.Host := g_xmlsrvip;
  // Usuario no anónimo. Cargar usuario y password.
  ftp.Username := g_xmluser;
  ftp.Password := g_xmlpswrd;
  // Conectar si no lo estamos.
  if not ftp.Connected then
    ftp.Connect;
  ftp.ChangeDir(g_xmlputpath);
  TestDir(ftp);
  // Procesar todos los archivos del directorio donde se generan los archivos. Una vez procesado un archivo
  // se mueve a otra carpeta.
  r := FindFirst(g_workingdir + XML_GEN_DIR + '*' + XML_EXT, faArchive, searchrec);
  while r = 0 do
  begin
    // Cargar contenido del archivo en un stream.
    sfile.LoadFromFile(g_workingdir + XML_GEN_DIR + searchrec.Name);
    // Asegurar la copia desde el primer byte del stream.
    sfile.Position := 0;
    // Subir archivo a la ubicación remoto.
    ftp.Put(sfile, searchrec.Name);
    // A continuación subimos un archivo de confirmación indicando que el archivo con formato XML está
    // correcto.
    sfile.Clear;
    ftp.Put(sfile, ChangeFileExt(searchrec.Name, CONFIRMATION_FILE_EXT));
    // Por último se mueve el archivo con formato XML a otra carpeta.
    MoveXMLFile(ChangeFileExt(searchrec.Name, ''));
    // Buscar próximo archivo con extensión "XML_EXT".
    r := FindNext(searchrec);
  end;
  ftp.Disconnect;
  ftp.Free;
  sfile.Free;
end;

procedure UpdateTransits(sp : TIBStoredProc; cds : TClientDataSet);
begin
  try
    Start(sp.Transaction);
    cds.First;
    while not cds.Eof do
    begin
      sp.Prepare;
      sp.ParamByName('PID_OL_SICAM').Value := cds.FieldByName('IDTRAN_OL_SICAM').AsInteger;
      sp.ExecProc;
      cds.Next;
    end;
    Commit(sp.Transaction);
  except
    Rollback(sp.Transaction);
    raise Exception.Create('Fallo al actualizar los tránsitos.');
  end;
end;

procedure Step2;
{
  Consulta de tránsitos no actualizados en central. Se genera un archivo con formato XML con los tránsitos
  consultados.
  Todos los archivos XML generados anteriormente y que no pudieron ser enviados se envían junto con el
  último archivo generado.
  Se actualiza la marca de "tránsito actualizado en central".
}
var
  dbt : TIBDataBase;
  //dbs : TIBDataBase;
  trnt : TIBTransaction;
  //trns : TIBTransaction;
  qryt : TIBQuery;
  //qrys : TIBQuery;
  dspt : TDataSetProvider;
  cdst : TClientDataSet;
  updt : TIBStoredProc;
begin
  dbt := TIBDatabase.Create(nil);
  //dbs := TIBDatabase.Create(nil);
  trnt := TIBTransaction.Create(nil);
  //trns := TIBTransaction.Create(nil);
  qryt := TIBQuery.Create(nil);
  //qrys := TIBQuery.Create(nil);
  updt := TIBStoredProc.Create(nil);
  dspt := TDataSetProvider.Create(nil);
  cdst := TClientDataSet.Create(nil);

  // Base de tránsitos.
  SetDataBase(dbt, g_xmlbasename, g_xmlbaseuser, g_xmlbasepwd, g_xmlbasechrset);
  // Base SICaM. Notar que usamos el usuario y contraseña de la base transitos.
  //SetDataBase(dbs, basename, xmlbaseuser, xmlbasepwd, basechrset);

  SetTransaction(trnt, dbt);
  //SetTransaction(trns, dbs);

  qryt.Database := dbt;
  qryt.Transaction := trnt;
  qryt.SQL.Add(
    'SELECT * FROM CLTORATRANSITOSACTUALIZADOR(:PFECHADESDE, :PFECHAHASTA, :PACTUALIZADO)');
  updt.Database := dbt;
  updt.Transaction := trnt;
  updt.StoredProcName := 'UPDTRANSITOSACTUALIZADOR';

  dspt.DataSet := qryt;
  cdst.SetProvider(dspt);

  //qrys.Database := dbs;
  //qrys.Transaction := trns;
  //qrys.SQL.Add('SELECT DESCRIPCION AS ID_LOC FROM IDLOC');

  OpenDataBaseConection(dbt);
  //OpenDataBaseConection(dbs);

  // Obtener IDLOC.
  //QueryIdLoc(qrys);
  // Consulta de transitos no actualizados en central.
  QueryTransits(qryt, cdst);
  // Generar un archivo con formato XML con los tránsitos consultados anteriormente.
  GenerateXMLFile(cdst);
  // Enviar todos los posibles archivos con formato XML.
  SendXMLFiles;
  // Actualizar marca de "tránsito actualizado en central".
  UpdateTransits(updt, cdst);

  CloseDatabaseConnection(dbt);
  //CloseDatabaseConnection(dbs);

  cdst.Free;
  dspt.Free;
  updt.Free;
  qryt.Free;
  //qrys.Free;
  trnt.Free;
  //trns.Free;
  dbt.Free;
  //dbs.Free;
end;

{procedure Step2;
//
//  Copia los tránsitos con errores en la base SICaM a la base de tránsitos.
//  Los tránsitos en la base SICaM son actualizados apropiadamente para no volver a ser copiados en
//  el próximo proceso.
var
  dbs, dbt : TIBDataBase;
  trns, trnt : TIBTransaction;
  spI, spU : TIBStoredProc;
  qryE : TIBQuery;
  dsps : TDataSetProvider;
  cdss : TClientDataSet;
begin
  dbs := TIBDatabase.Create(nil);
  dbt := TIBDatabase.Create(nil);
  trns := TIBTransaction.Create(nil);
  trnt := TIBTransaction.Create(nil);
  spI := TIBStoredProc.Create(nil);
  spU := TIBStoredProc.Create(nil);
  qryE := TIBQuery.Create(nil);
  dsps := TDataSetProvider.Create(nil);
  cdss := TClientDataSet.Create(nil);

  SetDataBase(dbs, basename, baseuser, basepwd, basechrset);
  SetDataBase(dbt, xmlbasename, xmlbaseuser, xmlbasepwd, xmlbasechrset);

  SetTransaction(trns, dbs);
  SetTransaction(trnt, dbt);

  spI.Database := dbt;
  spI.Transaction := trnt;
  spI.StoredProcName := '';

  spU.Database := dbs;
  spU.Transaction := trns;
  spU.StoredProcName := '';

  qryE.Database := dbs;
  qryE.Transaction := trns;
  qryE.SQL.Add('');

  dsps.DataSet := qryE;
  cdss.SetProvider(dsps);

  OpenDataBaseConection(dbs);
  OpenDataBaseConection(dbt);

  QueryErroneous(qryE, cdss);
  InsertUpdateTransits(spI, spU, cdss);

  CloseDatabaseConnection(dbs);
  CloseDatabaseConnection(dbt);

  cdss.Free;
  dsps.Free;
  qryE.Free;
  spI.Free;
  spU.Free;
  trns.Free;
  trnt.Free;
  dbs.Free;
  dbt.Free;
end;}

procedure Step1(basename : String);
const
  UpdateNull            = 'UPDATE TRANSITOSERRONEOSACTUALIZADOR TE SET ACTUALIZADO = ''T'' WHERE NOT EXISTS(SELECT T.IDTRANSITOS FROM TRANSITOS T WHERE TE.IDTRANSITO = T.IDTRANSITOS)';
  QryErrTran            = 'SELECT * FROM TRANSITOSERRONEOSACTUALIZADOR WHERE ACTUALIZADO = ''F''';
  QryUPDErrTran         = 'UPDATE TRANSITOSERRONEOSACTUALIZADOR SET ACTUALIZADO = ''T'' WHERE IDTRANSITO = :PIDTRANSITO AND IDACCIONREPLICADOR = :PACCION AND IDUSUARIO = :PIDUSUARIO AND IDTIPOTRANSPORTE = :PIDTIPOTRANSPORTE';
  SPSelectTransitos     = 'SELECT * FROM CLTTRANSITOSACTUALIZADOR(:PIDTRANSITO,:PACCION,:PIDUSUARIO,:PIDTIPOTRANSPORTE)';
  SPInsertTransitos     = 'INSTRANSITOSACTUALIZADOR';
  SPSelectTripulantes   = 'SELECT * FROM CLTTRITPULANTESACTUALIZADOR(:PIDTRANSITO,:PACCION,:PIDUSUARIO,:PIDTIPOTRANSPORTE)';
var
  IBQrySicamDB  : TDatosFuentesIB;
  IBQryTranDB   : TDatosFuentesIB;
  SPInsert      : TIBStoredProc;
  IBConnection  : TIBDatabase;
  IBTran        : TIBTransaction;
  Action        : Integer;
  i, p          : Integer;
begin
  { Inicializo el query para la base de datos de sicam }
  IBQrySicamDB := TDatosFuentesIB.Create;

  p := Pos(':', basename);
  i := Length(basename);
  IBQrySicamDB.Location := Copy(basename, 1, p - 1);
  IBQrySicamDB.DBPath   := Copy(basename, p + 1, i - p);
  IBQrySicamDB.User     := g_xmlbaseuser;
  IBQrySicamDB.Password := g_xmlbasepwd;
  IBQrySicamDB.Conectar;

  // Primero obtener el IDLOC.
  IBQrySicamDB.FQuery.SQL.Add('SELECT DESCRIPCION AS ID_LOC FROM IDLOC');
  QueryIdLoc(IBQrySicamDB.FQuery);

  IBQrySicamDB.InicializarAux;

  // SETEA EL CAMNPO ACTUALIZADO EN FALSE PARA LOS TRANSITOS QUE ESTAN COMO
  // ERRONEOS PERO NO SE INSERTARON EN TRANSITOS
  IBQrySicamDB.FSQL2.SQL.Text:= UpdateNull;
  IBQrySicamDB.FSQL2.Transaction.StartTransaction;
  IBQrySicamDB.FSQL2.ExecQuery;
  IBQrySicamDB.FSQL2.Transaction.Commit;
  // SETEA EL CAMNPO ACTUALIZADO EN FALSE PARA LOS TRANSITOS QUE ESTAN COMO
  // ERRONEOS PERO NO SE INSERTARON EN TRANSITOS

  IBQrySicamDB.FSQL2.SQL.Text:= QryUPDErrTran;

  { Inicializo el query para la base de datos de sicam }
  IBQryTranDB := TDatosFuentesIB.Create;

  p := Pos(':', g_xmlbasename);
  i := Length(g_xmlbasename);
  IBQryTranDB.Location  := Copy(basename, 1, p - 1);
  IBQryTranDB.DBPath    := Copy(basename, p + 1, i - p);
  IBQryTranDB.User      := g_xmlbaseuser;
  IBQryTranDB.Password  := g_xmlbasepwd;
  IBQryTranDB.Conectar;

  { Stored que inserta los transitos granadeados }
  { Inicializo }
  SPInsert      := TIBStoredProc.Create(Nil);
  IBConnection  := TIBDatabase.Create(Nil);
  IBTran        := TIBTransaction.Create(Nil);

  IBTran.Params.Add('read_committed');
  IBTran.Params.Add('rec_version');
  IBTran.Params.Add('nowait');

  { Seteo Propiedades }
  IBConnection.Params.Add(Format('user_name=%s', [g_xmlbaseuser]));
  IBConnection.Params.Add(Format('password=%s', [g_xmlbasepwd]));
  IBConnection.Params.Add(Format('lc_ctype=%s', [g_xmlbasechrset]));
  IBConnection.LoginPrompt := False;
  IBConnection.AllowStreamedConnected := False;
  IBConnection.DatabaseName := g_xmlbasename;
  IBConnection.Open;

  IBTran.DefaultDatabase:= IBConnection;

  SPInsert.Database := IBConnection;
  SPInsert.Transaction := IBTran;
  SPInsert.StoredProcName := SPInsertTransitos;

  IBQrySicamDB.FTransaction.StartTransaction;
  IBQrySicamDB.FQuery.SQL.Text := QryErrTran;
  IBQrySicamDB.FQuery.Open;
  IBQrySicamDB.FQuery.First;

  try
    While Not IBQrySicamDB.FQuery.Eof do
    begin
      try
        { Cierro y limpio el query del Stored para iterar el proximo }
        IBQryTranDB.FQuery.Close;
        IBQryTranDB.FQuery.SQL.Clear;

        { Depende el tipo de accion llamo al stored de tripulantes
          o transitos }
        Action := IBQrySicamDB.FQuery.FieldByName('IDACCIONREPLICADOR').AsInteger;

        if (Action = 0) or (Action = 1) then
          IBQryTranDB.FQuery.SQL.Text := SPSelectTransitos
        else
          IBQryTranDB.FQuery.SQL.Text := SPSelectTripulantes;

        if IBQrySicamDB.FQuery.FieldByName('IDTRANSITO').AsInteger > 0 then
        begin
          if not IBQryTranDB.FTransaction.InTransaction then
            IBQryTranDB.FTransaction.StartTransaction;

          { LLeno los datos del Stored }
          IBQryTranDB.FQuery.Prepare;

          With IBQryTranDB.FQuery do
          begin
            ParamByName('PIDTRANSITO').asInteger      := IBQrySicamDB.FQuery.FieldByName('IDTRANSITO').AsInteger;
            ParamByName('PACCION').asInteger          := IBQrySicamDB.FQuery.FieldByName('IDACCIONREPLICADOR').AsInteger;
            ParamByName('PIDUSUARIO').asInteger       := IBQrySicamDB.FQuery.FieldByName('IDUSUARIO').AsInteger;
            ParamByName('PIDTIPOTRANSPORTE').asInteger:= IBQrySicamDB.FQuery.FieldByName('IDTIPOTRANSPORTE').AsInteger;
          end;
          IBQryTranDB.FQuery.Open;

          { Pongo en NULL todos los parametros }
          if not SPInsert.Transaction.InTransaction then
            SPInsert.Transaction.StartTransaction;

          SPInsert.Prepare;
          for i:= 0 to SPInsert.ParamCount - 1 do
          Begin
            SPInsert.Params[i].Clear;
            SPInsert.Params[i].Bound:= True;
          end;

          { Seteo los parametros con el select }
          for i:= 0 to IBQryTranDB.FQuery.FieldCount - 1 do
            if not IBQryTranDB.FQuery.Fields[i].IsNull then
              SPInsert.ParamByName('P'+ IBQryTranDB.FQuery.Fields[i].FieldName).Value := IBQryTranDB.FQuery.Fields[i].Value;

          if IBQrySicamDB.FQuery.FieldByName('FECHA').IsNull then
            SPInsert.ParamByName('PRFECHAREGISTRO').Value:= IncHour(IBQryTranDB.FQuery.FieldByName('RTRANSITOFECHA').Value,2)
          else
            SPInsert.ParamByName('PRFECHAREGISTRO').Value:= IBQrySicamDB.FQuery.FieldByName('FECHA').Value;

          SPInsert.ParamByName('PRIDLOC').Value := glb_id_loc;

          SPInsert.ExecProc;
          SPInsert.Transaction.Commit;
          IBQryTranDB.FTransaction.Commit;
        end;

        if not IBQrySicamDB.FSQL2.Transaction.InTransaction then
          IBQrySicamDB.FSQL2.Transaction.StartTransaction;

        With IBQrySicamDB.FSQL2 do
          begin
            ParamByName('PIDTRANSITO').asInteger      := IBQrySicamDB.FQuery.FieldByName('IDTRANSITO').AsInteger;
            ParamByName('PACCION').asInteger          := IBQrySicamDB.FQuery.FieldByName('IDACCIONREPLICADOR').AsInteger;
            ParamByName('PIDUSUARIO').asInteger       := IBQrySicamDB.FQuery.FieldByName('IDUSUARIO').AsInteger;
            ParamByName('PIDTIPOTRANSPORTE').asInteger:= IBQrySicamDB.FQuery.FieldByName('IDTIPOTRANSPORTE').AsInteger;
          end;

        IBQrySicamDB.FSQL2.ExecQuery;
        IBQrySicamDB.FSQL2.Transaction.Commit;
      except
        on FExceptionError:Exception do
        begin
          if SPInsert.Transaction.InTransaction then
            SPInsert.Transaction.Rollback;
          IBQrySicamDB.RollBack2;
        end;
      end;
      IBQrySicamDB.FQuery.Next;
    end;
  finally
    SecureFree(IBQrySicamDB);
    SecureFree(IBQryTranDB);
    SecureFree(SPInsert);
    SecureFree(SPInsert);
    SecureFree(IBConnection);
    SecureFree(IBTran);
  end;
end;

function ProcessTransits(log : PTLog; basename : String) : Boolean;
begin
  Result := False;
  try
    Step1(basename);
    Step2;
    Result := True;
  except
    on E : Exception do WriteLog(log, LOG_EXCEPTION_RAISED + '-' +
                                 StringReplace(E.Message, END_OF_LINE, '', [rfReplaceAll, rfIgnoreCase]));
  end;
end;

end.
