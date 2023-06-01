{ Invokable implementation File for TWSTransitos which implements IWSTransitos }

unit WStransitosImpl;

interface

uses
  Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, WStransitosIntf, Udatos, System.Classes, System.IniFiles,
  NetConn, System.SysUtils, vcl.forms, uBase64, System.DateUtils, XML.xmldom, XML.XMLIntf, XML.Win.msxmldom,
  XML.XMLDoc, vcl.Controls, vcl.StdCtrls, WebServiceMMPaysandu, IwsPuente1, System.StrUtils,
  IwsPuentePRY1, IwsPuenteBolivia1, Ipuentechileno2,WinApi.ShellAPI,uMD5;

type

  { TWSTransitos }
  TWSTransitos = class(TInvokableClass, IWSTransitos)
    FresourceUserLoad: string;
    FresourcePassLoad: string;
    FresourcePathLoad: string;
    FresourceUserSave: string;
    FresourcePassSave: string;
    FresourcePathSave: string;
    Fredirijo: Integer;
    Fexe: string;
    FresourceUserSaveBis: string;
    FresourcePassSaveBis: string;
    FresourcePathSaveBis: string;
    FUruguayUserSave: string;
    FUruguayPassSave: string;
    FUruguayPathSave: string;
    FresourceManifiestoActivoSave: Boolean;
    FresourceManifiestoUserSave: string;
    FresourceManifiestoPassSave: string;
    FresourceManifiestoPathSave: string;
    FresourceExceptUser: string;
    FresourceExceptPass: string;
    FresourceExceptPath: string;
    FresourcePasos, FresourcePasosIps: string;
    GPath_respCHL, GPath_procesados, GPath_MandadosCHL: string;
    function cheqDia(dia: string): Tdatetime;
    function cheqDiaOrganismo(dia: string): TDate;
    procedure leerIni;
    procedure conectarRecurso(usuario, contra, path: string);
    function getFechaMenosDos: string;
    procedure getDiaMesAno(diaDate: TDateTime; var pathAno, pathMes, pathDia: string);
    function getFileToStr(pathFile: string): string;
    function ContarRegistros(path, organismo: string): boolean;
    function getUryCleanEncoded(linea: WideString; var paso: string): WideString;
  private
    function transitosPorDia(dia, tipo: string): string;
    function getFileToStrSolicitud(pathFile, organismo: string): string;
    function getFileToStrManifiesto(pathFile: string): string;
    function checkXML(archivo: WideString): string;
    function GuardarLog(Archivo, Mensaje: string): Boolean;
    function guardarArchivoSeguro(path, nombre, extension: string; archivo: TStrings): Boolean;
    procedure Listar(sDirectorio: string; var Resultado: TStringList);
    function GeneraBat(Archivo, Mensaje: string): Boolean;
  public
    function ArgentinosPaso(dia: string): string; stdcall;
    function ExtrangerosPaso(dia: string): string; stdcall;
    function TodosPaso(dia: string): string; stdcall;
    function Argentinos(dia: string): string; stdcall;
    function guardarRestricciones(transitos: ttransitoFile): boolean; stdcall;
    function guardarRestriccionesxml(transitos: ttransitoFile): boolean; stdcall;
    function enviarSolicitud(transitos: ttransitoFile; NRO_ENVIO: string): boolean; stdcall;
    function obtenerRespuestaSolicitud(consulta: tconsulta; NRO_ENVIO: string): TtransitoFile; stdcall;
    function validarUsuarioOrganismo(usuario: tusuario): boolean; stdcall;
    function Enviar_Transitos_SICaM(transitos: ttransitoFile): boolean; stdcall;
    function Enviar_Transitos_SICaM_alt(transitos: ttransitoFile): boolean; stdcall;
    function enviarManifiestoUry(archivo: tarchivo): string; stdcall;
    function generoArch(aXMLMigra: string): string;
    function enviarManifiestoCHL(archivo: tarchivo): string; stdcall;
    function enviarManifiestoPryBol(archivo: tarchivo): string; stdcall;
  end;

implementation

//uses FsocketChile;

function TWSTransitos.GuardarLog(Archivo, Mensaje: string): Boolean;
var
  fArchivo: TextFile;
begin
  Result := False;
  try
    AssignFile(fArchivo, Archivo);
    if not FileExists(Archivo) then
      Rewrite(fArchivo)
    else
    try
      Reset(fArchivo)
    except
      Exit;
    end;
    Append(fArchivo);
    WriteLn(fArchivo, Mensaje);
    CloseFile(fArchivo);
    result := True;
  except
  end;
end;

function TWSTransitos.GeneraBat(Archivo, Mensaje: string): Boolean;
var
  fArchivo: TextFile;
begin
  Result := False;
  try
    AssignFile(fArchivo, Archivo);
    if not FileExists(Archivo) then
      Rewrite(fArchivo)
    else
    try
      Reset(fArchivo)
    except
      Exit;
    end;
    Append(fArchivo);
    WriteLn(fArchivo, Mensaje);
    WriteLn(fArchivo, '(goto) 2>nul & del "%~f0"');
    WriteLn(fArchivo, 'exit');
    CloseFile(fArchivo);
    result := True;
  except
  end;
end;

procedure TWSTransitos.Listar(sDirectorio: string; var Resultado: TStringList);
var
  Busqueda: TSearchRec;
  iResultado: Integer;
begin
  // Nos aseguramos que termine en contrabarra
  sDirectorio := IncludeTrailingBackslash(sDirectorio);

  iResultado := FindFirst(sDirectorio + '*.*', faAnyFile, Busqueda);

  while iResultado = 0 do
  begin
    // ¿Ha encontrado un archivo y no es un directorio?
    if (Busqueda.Attr and faArchive = faArchive) and (Busqueda.Attr and faDirectory <> faDirectory) then
      Resultado.Add(Busqueda.Name);

    iResultado := FindNext(Busqueda);
  end;

  FindClose(Busqueda);
end;

function TWSTransitos.getFechaMenosDos: string;
var
  dia, mes, anio: word;
  Sdia, Smes, Sanio: string;
begin
  DecodeDate(IncDay(now, -2), anio, mes, dia);
  Smes := inttostr(mes);
  Sdia := inttostr(dia);
  if mes < 10 then
    Smes := '0' + Smes;
  if dia < 10 then
    Sdia := '0' + Sdia;
  result := Sdia + '-' + Smes + '-' + inttostr(anio);
end;

function TWSTransitos.cheqDia(dia: string): TDateTime;
{
  Asumo por ahora que dia viene en DDMMYYYY
}
var
  sdia, smes, sanio: string;
  fecha: TDateTime;
begin
  result := -1;
  try
    sdia := copy(dia, 1, 2);
    smes := copy(dia, 3, 2);
    sanio := copy(dia, 5, 4);
    fecha := EncodeDate(strtoint(sanio), strtoint(smes), strtoint(sdia));

    if (DaysBetween(now, fecha) >= 2) and (fecha <= now) then
      result := fecha;
  except
  end;
end;

function TWSTransitos.cheqDiaOrganismo(dia: string): TDate;
{
  Asumo por ahora que dia viene en DDMMYYYY
}
var
  sdia, smes, sanio: string;
  fecha: TDateTime;
begin
  result := -1;
  try
    sdia := copy(dia, 1, 2);
    smes := copy(dia, 3, 2);
    sanio := copy(dia, 5, 4);
    fecha := EncodeDate(strtoint(sanio), strtoint(smes), strtoint(sdia));

//    if (FormatDateTime('dd/mm/yyyy', fecha) = FormatDateTime('dd/mm/yyyy', now - 1)) then
    if fecha < date then
      result := fecha;
  except

  end;
end;

procedure TWStransitos.conectarRecurso(usuario, contra, path: string);
var
  netConn: TNetConnection;
begin
  try
    netConn := TNetConnection.Create(nil);
    netConn.UserName := usuario;
    netConn.ResourceType := rtDisk;
    netConn.Password := contra;
    netConn.RemoteName := path;
    netConn.Connect;
   GuardarLog('.\EnviarSolicitud.log', 'Se connecta al recurso');
  except
   GuardarLog('.\EnviarSolicitud.log', 'NO connecta al recurso');
  end;
end;

function TWStransitos.getFileToStrSolicitud(pathFile, organismo: string): string;
var
  fi: TFileStream;
  resultado: string;
begin
 // pathFile := 'C:\inetpub\wwwroot\WebServices\wsarchivosorganismos\';
  //pathFile := '';
  if FileExists(pathFile + 'respuesta_' + organismo + '.zip') then
  begin
    fi := TFileStream.Create(pathFile + 'respuesta_' + organismo + '.zip', fmOpenRead);
    fi.Position := 0;
    SetLength(resultado, fi.Size);
    fi.Read(pointer(resultado)^, fi.Size);
    fi.Free;
    result := resultado;
  end;
end;

function TWStransitos.getFileToStrManifiesto(pathFile: string): string;
var
  f: TStrings;
  fileStr: string;
begin
 // pathFile := 'C:\inetpub\wwwroot\WebServices\wsarchivosorganismos\';
  //pathFile := '';

  if FileExists(pathFile) then
  begin
    f := TStringList.Create;
    f.LoadFromFile(pathFile);
    result := f.Text;
  end;

end;

function FileSize(path: WideString): Int64;
var
  sr: TSearchRec;
begin
  if FindFirst(path, faAnyFile, sr) = 0 then
    result := Int64(sr.FindData.nFileSizeHigh) shl Int64(32) + Int64(sr.FindData.nFileSizeLow)
  else
    result := -1;
  FindClose(sr);
