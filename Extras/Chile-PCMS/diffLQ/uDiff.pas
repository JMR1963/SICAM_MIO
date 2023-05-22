unit uDiff;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, Diff, ExtCtrls, Grids, Menus, ComCtrls;

type
  TFDiff2 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open11: TMenuItem;
    Open21: TMenuItem;
    N1: TMenuItem;
    mnuCompare: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    OpenDialog1: TOpenDialog;
    mnuCancel: TMenuItem;
    Panel1: TPanel;
    lblFile1: TLabel;
    lblFile2: TLabel;
    StatusBar1: TStatusBar;
    ResultGrid: TStringGrid;
    Options1: TMenuItem;
    mnuIgnoreCase: TMenuItem;
    mnuIgnoreWhiteSpace: TMenuItem;
    mnuView: TMenuItem;
    PreviousChanges1: TMenuItem;
    NextChanges1: TMenuItem;
    ExpoPpm: TPopupMenu;
    ExportarSiCAM1: TMenuItem;
    ExportarUruguay: TMenuItem;
    ExportarComparacion1: TMenuItem;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure Open11Click(Sender: TObject);
    procedure Open21Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mnuCancelClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ResultGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure mnuIgnoreCaseClick(Sender: TObject);
    procedure mnuIgnoreWhiteSpaceClick(Sender: TObject);
    procedure PreviousChanges1Click(Sender: TObject);
    procedure NextChanges1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ResultGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ResultGridDblClick(Sender: TObject);
    procedure ExportarSiCAM1Click(Sender: TObject);
    procedure ExportarComparacion1Click(Sender: TObject);
    procedure ExportarUruguayClick(Sender: TObject);
  private
    FC,FF:Integer;
    FTitulo:String;
    FExportar:TStringList;
    source1, source2: TStringList;
    result1, result2: TStringList;
    procedure Clear(left,right: boolean);
  public
    { Public declarations }
    RefCAPI:TObject;
    GTotal:Boolean;
    GIguales:Integer;
    GTitulo:String;
    function selCelda:String;
    procedure OpenFile1(const filename: string);
    procedure OpenFile2(const filename: string);
    procedure comparo(cantI:Integer;var s,a:Integer;total:Boolean;titulo:String);
    procedure InfoExportar(data:String);
  end;

//var
//  FDiff: TFDiff=nil;


implementation

uses ureacomodoArchivos;

{$R *.dfm}

procedure TFDiff2.FormCreate(Sender: TObject);
begin
  source1 := TStringList.Create;
  source2 := TStringList.Create;
  result1 := TStringList.Create;
  result2 := TStringList.Create;
  FExportar := TStringList.Create;
  ResultGrid.ColWidths[0] := 40;
  ResultGrid.ColWidths[2] := 40;
  ResultGrid.Canvas.Font := ResultGrid.Font;

end;
//------------------------------------------------------------------------------

procedure TFDiff2.FormActivate(Sender: TObject);
begin
//  if (paramcount > 0) then OpenFile1(paramstr(1));
//  if (paramcount > 1) then OpenFile2(paramstr(2));
//  mnuCompareClick(nil);
end;
//------------------------------------------------------------------------------

procedure TFDiff2.FormDestroy(Sender: TObject);
begin
  source1.Free;
  source2.Free;
  result1.Free;
  result2.Free;
  FExportar.Free;
end;
//------------------------------------------------------------------------------

procedure TFDiff2.Clear(left, right: boolean);
begin
  if left then
  begin
    source1.Clear;
    result1.Clear;
    lblFile1.Caption := '  ';
  end;
  if right then
  begin
    source2.Clear;
    result2.Clear;
    lblFile2.Caption := '  ';
  end;
  ResultGrid.RowCount := 0;
  StatusBar1.Panels[0].Text := '';
  StatusBar1.Panels[1].Text := '';
  StatusBar1.Panels[2].Text := '';
  StatusBar1.Panels[3].Text := '';
  mnuCompare.Enabled := false;
  mnuView.Enabled := false;
end;
//------------------------------------------------------------------------------

//Because it's SO MUCH EASIER AND FASTER comparing hashes (integers) than
//comparing whole lines of text, we'll build a list of hashes for each line
//in the source files. Each line is represented by a (virtually) unique
//hash that is based on the contents of that line. Also, since the
//likelihood of 2 different lines generating the same hash is so small,
//we can safely ignore that possibility.


//------------------------------------------------------------------------------

procedure TFDiff2.OpenFile1(const filename: string);
var
  i: integer;
