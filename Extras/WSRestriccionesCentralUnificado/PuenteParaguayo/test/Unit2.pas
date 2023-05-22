unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, puenteParaguayoImpl,puenteParaguayoIntf;

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
var
  consulta: consultaPuentePry;
  i: integer;
  wsunit: Tpuenteparaguayo;
  r: respuestaDTOPry;
begin
  wsunit := Tpuenteparaguayo.Create;
  Consulta := consultaPuentePry.Create;

  consulta.NUMDOC    := '003292612';
  consulta.APELLIDO1 := 'DUARTE';
  consulta.APELLIDO2 := 'ALVAREZ';
  consulta.NOMBRE1   := 'RUBEN';
  consulta.NOMBRE2   := 'DARIO';
  consulta.FECHANAC  := '11/03/1981';
  consulta.GENERO    :=  'MALE';
  consulta.NACIONALIDAD := 'PRY';
  consulta.EMISORDOC := 'PRY';
  consulta.NUMEROIDENTIFICACION := '123654';
  consulta.TIPODOC := 'PAS' ;
  consulta.PUESTOCONTROL := 'EZE';

  r := wsunit.consultarPuentePry(Consulta);
  ShowMessage(r.COD_RTA );

end;

end.
