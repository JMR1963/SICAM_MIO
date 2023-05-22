unit uFaltantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Buttons, DBClient, Grids, DBGrids, CRGrid,
  ExtCtrls, ComCtrls, ExportDS, SME2Cell, SME2OLE, dateutils,uDiff;

type
  TFrmFaltantes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BtnCerrar: TBitBtn;
    lbTitulo: TLabel;
    Label2: TLabel;
    btnMostrar: TBitBtn;
    FDesde: TDateTimePicker;
    SaveDialog1: TSaveDialog;
    Panel3: TPanel;
    lblFile1: TLabel;
    lblFile2: TLabel;
    Label1: TLabel;
    ListSICAM: TListBox;
    ListCHILE: TListBox;
    pnlGR: TPanel;
    StatusBar1: TStatusBar;
    BtnSig: TButton;
    BrnAnt: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnMostrarClick(Sender: TObject);
    procedure btnLsClick(Sender: TObject);
    procedure BtnCerrarClick(Sender: TObject);
    procedure BtnSigClick(Sender: TObject);
    procedure BrnAntClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FDiff :TFDiff2;
  public
    { Public declarations }
    WsIP,Titulo,idPaso,fun:String;
  end;

var
  FrmFaltantes: TFrmFaltantes;

implementation

{$R *.dfm}

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns,
  uDMEntradaCHLSalidaARG,uList;


type


  TFECHA               = class;                 { "urn:despachosSicamIntf" }
  TRESULTADO           = class;                 { "urn:despachosSicamIntf" }
  TDESPCHILES          = class;                 { "urn:despachosSicamIntf" }
  TXML                 = class;                 { "urn:despachosSicamIntf" }
  TLS                  = class;                 { "urn:despachosSicamIntf" }

  TFECHA = class(TRemotable)
  private
    FFINI: WideString;
    FFFIN: WideString;
  published
    property FINI: WideString read FFINI write FFINI;
    property FFIN: WideString read FFFIN write FFFIN;
  end;


  TRESULTADO = class(TRemotable)
  private
    FRESULTADO: WideString;
  published
    property RESULTADO: WideString read FRESULTADO write FRESULTADO;
  end;

  TDESPCHILES = class(TRemotable)
  private
    FFINI: WideString;
    FFFIN: WideString;
    FID: WideString;
    FFUN: WideString;
  published
    property FINI: WideString read FFINI write FFINI;
    property FFIN: WideString read FFFIN write FFFIN;
    property ID: WideString read FID write FID;
    property FUN: WideString read FFUN write FFUN;
  end;

  TXML = class(TRemotable)
  private
    FXML: WideString;
  published
    property XML: WideString read FXML write FXML;
  end;

  TLS = class(TRemotable)
  private
    FLSA: WideString;
    FLSB: WideString;
  published
    property LSA: WideString read FLSA write FLSA;
    property LSB: WideString read FLSB write FLSB;
  end;


  IdespachosSicam = interface(IInvokable)
  ['{38787457-F563-EF37-A0F7-E00F293B5D1D}']
    function  despachosSicam(const FECHA: TFECHA): TRESULTADO; stdcall;
    function  despachosChile(const DESPCHL: TDESPCHILES): TRESULTADO; stdcall;
    function  despachosUruguay(const FECHA: TFECHA): TRESULTADO; stdcall;
    function  DESPACHOSxmlToLs(const aXML: TXML): TRESULTADO; stdcall;
    function  FALTANTESxmlToLs(const aXML: TXML): TRESULTADO; stdcall;
    function  DifLsALsB(const LS: TLS): TRESULTADO; stdcall;
  end;


