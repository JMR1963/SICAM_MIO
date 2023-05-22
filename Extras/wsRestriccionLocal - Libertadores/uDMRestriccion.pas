unit uDMRestriccion;
interface
uses
  vcl.Forms, vcl.Dialogs, System.SysUtils, System.Classes, IBX.IBDatabase, Data.DB, IBX.IBCustomDataSet, IBX.IBQuery, ADODB,
  MemDS, DBAccess, Ora, IWsListaControl_unif1,IpuenteApiMar1,Iws_obtener_autorizacion1,IWSActuaciones1,IwsRenaper1,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, vcl.Controls,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef;

const
  NullAsStringValue: string = '';
type
  TDMRestriccion = class(TDataModule)
    OraSession1: TOraSession;
    OraQuery1: TOraQuery;
    OraSession2: TOraSession;
    OraQuery2: TOraQuery;
    IBTransaction1: TFDTransaction;
    IBDatabase1: TFDConnection;
    qryBuscarNombre: TFDStoredProc;
    qryDocumentosRobados: TFDStoredProc;
    qryBuscarDoc: TFDStoredProc;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    InfTransp, sentido,transporteGral ,tipoPaso,BDrestriCentral, Paso, fuentes,urlInterpol,urlApiMar,urlTrans,
    urlMenores, urlSitMig,flagMenores, flagSitMig,otrasNacionalidades,otrosPaisesDoc,renaper,debug_aereo : String;

    { Public declarations }
    function BuscarListaControlPorNombres(Ape1, Ape2, Nom1,
      Nom2: string; fechaNac: TDateTime; var StringList,
                                          StringListFec: TStringList): Integer;
    function BuscarListaControlPorDocumentos(NroDoc : String;var StringList : TStringList; AcumLS:Boolean) : Integer;
    function BuscarDocumentosRobados(numerodoc : String) : Boolean;

    function TotalRestricciones(desdeDondeConsulto, pApe1, pApe2, pNom1, pNom2: string;
  fechaNac: TDateTime; pnroDoc, pnrolibreta, genero, tipoDoc, paisEmisorDoc, nacionalidad, fechaVTO: string; var Origen: string): Integer;

   // function InfTransporte(Ape1,ape2, nom1, nom2,  nroDoc, nrolibreta, sentidoVuelo: string; f:TDateTime; Var vuelo, pasajero, hayTransporte: string): boolean;
    function  DameCoincidenciasLogInterpol(pApe1, pApe2, pNom1, pNom2, fechaNac,  pnroDoc, pnrolibreta: string): boolean;
    function chequearAutorizacionOnline_esc(nro_doc, fechanac :string): tautorizacion;
    function chequearAutorizacionOnline_SACER(nro_doc, fechanac :string): tautorizacion_sacer;
    function consultoMenor(nroDoc, nrolibreta, f: string; var respMenor : string ): Boolean;
    function verSitMig(nroDoc: string; var respSitMig: string) :Boolean;
    function CoincideVTORENAPER(nroDoc, genero, tipo_doc :string) : string;
  end;
var
  DMRestriccion: TDMRestriccion;
implementation
{$R *.dfm}
uses system.Types, WinApi.Windows, System.inifiles;
procedure log1(fileName,LogString: string);
var f: TextFile;
begin
  AssignFile(f,fileName);
  If FileExists(fileName) then
    Reset(f)
  else
    Rewrite(f);
  Append(f);
  Writeln(f ,logString);
  closeFile(f);
end;

procedure AssignStringParam(p : TParam; s : String);
begin
  if s = '' then
  begin
    p.Clear;
    p.Bound:= true;
  end
  else
    p.Value:= s;
end;
function RemoveLastLetter(S : String) : String;
var
  palabra : String;
  i, k : integer;
begin
  k := Length(s);
  for i := 1 to k do
     if s[i] in ['0'..'9']  {aqui pones todos los digitos...}
        then
        palabra := palabra + s[i] ;
   Result := palabra;
end;

procedure CargarStringListAll(var SLd , SLn , SLf, SLa : TStringList);
var
  i,j,x,z : Integer;
  ok:boolean;
  temp: TStringList;
