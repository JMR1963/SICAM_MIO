unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, puenteBolivianoImpl,puenteBolivianoINTF,
  Vcl.Buttons;

type
  TForm1 = class(TForm)
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
var ws : TpuenteBoliviano;
    r: DatosSalidaPte;
    a: DatosEntradaPte;
begin
  r:= DatosSalidaPte.Create;
  try
    ws :=  TpuenteBoliviano.Create;
    a := DatosEntradaPte.Create;
    a.CODPAIS:= 'BOL';
    A.NOMBRE1:= 'RAUL';
    A.NOMBRE2:= 'CARLOS';
    A.APELLIDO1:= 'MAMANI';
    A.APELLIDO2:= 'ARAMAYO';
    A.NUMDOC:='3969014' ;
    A.PUESTOCONTROL:= '';
    A.TIPODOC:= '';
    A.EMISORDOC := '';
    A.FECHANAC := '';
    A.GENERO:= '';
    A.NACIONALIDAD := '';
    A.NUMEROIDENIFICACION := '';

    r:= ws.ConsultaBolivia(a);
    ShowMessage(R.COD_RTA +' '+R.COD_DETALLE_RTA);
  except
  end;
end;


end.
