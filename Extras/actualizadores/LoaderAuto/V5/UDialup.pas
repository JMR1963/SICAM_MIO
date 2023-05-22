unit UDialup;

interface

uses
  SysUtils, Classes, DialUp;

type
  TDialupDtMdl = class(TDataModule)
    DialUpConn : TDialUp;
    procedure DialUpConnDialing(Sender : TObject);
    procedure DialUpConnConnect(Sender : TObject);
    procedure DialUpConnNotConnected(Sender : TObject; ErrorCode : Integer; ErrorMessage : String);
  private
    { Private declarations }
    Connected : Boolean;
    Msg : String;
  public
    { Public declarations }
    procedure DialupInitialize(Connection : String);
    function DialupConnect(var Mess : String) : Boolean;
    procedure DialupDisconnect;
  end;

var
  DialupDtMdl : TDialupDtMdl;

implementation

{$R *.dfm}

uses
  Ucommon;

const
  LOG_ATTEMP_TO_DIALUP      = 'Conectando dial-up ...';
  LOG_DIALUP_CONNECTED      = 'Conexión dial-up establecida.';
  LOG_DIALUP_NOT_CONNECTED  = 'No se pudo establecer la conexión dial-up';
  LOG_DIALUP_ERROR_CODE     = 'Código de error';
  LOG_DIALUP_ERROR_MESSAGE  = 'Mensaje de error';

procedure TDialupDtMdl.DialupInitialize(Connection : String);

begin
  DialUpConn.Entry := Connection;
end;

function TDialupDtMdl.DialupConnect(var Mess : String) : Boolean;
begin
  DialUpConn.Dial;
  Result := Connected;
  Mess := Msg;
end;

procedure TDialupDtMdl.DialupDisconnect;
begin
  DialUpConn.HangUp;
end;

procedure TDialupDtMdl.DialUpConnDialing(Sender : TObject);
begin
  Msg := Msg + LOG_ATTEMP_TO_DIALUP + LOG_DELIMITER + DateTimeToStr(Now) + END_OF_LINE;
end;

procedure TDialupDtMdl.DialUpConnConnect(Sender: TObject);
begin
  Msg := Msg + LOG_DIALUP_CONNECTED + LOG_DELIMITER + DateTimeToStr(Now) + END_OF_LINE;
  Connected := True;
end;

procedure TDialupDtMdl.DialUpConnNotConnected(Sender : TObject;
                                              ErrorCode : Integer;
                                              ErrorMessage : String);
begin
  Msg := Msg + LOG_DIALUP_NOT_CONNECTED + LOG_DELIMITER + LOG_DIALUP_ERROR_CODE + LOG_DELIMITER +
          IntToStr(ErrorCode) + LOG_DELIMITER + LOG_DIALUP_ERROR_MESSAGE + LOG_DELIMITER +
          ErrorMessage + LOG_DELIMITER + DateTimeToStr(Now) + END_OF_LINE;
  Connected := False;
end;

end.
