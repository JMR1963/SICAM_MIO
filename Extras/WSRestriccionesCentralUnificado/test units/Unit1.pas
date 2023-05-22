unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, //UconsultaPFA,
  SqlOracleManage, DB, MemDS,
  DBAccess,
  WsListaControlImpl, WsListaControlIntf,
 // IWsListaControl_unif2,
  Ora, Buttons, Mask, UMaskEdit, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    btnIguazu: TButton;
    txtDesde: TSicamMaskEdit;
    txtHasta: TSicamMaskEdit;
    lbDesde: TLabel;
    lbHasta: TLabel;
    Conexion: TOraSession;
    OTransitos: TOraQuery;
    lbPorProcesar: TLabel;
    lbVarProcesados: TLabel;
    lbProcesados: TLabel;
    lbVarTotal: TLabel;
    BitBtn2: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnIguazuClick(Sender: TObject);
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
  consulta: XML_CONSULTA_new;
  i: integer;
  wsunit: TWsListaControl_unif;
  r: TRESULTADO_new;
begin


 wsunit := TWsListaControl_unif.Create;

  Consulta := XML_CONSULTA_new.Create;

  consulta.FUENTES   := 'URY';
  consulta.OPERADOR  := 'pruebaDNM-XXXXX-XXXXX-XXXXX-XXXXX-E-PEPE';  //ANSELMO-DARRAIN-I-INSPECTO
  consulta.NUMDOC    := '2101';
  consulta.APELLIDO1 := 'BUDROVICH';
  consulta.APELLIDO2 := '';
  consulta.NOMBRE1   := 'JUAN';
  consulta.NOMBRE2   := 'PABLO';
  consulta.FECHANAC  := '05/08/1981';
  consulta.GENERO    :=  'WWW-M';
  consulta.EMISORDOC := 'DEU';
  consulta.NUMEROIDENIFICACION := '2101';
  consulta.TIPODOC := 'P';
  consulta.NACIONALIDAD :='ARG'  ;
  consulta.PASO := 'PRUEBA';

   }
 {   consulta.FUENTES   := 'URY';
  consulta.OPERADOR  := 'pruebaDNM-XXXXX-XXXXX-XXXXX-XXXXX-E-PEPE';  //ANSELMO-DARRAIN-I-INSPECTO
  consulta.NUMDOC    := '40013790';
  consulta.APELLIDO1 := 'MALACRE';
  consulta.APELLIDO2 := 'LOPEZ';
  consulta.NOMBRE1   := 'JONATHAN';
  consulta.NOMBRE2   := 'ALEXANDRO';
  consulta.FECHANAC  := '02/05/1987';
  consulta.GENERO    :=  'WWW-M';
  consulta.EMISORDOC := 'URY';
  consulta.NUMEROIDENIFICACION := '';
  consulta.TIPODOC := 'ID';
  consulta.NACIONALIDAD :='URY'  ;
  consulta.PASO := 'PRUEBA';      }

 { consulta.FUENTES   := 'FPE,URY';
  consulta.OPERADOR  := 'pruebaDNM-XXXXX-XXXXX-XXXXX-XXXXX-E-PEPE';  //ANSELMO-DARRAIN-I-INSPECTO
  consulta.NUMDOC    := '60238752';
  consulta.APELLIDO1 := 'KORKUT';
  consulta.APELLIDO2 := '';
  consulta.NOMBRE1   := 'AHMET';
  consulta.NOMBRE2   := '';
  consulta.FECHANAC  := '01/01/1977';
  consulta.GENERO    :=  'WWW-M';
  consulta.EMISORDOC := 'PRY';
  consulta.NUMEROIDENIFICACION := '';
  consulta.TIPODOC := 'ID';
  consulta.NACIONALIDAD :='COL'  ;
  consulta.PASO := 'PRUEBA';     }


  r := wsunit.ConsultaRestriccion(Consulta);

  for i := 0 to length(r.fuentes)-1 do
    ShowMessage(r.fuentes[i].FUENTES + ' - ' + r.fuentes[i].ESTADO );


  for i:=low(r.restricciones) to high(r.restricciones) do
  begin
    showmessage(r.restricciones[i].FUENTE + ' - ' +
                r.restricciones[i].DESC_TIPO_DOC + ' - '          +
                r.restricciones[i].DOCTIPO + ' - '               +
                r.restricciones[i].NUM_DOC + ' - '                 +
                r.restricciones[i].PAIS_EMISOR_DOC + ' - '              +
                r.restricciones[i].APELLIDO + ' - '       +
                r.restricciones[i].APELLIDO2 + ' - '             +
                r.restricciones[i].NOMBRE  + ' - '       +
                r.restricciones[i].nombre2 + ' - '  +
                r.restricciones[i].NACIONALIDAD + ' - '  +
                r.restricciones[i].FECHA_NAC + ' - '  +
                r.restricciones[i].SEXO + ' - '  +
                r.restricciones[i].DESC_TIPO_RESTRICCION + ' - '  +
                r.restricciones[i].EXPED_DNM + ' - '  +
                r.restricciones[i].DESC_RESTRICCION + ' - '  +
                r.restricciones[i].DESC_CAUSA + ' - '   +
                r.restricciones[i].DESC_INSTRUCCION + ' - '  +
                r.restricciones[i].DESC_INSTRUCCION + ' - '  +
                r.restricciones[i].DESC_TIPO_JUSTICIA + ' - ' +
                r.restricciones[i].DESC_PROVINCIA     + ' - ' +
                r.restricciones[i].DESC_JUZGADOS + ' - '  +
                r.restricciones[i].DESC_LOCALIDAD + ' - ' +
                r.restricciones[i].DESC_ENTIDAD + ' - '  +
                r.restricciones[i].DESC_DELEGACION + ' - ' +
                r.restricciones[i].OBSERVACIONES   );

  end;


