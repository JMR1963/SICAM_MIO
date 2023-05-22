unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ubaseDatos, WsServiciosMaritimosIntf, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    edtFecha1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtFecha2: TEdit;
    edtJurisdiccion: TEdit;
    Jurisdiccion: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  bd: TbaseDatos;
  r: Tservicios;
  rpasos: Tpasosfronterizos;
  j,i:integer;
  catalogospf: TtipoBuques;
  pasos: tservicios;
  catalogostb: TtipoBuques;

begin
  j :=0;
  bd := TbaseDatos.create;

  pasos := bd.getServiciosLocalesYOtros(strtoint(edtJurisdiccion.text), edtFecha1.Text, edtFecha2.Text);


{
  bd := TbaseDatos.create;
  bd.setEstado(1,SOLICITADO);
 }
end;

end.
