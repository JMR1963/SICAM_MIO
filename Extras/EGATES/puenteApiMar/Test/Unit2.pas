unit unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses IpuenteApiMar1;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);

  var ws: IpuenteApiMar;
  RTA: STRING;
begin
  ws:= GetIpuenteApiMar(false);
  RTA:= ws.dameApi('BQB', 'BUDROVICH','', 'JUAN','','05/08/1981','29067325','');
  ShowMessage(RTA);
end;

end.