begin
  //Aca tengo que agregar las coincidencias a SLa ******** SV
  sla.Duplicates:= dupIgnore;
  SLa.Clear();
  sla.Assign(Slf);

  //chequea por documento y nombre
  if (SLd.Count>0) and (SLn.Count>0) then
  begin
    SLd.Add('#');
    SLn.Add('#');
    i:=0;
    While SLd.Strings[i]<>'#' do
    begin
      z:=0;
      j:=0;
      x:=i;
      While SLn.Strings[j]<>'#' do
      begin
        if SLd.Strings[x]=SLn.Strings[j] then
        begin
          z:=1;
          SLa.Add(SLd.Strings[x]);    //Si coinciden ambas las agrega a sLa
          SLn.Delete(j);
          j:=j - 1;
        end;
        Inc(j);
      end;
      if z = 1 then
      begin
        SLd.Delete(x);
        i := i - 1;
      end;
      Inc(i);
    end;
  SLd.Delete(SLd.Count-1);
  SLn.Delete(SLn.Count-1);
  end;//end if
 //**************************** SV
  i:=0;
  SLn.Add('#');
  SLf.Add('#');
  While SLf.Strings[i]<>'#' do
  begin
    z:=0;
    j:=0;
    x:=i;
    While SLn.Strings[j]<>'#' do
    begin
      if SLf.Strings[x]=SLn.Strings[j] then
      begin
        z:=1;
        sln.Delete(j);
        j:= j - 1;
      end;
      Inc(j);
    end;
    if z = 1 then
    begin
      SLf.Delete(x);
      i := i - 1;
    end;
    Inc(i);
  end;
  SLn.Delete(SLn.Count-1);
  SLf.Delete(SLf.Count-1);
 //end;
 //Moco para safar del moco *********************
 SLa.add('#');
 temp:=TStringList.Create;
 j:=0;
 While SLa.Strings[j]<>'#' do
 begin
      if temp.Count = 0 then
        temp.Add(SLa.Strings[j])
      else
      begin
        temp.Add('#');
        i:=0;
        ok:=false;
        While (temp.Strings[i]<>'#') and not ok do
        begin
           if SLa.Strings[j] <> temp.Strings[i] then
              inc(i)
           else
              ok:=true;
        end;
        temp.Delete(temp.Count-1);
        if not ok then
           temp.Add(SLa.Strings[j]);
      end;
      inc(j);
 end;
 SLa.Delete(SLa.Count-1);
 sla:=temp;
 //****************************************************

end;

function TDMRestriccion.BuscarDocumentosRobados(
  numerodoc: String): Boolean;
begin
  Result := False;
  //if not IBDatabase1.DefaultTransaction.Active then
  //  IBDatabase1.DefaultTransaction.Active := true;
  with qryDocumentosRobados do
    try
      ParamByName('PDOCNUMERO').Value := numerodoc;
      Open;
      Result := not IsEmpty;
      Transaction.Commit;
    except
      Transaction.Rollback;
    end;
end;
function TDMRestriccion.BuscarListaControlPorDocumentos(NroDoc: String;
         var StringList : TStringList; AcumLS:Boolean): Integer;
var
  i:Integer;
begin
  Result := -1;
  if (Length(NroDoc)<3) or (NroDoc='00000000') then Exit;
  //if not IBDatabase1.DefaultTransaction.Active then
  //  IBDatabase1.DefaultTransaction.Active := true;

  with qryBuscarDoc do
  try
    ParamByName('PDOCNUMERO').Value := NroDoc;
    Open;
    Last;
    if Not AcumLS then
      StringList.Clear;
    for i := RecordCount - 1 downto 0 do
    begin
      StringList.Add(FieldByName('RID_SIC').AsString);
      Prior;
    end;

    Result := RecordCount;
    Transaction.Commit;
  except
    Transaction.Rollback;
  end;
end;


function TDMRestriccion.BuscarListaControlPorNombres(Ape1, Ape2, Nom1,
  Nom2: string; fechaNac: TDateTime; var StringList,
                                         StringListFec: TStringList): Integer;
var
  i:integer;
begin
  Result := -1;
  //if not IBDatabase1.DefaultTransaction.Active then
  //  IBDatabase1.DefaultTransaction.Active := true;

  with qryBuscarNombre do
    try
      ParamByName('PAPELLIDO1').Value := Ape1;
      ParamByName('PAPELLIDO2').Value := Ape2;
      ParamByName('PNOMBRE1').Value   := Nom1;
      ParamByName('PNOMBRE2').Value   := Nom2;
      Open;
      Last;
      StringList.Clear;
      StringListFec.Clear;
      for i := RecordCount - 1 downto 0 do
      begin
        StringList.Add(FieldByName('RID_SIC').AsString);
      //Aca voy a preguntar si coincide con la fecha de nacimiento
      //Si coincide lo meto en una list ******************* SV
        IF (FieldByName('RFECHA_NAC').asDatetime = fechaNac) then
           StringListFec.add(FieldByName('RID_SIC').AsString);
      //**************************************************************
        Prior;
      end;
      Result := RecordCount;
      Transaction.Commit;
    except
      Transaction.Rollback;
    end;
