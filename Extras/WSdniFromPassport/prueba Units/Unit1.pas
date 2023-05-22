unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, wsDniPasaporteImpl, StdCtrls, wsDniPasaporteIntf, MIGRA_passWs;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses InvokeRegistry;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  ws: TwsDniPasaporte;
begin
  ws:=TwsDniPasaporte.Create;
  ShowMessage(ws.dniDePasaporte('27441660'));

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  ws: TwsDniPasaporte;
  e: entrada;
begin
  e := entrada.Create;
  e.dni := Edit2.Text;
  ws:=TwsDniPasaporte.Create;
  ShowMessage(ws.PasaportesEnTramite(Edit2.Text, 'M'));

end;

end.
