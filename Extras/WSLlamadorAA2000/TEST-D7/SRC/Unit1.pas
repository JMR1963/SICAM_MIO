unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,manager,IwsLLamadorAA2000B5; //IwsLLamadorAA2000B4;//IwsLLamadorAA2000B2;
  //IwsLLamadorAA2000B1;//IwsLlamadorAA20005;//IwsLlamadorAA20004;//IwsLlamadorAA20001;

type
  TForm1 = class(TForm)
    btnHelloWord: TBitBtn;
    btnTurnos: TBitBtn;
    txtPuesto: TEdit;
    txtLetra: TEdit;
    txtNro: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    mmo1: TMemo;
    btnFinalizar: TBitBtn;
    btnReLLamar: TBitBtn;
    btn1: TBitBtn;
    txtCOLA: TEdit;
    txtTurno: TEdit;
    txtCant: TEdit;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    txtINI_COLA: TEdit;
    txtSTAR_COLA: TEdit;
    procedure btnHelloWordClick(Sender: TObject);
    procedure btnTurnosClick(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure btnReLLamarClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EndShift(actualQueue:QueuesShifts);
    procedure LimpiarForm;
  end;

var
  Form1: TForm1;

implementation

uses DateUtils;

{$R *.dfm}

procedure TForm1.btnHelloWordClick(Sender: TObject);
var ws:ManagerSoap;
    shift:QueuesShifts;
    actualQueue:QueuesShifts;
    queueDate:TDateTime;
    queueTime:TDateTime;
    queueTime2,queueStartTime,queueTime3,queueTime4: Double;
    text,text2,text3:string;
    
begin

    ws:=GetManagerSoap(false);
    ShowMessage (ws.HelloWorld);

    //EncodeDate()

    //FormatTime('hh:mm:ss.zzz', now)
    //queueDate:=EncodeD
    queueTime2:=MilliSecondOfTheDay(Now);
    Str(queueTime2, text);
    queueTime3:=MilliSecondsBetween(Now,0);
    Str(queueTime3,text2);

    queueTime4:=MilliSecondSpan(Now,0);
    Str(queueTime4,text3);

    ShowMessage(text + ' / ' + text2 + ' / ' + text3);

end;

procedure TForm1.EndShift(actualQueue: QueuesShifts);
begin
    //
end;



procedure TForm1.btnTurnosClick(Sender: TObject);
var ws:IwsLLamadorAA2000B;
    mTurno:TTurno;
    mEntrada:TData;
begin
//

    LimpiarForm;

    mEntrada:=TData.Create;

    //mEntrada.ID_COLA:= 'c69f08fc-3aef-4c7c-9c72-fba2a92843ef';
    mEntrada.ID_COLA:='19c3340e-1502-401c-97b8-560c974e27e2';
    mEntrada.BOX:='LEO';
    mEntrada.LETRA:='E';

    ws:=GetIwsLLamadorAA2000B(false);

    mTurno:=TTurno.Create;

    mTurno:=ws.Call(mEntrada);

    txtPuesto.Text:=mTurno.BOX;
    txtLetra.Text :=mTurno.LETRA;
    txtNro.Text   := mTurno.ORDEN;
    mmo1.Lines.Add(mTurno.ID_COLA + '//' + mTurno.ID_TURNO + '//' +
                   mTurno.XDIA_COLA + '//' + mturno.DESCRIPCION);

    txtCOLA.Text:= mTurno.ID_COLA;
    txtTurno.Text:= mTurno.ID_TURNO;
    txtCant.Text:= mTurno.CANT_RELLAMAR;
    txtINI_COLA.Text:=mTurno.XINI_COLA;
    txtSTAR_COLA.Text:=mTurno.XSTAR_COLA;
    txtCant.Text:=mTurno.CANT_RELLAMAR;


end;

procedure TForm1.LimpiarForm;
begin
    txtPuesto.Clear;
    txtLetra.Clear;
    txtNro.Clear;
    mmo1.Clear;
    txtCOLA.Clear;
    txtTurno.Clear;
    txtCant.Clear;
    txtINI_COLA.Clear;
    txtSTAR_COLA.Clear;
    txtCant.Clear;
end;

procedure TForm1.btnFinalizarClick(Sender: TObject);
var ws:IwsLLamadorAA2000B;
    mTurno:TTurno;
    sal:TRespuesta;

begin
    ws:=GetIwsLLamadorAA2000B(false);
    sal:=TRespuesta.Create;
    mTurno:=TTurno.Create;

    //mTurno.ID_TURNO:='398854ff-fe73-470b-b7a0-3062a58b68f8';
    //240e5326-4430-4255-b80c-df4314141e72
    //mTurno.ID_TURNO:='34a0e06e-b31d-4136-a2b1-5e45460205fb';
    //mTurno.ID_TURNO:='2f538262-dbd4-4376-9374-5eb5b8bc98a4';
    //mTurno.ID_COLA:= 'c69f08fc-3aef-4c7c-9c72-fba2a92843ef';
    mTurno.ID_TURNO:=trim(txtTurno.Text);
    mTurno.ID_COLA:= trim(txtCOLA.Text);
    mTurno.XDIA_COLA:='2021-03-05T00:00:00';
    mTurno.BOX:= txtPuesto.Text; //'DANIEL';
    mTurno.LETRA:= txtLetra.Text; //'A';
    mTurno.ORDEN:=txtNro.Text;   //'2';

    sal:=ws.Finish(mturno);
    LimpiarForm;

    mmo1.Lines.Add('FINALIZAR: ' + sal.ERROR + ' - ' + sal.DESCRIPCION);

end;

procedure TForm1.btnReLLamarClick(Sender: TObject);
var ws:IwsLLamadorAA2000B;
    mTurno:TTurno;
    sal:TRespuesta;

begin
    ws:=GetIwsLLamadorAA2000B(false);
    sal:=TRespuesta.Create;
    mTurno:=TTurno.Create;

    //mTurno.ID_TURNO:='398854ff-fe73-470b-b7a0-3062a58b68f8';
    //240e5326-4430-4255-b80c-df4314141e72
    //mTurno.ID_TURNO:='34a0e06e-b31d-4136-a2b1-5e45460205fb';
    //mTurno.ID_TURNO:='2c8829f0-9bf9-4920-838b-7ae6dfa1d51e';
   // mTurno.ID_COLA:= 'c69f08fc-3aef-4c7c-9c72-fba2a92843ef';
    mTurno.ID_TURNO:= Trim(txtTurno.Text);
    mTurno.ID_COLA:= Trim(txtCOLA.Text);
    mTurno.XDIA_COLA:='2021-03-05T00:00:00';
    mTurno.BOX:= txtPuesto.Text;//'DANIEL';
    mTurno.LETRA:= txtLetra.Text;//'E';
    mTurno.ORDEN:= txtNro.Text;//'2';
    mTurno.XINI_COLA:=Trim(txtINI_COLA.Text);//'39829000';
    mTurno.XSTAR_COLA:=Trim(txtSTAR_COLA.Text);//'39829000';
    mTurno.CANT_RELLAMAR:=txtCant.Text;

    sal:=ws.ReCall(mturno);

    mmo1.Lines.Add('RE-LLAMAR: ' + sal.ERROR + ' - ' + sal.DESCRIPCION);



end;

procedure TForm1.btn1Click(Sender: TObject);
var addr,URL:string;

begin
   URL:='http://server-llamador/ws/manager.asmx';
   Addr := Format('%s', [Url]);
   //Addr := Format('%s?WSDL', [Url]);
   ShowMessage(Addr);
end;

end.
