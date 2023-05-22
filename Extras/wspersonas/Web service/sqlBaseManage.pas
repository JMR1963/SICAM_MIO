unit sqlBaseManage;
{
  **************************************************
  Consulto al sql base con un ado y un query
  recivo el string de coneccion y el usuario y password
  **************************************************
}

interface

uses
  classes, DB, ADODB, XMLIntf;

type
    resultadoConsulta = string;//array of string;

  TsqlBase = class (Tobject)
  private
    Fpass     : string;
    Fuser     : string;
    Fdatabase : string;
    FADOConnection: TADOConnection;
    FADOQuery : TADOQuery;
    procedure setSql(sql: Tstrings);
    function  getSql : Tstrings;
    function setStringConnection: integer;
    procedure writeRowXML(var xmlRootNode: IXMLNode; fields: TFieldList);
  public
    property username: string read Fuser     write Fuser;
    property pass    : string read Fpass     write Fpass;
    property database: string read Fdatabase write Fdatabase;
    property sql     : Tstrings read getSql write setSql;
    function connect : integer;
    constructor create; reintroduce;
    destructor destroy; reintroduce;
    function execSql : resultadoConsulta;
  end;

implementation

uses Variants, SysUtils, XmlDoc;

{ sqlBase }

function TsqlBase.connect: integer;
begin
  result := 1;
  try
    setStringConnection;
    FADOConnection.Connected := true;
  except
    result := -1;
  end;
end;

constructor TsqlBase.create;
begin
  inherited;
  FADOConnection := TADOConnection.Create(nil);
  FADOQuery := TADOQuery.Create(nil);
end;

destructor TsqlBase.destroy;
begin
  FreeAndNil(FADOConnection);
  FreeAndNil(FADOQuery);
  inherited;
end;

procedure TsqlBase.writeRowXML(var xmlRootNode: IXMLNode; fields: TFieldList);
//   var xmlNode: IXMLNode;
var i: integer;
    xmlChild: IXMLNode;
begin
   xmlChild:= xmlRootNode.AddChild('ROW');
   for i:= 0 to fields.Count - 1 do
   begin
     xmlChild.AddChild(fields[i].FieldName).Attributes[fields[i].FieldName]:= fields[i].Value;
   end;
end;

function TsqlBase.execSql: resultadoConsulta;
var
  //i,cantColumnas: integer;
  xmlStr: txmldocument;
  xmlNode: IXMLNode;
begin
  FADOQuery.Connection := FADOConnection;
  FADOQuery.Close;
  FADOQuery.Open;
  FADOQuery.FieldCount;
//  cantColumnas := FADOQuery.FieldCount;
  FADOQuery.First;
//  j := 0;

  xmlStr:= TXMLDocument.Create(FADOQuery);
  xmlStr.Active:= true;
  xmlStr.Version:= '1.0';
  xmlStr.Encoding:= 'iso-8859-1';
  xmlNode:= xmlStr.AddChild('RESULTADO');
  while not(FADOQuery.Eof) do
  begin
    writeRowXML(xmlNode,FADOQuery.FieldList);
    FADOQuery.Next;
  end;
  xmlStr.SaveToFile('./resultado.xml');
  result := xmlStr.XML.GetText;
  xmlStr.Free;
end;

function TsqlBase.getSql: Tstrings;
begin
  result := FADOQuery.SQL;
end;

procedure TsqlBase.setSql(sql: Tstrings);
begin
  FADOQuery.SQL := sql;
end;

function TsqlBase.setStringConnection: integer;
//chequea que esten seteados los parametros necesarios para realizar la conneccion
//inicia la conneccion retorna 1 si todo ok -1 si algo falla
begin
  try
    result := 1;
    if(Fpass <> NullAsStringValue) or (Fuser <> NullAsStringValue) or (Fdatabase <> NullAsStringValue) then
    begin
      FADOConnection.ConnectionString := 'Provider=SQLBASEOLEDB.1;Password=' + Fpass + ';' +
                                        'Persist Security Info=True;User ID=' + Fuser + ';Data ' +
                                        'Source=' + Fdatabase;
    end
    else
      result := -1;
  except
    result := -1;
  end;

end;

end.