end;
procedure TDMRestriccion.DataModuleCreate(Sender: TObject);

  function GetWSDir : String;
  const
    BUFFER_SIZE = 2048;
  var
    buffer : PWideChar;
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
  DatabaseName,Username,Password:String;
begin
  inifile := TIniFile.Create(Format('%sconfig.ini', [ExtractFilePath(GetWSDir)]));
  try
    DatabaseName := inifile.ReadString('Database', 'DatabaseName', 'localhost:1521/SICAM');
    Username := inifile.ReadString('Database', 'username', 'SICAM');
    Password := inifile.ReadString('Database', 'password', 'sicam');
    BDrestriCentral := inifile.ReadString('Database', 'DatabaseOracleName', '');
    InfTransp := inifile.ReadString('Transporte', 'nombre', '');
    sentido := inifile.ReadString('Transporte', 'sentido', '');
    transporteGral  := inifile.ReadString('Transporte', 'transporteGral', '');
    tipoPaso := inifile.ReadString('Transporte', 'tipoPaso', '');
    Paso := inifile.ReadString('Transporte', 'Paso', '');
    fuentes  := inifile.ReadString('Transporte', 'fuentes', '');
    urlInterpol:=  inifile.ReadString('Transporte', 'urlInterpol', '');
    urlTrans:=  inifile.ReadString('Transporte', 'infoTran', '');
    urlMenores:=  inifile.ReadString('Transporte', 'urlmenores', '');
    flagMenores:=  inifile.ReadString('Transporte', 'flagMenores', '0');
    urlSitMig:=  inifile.ReadString('Transporte', 'urlSitMig', '');
    flagSitMig:=  inifile.ReadString('Transporte', 'flagSitMig', '0') ;
    otrasNacionalidades:=  inifile.ReadString('Transporte', 'otrasNacionalidades', '') ;
    otrosPaisesDoc:=  inifile.ReadString('Transporte', 'otrosPaisesDoc', '') ;
    renaper:=  inifile.ReadString('Transporte', 'renaper', '') ;
    debug_aereo := inifile.ReadString('Transporte', 'debug_aereo', '0') ;

  finally
    inifile.Free;
  end;


  IBDatabase1.Close;
  //IBDatabase1.Params.Clear;
  IBDatabase1.Params.Database := DatabaseName;
  IBDatabase1.Params.UserName := Username;
  IBDatabase1.Params.Password := Password;
  //IBDatabase1.Params.Add('sql_role_name=3');
  //IBDatabase1.Params.Add(Format('lc_ctype=%s', ['WIN1251']));
  //IBDatabase1.ServerType:='IBServer';
  IBDatabase1.Connected:=True;


end;

function tryStrToIntStr(Str:String):String;
begin
  try
    result:= IntToStr(StrToInt(str));
  except
    Result:= Str;
  end;
end;
function TDMRestriccion.DameCoincidenciasLogInterpol(pApe1, pApe2, pNom1, pNom2, fechaNac,  pnroDoc, pnrolibreta: string): boolean;


function dameSql(DocOLibreta:string) : AnsiString;
begin
  Result:= 'SELECT * '+
           'FROM siger.log_webservice'+
           ' WHERE Fecha_nacimiento = to_date(:pFechaNac,''dd/mm/yyyy'')';
  if DocOLibreta = 'DOC' then
    Result:=  Result+' and numero_documento = :pDoc'
  else
    Result:=  Result+' and numero_identificacion = :pDoc';
  Result:=  Result+' ORDER BY fecha_consulta' ;
end;

function dameSql2(pnom2, pape2: string) : AnsiString;
begin
  Result:= 'SELECT * '+
           'FROM siger.log_webservice '+
           ' WHERE '+
                ' Fecha_nacimiento = to_date(:pFechaNac,''dd/mm/yyyy'') '+
                ' and upper(primer_nombre) =  :pNom1 ';
  if pnom2 <> '' then
    Result:=Result+' and upper(Otros_nombres) =  :pNom2 ';
  Result:=Result+' and upper(primer_apellido) =  :pApe1 ';
  if pape2 <> '' then
    Result:=Result+' and upper(otros_apellidos) =  :pApe2 ';
  Result:=Result+' ORDER BY fecha_consulta' ;
end;

