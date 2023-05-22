unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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

uses
wsRestriccionImpl ,
wsRestriccionintf;
//IwsRestriccion3;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
{var ws: IwsRestriccion;
    e: DatosEntrada;
    s: DatosSalida;     }
begin
  { e := DatosEntrada.Create;
   ws := GetIwsRestriccion(false,'http://172.16.192.111/cgi-bin/WSImpedimentosArgentina/WSImpedimentosArgentina/soap/IwsRestriccion',nil);
   e.USUARIO := 'pp';
   E.CLAVE:='';
   E.OPERADOR:='MGOROSITO';
   E.CODPAIS:= 'ARG';
   E.NOMBRE2:='YHIZETH';
   e.NOMBRE1 :='ESMERALDA';
   E.APELLIDO1:='xxxVASQUEZ';
   E.APELLIDO2 := 'MARMOL';
   E.NUMDOC:='AS022087';
   e.PUESTOCONTROL:='mipc';
   e.TIPODOC:='P';
   E.EMISORDOC:= 'COL';
   E.FECHANAC:='12/01/1989';
   E.GENERO:='M';
   E.NACIONALIDAD:= 'ARG';
   E.NUMEROIDENIFICACION:='AS02208777';
   E.PASO := 'LOCAL';
   S:= WS.ConsultaImpedimentosArgentina(E);

   ShowMessage(S.COD_RTA+' - '+S.COD_DETALLE_RTA +' - '+ S.OBSERVACIONES);
        }
end;

procedure TForm1.Button2Click(Sender: TObject);
var ws: TwsRestriccion;
    e: DatosEntrada;
    s: TRespuesta;
begin
ws:=  TwsRestriccion.Create;
   s:= TRespuesta.Create;

  S:= WS.buscarRestricciones('BUDROVICH',  'JUAN PABLO', '19810805','29067325','', 'M', 'ID', 'ARG','ARG','20310907'); //AAE237987

// S:= WS.buscarRestricciones('SANCHEZ',  'MARIANELA SOLEDAD', '19830616','30394861','', 'F', 'ID', 'ARG','ARG', '20330917' );

//   S:= WS.buscarRestricciones('LOPEZ',  'NATALIA', '19860316','32041141','' ,'F', 'ID', 'ARG','ARG' );  // '20330222'


//  S:= WS.buscarRestricciones('KORMAN',  'JUAN IGNACIO', '20161216','47572654','EX0452552', 'M', 'ID', 'ARG','ARG')     ;

//  S:= WS.buscarRestricciones('KORMAN',  'JUAN IGNACIO', '20160530','95675918','95675919', 'F', 'ID', 'ARG','ARG')     ;


   //S:= WS.buscarRestricciones('ARAUJO',  'RICARDO', '19850919','FK959123',' ');

     //S:= WS.buscarRestricciones('APPENDINO',  'CARLOS', '19740928','AAF434313','', 'M', );


   ShowMessage(s.Restriccion+ ' ' +s.Transporte+ ' -- '+s.TipoPasajero );

end;



procedure TForm1.Button3Click(Sender: TObject);
{var ws: IwsRestriccion;
    e: DatosEntrada;
    s: TRespuesta;    }
begin
  {ws:=  GetIwsRestriccion(true);
   s:= TRespuesta.Create;
//  S:= WS.buscarRestricciones('BUDROVICH',  'JUAN PABLO', '19810805','29067325','AAE237987');
//   S:= WS.buscarRestricciones('MENEM',  'CARLOS SAUL', '19900101','6705066','');
                                                      //02071930


   //  S:= WS.buscarRestricciones('BIACCHI',  'JUAN', '19680427','20035881N',' ');
//  S:= WS.buscarRestricciones('BUDROVICH',  'JUAN PABLO', '19810805','29067324','AAE237987', 'M', 'P', 'ARG','ARG');

S:= WS.buscarRestricciones('ANGELARO',  'MARIANA', '19631011','16495029','', 'F', 'ID', 'ARG','ARG')     ;

//   S:= WS.buscarRestricciones('AGUAD',  'ROSANA', '19641025','17037393','');
//  S:= WS.buscarRestricciones('AGUAD',  'ROSANA', '19700908','AAH893137','');
   ShowMessage(s.Restriccion+ ' ' +s.Transporte+ ' -- '+s.TipoPasajero ); }

end;

procedure TForm1.Button4Click(Sender: TObject);
var ws: TwsRestriccion;
    e: DatosEntrada;
    s: DatosSalida;
begin
   ws:=  TwsRestriccion.Create;
   e := DatosEntrada.Create;
   s := DatosSalida.Create;
   //ws := GetIwsRestriccion(false,'http://172.16.192.111/cgi-bin/WSImpedimentosArgentina/WSImpedimentosArgentina/soap/IwsRestriccion',nil);
   e.USUARIO := 'pp';
   E.CLAVE:='';
   E.OPERADOR:='MGOROSITO';
   E.CODPAIS:= 'ARG';
   E.NOMBRE2:='YHIZETH';
   e.NOMBRE1 :='ESMERALDA';
   E.APELLIDO1:='xxxVASQUEZ';
   E.APELLIDO2 := 'MARMOL';
   E.NUMDOC:='AS022087';
   e.PUESTOCONTROL:='mipc';
   e.TIPODOC:='P';
   E.EMISORDOC:= 'COL';
   E.FECHANAC:='12/01/1989';
   E.GENERO:='M';
   E.NACIONALIDAD:= 'ARG';
   E.NUMEROIDENIFICACION:='AS02208777';
   E.PASO := 'LOCAL';
   S:= WS.ConsultaImpedimentosArgentina(E);

   ShowMessage(S.COD_RTA+' - '+S.COD_DETALLE_RTA +' - '+ S.OBSERVACIONES);

end;

end.
