unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

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

USES INFOTRANSPORTEIMPL, INFOTRANSPORTEINTF;



{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
VAR RTA : trespuesta;
WS : TinfoTransporte;
begin
    WS := TinfoTransporte.Create;
    RTA:= trespuesta.Create;
    RTA := WS.InfTransporte('BUDROVICH','','JUAN','PABLO','29067325','','E','A','EZE', '05/08/1981') ;
    ShowMessage(RTA.ok);
end;

end.
