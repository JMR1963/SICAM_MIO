unit uDMDespachos;
interface
uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBCustomDataSet, IBX.IBQuery, IBX.IBDatabase,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,vcl.Dialogs,vcl.Controls;
type
  TDMDespachos = class(TDataModule)
    bdMain: TIBDatabase;
    trnMain: TIBTransaction;
    qryTran: TIBQuery;
    qryTranRVEHICULOFECHACTIVACION: TDateTimeField;
    qryTranRVEHICULOPATENTE: TIBStringField;
    qryTranRGNANACIONALIDAD: TIBStringField;
    qryTranCANT: TIntegerField;
    bdMainNew: TFDConnection;
    trnMainNew: TFDTransaction;
    qryTranNew: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    SicamTranDB:String;
    { Private declarations }
    procedure inicializar;
  public
    { Public declarations }
    function consultarVehiculosSicam(FINI,FFIN:AnsiString):AnsiString;
    function DESPACHOSxmlToLs(aXML:AnsiString):AnsiString;
    function FALTANTESxmlToLs(aXML:AnsiString):AnsiString;
    function DifLsALsB(sLSA,sLSB:AnsiString):AnsiString;
  end;
var
  DMDespachos: TDMDespachos;
implementation
{$R *.dfm}
uses Windows,IniFiles,Variants,xmldom, XMLIntf, msxmldom, XMLDoc,ShellAPI,DateUtils;
{ TDMDespachos }
procedure TDMDespachos.DataModuleCreate(Sender: TObject);
begin
  inicializar;
end;
procedure TDMDespachos.inicializar;
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
  sL:TStringList;
begin
  bdMain.Connected := False;
  
  inifile := TIniFile.Create(Format('%sSICAM7.ini', [ExtractFilePath(GetWSDir)]));
  try
    SicamTranDB := inifile.ReadString('Data Base', 'basedatosact', 'svdesarrollo10:c:\Basedatos\transitos.gdb');
  finally
    inifile.Free;
  end;
  if FileExists((Format('%sdespachos.qry', [ExtractFilePath(GetWSDir)]))) then
  begin
    sL:=TStringList.Create;
    try
      sL.LoadFromFile(Format('%sdespachos.qry', [ExtractFilePath(GetWSDir)]));
      qryTran.SQL.Text := sL.Text;
    finally
      sL.Free;
    end;
  end;
   if MessageDlg('Mensaje Nueva Compilacion en D11, quiere conectarse a Interbase ? ', mtInformation,[mbYes,mbNo], 0, mbNo)=mrYes then
   begin
     // nombre teorico de la DB en interbase "svdesarrollo10:c:\Basedatos\transitos.gdb"
     bdMain.ServerType  :=  'IBServer';
     bdMain.DatabaseName:= SicamTranDB;
     bdMain.Open;
   end;
end;
procedure StartTransaction( Trn : TIBTransaction );
{
  Comienza una transacción si la misma no se encuentra ya en progreso.
}
begin
  if not Trn.InTransaction then
    Trn.StartTransaction;
end;
procedure Commit(trn : TIBTransaction);
begin
  if trn.InTransaction then
    trn.Commit;
end;
procedure Rollback(trn : TIBTransaction);
begin
  // Generalmente la parte del commit de una transacción se pone dentro de un try ... except. No pasa lo
  // mismo con el rollback. El rollback se pone entre el except ... end del bloque. Por lo tanto si se
  // produce una excepción antes del rollback, la misma no será trapeada. Por esta razón el try ... except
  // del rollback está dentro de esta función.
  try
    if trn.InTransaction then
      trn.Rollback;
  except
  end;
end;
function SacoStrEntreTag(s,tagI,TagF:String):String;
var
  str,str2:String;
  hIni,hFin:Integer;
begin
  str2 := s;
  str := LowerCase(s);
  tagI := LowerCase(tagI);
  tagF := LowerCase(tagF);
  hIni := pos(tagI,str);
  if hIni<>0 then
  begin
    hFin := pos(tagF,str);
    if (hFin <> 0)and(hFin>hIni) then begin
      Delete(str2,hIni,hFin+length(tagF)-hIni);
    end;
  end;
  result := str2;
end;
function normalizoDir(aDir: String): String;
begin
  Result := aDir;
  if aDir[Length(aDir)]<>'\' then
    Result := aDir+'\';
end;
function TDMDespachos.DESPACHOSxmlToLs(aXML:AnsiString):AnsiString;
var
  DOC:IXMLDocument;
  i,a:integer;
  ROW:IXMLNode;
  str:String;
begin
  DOC := LoadXMLData(aXML);
  str := '';
  for i := 1 to DOC.ChildNodes.Nodes['DESPACHOS'].ChildNodes.Count-1 do
  begin
    ROW := DOC.ChildNodes.Nodes['DESPACHOS'].ChildNodes.Nodes[i];
    if Assigned(ROW)and(ROW.NodeName = 'ROW') then
    begin
      for a := 0 to ROW.AttributeNodes.Count-1 do
      begin
        if ROW.AttributeNodes.Nodes[a].NodeName='IMT' then
        try
          str := str + Format('%-10s', [ROW.AttributeNodes.Nodes[a].NodeValue])+'|';
          Continue;
        except
          Continue;
        end;
        if ROW.AttributeNodes.Nodes[a].NodeName='PMT' then
        try
          str := str + Format('%-5s', [ROW.AttributeNodes.Nodes[a].NodeValue])+'|';
          Continue;
        except
          Continue;
        end;

        if ROW.AttributeNodes.Nodes[a].NodeName='PAX' then
        try
          str := str + Format('%-4s', [ROW.AttributeNodes.Nodes[a].NodeValue])+'|';
          Continue;
        except
          Continue;
        end;
      end;
    end;
    str := str + '#';
  end;
  Result := str;