end;

function TWStransitos.ContarRegistros(path, organismo: string): boolean;
var
  i, Cantidad: integer;
  NodoPrinc: IXMLNode;
  XMLDoc1: IXMLDocument;
begin

  try
    Cantidad := 10000;
    if UpperCase(organismo) = 'ANSES' then
      //Cantidad := 30000;
      Cantidad := 100000;

    if (UpperCase(organismo) = 'ANSES') and (FileSize(path) <= 23068672) then
      Result := False
    else
    begin

      XMLDoc1 := TXMLDocument.Create(nil);
      XMLDoc1.FileName := path;
      XMLDoc1.Active := true;
      result := (XMLDoc1.DocumentElement.ChildNodes.Count > Cantidad);
      XMLDoc1.Active := false;
    end;
  finally
    XMLDoc1 := nil;

  end;
end;

function TWStransitos.obtenerRespuestaSolicitud(consulta: tconsulta; NRO_ENVIO: string): TtransitoFile;
var
  strFile: WideString;
  diaDate: TDate;
  filePath, pathAno, pathMes, pathDia: string;
begin
  try

    Result := ttransitoFile.Create;
    //Hacemos el chequeo de la fecha para asegurarnos que la fecha es valida
    //despues adelantamos dos dia la fecha ya que los transitos de la fecha x
    //estan en la fecha x+2 ejemplo los transitos del dia 4 estan en la carpeta
    //del dia 2
    diaDate := cheqDiaOrganismo(consulta.dia);
    if diaDate <> -1 then
    begin
      //obtengo los datos del recurso
      leerIni;
      //Me autentico en el recurso
      conectarRecurso(FresourceUserLoad, FresourcePassLoad, FresourcePathLoad);
      //Retorno un string en organismo solo porque esa clase esta reutilizada
      Result.organismo := consulta.organismo;
      Result.fecha := consulta.dia;
      //obtengo el string del archivo.
      //----Decode de la fecha
      getDiaMesAno(diaDate, pathAno, pathMes, pathDia);
      //----Obtengo el archivo que se corresponde con la fecha.
      //linia originaal


      strFile := getFileToStrSolicitud(FresourcePathLoad + '\' + pathAno + '\' + pathMes + '\' + pathDia + '\' + result.organismo + '\' + NRO_ENVIO + '\', result.organismo);
      //strFile := getFileToStrSolicitud('');
      strFile := Encode64(strFile);
      result.archivo := strFile;
      //Le aplico base 64
    end
    else
    begin
      result.archivo := 'Fecha invalida';
    end;
  except
    on e: Exception do
      result.archivo := e.Message;
    //result.archivo := FresourcePathLoad + '\' + pathAno + '\' + pathMes + '\' + pathDia + '\';
  end;
end;

function TWStransitos.enviarSolicitud(transitos: ttransitoFile; NRO_ENVIO: string): boolean;
{
  Guarda las restricciones recividas de otro organismo
}
var
  ts, archivo: TStrings;
  strAno, strMes, strDia: string;
  Stream: TStream;
  direccion: string;

  function esVAlidoelEnvio(nro_envio: string): Boolean;
  begin
    Result := ((StrToInt(nro_envio) >= 0) and (StrToInt(nro_envio) <= 39));
  end;

begin
  try
    dmdatos := Tdmdatos.Create(nil);
    try
      //obtengo los datos del recurso
      GuardarLog('.\EnviarSolicitud.log', '----------------------------------');
      leerIni;
      GuardarLog('.\EnviarSolicitud.log', 'lee ini');
      //Me autentico en el recurso
      conectarRecurso(FresourceUserSave, FresourcePassSave, FresourcePathSave);

      //guardo el archivo
      //el path tiene que ser recurso + ano + mes + dia
      strDia := copy(transitos.fecha, 1, 2);
      strMes := copy(transitos.fecha, 3, 2);
      strAno := copy(transitos.fecha, 5, 4);
      //-----------------------------------
      result := false;

      if NRO_ENVIO = '' then
        NRO_ENVIO := '0';

      direccion:= FresourcePathSave + '\' + transitos.organismo + '\' + strAno + '\' + strMes + '\' +strDia + '\' +NRO_ENVIO + '\';
      GuardarLog('.\EnviarSolicitud.log', 'Path : '+direccion);
      if esVAlidoelEnvio(NRO_ENVIO) then
      begin
        GuardarLog('.\EnviarSolicitud.log', 'Es valido el envio');
        if DirectoryExists(direccion) then
        begin
          GuardarLog('.\EnviarSolicitud.log', 'YA existe la carpeta de destino');
          if not FileExists(direccion +'solicitud_' + transitos.organismo+'.zip') then
          begin
            Stream := TFileStream.Create(direccion + 'solicitud_' + transitos.organismo + '.zip', fmCreate);
            Stream.WriteBuffer(Pointer(Decode64(transitos.archivo))^, Length(Decode64(transitos.archivo)));
            Stream.Free;
            GuardarLog('.\EnviarSolicitud.log', 'decode del archivo');

            //archivo.SaveToFile(FresourcePathSave + '\' + transitos.organismo + '\' + strAno + '\' + strMes + '\' +strDia + '\' +'solicitud_' + transitos.organismo+'.zip');
            //dmdatos.descomprimir(fexe, direccion +'solicitud_' + transitos.organismo+'.zip', FresourcePathSave + '\' + transitos.organismo + '\' + strAno + '\' + strMes + '\' +strDia + '\' +NRO_ENVIO);
            if generabat(direccion+'\extraer.bat', 'start unzip -n '+direccion+'solicitud_' + transitos.organismo+'.zip'+' '+' -d '+direccion) then
              GuardarLog('.\EnviarSolicitud.log', 'genero bat')
            else
              GuardarLog('.\EnviarSolicitud.log', 'Error al generar bat');


            if dmdatos.descomprimir(direccion+'\extraer.bat',direccion+'solicitud_' + transitos.organismo+'.zip', FresourcePathSave + '\' + transitos.organismo + '\' + strAno + '\' + strMes + '\' +strDia + '\' +NRO_ENVIO) then
              GuardarLog('.\EnviarSolicitud.log', 'Descomprimi')
            else
              GuardarLog('.\EnviarSolicitud.log', 'Error al Descomprimir');

            if ContarRegistros(direccion +'solicitud_' + transitos.organismo+'.xml',transitos.organismo) then
            begin
              DeleteFile(direccion + 'solicitud_' + transitos.organismo + '.xml');
              DeleteFile(direccion + 'solicitud_' + transitos.organismo + '.zip');
              result := false;
            end
            else
              result := true;
          end
          else
          begin
            result := false;
            GuardarLog('.\EnviarSolicitud.log', 'Ya existia el archivo');
          end;
        end
        else
        begin
          GuardarLog('.\EnviarSolicitud.log', 'No existe la carpeta de destino');
          if ForceDirectories(direccion) then
          begin
            GuardarLog('.\EnviarSolicitud.log', 'Creo el folder');
            Stream := TFileStream.Create(direccion +'solicitud_' + transitos.organismo+'.zip', fmCreate);
            Stream.WriteBuffer(Pointer(Decode64(transitos.archivo))^, Length(Decode64(transitos.archivo)));
            Stream.Free;
            GuardarLog('.\EnviarSolicitud.log', 'decode del archivo');
            //archivo.SaveToFile(direccion +'solicitud_' + transitos.organismo+'.zip');

            if generabat(direccion+'\extraer.bat', 'start unzip -n '+direccion+'solicitud_' + transitos.organismo+'.zip'+' '+' -d '+direccion) then
               GuardarLog('.\EnviarSolicitud.log', 'genero bat')
            else
              GuardarLog('.\EnviarSolicitud.log', 'Error al generar bat');

            if dmdatos.descomprimir(direccion+'\extraer.bat',direccion+'solicitud_' + transitos.organismo+'.zip', FresourcePathSave + '\' + transitos.organismo + '\' + strAno + '\' + strMes + '\' +strDia + '\' +NRO_ENVIO) then
              GuardarLog('.\EnviarSolicitud.log', 'Descomprimi')
            else
              GuardarLog('.\EnviarSolicitud.log', 'Error al Descomprimir');

            if ContarRegistros(direccion +'solicitud_' + transitos.organismo+'.xml',transitos.organismo) then
            begin
              DeleteFile(direccion +'solicitud_' + transitos.organismo+'.xml');
              DeleteFile(direccion +'solicitud_' + transitos.organismo+'.zip');
              result := false;
            end
            else
              result := true;
          end;
        end;
      end
      else
        GuardarLog('.\EnviarSolicitud.log', 'NO Es valido el envio');
    except
      on e: exception do
      begin
        ts := TStringList.Create;
        ts.Add(e.Message);
        result := false;
      end;
    end;
  finally
    FreeAndNil(dmdatos);
  end;
end;

function TWStransitos.getFileToStr(pathFile: string): string;
var
  f: TFileStream;
begin
 // pathFile := 'C:\inetpub\wwwroot\WebServices\wsarchivosorganismos\';
  //pathFile := '';
  if FileExists(pathFile) then
  begin
    f := TFileStream.Create(pathFile, fmOpenRead);
    SetLength(Result, f.size);
    f.Read(result[1], f.Size);
    f.Free;
  end;
end;

procedure TWStransitos.leerIni;
var
  inifile: TIniFile;
  ts: tstrings;
begin

  ts:= TStringList.Create;

  //inifile := TIniFile.Create(Format('%sconfig.ini', [ExtractFilePath(Application.ExeName)]));
  inifile := TIniFile.Create('.\config.ini');
  try
    FresourceUserLoad := inifile.ReadString('resourceLoad', 'user', '');
    FresourcePassLoad := inifile.ReadString('resourceLoad', 'pass', '');
    FresourcePathLoad := inifile.ReadString('resourceLoad', 'path', '');
    ts.Add('FresourceUserLoad '+FresourceUserLoad);
    ts.Add('FresourcePassLoad '+FresourcePassLoad);
    ts.Add('FresourcePathLoad '+FresourcePathLoad);

    FresourceUserSave   := inifile.ReadString('resourceSave', 'user', '');
    FresourcePassSave   := inifile.ReadString('resourceSave', 'pass', '');
    FresourcePathSave   := inifile.ReadString('resourceSave', 'path', '');
    ts.Add('FresourceUserSave '+FresourceUserSave);
    ts.Add('FresourcePassSave '+FresourcePassSave);
    ts.Add('FresourcePathLoad '+FresourcePathLoad);
    Fredirijo   :=          inifile.ReadInteger('resourceSave', 'redirijo', 0);
    ts.Add('Fredirijo '+inttostr(Fredirijo));
    Fexe                := inifile.ReadString('resourceSave', 'exeZIP', 'C:\Program Files\WinRAR\WinRAR.exe');
    ts.Add('exe '+Fexe);

    FresourceUserSaveBis := inifile.ReadString('resourceSaveBis', 'user', '');
    FresourcePassSaveBis := inifile.ReadString('resourceSaveBis', 'pass', '');
    FresourcePathSaveBis := inifile.ReadString('resourceSaveBis', 'path', '');

    FUruguayUserSave := inifile.ReadString('resourceUruguay', 'user', '');
    FUruguayPassSave := inifile.ReadString('resourceUruguay', 'pass', '');
    FUruguayPathSave := inifile.ReadString('resourceUruguay', 'path', '');

    FresourceManifiestoActivoSave := inifile.ReadBool('resourceManifiesto', 'activo', true);
    FresourceManifiestoUserSave := inifile.ReadString('resourceManifiesto', 'user', '');
    FresourceManifiestoPassSave := inifile.ReadString('resourceManifiesto', 'pass', '');
    FresourceManifiestoPathSave := inifile.ReadString('resourceManifiesto', 'path', 'c:\sicamMANI');

    FresourceExceptUser := inifile.ReadString('resourceExceptions', 'user', '');
    FresourceExceptPass := inifile.ReadString('resourceExceptions', 'pass', '');
    FresourceExceptPath := inifile.ReadString('resourceExceptions', 'path', 'c:\recursos\rechazados');

    FresourcePasos := inifile.ReadString('resourcePasos', 'paso', '');
    FresourcePasosIps := inifile.ReadString('resourcePasosIps', 'ip', '');

    {
    ts:= TStringList.Create;
    ts.Add(inifile.ReadString('resource', 'user', ''));
    ts.SaveToFile('log.txt');
    }

    GPath_respCHL := inifile.ReadString('CHL', 'respCHL', 'c:\respuestaCHL');
    GPath_procesados := inifile.ReadString('CHL', 'procesados', 'c:\procesados');
    GPath_MandadosCHL := inifile.ReadString('CHL', 'MandadosCHL', 'c:\MandadosCHL');

    inifile.Free;
    ts.SaveToFile('log.txt');
  except
    on e: exception do
    begin
      ts := TStringList.Create;
      ts.Add(e.Message);
      ts.SaveToFile('log.txt');
    end;
  end;
end;

function TWStransitos.transitosPorDia(dia, tipo: string): string;
{                               LOAD
  Retorna el archivo de transitos de la fecha dada.
  Se tiene que cumplir que la fecha sea de dos dias anteriores al dia actual.
}
var
  strFile: string;
  diaDate: TDateTime;
  filePath, pathAno, pathMes, pathDia: string;
begin
  try
    //Hacemos el chequeo de la fecha para asegurarnos que la fecha es valida
    //despues adelantamos dos dia la fecha ya que los transitos de la fecha x
    //estan en la fecha x+2 ejemplo los transitos del dia 4 estan en la carpeta
    //del dia 2
    diaDate := cheqDia(dia);
    if diaDate <> -1 then
    begin
      //obtengo los datos del recurso
      leerIni;
      //Me autentico en el recurso
      conectarRecurso(FresourceUserLoad, FresourcePassLoad, FresourcePathLoad);
      //Retorno un string en organismo solo porque esa clase esta reutilizada
      //obtengo el string del archivo.
      //----Decode de la fecha
      getDiaMesAno(diaDate, pathAno, pathMes, pathDia);
      //----Obtengo el archivo que se corresponde con la fecha.
      //linia originaal
      strFile := getFileToStr('\\' + FresourcePathLoad + '\' + pathAno + '\' + pathMes + '\' + pathDia + '\' + tipo + '.zip');
      //strFile := Encode64(strFile);
      //SetLength(result.archivo, length(strFile));
      Result := Encode64(strFile);
      //Le aplico base 64
    end
    else
    begin
      result := 'Fecha invalida';
    end;
  except
    on e: Exception do
      result := e.Message;
    //result.archivo := FresourcePathLoad + '\' + pathAno + '\' + pathMes + '\' + pathDia + '\';
  end;
end;

//--------- El otro metodo guardar transito

function TWStransitos.guardarRestricciones(transitos: ttransitoFile): boolean;
{
  Guarda las restricciones recividas de otro organismo
}
var
  ts, archivo: TStrings;
  strAno, strMes, strDia: string;
begin
  try
    //obtengo los datos del recurso
    leerIni;
    //Me autentico en el recurso
    conectarRecurso(FresourceUserSave, FresourcePassSave, FresourcePathSave);
    //Creo el archivo
    archivo := TStringList.Create;
    archivo.Text := Decode64(transitos.archivo);
    //guardo el archivo
    //el path tiene que ser recurso + ano + mes + dia
    strDia := copy(transitos.fecha, 1, 2);
    strMes := copy(transitos.fecha, 3, 2);
    strAno := copy(transitos.fecha, 5, 4);
    //-----------------------------------
    if ForceDirectories('\\' + FresourcePathSave + '\' + transitos.organismo + '\' + strAno + '\' + strMes + '\' + strDia) then
      archivo.SaveToFile('\\' + FresourcePathSave + '\' + transitos.organismo + '\' + strAno + '\' + strMes + '\' + strDia + '\' + 'restricciones.xml');
    //FIN PATH

  except
    on e: exception do
    begin
      ts := TStringList.Create;
      ts.Add(e.Message);
    end;

  end;
end;

procedure TWStransitos.getDiaMesAno(diaDate: TDateTime; var pathAno, pathMes, pathDia: string);
var
  dia, mes, ano: word;
begin
  DecodeDate(diaDate, ano, mes, dia);
  if mes < 10 then
    pathMes := '0' + inttostr(mes)
  else
    pathMes := inttostr(mes);

  if dia < 10 then
    pathDia := '0' + IntToStr(dia)
  else
    pathDia := IntToStr(dia);

  pathAno := IntToStr(ano);
end;

function TWSTransitos.ArgentinosPaso(dia: string): string;
begin
  result := transitosPorDia(dia, 'ARGENTINOSPASO');
end;

function TWSTransitos.ExtrangerosPaso(dia: string): string;
begin
  result := transitosPorDia(dia, 'EXTRANGEROSPASO');

end;

function TWSTransitos.TodosPaso(dia: string): string;
begin
  result := transitosPorDia(dia, 'TODOSPASO');
end;

function TWSTransitos.Argentinos(dia: string): string;
begin
  result := transitosPorDia(dia, 'ARGENTINOS');
end;

function TWSTransitos.guardarRestriccionesxml(transitos: ttransitoFile): boolean;
{
  Guarda el xml que viene como parametro en la carpeta indicada en transito.organismo
  Despues el xml se procesa en otro lado.
}
var
  ts, archivo: TStrings;
  strFechaPath: string;
  strDia, strMes, StrAno, fecha, hora: string;
begin
  result := true;
  try
    //obtengo los datos del recurso
    leerIni;
    //Me autentico en el recurso
    conectarRecurso(FUruguayUserSave, FUruguayPassSave, FUruguayPathSave);
    //Creo el archivo
    archivo := TStringList.Create;
    archivo.Text := transitos.archivo;
    dmdatos := Tdmdatos.Create(nil);
    fecha := dmdatos.getFechaHora; //DDMMYYYY HHMMSS
    fecha := copy(fecha, 5, 4) + copy(fecha, 3, 2) + copy(fecha, 1, 2) + copy(fecha, 10, 6);
    //guardo el archivo
    { codigo que no se usa
    //el path tiene que ser recurso + ano + mes + dia
    dmdatos := Tdmdatos.Create(nil);
    fecha := dmdatos.getFechaHora; //DDMMYYYY HHMMSS

    strDia := copy(fecha, 1, 2);  //DD
    strMes := copy(fecha, 3, 2);  //MM
    strAno := copy(fecha, 5, 4);  //YYYY
    hora   := copy(fecha, 10, 6); //HHMMSS
    }
    //-----------------------------------
    if ForceDirectories(FUruguayPathSave + '\' + transitos.organismo + '\' {+ strAno + '\' + strMes + '\' +strDia + '\'}) then
      archivo.SaveToFile(FUruguayPathSave + '\' + transitos.organismo + '\' + fecha + '.xml');
    //FIN PATH
    FreeAndNil(dmdatos);
  except
    on e: exception do
    begin
      result := false;
      FreeAndNil(dmdatos);
      ts := TStringList.Create;
      ts.Add(e.Message);
    end;

  end;
end;

function TWSTransitos.validarUsuarioOrganismo(usuario: tusuario): boolean;
begin
  try
    dmdatos := Tdmdatos.Create(nil);
    result := dmdatos.validarUsuarioOrganismo(usuario);
  finally
    FreeAndNil(dmdatos);
  end;

end;


procedure grabarEnArchivoLog(Error: string);
var
  myFile: TextFile;
  nombreArch: string;
begin
  try
    nombreArch := ChangeFileExt(ParamStr(0), '.log');
    AssignFile(myFile, nombreArch);
    if not FileExists(nombreArch) then
      ReWrite(myFile)
    else
      append(myFile);

    WriteLn(myFile, FormatDateTime('YYYY-MM-DD hh:mm:ss>', Now) + '-' + Error);

    CloseFile(myFile);
  except
  end;
end;




function TWStransitos.Enviar_Transitos_SICaM(transitos: ttransitoFile): boolean;
{
  Guarda las restricciones recibidas de otro organismo
}
var
  ts, archivo: TStrings;
  log: TStringList;
  strfechahora, logpath, nombrelog: string;
  f: TDateTime;
  e: Boolean;
  arch: tarchivo;
begin
  try
    result := false;
    //obtengo los datos del recurso
    leerIni;
//    fs.TimeSeparator:='';
 //   fs.DateSeparator:='';


    logpath := ExtractFilePath(Application.ExeName) + IntToStr(YearOf(Now)) + '\' + FormatFloat('00', MonthOf(Now)) + '\' + FormatFloat('00', DayOf(now));
    log := TStringList.Create;

    if not DirectoryExists(logpath) then
      ForceDirectories(logpath);

    //Me autentico en el recurso
  //  conectarRecurso(FresourceUserSave, FresourcePassSave, FresourcePathSave);


    //Creo el archivo
    archivo := TStringList.Create;
    archivo.Text := Decode64(transitos.archivo);
    //guardo el archivo
   // log.Clear;
    if fredirijo = 1 then
    begin
      log.Add('Base64');
      log.Add(transitos.archivo);
      log.Add('');
    end;
    log.Add('XML plano ');
    log.Add(archivo.Text);
    log.Add(' ');
    log.Add('checkXML');
    log.Add(checkXML(archivo.Text));

    e := false;
    try
      f := StrToDateTime(transitos.fecha);
    except
      e := true;
    end;

    if e then
    begin

      e := false;
      try
        f := StrToDateTime(StringReplace(transitos.fecha, '/', '-', [rfReplaceAll]));

      except
        e := true;
      end;

    end;


//grabarEnArchivoLog(transitos.fecha);

    if e then
    begin
      f:= EncodeDateTime(StrToInt(Copy(transitos.fecha,7,4)),
                         StrToInt(Copy(transitos.fecha,4,2)),
                         StrToInt(Copy(transitos.fecha,1,2)),
                         StrToInt(Copy(transitos.fecha,12,2)),
                         StrToInt(Copy(transitos.fecha,15,2)),
                         StrToInt(Copy(transitos.fecha,18,2)),0);


    end;

//grabarEnArchivoLog('1');

    strfechahora := formatDateTime('YYYYMMDDhhnnss', f);


    //-----------------------------------
    if not DirectoryExists(FresourcePathSave + '\' + transitos.organismo) then
      ForceDirectories(FresourcePathSave + '\' + transitos.organismo);

    if not DirectoryExists(FresourcePathSave + '\rechazados') then
      ForceDirectories(FresourcePathSave + '\rechazados');

    if not FileExists(FresourcePathSave + '\' + transitos.organismo + '\' + strfechahora + '.xml') then
      archivo.SaveToFile(FresourcePathSave + '\' + transitos.organismo + '\' + strfechahora + '.xml')
    else
      guardarArchivoSeguro(FresourcePathSave + '\' + transitos.organismo + '\', strfechahora, '.xml', archivo);

    //FIN PATH


    result := true;

    //Decide a donde envia el archivo.
    if Fredirijo = 1 then
    begin
      try
        arch := tarchivo.Create;
        arch.FileStr := transitos.archivo;
        arch.FileName := FormatDateTime('yyyymmddhhnnsszzz', Now) + '.xml';
        log.Add('');
        //log.Add('Rta del archivo redirijido : ' + enviarManifiestoPryBol(arch));
        log.Add('Rta del archivo redirijido : ' + enviarManifiestoCHL(arch));
        FreeAndNil(arch);
      except
        log.Add('');
        log.Add('Rta del archivo redirijido : ERROR');
      end;
    end;

    log.SaveToFile(logpath + '\' + formatdatetime('yyyymmddhhnnss', now) + '.txt');
    log.Clear;
  except
    on e: exception do
    begin
      grabarEnArchivoLog(e.Message);
      if not DirectoryExists(FresourceExceptPath) then
        ForceDirectories(FresourceExceptPath + '\');
      ts := TStringList.Create;
      ts.Add(e.Message);
      ts.Add(transitos.archivo + ' - ' + transitos.organismo + ' - ' + transitos.fecha);
      try
        ts.SaveToFile(FresourceExceptPath + '\' + transitos.organismo + '\' + strfechahora + '.xml');
        ts.SaveToFile(FresourceExceptPath + '\' + transitos.archivo);
      except

      end;
      result := false;
      archivo.SaveToFile(FresourcePathSave + '\rechazados\' + strfechahora + '.xml');

      log.Add('Error al guardar el manifiesto - ' + strfechahora);
      log.SaveToFile(logpath + '\' + formatdatetime('yyyymmddhhnnss', now) + '.txt');
      log.Clear;

    end;

  end;
end;

function TWSTransitos.enviarManifiestoUry(archivo: tarchivo): string; stdcall;
var
  path, strDecoded, strEncoded: string;
  strDia, strMes, StrAno, fecha, hora, min, seg: string;
  archivos, arch: TStrings;
  ws: WebServiceMM;
  respuesta, respUry, procesados, logpath: string;
  resultado, logdeenvio: TStringList;
  i: integer;
  a: tarchivo;
begin
  try
    result := '';
    respuesta := '';

    leerIni;
    archivos := TStringList.Create;
    resultado := TStringList.Create;
    logdeenvio := TStringList.Create;
    respUry := GPath_respCHL;
    procesados := GPath_procesados;

    logpath := ExtractFilePath(Application.ExeName) + IntToStr(YearOf(Now)) + '\' + FormatFloat('00', MonthOf(Now)) + '\' + FormatFloat('00', DayOf(now));

    if not DirectoryExists(FresourceManifiestoPathSave) then
      ForceDirectories(FresourceManifiestoPathSave);

    if not DirectoryExists(respUry) then
      ForceDirectories(respUry);

    if not DirectoryExists(procesados) then
      ForceDirectories(procesados);

    if not DirectoryExists(logpath) then
      ForceDirectories(logpath);

//    conectarRecurso(FresourceManifiestoUserSave, FresourceManifiestoPassSave, FresourceManifiestoPathSave);

    Listar(FresourceManifiestoPathSave, resultado);

    archivo.FileStr := getUryCleanEncoded(archivo.FileStr, FresourcePasos);
    try
      //logdeenvio.Add(FresourcePasos);
      logdeenvio.Add(archivo.FileStr);
      if not FileExists(logpath + '\' + formatdatetime('yyyymmddhhnnss', now) + '.txt') then
        logdeenvio.SaveToFile(logpath + '\' + formatdatetime('yyyymmddhhnnss', now) + '.txt')
      else
        logdeenvio.SaveToFile(logpath + '\' + formatdatetime('yyyymmddhhnnss', now) + '_2.txt')
    finally
      if Assigned(logdeenvio) then
        logdeenvio.Free;
    end;

    if FresourcePasos = 'MON' then
      ws := GetWebServiceMM(true, '10.2.3.15:8080');

    if FresourcePasos = 'COL' then
      ws := GetWebServiceMM(true, '10.2.224.15:8080')
    else
      ws := GetWebServiceMM(false, FresourcePasosIps);

    {if FresourcePasos = 'Paysandu' then
      ws := GetWebServiceMM(false, '3.5.7.5');
    if FresourcePasos = 'FBentos' then
      ws := GetWebServiceMM(false, '3.5.7.9');
    if FresourcePasos = 'Salto' then
      ws := GetWebServiceMM(false, '3.5.7.1');     }


    if resultado.Count > 0 then
    begin
      GuardarLog(respUry + '\log.log', '----------------------------------');
      GuardarLog(respUry + '\log.log', 'Se recorre lista. - ' + DateTimeToStr(Now));
      for i := 0 to resultado.Count - 1 do
      begin
        try
          arch := TStringList.Create;
          arch.LoadFromFile(FresourceManifiestoPathSave + '\' + resultado[i]);
          a := tarchivo.Create;
          a.FileStr := arch.Text;

          respuesta := ws.Ingreso_MM_RAMM(a.FileStr);

          archivos.Text := respuesta;
          archivos.SaveToFile(respUry + '\respuesta.txt');
          GuardarLog(respUry + '\log.log', respuesta);

          if UpperCase(respuesta) = 'OK' then
          begin
            if FileExists(FresourceManifiestoPathSave + '\' + resultado[i]) then
            begin
              if RenameFile((FresourceManifiestoPathSave + '\' + resultado[i]), pchar(procesados + '\' + resultado[i])) then
              begin
                if FileExists(FresourceManifiestoPathSave + '\' + resultado[i]) then
                  if DeleteFile(FresourceManifiestoPathSave + '\' + resultado[i]) then
                    GuardarLog(respUry + '\log.log', 'Se borró el archivo: ' + resultado[i] + ' - ' + DateTimeToStr(Now));
                GuardarLog(respUry + '\log.log', 'Se movió el archivo: ' + resultado[i] + ', a ' + procesados + ' - ' + DateTimeToStr(Now));
              end;
            end;
          end;

          a.Free;
          arch.Free;
        except
          on e: Exception do
          begin
            GuardarLog(respUry + '\log.log', '-----------------------------');
            GuardarLog(respUry + '\log.log', 'Archivo : ' + a.FileName);
            GuardarLog(respUry + '\log.log', 'Error : ' + e.Message + ': Fecha= ' + DateTimeToStr(Now));
            GuardarLog(respUry + '\log.log', '-----------------------------');
          end;
        end;
      end;
      GuardarLog(respUry + '\log.log', 'Fin recorrido. - ' + DateTimeToStr(Now));
      GuardarLog(respUry + '\log.log', '----------------------------------');
    end;
    GuardarLog(respUry + '\log.log', '------------------------------------');
    GuardarLog(respUry + '\log.log', 'Se intentará enviar archivo: ' + archivo.FileName);

    respuesta := ws.Ingreso_MM_RAMM(archivo.FileStr);

    archivos.Text := respuesta;
    archivos.SaveToFile(respUry + '\respuesta.txt');

    GuardarLog(respUry + '\log.log', 'Respuesta: ' + respuesta + ' - ' + DateTimeToStr(Now));
    GuardarLog(respUry + '\log.log', '-------------------------------');

    if (FresourceManifiestoActivoSave and (UpperCase(respuesta) <> 'OK')) then
    begin
      archivos.Text := archivo.FileStr;
      if not DirectoryExists(FresourceManifiestoPathSave) then
        ForceDirectories(FresourceManifiestoPathSave);
      archivos.SaveToFile(FresourceManifiestoPathSave + '\' + archivo.FileName);
    end;

    result := respuesta;
  except
    try
      archivos.Text := archivo.FileStr;
      if not DirectoryExists(FresourceManifiestoPathSave) then
        ForceDirectories(FresourceManifiestoPathSave);
      archivos.SaveToFile(FresourceManifiestoPathSave + '\' + archivo.FileName);
    except
    end;

    result := 'Excepcion ws ury';
  end;
end;

type
  TGS = class
    gen: string;
    num: Integer;
  end;

function TWSTransitos.generoArch(aXMLMigra: string): string;
var
  DOC: IXMLDocument;
  i, a, docu: Integer;
  r: string;
  ManiHeader, ManiROWS: IXMLNode;
  archCHL, gen: string;
  ws: Iwspuente;
  e: DatosEntradaNew;
  s: DatosSalidaNew;
  stDoc: TStringList;
  GS: TGS;
  esCaminante: Boolean;
  CamR, CamReem1, CamReem2, cNumDoc, CPaisDoc: string;

  procedure agregoCampos(campos: string);
  begin
    archCHL := archCHL + ' ' + campos + ' ';
  end;

begin
  CamReem1 := '';
  CamReem2 := '';
  CamR := '';

  stDoc := TStringList.Create;

  DOC := LoadXMLData(aXMLMigra);

  archCHL := '';
  //archCHL:=archCHL+'<?xml version="1.0" encoding="ISO-8859-1" standalone="yes"?>'+#13#10;
  archCHL := archCHL + '<MANIFIESTO>' + #13#10;
  archCHL := archCHL + '<HEADER';

  ManiHeader := DOC.ChildNodes.Nodes['MANIFIESTO'].ChildNodes.Nodes['HEADER'];
  if Assigned(ManiHeader) then
  begin
    for a := 0 to ManiHeader.AttributeNodes.Count - 1 do
    begin
      r := '';

      if ManiHeader.AttributeNodes.Nodes[a].NodeName = 'TIPO_ACCION' then
      try
        agregoCampos('TIPO_ACCION="' + ManiHeader.AttributeNodes.Nodes[a].NodeValue + '"');
        Continue;
      except
        Continue;
      end;

      if ManiHeader.AttributeNodes.Nodes[a].NodeName = 'TIPO_MEDIO_TRANSPORTE' then
      try
        r := '00';
        if ManiHeader.AttributeNodes.Nodes[a].NodeValue = 'OMNIBUS' then
          r := '02';
        if ManiHeader.AttributeNodes.Nodes[a].NodeValue = 'CAMION' then
          r := '03';
        if ManiHeader.AttributeNodes.Nodes[a].NodeValue = 'AUTO' then
          r := '04';
        if ManiHeader.AttributeNodes.Nodes[a].NodeValue = 'OTROS TERRESTRES' then
        begin
          r := '08';
          CamR := r;
        end;
        if ManiHeader.AttributeNodes.Nodes[a].NodeValue = 'MOTO' then
          r := '14';

        agregoCampos('TIPO_MT="' + r + '"');
        Continue;
      except
        agregoCampos('TIPO_MT="00"');
        Continue;
      end;

      if ManiHeader.AttributeNodes.Nodes[a].NodeName = 'FECHA_PROGRAMADA_TRANSPORTE' then
      try
        agregoCampos('FECHA_MT="' + trim(ManiHeader.AttributeNodes.Nodes[a].NodeValue) + '"');
        Continue;
      except
        Continue;
      end;

      if ManiHeader.AttributeNodes.Nodes[a].NodeName = 'FUNCIONARIO' then
      try
        agregoCampos('FUNCIONARIO="' + ManiHeader.AttributeNodes.Nodes[a].NodeValue + '"');
        Continue;
      except
        Continue;
      end;

      if ManiHeader.AttributeNodes.Nodes[a].NodeName = 'MATRICULA_MEDIO_TRANSPORTE' then
      try
        agregoCampos('MATRICULA="' + ManiHeader.AttributeNodes.Nodes[a].NodeValue + '"');
        CamReem1 := 'MATRICULA="' + Trim(ManiHeader.AttributeNodes.Nodes[a].NodeValue) + '"';
        Continue;
      except
        CamReem1 := 'MATRICULA=""';
        agregoCampos('MATRICULA=""');
        Continue;
      end;

      if ManiHeader.AttributeNodes.Nodes[a].NodeName = 'PAIS_MATRICULA' then
      try
        agregoCampos('PAIS_MT="' + ManiHeader.AttributeNodes.Nodes[a].NodeValue + '"');
        CamReem2 := 'PAIS_MT="' + ManiHeader.AttributeNodes.Nodes[a].NodeValue + '"';

        Continue;
      except
        CamReem2 := 'PAIS_MT=""';
        agregoCampos('PAIS_MT=""');
        Continue;
      end;
    end;
  end;

  esCaminante := (CamR = '08') and (CamReem1 = 'MATRICULA=""');

  archCHL := archCHL + '/>' + #13#10;

  for i := 1 to DOC.ChildNodes.Nodes['MANIFIESTO'].ChildNodes.Count - 1 do
  begin
    ManiROWS := DOC.ChildNodes.Nodes['MANIFIESTO'].ChildNodes.Nodes[i];

    if Assigned(ManiROWS) and (ManiROWS.NodeName = 'ROW') then  // Your node(s) of interest
    begin
      docu := 0;
      for a := 0 to ManiROWS.AttributeNodes.Count - 1 do
      begin
        if ManiROWS.AttributeNodes.Nodes[a].NodeName = 'SEXO' then
        try
          gen := ManiROWS.AttributeNodes.Nodes[a].NodeValue;
          Continue;
        except
          Continue;
        end;

        if ManiROWS.AttributeNodes.Nodes[a].NodeName = 'NUMERO_DOCUMENTO' then
        try
          docu := ManiROWS.AttributeNodes.Nodes[a].NodeValue;
          Continue;
        except
          Continue;
        end;

      end;
      GS := TGS.Create;
      GS.gen := gen;
      GS.num := docu;

      stDoc.AddObject(IntToStr(i), GS);
    end;
  end;

  cNumDoc := '';
  CPaisDoc := '';

  for i := 1 to DOC.ChildNodes.Nodes['MANIFIESTO'].ChildNodes.Count - 1 do
  begin
    ManiROWS := DOC.ChildNodes.Nodes['MANIFIESTO'].ChildNodes.Nodes[i];

    archCHL := archCHL + '<ROW';
    if Assigned(ManiROWS) and (ManiROWS.NodeName = 'ROW') then  // Your node(s) of interest
    begin
      for a := 0 to ManiROWS.AttributeNodes.Count - 1 do
      begin
        if ManiROWS.AttributeNodes.Nodes[a].NodeName = 'TIPO_DOCUMENTO' then
        try
          agregoCampos('TIPO_DOCUMENTO="' + ManiROWS.AttributeNodes.Nodes[a].NodeValue + '"');
          Continue;
        except
          Continue;
        end;

        if ManiROWS.AttributeNodes.Nodes[a].NodeName = 'SEXO' then
        try
          //gen := ManiROWS.AttributeNodes.Nodes[a].NodeValue;
          agregoCampos('GENERO="' + gen + '"');

          Continue;
        except
          Continue;
        end;

        if ManiROWS.AttributeNodes.Nodes[a].NodeName = 'NUMERO_DOCUMENTO' then
        try
          agregoCampos('NUMERO_DOCUMENTO="' + ManiROWS.AttributeNodes.Nodes[a].NodeValue + '"');
          cNumDoc := ManiROWS.AttributeNodes.Nodes[a].NodeValue;
          Continue;
        except
          Continue;
        end;

        if ManiROWS.AttributeNodes.Nodes[a].NodeName = 'PAIS_DOCUMENTO' then
        try
          agregoCampos('PAIS_DOCUMENTO="' + ManiROWS.AttributeNodes.Nodes[a].NodeValue + '"');
          CPaisDoc := ManiROWS.AttributeNodes.Nodes[a].NodeValue;

          if ManiROWS.AttributeNodes.Nodes[a].NodeValue = 'ARG' then
          begin
            try
              GS := TGS(stDoc.Objects[stDoc.IndexOf(IntToStr(i))]);

              e := DatosEntradaNew.Create;
              s := DatosSalidaNew.Create;
              e.dni := GS.num;
              e.sexo := GS.gen;
              ws := GetIwspuente(False);
              s := ws.DameOcupacion(e);
              agregoCampos('OCUPACION="' + s.ocupacion + '"');
            finally
              FreeAndNil(s);
            end;
          end
          else
            agregoCampos('OCUPACION="SIN INFORMAR"');
          Continue;
        except
          Continue;
        end;

        if ManiROWS.AttributeNodes.Nodes[a].NodeName = 'PRI_APELLIDO' then
        try
          agregoCampos('PRI_APELLIDO="' + ManiROWS.AttributeNodes.Nodes[a].NodeValue + '"');
          Continue;
        except
          agregoCampos('PRI_APELLIDO=""');
          Continue;
        end;

        if ManiROWS.AttributeNodes.Nodes[a].NodeName = 'SEG_APELLIDO' then
        try
          agregoCampos('SEG_APELLIDO="' + ManiROWS.AttributeNodes.Nodes[a].NodeValue + '"');
          Continue;
        except
          agregoCampos('SEG_APELLIDO=""');
          Continue;
        end;

        if ManiROWS.AttributeNodes.Nodes[a].NodeName = 'PRI_NOMBRE' then
        try
          agregoCampos('PRI_NOMBRE="' + ManiROWS.AttributeNodes.Nodes[a].NodeValue + '"');
          Continue;
        except
          agregoCampos('PRI_NOMBRE=""');
          Continue;
        end;

        if ManiROWS.AttributeNodes.Nodes[a].NodeName = 'SEG_NOMBRE' then
        try
          agregoCampos('SEG_NOMBRE="' + ManiROWS.AttributeNodes.Nodes[a].NodeValue + '"');
          Continue;
        except
          agregoCampos('SEG_NOMBRE=""');
          Continue;
        end;

        if ManiROWS.AttributeNodes.Nodes[a].NodeName = 'FEC_NAC' then
        try
          agregoCampos('FEC_NAC="' + ManiROWS.AttributeNodes.Nodes[a].NodeValue + '"');
          Continue;
        except
          Continue;
        end;

        if ManiROWS.AttributeNodes.Nodes[a].NodeName = 'NACIONALIDAD' then
        try
          agregoCampos('NACIONALIDAD="' + ManiROWS.AttributeNodes.Nodes[a].NodeValue + '"');
          Continue;
        except
          Continue;
        end;

        if ManiROWS.AttributeNodes.Nodes[a].NodeName = 'TRIPULANTE_PASAJERO' then
        try
          agregoCampos('TRIP_PAX="' + ManiROWS.AttributeNodes.Nodes[a].NodeValue + '"');
          Continue;
        except
          Continue;
        end;

        if ManiROWS.AttributeNodes.Nodes[a].NodeName = 'FECHA_TRANSITO' then
        try
          agregoCampos('FECHA_TRANSITO="' + trim(ManiROWS.AttributeNodes.Nodes[a].NodeValue) + '"');
          agregoCampos('ESTADO_CIVIL="SIN INFORMAR"');
          agregoCampos('DOMICILIO="SIN INFORMAR"');
          Continue;
        except
          Continue;
        end;

        if ManiROWS.AttributeNodes.Nodes[a].NodeName = 'CATEGORIA' then
        try
          agregoCampos('CATEGORIA="' + ManiROWS.AttributeNodes.Nodes[a].NodeValue + '"');
          Continue;
        except
          agregoCampos('CATEGORIA=""');
          Continue;
        end;

        if ManiROWS.AttributeNodes.Nodes[a].NodeName = 'PROFESION' then
        try
          agregoCampos('PROFESION="' + ManiROWS.AttributeNodes.Nodes[a].NodeValue + '"');
          Continue;
        except
          agregoCampos('PROFESION=""');
          Continue;
        end;

        if ManiROWS.AttributeNodes.Nodes[a].NodeName = 'OBS' then
        try
          agregoCampos('OBS="' + ManiROWS.AttributeNodes.Nodes[a].NodeValue + '"');
          Continue;
        except
          agregoCampos('OBS=""');
          Continue;
        end;

      end;
    end;
    archCHL := archCHL + '/>' + #13#10;
  end;

  archCHL := archCHL + '</MANIFIESTO>' + #13#10;

  if esCaminante then
  begin
    archCHL := StringReplace(archCHL, CamReem1, 'MATRICULA="' + cNumDoc + '"', [rfReplaceAll]);
    archCHL := StringReplace(archCHL, CamReem2, 'PAIS_MT="' + CPaisDoc + '"', [rfReplaceAll]);
  end;

  Result := archCHL;

end;

function TWSTransitos.enviarManifiestoCHL(archivo: tarchivo): string;
var
  path, strDecoded, strEncoded: string;
  strDia, strMes, StrAno, fecha, hora, min, seg: string;
  archivos, arch: TStrings;
  ws: Ipuentechileno;
  respCHL, procesados, logpath: string;
  REQ: WriteRequestCHL;
  respuesta: WriteResponseCHL;
  resultado, logdeenvio: TStringList;
  i: integer;
  a: tarchivo;
begin
  try
    result := '';

    REQ := WriteRequestCHL.Create;
    respuesta := WriteResponseCHL.Create;

    leerIni;

    archivos := TStringList.Create;
    resultado := TStringList.Create;
    logdeenvio := TStringList.Create;
    respCHL := GPath_respCHL;
    procesados := GPath_procesados;

    logpath := ExtractFilePath(Application.ExeName) + IntToStr(YearOf(Now)) + '\' + FormatFloat('00', MonthOf(Now)) + '\' + FormatFloat('00', DayOf(now));

    if not DirectoryExists(FresourceManifiestoPathSave) then
      ForceDirectories(FresourceManifiestoPathSave);

    if not DirectoryExists(respCHL) then
      ForceDirectories(respCHL);

    if not DirectoryExists(procesados) then
      ForceDirectories(procesados);

    if not DirectoryExists(logpath) then
      ForceDirectories(logpath);

//    conectarRecurso(FresourceManifiestoUserSave, FresourceManifiestoPassSave, FresourceManifiestoPathSave);

    Listar(FresourceManifiestoPathSave, resultado);

    archivo.FileStr := getUryCleanEncoded(archivo.FileStr, FresourcePasos);
    try
      //logdeenvio.Add(FresourcePasos);
      logdeenvio.Add(archivo.FileStr);
      if not FileExists(logpath + '\' + formatdatetime('yyyymmddhhnnss', now) + '.txt') then
        logdeenvio.SaveToFile(logpath + '\' + formatdatetime('yyyymmddhhnnss', now) + '.txt')
      else
        logdeenvio.SaveToFile(logpath + '\' + formatdatetime('yyyymmddhhnnss', now) + '_2.txt')
    finally
      if Assigned(logdeenvio) then
        logdeenvio.Free;
    end;

    ws := GetIpuentechileno(true, FresourcePasosIps);

    if resultado.Count > 0 then
    begin
      GuardarLog(respCHL + '\log.log', '----------------------------------');
      GuardarLog(respCHL + '\log.log', 'Se recorre lista. - ' + DateTimeToStr(Now));
      for i := 0 to resultado.Count - 1 do
      begin
        try
          arch := TStringList.Create;
          arch.LoadFromFile(FresourceManifiestoPathSave + '\' + resultado[i]);
          a := tarchivo.Create;
          a.FileStr := arch.Text;

          REQ.Data := a.FileStr;
          REQ.FechaCierre := FormatDateTime('dd/mm/yyyy hh:mm:ss', Now());
          REQ.FileName := ExtractFileName(FresourceManifiestoPathSave + '\' + resultado[i]);

          respuesta := ws.RegistraViajeCHL(REQ);

          archivos.Text := IntToStr(respuesta.Status) + ' ' + respuesta.Descripcion;
          archivos.SaveToFile(respCHL + '\respuesta.txt');
          GuardarLog(respCHL + '\log.log', archivos.Text);

          if respuesta.status = 0 then
          //if 0= 0 then
          begin
            if FileExists(FresourceManifiestoPathSave + '\' + resultado[i]) then
            begin
              if RenameFile((FresourceManifiestoPathSave + '\' + resultado[i]), pchar(procesados + '\' + resultado[i])) then
              begin
                if FileExists(FresourceManifiestoPathSave + '\' + resultado[i]) then
                  if DeleteFile(FresourceManifiestoPathSave + '\' + resultado[i]) then
                    GuardarLog(respCHL + '\log.log', 'Se borro el archivo: ' + resultado[i] + ' - ' + DateTimeToStr(Now));
                GuardarLog(respCHL + '\log.log', 'Se movió el archivo: ' + resultado[i] + ', a ' + procesados + ' - ' + DateTimeToStr(Now));
              end;
            end;
          end;

          a.Free;
          arch.Free;
        except
          on e: Exception do
          begin
            GuardarLog(respCHL + '\log.log', '-----------------------------');
            GuardarLog(respCHL + '\log.log', 'Archivo : ' + a.FileName);
            GuardarLog(respCHL + '\log.log', 'Error : ' + e.Message + ': Fecha= ' + DateTimeToStr(Now));
            GuardarLog(respCHL + '\log.log', '-----------------------------');
          end;
        end;
      end;
      GuardarLog(respCHL + '\log.log', 'Fin recorrido. - ' + DateTimeToStr(Now));
      GuardarLog(respCHL + '\log.log', '----------------------------------');
    end;
    GuardarLog(respCHL + '\log.log', '------------------------------------');
    GuardarLog(respCHL + '\log.log', 'Se intentara enviar archivo: ' + archivo.FileName);

    REQ.FechaCierre := FormatDateTime('dd/mm/yyyy hh:mm:ss', Now());
    REQ.FileName := archivo.FileName;
    REQ.Data := archivo.FileStr;

    {Formato viejo - mas profecion}
    //REQ.Data := Encode64(generoArch(Decode64(archivo.FileStr)));

    //Envia el transito a Chile.
    respuesta := ws.RegistraViajeCHL(REQ);

    archivos.Text := IntToStr(respuesta.Status) + ' ' + respuesta.Descripcion;
    archivos.SaveToFile(respCHL + '\respuesta.txt');

    GuardarLog(respCHL + '\log.log', 'Respuesta: ' + archivos.Text + ' - ' + DateTimeToStr(Now));
    GuardarLog(respCHL + '\log.log', '-------------------------------');

    if (FresourceManifiestoActivoSave) and (respuesta.Status <> 0) then//(UpperCase(respuesta) <> 'OK')) then
    begin
      archivos.Text := REQ.Data; //archivo.FileStr;
      if not DirectoryExists(FresourceManifiestoPathSave) then
        ForceDirectories(FresourceManifiestoPathSave);
      archivos.SaveToFile(FresourceManifiestoPathSave + '\' + archivo.FileName);
    end;

    if respuesta.Status = 0 then
      result := 'OK'
    else
      result := 'No OK';
  except
    try
      archivos.Text := archivo.FileStr;
      if not DirectoryExists(FresourceManifiestoPathSave) then
        ForceDirectories(FresourceManifiestoPathSave);
      archivos.SaveToFile(FresourceManifiestoPathSave + '\' + archivo.FileName);
    except
    end;

    result := 'Excepcion ws CHL';
  end;


{var path, strDecoded, strEncoded, r : string;
    strDia, strMes, StrAno, fecha, hora, min, seg: string;
    archivos, arch : TStrings;
    respuesta, respCHL, procesados, MandadosCHL , archContenidoChl: string;
    resultado : TStringList;
    estaArch : Boolean;
    i: integer;
    a : tarchivo;
    FrmSocketChile: TFrmSocketChile;
    Year, Month, Day: Word;
begin
  try
    result := '';
    respuesta := '';

    FrmSocketChile := nil;

    leerIni;

    archivos   := TStringList.Create;
//    try COMENTADO POR COMENTAR EL FINALLY END MAS ABAJO;
      resultado  := TStringList.Create;
      respCHL    := GPath_respCHL;
      procesados := GPath_procesados;
      MandadosCHL := GPath_MandadosCHL;


      FrmSocketChile:= TFrmSocketChile.Create(nil);
      with FrmSocketChile do
      begin
        r := autenticar('9999');
        if not esOK(r) then raise Exception.Create('ERROR! en autenticar'+r);
      end;



     //conectarRecurso(FresourceManifiestoUserSave, FresourceManifiestoPassSave, FresourceManifiestoPathSave);


      if not DirectoryExists(FresourceManifiestoPathSave) then
        ForceDirectories(FresourceManifiestoPathSave);

      if not DirectoryExists(respCHL) then
        ForceDirectories(respCHL);

      if not DirectoryExists(procesados)then
        ForceDirectories(procesados);

      DecodeDate(now,Year, Month, Day);
  
      MandadosCHL := normalizoDir(MandadosCHL) +
       normalizoDir(IntToStr(Year))+
       normalizoDir(IntToStr(Month))+
       normalizoDir(IntToStr(Day));

      if not DirectoryExists(MandadosCHL)then
        ForceDirectories(MandadosCHL);



    with FrmSocketChile do
    begin
      archContenidoChl := Encode64(generoArch(Decode64(archivo.FileStr)));
      crearArchivo(normalizoDir(MandadosCHL)+'CHL_'+archivo.FileName,archContenidoChl);

      r := manifiesto('9999',archContenidoChl);
      if esOK(r) then
         respuesta  := 'OK'
      else
         respuesta  := '';
    end;

//    respuesta  := 'OK';//  aaaaaaaaaaaaaaaaaaaa

    if not Assigned(archivos) then
      archivos := TStringList.Create;


    try
      archivos.Text := respuesta;
      archivos.SaveToFile(respCHL + '\respuesta.txt');

      GuardarLog(respCHL + '\log.log', 'Respuesta: ' + respuesta + ' - ' + DateTimeToStr(Now));
      GuardarLog(respCHL + '\log.log', '-------------------------------');

      if (FresourceManifiestoActivoSave and (UpperCase(respuesta) <> 'OK')) then
      begin
        archivos.Text := archivo.FileStr;
        if not DirectoryExists(FresourceManifiestoPathSave) then
          ForceDirectories(FresourceManifiestoPathSave);
        archivos.SaveToFile(FresourceManifiestoPathSave +'\' + archivo.FileName);
      end;

      result := respuesta;
    finally
      if Assigned(archivos) then
        FreeAndNil(archivos);

    end;
  except
    on e:exception do
    begin
      result := '';//e.Message;
      GuardarLog(respCHL + '\log.log', 'Respuesta: ' + e.Message + ' - ' + DateTimeToStr(Now));
    end;
  end;
  if Assigned(FrmSocketChile) then
    FreeAndNil(FrmSocketChile);
    }
end;

function TWSTransitos.getUryCleanEncoded(linea: WideString; var paso: string): WideString;
var
  separador: Integer;
  destino: string;
begin
  separador := Ansipos('   ', linea);
  if separador = 0 then
    Result := linea
  else
  begin
    paso := trim(RightStr(linea, 3));
    Result := trim(LeftStr(linea, separador));
  end;
end;

function TWSTransitos.enviarManifiestoPryBol(archivo: tarchivo): string;
var
  path, strDecoded, strEncoded: string;
  strDia, strMes, StrAno, fecha, hora, min, seg: string;
  archivos, arch: TStrings;
  ws: IwsPuentePRY;
  wsBol: IwsPuenteBolivia;
  rtaWSBol: TRespuesta;
  rtaWSPry: TRespuestaPry;
  respuesta, resPry, procesados, logpath: string;
  resultado, logdeenvio: TStringList;
  i: integer;
  a: tarchivo;
begin
  try
    result := '';
    respuesta := '';
    rtaWSBol := TRespuesta.Create;
    rtaWSPry := TRespuestaPry.Create;

    leerIni;
    archivos := TStringList.Create;
    resultado := TStringList.Create;
    logdeenvio := TStringList.Create;
    resPry := GPath_respCHL;
    procesados := GPath_procesados;

    logpath := ExtractFilePath(Application.ExeName) + IntToStr(YearOf(Now)) + '\' + FormatFloat('00', MonthOf(Now)) + '\' + FormatFloat('00', DayOf(now));

    if not DirectoryExists(FresourceManifiestoPathSave) then
      ForceDirectories(FresourceManifiestoPathSave);

    if not DirectoryExists(resPry) then
      ForceDirectories(resPry);

    if not DirectoryExists(procesados) then
      ForceDirectories(procesados);

    if not DirectoryExists(logpath) then
      ForceDirectories(logpath);

    conectarRecurso(FresourceManifiestoUserSave, FresourceManifiestoPassSave, FresourceManifiestoPathSave);

    Listar(FresourceManifiestoPathSave, resultado);

    archivo.FileStr := getUryCleanEncoded(archivo.FileStr, FresourcePasos);

    if fredirijo <> 1 then
    begin
      try
        logdeenvio.Add(FresourcePasos);
        logdeenvio.Add(archivo.FileStr);
        logdeenvio.SaveToFile(logpath + '\' + formatdatetime('yyyymmddhhnnss', now) + '.txt');
      finally
        if Assigned(logdeenvio) then
          logdeenvio.Free;
      end;
    end;



    {
    if UpperCase(FresourcePasos) = 'PRY' then
      ws := GetIwsPuentePRY(false, '10.170.18.66');

    if UpperCase(FresourcePasos) = 'BOL' then
      wsBol := GetIwsPuenteBolivia(false, '10.170.107.66:82');  }

    if UpperCase(FresourcePasos) = 'PRY' then
      ws := GetIwsPuentePRY(false, FresourcePasosIps);

    if UpperCase(FresourcePasos) = 'BOL' then
      wsBol := GetIwsPuenteBolivia(false, FresourcePasosIps);

    GuardarLog(resPry + '\' + formatdatetime('yyyymmdd', now) + '.log', FresourcePasos);

    if resultado.Count > 0 then
    begin
      GuardarLog(resPry + '\' + formatdatetime('yyyymmdd', now) + '.log', '----------------------------------');
      GuardarLog(resPry + '\' + formatdatetime('yyyymmdd', now) + '.log', 'Se recorre lista. - ' + DateTimeToStr(Now));
      for i := 0 to resultado.Count - 1 do
      begin
        try
          arch := TStringList.Create;
          arch.LoadFromFile(FresourceManifiestoPathSave + '\' + resultado[i]);
          a := tarchivo.Create;
          a.FileStr := arch.Text;
          a.FileName := ExtractFileName(FresourceManifiestoPathSave + '\' + resultado[i]); // archivo.FileName;

          if UpperCase(FresourcePasos) = 'PRY' then
          begin
            rtaWSPry := ws.enviarSobre(a.FileName, a.FileStr);
            if (rtaWSPry.Respuesta = '1') and (rtaWSPry.DetalleRta = '0') then
              respuesta := 'OK'
            else
              respuesta := rtaWSPry.Respuesta + ' - ' + rtaWSPry.DetalleRta;
          end
          else
          begin
            rtaWSBol := wsBol.enviarSobre(a.FileStr, a.FileName, 'argentina');
            if ((rtaWSBol.Respuesta = '1') or (rtaWSBol.DetalleRta = 'CORRECTO')) then
              respuesta := 'OK'
            else
              respuesta := rtaWSBol.DetalleRta + ' - ' + rtaWSBol.Respuesta;
          end;

          archivos.Text := respuesta;
          archivos.SaveToFile(resPry + '\respuesta.txt');
          GuardarLog(resPry + '\' + formatdatetime('yyyymmdd', now) + '.log', respuesta);

          if UpperCase(respuesta) = 'OK' then

          //if 0=0 then
          begin
            if FileExists(FresourceManifiestoPathSave + '\' + resultado[i]) then
            begin
              if RenameFile((FresourceManifiestoPathSave + '\' + resultado[i]), pchar(procesados + '\' + resultado[i])) then
              begin
                if FileExists((FresourceManifiestoPathSave + '\' + resultado[i])) then
                  if DeleteFile(FresourceManifiestoPathSave + '\' + resultado[i]) then
                    GuardarLog(resPry + '\' + formatdatetime('yyyymmdd', now) + '.log', 'Se borro el archivo: ' + resultado[i] + ' - ' + DateTimeToStr(Now));
                GuardarLog(resPry + '\' + formatdatetime('yyyymmdd', now) + '.log', 'Se movió el archivo: ' + resultado[i] + ', a ' + procesados + ' - ' + DateTimeToStr(Now));
              end;
            end;
          end;

          a.Free;
          arch.Free;
        except
          on e: Exception do
          begin
            GuardarLog(resPry + '\error.log', '-----------------------------');
            GuardarLog(resPry + '\error.log', 'Archivo : ' + a.FileName);
            GuardarLog(resPry + '\error.log', 'Error : ' + e.Message + ': Fecha= ' + DateTimeToStr(Now));
            GuardarLog(resPry + '\error.log', '-----------------------------');

          end;

        end;
      end;
      GuardarLog(resPry + '\' + formatdatetime('yyyymmdd', now) + '.log', 'Fin recorrido. - ' + DateTimeToStr(Now));
      GuardarLog(resPry + '\' + formatdatetime('yyyymmdd', now) + '.log', '----------------------------------');
    end;

    GuardarLog(resPry + '\' + formatdatetime('yyyymmdd', now) + '.log', '------------------------------------');
    GuardarLog(resPry + '\' + formatdatetime('yyyymmdd', now) + '.log', 'Se intentara enviar archivo: ' + archivo.FileName);
    respuesta := 'NOOK';
    try
      //if FresourcePasos = 'Pry' then
      if UpperCase(FresourcePasos) = 'PRY' then
      begin
        rtaWSPry := ws.enviarSobre(archivo.FileName, archivo.FileStr);
        if (rtaWSPry.Respuesta = '1') and (rtaWSPry.DetalleRta = '0') then
          respuesta := 'OK'
        else
          respuesta := rtaWSPry.Respuesta + ' - ' + rtaWSPry.DetalleRta;

      end
      else
      begin
        rtaWSBol := wsBol.enviarSobre(archivo.FileStr, archivo.FileName, 'argentina');
        if ((rtaWSBol.Respuesta = '1') or (rtaWSBol.DetalleRta = 'CORRECTO')) then
          respuesta := 'OK'
        else
          respuesta := rtaWSBol.DetalleRta + ' - ' + rtaWSBol.Respuesta;
      end;
    except
      GuardarLog(resPry + '\error.log', 'excepcion llamada');
    end;

    archivos.Text := respuesta;
    archivos.SaveToFile(resPry + '\respuesta.txt');

    GuardarLog(resPry + '\' + formatdatetime('yyyymmdd', now) + '.log', 'Respuesta: ' + respuesta + ' - ' + DateTimeToStr(Now));
    GuardarLog(resPry + '\' + formatdatetime('yyyymmdd', now) + '.log', '-------------------------------');

    if (FresourceManifiestoActivoSave and (UpperCase(respuesta) <> 'OK')) then
    begin
      archivos.Text := archivo.FileStr;
      if not DirectoryExists(FresourceManifiestoPathSave) then
        ForceDirectories(FresourceManifiestoPathSave);
      archivos.SaveToFile(FresourceManifiestoPathSave + '\' + archivo.FileName);
    end;

    result := respuesta;
  except
    result := 'Excepcion';
  end;
end;

function TWSTransitos.Enviar_Transitos_SICaM_alt(transitos: ttransitoFile): boolean;
var
  ts, archivo: TStrings;
  strfechahora: string;
  f: TDateTime;
  e: Boolean;
begin
  try
    result := false;
    //obtengo los datos del recurso
    leerIni;
//    fs.TimeSeparator:='';
 //   fs.DateSeparator:='';
    //Me autentico en el recurso
  //  conectarRecurso(FresourceUserSave, FresourcePassSave, FresourcePathSave);
    //Creo el archivo
    archivo := TStringList.Create;
    archivo.Text := Decode64(transitos.archivo);
    //guardo el archivo
    e := false;
    try
      f := StrToDateTime(transitos.fecha);
    except
      e := true;
    end;

    if e then
      f := StrToDateTime(StringReplace(transitos.fecha, '/', '-', [rfReplaceAll]));

    strfechahora := formatDateTime('YYYYMMDDhhnnss', f);


    //-----------------------------------
    if not DirectoryExists(FresourcePathSaveBis + '\' + transitos.organismo) then
      ForceDirectories(FresourcePathSaveBis + '\' + transitos.organismo);

    if not DirectoryExists(FresourcePathSaveBis + '\rechazados') then
      ForceDirectories(FresourcePathSaveBis + '\rechazados');

    if FileExists(FresourcePathSaveBis + '\' + transitos.organismo + '\' + strfechahora + '.xml') then
      archivo.SaveToFile(FresourcePathSaveBis + '\' + transitos.organismo + '\' + strfechahora + '_2.xml')
    else
      archivo.SaveToFile(FresourcePathSaveBis + '\' + transitos.organismo + '\' + strfechahora + '.xml');
    //FIN PATH
    result := true;
  except
    on e: exception do
    begin
      if not DirectoryExists(FresourceExceptPath) then
        ForceDirectories(FresourceExceptPath + '\');
      ts := TStringList.Create;
      ts.Add(e.Message);
      ts.Add(transitos.archivo + ' - ' + transitos.organismo + ' - ' + transitos.fecha);
      try
        ts.SaveToFile(FresourceExceptPath + '\' + transitos.archivo);
      except
        ts.SaveToFile(FresourceExceptPath + '\' + transitos.organismo + '\' + strfechahora + '.xml');
      end;
      result := false;
      archivo.SaveToFile(FresourcePathSaveBis + '\rechazados\' + strfechahora + '.xml');
    end;
  end;
end;

function TWSTransitos.checkXML(archivo: WideString): string;
var
  xmldoc: IXMLDocument;
  node, manifiesto: IXMLNode;
  tipodoc, documento, matricula, fechatransito, apellido, nombre, fechanac: string;
  i: integer;
begin
  xmldoc := TXMLDocument.Create(nil);

  i := 0;

  xmldoc.XML.Append(archivo);

  try
    xmldoc.Active := true;
  except
    on e: exception do
    begin
      Result := e.Message;
      exit;
    end;
  end;

  try

    manifiesto := xmldoc.ChildNodes[i + 1];

    manifiesto.ChildNodes.First;
    node := manifiesto.ChildNodes[i];

    matricula := node.Attributes['MATRICULA_MEDIO_TRANSPORTE'];

    i := i + 1;

    node := manifiesto.ChildNodes[i];

    tipodoc := node.Attributes['TIPO_DOCUMENTO'];
    documento := node.Attributes['NUMERO_DOCUMENTO'];

    apellido := node.Attributes['PRI_APELLIDO'];

    nombre := node.Attributes['PRI_NOMBRE'];

    fechanac := node.Attributes['FEC_NAC'];

    fechatransito := node.Attributes['FECHA_TRANSITO'];

    Result := fechatransito + ' - ' + matricula + '-' + tipodoc + ' ' + documento + ' - ' + apellido + ', ' + nombre + ' - ' + fechanac;
  except
    on e: exception do
    begin
      Result := e.Message + ' error xml';
      exit;
    end;
  end;

end;

function TWSTransitos.guardarArchivoSeguro(path, nombre, extension: string; archivo: TStrings): Boolean;
var
  i: integer;
  n: string;
begin
  Result := false;
  i := 0;
  n := '_' + IntToStr(random(125));
  while i = 0 do
  begin
    if not FileExists(path + nombre + n + extension) then
    begin
      archivo.SaveToFile(path + nombre + n + extension);
      i := 1;
      Result := true;
    end;
    n := '_' + IntToStr(random(125));
  end;
end;

initialization
  { Invokable classes must be registered }
  InvRegistry.RegisterInvokableClass(TWSTransitos);

end.

