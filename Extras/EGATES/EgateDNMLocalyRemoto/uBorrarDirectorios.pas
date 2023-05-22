unit uBorrarDirectorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFmBorroCarpetas = class(TForm)
    mmoIDLOC: TMemo;
    mmoLisD: TMemo;
    btn1: TButton;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FMin:Integer;
    FMinExta:Integer;
    FHora:Integer;

    Img2:string;
    Img3:string;
    borroTXT1,
    borroTXT2,
    borroXML1,
    borroXML2,
    borroLOG1:String;


  public
    { Public declarations }
    function getListCreatedDirectory(const APath: string): Boolean;
    procedure recorroYBorro;
    function directorioArchivosEgate: string;
  end;

var
  FmBorroCarpetas: TFmBorroCarpetas;

implementation

{$R *.dfm}

uses System.IniFiles,System.DateUtils;

var
  GLOBALConfigINI_directorioArchivosEgate:String = '';

function normalizoDir(aDir: string): string;
begin
  Result := aDir;
  if aDir[length(aDir)] <> '\' then
    Result := aDir + '\';
end;


function TFmBorroCarpetas.directorioArchivosEgate: string;
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



      mmoIDLOC.Lines.Text := StringReplace(ini.ReadString('Egate', 'IDLOC','LOCAL'),';',#13#10,[rfReplaceAll]);
      Img2 := ini.ReadString('Egate', 'Directorio2','');
      Img3 := ini.ReadString('Egate', 'Directorio3','');
      borroTXT1 := ini.ReadString('Extra', 'DirectorioTXT1', '');
      borroTXT2 := ini.ReadString('Extra', 'DirectorioTXT2', '');
      borroXML1 := ini.ReadString('Extra', 'DirectorioXML1', '');
      borroXML2 := ini.ReadString('Extra', 'DirectorioXML2', '');
      borroLOG1 := ini.ReadString('Extra', 'DirectorioLOG1', '');
      FMinExta := ini.ReadInteger('Extra', 'Min',24*60*31);

      FMin := ini.ReadInteger('Egate', 'Min',60*5);
      FHora := ini.ReadInteger('Egate', 'Hora',-1);
    finally
      ini.Free;
    end;

    Result := GLOBALConfigINI_directorioArchivosEgate;


  end;

  Result := GLOBALConfigINI_directorioArchivosEgate;
end;




function FileTimeToDateTime(Value: TFileTime): TDateTime;
var
  Tmp: Integer;
begin
  FileTimeToDosDateTime(Value, LongRec(Tmp).Hi, LongRec(Tmp).Lo);
  Result := FileDateToDateTime(Tmp);
end;

procedure TFmBorroCarpetas.btn1Click(Sender: TObject);
begin
//recorroYBorro;
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

    WriteLn(myFile, FormatDateTime('YYYYMMDDhhmmss', Now) + '-' + Error);

    CloseFile(myFile);
  except
  end;
end;


procedure TFmBorroCarpetas.FormCreate(Sender: TObject);
begin
  try
    recorroYBorro; // getListCreatedDirectory('C:\LOCALNECFACE64\info\LOCAL\');
    //Halt(0);
    Application.Terminate;
  except
    on e:exception do begin
      grabarEnArchivoLog(e.Message);
      Application.Terminate;
    end;
  end;
  Application.Terminate;
end;

function TFmBorroCarpetas.getListCreatedDirectory(const APath: string): Boolean;
var
  res: TSearchRec;
  lastCreatedFileTime: TFileTime;
begin
  mmoLisD.Clear;
  Result := False;

  if not DirectoryExists(APath) then
    Exit;

  grabarEnArchivoLog('E1'+APath);
  FillChar(lastCreatedFileTime, SizeOf(TFileTime), 0);

  if FindFirst(APath + '*.*', faDirectory, res) = 0 then
  begin
    try
      repeat
        if (res.Attr and faDirectory) = 0 then
          Continue;

        if (res.Name = '.') or (res.Name = '..') then
          Continue;


        lastCreatedFileTime := res.FindData.ftCreationTime;
        if MinutesBetween(now,FileTimeToDateTime(lastCreatedFileTime))>FMin then
        begin
          Result := True;
          mmoLisD.Lines.Add(ExtractFilePath(APath) + res.Name);
        end;

      until FindNext(res) <> 0;
    finally
      System.SysUtils.FindClose(res);
    end;
  end;
end;


procedure BorroDir(const Dir: String;mascara:String);
var
  sDir: String;
  Rec: TSearchRec;
begin
  sDir := IncludeTrailingPathDelimiter(Dir);
  if FindFirst(sDir + '*.*', faAnyFile, Rec) = 0 then
  try
    repeat
      if (Rec.Attr and faDirectory) = faDirectory then
      begin
        if (Rec.Name <> '.') and (Rec.Name <> '..') then
          BorroDir(sDir + Rec.Name,mascara);
      end else
      begin
        //DeleteFile(sDir + Rec.Name);
        if (ExtractFileExt(mascara).ToUpper=ExtractFileExt(sDir + Rec.Name).ToUpper)or(mascara='*.*') then
        begin
          DeleteFile(sDir + Rec.Name);
          grabarEnArchivoLog('DeleteFile:'+sDir + Rec.Name);
        end;
      end;
    until FindNext(Rec) <> 0;
  finally
    FindClose(Rec);
  end;
  RemoveDir(sDir);
end;


procedure TFmBorroCarpetas.recorroYBorro;


  function recorroYBorro(aDir,mascara:string):Boolean;
  begin
    Result := False;
    if Trim(aDir)='' then Exit;



    if DirectoryExists(aDir) then
    begin
    grabarEnArchivoLog('E'+aDir);
      if getListCreatedDirectory(normalizoDir(aDir)) then
        for var d := 0 to mmoLisD.Lines.Count-1 do begin
            grabarEnArchivoLog(mmoLisD.Lines[d]);
          BorroDir(mmoLisD.Lines[d],mascara);
          grabarEnArchivoLog(mmoLisD.Lines[d]);
          Result := True;
        end;
      //aaaa
    end;
  end;

  procedure dirIMG(direc:string);
  var
    h,m,s,ms:Word;
    i,d:Integer;
  begin

  grabarEnArchivoLog(direc);

  if direc.Trim.IsEmpty then
    Exit;

  DecodeTime(Now,h,m,s,ms);

  //if FHora<>-10 then
  //  if FHora<>h then Exit;

  for I := 0 to mmoIDLOC.Lines.Count-1 do
  begin
    if DirectoryExists(direc+mmoIDLOC.Lines[i]) then
    begin
      if getListCreatedDirectory(normalizoDir(direc+mmoIDLOC.Lines[i])) then
        for d := 0 to mmoLisD.Lines.Count-1 do begin
          BorroDir(mmoLisD.Lines[d],'*.*');
          grabarEnArchivoLog(mmoLisD.Lines[d]);

         // ShowMessage(mmoLisD.Lines[d]);
        end;
      //aaaa
    end;
  end;

  end;



var

  direc:string;
begin
  direc := directorioArchivosEgate;

  if FHora=-1 then Exit;

  dirIMG(direc);
  dirIMG(Img2);
  dirIMG(Img3);

  recorroYBorro(borroTXT2,'*.txt');
  recorroYBorro(borroXML2,'*.xml');
  recorroYBorro(borroLOG1,'*.log');

  FMin :=FMinExta;
  recorroYBorro(borroTXT1,'*.txt');
  recorroYBorro(borroXML1,'*.xml');



end;

procedure TFmBorroCarpetas.Timer1Timer(Sender: TObject);
begin
  Application.Terminate;
end;

end.


