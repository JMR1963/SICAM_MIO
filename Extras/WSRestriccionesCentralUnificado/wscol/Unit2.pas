unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

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

uses wsConsultaAptitudExterna;

procedure TForm2.BitBtn1Click(Sender: TObject);
var
  //ws : ConsultaAlianzaArgentina;
    ws : AlianzaArgentinaService;
  str: respuestaAlianza;


  (* estas dos variables se reeplazan por la clase del Ws de los Colombianos!  *)
  CodRespuesta, codDetalleRespuesta: integer;

begin

  (* estas dos variables se reeplazan por la clase del Ws de los Colombianos!  *)
  CodRespuesta:= -1;
  codDetalleRespuesta:= -1;



    str := respuestaAlianza.Create;
    //ws := GetConsultaAlianzaArgentina(TRUE);
    ws := GetAlianzaArgentinaService(FALSE);
    str := ws.consultaColombia('PAS',
                               'AR353804',
                               'COL',
                               '',
                               'MIGUEL',
                               'ROBERTO',
                               'GUERRERO',
                               'AYCARDI',
                               '1982-11-03',
                               'M',
                               'COL',
                               'ARG', (*CODIGO DE PAIS*)
                               'PRUEBA');
    ShowMessage('codigoError: '+inttostr(str.codigoError));
    ShowMessage('codigoError: '+inttostr(str.codigoRespuesta));


end;

end.
