unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,
  //;IWSValidarSemaforo1;
  WSValidarSemaforoImpl, WSValidarSemaforoIntf;

type
  TFMain = class(TForm)
    txtCodigoPaisDocumento: TEdit;
    lbPaisDoc: TLabel;
    Panel1: TPanel;
    lbNumeroDocumento: TLabel;
    txtNumeroDocumento: TEdit;
    txtFlag: TEdit;
    lbFlag: TLabel;
    lbFuncionario: TLabel;
    txtFuncionario: TEdit;
    txtObservacion: TMemo;
    lbObservacion: TLabel;
    btnEnviarRespuesta: TButton;
    btn1: TButton;
    procedure btnEnviarRespuestaClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

procedure TFMain.btnEnviarRespuestaClick(Sender: TObject);
{var d:TDatosEntrada;
    ws:IWSValidarSemaforo;   }
begin
   { d := TDatosEntrada.Create;
    d.CodigoPaisEmisor := txtCodigoPaisDocumento.Text;
    d.NumeroDocumento  := txtNumeroDocumento.Text;
    d.Flag := txtFlag.Text;
    d.Funcionario := txtFuncionario.Text;
    d.Observacion := txtObservacion.Text;

    ws := GetIWSValidarSemaforo(False);
    ws.EnviarRespuesta(d);  }
end;

procedure TFMain.btn1Click(Sender: TObject);
var d:TDatosEntrada;
    ws:TWSValidarSemaforo;
begin
    d := TDatosEntrada.Create;
    d.CodigoPaisEmisor := txtCodigoPaisDocumento.Text;
    d.NumeroDocumento  := txtNumeroDocumento.Text;
    d.Flag := txtFlag.Text;
    d.Funcionario := txtFuncionario.Text;
    d.Observacion := txtObservacion.Text;

    //ws := GetIWSValidarSemaforo(False);
    ws:=TWSValidarSemaforo.Create;
    ws.EnviarRespuesta(d);

end;

end.
