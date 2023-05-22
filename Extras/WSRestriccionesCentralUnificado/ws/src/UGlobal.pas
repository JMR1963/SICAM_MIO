unit UGlobal;



interface

uses  system.Classes, WsListaControlIntf, IdSMTP, IdMessage, IdEMailAddress;

var ip: string;
    URL : STRING;
    wSInterpol,WSURY : STRING;
    SERVER: STRING;
    WSPUENTE : STRING;
    ConsultaRestriccionCentral :string; // 1 Habilitado, 0 deshabilitado.-
    DesdeDondeLlamamos : string;
    serverAPI : string;


    procedure EnviarMail(unaPersona : XML_CONSULTA_NEW);

implementation



procedure EnviarMail(unaPersona : XML_CONSULTA_NEW);
var
  Smtp : TIdSMTP;
  MailMessage : TIdMessage;
  directorio,minutos_segundos,fecha,log_ad: String;
  lista: TStringList;

procedure AgregarDestinatariosMail(MailMessage : TIdMessage; unaLista : TStringList);
var
  eai : TIdEMailAddressItem;
  i : Integer;
begin
  MailMessage.Recipients.Clear;
  for i := 0 to unaLista.Count -1 do
  begin
    eai := MailMessage.Recipients.Add;
    eai.Address := unaLista.Strings[i];
  end;
end;

begin
//    DateTimeToIn(fecha,'yyyymmddHH',Now);
    try
      MailMessage := TIdMessage.Create(nil);
    except
      Exit;
    end;

    try
      Smtp := TIdSMTP.Create(nil);
      Smtp.Username := 'desarrollo_sistemas@migraciones.gov.ar';
      Smtp.Password := 'Windows7';
      Smtp.Host := 'webmail.migraciones.gov.ar';

     (** SI es con INDI 10 DESCOMENTAR el punto 1 , si es con INDY 9 COMENTAR el punto 1  **)
        (*1*)  Smtp.AuthType := satNone;    // para INDY 10
     (*********************)

    except
      MailMessage.Free;
      Exit;
    end;

    try
      MailMessage.From.Address := 'desarrollo_sistemas@migraciones.gov.ar';
      MailMessage.From.Name := 'Alerta.FPE';
      MailMessage.Subject := 'Alerta.FPE - ' + unaPersona.PASO  ;
      lista:=TStringList.Create;
      lista.Add('jbudrovich@migraciones.gov.ar');




      AgregarDestinatariosMail(MailMessage, lista);
      lista.Clear;
      lista.Add('ALERTA FPE');
      lista.Add(' ');
      lista.Add('Tipo de Documento: '+unaPersona.TIPODOC);
      lista.Add('Numero de Documento: '+unaPersona.NUMDOC);
      lista.Add('Emisor de Documento: '+unaPersona.EMISORDOC);
      lista.Add('Apellido1: '+unaPersona.APELLIDO1);
      lista.Add('Apellido12: '+unaPersona.APELLIDO2);
      lista.Add('Nombre1: '+unaPersona.NOMBRE1);
      lista.Add('Nombre12: '+unaPersona.NOMBRE2);
      lista.Add('Fecha de Nac: '+unaPersona.FECHANAC);
      lista.Add('Género: '+unaPersona.GENERO);
      lista.Add('Nacionalidad: '+unaPersona.NACIONALIDAD);
      lista.Add('Numero de Identificación: '+unaPersona.NUMEROIDENIFICACION);
      lista.Add('Usuario Consulta: '+ '123');
      lista.Add('Puesto de Control: '+unaPersona.PASO);


      MailMessage.Body.AddStrings(lista);


      (** SI es con INDY 10 comentar el punto 1 y descomentar 2 y 3, si es con INDY 9 al revez **)

       // (*1*) smtp.Connect(1000);         // para INDY 9
        (*2*) smtp.ConnectTimeout:=1000;    // para INDY 10
        (*3*) smtp.Connect;                 // para INDY 10

      (*********************)

      SMTP.Send(MailMessage);
      SMTP.Disconnect;

    except
     //on e:Exception do EscribirDatos(archivo, 'Excepcion enviando correo: ' + e.Message);
    end;

    Smtp.Free;
    MailMessage.Free;

end;


end.
