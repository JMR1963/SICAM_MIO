{ Invokable implementation File for TwsRestriccion which implements IwsRestriccion }

unit wsRestriccionImpl;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, wsRestriccionIntf, System.DateUtils;

type

  { TwsRestriccion }
  TwsRestriccion = class(TInvokableClass, IwsRestriccion)
  public
//     function buscarRestricciones(Apellidos, Nombres, fechaNac, nroDoc,nrolibreta, genero, tipoDoc, paisEmisorDoc, nacionalidad, fechaVTO:string): TRespuesta; stdcall;
     function buscarRestricciones(Apellidos, Nombres, fechaNac, nroDoc,nrolibreta, genero,tipoDoc,paisEmisorDoc,nacionalidad : string ; fechaVTO:string=''): TRespuesta; stdcall;
     function ConsultaImpedimentosArgentina(consulta: DatosEntrada): DatosSalida; stdcall;
  end;

implementation

uses uDMRestriccion, System.SysUtils, System.Classes, System.IniFiles, System.Math, IinfoTransporte1, wsAnticipadaDNM;
     //IinfoTransporte2

function ParseName(str:string):TStringList;
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


function IsFucked(str:string):integer;
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


procedure FixNames(name:string;var str1,str2:String);
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

procedure msgLOG(msg: String);
var
  archivo: TStringList;
  arch:String;
begin
     try
      archivo := TStringList.Create;
      try
        arch:= ExtractFilePath(ParamStr(0))+'debug_LOG.log';

        if FileExists(arch) then
        begin
          archivo.LoadFromFile(arch);
        end;

        archivo.Add(FormatDateTime('dd-mm-yyyy hh:nn:ss', System.SysUtils.Now)+' - '+msg);
        archivo.SaveToFile(arch);
      finally
        archivo.Free;
      end;
    except
    end;
end;

procedure log(fileName,LogString: string);
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

function GetTransport( Ape1, ape2, nom1, Nom2, nroDoc,nrolibreta, sentido, tipoPaso,Paso,Fecha_nac:string; var vuelo:string):string;
var ws :IinfoTransporte;
    rtatra : trtaTransporte;
    r,rAntDNM: ansistring;
    str1:string;
begin
    try
        rtatra:= trtaTransporte.create;
        ws := GetIinfoTransporte(false);
        rtatra := ws.InfTransporte(Ape1, ape2, nom1, Nom2, nroDoc,nrolibreta, sentido, tipoPaso,Paso,Fecha_nac);
        msgLOG(rtatra.vuelo);
        vuelo:= rtatra.vuelo;
        Result:=rtatra.hayTransporte;
    except on E : Exception do
      begin
         msgLOG(e.Message);
      end;
    end;
end;


