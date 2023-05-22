unit UTest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    btn5: TButton;
    mmo1: TMemo;
    edtenca: TEdit;
    edtID: TEdit;
    lbl1: TLabel;
    btn6: TButton;
    mmoFM: TMemo;
    btn7: TButton;
    edtWSP: TEdit;
    edtRESTP: TEdit;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses EgateFunciones,IEGateMgrWS112,IdHTTP;

var
  idT:string;


procedure TForm1.btn1Click(Sender: TObject);
var
  trans: Transaction;
  D:ArrayOf_tns1_DocumentImage;
  r:TransactionResult;
begin
  idT := edtenca.Text +'E_'+FormatDateTime('YYYYMMDDHHMMSS',now)+'_'+IntToStr(Random(1000));

  trans:= Transaction.Create;
  trans.transactionId :=idT;
  trans.egateID := edtID.Text;


//trans.MRZ :=  'IDARG21480516<7<<<<<<<<<<<<<<<'+#13#10+'7001017M2610313ARG<<<<<<<<<<<2'+#13#10+'VEIGA<<DANIEL<ARTURO<<<<<<<<<<';
// trans.MRZ :='IDARG17605376<9<<<<<<<<<<<<<<'+#13#10+'6509066M2703062ARG<<<<<<<<<<<'+#13#10+'GARCIA<ZIVANO<<GUSTAVO<RAFAEL';
 trans.MRZ :='IDARG17605376<9<<<<<<<<<<<<<<<'+#13#10+'6509061M2703062ARG<<<<<<<<<<<6'+#13#10+'GARCIA<ZIVANO<<GUSTAVO<RAFAEL<';

//FECHA_TRANSACTION	TRANSACTIONID	APELLIDO	NOMBRE	MRZ

//IDARG17605376<9<<<<<<<<<<<<<<<
//6509061M2703062ARG<<<<<<<<<<<6
//GARCIA<ZIVANO<<GUSTAVO<RAFAEL<

//trans.MRZ :='IDARG20426371<5<<<<<<<<<<<<<<'+#13#10+'6809021M2711047ARG<<<<<<<<<<<'+#13#10+'VETERE<<ENRIQUE<CARLOS<<<<<<<';
//  trans.MRZ := 'IDARG17605376<9<<<<<<<<<<<<<<<'+#13#10+'6509061M2703062ARG<<<<<<<<<<<6'+#13#10+'GARCIA<ZIVANO<<GUSTAVO<RAFAEL<';
 // trans.MRZ := 'P<ARGCHMIELEWSKI<<JUAN<PABLO<<<<<<<<<<<<<<<<'+#13#10+'32772126N5ARG8707110M210601000000000<<<<<<08';
//  trans.MRZ := 'IDARG29067325<6<<<<<<<<<<<<<<<'+#13#10+'8108050M3109074ARG<<<<<<<<<<<6'+#13#10+'BUDROVICH<<JUAN<PABLO<<<<<<<<<';

  trans.gateGroup := 'TEST';
  SetLength(D,2);
  D[0]:=DocumentImage.Create;
  D[0].documentImageType:=1;
  D[0].Image:=FIleToByteArray('C:\egateMEGA\pruebas\fm\ARG-VIS-True.jpg');
  D[1]:=DocumentImage.Create;
  D[1].documentImageType:=2;
  D[1].Image:=FIleToByteArray('C:\egateMEGA\pruebas\fm\ARG-UV-True.jpg');


  trans.DocumentImages := D;
  r := GetIEGateMgrWS.InitTransaction(trans);

  mmo1.Lines.Add('InitTransaction:'+IntToStr(r.transactionResultCode));

  trans.Free;
  r.Free;
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  trans: Transaction;
//  D:DocumentImages;
  R:BiometricData;