function GetIdespachosSicam(WSIP:String;UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IdespachosSicam;
const
  defSvc  = 'IdespachosSicamservice';
  defPrt  = 'IdespachosSicamPort';
var
  RIO: THTTPRIO;
  defWSDL,defURL:String;
begin

  defWSDL := 'http://'+WSIP+'/cgi-bin/wsDespachosSalidas/wsdespachos/wsdl/IdespachosSicam';
  defURL  := 'http://'+WSIP+'/cgi-bin/wsDespachosSalidas/wsDespachos/soap/IdespachosSicam';


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





procedure TFrmFaltantes.FormShow(Sender: TObject);
begin
  FDiff := TFDiff2.Create(self);

  FDiff.ResultGrid.Parent := pnlGR;


  FDesde.DateTime := Yesterday;
//  FHasta.DateTime := now;
  lbTitulo.Caption := Titulo;

//  GetIdespachosSicam(IPWs)
end;

function esError(s:string):boolean;
begin
  Result := False;
  if pos('ERR:',UpperCase(s))>0 then
  begin
    Result := TRUE;
    Exit;
  end;
  if pos('ERROR:',UpperCase(s))>0 then
  begin
    Result := TRUE;
    Exit;
  end;

end;

procedure TFrmFaltantes.btnMostrarClick(Sender: TObject);
var
  FI,FF,col:String;
  ds,dc,fal,t:String;

  stF,stC:TStringList;

  f,c,i,a,b:Integer;
  DESPCHILES: TDESPCHILES;
  RESULTADOS_S,RESULTADOS_C : TRESULTADO;
  FECHA : TFECHA;
  dsXML,dcXML, XML:TXML;
  LS:TLS;

begin
  t := norDir(GetEnvironmentVariable('TEMP'));


  Screen.Cursor := crHourGlass;
  btnMostrar.Enabled := False;
  try
    FI := FormatDateTime('YYYYMMDD',FDesde.Date);
    FF := FormatDateTime('YYYYMMDD',FDesde.Date);

    DESPCHILES := TDESPCHILES.Create;
    DESPCHILES.FINI := FI;
    DESPCHILES.FFIN := FF;
    DESPCHILES.ID := idPaso;
    DESPCHILES.FUN := Fun;

    FECHA := TFECHA.Create;
    FECHA.FINI := FI;
    FECHA.FFIN := FF;

    LS:=TLS.Create;


    dsXML:=TXML.Create;
    dcXML:=TXML.Create;
    XML := TXML.create;

    with GetIdespachosSicam(WsIP,false,'',nil) do
    begin
      try
        dsXML.XML := despachosSicam(FECHA).RESULTADO;


        if esError(dsXML.XML) then begin
          ShowMessage('despachosSicam '+dsXML.XML);
          Exit;
        end;
      except
        on E:Exception do
        begin
          ShowMessage('Error despachosSicam ->'+E.Message);
          Exit;
        end;
      end;

      try
        //dcXML CHILE

        dcXML.XML := despachosChile(DESPCHILES).RESULTADO;

      except
        on E:Exception do
        begin
          ShowMessage('Error despachosChile ->'+E.Message);
          Exit;
        end;
      end;

      try
        LS.LSB := DESPACHOSxmlToLs(dsXML).RESULTADO;    //SICAM

        ListSICAM.Items.Text := StringReplace(LS.LSB,'#',#13#10,[rfReplaceAll]);

        DeleteFile(t+'sicam.bin');
        ListSICAM.Sorted:= True;
        ListSICAM.Items.SaveToFile(t+'sicam.bin');
        FDiff.OpenFile1(t+'sicam.bin');

      //  Memo1.Text := LS.LSA;

        if esError(LS.LSB) then begin
          ShowMessage('DESPACHOSxmlToLs 1 '+LS.LSA);

          Exit;
        end;

      except
        on E:Exception do
        begin
          ShowMessage('Error datos SICAM -> '+E.Message);
          Exit;
        end;
      end;


      try
        LS.LSA := DESPACHOSxmlToLs(dcXML).RESULTADO;   //CHILE

        ListCHILE.Items.Text := StringReplace(LS.LSA,'#',#13#10,[rfReplaceAll]);

        DeleteFile(t+'pdi.bin');
        ListCHILE.Sorted := True;
        ListCHILE.Items.SaveToFile(t+'pdi.bin');
        FDiff.OpenFile2(t+'pdi.bin');


        if esError(LS.LSA) then begin
          ShowMessage('DESPACHOSxmlToLs 2 '+LS.LSB);
          Exit;
        end;

      except
        on E:Exception do
        begin
          ShowMessage('Error datos CHILE -> '+E.Message);
          Exit;
        end;
      end;

    end;

    FDiff.comparo(17,a,b,true,'Vehiculos');

    StatusBar1.Panels[0].Text := FDiff.StatusBar1.Panels[0].Text;
    StatusBar1.Panels[1].Text := FDiff.StatusBar1.Panels[1].Text;
    StatusBar1.Panels[2].Text := FDiff.StatusBar1.Panels[2].Text;
    StatusBar1.Panels[3].Text := FDiff.StatusBar1.Panels[3].Text;


    with FDiff.ResultGrid do
    begin
      i := (ClientWidth -80) div 2;
      FDiff.ResultGrid.ColWidths[1] := i;
      FDiff.ResultGrid.ColWidths[3] := i;
    end;
    lblFile2.Left := pnlGR.ClientWidth div 2;

    lblFile1.Caption := 'ARGENTINA (SICAM) - '+IntToStr(ListSICAM.Count);
    lblFile2.Caption := 'CHILE (PDI) - '+IntToStr(ListCHILE.Count);

  finally
    Screen.Cursor := crDefault;
    btnMostrar.Enabled := True;

    DESPCHILES.Free;
    FECHA.Free;
    LS.Free;
    dsXML.Free;
    dcXML.Free;
    XML.Free;

  end;

end;



procedure TFrmFaltantes.btnLsClick(Sender: TObject);
begin
  if Assigned(FrmLs) then
    FrmLs.ShowModal;
end;

procedure TFrmFaltantes.BtnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmFaltantes.BtnSigClick(Sender: TObject);
begin
  if Assigned(FDiff) then
    FDiff.NextChanges1.Click;

end;

procedure TFrmFaltantes.BrnAntClick(Sender: TObject);
begin
  if Assigned(FDiff) then
    FDiff.PreviousChanges1.Click;

end;

procedure TFrmFaltantes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FDiff.Free;
  Action := caFree;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(IdespachosSicam), 'urn:despachosSicamIntf-IdespachosSicam', 'utf-8');
  InvRegistry.RegisterAllSOAPActions(TypeInfo(IdespachosSicam), '|urn:despachosSicamIntf-IdespachosSicam#despachosSicam'
                                                               +'|urn:despachosSicamIntf-IdespachosSicam#despachosChile'
                                                               +'|urn:despachosSicamIntf-IdespachosSicam#ARGFaltantesEnMONTEAYMOND'
                                                               +'|urn:despachosSicamIntf-IdespachosSicam#DESPACHOSxmlToLs'
                                                               +'|urn:despachosSicamIntf-IdespachosSicam#FALTANTESxmlToLs'
                                                               +'|urn:despachosSicamIntf-IdespachosSicam#DifLsALsB'
                                                               );
  RemClassRegistry.RegisterXSClass(TFECHA, 'urn:despachosSicamIntf', 'TFECHA');
  RemClassRegistry.RegisterXSClass(TRESULTADO, 'urn:despachosSicamIntf', 'TRESULTADO');
  RemClassRegistry.RegisterXSClass(TDESPCHILES, 'urn:despachosSicamIntf', 'TDESPCHILES');
  RemClassRegistry.RegisterXSClass(TXML, 'urn:despachosSicamIntf', 'TXML');
  RemClassRegistry.RegisterXSClass(TLS, 'urn:despachosSicamIntf', 'TLS');


end.
