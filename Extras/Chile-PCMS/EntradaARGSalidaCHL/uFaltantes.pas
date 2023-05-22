unit uFaltantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Buttons, DBClient, Grids, DBGrids, CRGrid,
  ExtCtrls, ComCtrls;

type
  TFrmFaltantes = class(TForm)
    Panel1: TPanel;
    DBGrid1: TCRDBGrid;
    tblFaltantes: TClientDataSet;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    tblFaltantesVisto: TBooleanField;
    tblFaltantesPatente: TStringField;
    tblFaltantesPaisvehiculo: TStringField;
    tblFaltantesFecha: TDateTimeField;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    btnMostrar: TBitBtn;
    Label3: TLabel;
    FDesde: TDateTimePicker;
    FHasta: TDateTimePicker;
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure btnMostrarClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    WsIP,Titulo,ipPaso,fun:String;
  end;

var
  FrmFaltantes: TFrmFaltantes;

implementation

{$R *.dfm}

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;


type
  IdespachosSicam = interface(IInvokable)
  ['{38787457-F563-EF37-A0F7-E00F293B5D1D}']
    function  despachosSicam(const FINI: WideString; const FFIN: WideString): WideString; stdcall;
    function  despachosChile(const ID: WideString; const FINI: WideString; const FFIN: WideString; const FUN: WideString): WideString; stdcall;
    function  DESPACHOSxmlToLs(const aXML: WideString): WideString; stdcall;
    function  FALTANTESxmlToLs(const aXML: WideString): WideString; stdcall;
    function  DifLsALsB(const sLSA: WideString; const sLSB: WideString): WideString; stdcall;
  end;

function GetIdespachosSicam(WSIP:String;UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IdespachosSicam;
const
  defSvc  = 'IdespachosSicamservice';
  defPrt  = 'IdespachosSicamPort';
var
  RIO: THTTPRIO;
  defWSDL,defURL:String;
begin

  defWSDL := 'http://'+WSIP+'/cgi-bin/wsDespachos/wsDespachosSicam/wsdl/IdespachosSicam';
  defURL  := 'http://'+WSIP+'/cgi-bin/wsDespachos/wsDespachosSicam/soap/IdespachosSicam';


  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as IdespachosSicam);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;




procedure TFrmFaltantes.BitBtn1Click(Sender: TObject);
begin
  if (tblFaltantes.State in [dsBrowse]) then
  begin
    tblFaltantes.Edit;
    tblFaltantes.FieldByName('Visto').AsBoolean := not tblFaltantes.FieldByName('Visto').AsBoolean;
    tblFaltantes.Post;
  end;
end;

procedure TFrmFaltantes.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if gdSelected in State then Exit;

  if not DBGrid1.DataSource.DataSet.FieldByName('visto').AsBoolean then
    begin
      DBGrid1.Canvas.Brush.Color:=clRed;
      dbgrid1.Canvas.Font.Color :=clWhite;
    end
  else
   begin
    DBGrid1.Canvas.Brush.Color:=clGreen;
    dbgrid1.Canvas.Font.Color :=clBlack;
   end;

  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State)
end;

procedure TFrmFaltantes.FormShow(Sender: TObject);
begin
  FDesde.DateTime := now;
  FHasta.DateTime := now;
  Label1.Caption := Titulo;
  tblFaltantes.Open;

//  GetIdespachosSicam(IPWs)
end;

procedure TFrmFaltantes.btnMostrarClick(Sender: TObject);
var
  FI,FF,col:String;
  ds,dc,fal:String;

  stF,stC:TStringList;

  f,c:Integer;
begin
  while not tblFaltantes.Eof do
    tblFaltantes.Delete;



  FI := FormatDateTime('YYYYMMDD',FDesde.Date);
  FF := FormatDateTime('YYYYMMDD',FHasta.Date);

  with GetIdespachosSicam(WsIP,false,'',nil) do
  begin
    ds := DESPACHOSxmlToLs(despachosSicam(FI,FF));
    dc := DESPACHOSxmlToLs(despachosChile(ipPaso,FI,FF,fun));
    fal := DifLsALsB(ds,dc);
  end;

  stF := TStringList.Create;
  stC := TStringList.Create;

  stF.Text := StringReplace(fal,'#',#13#10,[rfReplaceAll]);

  tblFaltantes.Insert;
  for f:=0 to stF.Count-1 do
  begin
    col := stF.Strings[f];
    stC.Text := StringReplace(fal,'|',#13#10,[rfReplaceAll]);
    for c:=0 to stC.Count-1 do
    begin


      stC.Strings[0];
      stC.Strings[1];
      stC.Strings[2];

    end;
  end;
  tblFaltantes.Post;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(IdespachosSicam), 'urn:despachosSicamIntf-IdespachosSicam', 'utf-8');
  InvRegistry.RegisterAllSOAPActions(TypeInfo(IdespachosSicam), '|urn:despachosSicamIntf-IdespachosSicam#despachosSicam'
                                                               +'|urn:despachosSicamIntf-IdespachosSicam#despachosChile'
                                                               +'|urn:despachosSicamIntf-IdespachosSicam#DESPACHOSxmlToLs'
                                                               +'|urn:despachosSicamIntf-IdespachosSicam#FALTANTESxmlToLs'
                                                               +'|urn:despachosSicamIntf-IdespachosSicam#DifLsALsB'
                                                               );

end.
