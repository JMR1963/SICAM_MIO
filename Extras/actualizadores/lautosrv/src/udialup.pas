unit uDialup;

interface

function CreateDialupComponent: Boolean;

procedure FreeDialupComponent;

function Dial: Boolean;

procedure Hangup;

implementation

uses
  SysUtils, DialUp, uGlobal;

var
  // Variable para conexión dial-up
  dialupclient: TDialUp;

function CreateDialupComponent: Boolean;
begin
  Result := False;
  try
    dialupclient := TDialUp.Create(nil);
    dialupclient.DialMode := dmSync;
    dialupclient.Entry := g_dialupconn;
    Result := True;
  except
  end;
end;

procedure FreeDialupComponent;
begin
  try
    if Assigned(dialupclient) then
      FreeAndNil(dialupclient);
  except
  end;
end;

function Dial: Boolean;
begin
  try
    Result := dialupclient.Dial = 0;
  except
    Result := False;
  end;
end;

procedure Hangup;
begin
  try
    dialupclient.HangUp;
  except
  end;
end;

end.

