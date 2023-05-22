unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  TRANSITOSGNAImpl,
  TRANSITOSGNAIntf;

type
  TForm1 = class(TForm)
    DoRequestNew: TButton;
    doRequestAmpliada: TButton;
    doRequest: TButton;
    Button1: TButton;
    Button2: TButton;
    procedure DoRequestNewClick(Sender: TObject);
    procedure doRequestAmpliadaClick(Sender: TObject);
    procedure doRequestClick(Sender: TObject);
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

procedure TForm1.DoRequestNewClick(Sender: TObject);
var ws : TTRANSITOSGNA;
    resP : trespuesta;
    con: TConsultaNew;
begin

    ws := TTRANSITOSGNA.Create;
    CON:= TConsultaNew.Create;
    con.USUARIO := 'jburovich';
    con.CLAVE := '12356';
    con.OPERADOR := 'jbudrovich';
{    con.NUMDOC := 29067325;
    con.APELLIDO1:= 'BUDROVICH';
    con.APELLIDO2:= '';
    con.NOMBRE1 := 'JUAN';
    con.NOMBRE2  := 'PABLO';
    con.SEXO:= 'M';
    con.FECHANAC:= '05/08/1981';  }

    //con.NUMDOC := 12232209 2;
  {  con.APELLIDO1:= 'OSSANDON';
    con.APELLIDO2:= 'WILLIAMSON';
    con.NOMBRE1 := 'ELIZABETH';
    con.NOMBRE2  := '';
    con.NACIONALIDAD:= 'ARGENTINA';
    con.FECHANAC:= '30/04/1972';    }

     con.APELLIDO1:= 'BUDROVICH';
    con.APELLIDO2:= '';
    con.NOMBRE1 := 'JUAN';
    con.NOMBRE2  := 'PABLO';
    con.NACIONALIDAD:= 'ARGENTINA';
    con.FECHANAC:= '05/08/1981';




    resP:= ws.doRequestNew(CON);
    ShowMessage('VER');

end;

procedure TForm1.doRequestAmpliadaClick(Sender: TObject);

 var ws : TTRANSITOSGNA;
    resP : TRespuestaAmpliada;
    con: TConsulta;
begin

    ws := TTRANSITOSGNA.Create;
    CON:= TConsulta.Create;
    con.USUARIO := 'jburovich';
    con.CLAVE := '12356';
    con.OPERADOR := 'jbudrovich';
    con.NUMDOC := 29067325;
    con.APELLIDO1:= 'BUDROVICH';
    con.APELLIDO2:= '';
    con.NOMBRE1 := 'JUAN';
    con.NOMBRE2  := 'PABLO';



    //con.NUMDOC := 12232209 2;
  {  con.APELLIDO1:= 'OSSANDON';
    con.APELLIDO2:= 'WILLIAMSON';
    con.NOMBRE1 := 'ELIZABETH';
    con.NOMBRE2  := '';
    con.NACIONALIDAD:= 'ARGENTINA';
    con.FECHANAC:= '30/04/1972';    }






    resP:= ws.doRequestAmpliada(CON);
    ShowMessage('VER');

end;

procedure TForm1.doRequestClick(Sender: TObject);
 var ws : TTRANSITOSGNA;
    resP : TRespuesta;
    con: TConsulta;
begin

    ws := TTRANSITOSGNA.Create;
    CON:= TConsulta.Create;
   { con.USUARIO := 'jburovich';
    con.CLAVE := '12356';
    con.OPERADOR := 'jbudrovich';
    con.NUMDOC := 29067325;
    con.APELLIDO1:= '';//'BUDROVICH';
    con.APELLIDO2:= '';
    con.NOMBRE1 := '';//'JUAN';
    con.NOMBRE2  := '';//'PABLO';
  }

      con.USUARIO := 'jburovich';
    con.CLAVE := '12356';
    con.OPERADOR := 'jbudrovich';
    con.NUMDOC := 12929210;
    con.APELLIDO1:= '';//'BUDROVICH';
    con.APELLIDO2:= '';
    con.NOMBRE1 := '';//'JUAN';
    con.NOMBRE2  := '';//'PABLO';

    //con.NUMDOC := 12232209 2;
  {  con.APELLIDO1:= 'OSSANDON';
    con.APELLIDO2:= 'WILLIAMSON';
    con.NOMBRE1 := 'ELIZABETH';
    con.NOMBRE2  := '';
    con.NACIONALIDAD:= 'ARGENTINA';
    con.FECHANAC:= '30/04/1972';    }






    resP:= ws.doRequest(CON);
    ShowMessage('VER');

end;

procedure TForm1.Button1Click(Sender: TObject);
 var ws : TTRANSITOSGNA;
    resP : TRespuesta;

begin

    ws := TTRANSITOSGNA.Create;






    //con.NUMDOC := 12232209 2;
  {  con.APELLIDO1:= 'OSSANDON';
    con.APELLIDO2:= 'WILLIAMSON';
    con.NOMBRE1 := 'ELIZABETH';
    con.NOMBRE2  := '';
    con.NACIONALIDAD:= 'ARGENTINA';
    con.FECHANAC:= '30/04/1972';    }






    resP:= ws.doRequestPersons('07-10-2017','AA-997' );
    ShowMessage('VER');

end;

end.
