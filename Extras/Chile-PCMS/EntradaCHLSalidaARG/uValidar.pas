unit uValidar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, Mask, DBCtrls, DBClient, Buttons;

type
  TValidarFrm = class(TForm)
    rgEstado: TRadioGroup;
    mmOBS: TMemo;
    Panel1: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DataSource1: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    DataSource2: TDataSource;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    lbl1: TLabel;
    btnAceptar: TBitBtn;
    bbCancelar: TBitBtn;
    procedure BtnCancelarClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure mmOBSKeyPress(Sender: TObject; var Key: Char);
    procedure btnAceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    rta:String;
  end;


implementation

{$R *.dfm}

uses uDMEntradaCHLSalidaARG, IWSValidarSemaforo2;

procedure TValidarFrm.BtnCancelarClick(Sender: TObject);
begin
  close;
end;



procedure TValidarFrm.FormCreate(Sender: TObject);
begin
  rta := '';
end;

procedure TValidarFrm.mmOBSKeyPress(Sender: TObject; var Key: Char);
function LatinUpperCase(c : Char) : Char;
{
  Convierte cualquier caracter alfabético latino a mayúsculas.
}
begin
  Result := c;
  if c in ['a'..'z'] then
    Result := Chr(Ord(c) - $20)
  else
    case c of
      'ñ' : Result := 'Ñ';
      'á' : Result := 'Á';
      'é' : Result := 'É';
      'í' : Result := 'Í';
      'ó' : Result := 'Ó';
      'ú' : Result := 'Ú';
      'ü' : Result := 'Ü';            
    end;
end;
begin
Key := LatinUpperCase(Key);
end;

procedure TValidarFrm.btnAceptarClick(Sender: TObject);
var
  d:TDatosEntrada;
  r:String;
begin

    try
      if Trim(mmOBS.Lines.Text)=NullAsStringValue then
        begin
          MessageDlg('Debe ingresar una observación', mtError,[mbOK],0);
          Exit;
        end;
      if MessageDlg('Seguro que: '+ rgEstado.Items.ValueFromIndex[rgEstado.ItemIndex]+' manifestando: '+mmOBS.Lines.Text,mtConfirmation,[mbYes,mbNo],0 )=mrNo then
        Exit;
      if (DBEdit1.Text = NullAsStringValue) and (DBEdit2.Text = NullAsStringValue) then
        begin
          MessageDlg('Debe seleccionar previamente una fila para validar', mtError,[mbOK],0);
          Exit;
        end;

      d := TDatosEntrada.Create;
      d.CodigoPaisEmisor := DataSource1.DataSet.fieldbyName('EMISORDOC').AsString;
      d.NumeroDocumento := DataSource1.DataSet.fieldbyName('NroDOC').AsString;
      d.Observacion := mmOBS.Text;
      d.Funcionario := DMSem.GLOBAL_UserName;
      d.tdi := DataSource1.DataSet.fieldbyName('tdi').AsString;

      d.Flag := IntToStr(rgEstado.ItemIndex+1);

      //ShowMessage(d.CodigoPaisEmisor + '-' + d.NumeroDocumento+ '-' +d.Observacion+ '-' +d.Funcionario+ '-' +d.TDI+ '-' +d.Flag);
      r:= GetIWSValidarSemaforo.EnviarRespuesta(d,GLOBAL_WSValSemaforo);

    //  if valorNodoXML(r,'OK')='OK' then
      if r ='OK' then
        rta := 'OK'
      else
        rta := r;

      close;

      except on e: exception do
          ShowMessage( 'Error:' +e.Message );

       end;
end;

end.




