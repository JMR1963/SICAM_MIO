unit UTestWS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,{IWSActuaciones1,} StdCtrls, ExtCtrls, Buttons,ubase64,Jpeg,
  WSActuacionesIntf, WSActuacionesImpl;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    Image1: TImage;
    Edit1: TEdit;
    Button2: TButton;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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
  i : Integer;
  r : TResultado;
  E : TVectExpedientes;
  ws: TWSActuaciones;
begin
//  r:=GetIWSActuaciones.GetFotoHabilitaciones('861347','Sede Central');
//  i:= r.NroFilasHabilitaciones;

  ws := TWSActuaciones.Create;
  r := ws.GetExpedientes(48162010);
  {
  r:=GetIWSActuaciones.GetExpedientes(48162010);


  //r:=GetIWSActuaciones.GetExpedientes(1335202009);
  r:=GetIWSActuaciones.GetExpedientes(StrToInt(Edit1.Text));

  E:= r.FilasExpedientes;
  }


//  r:=GetIWSActuaciones.GetDisposiciones(5158);
{  i:= r.NroFilas;
  ShowMessage(IntTOStr(i));
  for i:=0 to r.NroFilas-1 do
  begin
    Memo1.Lines.Add('----------------------------------------------------');
    Memo1.Lines.Add('APELLIDO:'+r.Filas[i].APELLIDO);
    Memo1.Lines.Add('NOMBRE:'+r.Filas[i].NOMBRE);
    Memo1.Lines.Add('NRO_CUIM:'+r.Filas[i].NRO_CUIM);
    Memo1.Lines.Add('TIPO_DOC:'+r.Filas[i].TIPO_DOC);
    Memo1.Lines.Add('NUM_DOC:'+r.Filas[i].NUM_DOC);
    Memo1.Lines.Add('FECHA_NAC:'+r.Filas[i].FECHA_NAC);
    Memo1.Lines.Add('SEXO:'+r.Filas[i].SEXO);
    Memo1.Lines.Add('E_CIVIL:'+r.Filas[i].E_CIVIL);
    Memo1.Lines.Add('PAIS_NAC:'+r.Filas[i].PAIS_NAC);
    Memo1.Lines.Add('NACIONALIDAD:'+r.Filas[i].NACIONALIDAD);
    Memo1.Lines.Add('FECHA_INGRESO:'+r.Filas[i].FECHA_INGRESO);
    Memo1.Lines.Add('DOMICILIO:'+r.Filas[i].DOMICILIO);
    Memo1.Lines.Add('LOCALIDAD:'+r.Filas[i].LOCALIDAD);
    Memo1.Lines.Add('PROFESION:'+r.Filas[i].PROFESION);
    Memo1.Lines.Add('DATO_MADRE:'+r.Filas[i].DATO_MADRE);
    Memo1.Lines.Add('DATO_PADRE:'+r.Filas[i].DATO_PADRE);
    Memo1.Lines.Add('TIPO_ACTUACION:'+r.Filas[i].TIPO_ACTUACION);
    Memo1.Lines.Add('NRO_EXPEDIENTE:'+r.Filas[i].NRO_EXPEDIENTE);
    Memo1.Lines.Add('FECHA_INICIO:'+r.Filas[i].FECHA_INICIO);
    Memo1.Lines.Add('DELEGACION_INICIO:'+r.Filas[i].DELEGACION_INICIO);
    Memo1.Lines.Add('MOTIVO:'+r.Filas[i].MOTIVO);
    Memo1.Lines.Add('NORMA:'+r.Filas[i].NORMA);
    Memo1.Lines.Add('CATEGORIA_OBTENIDA:'+r.Filas[i].CATEGORIA_OBTENIDA);
    Memo1.Lines.Add('NRO_DISPO:'+r.Filas[i].NRO_DISPO);
    Memo1.Lines.Add('FECHA_DISPO:'+r.Filas[i].FECHA_DISPO);
    Memo1.Lines.Add('FECHA_RADICACION_DESDE:'+r.Filas[i].FECHA_RADICACION_DESDE);
    Memo1.Lines.Add('CATEGORIA_OBTENIDA:'+r.Filas[i].CATEGORIA_OBTENIDA);
    Memo1.Lines.Add('FECHA_VENCIMIENTO:'+r.Filas[i].FECHA_VENCIMIENTO);
    Memo1.Lines.Add('CONSULADO:'+r.Filas[i].CONSULADO);
    Memo1.Lines.Add('NRO_ACTO_CONSULAR:'+r.Filas[i].NRO_ACTO_CONSULAR);
    Memo1.Lines.Add('ANIO_ACTO_CONSULAR:'+r.Filas[i].ANIO_ACTO_CONSULAR);
    Memo1.Lines.Add('PERMANENCIA_AUTORIZADA_DNM:'+r.Filas[i].PERMANENCIA_AUTORIZADA_DNM);
    Memo1.Lines.Add('PERMANENCIA_AUTORIZADA_CONSUL:'+r.Filas[i].PERMANENCIA_AUTORIZADA_CONSUL);
  end;


  Memo1.Lines.Add('-----------');

//  exit;

  r:=GetIWSActuaciones.GetExpedientes(4143502008);
}
//  i:= r.NroFilas;
//  ShowMessage(IntTOStr(i));

  for i:=0 to LENGTH(E) -1 do
  begin
    Memo1.Lines.Add('----------------------------------------------------');
    Memo1.Lines.Add('APELLIDO:'+e[i].APELLIDO);
    Memo1.Lines.Add('NOMBRE:'+e[i].NOMBRE);
    Memo1.Lines.Add('NRO_CUIM:'+e[i].NRO_CUIM);
    Memo1.Lines.Add('TIPO_DOC:'+e[i].TIPO_DOC);
    Memo1.Lines.Add('NUM_DOC:'+e[i].NUM_DOC);
    Memo1.Lines.Add('FECHA_NAC:'+e[i].FECHA_NAC);
    Memo1.Lines.Add('SEXO:'+e[i].SEXO);
    Memo1.Lines.Add('E_CIVIL:'+e[i].E_CIVIL);
    Memo1.Lines.Add('PAIS_NAC:'+e[i].PAIS_NAC);
    Memo1.Lines.Add('NACIONALIDAD:'+e[i].NACIONALIDAD);
    Memo1.Lines.Add('FECHA_INGRESO:'+e[i].FECHA_INGRESO);
    Memo1.Lines.Add('DOMICILIO:'+e[i].DOMICILIO);
    Memo1.Lines.Add('LOCALIDAD:'+e[i].LOCALIDAD);
    Memo1.Lines.Add('PROFESION:'+e[i].PROFESION);
    Memo1.Lines.Add('DATO_MADRE:'+e[i].DATO_MADRE);
    Memo1.Lines.Add('DATO_PADRE:'+e[i].DATO_PADRE);
    Memo1.Lines.Add('TIPO_ACTUACION:'+e[i].TIPO_ACTUACION);
    Memo1.Lines.Add('NRO_EXPEDIENTE:'+e[i].NRO_EXPEDIENTE);
    Memo1.Lines.Add('FECHA_INICIO:'+e[i].FECHA_INICIO);
    Memo1.Lines.Add('DELEGACION_INICIO:'+e[i].DELEGACION_INICIO);
    Memo1.Lines.Add('MOTIVO:'+e[i].MOTIVO);
    Memo1.Lines.Add('NORMA:'+e[i].NORMA);
    Memo1.Lines.Add('CATEGORIA_OBTENIDA:'+e[i].CATEGORIA_OBTENIDA);
    Memo1.Lines.Add('NRO_DISPO:'+e[i].NRO_DISPO);
    Memo1.Lines.Add('FECHA_DISPO:'+e[i].FECHA_DISPO);
    Memo1.Lines.Add('FECHA_RADICACION_DESDE:'+e[i].FECHA_RADICACION_DESDE);
    Memo1.Lines.Add('CATEGORIA_OBTENIDA:'+e[i].CATEGORIA_OBTENIDA);
    Memo1.Lines.Add('FECHA_VENCIMIENTO:'+e[i].FECHA_VENCIMIENTO);
    Memo1.Lines.Add('CONSULADO:'+e[i].CONSULADO);
    Memo1.Lines.Add('NRO_ACTO_CONSULAR:'+e[i].NRO_ACTO_CONSULAR);
    Memo1.Lines.Add('ANIO_ACTO_CONSULAR:'+e[i].ANIO_ACTO_CONSULAR);
    Memo1.Lines.Add('PERMANENCIA_AUTORIZADA_DNM:'+e[i].PERMANENCIA_AUTORIZADA_DNM);
    Memo1.Lines.Add('PERMANENCIA_AUTORIZADA_CONSUL:'+e[i].PERMANENCIA_AUTORIZADA_CONSUL);
    BitBtn1Click(BitBtn1);
  end;  
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i : Integer;
  r : TResultado;
  E : TVectExpedientes;
  ws: TWSActuaciones;
  //s: string;
  s: TSituacionMig;


  jpg1: TJPEGImage;
  fotodeco : string;
  stre: TStringStream;
  w :    IWSActuaciones;