function TwsRestriccion.buscarRestricciones(Apellidos, Nombres, fechaNac, nroDoc,nrolibreta, genero, tipoDoc, paisEmisorDoc, nacionalidad : STRING; fechaVTO:string=''): TRespuesta;



  function AuxBuscarRestricciones2(Ape1, Ape2, Nom1, Nom2, fechaNac, nroDoc,nrolibreta, genero, tipoDoc, paisEmisorDoc, nacionalidad, fechaVTO:string): TRespuesta;
  var
    f:TDateTime;
    filename, path: String;
    vuelo, pasajero,respMenor, respSitMig : string;
    OrigenRestri,hayTransporte: string;
    ws :IinfoTransporte;
    rtatra : trtaTransporte;
    r,rAntDNM: ansistring;
    vuelo2:string;
  begin

    f := EncodeDate(StrToInt(copy(fechaNac,1,4)),StrToInt(copy(fechaNac,5,2)),StrToInt(copy(fechaNac,7,2)));
    begin
      Result := TRespuesta.Create;
      Result.Restriccion := '';
      rAntDNM := '';
      with TDMRestriccion.Create(nil) do
      try

         if ACTIVO_DDJJ = '1' then
         begin
            if (AnticipadaDNM<>'') then
            begin
              //                                  AnticipadaDNM,TRANSITODIRECCION,NRO_LIBRETA,APE_1,NOM_1,NRO_DOCUMENTO, FECHA_NAC:string)
              rAntDNM := ConsultarwsAnticipadaDNM(AnticipadaDNM,UpperCase(sentido),nrolibreta,Ape1,Nom1,nroDoc,FormatDateTime('DD/MM/YYYY',f),tipoPaso);

              if rAntDNM =  'NOT_OK' then
              begin
                Result.Restriccion := 'T';
                rAntDNM := '|DDJJ: '+rAntDNM;
                Exit;
              end;

              rAntDNM := '|DDJJ: '+rAntDNM;
            end;
         end;

        if ((UpperCase(sentido) = 'E') and (yearsBetween( f,Now())>=13))
            or
           ((UpperCase(sentido) = 'S') and (yearsBetween( f,Now())>= 18)) then //Forzado a 18 a�os, nunca se usara la saluda de Menore para mayores de 13 - Si se habilita, cambiar a 13 para qye tenga coherencia (*)
        begin

            Result.Restriccion := 'F';
            OrigenRestri := '';
            if TotalRestricciones('BR',Ape1, Ape2, Nom1, Nom2,f,nroDoc,nrolibreta, genero, tipoDoc, paisEmisorDoc, nacionalidad,fechaVTO, OrigenRestri)>0 then   //BR = buscarRestricciones
              Result.Restriccion := 'T';


            respMenor:='';
            respSitMig:='';
            if (Result.Restriccion <> 'T')  then
            begin

              try


                  ws := GetIinfoTransporte(false);
                  rtatra := ws.InfTransporte(Ape1, ape2, nom1, Nom2, nroDoc,nrolibreta, sentido, tipoPaso,Paso, formatdatetime('dd/mm/yyyy',f));
                  //rtatra := ws.InfTransporte(Ape1, '', nom1, '', nroDoc,'', sentido, tipoPaso,Paso, formatdatetime('dd/mm/yyyy',f));
                  msgLOG(Ape1 + '-' + ape2+ '-' +nom1+ '-' +Nom2+ '-' +nrodoc+ '-' +nrolibreta+ '-' +sentido+ '-' +paso+ '-' + formatdatetime('dd/mm/yyyy',f));
                  {
                  rtatra:=trtaTransporte.Create;
                  rtatra.hayTransporte:= GetTransport(Ape1, ape2, nom1, Nom2, nroDoc,nrolibreta, sentido, tipoPaso,Paso, formatdatetime('dd/mm/yyyy',f),vuelo2);
                  rtatra.vuelo:= vuelo2;
                  }
              except on E : Exception do
                begin
                   msgLOG(e.Message);
                end;
              end;

              //msgLOG(rtatra.hayTransporte);
              r:= rtatra.hayTransporte;
              //InfTransporte(Ape1, ape2, nom1, Nom2, nroDoc,nrolibreta, sentido, f, vuelo, pasajero, hayTransporte);
              If tipoPaso = 'A' then
              begin
                if debug_aereo = '0' then
                begin
                  if (rtatra.hayTransporte = 'F') and (rtatra.vuelo = '') then
                     Result.Restriccion := 'T';
                  Result.Transporte := rtatra.vuelo;
                end
                else
                begin
                  (*Solo entrar� en modo debug*)
                  Result.Transporte := 'EGATES';
                end;
              end;

              if (tipoPaso = 'M') or (tipoPaso = 'T') then
              begin
                  Result.Transporte := rtatra.vuelo;
              end;



              if UpperCase(rtatra.pasajero) = 'CRW' then
                Result.TipoPasajero := 'T' //Tripulante
              else
                Result.TipoPasajero := 'P'; //Pasajero



              if paisEmisorDoc = 'ARG' then
              begin
                //Verificacion de Autorizacion de Salidas de Menores  - Dudo que esto prosper
                if(UpperCase(sentido) = 'S') then
                begin
                  if (rtatra.vuelo <> '') and (yearsBetween( f,Now())<18) then
                  begin

                    //queda comentado por el tema de evitar errores

                    {
                    if flagMenores = '1' then
                    begin
                      if consultoMenor(nroDoc, nrolibreta, FormatDateTime('dd/mm/yyyy',f), respMenor ) then    //
                      begin
                         // si la respuesta es '', quiere decir que no encontre nada,
                         // si no devulelvo datos de la autorizacion para loguear
                         if respMenor = '' then
                         begin
                           result.Transporte := respMenor;
                         end;
                      end
                      else
                          result.Transporte := '';
                    end;}

                  end;
                end
                else
                if (UpperCase(sentido) = 'E') then
                begin
                  if nacionalidad <> 'ARG' then     // Extrangeros con Doc Argentino
                  begin
                    //Verificacion de Situacion Migratoria para Residentes En la Argentina
                    if flagSitMig = '1'  then
                    begin
                      if ( (StrToInt(nroDoc) >= 90000000) and (StrToInt(nroDoc) <= 99000000)) and
                         (tipoDoc = 'ID') and
                         (paisEmisorDoc = 'ARG') then
                      begin
                         if verSitMig(nroDoc,respSitMig) then
                         begin
                           if (respSitMig <> 'PERMANENTE') and (respSitMig <> 'TEMPORARIA') and (respSitMig <> 'TRANSITORIA')  then
                           begin
                             result.Transporte := '';
                           end;
                         end
                         else
                           result.Transporte := '';
                      end
                    end
                  end;
                end;
              end
              else
              begin
                if ( pos(UpperCase(paisEmisorDoc), UpperCase(otrosPaisesDoc)) <> 0 ) or ( pos(UpperCase(nacionalidad), UpperCase(otrasNacionalidades)) <> 0 ) then
                begin
                  if (UpperCase(sentido) = 'S') and (yearsBetween( f,Now())<18) then           // por si alguna vez para las salidas contemplo a mayores de 13 y no mayores de 18 (*)
                  begin
                      result.Transporte := ''
                  end;

                end
                else
                begin
                  if (UpperCase(sentido) = 'E')   then
                  begin
                    result.Transporte := ''
                  end
                  else
                  begin
                    if (UpperCase(sentido) = 'S')  then
                    begin
                      result.Transporte := ''
                    end;
                  end;
                end
                end;
            end
            else
              result.Transporte := '';
        end;

      finally

        DateTimeToString(filename,'yyyymmddHHmmss', Now);
        ForceDirectories(ExtractFilePath(ParamStr(0)) + 'logs\'+IntToStr(YearOf(Now))+'\'+FormatFloat('00',MonthOf(Now))+'\'+FormatFloat('00',DayOf(now)));
        filename:= ExtractFilePath(ParamStr(0)) + 'logs\'+IntToStr(YearOf(Now))+'\'+FormatFloat('00',MonthOf(Now))+'\'+FormatFloat('00',DayOf(now))+'\'+ filename+'_'+ nroDoc+ '.log';
        log(filename,'DOC: '+ nroDoc+'|RTA: '+Result.Restriccion+'|TRANSPORTE: '+Result.Transporte+'|TIPO_PASAJERO: '+Result.TipoPasajero+'|OTROS DATOS:|'+ Ape1+'|'+ Ape2+'|'+Nom1+'|'+Nom2+'|Fecha Nac: '+formatdatetime('dd/mm/yyyy',f)+'|Nro _libreta: '+nrolibreta+ '|AutMenor: '+respMenor+ '|SitMig: '+respSitMig+'| Fecha Consulta: ' + DateTimeToStr(Now)+' | Origen Imp: '+OrigenRestri+' | VtoDNI: '+fechaVTO+' | HayTransporte (Solo Aereo): '+r+rAntDNM);
        free;
      end;
    end;
  end;

var
  n1,n2,a1,a2:string;
  fechaAUX: string;
  ws :IinfoTransporte;
    rtatra : trtaTransporte;
    r,rAntDNM: ansistring;

begin

  FixNames(Apellidos, a1, a2);
  FixNames(Nombres, n1, n2);

  Result := TRespuesta.Create;
  Result.Restriccion := '';
  Result.Transporte := '';
  fechaAUX := copy(fechaVTO,7,2)+'/'+copy(fechaVTO,5,2)+'/'+copy(fechaVTO,1,4);
  Result := AuxBuscarRestricciones2(a1,a2,n1,n2,fechaNac, nroDoc,nrolibreta, genero, tipoDoc, paisEmisorDoc, nacionalidad, fechaAUX);

end;

function TwsRestriccion.ConsultaImpedimentosArgentina(
  consulta: DatosEntrada): DatosSalida;
var filename, path: String;
    inifile: TIniFile;
    OrigenRestri: string;

  function AuxBuscarRestricciones3(Ape1, Ape2, Nom1, Nom2, fechaNac, nroDoc,nrolibreta:string; var origen : string): Boolean;
  var
    e:boolean;
    f:TDateTime;
  begin
    e := false;
    try
      f := StrToDate(fechaNac); // EncodeDate(StrToInt(copy(fechaNac,1,4)),StrToInt(copy(fechaNac,5,2)),StrToInt(copy(fechaNac,7,2)));
    except
      e := True;
    end;

    if e then
      f := StrToDate(StringReplace(fechanac,'/','-',[rfReplaceAll])); // EncodeDate(StrToInt(copy(fechaNac,1,4)),StrToInt(copy(fechaNac,5,2)),StrToInt(copy(fechaNac,7,2)));

    with TDMRestriccion.Create(nil) do
    try
      Result := False;
      if TotalRestricciones('CIA',Ape1, Ape2, Nom1, Nom2,f,nroDoc,nrolibreta,'','','','','', origen)>0 then      // CIA = ConsultaImpedimentosArgentina
        Result:= True;

    finally
      free;
    end;

  end;

var
  s:String;

begin
  try
  DateTimeToString(filename,'yyyymmddHHmmss', Now);
  ForceDirectories(ExtractFilePath(ParamStr(0)) + 'logs\'+IntToStr(YearOf(Now))+'\'+FormatFloat('00',MonthOf(Now))+'\'+FormatFloat('00',DayOf(now)));
  filename:= ExtractFilePath(ParamStr(0)) + 'logs\'+IntToStr(YearOf(Now))+'\'+FormatFloat('00',MonthOf(Now))+'\'+FormatFloat('00',DayOf(now))+'\'+ filename+'_'+ consulta.NUMDOC+ '.log';

  Result:= DatosSalida.Create;
  OrigenRestri := '';
  if AuxBuscarRestricciones3(consulta.APELLIDO1, consulta.APELLIDO2,consulta.NOMBRE1,consulta.NOMBRE2,consulta.FECHANAC, consulta.NUMDOC,consulta.NUMEROIDENIFICACION, OrigenRestri )then
    begin
      Result.COD_RTA := '2';
      Result.COD_DETALLE_RTA := '0'; // 2 - 0 ---> Hay coincidencia
      Result.OBSERVACIONES := 'HAY COINCIDENCIA';
      inifile := TIniFile.Create(Format('%sconfig.ini', [ExtractFilePath(ParamStr(0))]));
      try
        path := inifile.ReadString('semaforo', 'path', '')+IntToStr(YearOf(Now))+FormatFloat('00',MonthOf(Now))+FormatFloat('00',DayOf(now))+FormatFloat('00',HourOf(Now))+FormatFloat('00',MinuteOf(Now))+'_'+ consulta.NUMDOC+ '.log';
      finally
        inifile.Free;
      end;


      s := '';
      s := s + '<EMISORDOC>'+consulta.EMISORDOC+'</EMISORDOC>';
      s := s + '<NOMBRE1>'+consulta.NOMBRE1+'</NOMBRE1>';
      s := s + '<NOMBRE2>'+consulta.NOMBRE2+'</NOMBRE2>';
      s := s + '<APELLIDO1>'+consulta.APELLIDO1+'</APELLIDO1>';
      s := s + '<APELLIDO2>'+consulta.APELLIDO2+'</APELLIDO2>';
      s := s + '<NUMDOC>'+consulta.NUMDOC+'</NUMDOC>';
      s := s + '<TIPODOC>'+consulta.TIPODOC+'</TIPODOC>';
      s := s + '<EMISORDOC>'+consulta.EMISORDOC+'</EMISORDOC>';
      s := s + '<FECHANAC>'+consulta.FECHANAC+'</FECHANAC>';
      s := s + '<GENERO>'+consulta.GENERO+'</GENERO>';
      s := s + '<NACIONALIDAD>'+consulta.NACIONALIDAD+'</NACIONALIDAD>';
      s := s + '<NROLIBRETA>'+consulta.NUMEROIDENIFICACION+'</NROLIBRETA>';
      s := s + '<ORIGEN>'+OrigenRestri+'</ORIGEN>';
      s := s + '<FECHA_HORA>'+FormatDateTime('YYYY/MM/DD hh:mm:ss',now)+'</FECHA_HORA>';
      log (path,s );
     // log (path,DateTimeToStr(Now)+ ' # Apellidos: '+ Trim(consulta.APELLIDO1+' '+ consulta.APELLIDO2)+' # Nombres: '+Trim(consulta.NOMBRE1+' '+consulta.NOMBRE2)+' # Fecha de Nacimiento: '+consulta.FECHANAC+' # Nro. Doc.: '+ consulta.NUMDOC+' # Nro. Libreta: '+consulta.NUMEROIDENIFICACION+' # HAY COINCIDENCIAS');
    end
   else
    begin
      Result.COD_RTA := '1';
      Result.COD_DETALLE_RTA := '0';// 1 - 0 ---> "NO EXISTEN" coincidencia
      Result.OBSERVACIONES := 'NO HAY COINCIDENCIA';
    end;
   log (filename,DateTimeToStr(Now)+' - Datos:'+ consulta.APELLIDO1+'-'+ consulta.APELLIDO2+'-'+consulta.NOMBRE1+'-'+consulta.NOMBRE2+'-'+consulta.FECHANAC+'-'+ consulta.NUMDOC+'-'+consulta.NUMEROIDENIFICACION+' - CodRta: '+Result.COD_RTA+' - CodDetalleRta: '+Result.COD_DETALLe_RTA);
   except on e:exception do
     begin
       Result:= DatosSalida.Create;
       Result.COD_RTA := '0';
       Result.COD_DETALLE_RTA := '1';  // Error en la busqueda
       Result.OBSERVACIONES := 'ERROR';       
       log(fileName,DateTimeToStr(Now)+' - Datos:'+ consulta.APELLIDO1+'-'+ consulta.APELLIDO2+'-'+consulta.NOMBRE1+'-'+consulta.NOMBRE2+'-'+consulta.FECHANAC+'-'+ consulta.NUMDOC+'-'+consulta.NUMEROIDENIFICACION+' - CodRta: '+Result.COD_RTA+' - CodDetalleRta: '+Result.COD_DETALLe_RTA+' - Error: '+e.Message);
     end;

    end;

end;

initialization
  { Invokable classes must be registered }
  InvRegistry.RegisterInvokableClass(TwsRestriccion);

end.