begin
  try
    result := false;
    OraSession2.Server := BDrestriCentral;
    OraSession2.Connected := true;
    with OraQuery2 do
    begin
      (*Busqueda por fecha nac y Doc*)
      Close;
      sql.Clear;
      SQL.Add(dameSql('DOC'));
      ParamByName('pFechaNac').AsString := fechanac;
      ParamByName('pDoc').AsString := pnroDoc;
      Open;
      if IsEmpty then
      begin
        (*Busqueda por fecha nac , APE Y NOM*)
        Close;
        sql.Clear;
        SQL.Add(dameSql2(pnom2, pape2));
        ParamByName('pFechaNac').AsString := fechanac;
        ParamByName('pNom1').AsString := pNom1;
        if trim(pNom2) <> '' then
          ParamByName('pNom2').AsString := pNom2;
        ParamByName('pApe1').AsString := pApe1;
        if trim(pApe2) <> '' then
          ParamByName('pApe2').AsString := pApe2;
        Open;
        if IsEmpty then
        begin
          if trim(pnrolibreta) <> '' then
          begin
            Close;
            sql.Clear;
          (*Busqueda por fecha nac , APE Y NOM*)
            SQL.add(dameSql('LIB' ));
            ParamByName('pFechaNac').AsString := fechanac;
            ParamByName('pDoc').AsString := pnrolibreta;
            //SQL.savetofile('.\ejemplo.txt');
            Open;
            if not IsEmpty then
            begin
              First;
              if (OraQuery2.FieldByName('COLOR').AsString = 'ROJO') or (OraQuery2.FieldByName('COLOR').AsString = 'NARANJA') then
                Result := true;
            end;
          end;
        end
        else
        begin
          First;
          if (OraQuery2.FieldByName('COLOR').AsString = 'ROJO') or (OraQuery2.FieldByName('COLOR').AsString = 'NARANJA') then
            Result := true;
        end
      end
      else
      begin
        First;
        if (OraQuery2.FieldByName('COLOR').AsString = 'ROJO') or (OraQuery2.FieldByName('COLOR').AsString = 'NARANJA') then
          Result := true;
      end;
    end;
  except
    Result := false;
  end;
end;

function TDMRestriccion.CoincideVTORENAPER(nroDoc, genero, tipo_doc :string) : string;
var ws : IwsRenaper;
  ds : salidaVto;
begin
  try
      ds := salidaVto.Create;
      ws := GetIwsRenaper(False, renaper);
      ds := ws.VtoDOC(nroDoc,genero,tipo_doc);
      Result := ds.vto;
      FreeAndNil(ds);
  except
    Result := 'NOTOK';
  end;
end;
function TDMRestriccion.TotalRestricciones(desdeDondeConsulto,pApe1, pApe2, pNom1, pNom2: string;
  fechaNac: TDateTime; pnroDoc, pnrolibreta,genero, tipoDoc, paisEmisorDoc, nacionalidad, fechaVTO: string; var Origen: string): Integer;
var
  doc : String;
  Cant : Integer;
  SlApe,SLdoc,SLAll,SLNom,SLFech:TStringList;
  Ape1, Ape2, Nom1, Nom2,nroDoc, nrolibreta: string;
  filename2 : string;
  consulta: XML_CONSULTA_new;
  wsunit: iWsListaControl_unif;
  r: TRESULTADO_new;
  vto: string;