begin
//  r:=GetIWSActuaciones.GetFotoHabilitaciones('861347','Sede Central');
//  i:= r.NroFilasHabilitaciones;

  ws := TWSActuaciones.Create;
  s := ws.GetSituacionMigratoria('93385076');
  ShowMessage(s.SituacionMig +' - '+s.FechaVto );


  {ws := TWSActuaciones.Create;
  s := ws.GetFotoExpedientes(799146);
  ShowMessage(s);


   jpg1:=TJPEGImage.Create;
  fotodeco := Decode64(s);
  stre:= TStringStream.Create(fotodeco);
 // stre.writeBuffer(pointer(fotodeco)^, length(fotodeco));
  stre.Position:=0;
  jpg1.LoadFromStream(stre);
  jpg1.SaveToFile(GetEnvironmentVariable('UserProfile')+'\foto.jpg');
  stre.free;
  Image1.Picture.LoadFromFile(GetEnvironmentVariable('UserProfile')+'\foto.jpg');  }


end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var r:string;
  jpg1: TJPEGImage;
  bmp1 : tbitmap;
  fotodeco : string;
  stre: TStringStream;
  w :    IWSActuaciones;
begin
{
  w:=GetIWSActuaciones(false);
//  r:=w.GetFotoExpedientes(581095);
  r:=w.GetFotoExpedientes(StrToInt(Edit1.Text));
  jpg1:=TJPEGImage.Create;
  fotodeco := Decode64(r);
  stre:= TStringStream.Create(fotodeco);
 // stre.writeBuffer(pointer(fotodeco)^, length(fotodeco));
  stre.Position:=0;
  jpg1.LoadFromStream(stre);
  jpg1.SaveToFile(GetEnvironmentVariable('UserProfile')+'\foto.jpg');
  stre.free;
  Image1.Picture.LoadFromFile(GetEnvironmentVariable('UserProfile')+'\foto.jpg');
  //----imagen2

}
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  DeleteFile(GetEnvironmentVariable('UserProfile')+'\foto.jpg');
end;

end.