end;

procedure TForm1.Button2Click(Sender: TObject);
var consulta :XML_CONSULTA_NEW;
    res :TRESPUESTA_ARG;
    wsunit: TWsListaControl_unif;
    i:integer;
  r: TRESULTADO_new;
begin

  res:= TRESPUESTA_ARG.Create;
  wsunit := TWsListaControl_unif.Create;
  Consulta := XML_CONSULTA_new.Create;

  {
  consulta.OPERADOR  := 'adarrain';
  consulta.NUMDOC    := '6705066';
  consulta.USUARIO := 'MIGCOL';
  consulta.APELLIDO1 := 'MENEM';
  consulta.APELLIDO2 := '';
  consulta.NOMBRE1   := 'CARLOS';
  consulta.NOMBRE2   := 'SAUL';
  consulta.IP        := '';
  consulta.FECHANAC  := '02/07/1930';

  consulta.NUMEROIDENIFICACION := '6705066';
  consulta.GENERO := 'M';
  consulta.NACIONALIDAD := 'ESP';
  consulta.EMISORDOC := 'ARG';
  consulta.TIPODOC := 'ID' ;       }

{  consulta.OPERADOR  := 'adarrain';
  consulta.NUMDOC    := 'AS29067325';
  consulta.APELLIDO1 := 'BUDROVICH';
  consulta.APELLIDO2 := '';
  consulta.NOMBRE1   := 'JUAN';
  consulta.NOMBRE2   := '';
  consulta.IP        := '';
  consulta.FECHANAC  := '02/07/1930';  }

 { consulta.FUENTES   := 'DNM';

  res := wsunit.ConsultaRestriccionARG(consulta);

  ShowMessage(res.COD_RTA +' - ' +res.COD_DETALLE_RTA);

               }

 consulta.FUENTES   := 'URY';
  consulta.OPERADOR  := '';




  consulta.NUMDOC    := '55590206';
  consulta.APELLIDO1 := 'BUDROVICH';
  consulta.APELLIDO2 := 'BURGA';
  consulta.NOMBRE1   := 'JUAN';
  consulta.NOMBRE2   := 'PABLO';

  consulta.FECHANAC  := '05/08/1981';
  consulta.GENERO    :=  'M';
  consulta.NACIONALIDAD := 'URY';
  consulta.EMISORDOC := 'URY';
  consulta.NUMEROIDENIFICACION := '';
  consulta.TIPODOC := 'P' ;
  consulta.PASO := 'EZE';
  consulta.NUMEROIDENIFICACION:= '234234';




  r := wsunit.ConsultaRestriccionLocal(Consulta);

  for i := 0 to length(r.fuentes)-1 do
    ShowMessage(r.fuentes[i].FUENTES + ' - ' + r.fuentes[i].ESTADO );


  for i:=low(r.restricciones) to high(r.restricciones) do
  begin
    showmessage(r.restricciones[i].FUENTE + ' - ' +
                r.restricciones[i].DESC_TIPO_DOC + ' - '          +
                r.restricciones[i].DOCTIPO + ' - '               +
                r.restricciones[i].NUM_DOC + ' - '                 +
                r.restricciones[i].PAIS_EMISOR_DOC + ' - '              +
                r.restricciones[i].APELLIDO + ' - '       +
                r.restricciones[i].APELLIDO2 + ' - '             +
                r.restricciones[i].NOMBRE  + ' - '       +
                r.restricciones[i].nombre2 + ' - '  +
                r.restricciones[i].NACIONALIDAD + ' - '  +
                r.restricciones[i].FECHA_NAC + ' - '  +
                r.restricciones[i].SEXO + ' - '  +
                r.restricciones[i].DESC_TIPO_RESTRICCION + ' - '  +
                r.restricciones[i].EXPED_DNM + ' - '  +
                r.restricciones[i].DESC_RESTRICCION + ' - '  +
                r.restricciones[i].DESC_CAUSA + ' - '   +
                r.restricciones[i].DESC_INSTRUCCION + ' - '  +
                r.restricciones[i].DESC_INSTRUCCION + ' - '  +
                r.restricciones[i].DESC_TIPO_JUSTICIA + ' - ' +
                r.restricciones[i].DESC_PROVINCIA     + ' - ' +
                r.restricciones[i].DESC_JUZGADOS + ' - '  +
                r.restricciones[i].DESC_LOCALIDAD + ' - ' +
                r.restricciones[i].DESC_ENTIDAD + ' - '  +
                r.restricciones[i].DESC_DELEGACION + ' - '  );

  end;