begin
  Result := 0;
  Cant := 0;
  Ape1 := Trim(UpperCase(pApe1));
  Ape2 := Trim(UpperCase(pApe2));
  Nom1 := Trim(UpperCase(pNom1));
  Nom2 := Trim(UpperCase(pNom2));
  nroDoc := Trim(UpperCase(pnroDoc));
  nrolibreta := Trim(UpperCase(pnrolibreta));
  doc := TryStrToIntStr(RemoveLastLetter(nroDoc));

  SLdoc:= TStringList.Create;
  SLNom:= TStringList.Create;
  SLFech:= TStringList.create;
  SlApe:= TStringList.create;
  SlAll := TStringList.create;
  try
    //------------------------------------------
    BuscarListaControlPorDocumentos(nroDoc,SLdoc,false);
    if (Trim(nroDoc) <> doc) then
      BuscarListaControlPorDocumentos(doc,SLdoc,true);
    if (Trim(nrolibreta) <> NullAsStringValue) and (nrolibreta <> Trim(nroDoc)) then
      BuscarListaControlPorDocumentos(Trim(nrolibreta),SLdoc,true);
    if (Trim(nrolibreta) <> NullAsStringValue)
      and (Trim(nrolibreta) <> RemoveLastLetter(nrolibreta))
      and (RemoveLastLetter(nrolibreta)<>RemoveLastLetter(nroDoc)) then
        BuscarListaControlPorDocumentos(Trim(nrolibreta),SLdoc,true);
    if (length(Ape1) >= 2) and (length(Nom1) >= 2) then
      BuscarListaControlPorNombres(Ape1,Ape2,Nom1,Nom2,fechaNac,SlApe, SLFech);
    CargarStringListAll(SlDoc, SlApe, SLFech,SlAll);
    if (SlDoc.Count > 0) or (SLFech.Count > 0) or (SlAll.Count > 0) then
    begin
      Cant := 1;
      Origen := Origen + 'R';
    end;
    if Cant>0 then Exit;
    // Documentacion Robada DNM
    if (paisEmisorDoc <> 'ARG') then
    begin
      if not((nrolibreta = NullAsStringValue) or (nrolibreta = '00000000') or (length(nrolibreta)<3)) then
      begin
        if BuscarDocumentosRobados(nrolibreta) then
        begin
          Cant := 1;
          Origen := Origen + 'D';
        end;
        if Cant>0 then Exit;
        if (Trim(nrolibreta)<>RemoveLastLetter(nrolibreta)) then
          if BuscarDocumentosRobados(RemoveLastLetter(nrolibreta)) then
          begin
            Cant := 1;
            Origen := Origen + 'D';
          end;
        if Cant>0 then Exit;
      end;

      if BuscarDocumentosRobados(nroDoc) then
      begin
        Cant := 1;
        Origen := Origen + 'D';
      end;
      if Cant>0 then Exit;
      if (nroDoc<>doc) then
        if BuscarDocumentosRobados(doc) then
        begin
          Cant := 1;
          Origen := Origen + 'D';
        end;
      if Cant>0 then Exit;
    end;
    if  (paisEmisorDoc = 'ARG') and (nroDoc = '00000000') and (UpperCase(tipoDoc) = 'P' ) then
    begin
      Cant := 1;
      Origen := Origen + 'D - 00000000';
      if Cant>0 then Exit;
    end;

    // Documentacion Robada
    //RENAPER - DNM
    if (desdeDondeConsulto = 'BR' ) and (paisEmisorDoc = 'ARG') and ((UpperCase(tipoDoc) =  'P' ) or (UpperCase(tipoDoc) =  'ID')) then
    begin
      vto := CoincideVTORENAPER(nroDoc, genero, tipodoc );
      if (vto <> '') and (vto <> 'NOTOK')  and (fechaVTO <> '//') then 
      begin
        if (fechaVTO <> vto) then
        begin
          Cant := 1;
          Origen := Origen + 'D - ' + VTO
        end;
      end;
      if Cant>0 then Exit;
    end;

    {if cant = 0 then
    begin
      if DameCoincidenciasLogInterpol(pApe1, pApe2, pNom1, pNom2, formatdatetime('dd/mm/yyyy', fechaNac),  pnroDoc, pnrolibreta) then
        cant:=1;
    end; }
    if desdeDondeConsulto = 'BR' then //BR = buscarRestricciones
    begin
      if cant = 0 then
      begin
        wsunit := GetIWsListaControl_Unif(false,urlInterpol);
        Consulta := XML_CONSULTA_new.Create;
        consulta.FUENTES   := fuentes;
        consulta.OPERADOR  := 'EGATES-EGATES-EGATES-EGATES-EGATES-'+UpperCase(sentido)+'-EGATES';  //
        consulta.NUMDOC    := nroDoc;
        consulta.APELLIDO1 := Ape1;
        consulta.APELLIDO2 := Ape2;
        consulta.NOMBRE1   := Nom1;
        consulta.NOMBRE2   := Nom2;
        consulta.FECHANAC  := formatdatetime('dd/mm/yyyy',fechaNac);
        consulta.GENERO    :=  genero;
        consulta.NACIONALIDAD := nacionalidad;
        consulta.EMISORDOC := paisEmisorDoc;
        consulta.NUMEROIDENIFICACION := nrolibreta;
        consulta.TIPODOC :=tipoDoc;
        consulta.PASO := Paso;
       // R:=TRESULTADO_NEW.Create;
        try
          r := wsunit.ConsultaRestriccion(Consulta);
          if Length(r.restricciones) > 0 then
          begin
            cant:=1;
            Origen := Origen + 'I';
          end;
          consulta.Free;
        except
           on E: Exception do
           begin
            Cant :=0;
            ForceDirectories(ExtractFilePath(ParamStr(0)) + 'logs');
            filename2:= ExtractFilePath(ParamStr(0)) + 'logs\dejopasarInterpol.log';
            log1(filename2,'FECHA: ' + DateTimeToStr(Now) +' | DOC: '+ consulta.NUMDOC +' | Libreta: '+nrolibreta+ ' | Ape: '+ape1+'| Nombre: '+Nom1+' | nacionalidad: '+nacionalidad+' | fechaNac: '+formatdatetime('dd/mm/yyyy',fechaNac)+' ERROR : '+e.Message);
          end;
        end
      end;
    end;

  finally
    SlAll.Free;
    SlApe.Free;
    SLdoc.Free;
    SLNom.Free;
    SLFech.Free;
    Result := Cant;
  end;
