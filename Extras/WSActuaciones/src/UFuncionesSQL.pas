unit UFuncionesSQL;

interface
uses
  SysUtils, Classes, DB, MemDS, DBAccess, Ora, Variants;


function FieldsToXml (rootName: string; OraQuery:TOraQuery): WideString;
function ExtractXMLValueStr(xml,node: string): WideString;

implementation


function MakeXmlStr (node, value: string): WideString;
begin
  Result := '<' + node + '>' + value + '</' + node + '>';
end;
 
function FieldsToXml (rootName: string; OraQuery:TOraQuery): WideString;
var
  i: Integer;
begin
  Result := '<' + rootName + '>' + sLineBreak;;
  for i := 0 to OraQuery.FieldCount - 1 do
      Result := Result + '  ' + MakeXmlStr (
                LowerCase (OraQuery.Fields[i].FieldName),
                OraQuery.Fields[i].AsString) + sLineBreak;
  Result := Result + '</' + rootName + '>' + sLineBreak;;
end;

function ExtractXMLValueStr(xml,node: string): WideString;
var
  i,f:integer;
begin
  node := LowerCase(node);
  i:=Pos('<'+node+'>',xml)+length('<'+node+'>');
  f:=Pos('</'+node+'>',xml);
  Result := copy(xml,i,f-i);
end;


end.
