unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UBASE64,

  wsSolicitudConsularImpl,wsSolicitudConsularIntf;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var ws : TwsSolicitudConsular;
    res : TConstancia;
    Stream: TStream;
begin
  ws:= TwsSolicitudConsular.Create;

  res := ws.DataSolicitud('92747224','URY');
  if res.RESULTADO = 'OK' then
  begin
    Stream := TFileStream.Create('.\doc.JPG', fmCreate);
    Stream.WriteBuffer(Pointer(Decode64(res.DATOS.IMGDOC))^, Length(Decode64(res.DATOS.IMGDOC)));
    Stream.Free;

    Stream := TFileStream.Create('.\fac.JPG', fmCreate);
    Stream.WriteBuffer(Pointer(Decode64(res.DATOS.IMGFACIL))^, Length(Decode64(res.DATOS.IMGFACIL)));
    Stream.Free;
    ShowMessage('OK');
  end
  else
    ShowMessage('Sin biometria');


end;

end.
