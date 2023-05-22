unit EgateFunciones;

interface

uses System.Types, WinApi.Windows, System.Classes;

const
  SEPADADORIMAGEN='<****>';



function FIleToByteArray(const FileName: string): TByteDynArray;
procedure ByteArrayToFIle(const ByteArray: TByteDynArray;
  const FileName: string);
function deltree(Dir: string): Boolean;
function Calcular_MD5(Cadena: string): string;
function normalizoDir(aDir: string): string;
function directorioArchivosEgate: string;
procedure ConvertStrBase64ToFile(const base64: AnsiString;
  const FileName: string);
procedure ConvertFileToFileBase64(const AInFileName, AOutFileName: string);
function ConvertFileToStrBase64(const AInFileName: string): AnsiString;
procedure Jpeg2Bmp(const JpgFileName, BmpFileName: string);
procedure Jpeg2BmpOLD(const JpgFileName, BmpFileName: string);
procedure Bmp2Jpeg(const BmpFileName, JpgFileName: string);
function ByteArraytoStr(P: TByteDynArray): AnsiString;
function strToByteArray(S: AnsiString): TByteDynArray;

procedure grabarArchivoBat(nom: string; cont1, cont2, cont3, cont4,
  cont5: String);
function leerInt(nom: string): Integer;
function YYMMDDtoDate(YYMMDD: string): TDate;
function YYMMDDtoDateSumo2000(YYMMDD: string): TDate;
function DirTransac(idLOC, id: string): string;
procedure FixNames(name: string; var str1, str2: String);
procedure ExecProcess(ProgramName: String;Params: string; Wait: Boolean);
function PuertoREST: Integer;
function NroRemoto:Integer;
function usoCambioAutoRemoto:Boolean;
function WSConf1:Boolean;
function WSConf1Check:Boolean;
function WSHabilitoPORSicam:Boolean;
function WSUsarResLocal:Boolean;

function WSDebug:Boolean;
function WSEsKiosko:Boolean;
function FaceComp:Boolean;
function FaceScore:Integer;
function IPReinicioServidorFacial:String;
function CMDReinicioFacial:String;

function PuertoWS: Integer;
function LogicaInversa:Integer;
procedure grabarArchivo(nom, contenido: string);
function StrToBase64(S: AnsiString): AnsiString;
function Base64ToStr(S:AnsiString):AnsiString;
function iif(const Condition: Boolean; Value1, Value2: Variant): Variant;
procedure grabarEnArchivoLog(Error: string;nomA:string='');
function verLog:String;
function verTraza:String;
procedure grabarEnArchivoDURNo(info: string);
procedure grabarEnArchivoTraza(nombrenA,info: string);
function PostEgate(IP:string;cmd:string):Boolean;
function LoadFileToStr(const FileName: string): string;
function File2Str(ruta: ansistring): ansistring;
function FileSize2(const aFilename: String): Int64;
function WSConf1ResetHref:Boolean;
function pathBckEnviar_Transitos_SICaM:String;

function OcupaMemoriaM:Integer;
function EspacioDiscoM:String;
function TamArchivo(const Arch: AnsiString): Integer;
function LsFiles(aDir:string):String;


implementation

uses System.SysUtils, IdGlobal, IdHash, IdHashMessageDigest, System.IniFiles, System.Math,
  System.NetEncoding, Vcl.Imaging.jpeg, Vcl.Graphics, System.DateUtils, Vcl.ExtCtrls,
  IdHTTP,Vcl.Imaging.pngimage,Winapi.PsAPI, Winapi.ShellAPI, Vcl.Forms;


var
  GLOBALConfigINI_directorioArchivosEgate:String = '';
//  con : TNetConnection; //Lenardo Quadraccia - lquadraccia@gmail.com
  LSGL,LSGT:TStringList;


function verLog:String;
begin
  try
    Result := LSGL.Text;
  except
  end;
end;

function verTraza:String;
begin
  try
    Result := LSGT.Text;
  except
  end;