end;

function aaaammdd(aStr:String):TDateTime;
begin
  Result := EncodeDate(
              StrToInt(copy(aStr,1,4)),
              StrToInt(copy(aStr,5,2)),
              StrToInt(copy(aStr,7,2)));
end;

function TDMDespachos.consultarVehiculosSicam(FINI,FFIN:AnsiString): AnsiString;
var
  str:String;
begin
  //bdMain.Open;
  try
    Result := '';
    with qryTran do
      try
        StartTransaction(Transaction);
        Close;
        ParamByName('FINI').Value := aaaammdd(FINI)+EncodeTime(00,00,00,00);
        ParamByName('FFIN').Value := aaaammdd(FFIN)+EncodeTime(23,59,59,59);
        Open;
        str := '<DESPACHOS>';
        str := str + '<HDR FINI="'+FINI+'" FFIN="'+FFIN+'" />';
        while not eof do
        begin
          str := str + '<ROW IMT="'+fieldByName('RVEHICULOPATENTE').AsString+
                       '" PMT="'+fieldByName('RGNANACIONALIDAD').AsString+
                       '" FHT="'+FormatDateTime('YYYYMMDDhhmmss',fieldByName('RVEHICULOFECHACTIVACION').AsDateTime)+
                       '" PAX="'+fieldByName('cant').AsString+'" />';
          next;
        end;
        str := str + '</DESPACHOS>';
        Commit(Transaction);
        Result := str;
      except
        Rollback(Transaction);
      end;
  finally
    bdMain.Close;
  end;
end;

function TDMDespachos.FALTANTESxmlToLs(aXML:AnsiString):AnsiString;
var
  DOC:IXMLDocument;
  i,a:integer;
  ROW:IXMLNode;
  str:String;
begin
  DOC := LoadXMLData(aXML);
  str := '';
  for i := 1 to DOC.ChildNodes.Nodes['FALTANTES'].ChildNodes.Count-1 do
  begin
    ROW := DOC.ChildNodes.Nodes['FALTANTES'].ChildNodes.Nodes[i];
    if Assigned(ROW)and(ROW.NodeName = 'ROW') then
    begin
      for a := 0 to ROW.AttributeNodes.Count-1 do
      begin
        if ROW.AttributeNodes.Nodes[a].NodeName='IMT' then
        try
          str := str + ROW.AttributeNodes.Nodes[a].NodeValue+'|';
          Continue;
        except
          Continue;
        end;
        if ROW.AttributeNodes.Nodes[a].NodeName='PMT' then
        try
          str := str + ROW.AttributeNodes.Nodes[a].NodeValue+'|';
          Continue;
        except
          Continue;
        end;
        if ROW.AttributeNodes.Nodes[a].NodeName='FHT' then
        try
          str := str + ROW.AttributeNodes.Nodes[a].NodeValue+'|';
          Continue;
        except
          Continue;
        end;
      end;
    end;
    str := str + '#';
  end;
  Result := str;
end;

function TDMDespachos.DifLsALsB(sLSA, sLSB: AnsiString):AnsiString;
var
  lsA,lsB, par: TStringList;
  a,b:Integer;
  str,xml:String;
begin
  lsA := TStringList.Create;
  lsB := TStringList.Create;
  xml := '<FALTANTES>';
  try
    lsA.Text := StringReplace(sLSA,'#',#13#10,[rfReplaceAll]);
    lsB.Text := StringReplace(sLSB,'#',#13#10,[rfReplaceAll]);
    lsB.Sort;
    for a:=0 to lsA.Count-1 do
    begin
      str := lsA.Strings[a];
      if lsB.IndexOf(str)=-1 then
      begin
        par := TStringList.Create;
        try
          par.Text := StringReplace(str,'|',#13#10,[rfReplaceAll]);
          xml := xml + '<ROW IMT="'+par.Strings[0]+'" ';
          xml := xml + ' PMT="'+par.Strings[1]+'" ';
          xml := xml + ' FHT="'+par.Strings[2]+'" />';
        finally
          par.Free;
        end;
      end;
    end;
    xml := xml + '</FALTANTES>';
    Result := xml;
  finally
    lsA.Free;
    lsB.Free;
  end;
end;
end.
<HDR FINI="20160901" FFIN="20160926" /><ROW IMT="FXYZ33" PMT="CHL" FHT="20160901102023" PAX="1" /></DESPACHOS>
> <FALTANTES>
>   <ROW IMT="identificacion medio transporte"
>        PMT="pais medio transporte"
>        FHT="fecha hora transito (yyyymmddhhmiss)" />
>   ...
> </FALTANTES>
>
> Ejemplo:
>
> <FALTANTES><ROW IMT="BXRT21" PMT="CHL" FHT="20160905152734" /></FALTA>
> NTES>
