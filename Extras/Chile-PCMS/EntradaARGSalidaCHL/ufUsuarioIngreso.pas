unit ufUsuarioIngreso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask;

type
  TUsuarioIngresoFrm = class(TForm)
    lblNombrePaso: TLabel;
    lblUsuario: TLabel;
    lblPassword: TLabel;
    edtPassword: TMaskEdit;
    edtUsuario: TMaskEdit;
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtUsuarioKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    Ok:Boolean;
  end;

var
  UsuarioIngresoFrm: TUsuarioIngresoFrm;


function mostarLogin:Boolean;


implementation

{$R *.dfm}

uses uDMEntradaARGSalidaCHL;

function mostarLogin:Boolean;
var
  UsuarioIngresoFrm:TUsuarioIngresoFrm;
begin
  UsuarioIngresoFrm:=TUsuarioIngresoFrm.Create(nil);
  try
    UsuarioIngresoFrm.lblNombrePaso.Caption := DMSem.descrip;
    UsuarioIngresoFrm.ShowModal;
    Result := UsuarioIngresoFrm.Ok;
  finally
    UsuarioIngresoFrm.Free;
  end;
end;


procedure TUsuarioIngresoFrm.edtPasswordKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #27 then
  begin
    Application.Terminate;
    Exit;
  end;

  if (Key = #13) then
  begin
    if DMSem.ValidarUsuario(edtUsuario.Text,DMSem.Paso,edtPassword.Text)<>1 then
    begin
      ShowMessage('Error vuelva a ingresar!!!');
    end
    else
    begin
      Ok := True;
      Close;
    end;
  end;
end;

procedure TUsuarioIngresoFrm.FormCreate(Sender: TObject);
begin
  Ok := False;
end;

procedure TUsuarioIngresoFrm.edtUsuarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #27 then
  begin
    Application.Terminate;
    Exit;
  end;
  if key = #13 then
    edtPassword.SetFocus;
end;

end.
 