end;


procedure reinicioApp;
begin
  grabarEnArchivoLog('**** REINICIO!!!****');
  var archBat := ExtractFilePath(Application.ExeName)+'\reinicio.bat';
  var cont := 'TASKKILL /F /IM '+ ExtractFileName(Application.ExeName)+' & start '+Application.ExeName;
  grabarArchivo(archBat,cont);
  ShellExecute(0, nil, PChar(archBat), nil, nil, SW_SHOWDEFAULT);
end;


procedure insertLSM(ls:TStringList;dato:string);
begin
  try
    if ls.Count>20 then
    begin
      ls.Delete(0);
    end;
    ls.Add(dato);
  EXCEPT
  end;
end;

function TamArchivo(const Arch: AnsiString): Integer;

  function TextfileSize(const name: string): LongInt;
  var
    SRec: TSearchRec;
  begin
    if FindFirst(name, faAnyfile, SRec) = 0 then
    begin
      Result := SRec.Size;
      FindClose(SRec);
    end
    else
      Result := 0;
  end;

begin
  Result := TextfileSize(Arch);
end;



procedure fin(nombre: string);//(cantScaneados:Integer);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\' + nombre);
  try
    ini.WriteString('SCAN', 'Termino', 'S');
    ini.UpdateFile;
  finally
    ini.Free;
  end;
end;

function EjecutoBatRemoto(const contenido: AnsiString): Boolean;
var
  mm: TStringList;
  s: string;
  i: integer;