end;
procedure TDMRestriccion.DataModuleDestroy(Sender: TObject);
begin
  IBDatabase1.Close;
end;

 (*
function TDMRestriccion.InfTransporte(Ape1,ape2, nom1, nom2, nroDoc, nrolibreta, sentidoVuelo: string; f:TDateTime; Var vuelo, pasajero, hayTransporte: string): boolean;
var ws: IpuenteApiMar;
    RTA: STRING;
    erafotopoc : Boolean;

function dameSql : AnsiString;
begin

Result:='SELECT '+
            'a.id, '+
            'a.FlightId, '+
            'a.NOMBRE1|| '+''''+' '+''''+'||a.NOMBRE2 AS nombre,'+
            'a.APELLIDO1 AS apellido, '+
            'a.pasajero, '+
            'a.sexo, '+
            'a.fecha_nac, '+
            'a.nacionalidad, '+
            'a.codigo_compania, '+
            'a.numero_vuelo, '+
            'a.origen_vuelo, '+
            'a.destino_vuelo, '+
            'a.fecha_vuelo, '+
            'a.tipo_doc, '+
            'a.numero_doc, '+
            'a.pais_doc, '+
            'a.asiento, '+
            'a.compania_descripcion, '+
            'a.destino_vuelo_desc, '+
            'a.origen_vuelo_desc, '+
            'a.asiento_numero, '+
            'a.asiento_letra, '+
            'a.origen_viaje_desc, '+
            'a.destino_viaje_desc, '+
            'a.tipo_cruce '+
         'FROM '+
            ' apisql.VW_PASAJEROS_WEB a '+ //inner join '+
        		//' apisql.VW_VUELOS_WEB b on a.FlightId = b.flightid '+
         ' WHERE '+
                //' a.fecha_vuelo >= to_date('+''''+formatdatetime('dd/mm/yyyy', now-1)+''''+','+''''+'dd/mm/yyyy'+''''+')'+         //VERRRRRRR
                ' a.fecha_vuelo >= to_date(:desde,''dd/mm/yyyy'') '+         //VERRRRRRR
                ' and a.fecha_nac = to_date(:fechaNac,''dd/mm/yyyy'') '+
                ' and a.numero_doc = :doc '+
                ' and a.tipo_cruce = :sentido '+
         ' ORDER BY '+
                ' a.asiento_numero, a.asiento_letra, a.apellido1 ASC ' ;
end;

function dameSql2 : AnsiString;
begin

  Result:=
            'SELECT '+
            'a.id, '+
            'a.FlightId, '+
            'a.NOMBRE1|| '+''''+' '+''''+'||a.NOMBRE2 AS nombre,'+
            'a.APELLIDO1 AS apellido, '+
            'a.pasajero, '+
            'a.sexo, '+
            'a.fecha_nac, '+
            'a.nacionalidad, '+
            'a.codigo_compania, '+
            'a.numero_vuelo, '+
            'a.origen_vuelo, '+
            'a.destino_vuelo, '+
            'a.fecha_vuelo, '+
            'a.tipo_doc, '+
            'a.numero_doc, '+
            'a.pais_doc, '+
            'a.asiento, '+
            'a.compania_descripcion, '+
            'a.destino_vuelo_desc, '+
            'a.origen_vuelo_desc, '+
            'a.asiento_numero, '+
            'a.asiento_letra, '+
            'a.origen_viaje_desc, '+
            'a.destino_viaje_desc, '+
            'a.tipo_cruce '+
         'FROM '+
            ' apisql.VW_PASAJEROS_WEB a '+ //inner join '+
        		//' apisql.VW_VUELOS_WEB b on a.FlightId = b.flightid '+
         ' WHERE '+
                ' a.fecha_vuelo >= to_date(:desde,''dd/mm/yyyy'') '+         //VERRRRRRR
                ' and a.fecha_nac = to_date(:fechaNac,''dd/mm/yyyy'') '+
                ' and a.apellido1 like Upper(:Ape1)||''%'' '+
                ' and a.nombre1 = Upper(:nom1) '+
                ' and a.tipo_cruce = upper(:sentido) '+
         ' ORDER BY '+
                ' a.asiento_numero, a.asiento_letra, a.apellido1 ASC' ;
end;

function dameAPIFOTOPOC : AnsiString;
begin
       Result:= 'select trim(replace(vuelo,'' '' , ''-'') ) vueloCast, a.* '+
           'from api_owner.apifotopoc a '+
           'where '+
           //'a.fecha_vuelo >= to_date(:desde,''dd/mm/yyyy'') '+
           'a.fecha_registro >= sysdate-1/2 '+
           'and a.apellido1 = Upper(:Ape1) '+
           'and a.nombre1 = Upper(:nom1)' ;
end;

begin
  try
    //ADOConnection1.ConnectionString := 'Provider=SQLOLEDB.1;Password=userapi;Persist Security Info=True;User ID=apiuser;Initial Catalog=ATSG;Data Source='+InfTransp+';Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID= ;Use Encryption for Data=False;Tag with column collation when possible=False';
    //ADOConnection1.Connected := true;
    result := false;
    IF tipoPaso = 'A' then
    begin
      // pasos Aereos
      OraSession1.Server := InfTransp;
      OraSession1.Connected := true;
      if sentidoVuelo <> '' then
      begin
        erafotopoc := False;
        if sentidoVuelo = 'S' then
        begin
          with OraQuery1 do
          begin
            Close;
            sql.Clear;
            SQL.Add(dameAPIFOTOPOC);
            ParamByName('ape1').AsString:=ape1;
            ParamByName('Nom1').AsString:=Nom1;
            Open;
            if (not IsEmpty) and ( RecordCount=1) then
            begin
              pasajero:=  'P';
              vuelo := UpperCase(trim(fieldbyname('vueloCast').AsString));
              hayTransporte := 'T';
              erafotopoc:=True;
            end;
          end;
        end;
        if not erafotopoc then
        begin
          with OraQuery1 do
          begin
            Close;
            sql.Clear;
            SQL.Add(dameSql);
            ParamByName('desde').AsString:= formatdatetime('dd/mm/yyyy', now-1);
            ParamByName('fechaNac').AsString:= formatdatetime('dd/mm/yyyy', f);
            ParamByName('doc').AsString:=nroDoc;
            ParamByName('sentido').AsString:= sentidoVuelo;
            Open;
            if IsEmpty then
            begin
              Close;
              sql.Clear;
              SQL.Add(dameSql2);
             // sql.savetofile('.\prueba.txt');
              ParamByName('desde').AsString:= formatdatetime('dd/mm/yyyy', now-1);
              ParamByName('fechaNac').AsString:= formatdatetime('dd/mm/yyyy', f);
              ParamByName('ape1').AsString:=ape1;
              ParamByName('Nom1').AsString:=Nom1;
              ParamByName('sentido').AsString:= sentidoVuelo;
              Open;
              if IsEmpty then
              begin
                if nrolibreta <> '' then
                begin
                  Close;
                  sql.Clear;
                  SQL.add(dameSql);
                  ParamByName('desde').AsString:= formatdatetime('dd/mm/yyyy', now-1);
                  ParamByName('fechaNac').AsString:= formatdatetime('dd/mm/yyyy', f);
                  ParamByName('doc').AsString:=nrolibreta;
                  ParamByName('sentido').AsString:= sentidoVuelo;
                  //SQL.savetofile('.\ejemplo.txt');
                  Open;
                  if not IsEmpty then
                    begin
                      First;
                      pasajero:=  fieldbyname('pasajero').AsString;
                      vuelo := fieldbyname('codigo_compania').AsString+'-'+fieldbyname('numero_vuelo').AsString;
                      hayTransporte := 'T';                      
                    end
                    else
                    begin
                      pasajero:= '';
                      vuelo := ''; //transporteGral ;   //JPB 12/05/2020
                      hayTransporte := 'F';
                    end;
                 end
                 else
                 begin
                   pasajero:= '';
                   vuelo := '';//transporteGral ;  //JPB 12/05/2020 ;
                   hayTransporte := 'F';
                 end;
              end
              else
              begin
                First;
                pasajero:=  fieldbyname('pasajero').AsString;
                vuelo := fieldbyname('codigo_compania').AsString+'-'+fieldbyname('numero_vuelo').AsString;
                hayTransporte := 'T';
              end
            end
            else
            begin
              First;
              pasajero:=  fieldbyname('pasajero').AsString;
              vuelo := fieldbyname('codigo_compania').AsString+'-'+fieldbyname('numero_vuelo').AsString;
              hayTransporte := 'T';
            end;
            if vuelo <> '' then
            begin
              if (Copy(vuelo,1,2)= 'AR') and (StrToInt(Copy(vuelo,4,Length(vuelo)))>=2000 ) then
                vuelo := 'AU-'+ Copy(vuelo,4,Length(vuelo));

            end;
          end;
        end;
      end
      else
      begin
        pasajero:= '';
        vuelo := ''; //'ERROR - WS SIN TIPO_CRUCE'; jpb 12/05
        hayTransporte := 'F';
      end;
    end
    else
    begin
      if tipoPaso = 'M' then
      begin
        // pasos Maritimos
        ws:= GetIpuenteApiMar(false,urlApiMar);
        RTA:= ws.dameApi(Paso, Ape1,ape2, nom1,nom2,formatdatetime('dd/mm/yyyy', f),nroDoc,nrolibreta);
        IF (rta = '0') or (rta ='-1000') then
          vuelo := transporteGral
        else
          vuelo := rta;
        pasajero:=  '';
      end
      else
      begin
        // pasos Terrestres
        pasajero:= '';
        vuelo := transporteGral;
      end;
    end;
    Result := true;
  except
      vuelo :='';//:= e.Message;
      Result := false;
  end;
  //  result := infTransp;
end;
 *)
