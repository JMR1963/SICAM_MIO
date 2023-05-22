unit ureacomodoArchivos;

interface

uses Classes;

procedure reacomodoArchivos(a1,a2:String);
function comp(s1,s2:string;cantMach:Integer):Boolean;
procedure agregarEspacios(l1, l2: TStringList;CantMach:Integer);
procedure agregarEspacios2(l1, l2: TStringList;CantMach:Integer);

implementation

uses dialogs;


  function comp(s1,s2:string;cantMach:Integer):Boolean;
  var
    i:integer;
  begin
  {  if (s1='')and(s2<>'') then begin
      Result := true;
      Exit;
    end;

    if (s2='')and(s1<>'') then begin
      Result := true;
      Exit;
    end;
   }

  // ShowMessage(s1+' - '+s2);


    if (s2=s1) then begin
      Result := True;
      Exit;
    end;

    Result := True;
    for i:=1 to cantMach do
    begin
      Result := Result and (s1[i]=s2[i]);
    end;
  end;

  function recorroLS(str:String;Ls:TStringList;cantMach:Integer):Boolean;
  var
    i:Integer;
  begin
    Result := False;
    for i:=0 to Ls.Count-1 do begin
      if comp(str,Ls.Strings[i],cantMach) then begin
        Result := true;
        Exit;
      end;
    end;
  end;


  procedure agregoFaltantes(l1,l2:TStringList;CantMach:Integer);
  var
    i:Integer;
  begin
    for I := 0 to l1.Count-1 do begin
      if not recorroLS(l1.Strings[i],l2,CantMach) then
        l2.Add(l1.Strings[i]+'        ******');
    end;
  end;

  procedure sacoAsteriscos(l1:TStringList);
  var
    i:Integer;
  begin
    for I := 0 to l1.Count-1 do begin
      if pos('***',l1.Strings[i])<>0 then
        l1.Strings[i] := '';
    end;
  end;

  procedure acomodo(l1,l2,nl1,nl2:TStringList);
  var
    i:integer;
  begin
    i:=0;
    while true do


    if True then



  end;


procedure agregarEspacios2(l1, l2: TStringList;CantMach:Integer);
begin
  agregoFaltantes(l2,l1,CantMach);
  agregoFaltantes(l1,l2,CantMach);


  l1.Sort;
  l2.Sort;

  l1.Sorted := false;
  l2.Sorted := false;

  sacoAsteriscos(l1);
  sacoAsteriscos(l2);

end;


procedure agregarEspacios(l1, l2: TStringList;CantMach:Integer);
var
  i,j:Integer;
  nl1, nl2: TStringList;
begin
  l1.Sort;
  l2.Sort;

  i:=0;
  j:=0;
  nl1:=TStringList.Create;
  nl2:=TStringList.Create;


  while (i<l1.Count)and(j<l2.Count) do
  begin
    if comp(l1[i],l2[j],CantMach) then
    begin
      nl1.Add(l1[i]);
      nl2.Add(l2[j]);
      i:=i+1;
      j:=j+1;
    end else
    if l1[i]<l2[j] then
    begin
      nl1.Add(l1[i]);
      nl2.Add('');
      i:=i+1;
    end else
    if l1[i]>l2[j] then
    begin
      nl1.Add('');
      nl2.Add(l2[j]);
      j:=j+1;
    end;
  end;

    while (i<l1.Count) do
    begin
      nl1.Add(l1[i]);
      nl2.Add('');
      i:=i+1;
    end;

    while (j<l2.Count) do
    begin
      nl1.Add('');
      nl2.Add(l2[j]);
      j:=j+1;
    end;

  l1.Text := nl1.Text;
  l2.Text := nl2.Text;
end;



procedure reacomodoArchivos(a1,a2:String);
var
  l1,l2:TStringList;
begin
    l1:=TStringList.Create;
    l2:=TStringList.Create;
    try
      l1.LoadFromFile(a1);
      l2.LoadFromFile(a2);
      agregarEspacios(l1,l2,11);
      l1.SaveToFile(a1);
      l2.SaveToFile(a2);
    finally
      l1.Free;
      l2.Free;
    end;

end;

end.
