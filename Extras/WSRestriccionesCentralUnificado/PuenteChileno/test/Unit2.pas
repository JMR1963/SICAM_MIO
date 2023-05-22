unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,puentechilenoImpl,puentechilenoIntf;

type
  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
  consulta: consultaPuenteCHl;
  i: integer;
  wsunit: Tpuentechileno;
  r: respuestaDTOchl;
begin
  wsunit := Tpuentechileno.Create;
  Consulta := consultaPuenteCHl.Create;

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


  r := wsunit.consultarPuentechl(Consulta);
  ShowMessage(r.COD_RTA );
  ShowMessage(r.COD_DETALLE_RTA);

end;

procedure TForm2.Button1Click(Sender: TObject);
var
  consulta: consultaProcederCHL;
  i: integer;
  wsunit: Tpuentechileno;
  r: respuestaProcederCHL;
begin
  wsunit := Tpuentechileno.Create;
  Consulta := consultaProcederCHL.Create;

  consulta.TipoDocumento := 'ID';
  consulta.NumeroDocumento := '29067325';
  consulta.PaisDocumento := 'ARG';
  consulta.Observacion := 'argefd';
  consulta.Funcionario := '123';
  consulta.Status := '1';

  r := wsunit.procederCHL(Consulta);

  ShowMessage('si');


end;

procedure TForm2.Button2Click(Sender: TObject);



var
  consulta: DespachosChileRequestCHL;
  i: integer;
  wsunit: Tpuentechileno;
  r: DespachosChileResponseCHL;
  a: ansistring;
begin
  wsunit := Tpuentechileno.Create;
  Consulta := DespachosChileRequestCHL.Create;



  consulta.FINI := '20190901';
  consulta.FFIN := '20190906';
  r := wsunit.DespachosChileCHL(consulta);

  ShowMessage(r.data);
end;

end.
