unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses puenteUryIntf, puenteUryImpl;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var ws : TpuenteUry;
    a : consultaPuenteURY;
    b: respuestaURY;
begin
  ws:=TpuenteUry.Create;
  b:= respuestaURY.Create;

  a:= consultaPuenteURY.Create;
 // a.CODPAIS := 'ARG';
  a.NOMBRES := 'Juan';
  a.APELLIDOS := 'BUDROVICH';
  A.NUMDOC := '29067325';
  A.PUESTOCONTROL := 'EZE' ;
  A.TIPODOC := 'PA' ;
  A.EMISORDOC := 'ARG';
  A.FECHANAC := '05/08/1981';
  A.GENERO := 'M';
  a.NACIONALIDAD := 'ARG';
  A.NUMEROIDENTIFICACION := 'ARG';
  a.USER := 'JBUDR';
  b:= ws.consultarPuenteURY(a);
  ShowMessage(b.COD_RTA+' '+b.COD_DETALLE_RTA);


end;

end.