begin
  Randomize;
  s := IntTOStr(RandomRange(10, 1999999));

  while FileExists(ExtractFilePath(ParamStr(0)) + '\' + s + '.bin') do
    s := IntTOStr(RandomRange(10, 1999999));

  mm := TStringList.Create;
  try
    fin(s + '.bin');
    mm.Text := contenido;

    mm.Add('del ' + s + '.bin');
    mm.SaveToFile(ExtractFilePath(ParamStr(0)) + '\pcs' + s + '.bat');

    ShellExecute(Application.Handle, nil, PChar(ExtractFilePath(ParamStr(0)) + '\pcs' + s + '.bat'), nil, nil, 0);
    Application.ProcessMessages;

    while FileExists(ExtractFilePath(ParamStr(0)) + '\' + s + '.bin') do
      Application.ProcessMessages;

    DeleteFile(ExtractFilePath(ParamStr(0)) + s + '.bin');
    DeleteFile(ExtractFilePath(ParamStr(0)) + '\pcs' + s + '.bat');
  finally
    FreeAndNil(mm);
  end;
end;



function EspacioDiscoM:String;
begin
  var st := TStringList.Create;
  try
    for var i := 2 to 6 do
    begin
      var space := DiskSize(i) div (1024*1024);

      if space >= 0 then
      begin
        st.Add(Space.ToString);
      end;
    end;

    Result := st.Text;
  finally
    st.free;
  end;
end;


function LsFiles(aDir:string):String;
var
  ls:TStringList;
  sr: TSearchRec;
begin
  ls:=TStringList.Create;
  try
    if FindFirst(normalizoDir(aDir) + '*.*', faAnyFile, sr) = 0 Then
      repeat
        if (sr.Name <> '..') and (sr.Name <> '.') then
          ls.Add(sr.Name);
      until FindNext(sr) <> 0;
    Result := ls.Text;
  finally
    ls.Free;
  end;
end;


function OcupaMemoriaM:Integer;
begin
  var pmc: PPROCESS_MEMORY_COUNTERS;
  var archBat,cont:String;
  var memoria:Integer:=0;
  Result := -1;
  try
    var cb := SizeOf(_PROCESS_MEMORY_COUNTERS);
    GetMem(pmc, cb);
    try
      pmc^.cb := cb;
      if GetProcessMemoryInfo(GetCurrentProcess(), pmc, cb) then memoria := pmc^.WorkingSetSize div (1024*1024);
    finally
      FreeMem(pmc);
    end;
    Result := memoria;
  except
    memoria := 0;
  end;
end;


function FileSize2(const aFilename: String): Int64;
var
  info: TWin32FileAttributeData;
begin
  result := -1;

  if NOT GetFileAttributesEx(PWideChar(aFileName), GetFileExInfoStandard, @info) then
    EXIT;

  result := Int64(info.nFileSizeLow) or Int64(info.nFileSizeHigh shl 32);

end;



function LoadFileToStr(const FileName: string): string;
var
  FileStream : TFileStream;
  Bytes: TBytes;
begin
  Result:= '';
  FileStream:= TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    if FileStream.Size>0 then begin
      SetLength(Bytes, FileStream.Size);
      FileStream.Read(Bytes[0], FileStream.Size);
    end;
    Result:= TEncoding.ASCII.GetString(Bytes);
  finally
    FileStream.Free;
  end;
end;

function File2Str(ruta: ansistring): ansistring;
var f: file;
begin
{$I-}
  result := '';
  if not FileExists(ruta) then exit;
  assignfile(f, ruta);
  filemode := fmOpenRead;
  reset(f, 1);
  setlength(result, system.filesize(f));
  blockread(f, result[1], length(result));
  closefile(f);
{$I+}
end;





function PostEgate(IP:string;cmd:string):Boolean;
var
  lHTTP: TIdHTTP;
begin
  try
    lHTTP := TIdHTTP.Create;
    try
      lHTTP.Post('http://'+IP+'/GateServerArgWebService/', ExtractFilePath(ParamStr(0))+cmd+'.xml');
      Result := True;
    finally
      lHTTP.Free;
    end;
  Except
    Result := False;
  end;

end;


procedure grabarEnArchivoTraza(nombrenA,info: string);
var
  myFile: TextFile;
  nombreArch: string;
begin
    insertLSM(LSGT,info);
  try
    nombreArch := ChangeFileExt(ParamStr(0), '_traza_'+nombrenA+'.log');
    AssignFile(myFile, nombreArch);
    if not FileExists(nombreArch) then
      ReWrite(myFile)
    else
      append(myFile);

    WriteLn(myFile, FormatDateTime('YYYY-MM-DD hh:mm:ss>', Now) + '-' + info);

    CloseFile(myFile);
  except
  end;
end;


procedure grabarEnArchivoDURNo(info: string);
var
  myFile: TextFile;
  nombreArch: string;
begin
  try
    nombreArch := ChangeFileExt(ParamStr(0), '.ver');
    AssignFile(myFile, nombreArch);
    if not FileExists(nombreArch) then
      ReWrite(myFile)
    else
      append(myFile);

    WriteLn(myFile, info);

    CloseFile(myFile);
  except
  end;
end;



procedure grabarEnArchivoLog(Error: string;nomA:string='');
var
  myFile: TextFile;
  nombreArch: string;
begin
  insertLSM(LSGL,Error);
  try
    if nomA<>'' then
    begin
      if pos('yyyymmdd',nomA)>1 then
      begin
        ForceDirectories(ExtractFilePath(nomA)+'\');
        nombreArch := ExtractFilePath(nomA)+'\'+FormatDateTime('YYYYMMDD', Now)+'.txt';
      end else
        nombreArch := nomA
    end else
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

function iif(const Condition: Boolean; Value1, Value2: Variant): Variant;
begin
  if Condition then
    Result := Value1
  else
    Result := Value2;
end;

procedure grabarArchivo(nom, contenido: string);
var
  st: TStringList;
begin
  try
    st := TStringList.Create;
    try
      st.Add(contenido);
      st.SaveToFile(nom);
    finally
      st.Free;
    end;
  except
  end;
end;

function StrToBase64(S: AnsiString): AnsiString;
var
  base64: TBase64Encoding;
begin
  base64 := TBase64Encoding.Create(0); // CharsPerLine = 0 means no line breaks
  try
    Result := base64.Encode(S);
  finally
    base64.Free;
  end;
end;

function Base64ToStr(S:AnsiString):AnsiString;
var
  base64: TBase64Encoding;
begin
  base64 := TBase64Encoding.Create(0); // CharsPerLine = 0 means no line breaks
  try
    Result := base64.Decode(S);
  finally
    base64.Free;
  end;
end;


function PuertoREST: Integer;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadInteger('REST', 'PUERTO', 8081);
    // '10.170.15.8:D:\Basedatos\sicam.gdb');
  finally
    inifile.Free;
  end;
end;

function usoCambioAutoRemoto:Boolean;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadInteger('REMOTO', 'AUTO', 0)=1;
  finally
    inifile.Free;
  end;
end;


function NroRemoto: Integer;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadInteger('REMOTO', 'NRO', 0);
  finally
    inifile.Free;
  end;
end;


function PuertoWS: Integer;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadInteger('WS', 'PUERTO', 8080);
    // '10.170.15.8:D:\Basedatos\sicam.gdb');
  finally
    inifile.Free;
  end;
end;

function WSDebug:Boolean;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadInteger('WS', 'DEBUG', 0)=1;
    // '10.170.15.8:D:\Basedatos\sicam.gdb');
  finally
    inifile.Free;
  end;
end;

function WSConf1:Boolean;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadInteger('WS', 'Conf1', 0)=1;
    // '10.170.15.8:D:\Basedatos\sicam.gdb');
  finally
    inifile.Free;
  end;
end;



function EjecutoExterno5Horas:string;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadString('EXTERNO', 'cmd', '');

  finally
    inifile.Free;
  end;
end;


function WSConf1Check:Boolean;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadInteger('WS', 'Conf1Check', 0)=1;
    // '10.170.15.8:D:\Basedatos\sicam.gdb');
  finally
    inifile.Free;
  end;
end;

function WSHabilitoPORSicam:Boolean;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadInteger('WS', 'HabilitoPORSicam', 0)=1;
    // '10.170.15.8:D:\Basedatos\sicam.gdb');
  finally
    inifile.Free;
  end;
end;


function WSUsarResLocal:Boolean;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadInteger('WS', 'WSUsarResLocal', 0)=1;
    // '10.170.15.8:D:\Basedatos\sicam.gdb');
  finally
    inifile.Free;
  end;
end;


function WSConf1ResetHref:Boolean;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadInteger('WS', 'Conf1ResetHref', 0)=1;
    // '10.170.15.8:D:\Basedatos\sicam.gdb');
  finally
    inifile.Free;
  end;
end;

function pathBckEnviar_Transitos_SICaM:String;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadString('WS', 'pathBckEnviar_Transitos_SICaM','');
  finally
    inifile.Free;
  end;
end;

function FaceScore:Integer;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadInteger('REST', 'FaceScore', 70);
  finally
    inifile.Free;
  end;
end;

function FaceComp:Boolean;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadInteger('REST', 'FaceComp', 1)=1;
    // '10.170.15.8:D:\Basedatos\sicam.gdb');
  finally
    inifile.Free;
  end;
end;

function IPReinicioServidorFacial:String;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadString('REST', 'IPSRV', '');
    // '10.170.15.8:D:\Basedatos\sicam.gdb');
  finally
    inifile.Free;
  end;
end;


function CMDReinicioFacial:String;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadString('REST', 'CMDReinicio', '');
    // '10.170.15.8:D:\Basedatos\sicam.gdb');
  finally
    inifile.Free;
  end;
end;




function WSEsKiosko:Boolean;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadInteger('WS', 'EsKiosko', 0)=1;
    // '10.170.15.8:D:\Basedatos\sicam.gdb');
  finally
    inifile.Free;
  end;
end;

function LogicaInversa: Integer;
var
  inifile: TIniFile;
begin
  inifile := TIniFile.Create(Format('%sCONFIG.ini',
    [ExtractFilePath(ExtractFilePath(ParamStr(0)))]));
  try
    Result := inifile.ReadInteger('LogicaInversa', 'activo', 0);
    // '10.170.15.8:D:\Basedatos\sicam.gdb');
  finally
    inifile.Free;
  end;
end;




procedure ExecProcess(ProgramName: String;Params: string; Wait: Boolean);
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  ProcessCreated: Boolean;
  CommandLine: String;
begin
  { fill with known state }
  if Params <> '' then
    CommandLine := Format('%s %s', [ProgramName, Params])
  else
    CommandLine := Format('%s', [ProgramName]);

  FillChar(StartupInfo, SizeOf(TStartupInfo), #0);
  FillChar(ProcessInfo, SizeOf(TProcessInformation), #0);
  StartupInfo.cb := SizeOf(TStartupInfo);

  ProcessCreated := CreateProcess(nil, PChar(ProgramName), nil, nil, False,
    CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS, nil, PWideChar(ExtractFilePath(ProgramName)), StartupInfo,
    ProcessInfo);
  { Check whether to wait }
  if ProcessCreated then
  begin
    if Wait then
      WaitForSingleObject(ProcessInfo.hProcess, INFINITE)
    else
      // ShowMessage(Error: The ‘+ProgramName+’ could not execute!’);
  end;

  CloseHandle(ProcessInfo.hProcess);
  CloseHandle(ProcessInfo.hThread);
end;

function ParseName(str: string): TStringList;
// Toma un apellido compuesto y lo  transforma en una lista de apellidos
var
  i: Integer;
  aux: string;
  list: TStringList;
begin
  list := TStringList.Create;
  for i := 1 to (length(str)) do
  begin
    if (i = length(str)) and (aux = '') then
    begin
      aux := copy(str, i, 1);
      list.Add(aux)
    end
    else if ((str[i] = ' ') or (i = length(str))) and (aux <> '') then
    begin
      if (i = length(str)) then
        aux := aux + copy(str, i, 1);
      list.Add(aux);
      aux := '';
    end
    else if (str[i] <> ' ') then
      aux := aux + copy(str, i, 1);
  end;
  Result := list;
end;

function IsFucked(str: string): Integer;
var
  i: Integer;
const
  { Palabras comunes al principio del apellido }
  FuckWords: array [0 .. 15] of string =

    ('DE', 'LAS', 'LOS', 'DA', 'LA', 'DEL', 'VAN', 'VON', 'DER', 'MC', 'MAC',
    'JR', 'DI', 'AL', 'DOS', 'DO');

  { Palabras comunes al final del apellido }
  FuckAfterWords: array [0 .. 16] of string =

    ('JR', 'JUNIOR', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX',
    'X', 'XI', 'XII', 'XIII', 'XIV', 'XV');
begin
  { Itero verificando si el string coincide con alguna palabra en ambos casos }
  if length(str) = 1 then
    Result := 0
  else
  begin
    for i := low(FuckWords) to high(FuckWords) do
    begin
      if FuckWords[i] = str then
      begin
        Result := 0;
        exit;
      end;
    end;
    for i := low(FuckAfterWords) to high(FuckAfterWords) do
    begin
      if FuckAfterWords[i] = str then
      begin
        Result := 1;
        exit;
      end;
    end;
    Result := -1;
  end;
end;

procedure FixNames(name: string; var str1, str2: String);
var
  names: TStringList;
  lastFucked: Boolean;
  i: Integer;
begin
  lastFucked := TRUE;
  names := ParseName(name);
  for i := 0 to names.Count - 1 do
  begin
    if lastFucked then
    begin
      if i = 0 then
        str1 := names.Strings[i]
      else
        str1 := Trim(str1 + ' ' + names.Strings[i]);
      lastFucked := (IsFucked(names.Strings[i]) = 0);
    end
    else
    begin
      lastFucked := False;
      if (IsFucked(names.Strings[i]) = 1) then
        if (i = 0) then
          str1 := names.Strings[i]
        else
          str1 := Trim(str1 + ' ' + names.Strings[i])
      else if (i = 0) then
        str1 := names.Strings[i]
      else
        str2 := Trim(str2 + ' ' + names.Strings[i])
    end;
  end;
  freeAndNil(names);
end;

function DirTransac(idLOC, id: string): string;
begin
  Result := directorioArchivosEgate + normalizoDir(idLOC) + normalizoDir(id);
  ForceDirectories(Result);
end;

function leerInt(nom: string): Integer;
var
  st: TStringList;
begin
  st := TStringList.Create;
  try
    st.LoadFromFile(nom);
    Result := StrToInt(Trim(st.Text))
  finally
    st.Free;
  end;
end;

procedure grabarArchivoBat(nom: string; cont1, cont2, cont3, cont4,
  cont5: String);
var
  st: TStringList;
begin
  st := TStringList.Create;
  try
    if cont1 <> '' then
      st.Add(cont1);
    if cont2 <> '' then
      st.Add(cont2);
    if cont3 <> '' then
      st.Add(cont3);
    if cont4 <> '' then
      st.Add(cont4);
    if cont5 <> '' then
      st.Add(cont5);

    st.SaveToFile(nom);
  finally
    st.Free;
  end;
end;

procedure ConvertFileToFileBase64(const AInFileName, AOutFileName: string);
var
  inStream: TStream;
  outStream: TStream;
  base64: TBase64Encoding;
begin
  inStream := TFileStream.Create(AInFileName, fmOpenRead);
  try
    outStream := TFileStream.Create(AOutFileName, fmCreate);
    try

      base64 := TBase64Encoding.Create(0);
      // CharsPerLine = 0 means no line breaks
      try
        base64.Encode(inStream, outStream);;
      finally
        base64.Free;
      end;

    finally
      outStream.Free;
    end;
  finally
    inStream.Free;
  end;
end;

function ConvertFileToStrBase64(const AInFileName: string): AnsiString;
var
  inStream: TStream;
  outStream: TStringStream;
  base64: TBase64Encoding;
begin
  inStream := TFileStream.Create(AInFileName, fmOpenRead);
  try
    outStream := TStringStream.Create('');
    try

      base64 := TBase64Encoding.Create(0);
      // CharsPerLine = 0 means no line breaks
      try
        base64.Encode(inStream, outStream);;
      finally
        base64.Free;
      end;

      Result := outStream.DataString;
    finally
      outStream.Free;
    end;
  finally
    inStream.Free;
  end;
end;

function ByteArraytoStr(P: TByteDynArray): AnsiString;
var
  Buffer: AnsiString;
begin
  SetLength(Buffer, length(P));
  System.Move(P[0], Buffer[1], length(P));
  Result := Buffer;
end;

function strToByteArray(S: AnsiString): TByteDynArray;
begin
  SetLength(Result, length(S));
  System.Move(S[1], Result[0], length(S));
end;

procedure ConvertStrBase64ToFile(const base64: AnsiString;
  const FileName: string);
var
  stream: TBytesStream;
begin
  stream := TBytesStream.Create(TNetEncoding.base64.DecodeStringToBytes
    (base64));
  try
    stream.SaveToFile(FileName);
  finally
    stream.Free;
  end;
end;

function StreamToString(const stream: TStream;
  const Encoding: TEncoding): string;
var
  StringBytes: TBytes;
begin

  stream.Position := 0;
  SetLength(StringBytes, stream.Size);
  stream.ReadBuffer(StringBytes, stream.Size);
  Result := Encoding.GetString(StringBytes);
end;

function deltree(Dir: string): Boolean;
var
  FileSearch: TSearchRec;
begin
  Result := False;

  if Dir[length(Dir)] <> '\' then
    Dir := Dir + '\';

  if FindFirst(Dir + '*.*', faAnyFile, FileSearch) = 0 then
    repeat
      if ((FileSearch.Attr and fadirectory) = fadirectory) then
      begin
        if (FileSearch.name <> '.') and (FileSearch.name <> '..') then
          deltree(Dir + FileSearch.name);
      end
      else
      begin
        DeleteFile(Dir + FileSearch.name);
      end;
    until FindNext(FileSearch) <> 0;
  FindClose(FileSearch);

  sleep(100);
  Result := RemoveDir(Dir);

end;

function directorioArchivosEgate: string;
var
  ini: TIniFile;
begin
  if GLOBALConfigINI_directorioArchivosEgate='' then
  begin
    ini := TIniFile.Create(normalizoDir(ExtractFilePath(ParamStr(0))) +
      'config.ini');
    try
      GLOBALConfigINI_directorioArchivosEgate := normalizoDir(ini.ReadString('Egate', 'Directorio',
        normalizoDir(ExtractFilePath(ParamStr(0))) + 'info'));

    finally
      ini.Free;
    end;

    Result := GLOBALConfigINI_directorioArchivosEgate;

  end;

  Result := GLOBALConfigINI_directorioArchivosEgate;
end;

function nombreArchivoValido(aNombre: AnsiString): AnsiString;
var
  i: Integer;
  Car: AnsiChar;
  str: AnsiString;
begin
  str := '';
  for i := 1 to length(aNombre) do
  begin
    Car := UpCase(aNombre[i]);
    if Car = ' ' then
      Car := '_';

    if Car in ['0' .. '9', 'A' .. 'Z', '_'] then
      str := str + Car;
  end;
  Result := str;
end;

function Calcular_MD5(Cadena: string): string;
var
  hashMessageDigest5: TIdHashMessageDigest5;
  nuevaCad, nuevaCad2: AnsiString;
  i: Integer;
  listS: TStringList;
begin
  nuevaCad := UpperCase(Cadena);
  nuevaCad2 := '';

  for i := 1 to length(nuevaCad) do
    if nuevaCad[i] in ['A' .. 'Z', '0' .. '9'] then
      nuevaCad2 := nuevaCad2 + nuevaCad[i];

  { listS := TStringList.Create;
    try
    for i:=1 to Length(nuevaCad2) do
    listS.Add(nuevaCad2[i]);

    listS.Sort;
    nuevaCad2 := Trim(System.SysUtils.StringReplace(listS.Text,'#13#10',';',[rfReplaceAll]));
    finally
    listS.Free;
    end;
  }
  hashMessageDigest5 := nil;
  try
    hashMessageDigest5 := TIdHashMessageDigest5.Create;
    Result := IdGlobal.IndyLowerCase
      (hashMessageDigest5.HashStringAsHex(Trim(nuevaCad2)));
  finally
    hashMessageDigest5.Free;
  end;
end;

function normalizoDir(aDir: string): string;
begin
  Result := aDir;
  if aDir[length(aDir)] <> '\' then
    Result := aDir + '\';
end;

procedure ByteArrayToFIle(const ByteArray: TByteDynArray;
  const FileName: string);
var
  Count: Integer;
  F: file of Byte;
  pTemp: Pointer;
begin
  AssignFile(F, FileName);
  ReWrite(F);
  try
    Count := length(ByteArray);
    pTemp := @ByteArray[0];
    BlockWrite(F, pTemp^, Count);
  finally
    CloseFile(F);
  end;
end;

function FIleToByteArray(const FileName: string): TByteDynArray;
const
  BLOCK_SIZE = 1024;
var
  BytesRead, BytesToWrite, Count: Integer;
  F: file of Byte;
  pTemp: Pointer;
begin
  AssignFile(F, FileName);
  Reset(F);
  try
    Count := FileSize(F);
    SetLength(Result, Count);
    pTemp := @Result[0];
    BytesRead := BLOCK_SIZE;
    while (BytesRead = BLOCK_SIZE) do
    begin
      BytesToWrite := Min(Count, BLOCK_SIZE);
      BlockRead(F, pTemp^, BytesToWrite, BytesRead);
      pTemp := Pointer(LongInt(pTemp) + BLOCK_SIZE);
      Count := Count - BytesRead;
    end;
  finally
    CloseFile(F);
  end;
end;

procedure Jpeg2BmpOLD(const JpgFileName, BmpFileName: string); // helloacm.com
var
  Bmp: TBitmap;
  Jpg: TJPEGImage;
begin
  Bmp := TBitmap.Create;
  try
    Bmp.PixelFormat := pf32bit;
    Jpg := TJPEGImage.Create;
    try
      Jpg.LoadFromFile(JpgFileName);
      Bmp.Assign(Jpg);
      Bmp.SaveToFile(BmpFileName);
    finally
      Jpg.Free;
    end;
  finally
    Bmp.Free;
  end;
end;

procedure Jpeg2Bmp(const JpgFileName, BmpFileName: string); // helloacm.com
var
  Image1: TImage;
  Image_Data: TMemorystream;
  Jpg: TJPEGImage;
begin
  Jpg := TJPEGImage.Create;
  Image1 := TImage.Create(nil);
  Image_Data := TMemorystream.Create;
  try
    Image_Data.LoadFromFile(JpgFileName);
    Image_Data.Position := 0;
    Image1.Picture.Bitmap.LoadFromStream(Image_Data);
    Jpg.Assign(Image1.Picture.Bitmap);
    Jpg.SaveToFile(normalizoDir(ExtractFilePath(JpgFileName)) + 'tmpfoto2.jpg');
    Jpeg2BmpOLD(normalizoDir(ExtractFilePath(JpgFileName)) + 'tmpfoto2.jpg',
      BmpFileName);
    DeleteFile(normalizoDir(ExtractFilePath(JpgFileName)) + 'tmpfoto2.jpg');
  finally
    Image1.Free;
    Image_Data.Free;
    Jpg.Free;
  end;
end;

procedure Bmp2Jpeg(const BmpFileName, JpgFileName: string); // helloacm.com
var
  Bmp: TBitmap;
  Jpg: TJPEGImage;
begin
  Bmp := TBitmap.Create;
  Bmp.PixelFormat := pf32bit;
  Jpg := TJPEGImage.Create;
  try
    Bmp.LoadFromFile(BmpFileName);
    Jpg.Assign(Bmp);
    Jpg.SaveToFile(JpgFileName);
  finally
    Jpg.Free;
    Bmp.Free;
  end;
end;

function MakeYear4Digit(Year, Pivot: Integer): Integer;
var
  Century: Integer;
begin
  Assert(Pivot >= 0);

  { map 100 to zero }
  if Year = 100 then
    Year := 0;
  if Pivot = 100 then
    Pivot := 0;

  // turn 2 digit pivot to 4 digit
  if Pivot < 100 then
    Pivot := Pivot + 1900;

  { turn 2 digit years to 4 digits }
  if (Year >= 0) and (Year < 100) then
  begin
    Century := (Pivot div 100) * 100;

    Result := Year + Century; // give the result the same century as the pivot
    if Result < Pivot then
      // cannot be lower than the Pivot
      Result := Result + 100;
  end
  else
    Result := Year;
end;

function YYMMDDtoDate(YYMMDD: string): TDate;
var
  y, m, d: Word;
begin
  y := StrToInt(copy(YYMMDD, 1, 2));
  m := StrToInt(copy(YYMMDD, 3, 2));
  d := StrToInt(copy(YYMMDD, 5, 2));

  y := MakeYear4Digit(y, (YearOf(Now) mod 100) + 1);

  Result := EncodeDate(y, m, d);
end;

function YYMMDDtoDateSumo2000(YYMMDD: string): TDate;
var
  y, m, d: Word;
begin
  y := StrToInt(copy(YYMMDD, 1, 2));
  m := StrToInt(copy(YYMMDD, 3, 2));
  d := StrToInt(copy(YYMMDD, 5, 2));

  y := y + 2000;
  Result := EncodeDate(y, m, d);
end;

initialization
    LSGL:=TStringList.Create;
    LSGT:=TStringList.Create;
finalization
  LSGT.free;
  LSGL.free;
end.
