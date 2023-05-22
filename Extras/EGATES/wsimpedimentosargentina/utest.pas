unit utest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    EA1: TEdit;
    EN1: TEdit;
    ED: TEdit;
    EL: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label7: TLabel;
    Label8: TLabel;
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

uses IwsRestriccion1,wsRestriccionImpl;




procedure TForm1.BitBtn1Click(Sender: TObject);
var
  r:TRespuesta;

begin
 r:= GetIwsRestriccion.buscarRestricciones(EA1.Text,EN1.Text,FormatDateTime('YYYYMMDD',DateTimePicker1.Date),ED.Text,EL.Text);
 ShowMessage('Restriccion:'+r.Restriccion + ' - ' + 'Transporte:'+r.Transporte);
end;

end.