end;

procedure TForm1.Button3Click(Sender: TObject);
{var
  consulta: XML_CONSULTA_new;
  i: integer;
  wsunit: iWsListaControl_unif;
  r: TRESULTADO_new; }
begin
{
   wsunit := GetIWsListaControl_Unif(true);
  Consulta := XML_CONSULTA_new.Create;





 consulta.FUENTES   := 'XPO';
  consulta.OPERADOR  := 'pruebaDNM-XXXXX-XXXXX-XXXXX-XXXXX-E-PEPE';  //ANSELMO-DARRAIN-I-INSPECTO
  consulta.NUMDOC    := '29067325';
  consulta.APELLIDO1 := 'BUDROVICH';
  consulta.APELLIDO2 := '';
  consulta.NOMBRE1   := 'JUAN';
  consulta.NOMBRE2   := 'PABLO';
  consulta.FECHANAC  := '05/08/1981';
  consulta.GENERO    :=  'M';
  consulta.EMISORDOC := 'COL';
  consulta.NUMEROIDENIFICACION := '';
  consulta.TIPODOC := 'ID';
  consulta.NACIONALIDAD :='ARG'  ;
  consulta.PASO := 'PRUEBA';


 r := wsunit.ConsultaRestriccion(Consulta);

  for i := 0 to length(r.fuentes)-1 do
    ShowMessage(r.fuentes[i].FUENTES + ' - ' + r.fuentes[i].ESTADO );


  for i:=low(r.restricciones) to high(r.restricciones) do
  begin
    showmessage(r.restricciones[i].FUENTE + ' - ' +
                r.restricciones[i].DESC_TIPO_DOC + ' - '          +
                r.restricciones[i].DOCTIPO + ' - '               +
                r.restricciones[i].NUM_DOC + ' - '                 +
                r.restricciones[i].PAIS_EMISOR_DOC + ' - '              +
                r.restricciones[i].APELLIDO + ' - '       +
                r.restricciones[i].APELLIDO2 + ' - '             +
                r.restricciones[i].NOMBRE  + ' - '       +
                r.restricciones[i].nombre2 + ' - '  +
                r.restricciones[i].NACIONALIDAD + ' - '  +
                r.restricciones[i].FECHA_NAC + ' - '  +
                r.restricciones[i].SEXO + ' - '  +
                r.restricciones[i].DESC_TIPO_RESTRICCION + ' - '  +
                r.restricciones[i].EXPED_DNM + ' - '  +
                r.restricciones[i].DESC_RESTRICCION + ' - '  +
                r.restricciones[i].DESC_CAUSA + ' - '   +
                r.restricciones[i].DESC_INSTRUCCION + ' - '  +
                r.restricciones[i].DESC_INSTRUCCION + ' - '  +
                r.restricciones[i].DESC_TIPO_JUSTICIA + ' - ' +
                r.restricciones[i].DESC_PROVINCIA     + ' - ' +
                r.restricciones[i].DESC_JUZGADOS + ' - '  +
                r.restricciones[i].DESC_LOCALIDAD + ' - ' +
                r.restricciones[i].DESC_ENTIDAD + ' - '  +
                r.restricciones[i].DESC_DELEGACION + ' - '  );

  end;        }

