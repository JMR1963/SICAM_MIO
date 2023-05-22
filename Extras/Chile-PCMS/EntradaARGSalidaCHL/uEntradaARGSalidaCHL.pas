unit uEntradaARGSalidaCHL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, Grids, DBGrids, CRGrid,
  WinSkinData;

type
  TEntradaARGSalidaCHLFrm = class(TForm)
    Panel1: TPanel;
    btnRefrescar: TBitBtn;
    Panel2: TPanel;
    btnVisto: TBitBtn;
    Panel3: TPanel;
    DBGrid1: TCRDBGrid;
    DataSource1: TDataSource;
    Timer1: TTimer;
    Label1: TLabel;
    lblPaso: TLabel;
    BitBtn1: TBitBtn;
    btnTestCHL: TBitBtn;
    btnTestArg: TBitBtn;
    BtnCerrar: TBitBtn;
    SkinData1: TSkinData;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnRefrescarClick(Sender: TObject);
    procedure btnVistoClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnTestCHLClick(Sender: TObject);
    procedure btnTestArgClick(Sender: TObject);
    procedure BtnCerrarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EntradaARGSalidaCHLFrm: TEntradaARGSalidaCHLFrm;

implementation

{$R *.dfm}

uses ufUsuarioIngreso,uDMEntradaARGSalidaCHL, IWsListaControl_Unif2, IwsRestriccionArgentina;


procedure TEntradaARGSalidaCHLFrm.FormCreate(Sender: TObject);
begin
  MostarLogin;
  Caption := Caption + ' ['+DMSem.descrip+']';
  lblPaso.Caption := DMSem.descrip;
end;

procedure TEntradaARGSalidaCHLFrm.Timer1Timer(Sender: TObject);
begin
  btnRefrescar.Click;
end;

procedure TEntradaARGSalidaCHLFrm.btnRefrescarClick(Sender: TObject);
begin
  Timer1.Enabled:=False;
  DMSem.refrescoTabla;
  Timer1.Enabled:=True;
end;

procedure TEntradaARGSalidaCHLFrm.btnVistoClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  if MessageDlg('Está seguro que desea marcar como visto el mensaje?',mtConfirmation,[mbYes, mbNo],0)= mryes  then
    begin
      try
        DMSem.renombroArch(DMSem.GLOBAL_SemPath,DBGrid1.DataSource.DataSet.fieldByName('archivo').AsString,'.VIS');
      except
        DMSem.renombroArch(DMSem.GLOBAL_SemPath,DBGrid1.DataSource.DataSet.fieldByName('archivo').AsString,'_0.VIS');
      end;
      btnRefrescar.Click;
    end;
  Timer1.Enabled := True;
end;

procedure TEntradaARGSalidaCHLFrm.DBGrid1TitleClick(Column: TColumn);
begin
  DMSem.ordenoCampo(Column.FieldName);
end;

procedure TEntradaARGSalidaCHLFrm.FormShow(Sender: TObject);
begin
  btnRefrescar.Click;
end;

procedure TEntradaARGSalidaCHLFrm.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if gdSelected in State then Exit;

  if not DBGrid1.DataSource.DataSet.FieldByName('flag').AsBoolean then
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

procedure TEntradaARGSalidaCHLFrm.BitBtn1Click(Sender: TObject);
begin
//PIA...




end;

procedure TEntradaARGSalidaCHLFrm.btnTestCHLClick(Sender: TObject);
var
  hi,hf:TDateTime;
  consulta: XML_CONSULTA_NEW;
  salida : TRESULTADO_NEW;
  ws : IWsListaControl_Unif;

begin

  Timer1.Enabled := False;
  Cursor := crHourGlass;
  consulta:= XML_CONSULTA_NEW.Create;

  ws := GetIWsListaControl_Unif(False,'',NIL);

  SALIDA := TRESULTADO_NEW.Create;
  try
    hi := now;
    with consulta do
    begin
      FUENTES:= 'CHL';
      USUARIO:= 'PRUEBA';
      CLAVE:= '';
      OPERADOR:='PRUEBA';
      IP:= '8.8.8.8';
      NOMBRE1:= 'MARTIN';
      NOMBRE2:= 'GERARDO';
      APELLIDO1:= 'GOROSITO';
      APELLIDO2:= '';
      NUMDOC:= '28648853';
      TIPODOC:= 'ID';
      EMISORDOC:= 'ARG';
      FECHANAC:= '01/01/2001';
      GENERO:='M';
      NACIONALIDAD:= 'ARG';
      NUMEROIDENIFICACION:= '28648853';
      PASO:= 'PRUEBA';

    end;

    salida := ws.ConsultaRestriccionLocal(consulta);
    hf := now;
    Cursor := crDefault;
    MessageDlg('Hora inicio:'+formatDateTime('hh:mm:ss',hi)+' - Hora fin:'+formatDateTime('hh:mm:ss',hf)+ ' - Dif '+formatDateTime('hh:mm:ss.zzz',hf-hi), mtInformation,[mbOK],0);
  finally
    consulta.Free;
    btnRefrescar.Click;
    Timer1.Enabled := True;
  end;
end;

procedure TEntradaARGSalidaCHLFrm.btnTestArgClick(Sender: TObject);
var
  hi,hf:TDateTime;
  consulta: DatosEntrada;
  salida : DatosSalida;
  ws : iwsrestriccionargentina.IwsRestriccion;

begin

  Timer1.Enabled := False;
  Cursor := crHourGlass;
  consulta:= DatosEntrada.Create;
  ws := GetIwsRestriccion(false,'',nil);
  try
    hi := now;
    with consulta do
    begin

       USUARIO := 'pp';
       CLAVE:='';
       OPERADOR:='MGOROSITO';
       CODPAIS:= 'ARG';
       NOMBRE2:='';
      {POSITIVO
       NOMBRE1 :='MARIA';
       APELLIDO1:='DUSSO';
       APELLIDO2 := '';
       NUMDOC:='F5269132';
       PUESTOCONTROL:='mipc';
       TIPODOC:='P';
       EMISORDOC:= 'ARG';
       FECHANAC:='01/05/1946';}
       NOMBRE1 :='MARTIN';
       APELLIDO1:='GOROSITO';
       APELLIDO2 := '';
       NUMDOC:='28648853';
       PUESTOCONTROL:='mipc';
       TIPODOC:='P';
       EMISORDOC:= 'ARG';
       FECHANAC:='31/05/1981';
       GENERO:='M';
       NACIONALIDAD:= 'ARG';
       NUMEROIDENIFICACION:='28648853';
       PASO := 'LOCAL';

    end;

    salida := ws.ConsultaImpedimentosArgentina(consulta);
    hf := now;
    Cursor := crDefault;
    MessageDlg('Hora inicio:'+formatDateTime('hh:mm:ss',hi)+' - Hora fin:'+formatDateTime('hh:mm:ss',hf)+ ' - Dif '+formatDateTime('hh:mm:ss.zzz',hf-hi), mtInformation,[mbOK],0);
  finally
    consulta.Free;
    btnRefrescar.Click;
    Timer1.Enabled := True;
  end;
end;

procedure TEntradaARGSalidaCHLFrm.BtnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TEntradaARGSalidaCHLFrm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose :=MessageDlg('Desea cerrar la aplicación?',mtConfirmation,[mbYes,mbNo],0)=mrYes;
end;

end.



