unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,Iws_obtener_autorizacion1;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    edtDoc: TEdit;
    Label1: TLabel;
    edtFecha: TEdit;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  ws: Iws_obtener_autorizacion;
  busqueda: Tdatos_busqueda;
  af: tautorizacion_full;
begin
  ws := GetIws_obtener_autorizacion(false);
  busqueda := Tdatos_busqueda.Create;
  busqueda.fecha_nacimiento :=  '08/05/2016';
  busqueda.numero_documento := '11223344';
  af := ws.autorizacion_menores(busqueda);
  ShowMessage(af.nombre_escribano);

end;

end.