end;

procedure TForm1.Button4Click(Sender: TObject);
{var consulta :XML_CONSULTA_NEW;
    res :TRESPUESTA_ARG;
    wsunit: iWsListaControl_unif;    }
begin
 { res:= TRESPUESTA_ARG.Create;
  wsunit := GetIWsListaControl_Unif(true);
  Consulta := XML_CONSULTA_new.Create;
  consulta.OPERADOR  := 'adarrain';
  consulta.NUMDOC    := '6705066';
  consulta.APELLIDO1 := 'MENEM';
  consulta.APELLIDO2 := '';
  consulta.NOMBRE1   := 'CARLOS';
  consulta.NOMBRE2   := 'SAUL';
  consulta.IP        := '';
  consulta.FECHANAC  := '02/07/1930';
  consulta.FUENTES   := 'DNM';
  consulta.GENERO := 'M';
  consulta.NACIONALIDAD := 'ARG';
  consulta.EMISORDOC := 'ARG';
  consulta.NUMEROIDENIFICACION := '1234';
  consulta.TIPODOC := 'ID' ;
  consulta.PASO := 'PRUEBAS DNM CENTRAL';   }

 {consulta.NUMDOC    := '25535038';
  consulta.APELLIDO1 := 'MORALES';
  consulta.APELLIDO2 := '';
  consulta.NOMBRE1   := 'CARLOS';
  consulta.NOMBRE2   := 'ROBERTO';
  consulta.IP        := '';
  consulta.FECHANAC  := '03/11/1975';
  consulta.FUENTES   := 'DNM';
  consulta.GENERO := 'M';
  consulta.NACIONALIDAD := 'ARG';
  consulta.EMISORDOC := 'ARG';
  consulta.NUMEROIDENIFICACION := '25535038';
  consulta.TIPODOC := 'ID' ;
  consulta.PASO := 'PRUEBAS DNM CENTRAL';
                                                     }


    {
  res := wsunit.ConsultaRestriccionARG(consulta);

  ShowMessage(res.COD_RTA +' - ' +res.COD_DETALLE_RTA);     }

end;

procedure TForm1.BitBtn1Click(Sender: TObject);
 {
var
  consulta: XML_CONSULTA_new;
  i: integer;
  wsunit: iWsListaControl_unif;
  r: TRESULTADO_new;   }
