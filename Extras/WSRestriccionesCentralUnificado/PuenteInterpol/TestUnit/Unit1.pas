unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

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

  uses puenteInterpolintf, puenteInterpolimpl;

  {$R *.dfm}



procedure TForm1.BitBtn1Click(Sender: TObject);
var ws : TpuenteInterpol;
    cons : datosConsultaInterpol;
    res : respuestaInterpol;
begin
  res:= respuestaInterpol.Create;
  cons := datosConsultaInterpol.Create;
  cons.nombre := 'JUAN';
  cons.apellido:='XXXXXXXXXX';
  cons.fechaNacimiento:='19800101';
  cons.tipoDoc:='DIP';
  cons.nroDoc:='123456' ;
  cons.pais:='110';
  cons.genero:='M';
  cons.transito:='E';
  cons.usuarioNombre:='XXXX';
  cons.usuarioApellido:='XXXX';
  cons.usuarioIp:='XX.XX.XX.XX';
  cons.usuarioDepen:='XXXX';
  cons.usuarioDepenId:='XXXX';
  cons.usuarioTipoDoc:='XXXX';
  cons.usuarioDoc:='XXXX';
  cons.usuarioJerarquia:='XXXX';
  cons.usuario:='XXXX';
  res:= ws.ConsultaInterpol(cons);

end;

end.
