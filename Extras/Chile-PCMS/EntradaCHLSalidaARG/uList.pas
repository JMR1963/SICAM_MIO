unit uList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFrmLs = class(TForm)
    BitBtn1: TBitBtn;
    ListSICAM: TListBox;
    ListCHILE: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lsc: TLabel;
    lcc: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLs: TFrmLs;

implementation

{$R *.dfm}

procedure TFrmLs.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmLs.FormShow(Sender: TObject);
begin
  lsc.Caption := IntToStr(ListSICAM.Count);
  lcc.Caption := IntToStr(ListCHILE.Count);
end;

end.