begin

   {
 wsunit := GetIWsListaControl_Unif(true);
  Consulta := XML_CONSULTA_new.Create;
                                                  }


  {consulta.FUENTES   := 'PRY';
  consulta.OPERADOR  := 'dnm';
  consulta.NUMDOC    := '003292612';
  consulta.APELLIDO1 := 'DUARTE';
  consulta.APELLIDO2 := 'ALVAREZ';
  consulta.NOMBRE1   := 'RUBEN';
  consulta.NOMBRE2   := 'DARIO';
  consulta.FECHANAC  := '11/03/1981';
  consulta.GENERO    :=  'M';
  consulta.NACIONALIDAD := 'PRY';
  consulta.EMISORDOC := 'PRY';
  consulta.NUMEROIDENIFICACION := '123654';
  consulta.TIPODOC := 'PAS' ;
  consulta.PASO := 'EZE';}

 { consulta.FUENTES   := 'PRY';
  consulta.OPERADOR  := 'dnm';
  consulta.NUMDOC    := '003292612';
  consulta.APELLIDO1 := 'DUARTE';
  consulta.APELLIDO2 := 'ALVAREZ';
  consulta.NOMBRE1   := 'RUBEN';
  consulta.NOMBRE2   := 'DARIO';
  consulta.FECHANAC  := '11/03/1981';
  consulta.GENERO    :=  'M';
  consulta.NACIONALIDAD := 'PRY';
  consulta.EMISORDOC := 'PRY';
  consulta.NUMEROIDENIFICACION := '101101091241657383';
  consulta.TIPODOC := 'PAS' ;
  consulta.PASO := 'AIS';
  }


     {
  consulta.FUENTES   := 'PRY';
  consulta.OPERADOR  := 'dnm';
  consulta.NUMDOC    := '003292612';
  consulta.APELLIDO1 := 'DUARTE';
  consulta.APELLIDO2 := 'ALVAREZ';
  consulta.NOMBRE1   := 'RUBEN';
  consulta.NOMBRE2   := 'DARIO';
  consulta.FECHANAC  := '11/03/1981';
  consulta.GENERO    :=  'M';
  consulta.NACIONALIDAD := 'PRY';
  consulta.EMISORDOC := 'PRY';
    //consulta.NUMEROIDENIFICACION := '101101091241657383';
  consulta.TIPODOC := 'P' ;
  consulta.PASO := '';   }

  {consulta.FUENTES   := 'PRY';
  consulta.OPERADOR  := '';




  consulta.NUMDOC    := 'XDB360731';
  consulta.APELLIDO1 := 'BUDROVICH';
  consulta.APELLIDO2 := '';
  consulta.NOMBRE1   := 'JUAN';
  consulta.NOMBRE2   := 'PABLO';

  consulta.FECHANAC  := '05/08/1981';
  consulta.GENERO    :=  'M';
  consulta.NACIONALIDAD := 'ESP';
  consulta.EMISORDOC := 'ESP';
  consulta.NUMEROIDENIFICACION := '';
  consulta.TIPODOC := 'P' ;
  consulta.PASO := 'EZE';
                                 }

    {

  r := wsunit.ConsultaRestriccionLocal(Consulta);

  for i := 0 to length(r.fuentes)-1 do
    ShowMessage(r.fuentes[i].FUENTES + ' - ' + r.fuentes[i].ESTADO );


  for i:=low(r.restricciones) to high(r.restricciones) do
  begin
    showmessage(r.restricciones[i].FUENTE + ' - ' +
                r.restricciones[i].DESC_TIPO_DOC + ' - '          +
                r.restricciones[i].DOCTIPO + ' - '               +
                r.restricciones[i].NUM_DOC + ' - '                 +
                r.restricciones[i].PAIS_EMISOR_DOC + ' - '              +
                r.restricciones[i].APELLIDO + ' - '       +
                r.restricciones[i].APELLIDO2 + ' - '             +
                r.restricciones[i].NOMBRE  + ' - '       +
                r.restricciones[i].nombre2 + ' - '  +
                r.restricciones[i].NACIONALIDAD + ' - '  +
                r.restricciones[i].FECHA_NAC + ' - '  +
                r.restricciones[i].SEXO + ' - '  +
                r.restricciones[i].DESC_TIPO_RESTRICCION + ' - '  +
                r.restricciones[i].EXPED_DNM + ' - '  +
                r.restricciones[i].DESC_RESTRICCION + ' - '  +
                r.restricciones[i].DESC_CAUSA + ' - '   +
                r.restricciones[i].DESC_INSTRUCCION + ' - '  +
                r.restricciones[i].DESC_INSTRUCCION + ' - '  +
                r.restricciones[i].DESC_TIPO_JUSTICIA + ' - ' +
                r.restricciones[i].DESC_PROVINCIA     + ' - ' +
                r.restricciones[i].DESC_JUZGADOS + ' - '  +
                r.restricciones[i].DESC_LOCALIDAD + ' - ' +
                r.restricciones[i].DESC_ENTIDAD + ' - '  +
                r.restricciones[i].DESC_DELEGACION + ' - '  );

  end;     }



