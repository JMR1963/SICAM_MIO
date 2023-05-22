{ Invokable implementation File for Twebusersicam which implements Iwebusersicam }

unit webusersicamImpl;

interface

uses
  Soap.InvokeRegistry, System.Types, NetConn, Soap.XSBuiltIns, webusersicamIntf, ubaseDatos, System.Classes,
  {sqlBaseManage, }Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,ZConnection,
  Ora, DBAccess, IwsRenaper1, System.strutils, Vcl.Imaging.jpeg, Vcl.Controls;

type



  { Twebusersicam }
  Twebusersicam = class(TInvokableClass, Iwebusersicam)
  private
    function EliminaAcentos(Texto:string):string;
    function cantidadDeFilas: string;
    function findPathImages(id_loc, fechaTransito:string):tstringlist; stdcall;
    function findIdTransit(idTranOlSicam:string):string; stdcall;
    function quitarComillasSimples(str : string): string;
    function ParseName(str:string):TStringList;
    function IsFucked(str:string):integer;
    procedure FixNames(name:string;var str1,str2:String);
    function obtenerFechaYhora : tdatetime;


    // JPB - Inicio
    procedure generarTxT(path, resultado:string);
    // JPB - Fin



  public
    FbaseOracle: TbaseDatos;


    function usuarios_pasos(usuario, documentonro, clavesistema, apellidos, nombres,
        pasold, pasonew, idusuariostipos, credencial: string): string; stdcall;

    function findPerson(id, pais, subTipoDoc, nroDocumento: string): string; stdcall;

    function findPersonAndTransit(id, pais, subTipoDoc, nroDocumento: string): aTransitos; stdcall;



    function findImagesTransit(id, pais, subTipoDoc, nroDocumento:string):aImagesTransit; stdcall;

  end;

   function refresh( usuario, documentonro, clavesistema, apellidos, nombres, pasold,
                      pasonew, idusuariostipos, credencial: pchar):pchar cdecl; external
                      'UsuarioSicam.dll' name 'refresh';


   function trimDoc(const num: pchar):pchar; stdcall; external 'ib_funcs.dll' name 'ib_funcs_getnumbers';


implementation

uses System.SysUtils, System.iniFiles, vcl.forms, WinApi.Windows, System.DateUtils, uBase64, System.Variants;

{ Twebusersicam }



procedure log(aNombre, texto:String);
var
  stl:TStringList;