begin
  if not fileExists(fileName) then exit;
  Clear(true,false);
  source1.Clear;
  source1.LoadFromFile(fileName);
  lblFile1.Caption := ' File1: ' + ExtractFileName(fileName);

  ResultGrid.RowCount := max(source1.Count, source2.Count);
  for i := 0 to 3 do ResultGrid.Cols[i].BeginUpdate;
  try
    for i := 0 to source1.Count -1 do
    begin
      ResultGrid.Cells[0,i] := inttostr(i+1);
      ResultGrid.Cells[1,i] := source1[i];
    end;
  finally
    for i := 0 to 3 do ResultGrid.Cols[i].EndUpdate;
  end;
end;
//------------------------------------------------------------------------------

procedure TFDiff2.OpenFile2(const filename: string);
var
  i: integer;
begin
  if not fileExists(fileName) then exit;
  Clear(false,true);
  source2.Clear;
  source2.LoadFromFile(fileName);
  lblFile2.Caption := ' File2: ' + ExtractFileName(fileName);

  ResultGrid.RowCount := max(source1.Count, source2.Count);
  for i := 0 to 3 do ResultGrid.Cols[i].BeginUpdate;
  try
    for i := 0 to source2.Count -1 do
    begin
      ResultGrid.Cells[2,i] := inttostr(i+1);
      ResultGrid.Cells[3,i] := source2[i];
    end;
  finally
    for i := 0 to 3 do ResultGrid.Cols[i].EndUpdate;
  end;
end;
//------------------------------------------------------------------------------

procedure TFDiff2.Open11Click(Sender: TObject);
begin
  if OpenDialog1.Execute then OpenFile1(OpenDialog1.FileName);
end;
//------------------------------------------------------------------------------

procedure TFDiff2.Open21Click(Sender: TObject);
begin
  if OpenDialog1.Execute then OpenFile2(OpenDialog1.FileName);
end;
//------------------------------------------------------------------------------

procedure TFDiff2.comparo(cantI: Integer;var s,a:Integer;total:Boolean;titulo:String);
var
  i,oldIndex1,oldIndex2: integer;
  deletes,adds,modifies,matches:Integer;
begin
  deletes:=0;
  adds:=0;
  modifies:=0;
  matches:=0;

  GTotal:=False;
  GIguales:=cantI;
  GTitulo := titulo;

  mnuCancel.Enabled := true;
  screen.Cursor := crHourGlass;
  try
    oldIndex1:=0;
    oldIndex2:=0;

    s := source1.Count;
    a := source2.Count;

    agregarEspacios(source1,source2,11);

    ResultGrid.RowCount := source1.Count;

    //now fill ResultGrid with the differences ...
    for i := 0 to 3 do
    begin
      ResultGrid.Cols[i].BeginUpdate;
      ResultGrid.Cols[i].Clear;
    end;
    try
      for i := 0 to ResultGrid.RowCount-1 do
        with ResultGrid do
        begin
          if i<source1.Count then
            if source1[i]='' then
            begin
              Cells[0,i] := '';
              Cells[1,i] := '';
              deletes := deletes +1;
            end;

          if i<source2.Count then
            if source2[i]='' then
            begin
              Cells[2,i] := '';
              Cells[3,i] :='';
              adds := adds + 1;
            end;

         if i<source1.Count then
            if source1[i]<>'' then
            begin
              oldIndex1 := oldIndex1 + 1;
              Cells[0,i] := inttostr(oldIndex1);
              Cells[1,i] := source1[i];
            end;

          if i<source2.Count then
            if source2[i]<>'' then
            begin
              oldIndex2 := oldIndex2 + 1;
              Cells[2,i] := inttostr(oldIndex2);
              Cells[3,i] := source2[i];
            end;


          if i<source1.Count then
            if i<source2.Count then
              if source1[i]<>'' then
                if source2[i]<>'' then
                begin
                   if GTotal then
                   begin
                    if comp(source1[i],source2[i],GIguales) then
                      matches := matches + 1
                    else
                      modifies := modifies + 1;
                   end else begin
                    if source1[i]=source2[i] then
                      matches := matches + 1
                    else
                      modifies := modifies + 1;
                   end;
                end;


        end;
    finally
      for i := 0 to 3 do ResultGrid.Cols[i].EndUpdate;
    end;

      StatusBar1.Panels[0].Text := ' Iguales: ' + inttostr(matches);
      StatusBar1.Panels[1].Text := ' Distintos: ' + inttostr(modifies);
      StatusBar1.Panels[2].Text := ' Faltantes: ' + inttostr(deletes);
      StatusBar1.Panels[3].Text := ' Sobrantes: ' + inttostr(adds);


  finally
    screen.Cursor := crDefault;
    mnuCancel.Enabled := false;
  end;
  mnuView.Enabled := true;