function TDMRestriccion.chequearAutorizacionOnline_esc(nro_doc, fechanac :string): tautorizacion;
var
  ws_autorizacion: Iws_obtener_autorizacion;
  datos_busqueda: Tdatos_busqueda;
  res: tautorizacion;
begin
  result := nil;
  try
    ws_autorizacion:= GetIws_obtener_autorizacion( FALSe,urlMenores );
    datos_busqueda := Tdatos_busqueda.Create;
    datos_busqueda.fecha_nacimiento := fechanac;
    datos_busqueda.numero_documento := trim(nro_doc);
    Result := ws_autorizacion.obtener_autorizacion_escribanos(datos_busqueda);
  except
    result := nil;
  end;
end;

function TDMRestriccion.chequearAutorizacionOnline_SACER(nro_doc, fechanac :string): tautorizacion_sacer;
var
  ws_autorizacion: Iws_obtener_autorizacion;
  datos_busqueda: Tdatos_busqueda;
  res: tautorizacion_sacer;
begin
  try
    ws_autorizacion:= GetIws_obtener_autorizacion(FALSE, urlmenores);
    datos_busqueda := Tdatos_busqueda.Create;
    datos_busqueda.fecha_nacimiento := fechanac;
    datos_busqueda.numero_documento := trim(nro_doc);
    Result := ws_autorizacion.obtener_autorizacion_sacer(datos_busqueda);
  except
  end;