begin
  try
    stl:=TStringList.Create;
    try
      stl.Text := DateTimeToStr(now)+' - '+texto;
      stl.SaveToFile(ExtractFilePath(Application.ExeName)+'\Logs\'+aNombre);
    finally
      stl.Free;
    end;
  except
  end;
end;

function Twebusersicam.EliminaAcentos(Texto:string):string;
const Acentos = '·ÈÌÛ˙¡…Õ”⁄'; NoAcentos = 'aeiouAEIOU';
var i: integer;
begin
  for i:= 1 to length(Texto) do
  begin
    if pos(Texto[i], Acentos) <> 0 then
      Texto:= StringReplace(Texto, Acentos[pos(Texto[i], Acentos)],
              NoAcentos[pos(Texto[i], Acentos)], [rfReplaceAll, rfIgnoreCase]);
  end;
  Result:= Texto;
end;

function Twebusersicam.obtenerFechaYhora : tdatetime;
var ora  : TOraQuery;
begin
  try
    ora := TOraQuery.Create(nil);
    ora.Close;
    ora.SQL.Clear;
    ora.SQL.Add('select sysdate from dual');
    ora.Open;

    result := ora.fieldbyname('sysdate').AsDateTime; 
  except
  end;
end;

function Twebusersicam.cantidadDeFilas: string;
var
  iniFile: TiniFile;
  path: string;       //ruta al archivo
  countIni: string;   //cantidad leida del ini
begin
  path    := ExtractFilePath(Application.ExeName) + 'params.ini';
  iniFile := TIniFile.Create(path);
  result  := iniFile.ReadString('MaxRows', 'count', '');
end;

function Twebusersicam.findPerson(id, pais, subTipoDoc, nroDocumento: string): string;
var
  aux: string;
  ts: tstrings;

begin
  log('findPerson_'+Trim(nroDocumento), 'findPerson');

  try
    FbaseOracle := TbaseDatos.create;
    FbaseOracle.server    := 'PADRON';
    FbaseOracle.username  := 'personas';
    FbaseOracle.password  := 'p3rs0n4$';
    FbaseOracle.connected := TRUE;
    ts := TStringList.Create;
    ts.Add('select * from personas.personas ' );
    ts.Add('where DOCTIPO = :PDOCTIPO and PAISEMISOR = :PAISEMISOR and DOCSUBTIPO = :PDOCSUBTIPO and DOCNUMERO = :PDOCNUMERO');
    FbaseOracle.sql := ts;
    freeAndNil(ts);
    ts := TStringList.Create;
    ts.Add(id);
    ts.Add(pais);
    ts.Add(subTipoDoc);
    ts.Add(nroDocumento);
    FbaseOracle.parametros := ts;
    FreeAndNil(ts);
    FbaseOracle.asignarParametros;
    result := FbaseOracle.executeSql;
    {if result =  '' then
    begin
       ts := TStringList.Create;
       ts.Add('select * from vw_padron ' );
       ts.Add('where DOCTIPO = :PDOCTIPO and PAISEMISOR = :PAISEMISOR and DOCNUMERO = :PDOCNUMERO');
       FbaseOracle.sql.Clear;
       FbaseOracle.sql := ts;
       FbaseOracle.asignarParametros2;
       result := '';
       result := FbaseOracle.executeSql2;
    end;}
  except
    result := ',,,,,,,,,,,,';
  end;

  DeleteFile(Pchar(ExtractFilePath(Application.ExeName)+'\Logs\findPerson_'+Trim(nroDocumento)));
end;

function Twebusersicam.quitarComillasSimples(str : string): string;
var i : integer;
begin
  result := AnsiReplaceStr(str, '''', ' ');
end;

function Twebusersicam.ParseName(str:string):TStringList;
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


function Twebusersicam.IsFucked(str:string):integer;
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

procedure Twebusersicam.FixNames(name:string;var str1,str2:String);
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


/////////////////////////////////////////////////////////////////
/////**************   JPB -  Inicio    ********************//////
/////////////////////////////////////////////////////////////////

procedure Twebusersicam.generarTxT(path, resultado:string);
var
  F: TextFile;
begin
  AssignFile( F, path);
//  REwrite( F );
    Append(f);

  //escribirRegistroBURe(f);

  WriteLn( F, resultado);

  CloseFile( F );
end;


/////////////////////////////////////////////////////////////////
//////////****************   JPB -  fin    **************////////
/////////////////////////////////////////////////////////////////




function Twebusersicam.findPersonAndTransit(id, pais, subTipoDoc, nroDocumento: string): aTransitos;

  function whereNroDocumento:String;
  var
    i:Integer;
    StrNroDoc:String;
  begin
    Result := '';
    StrNroDoc := '';
    for i:=1 to Length(nroDocumento) do
    begin
      if (nroDocumento[i] in ['0'..'9']) then
        StrNroDoc := StrNroDoc+ nroDocumento[i];
    end;

    //if Length(StrNroDoc)<=5 then
      Result := 'and (P.DOCNUMERO = '''+nroDocumento+''') ';
//    else
  //    Result := 'and ((P.DOCNUMEROENTERO = '+StrNroDoc+') or (P.DOCNUMERO = '''+nroDocumento+'''))';
  end;


var
  aux, logueo: string;
  auxTran:TTransit;
  i,j,indaux:integer;
  MySettings: TFormatSettings;
  auxATransitos:aTransitos;
  lsIdTranOlSicam:TStringList;
  wsrenaper : IwsRenaper;
  respuestaRenaper : ciudadanosYDetalle;
  ape1, ape2, nom1, nom2 : string;
  facialEnBase64: string;
  stream: TMemoryStream;
  glb_pathbiometrico, imagen: string;
  image: TJPEGImage;
  veces:Integer;



  // JPB - Inicio
    resultado : string;
    fecha_actual : Tdatetime;
  // JPB - Fin
begin
  nroDocumento := Trim(nroDocumento);
  if nroDocumento = NullAsStringValue then
    Exit;
  logueo := NullAsStringValue;
  log('findPersonAndTransit_'+nroDocumento, 'voy a conectarme'+#13#10);

  Result := nil;
  try
    FbaseOracle := TbaseDatos.create;

    FbaseOracle.server    := 'PADRON';  //'PADRON';
    FbaseOracle.username  := 'personas';
    FbaseOracle.password  := 'p3rs0n4$';
    FbaseOracle.connected := TRUE;
    FbaseOracle.ForaQuery.sql.Text := 'select ' +
                                      'P.IDTRAN_OL_SICAM, P.IDLOC, P.DOCTIPO, '+
                                      'P.DOCTIPODESCRIPCION, P.PAISEMISOR, P.DOCSUBTIPO, '+
                                      'P.DOCSUBTIPODESCRIPCION, P.DOCNUMERO, P.APELLIDO1, '+
                                      'P.APELLIDO2, P.NOMBRE1, P.NOMBRE2, '+
                                      'to_char(P.FECNAC,''DD/MM/YYYY'') as FECNAC, P.SEXO, P.NACIONALIDAD, '+
                                      'P.DOCVENCIMIENTO, P.DOCNUMEROENTERO, P.PASOFRONTERIZO, '+
                                      'to_char(P.T1_FECHA_CRUCE,''DD/MM/YYYY HH24:MI:SS'') as T1_FECHA_CRUCE, '+
                                      'P.T1_TIPO_DOC, P.T1_NUM_DOC, '+
                                      'P.T1_APELLIDO1, P.T1_APELLIDO2, P.T1_NOMBRE1, '+
                                      'P.T1_NOMBRE2, P.T1_SEXO, to_char(P.T1_FECHA_NAC,''DD/MM/YYYY'') as T1_FECHA_NAC, '+
                                      'P.T1_NACIONALIDAD, P.T1_PASO_CRUCE, P.T1_TIPO_CRUCE, '+
                                      'P.T1_DIAS_PERM, P.T1_IDTRAN_OL_SICAM, '+
                                      'to_char(P.T2_FECHA_CRUCE,''DD/MM/YYYY HH24:MI:SS'') as T2_FECHA_CRUCE, '+
                                      'P.T2_TIPO_DOC, P.T2_NUM_DOC, P.T2_APELLIDO1, '+
                                      'P.T2_APELLIDO2, P.T2_NOMBRE1, P.T2_NOMBRE2, '+
                                      'P.T2_SEXO, to_char(P.T2_FECHA_NAC,''DD/MM/YYYY'') as T2_FECHA_NAC, P.T2_NACIONALIDAD, '+
                                      'P.T2_PASO_CRUCE, P.T2_TIPO_CRUCE, P.T2_DIAS_PERM, '+
                                      'P.T2_IDTRAN_OL_SICAM, '+
                                      'to_char(P.T3_FECHA_CRUCE,''DD/MM/YYYY HH24:MI:SS'') as T3_FECHA_CRUCE, '+
                                      'P.T3_TIPO_DOC, '+
                                      'P.T3_NUM_DOC, P.T3_APELLIDO1, P.T3_APELLIDO2, '+
                                      'P.T3_NOMBRE1, P.T3_NOMBRE2, P.T3_SEXO, '+
                                      'to_char(P.T3_FECHA_NAC,''DD/MM/YYYY'') as T3_FECHA_NAC,  P.T3_NACIONALIDAD, P.T3_PASO_CRUCE, '+
                                      'P.T3_TIPO_CRUCE, P.T3_DIAS_PERM, P.T3_IDTRAN_OL_SICAM, '+
                                      'to_char(P.TM_FECHA_CRUCE,''DD/MM/YYYY HH24:MI:SS'') as TM_FECHA_CRUCE, '+
                                      'P.TM_TIPO_DOC, P.TM_NUM_DOC, '+
                                      'P.TM_APELLIDO1, P.TM_APELLIDO2, P.TM_NOMBRE1, '+
                                      'P.TM_NOMBRE2, P.TM_SEXO,to_char(P.TM_FECHA_NAC,''DD/MM/YYYY'') as TM_FECHA_NAC, '+
                                      'P.TM_NACIONALIDAD, P.TM_PASO_CRUCE, P.TM_TIPO_CRUCE, '+
                                      'P.TM_DIAS_PERM, P.TM_IDTRAN_OL_SICAM, P.ACTUALIZADO '+
                                      'from ' +
                                      'personas.personas P ' +
                                      'where '+
                                      'P.DOCTIPO = :PDOCTIPO '+
                                      'and P.PAISEMISOR = :PAISEMISOR ' +
                                      'and P.DOCSUBTIPO = :PDOCSUBTIPO '+
                                      whereNroDocumento + ' order by P.T1_FECHA_CRUCE desc ';//'and P.DOCNUMERO = :PDOCNUMERO';

    FbaseOracle.ForaQuery.ParamByName('PDOCTIPO').asString:= id;
    FbaseOracle.ForaQuery.ParamByName('PAISEMISOR').asString:= pais;
    FbaseOracle.ForaQuery.ParamByName('PDOCSUBTIPO').asString:= subTipoDoc;
   // FbaseOracle.ForaQuery.ParamByName('PDOCNUMERO').asString:= nroDocumento;
    FbaseOracle.executeSql;
    logueo := logueo +' - '+ FormatDateTime('dd/mm/yyyy HH:mm:ss:zzz',now)+' - termine la consulta'+#13#10;
    //FbaseOracle.ForaQuery.SQL.SaveToFile('./sql_wspersonas.txt');
    if not FbaseOracle.ForaQuery.IsEmpty then
    begin
      //El primer transito en realidad es la informacion del ciudadano.
      //Sobra la info de transito ya que no posee.
      SetLength(Result, 5);
      Result[0] := TTransit.Create;
      with Result[0] do
      begin
        Apellido1 := FbaseOracle.ForaQuery.fieldbyname('APELLIDO1').AsString;
        Apellido2 := FbaseOracle.ForaQuery.fieldbyname('APELLIDO2').AsString;
        Nombre1   := FbaseOracle.ForaQuery.fieldbyname('NOMBRE1').AsString;
        Nombre2   := FbaseOracle.ForaQuery.fieldbyname('NOMBRE2').AsString;
        Nacionalidad := FbaseOracle.ForaQuery.fieldbyname('NACIONALIDAD').AsString;
        Sexo      := FbaseOracle.ForaQuery.fieldbyname('SEXO').AsString;
        DocVenc := FbaseOracle.ForaQuery.fieldbyname('DOCVENCIMIENTO').AsString;
        DocNro := FbaseOracle.ForaQuery.fieldbyname('DOCNUMERO').AsString;
        DocTipo := FbaseOracle.ForaQuery.fieldbyname('DOCTIPO').AsString;
        DocPaisEmisor := FbaseOracle.ForaQuery.fieldbyname('PAISEMISOR').AsString;
        DocSubTipo := FbaseOracle.ForaQuery.fieldbyname('DOCSUBTIPO').AsString;
        FechaNac := FbaseOracle.ForaQuery.fieldbyname('FECNAC').AsString;
      end;

      FbaseOracle.ForaQuery.First;

      lsIdTranOlSicam := TStringList.Create;
      indaux := 0;
      veces := 0;

      while not FbaseOracle.ForaQuery.Eof do
      begin
        SetLength(auxATransitos,length(auxATransitos)+3);

        for i:=1 to 3 do
        begin
          auxATransitos[indaux]:= TTransit.Create;
          if lsIdTranOlSicam.IndexOf(FbaseOracle.ForaQuery.fieldbyname('T'+inttostr(i)+'_IDTRAN_OL_SICAM').AsString)<>-1 then
          begin
            indaux := indaux + 1;
            Continue;
          end;

          auxATransitos[indaux].FechaCruce:= FbaseOracle.ForaQuery.fieldbyname('T'+inttostr(i)+'_FECHA_CRUCE').AsString;
          auxATransitos[indaux].PasoCruce:= FbaseOracle.ForaQuery.fieldbyname('T'+inttostr(i)+'_PASO_CRUCE').AsString;
          auxATransitos[indaux].TipoCruce:= FbaseOracle.ForaQuery.fieldbyname('T'+inttostr(i)+'_TIPO_CRUCE').AsString;
          auxATransitos[indaux].DiasPermanencia:= FbaseOracle.ForaQuery.fieldbyname('T'+inttostr(i)+'_DIAS_PERM').AsString;
          auxATransitos[indaux].Apellido1:= FbaseOracle.ForaQuery.fieldbyname('T'+inttostr(i)+'_APELLIDO1').AsString;
          auxATransitos[indaux].Apellido2:= FbaseOracle.ForaQuery.fieldbyname('T'+inttostr(i)+'_APELLIDO2').AsString;
          auxATransitos[indaux].Nombre1:= FbaseOracle.ForaQuery.fieldbyname('T'+inttostr(i)+'_NOMBRE1').AsString;
          auxATransitos[indaux].Nombre2:= FbaseOracle.ForaQuery.fieldbyname('T'+inttostr(i)+'_NOMBRE2').AsString;
          auxATransitos[indaux].Sexo:= FbaseOracle.ForaQuery.fieldbyname('T'+inttostr(i)+'_SEXO').AsString;
          auxATransitos[indaux].DocNro:= FbaseOracle.ForaQuery.fieldbyname('T'+inttostr(i)+'_NUM_DOC').AsString;
          auxATransitos[indaux].DocTipo:= FbaseOracle.ForaQuery.fieldbyname('T'+inttostr(i)+'_TIPO_DOC').AsString;
          auxATransitos[indaux].FechaNac:= FbaseOracle.ForaQuery.fieldbyname('T'+inttostr(i)+'_FECHA_NAC').AsString;
          auxATransitos[indaux].Nacionalidad:= FbaseOracle.ForaQuery.fieldbyname('T'+inttostr(i)+'_NACIONALIDAD').AsString;
          auxATransitos[indaux].IdTranOlSicam:= FbaseOracle.ForaQuery.fieldbyname('T'+inttostr(i)+'_IDTRAN_OL_SICAM').AsString;
          lsIdTranOlSicam.Add(auxATransitos[indaux].IdTranOlSicam);
          indaux := indaux + 1;
        end;
        FbaseOracle.ForaQuery.Next;

        veces := veces + 1;

        if veces>30 then break;
      end;


      lsIdTranOlSicam.Free;

      GetLocaleFormatSettings(GetUserDefaultLCID, MySettings);
      MySettings.DateSeparator := '/';
      MySettings.TimeSeparator := ':';
      MySettings.ShortDateFormat := 'dd/mm/yyyy';
      MySettings.ShortTimeFormat := 'hh:nn:ss';

      for i:=0 to length(auxATransitos)-1 do
        if auxATransitos[i].FechaCruce='' then
          auxATransitos[i].FechaCruce := '01/01/1900 01:00:00';


      for i:=0 to length(auxATransitos)-2 do
      begin
        for j:=i+1 to length(auxATransitos)-1 do
        begin
          if StrToDateTime(auxATransitos[i].FechaCruce, MySettings)<StrToDateTime(auxATransitos[j].FechaCruce, MySettings) then
          begin
            auxTran := TTransit.Create;
            auxTran.FechaCruce := auxATransitos[i].FechaCruce;
            auxTran.PasoCruce := auxATransitos[i].PasoCruce;
            auxTran.TipoCruce := auxATransitos[i].TipoCruce;
            auxTran.DiasPermanencia := auxATransitos[i].DiasPermanencia;
            auxTran.Apellido1 := auxATransitos[i].Apellido1;
            auxTran.Apellido2 := auxATransitos[i].Apellido2;
            auxTran.Nombre1 := auxATransitos[i].Nombre1;
            auxTran.Nombre2 := auxATransitos[i].Nombre2;
            auxTran.Sexo := auxATransitos[i].Sexo;
            auxTran.DocNro := auxATransitos[i].DocNro;
            auxTran.DocTipo := auxATransitos[i].DocTipo;
            auxTran.FechaNac := auxATransitos[i].FechaNac;
            auxTran.Nacionalidad := auxATransitos[i].Nacionalidad;
            auxTran.IdTranOlSicam := auxATransitos[i].IdTranOlSicam;

            auxATransitos[i].FechaCruce := auxATransitos[j].FechaCruce;
            auxATransitos[i].PasoCruce := auxATransitos[j].PasoCruce;
            auxATransitos[i].TipoCruce := auxATransitos[j].TipoCruce;
            auxATransitos[i].DiasPermanencia := auxATransitos[j].DiasPermanencia;
            auxATransitos[i].Apellido1 := auxATransitos[j].Apellido1;
            auxATransitos[i].Apellido2 := auxATransitos[j].Apellido2;
            auxATransitos[i].Nombre1 := auxATransitos[j].Nombre1;
            auxATransitos[i].Nombre2 := auxATransitos[j].Nombre2;
            auxATransitos[i].Sexo := auxATransitos[j].Sexo;
            auxATransitos[i].DocNro := auxATransitos[j].DocNro;
            auxATransitos[i].DocTipo := auxATransitos[j].DocTipo;
            auxATransitos[i].FechaNac := auxATransitos[j].FechaNac;
            auxATransitos[i].Nacionalidad := auxATransitos[j].Nacionalidad;
            auxATransitos[i].IdTranOlSicam := auxATransitos[j].IdTranOlSicam;


            auxATransitos[j].FechaCruce := auxTran.FechaCruce;
            auxATransitos[j].PasoCruce := auxTran.PasoCruce;
            auxATransitos[j].TipoCruce := auxTran.TipoCruce;
            auxATransitos[j].DiasPermanencia := auxTran.DiasPermanencia;
            auxATransitos[j].Apellido1 := auxTran.Apellido1;
            auxATransitos[j].Apellido2 := auxTran.Apellido2;
            auxATransitos[j].Nombre1 := auxTran.Nombre1;
            auxATransitos[j].Nombre2 := auxTran.Nombre2;
            auxATransitos[j].Sexo := auxTran.Sexo;
            auxATransitos[j].DocNro := auxTran.DocNro;
            auxATransitos[j].DocTipo := auxTran.DocTipo;
            auxATransitos[j].FechaNac := auxTran.FechaNac;
            auxATransitos[j].Nacionalidad := auxTran.Nacionalidad;
            auxATransitos[j].IdTranOlSicam := auxTran.IdTranOlSicam;

            FreeAndNil(auxTran);
          end;
        end;
      end;




      //Los 3 ultimos transitos de la persona + un transito metropolitano.
      for i:=1 to 3 do
      begin
        result[i]:= TTransit.Create;
        result[i].FechaCruce := auxATransitos[i-1].FechaCruce;
        result[i].PasoCruce := auxATransitos[i-1].PasoCruce;
        result[i].TipoCruce := auxATransitos[i-1].TipoCruce;
        result[i].DiasPermanencia := auxATransitos[i-1].DiasPermanencia;
        result[i].Apellido1 := auxATransitos[i-1].Apellido1;
        result[i].Apellido2 := auxATransitos[i-1].Apellido2;
        result[i].Nombre1 := auxATransitos[i-1].Nombre1;
        result[i].Nombre2 := auxATransitos[i-1].Nombre2;
        result[i].Sexo := auxATransitos[i-1].Sexo;
        result[i].DocNro := auxATransitos[i-1].DocNro;
        result[i].DocTipo := auxATransitos[i-1].DocTipo;
        result[i].FechaNac := auxATransitos[i-1].FechaNac;
        result[i].Nacionalidad := auxATransitos[i-1].Nacionalidad;
        result[i].IdTranOlSicam := auxATransitos[i-1].IdTranOlSicam;
        if auxATransitos[i-1].FechaCruce = '01/01/1900 01:00:00' then
          result[i].IdTranOlSicam := '';
      end;

       //Los transitos de area metropolitana vienen con m 'TM'

      FbaseOracle.ForaQuery.First;
      i := 4;
      result[i]:= TTransit.Create;
      result[i].FechaCruce:= FbaseOracle.ForaQuery.fieldbyname('TM_FECHA_CRUCE').AsString;
      result[i].PasoCruce:= FbaseOracle.ForaQuery.fieldbyname('TM_PASO_CRUCE').AsString;
      result[i].TipoCruce:= FbaseOracle.ForaQuery.fieldbyname('TM_TIPO_CRUCE').AsString;
      result[i].DiasPermanencia:= FbaseOracle.ForaQuery.fieldbyname('TM_DIAS_PERM').AsString;
      result[i].Apellido1:= FbaseOracle.ForaQuery.fieldbyname('TM_APELLIDO1').AsString;
      result[i].Apellido2:= FbaseOracle.ForaQuery.fieldbyname('TM_APELLIDO2').AsString;
      result[i].Nombre1:= FbaseOracle.ForaQuery.fieldbyname('TM_NOMBRE1').AsString;
      result[i].Nombre2:= FbaseOracle.ForaQuery.fieldbyname('TM_NOMBRE2').AsString;
      result[i].Sexo:= FbaseOracle.ForaQuery.fieldbyname('TM_SEXO').AsString;
      result[i].DocNro:= FbaseOracle.ForaQuery.fieldbyname('TM_NUM_DOC').AsString;
      result[i].DocTipo:= FbaseOracle.ForaQuery.fieldbyname('TM_TIPO_DOC').AsString;
      result[i].FechaNac:= FbaseOracle.ForaQuery.fieldbyname('TM_FECHA_NAC').AsString;
      result[i].Nacionalidad:= FbaseOracle.ForaQuery.fieldbyname('TM_NACIONALIDAD').AsString;
      result[i].IdTranOlSicam:= FbaseOracle.ForaQuery.fieldbyname('TM_IDTRAN_OL_SICAM').AsString;



      for i:=0 to length(auxATransitos)-1 do
        FreeAndNil(auxATransitos[i]);




/////////////////////////////////////////////////////////////////
/////******   JPB - Turista Cronico - Inicio    ***********//////
/////////////////////////////////////////////////////////////////

      try

        fecha_Actual := strtodatetime(formatdatetime('dd/mm/yyyy',date)+' '+formatdatetime('HH:mm:ss',time));
        if (result[1].Nacionalidad <> 'ARGENTINA') and
           (result[1].Nacionalidad <> 'BRASILE—A') and
           (result[1].Nacionalidad <> 'URUGUAYA') and
           (result[1].Nacionalidad <> 'CHILENA') and
           (result[1].Nacionalidad <> 'PARAGUAYA') and
           (result[1].Nacionalidad <> 'BOLIVIANA') then
        begin
          if (result[3].fechacruce <> '') then
          begin
            if (Result[1].TipoCruce = 'S') and (Result[2].TipoCruce = 'E') and (Result[3].TipoCruce = 'S') then
            begin
              if ((fecha_Actual - strtodate(formatdatetime('dd/mm/yyyy',strtodateTIME(result[3].fechacruce)))) < 200)
                    and
                 ((fecha_Actual - strtodate(formatdatetime('dd/mm/yyyy',strtodatetime(result[3].fechacruce)))) > 100)
                 and ( DaysBetween(StrToDateTime(result[1].FechaCruce), StrToDateTime(result[2].FechaCruce)) > 4) then      // by pipo 20141028
              begin
                resultado :=  result[1].Nacionalidad +'|'+ result[1].fechanac +'|'+result[1].doctipo +'|'+ result[1].docnro +'|'+ formatdatetime('dd/mm/yyyy HH:mm:ss', fecha_Actual) +'|'+result[1].FechaCruce+'|'+result[2].FechaCruce+'|'+result[3].FechaCruce+'|'+IntToStr(DaysBetween(StrToDateTime(result[1].FechaCruce), StrToDateTime(result[2].FechaCruce)));
//                generarTxT ('.\'+FormatDateTime('yyyymmdd',date)+'-turistaCronico.txt',resultado);
                generarTxT ('.\turistaCronico.txt',resultado);
              end;{
              else
              begin
                 resultado :=  'NO '+result[1].Nacionalidad +'|'+result[1].fechanac +'|'+result[1].doctipo +'|'+ result[1].docnro +'|'+ formatdatetime('dd/mm/yyyy HH:mm:ss', fecha_Actual) +'|'+result[1].FechaCruce+'|'+result[2].FechaCruce+'|'+result[3].FechaCruce;
                 generarTxT ('.\turistaCronico.txt',resultado);
              end; }
            end;
          end;
        end;

      EXCEPT
        //esto es para que si surge un error en el procesos, no pase nada ydebuelva bien los datos en SICaM
      END;


/////////////////////////////////////////////////////////////////
/////******     JPB - Turista Cronico - FIN     ***********//////
/////////////////////////////////////////////////////////////////


      SetLength(auxATransitos,0);
      FbaseOracle.connected := False;

    end
    else
    begin
      try
         logueo := logueo +' - '+ FormatDateTime('dd/mm/yyyy HH:mm:ss:zzz',now)+' - no esta en padron, voy a renaper'+#13#10;
        FbaseOracle.connected := False;
        FbaseOracle.destroy;
        if (pais = 'ARGENTINA') and  (StrToInt(Trim(nroDocumento)) < 90000000) then
        begin

          log('wsrenaper_'+nroDocumento,'');

          wsrenaper := GetIwsRenaper(false);

          //SetLength(respuestaRenaper, 1);
          SetLength(Result, 1);
          Result[0] := TTransit.Create;

         { logueo := logueo +' - '+ FormatDateTime('dd/mm/yyyy HH:mm:ss:zzz',now)+' - voy a ir a renaper a buscar por masculino'+#13#10;
          log('wsrenaper_'+nroDocumento,logueo);  }

          respuestaRenaper := wsrenaper.consultaUnificada(nroDocumento, 'M');


         { logueo := logueo +' - '+ FormatDateTime('dd/mm/yyyy HH:mm:ss:zzz',now)+' - termine de consultar por masculino'+#13#10;
          log('wsrenaper_'+nroDocumento,logueo);    }
          if respuestaRenaper[0].numeroError=0 then
          //if (Length(respuestaRenaper) = 0) then   ahora siempre viene el arreglo, pero con los algunos campos vacios. Pipo 20181217
            begin
              respuestaRenaper := wsrenaper.consultaUnificada(nroDocumento, 'F');
              //logueo := logueo +' - '+ FormatDateTime('dd/mm/yyyy HH:mm:ss:zzz',now)+' - termine de consultar por femenino'+#13#10;
            end;
          //if (Length(respuestaRenaper) > 0) then
         if (respuestaRenaper[0].numeroError > 0) then
          begin
            if (respuestaRenaper[0].foto <> '') then
            begin
               ape1 := '';
               ape2 := '';
               nom1 := '';
               nom2 := '';
               respuestaRenaper[0].apellido := EliminaAcentos(respuestaRenaper[0].apellido);
               respuestaRenaper[0].nombres  := EliminaAcentos(respuestaRenaper[0].nombres);
               FixNames(respuestaRenaper[0].apellido, ape1, ape2);
               FixNames(respuestaRenaper[0].nombres, nom1, nom2);
               Result[0].Apellido1       := UpperCase(quitarComillasSimples(ape1));
               Result[0].Apellido2       := UpperCase(quitarComillasSimples(ape2));
               Result[0].Nombre1         := UpperCase(quitarComillasSimples(nom1));
               Result[0].Nombre2         := UpperCase(quitarComillasSimples(nom2));
               Result[0].Sexo            := respuestaRenaper[0].sexo;
               Result[0].FechaNac        := copy( respuestaRenaper[0].fechanac , 9, 2)
                + '/' + copy( respuestaRenaper[0].fechanac , 6, 2)
                + '/' + copy( respuestaRenaper[0].fechanac , 1, 4);
               Result[0].Nacionalidad    := 'ARGENTINA';//respuestaRenaper[0].nacionalidad;
               Result[0].DocNro          := respuestaRenaper[0].nrodni;
               Result[0].FechaCruce      := '';
               Result[0].PasoCruce       := '';
               Result[0].TipoCruce       := '';
               Result[0].DiasPermanencia := '';
               Result[0].DocVenc         := '';
               Result[0].DocTipo         := id;
               Result[0].DocPaisEmisor   := pais;
               Result[0].DocSubTipo      := subTipoDoc;
               Result[0].IdTranOlSicam   := '';
            end;

            //FreeAndNil(auxTran);

            { facialEnBase64 := respuestaRenaper[0].foto;

             //obtengo el wsq que esta en base64
             imagen := Decode64(facialEnBase64);
             //lo guardo en un archivo
             Stream := TMemoryStream.Create;
             Stream.Write(imagen[1],LENGTH(imagen));
             //Guardo el wsq con el nombre que me pasaron

             DateTimeToString(glb_pathbiometrico,'yyyymmddHHnnss',obtenerFechaYhora);
             if not DirectoryExists(GetEnvironmentVariable('UserProfile')+'\biometria' + '\' + glb_pathbiometrico) then
               ForceDirectories(GetEnvironmentVariable('UserProfile')+'\biometria' + '\' + glb_pathbiometrico);
             if not FileExists(GetEnvironmentVariable('UserProfile')+'\biometria' + '\' + glb_pathbiometrico + '\rostroDNM.jpg') then
               Stream.SaveToFile(GetEnvironmentVariable('UserProfile')+'\biometria' + '\' + glb_pathbiometrico + '\rostroDNM.jpg');

             stream.Free;   }
          end;
         DeleteFile(Pchar(ExtractFilePath(Application.ExeName)+'\Logs\wsrenaper_'+nroDocumento));
        end;
      except

      end;
    end;

  except
  end;
   log('findPersonAndTransit_'+nroDocumento, logueo);
   if nroDocumento <>'28648771' then
      DeleteFile(Pchar(ExtractFilePath(Application.ExeName)+'\Logs\findPersonAndTransit_'+nroDocumento));
end;

function Twebusersicam.usuarios_pasos(usuario, documentonro, clavesistema,
  apellidos, nombres, pasold, pasonew, idusuariostipos, credencial: string): string;

begin

  result := refresh(pchar(usuario), pchar(documentonro), pchar(clavesistema), pchar(apellidos),
                    pchar(nombres), pchar(pasold), pchar(pasonew), pchar(idusuariostipos), pchar(credencial));
end;

function Twebusersicam.findPathImages(id_loc, fechaTransito:string):tstringlist; stdcall;
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



var inifile:TIniFile;
    Server,Username,Password, strSql:String;
    list: tstringlist;
    oraConn: TOraSession;
    query : TOraQuery;
begin
//  inifile := TIniFile.Create(Format('%sconfig.ini', [ExtractFilePath(GetWSDir)]));
  inifile := TIniFile.Create('.\config.ini');
  list:= TStringList.Create;
  try
    Server := inifile.ReadString('Database', 'server', '');
    Username := inifile.ReadString('Database', 'username', '');
    Password := inifile.ReadString('Database', 'password', '');
  finally
    inifile.Free;
  end;
  oraConn:= TOraSession.Create(nil);

  oraConn.Server := server;
  oraConn.Username := username;
  oraConn.Password := password;
  oraConn.Connected:= true;

  query:= TOraQuery.Create(nil);
  query.Session:= oraConn;
  query.FetchAll:= true;
  try
    if not oraConn.InTransaction then
    begin

      oraConn.StartTransaction;
      query.Close;
      query.sql.Clear;

      query.SQL.Add('SELECT I.PATH, D.DESCRIPCION FROM TRAVEL_OWNER.DB_LOC D, TRAVEL_OWNER.IMAGENES_PATH I ' +
                    'WHERE   I.ID_LOC =  ' +''''+id_loc +''''+
                    ' AND D.ID_LOC = I.ID_LOC ' +
                    'AND  to_date('+''''+ fechaTransito+''''+', ''dd/mm/yyyy'')  BETWEEN I.FECHA_INI AND I.FECHA_FIN ' +
                    'AND I.ESTRUCTURA = ''T'' ');

      //Viejo sql, fue reemplazado por el de arriba.
      {query.sql.Add('select L.BIOMETRIC_PATH, L.DESCRIPCION'+
                    ' from TRAVEL_OWNER.DB_LOC L where L.DESCRIPCION= ' + QuotedStr(UpperCase(trim(pasoCruce))));}
      query.Open;
      //query.sql.SaveToFile('./qry_Images_Path.txt');

      oraConn.Commit;

      if not query.IsEmpty then
      begin
        list.add(' ' + query.fieldByName('PATH').AsString);
        list.add(' ' + query.fieldByName('DESCRIPCION').AsString);
      end
      else
      begin
        list.add('');
        list.add('');
      end;
    end;
  Except
    oraConn.Rollback;
  end;



  oraConn.Connected:= false;

  result:= list;
end;



function Twebusersicam.findIdTransit(idTranOlSicam:string):string; stdcall;
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

var inifile:TIniFile;
    Server,Username,Password, strSql:String;
    list: tstringlist;
    oraConn: TOraSession;
    query : TOraQuery;
begin
   inifile := TIniFile.Create(Format('%sconfig.ini', [ExtractFilePath(GetWSDir)]));
  list:= TStringList.Create;
  try
    Server := inifile.ReadString('Database_bcshq8', 'server', '');
    Username := inifile.ReadString('Database_bcshq8', 'username', '');
    Password := inifile.ReadString('Database_bcshq8', 'password', '');
  finally
    inifile.Free;
  end;
  oraConn:= TOraSession.Create(nil);

  oraConn.Server := server;
  oraConn.Username := username;
  oraConn.Password := password;
  oraConn.Connected:= true;

  query:= TOraQuery.Create(nil);
  query.Session:= oraConn;
  query.FetchAll:= true;

  try
    if not oraConn.InTransaction then
    begin
      oraConn.StartTransaction;
      query.Close;
      query.SQL.Clear;
      query.SQL.Add('select T.IDTRANSITO from TRAVEL_OWNER.TRANSITOS_ONLINE T'+
                    ' where T.IDTRAN_OL_SICAM= ' + trim(idTranOlSicam));
      query.Open;
      oraConn.Commit;
      if not query.IsEmpty then
        result:= query.fieldByName('IDTRANSITO').AsString
      else
        result:= '';
    end;
  except
    oraConn.Rollback;
  end;
  oraConn.Connected:= False;
end;


//MÈtodo para obtener las imagenes faciales y dactilares
function Twebusersicam.findImagesTransit(id, pais, subTipoDoc, nroDocumento:string):aImagesTransit; stdcall;

const dactilares : array[0..9] of string = ('Pulgar_Der', 'Indice_Der', 'Mayor_Der', 'Anular_Der',
                                            'Menique_Der','Pulgar_Izq', 'Indice_Izq', 'Mayor_Izq',
                                            'Anular_Izq', 'Menique_Izq');

      descripcionDactilares : array[0..9] of string = ('PULGAR DERECHO', 'INDICE DERECHO', 'MAYOR DERECHO',
                                                       'ANULAR DERECHO', 'MENIQUE DERECHO','PULGAR IZQUIERDO',
                                                       'INDICE IZQUIERDO', 'MAYOR IZQUIERDO', 'ANULAR IZQUIERDO',
                                                       'MENIQUE IZQUIERDO');

var dia, mes, anio, hora, fechaCruce:string;
    wAnyo, wMes, wDia: Word;
    wHora, wMinutos, wSegundos, wMilisegundos: Word;
    id_loc, path, tmIdTransit_ol, idTransit, pasoCruce:string;
    path_images: TStringlist;
    netConnection : TNetConnection;
    i:integer;


  function LoadImage(Filename: String):string;
  var
  fi: TFileStream;
  resultado : STRING;
  begin
    resultado:= '';
    fi := TFileStream.Create(Filename, fmOpenRead or fmShareDenyNone);
    fi.Position := 0;
    SetLength(resultado, fi.Size);
    fi.Read(pointer(resultado)^, fi.Size);
    fi.Free;
    result:= encode64(resultado);
  end;


begin
  log('findImagesTransit_'+Trim(nroDocumento),'arranco');


  FbaseOracle := TbaseDatos.create;

  FbaseOracle.server    := 'PADRON';
  FbaseOracle.username  := 'personas';
  FbaseOracle.password  := 'p3rs0n4$';
  FbaseOracle.connected := TRUE;
  FbaseOracle.ForaQuery.sql.Text := 'select * from personas.personas ' +
                          'where DOCTIPO = :PDOCTIPO and PAISEMISOR = :PAISEMISOR ' +
                          'and DOCSUBTIPO = :PDOCSUBTIPO and DOCNUMERO = :PDOCNUMERO';

  FbaseOracle.ForaQuery.ParamByName('PDOCTIPO').asString:= id;
  FbaseOracle.ForaQuery.ParamByName('PAISEMISOR').asString:= pais;
  FbaseOracle.ForaQuery.ParamByName('PDOCSUBTIPO').asString:= subTipoDoc;
  FbaseOracle.ForaQuery.ParamByName('PDOCNUMERO').asString:= nroDocumento;
  FbaseOracle.ForaQuery.Open;
  fechaCruce:= FormatDateTime( 'dd/mm/yyyy HH:mm:ss',
                                   FbaseOracle.ForaQuery.fieldbyname('TM_FECHA_CRUCE').asdatetime);

  SetLength(Result, 2);
  Result[0] := TImagesTransit.Create;

  result[0].ErrorCode:= '0';
  if fechaCruce <> '' then
  begin
    result[0].ErrorCode:= '1';
    path_images:= TStringlist.Create;
    DecodeDateTime(StrToDateTime(fechaCruce), wAnyo, wMes, wDia, wHora,
                                                              wMinutos, wSegundos, wMilisegundos );
    dia:= IntToStr(wDia);
    mes:= IntToStr(wMes);
    anio:= IntToStr(wAnyo);
    hora:= IntToStr(wHora);

    tmIdTransit_ol:= FbaseOracle.ForaQuery.fieldbyname('TM_IDTRAN_OL_SICAM').AsString;

    idTransit:= findIdTransit(tmIdTransit_ol);

    pasoCruce:= FbaseOracle.ForaQuery.fieldbyname('TM_PASO_CRUCE').AsString;

    id_loc := FbaseOracle.ForaQuery.fieldbyname('TM_IDLOC').AsString;

    path_images:= findPathImages(id_loc, FormatDateTime('dd/mm/yyyy',StrToDateTime(fechaCruce)));

    path:= path_images.ValueFromIndex[0] + '\' + path_images.ValueFromIndex[1] + '\' + anio +
                                           '\' + mes + '\' + dia + '\' + hora + '\' + idTransit;

    {netConnection:= TNetConnection.Create(nil);
    netConnection.UserName:= 'migraciones\biotrans_ro';
    netConnection.Password:= 'Aps9tLZgQxM5R98Z';
    netConnection.RemoteName:= path_images.ValueFromIndex[0] ;
    netConnection.ResourceType:= rtDisk;
    netConnection.Connect;   }

  {
    if FileExists(path+'\'+idTransit+'-FACIAL.jpg') then
    begin
      result[0].NombreFacial:= idTransit+'-FACIAL.jpg';
      result[0].FileFacial:=  LoadImage(path+'\'+idTransit+'-FACIAL.jpg');
    end;
    i:=0;
    while (i<=9) and not FileExists(path+'\'+idTransit+'-'+dactilares[i]+'.wsq') do
    begin
       i:= i + 1;
    end;
    if(i<=9)then
    begin
      result[0].DescripcionDactilar:= descripcionDactilares[i];
      result[0].NombreDactilar:= idTransit+'-'+dactilares[i]+'.wsq';
      result[0].FileDactilar:= LoadImage(path+'\'+idTransit+'-'+dactilares[i]+'.wsq');
    end;
       }

    FbaseOracle.connected := False;

  end;

  DeleteFile(Pchar(ExtractFilePath(Application.ExeName)+'\Logs\findImagesTransit_'+Trim(nroDocumento)));
end;

initialization
  { Invokable classes must be registered }
  InvRegistry.RegisterInvokableClass(Twebusersicam);

end.