begin
  trans:= Transaction.Create;
  trans.transactionId := idT;
  //trans.transactionId :='e4d79ac9-f082-41f5-b7df-425e9d0e071f';
  trans.egateID := edtID.Text;
 // trans.MRZ :='IDARG21431989<7<<<<<<<<<<<<<<<'+#13#10+'7004166M2812106ARG<<<<<<<<<<<6'+#13#10+'MARABINI<<FRANCISCO<JOSE<<<<<<';


  R:= GetIEGateMgrWS.getBiometricData(trans);


  mmo1.Lines.Add('getBiometricData:'+r.transport);
  r.Free;
  trans.free;
end;

procedure TForm1.btn3Click(Sender: TObject);
var
  trans: Transaction;
begin
  mmo1.Lines.Add('>>>>>>>>>>>>>>>>>> '+DateTimeToStr(now));
  trans:= Transaction.Create;
  trans.transactionId := idT;
  trans.egateID := '1';
  trans.MRZ :='IDARG21431989<7<<<<<<<<<<<<<<<'+#13#10+'7004166M2812106ARG<<<<<<<<<<<6'+#13#10+'MARABINI<<FRANCISCO<JOSE<<<<<<';


  mmo1.Lines.Add('doMach:'+IntToStr(GetIEGateMgrWS.doMatch(trans , FIleToByteArray('C:\egateMEGA\pruebas\fm\huella.wsq'))));

  trans.Free;
  mmo1.Lines.Add('>>>>>>>>>>>>>>>>>> '+DateTimeToStr(now));

end;



procedure TForm1.btn4Click(Sender: TObject);
var
   fd: FaceData;
begin
  fD:= FaceData.Create;
  fd.transactionId :=idT;
  fd.image := FIleToByteArray('C:\egateMEGA\pruebas\fm\f.b64');
  GetIEGateMgrWS.watchListSearch(fd);

end;

procedure TForm1.btn5Click(Sender: TObject);
var
  tc: TransactionClosure;
  r:TransactionResult;
begin
  tc := TransactionClosure.Create;
  tc.transactionId := idT;
  r := GetIEGateMgrWS.closeTransaction(tc);


  mmo1.Lines.Add('closeTransaction:'+IntToStr(r.transactionResultCode));
  tc.Free;


end;

procedure TForm1.btn6Click(Sender: TObject);
var
  lHTTP: TIdHTTP;
  sl: TStringList;
begin
  mmo1.Lines.Add('>>>>>>>>>>>>>>>>>> '+DateTimeToStr(now));

  lHTTP := TIdHTTP.Create;
  sl:=TStringList.Create;
  sl.Text := mmoFM.Text;
  sl.Text := StringReplace(sl.Text,'PUERTA',edtID.Text,[]);
  sl.Text := StringReplace(sl.Text,'TRANS',idT,[]);
  sl.SaveToFile('c:\prueba\'+idT+'.txt');


  try
     mmo1.Lines.Add('faceMatch:'+lHTTP.Post('http://127.0.0.1:'+Form1.edtRESTP.Text+'/faceMatch', 'c:\prueba\'+idT+'.txt'));
  finally
    lHTTP.Free;
  end;

  DeleteFile('c:\prueba\'+idT+'.txt');

  mmo1.Lines.Add('>>>>>>>>>>>>>>>>>> '+DateTimeToStr(now));

end;

procedure TForm1.btn7Click(Sender: TObject);
var
  i:Integer;
begin
 for I := 0 to 10 do
  begin
  mmo1.Lines.Add(DateTimeToStr(now));
  btn1.Click;
  Application.ProcessMessages;
  btn2.Click;
  Application.ProcessMessages;
  btn3.Click;
  Application.ProcessMessages;
  btn6.Click;
  Application.ProcessMessages;
  btn4.Click;
  Application.ProcessMessages;
  btn5.Click;
  Application.ProcessMessages;
  mmo1.Lines.Add(DateTimeToStr(now));
  mmo1.Lines.Add('---------------');
  Application.ProcessMessages;
  Refresh;
  end;
end;

end.




