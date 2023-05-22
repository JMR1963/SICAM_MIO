unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ws_autorizacion_viajeIntf, ws_autorizacion_viajeImpl, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
  pe: Tpedido;
  res: tresultado;
  ws_prueba_u : Tws_autorizacion_viaje;
  otros_p: personas_varias;
  terceros: personas_varias;
begin
  pe := tpedido.Create;
  //---datos del menor.
  pe.menor := rmenor.Create;

  pe.menor.apellido             := 'PEREZ';
  pe.menor.segundo_apellido     := '';
  pe.menor.nombre               := 'JUAN';
  pe.menor.otros_nombres        := '';
  pe.menor.nacionalidad         := 'ARG';
  pe.menor.tipo_de_documento    := 'ID';
  pe.menor.emisor_documento     := 'ARG';
  pe.menor.numero_de_documento  := '5087598';
  pe.menor.fecha_de_nacimiento  := '09062005';
  pe.menor.Sexo                 := 'M';
  pe.menor.Domicilio            := 'calle 123 570';
  //Autorizante1
  pe.autorizante_1 := rautorizante.Create;
  pe.autorizante_1.apellido         := 'PEREZ';
  pe.autorizante_1.segundo_apellido := '';
  pe.autorizante_1.nombre           := 'ANSELMO';
  pe.autorizante_1.otros_nombres    := 'JAVIER';
  pe.autorizante_1.nacionalidad     := 'ARG';
  pe.autorizante_1.tipo_de_documento            := 'ID';
  pe.autorizante_1.emisor_documento             := 'ARG';
  pe.autorizante_1.numero_de_documento          := '27519668';
  pe.autorizante_1.fecha_de_nacimiento          := '16081979';
  pe.autorizante_1.sexo                         := 'M';
  pe.autorizante_1.domicilio                    := 'LANDA 570';
  pe.autorizante_1.caracter_primer_autorizante  := '1';
  pe.autorizante_1.acredita_vinculo_con         := '1';
  pe.autorizante_1.telefono                     := '0221-15-4401213';
  //autorizante2
  pe.autorizante_2 := rautorizante.Create;
  pe.autorizante_2.apellido                     := 'MARTINEZ';
  pe.autorizante_2.segundo_apellido             := '';
  pe.autorizante_2.nombre                       := 'MARIA';
  pe.autorizante_2.otros_nombres                := 'ALEJANDRA';
  pe.autorizante_2.nacionalidad                 := 'ARG';
  pe.autorizante_2.tipo_de_documento            := 'ID';
  pe.autorizante_2.emisor_documento             := 'ARG';
  pe.autorizante_2.numero_de_documento          := '27519668';
  pe.autorizante_2.fecha_de_nacimiento          := '16081979';
  pe.autorizante_2.sexo                         := 'M';
  pe.autorizante_2.domicilio                    := 'LANDA 570';
  pe.autorizante_2.caracter_primer_autorizante  := '1';
  pe.autorizante_2.acredita_vinculo_con         := '1';
  pe.autorizante_2.telefono                     := '0221-15-4401213';
  //Acompañante
  pe.acompanante :=racompanante.Create;
  pe.acompanante.viaja_solo := false;


  SetLength(otros_p, 1);
  otros_p[0] := rpersonas.Create;
  with otros_p[0] do
  begin
    apellido            := 'DUBERTI';
    segundo_apellido    := '';
    nombre              := 'EMILCE';
    otros_nombres       := '';
    tipo_de_documento   := 'ID';
    numero_de_documento := '29772951';
  end;

  pe.acompanante.otros_progenitores := otros_p;

  SetLength(terceros,1);

  terceros[0] := rpersonas.Create;
  with terceros[0] do
  begin
    apellido            := 'DARRAIN';
    segundo_apellido    := '';
    nombre              := 'ERNESTO';
    otros_nombres       := '';
    tipo_de_documento   := 'ID';
    numero_de_documento := '12345678';
  end;
  pe.acompanante.terceros := terceros;

  pe.datos_tramite := rdatos_tramite.Create;
  with pe.datos_tramite do
  begin
    distrito            := '';
    matricula           := '4818';
    nombres_escribano   := 'ANSELMO DARRAIN UNIT';
    apellidos_escribano := 'PANO';
    numero_actuacion_notarial_cert_firma := '2751966888';
    fecha_del_instrumento := '12122017';
    cualquier_pais  := TRUE;
    paises          := nil;
    serie_foja      := 'AA';
    tipo_foja       := '43';
    vigencia_hasta_mayoria_edad := true;
    instrumento := 'I';
    nro_foja := '0022';
  end;

  ws_prueba_u := Tws_autorizacion_viaje.Create();
  res := ws_prueba_u.grabar(pe);
  ShowMessage(inttostr(res.numero_autorizacion));
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  pe          : Tpedido;
  res         : tresultado;
  ws          : Tws_autorizacion_viaje;
  otros_p     : personas_varias;
  terceros    : personas_varias;
  resultado   : tresultado_revocar;
  solicitud   : trevocar;
  t: TStrings;