end;

procedure TForm1.btnIguazuClick(Sender: TObject);
{var
  consulta: XML_CONSULTA_new;
  i,i2: integer;
  wsunit: iWsListaControl_unif;
  r: TRESULTADO_new;
  registro:AnsiString;
  f:TextFile;  }
begin
   { wsunit := GetIWsListaControl_Unif(true);
    Consulta := XML_CONSULTA_new.Create;

    with OTransitos do
    begin
      Close;
      ParamByName('FECHA_1').AsString := txtDesde.Text;
      ParamByName('FECHA_2').AsString := txtHasta.Text;
      Open;
      Connection.Commit;

      if not IsEmpty then
      begin
        Last;
        First;

        lbVarProcesados.Caption := IntToStr(RecordCount);
        Application.ProcessMessages;

        while not Eof do
        begin
          try
            consulta.FUENTES   := 'XPO';


            //Limpio
            consulta.OPERADOR  :=  '';
            consulta.NUMDOC    :=  '';
            consulta.APELLIDO1 :=   '';
            consulta.APELLIDO2 :=   '';
            consulta.NOMBRE1   :=   '';
            consulta.NOMBRE2   :=   '';
            consulta.FECHANAC  :=   '';
            consulta.GENERO    :=   '';
            consulta.EMISORDOC :=   '';
            consulta.NUMEROIDENIFICACION :=   '';
            consulta.TIPODOC :=   '';
            consulta.NACIONALIDAD :=   '';
            consulta.PASO :=   '';

            //cARGO
            consulta.OPERADOR  :=  FieldByName('RUSUARIOREGISTROUSISTEMA').AsString  + '-' +
                                   FieldByName('RUSUARIOREGISTRONOMBRES').AsString   + '-' +
                                   FieldByName('RUSUARIOREGISTROAPELLIDOS').AsString + '-I-XXX-' +
                                   FieldByName('RTRANSITODIRECCION').AsString + '-BRA021';

            //consulta.OPERADOR  := 'SISTEMAS-XXX-XXX-XXX-I-XXX-' + FieldByName('RTRANSITODIRECCION').AsString + '-BRA021';
            consulta.NUMDOC    := FieldByName('RDOCNUMERO').AsString;
            consulta.APELLIDO1 := FieldByName('RAPELLIDO1').AsString;
            consulta.APELLIDO2 := FieldByName('RAPELLIDO2').AsString;
            consulta.NOMBRE1   := FieldByName('RNOMBRE1').AsString;
            consulta.NOMBRE2   := FieldByName('RNOMBRE2').AsString;
            consulta.FECHANAC  := FieldByName('RFECNAC').AsString;
            consulta.GENERO    := FieldByName('RSEXO').AsString;
            consulta.EMISORDOC := FieldByName('RPAISEMISORETIQ').AsString;
            consulta.NUMEROIDENIFICACION := FieldByName('RPRECARIANROPRECARIA').AsString;
            consulta.TIPODOC := FieldByName('RDOCTIPO').AsString;
           //ESTA MAL EL CAMPO RGNANACIONALIDAD
            consulta.NACIONALIDAD := FieldByName('RNACIONALIDADETIQ').AsString;

            consulta.PASO := 'IGUAZU';

            registro := 'FUENTES = '  + consulta.FUENTES  + #13 +
                        'OPERADOR = '  + consulta.OPERADOR  + #13 +
                        'NUMDOC = '    + consulta.NUMDOC    + #13 +
                        'APELLIDO1 = ' + consulta.APELLIDO1 + #13 +
                        'APELLIDO2 = ' + consulta.APELLIDO2 + #13 +
                        'NOMBRE1 = '   + consulta.NOMBRE1   + #13 +
                        'NOMBRE2 = '   + consulta.NOMBRE2   + #13 +
                        'FECHANAC = '  + consulta.FECHANAC  + #13 +
                        'GENERO = '    + consulta.GENERO    + #13 +
                        'EMISORDOC = ' + consulta.NUMEROIDENIFICACION + #13 +
                        'TIPODOC = '   + consulta.TIPODOC   + #13 +
                        'NACIONALIDAD = ' + consulta.NACIONALIDAD + #13 +
                        'PASO = '      + consulta.PASO;

            r := wsunit.ConsultaRestriccion(Consulta);     }

         {   for i2 := 0 to length(r.fuentes)-1 do
              ShowMessage(r.fuentes[i].FUENTES + ' - ' + r.fuentes[i].ESTADO );

            i2 := 0;

            for i2:=low(r.restricciones) to high(r.restricciones) do
            begin
              showmessage(r.restricciones[i].FUENTE + ' - ' +
                          r.restricciones[i].DESC_TIPO_DOC + ' - '          +
                          r.restricciones[i].DOCTIPO + ' - '               +
                          r.restricciones[i].NUM_DOC + ' - '                 +
                          r.restricciones[i].PAIS_EMISOR_DOC + ' - '              +
                          r.restricciones[i].APELLIDO + ' - '       +
                          r.restricciones[i].APELLIDO2 + ' - '             +
                          r.restricciones[i].NOMBRE  + ' - '       +
                          r.restricciones[i].nombre2 + ' - '  +
                          r.restricciones[i].NACIONALIDAD + ' - '  +
                          r.restricciones[i].FECHA_NAC + ' - '  +
                          r.restricciones[i].SEXO + ' - '  +
                          r.restricciones[i].DESC_TIPO_RESTRICCION + ' - '  +
                          r.restricciones[i].EXPED_DNM + ' - '  +
                          r.restricciones[i].DESC_RESTRICCION + ' - '  +
                          r.restricciones[i].DESC_CAUSA + ' - '   +
                          r.restricciones[i].DESC_INSTRUCCION + ' - '  +
                          r.restricciones[i].DESC_INSTRUCCION + ' - '  +
                          r.restricciones[i].DESC_TIPO_JUSTICIA + ' - ' +
                          r.restricciones[i].DESC_PROVINCIA     + ' - ' +
                          r.restricciones[i].DESC_JUZGADOS + ' - '  +
                          r.restricciones[i].DESC_LOCALIDAD + ' - ' +
                          r.restricciones[i].DESC_ENTIDAD + ' - '  +
                          r.restricciones[i].DESC_DELEGACION + ' - '  );

            end;        }

  {          Next;
          //  Sleep(250);
            inc(i);
            lbVarTotal.Caption := IntToStr(i);
            Application.ProcessMessages;
          except

            on e:exception do
            begin
              AssignFile(f,ExtractFilePath(Application.ExeName) + '.\Erroneos.txt');
              Rewrite(f);
              write(f, 'Error en registro: ' + #13 + registro);
              write(f, '//------------------------------------------------//');
              CloseFile(f);
            end;

          end;
        end;
      end;
    end;           }

end;

end.
