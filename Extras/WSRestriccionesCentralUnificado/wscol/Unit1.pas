unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,InvokeRegistry, Rio, SOAPHTTPClient,
  Buttons, consultaArgentina1;

type
  Tllamadas = class(TForm)
    Button1: TButton;
    Button2: TButton;
    HTTPRIO1: THTTPRIO;
    mRequest: TMemo;
    mResponse: TMemo;
    BitBtn1: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure HTTPRIO1AfterExecute(const MethodName: String;
      SOAPResponse: TStream);
    procedure HTTPRIO1BeforeExecute(const MethodName: String;
      var SOAPRequest: WideString);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  llamadas: Tllamadas;

implementation

uses Unit2;

{$R *.dfm}




procedure Tllamadas.Button1Click(Sender: TObject);
{var
  //ws : ConsultaAlianzaArgentina;
    ws : AlianzaArgentinaService;
  str: respuestaAlianza;


  (* estas dos variables se reeplazan por la clase del Ws de los Colombianos!  *)
  CodRespuesta, codDetalleRespuesta: integer;   }

begin

  (* estas dos variables se reeplazan por la clase del Ws de los Colombianos!  *)
 { CodRespuesta:= -1;
  codDetalleRespuesta:= -1;



    str := respuestaAlianza.Create;      }
    //ws := GetConsultaAlianzaArgentina(TRUE);
   { ws := GetAlianzaArgentinaService(FALSE);
    str := ws.consultarPersona('PAS',
                               'AR353804',
                               'COL',
                               '123',
                               'MIGUEL',
                               'ROBERTO',
                               'GUERRERO',
                               'AYCARDI',
                               '1982/11/03',
                               'M',
                               'COL',
                               'ARG',
                               'PRUEBA');   }
   {
  str:= (HTTPRIO1 as AlianzaArgentinaService).consultarPersona('PAS',
                               'AR353804',
                               'COL',
                               '',
                               'MIGUEL',
                               'ROBERTO',
                               'GUERRERO',
                               'AYCARDI',
                               '1982-11-03',
                               'M',
                               'COL',
                               'ARG',
                               'PRUEBA');


    ShowMessage(inttostr(str.codigoError));
   ShowMessage(inttostr(str.codigoRespuesta));         }



end;

procedure Tllamadas.Button2Click(Sender: TObject);
begin
 try
   Form2:= TForm2.create(nil);
   form2.showmodal;
 finally
   FreeAndNil(form2);
 end;
end;

procedure Tllamadas.HTTPRIO1BeforeExecute(const MethodName: String;
  var SOAPRequest: WideString);
var  a, b,c,d,e :AnsiString;
begin
  a:=StringReplace(SoapRequest,'<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">','<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">',[rfReplaceAll] );
  b:=StringReplace(a,'consultarPersona','ser:consultarPersona',[rfReplaceAll] );
  c:=StringReplace(b, 'xmlns="http://servicio.migracion.gov.co/','xmlns:ser="http://servicio.migracion.gov.co/',[rfReplaceAll] );
  d:=StringReplace(c, 'xsd:','',[rfReplaceAll] ) ;
  e:=StringReplace(d, 'SOAP-ENV','soapenv',[rfReplaceAll] ) ;
  SoapRequest:=StringReplace(e, 'xsd','',[rfReplaceAll] ) ;


  mRequest.Lines.Text := SoapRequest;
end;


procedure Tllamadas.HTTPRIO1AfterExecute(const MethodName: String;
  SOAPResponse: TStream);
begin
  SoapResponse.Position := 0;
  mResponse.Lines.LoadFromStream(SoapResponse);

end;


procedure Tllamadas.BitBtn1Click(Sender: TObject);
var
  //ws : ConsultaAlianzaArgentina;
    ws : AlianzaArgentinaService;
  str: respuestaAlianza;


  (* estas dos variables se reeplazan por la clase del Ws de los Colombianos!  *)
  CodRespuesta, codDetalleRespuesta: integer;

begin

  (* estas dos variables se reeplazan por la clase del Ws de los Colombianos!  *)
  CodRespuesta:= -1;
  codDetalleRespuesta:= -1;



    str := respuestaAlianza.Create;
    //ws := GetConsultaAlianzaArgentina(TRUE);
    ws := GetAlianzaArgentinaService(false);
    {str := ws.consultarPersona('PAS',
                               'AR353804',
                               'COL',
                               '123',
                               'MIGUEL',
                               'ROBERTO',
                               'GUERRERO',
                               'AYCARDI',
                               '1982/11/03',
                               'M',
                               'COL',
                               'ARG',
                               'PRUEBA');  }

  str:= (HTTPRIO1 as AlianzaArgentinaService).consultarPersona('CI',
                               '29067325',
                               'COL',
                               '',
                               'BUDROVICH',
                               '',
                               'JUAN',
                               'PABLO',
                               '1981/08/05',
                               'M',
                               'COL',
                               'ARG',
                               'PRUEBA');


   ShowMessage(inttostr(str.codigoRespuesta));
   ShowMessage(inttostr(str.codigoError));


end;

end.