begin
  ws          := Tws_autorizacion_viaje.Create;
  solicitud   := trevocar.Create;

  with solicitud do
  begin
    numero_doc              := '27519668';
    numero_matricula        := '1324564';
    numero_act_notarial_cert_firma  := '56565';
    //FORMATO DE FECHA
    fecha                   := '16081979';
    //-------------------------------------------
    tipo_documento          := 'ID';
    nacionalidad_documento  := 'USA';
    {
      PATRIA POTESTAD - AMBOS PADRES     t     19
      PATRIA POTESTAD - MADRE            t     17
      PATRIA POTESTAD - PADRE            t     18
    }
    Entidad_emisora         := '19';
    Nombre                  := 'ANSELMO';
    Nombre2                 := '';
    Apellido                := 'DARRAIN';
    Apellido2               := '';
    Nacionalidad            := 'ESP';
    Fecha_de_nacimiento     := '16081979';
    Sexo                    := 'M';
    nombre_escribano        := 'ANSELMO';
  end;

  resultado := ws.revocar(solicitud);
  ShowMessage(res.error);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  pe: Tpedido;
  res: tresultado;
  ws_prueba_u : Tws_autorizacion_viaje;
  otros_p: personas_varias;
  terceros: personas_varias;
  id:TNumeroSolicitud;
begin
  pe := tpedido.Create;
  //---datos del menor.
  pe.menor := rmenor.Create;

  pe.menor.apellido             := 'PEREZ';
  pe.menor.segundo_apellido     := '';
  pe.menor.nombre               := 'JUAN';
  pe.menor.otros_nombres        := '';
  pe.menor.nacionalidad         := 'ARG';
  pe.menor.tipo_de_documento    := 'ID';
  pe.menor.emisor_documento     := 'ARG';
  pe.menor.numero_de_documento  := '41526378';
  pe.menor.fecha_de_nacimiento  := '16062010';
  pe.menor.Sexo                 := 'M';
  pe.menor.Domicilio            := 'calle 123 570';
  //Autorizante1
  pe.autorizante_1 := rautorizante.Create;
  pe.autorizante_1.apellido         := 'PEREZ';
  pe.autorizante_1.segundo_apellido := '';
  pe.autorizante_1.nombre           := 'JUANA';
  pe.autorizante_1.otros_nombres    := '';
  pe.autorizante_1.nacionalidad     := 'ARG';
  pe.autorizante_1.tipo_de_documento            := 'ID';
  pe.autorizante_1.emisor_documento             := 'ARG';
  pe.autorizante_1.numero_de_documento          := '18457654';
  pe.autorizante_1.fecha_de_nacimiento          := '10071975';
  pe.autorizante_1.sexo                         := 'F';
  pe.autorizante_1.domicilio                    := 'calle 123';
  pe.autorizante_1.caracter_primer_autorizante  := '2';
  pe.autorizante_1.acredita_vinculo_con         := '5';
  pe.autorizante_1.telefono                     := '41527845';
  //autorizante2
  pe.autorizante_2 := rautorizante.Create;
  pe.autorizante_2.apellido                     := '';
  pe.autorizante_2.segundo_apellido             := '';
  pe.autorizante_2.nombre                       := '';
  pe.autorizante_2.otros_nombres                := '';
  pe.autorizante_2.nacionalidad                 := '';
  pe.autorizante_2.tipo_de_documento            := '';
  pe.autorizante_2.emisor_documento             := '';
  pe.autorizante_2.numero_de_documento          := '';
  pe.autorizante_2.fecha_de_nacimiento          := '';
  pe.autorizante_2.sexo                         := '';
  pe.autorizante_2.domicilio                    := '';
  pe.autorizante_2.caracter_primer_autorizante  := '';
  pe.autorizante_2.acredita_vinculo_con         := '';
  pe.autorizante_2.telefono                     := '';
  //Acompañante
  pe.acompanante :=racompanante.Create;
  pe.acompanante.viaja_solo := false;


  SetLength(otros_p, 0);
  {
  otros_p[0] := rpersonas.Create;
  with otros_p[0] do
  begin
    apellido            := 'DUBERTI';
    segundo_apellido    := '';
    nombre              := 'EMILCE';
    otros_nombres       := '';
    tipo_de_documento   := 'ID';
    numero_de_documento := '29772951';
  end;

  pe.acompanante.otros_progenitores := otros_p;

  SetLength(terceros,1);

  terceros[0] := rpersonas.Create;
  with terceros[0] do
  begin
    apellido            := 'DARRAIN';
    segundo_apellido    := '';
    nombre              := 'ERNESTO';
    otros_nombres       := '';
    tipo_de_documento   := 'ID';
    numero_de_documento := '12345678';
  end;
  pe.acompanante.terceros := terceros;
  }
  pe.datos_tramite := rdatos_tramite.Create;
  with pe.datos_tramite do
  begin
    distrito            := '';
    matricula           := '4818';
    nombres_escribano   := 'SANTIAGO JOAQUIN ENRIQUE';
    apellidos_escribano := 'PANO';
    numero_actuacion_notarial_cert_firma := '9517534862';
    fecha_del_instrumento := '12122017';
    cualquier_pais  := TRUE;
    paises          := nil;
    serie_foja      := 'A';
    tipo_foja       := '4';
    vigencia_hasta_mayoria_edad := true;
  end;

  ws_prueba_u := Tws_autorizacion_viaje.Create();
  id := TNumeroSolicitud.Create;
  id.numero_solicitud := 6;
  res := ws_prueba_u.modificar(pe,id);
  ShowMessage(inttostr(res.numero_autorizacion));
end;

end.

