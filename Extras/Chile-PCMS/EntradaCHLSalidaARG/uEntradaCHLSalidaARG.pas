unit uEntradaCHLSalidaARG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ActnList, DB, Grids, DBGrids, CRGrid,
  ExtCtrls, WinSkinData, ComCtrls;

type
  TEntradaCHLSalidaARGFrm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DataSource1: TDataSource;
    DBGrid1: TCRDBGrid;
    BtnValidar: TBitBtn;
    btnRefrescar: TBitBtn;
    Timer1: TTimer;
    lblPaso: TLabel;
    Label1: TLabel;
    BtnVisto: TBitBtn;
    btnTest: TBitBtn;
    BtnComparacion: TBitBtn;
    SkinData1: TSkinData;
    BtnCerrar: TBitBtn;
    btnTestArg: TBitBtn;
    stat1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnRefrescarClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BtnValidarClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure BtnVistoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure BtnComparacionClick(Sender: TObject);
    procedure BtnCerrarClick(Sender: TObject);
    procedure btnTestArgClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EntradaCHLSalidaARGFrm: TEntradaCHLSalidaARGFrm;

implementation

{$R *.dfm}

uses ufUsuarioIngreso,uDMEntradaCHLSalidaARG, Math,uValidar,IwsRestriccion1,uFaltantes, IwsRestriccionArgentina, IWsListaControl_Unif2;


procedure TEntradaCHLSalidaARGFrm.FormCreate(Sender: TObject);
begin
 //Debug
  if Not MostarLogin then  Application.Terminate;

  Caption := Caption + ' ['+DMSem.descrip+']';
  lblPaso.Caption := DMSem.descrip;
end;

procedure TEntradaCHLSalidaARGFrm.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if gdSelected in State then Exit;

  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State)
end;

procedure TEntradaCHLSalidaARGFrm.btnRefrescarClick(Sender: TObject);
begin
  Timer1.Enabled:=False;
  DMSem.refrescoTabla;
  Timer1.Enabled:=True;
end;

procedure TEntradaCHLSalidaARGFrm.Timer1Timer(Sender: TObject);
begin
  btnRefrescar.Click;
end;

procedure TEntradaCHLSalidaARGFrm.BtnValidarClick(Sender: TObject);
var
  ValidarFrm: TValidarFrm;
begin
  if DBGrid1.DataSource.DataSet.IsEmpty then
    Exit;
  Timer1.Enabled := False;
  ValidarFrm:= TValidarFrm.Create(self);
  try
    ValidarFrm.ShowModal;
    if ValidarFrm.rta = 'OK' then
    begin
      DMSem.renombroArch(DMSem.GLOBAL_SemPath,DBGrid1.DataSource.DataSet.fieldByName('archivo').AsString,'.OK');
      MessageBox(0, 'TRANSACCIÓN APROBADA', 'SEMAFORO', MB_ICONWARNING or MB_OK or MB_TOPMOST or MB_APPLMODAL);
    end
    else
      if ValidarFrm.rta <>'' then
        MessageBox(0, Pchar('ERROR AL INTENTAR VALIDAR EL TRÁNSITO'+ValidarFrm.rta), 'SEMÁFORO - ERROR', MB_ICONERROR or MB_OK or MB_TOPMOST or MB_APPLMODAL);

  finally
    ValidarFrm.Free;
  end;
  btnRefrescar.Click;
  Timer1.Enabled := True;
end;

procedure TEntradaCHLSalidaARGFrm.DBGrid1TitleClick(Column: TColumn);
begin
  DMSem.ordenoCampo(Column.FieldName);
end;

procedure TEntradaCHLSalidaARGFrm.BtnVistoClick(Sender: TObject);
begin
  if DBGrid1.DataSource.DataSet.IsEmpty then
    Exit;
  if (MessageDlg('Está seguro que desea borrar el registro?', mtWarning, [mbYes, mbNo], 0) = mrNo) then
    Exit;                          

  Timer1.Enabled := False;
  DMSem.renombroArch(DMSem.GLOBAL_SemPath,DBGrid1.DataSource.DataSet.fieldByName('archivo').AsString,'.BOR');
  btnRefrescar.Click;
  Timer1.Enabled := True;
end;

procedure TEntradaCHLSalidaARGFrm.FormShow(Sender: TObject);
begin
  btnRefrescar.Click;
end;

procedure TEntradaCHLSalidaARGFrm.btnTestClick(Sender: TObject);
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

procedure TEntradaCHLSalidaARGFrm.BtnComparacionClick(Sender: TObject);
begin
  Timer1.Enabled:=False;

  with TFrmFaltantes.Create(self) do
  try
    Titulo := 'Vehículos faltantes en SICaM';
    WsIP := DMSem.GLOBAL_SERVER; //DEBUG
    idPaso := IntToStr(DMSem.paso);
    fun := DMSem.GLOBAL_UserName; //DEBUG
    ShowModal;
  finally
    Timer1.Enabled:=True;
    Free;
  end;
  // MONTE AYMOND!

  //llamo al socket de chl y comparo con sicam.

  //envio por socket los faltantees de sicam...
end;

procedure TEntradaCHLSalidaARGFrm.BtnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TEntradaCHLSalidaARGFrm.btnTestArgClick(Sender: TObject);
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
procedure TEntradaCHLSalidaARGFrm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose :=MessageDlg('Desea cerrar la aplicación?',mtConfirmation,[mbYes,mbNo],0)=mrYes;
end;

end.

