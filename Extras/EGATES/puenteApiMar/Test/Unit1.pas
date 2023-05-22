unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
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

uses puenteApiMarIntf, puenteApiMarImpl, unit2;

{$R *.dfm}



procedure TForm1.Button1Click(Sender: TObject);
  var ws: TpuenteApiMar;
  RTA: STRING;
begin
  RTA:= ws.dameApi('BQB', 'BUDROVICH','', 'JUAN','','05/08/1981','29067325','');
  ShowMessage(RTA);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  form2:= TForm2.Create(nil);
  Form2.Show;
end;

end.