end;

procedure TFDiff2.Exit1Click(Sender: TObject);
begin
  close;
end;

procedure TFDiff2.ExportarUruguayClick(Sender: TObject);
var
  i:integer;
begin
  if source2.Count=0 then Exit;

  SaveDialog1.FileName := 'ATSG-'+GTitulo;

  if SaveDialog1.Execute then
  begin
    FExportar.Clear;
    for I := 0 to source2.Count-1 do
      InfoExportar(source2[I]);

      FExportar.SaveToFile(ChangeFileExt(SaveDialog1.FileName,'.csv'));
  end;
end;

procedure TFDiff2.ExportarComparacion1Click(Sender: TObject);
var
  linea:String;
  RowCount, ColCount, i, j: Integer;
  SepS1,SepS2:Integer;

  function cantSep(str:String):Integer;
  var
    i:integer;
  begin
    Result := 0;
    for I := 1 to Length(Str) do
      if str[I]='|' then
      begin
        Result := Result + 1;
      end;
  end;

  function SepExtra(cant:Integer):String;
  var
    i :Integer;
  begin
    Result := '';
    for I := 1 to cant do
      Result := Result + ' | ';
  end;

begin
  {create variant array where we'll copy our data}
  RowCount := ResultGrid.RowCount;
  ColCount := ResultGrid.ColCount;
  {fill array}
  SaveDialog1.FileName := 'Comparacion-'+GTitulo;

  if SaveDialog1.Execute then
  begin
    FExportar.Clear;

    for i := 0 to RowCount-1 do
    begin
      linea := '';

      SepS1:= cantSep(source1[I]);
      SepS2:= cantSep(source2[I]);

      for j := 0 to ColCount-1 do
      begin
        linea := linea + ResultGrid.Cells[j, i] + ' | ';
      end;

      linea := linea + '>';
      linea := StringReplace(linea,' | >','',[rfReplaceAll]);

      if SepS1=0 then
      begin
        linea:= SepExtra(SepS2)+ linea;
      end;

      if SepS2=0 then
      begin
        linea:=linea+ SepExtra(SepS1);
      end;

      InfoExportar(linea);
    end;

    FExportar.SaveToFile(ChangeFileExt(SaveDialog1.FileName,'.csv'));
  end;
end;

procedure TFDiff2.ExportarSiCAM1Click(Sender: TObject);
var
  i:integer;
begin
  if source1.Count=0 then Exit;

  SaveDialog1.FileName := 'Sicam-'+GTitulo;

  if SaveDialog1.Execute then
  begin
    FExportar.Clear;
    for I := 0 to source1.Count-1 do
      InfoExportar(source1[I]);

      FExportar.SaveToFile(ChangeFileExt(SaveDialog1.FileName,'.csv'));
  end;

end;

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------

procedure TFDiff2.mnuCancelClick(Sender: TObject);
begin

end;
//------------------------------------------------------------------------------

procedure TFDiff2.FormResize(Sender: TObject);
var
  i: integer;
begin
  with ResultGrid do
  begin
    i := (ClientWidth -80) div 2;
    ResultGrid.ColWidths[1] := i;
    ResultGrid.ColWidths[3] := i;
  end;
  lblFile2.Left := Panel1.ClientWidth div 2;
end;

procedure TFDiff2.InfoExportar(data: String);
begin
  if trim(data)<>'' then
    FExportar.Add(StringReplace(data,'|',';',[rfReplaceAll]));
end;

//------------------------------------------------------------------------------

procedure AddCharToStr(var s: string; c: char; kind, lastkind: TChangeKind);
begin
  if (Kind = lastKind) then s := s + c
  else
  case kind of
    ckNone: s := s + '<BC:------>' + c;
    else s := s + '<BC:33FFFF>' + c;
  end;
end;
//------------------------------------------------------------------------------

procedure TFDiff2.ResultGridDblClick(Sender: TObject);
begin
//
end;

procedure TFDiff2.ResultGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
const
  PaleGreen: TColor = $AAFFAA;
  PaleRed  : TColor = $AAAAFF;
  PaleBlue : TColor = $FFAAAA;
var
  clr: Tcolor;
  i:integer;
begin

  i := ARow;
  if (ResultGrid.RowCount <> 0) then clr := clWhite else clr := clBtnFace;
  if (ACol in [1,3]) then
  begin
    if i<source1.Count then
      if source1[i]='' then
      begin
        clr := PaleRed;
      end;

    if i<source2.Count then
      if source2[i]='' then
      begin
        clr := PaleBlue;
      end;

    if (i<source1.Count)and(i<source2.Count) then
      if (source1[i]<>'')and(source2[i]<>'') then
      begin
        if GTotal then
        begin
          if source1[i]<>source2[i] then
          begin
            clr := PaleGreen
          end;
        end
        else
        begin
          if not comp(source1[i],source2[i],GIguales) then
          begin
            clr := PaleGreen
          end;
        end;
      end;
  end;


  with ResultGrid.Canvas do
  begin
    Brush.Color := clr;
    FillRect(Rect);
    TextRect(Rect, Rect.Left+3,Rect.Top+2, ResultGrid.Cells[ACol,ARow]);


    //now just some fancy coloring ...
    if (ACol in [0,2]) then
    begin
      Pen.Color := clWhite;
      MoveTo(Rect.Right-1,0);
      LineTo(Rect.Right-1,Rect.Bottom);
    end else
    begin
      if (ACol = 1) then
      begin
        Pen.Color := $333333;
        MoveTo(Rect.Right-1,0);
        LineTo(Rect.Right-1,Rect.Bottom);
      end;
      Pen.Color := clSilver;
      MoveTo(Rect.Left,0);
      LineTo(Rect.Left,Rect.Bottom);
    end;
    //finally, draw the focusRect ...
    if (gdSelected in State) then
    begin
      rect.Left := 0;
      DrawFocusRect(Rect);
    end;
  end;
end;

procedure TFDiff2.ResultGridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  FC := ACol;
  FF := ARow;
end;

function TFDiff2.selCelda: String;
var
  st:TStringList;
begin
  Result := '';

  if FC in [1,3] then
  begin
    Result := ResultGrid.Cells[FC,FF];

    if Result='' then Exit;

    st:=TStringList.Create;
    try
      st.Text := StringReplace(Result,'|',#13#10,[rfReplaceAll]);
      Result := Trim(st.Strings[0])+'-'+Trim(st.Strings[1])+'-'+Trim(st.Strings[3]);
    finally
      st.Free;
    end;

  end;

end;

//------------------------------------------------------------------------------

procedure TFDiff2.mnuIgnoreCaseClick(Sender: TObject);
begin
end;
//------------------------------------------------------------------------------

procedure TFDiff2.mnuIgnoreWhiteSpaceClick(Sender: TObject);
begin
end;
//------------------------------------------------------------------------------

function GridRect(Coord1, Coord2: TGridCoord): TGridRect;
begin
  with Result do
  begin
    Left := Coord2.X;
    if Coord1.X < Coord2.X then Left := Coord1.X;
    Right := Coord1.X;
    if Coord1.X < Coord2.X then Right := Coord2.X;
    Top := Coord2.Y;
    if Coord1.Y < Coord2.Y then Top := Coord1.Y;
    Bottom := Coord1.Y;
    if Coord1.Y < Coord2.Y then Bottom := Coord2.Y;
  end;
end;
//------------------------------------------------------------------------------

procedure TFDiff2.PreviousChanges1Click(Sender: TObject);
var
  row: integer;
  Kind: TChangeKind;
begin
  row := ResultGrid.Selection.Top;
{  if row = 0 then exit;
  Kind := Diff.Compares[row].Kind;
  while (row > 0) and (Diff.Compares[row].Kind = Kind) do dec(row);
  if Diff.Compares[row].Kind = ckNone then
  begin
    Kind := ckNone;
    while (row > 0) and
      (Diff.Compares[row].Kind = Kind) do dec(row);
  end;
  ResultGrid.Selection := TGridRect(Rect(0, row, 3, row));
  If row < ResultGrid.TopRow then
    ResultGrid.TopRow := Max(0, row - ResultGrid.VisibleRowCount +1);}
end;
//------------------------------------------------------------------------------

procedure TFDiff2.NextChanges1Click(Sender: TObject);
var
  row: integer;
  Kind: TChangeKind;
begin
  row := ResultGrid.Selection.Top;
{  if row = ResultGrid.RowCount -1 then exit;
  Kind := Diff.Compares[row].Kind;
  while (row < ResultGrid.RowCount -1) and
    (Diff.Compares[row].Kind = Kind) do inc(row);
  if Diff.Compares[row].Kind = ckNone then
  begin
    Kind := ckNone;
    while (row < ResultGrid.RowCount -1) and
      (Diff.Compares[row].Kind = Kind) do inc(row);
  end;
  ResultGrid.Selection := TGridRect(Rect(0, row, 3, row));
  if row > ResultGrid.TopRow + ResultGrid.VisibleRowCount -1 then
    ResultGrid.TopRow :=
      max(0,min(row, ResultGrid.RowCount - ResultGrid.VisibleRowCount));}
end;
//------------------------------------------------------------------------------

end.
