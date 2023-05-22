unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,IPuenteParaguayo1, Vcl.StdCtrls,
  Vcl.Buttons;

type
  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.BitBtn1Click(Sender: TObject);
var ws : IPuenteParaguayo;
    r: respuestaDTOPry;
    a: consultaPuentePry;
begin
  r:= respuestaDTOPry.Create;

    ws :=  GetIPuenteParaguayo(false);
  a := consultaPuentePry.Create;

  a.CODPAIS:= 'PRY';
  a.NUMDOC    := '003292612';
  a.APELLIDO1 := 'DUARTE';
  a.APELLIDO2 := 'ALVAREZ';
  a.NOMBRE1   := 'RUBEN';
  a.NOMBRE2   := 'DARIO';
  a.FECHANAC  := '11/03/1981';
  a.GENERO    :=  'MALE';
  a.NACIONALIDAD := 'PRY';
  a.EMISORDOC := 'PRY';
  a.NUMEROIDENTIFICACION := '123654';
  a.TIPODOC := 'PAS' ;
  a.PUESTOCONTROL := 'EZE';

  r:= ws.consultarPuentePry(a);
  ShowMessage( r.COD_RTA);
  ShowMessage(r.COD_DETALLE_RTA);


end;

end.
