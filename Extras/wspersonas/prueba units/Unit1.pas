unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  //Iwebusersicam3;
  webusersicamImpl,webusersicamIntf;
type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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
var
  //ws : Iwebusersicam;
  ws :  twebusersicam;
  r  : aTransitos;
  i: integer;
begin
  try
    //while true do
    begin
      SetLength(r, 10);
      //ws := GetIwebusersicam(false);
       ws:= Twebusersicam.Create;
       if FileExists('log.txt') then
          memo1.Lines.LoadFromFile('log.txt');
  //    r := ws.findPersonAndTransit('ID','PARAGUAYA', 'SIN', '4621607');
      memo1.Lines.Add( DateTimeToStr(now) +  '----CONSULTANDO----');

      r := ws.findPersonAndTransit('ID','ARGENTINA', 'DNI', '57309053');
      for i:=0 to length(r)-1 do
      begin
        memo1.Lines.Add(r[i].Apellido1);
      end;
      memo1.Lines.Add( DateTimeToStr(now) +  '----FIN----');
      {
      if (length(r)>0) then
      begin
        Memo1.Lines.Add('Apellido 1: ' + r[0].Apellido1);
        Memo1.Lines.Add('Apellido 2: ' + r[0].Apellido2);
        Memo1.Lines.Add('Nombre 1: ' + r[0].Nombre1);
        Memo1.Lines.Add('Nombre 2: ' + r[0].Nombre2);
        Memo1.Lines.Add('Sexo: ' + r[0].Sexo);
        Memo1.Lines.Add('DocVenc: ' + r[0].DocVenc);
        Memo1.Lines.Add('DocNro: ' + r[0].DocNro);
        Memo1.Lines.Add('DocTipo: ' + r[0].DocTipo);
        Memo1.Lines.Add('DocPaisEmisor: ' + r[0].DocPaisEmisor);
        Memo1.Lines.Add('FechaNac: ' + r[0].FechaNac);
        Memo1.Lines.Add('Nacionalidad: ' + r[0].Nacionalidad);
        Memo1.Lines.Add('FechaCruce: ' + r[0].FechaCruce);
        Memo1.Lines.Add('PasoCruce: ' + r[0].PasoCruce);
        Memo1.Lines.Add('TipoCruce: ' + r[0].TipoCruce);
        Memo1.Lines.Add('DiasPermanencia: ' + r[0].DiasPermanencia);
     end;
      }
       // sleep(10000);

       // Memo1.Lines.SaveToFile('log.txt');
     end;
  EXCEPT
    ON E:EXCEPTION DO
    ShowMessage(E.MESSAGE);
  END

end;

procedure TForm1.Button3Click(Sender: TObject);
{var
 ws : Iwebusersicam;
  ar : aImagesTransit;   }
begin
 {ws := GetIwebusersicam(false);
  SetLength(ar, 2);
  ar := ws.findImagesTransit('P','ARGENTINA', 'SIN', '44667766N');
  Memo1.Lines.Add('Descripcion dacctilar: '+   ar[0].DescripcionDactilar);
  Memo1.Lines.Add('Nombre dacctilar: '+   ar[0].NombreDactilar);
  Memo1.Lines.Add('File dactilar: ' + ar[0].FileDactilar);        }
 // ShowMessage(ar[0].Apellido1);

end;

procedure TForm1.Button4Click(Sender: TObject);
{var
  wsUnit: Twebusersicam;
  ar: webusersicamIntf.aImagesTransit;    }
begin
 { wsUnit := Twebusersicam.Create;
  ar := wsUnit.findImagesTransit('P','ARGENTINA', 'SIN', '44667766N');
  Memo1.Lines.Add('Descripcion dacctilar: '+   ar[0].DescripcionDactilar);
  Memo1.Lines.Add('Nombre dacctilar: '+   ar[0].NombreDactilar);
  Memo1.Lines.Add('File dactilar: ' + ar[0].FileDactilar);
                                                              }

end;

end.
