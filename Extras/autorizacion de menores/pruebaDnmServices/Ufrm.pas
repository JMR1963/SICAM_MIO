unit Ufrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, wsAutorizacionViaje, StdCtrls, Buttons;

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

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  ws: wsAutorizacionViajePortType;
  pe: tpedido;
  res : tresultado;
  otros_p: personas_varias;
  terceros: personas_varias;
begin
  pe := tpedido.Create;
  //---datos del menor.
  pe.usuario := 'CEPBSAS';
  pe.clave := 'dc9bc863bd5c3b7f5b2f26c8306c0497';
  pe.menor := rmenor.Create;

  pe.menor.apellido             := 'PEREZ';
  pe.menor.segundo_apellido     := '';
  pe.menor.nombre               := 'JUAN';
  pe.menor.otros_nombres        := '';
  pe.menor.nacionalidad         := 'ARG';
  pe.menor.tipo_de_documento    := 'ID';
  pe.menor.emisor_documento     := 'ARG';
  pe.menor.numero_de_documento  := '29884557';
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
  //Acompaņante
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
    nombres_escribano   := 'ANSELMO PANNO';
    apellidos_escribano := 'PANO';
    numero_actuacion_notarial_cert_firma := '05087598';
    fecha_del_instrumento := '29082022';
    cualquier_pais  := TRUE;
    paises          := nil;
    serie_foja      := 'A';
    tipo_foja       := '4';
    vigencia_hasta_mayoria_edad := true;
    instrumento := 'E';
    nro_foja := '0022';
  end;

  
  ws := GetwsAutorizacionViajePortType();
  res := ws.grabar(pe);
  ShowMessage(inttostr(res.numero_autorizacion));




end;

end.
