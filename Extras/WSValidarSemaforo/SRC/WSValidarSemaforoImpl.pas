{ Invokable implementation File for TWSValidarSemaforo which implements IWSValidarSemaforo }

unit WSValidarSemaforoImpl;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, WSValidarSemaforoIntf, System.IniFiles,
     vcl.Forms, System.Classes;

type

  { TWSValidarSemaforo }
  TWSValidarSemaforo = class(TInvokableClass, IWSValidarSemaforo)
  public
    //Procedure  EnviarRespuesta(Datos:TDatosEntrada);stdcall;
    function  EnviarRespuesta(Datos:TDatosEntrada):string;stdcall;
    Function   RecibirRespuesta(Datos: TDatosEntrada):string;stdcall;
  end;

implementation

uses System.SysUtils, System.DateUtils, Ipuentechileno1;



{ TWSValidarSemaforo }

function  TWSValidarSemaforo.EnviarRespuesta(Datos:TDatosEntrada):string;
//procedure TWSValidarSemaforo.EnviarRespuesta(Datos: TDatosEntrada);
var
  s,pathYArh, pathws:String;
  inifile:TIniFile;
  ws : Ipuentechileno;
  parametro: consultaProcederCHL;
  rta : respuestaProcederCHL;

procedure log(mess: string);
var
  exepath: string;
  ts: TStringList;
  filename: string;
begin
  exepath := pathYArh;
  ts := TStringList.Create;

  DateTimeToString(filename,'yyyymmddHHmmss', Now);
//  ForceDirectories( exepath+'\'+IntToStr(YearOf(Now))+'\'+FormatFloat('00',MonthOf(Now))+'\'+FormatFloat('00',DayOf(now)));
//  filename:=  exepath+'\'+IntToStr(YearOf(Now))+'\'+FormatFloat('00',MonthOf(Now))+'\'+FormatFloat('00',DayOf(now))+'\'+ filename+ '.log';

  ForceDirectories( exepath+IntToStr(YearOf(Now))+'\'+FormatFloat('00',MonthOf(Now))+'\'+FormatFloat('00',DayOf(now)));
  filename:=  exepath+IntToStr(YearOf(Now))+'\'+FormatFloat('00',MonthOf(Now))+'\'+FormatFloat('00',DayOf(now))+ '\'+filename+ '.log';

  //Si ya existe cargo los datos existentes.
  if FileExists( filename) then
    ts.LoadFromFile(filename);

  ts.Add(mess);
  ts.SaveToFile(filename);
 end;

 
begin
   RESULT := 'NOTOK';
   //inifile := TIniFile.Create(Format('%sconfig.ini', [ExtractFilePath(ParamStr(0))]));
   inifile := TIniFile.Create('.\config.ini');
   try
     pathYArh := inifile.ReadString('server', 'path', '');//+IntToStr(YearOf(Now))+'\'+FormatFloat('00',MonthOf(Now))+'\'+FormatFloat('00',DayOf(now))+'\'+ Datos.NumeroDocumento+ '.log';
     pathws:= inifile.ReadString('server', 'URLPUENTE', '')

   finally
     inifile.Free;
   end;


     try
       try

        WS := GetIpuentechileno(False, pathws);
        parametro := consultaProcederCHL.Create;

        rta := respuestaProcederCHL.Create;
        rta.Status := -2;
        rta.Descripcion := 'No llego a puente chileno';
        parametro.PaisDocumento :=  Datos.CodigoPaisEmisor;
        parametro.NumeroDocumento :=Datos.NumeroDocumento;
        parametro.Observacion :=Datos.Observacion;
        parametro.Funcionario :=Datos.Funcionario;
        parametro.TipoDocumento := 'ID';
        parametro.Status := Datos.Flag;
        rta := ws.procederCHL(parametro);

       finally
         log('PaisDocumento: '+ Datos.CodigoPaisEmisor+' |NumeroDocumento: '+Datos.NumeroDocumento+
        ' |Observacion: '+Datos.Observacion+' |Status: '+Datos.Flag+' ||Resultado ID: '+IntToStr(rta.Status) + ' |Resultado descripcion: '+rta.Descripcion);
         IF (rta.Status = 0) AND (rta.Descripcion ='') then
            RESULT := 'OK';
         parametro.Free;
         rta.Free;
       end;


   except on e: exception do
      log( 'Error:' +e.Message
      );

   end;
end;

Function TWSValidarSemaforo.RecibirRespuesta(Datos: TDatosEntrada):string;
var ini:TIniFile;
    path_server:string; //Donde guardar
    fecha,tiempo:string; //Fecha para el archivo 'yyyyddmmhh24mi'
    Texto,s:String; // Texto a guardar en log
    Aceptado,r:string; // Aceptado o denegado según flag
    F:integer;
    
procedure GuardarLog(path,texto: string);
var F:textfile;
begin
   AssignFile(F,path);

   if FileExists(path) then
     Append(F)
   else
     Rewrite(F);

   Writeln(F,texto);
   CloseFile(F);
end;
begin
   //Se inicializa en OK
   Result := 'OK';

   //Se obtiene el server donde guardar
   ini := TIniFile.create(ExtractFilePath(Application.ExeName) + '.\config.ini');
   path_server := ini.ReadString('SEMAFORO','PATH','N');
   ini.Free;

   if (path_server = 'N') then
   begin
     Result := 'No se encontro el path donde guardar los archivos. Verifíque el ini';
     Exit;
   end;

   //Fecha de hoy y hora con min
   fecha := FormatDateTime('YYYYMMDD',Now);
   tiempo := FormatDateTime('hhmm',Time);

   //Se setea el nombre de archivo
   path_server := path_server + '.\' + fecha + tiempo + '_' +
                  datos.NumeroDocumento + '.log';

   // Aceptado o denegado según flag
   try
     F := StrToInt(datos.Flag);

     case f of
       1 : Aceptado := 'acepta';
       2 : Aceptado := 'deniega';
     else
       Result := 'Error en el campo Flag';
     end;
   except
     Result := 'Error en el campo Flag';
   end;

   //Si Fallo en el Flag se va
   if (Result <> 'OK') then
     exit;

     (* Se (acepta o deniega) el tránsito a razón de: (observación)
      dada por el funcionario: (funcionario) *)
    Texto := 'Se ' + UpperCase(Aceptado) + ' el tránsito a razón de: ' +
            Trim(datos.Observacion) + ' otorgada por el funcionario: ' +
            UpperCase(datos.Funcionario);
    s := '<FECHA_HORA>'+FormatDateTime('YYYY/MM/DD hh:mm:ss',now)+'</FECHA_HORA>';
    s := s + '<CodigoPaisEmisor>'+Datos.CodigoPaisEmisor+'</CodigoPaisEmisor>';
    s := s + '<NumeroDocumento>'+Datos.NumeroDocumento+'</NumeroDocumento>';
    s := s + '<Flag>'+Datos.Flag+'</Flag>';
    s := s + '<Observacion>'+Texto+'</Observacion>';
    s := s + '<Funcionario>'+Datos.Funcionario+'</Funcionario>';






   //Se guarda
   GuardarLog(path_server,s);

   //Si no se guarda => Mensaje Error
   if not FileExists(path_server) then
    Result := 'No se pudo guardar el log';
end;

initialization
  { Invokable classes must be registered }
  InvRegistry.RegisterInvokableClass(TWSValidarSemaforo);

end.