end;

function TDMRestriccion.consultoMenor(nroDoc, nrolibreta, f: string; var respMenor : string ): Boolean;
Var
  res: tautorizacion;
  res_sacer: tautorizacion_sacer;
begin
  try
    Result := True;
    res := chequearAutorizacionOnline_esc(nroDoc,f);
    if res <> nil then
    begin
      if (res.MENOR = '-1') then
      begin
        res := chequearAutorizacionOnline_esc(nrolibreta,f);
        if res <> nil then
        begin
          if (res.MENOR = '-1') then
          begin
            res_sacer := chequearAutorizacionOnline_SACER(nroDoc,f);
            if (Assigned(res_sacer)) and (res_sacer.NUMERO_DOC <> '-1') then
            begin
                   respMenor := 'AUTORIZACION DNM: '+res_sacer.NRO_SOLICITUD; //aca debe ir el nro de autorizacion
            end
            else
            begin
              res_sacer := chequearAutorizacionOnline_SACER(nrolibreta,f);
              if (Assigned(res_sacer)) and (res_sacer.NUMERO_DOC <> '-1') then
              begin
                 respMenor := 'AUTORIZACION DNM: '+res_sacer.NRO_SOLICITUD; //aca debe ir el nro de autorizacion
              end
            end
          end
          else
            respMenor := 'AUTORIZACION EXT: '+res.NUMERO_TRAMITE +' (id:'+res.menor+')'; //aca debe ir el nro de autorizacion
        end
      end
      else
          respMenor := 'AUTORIZACION EXT: '+res.NUMERO_TRAMITE +' (id:'+res.menor+')'; //aca debe ir el nro de autorizacion
    end;
  except
    respMenor := '';
    Result := False;
  end;
end;

function TDMRestriccion.verSitMig(nroDoc: string; var respSitMig: string) :Boolean;
var
  ws_actuacion: IWSActuaciones;
  res: TSituacionMig;
begin
  result := true;
  try
    ws_actuacion:= GetIWSActuaciones( FALSe,urlSitMig );
    res := TSituacionMig.Create;
    res := ws_actuacion.GetSituacionMigratoria(nroDoc);
    respSitMig := UpperCase(res.SituacionMig) ;
  except
    respSitMig := 'ERROR WS SITMIG';
    result := false;
  end;
end;

end.


