unit usocket;

interface

uses
  System.Classes;

  function Init(ipaddress : String; port : Word; timeout : Integer) : Boolean;
  procedure UnInit;
  function Connect : Boolean;
  procedure Disconnect;
  function Write(buffer : PChar; size : Integer) : Boolean;
  function Read(var xml : TStream) : Boolean;
  function Read2(response : PChar) : Boolean;

implementation

uses
  IdTCPClient, IdGlobal, IdBaseComponent;

var
  tcp : TIdTCPClient;

function Init(ipaddress : String; port : Word; timeout : Integer) : Boolean;
begin
  Result := False;
  try
    tcp := TIdTCPClient.Create(nil);
    tcp.ReadTimeout := timeout * 1000;
    tcp.Host := ipaddress;
    tcp.Port := port;
  except
  end;
end;

procedure UnInit;
begin
  try
    tcp.Free;
    tcp := nil;
  except
  end;
end;

function Connect : Boolean;
begin
  Result := False;
  try
    tcp.Connect;
    Result := True;
  except
  end;
end;

procedure Disconnect;
begin
  try
    tcp.Disconnect;
  except
  end;
end;

function Write(buffer : PChar; size : Integer) : Boolean;
begin
  Result := False;
  try
    tcp.Socket.Write(TIdBytes(buffer), size);
    // Si se logró escribir el socket devolvemos "True", aunque despues falle la desconexión.
    Result := True;
  except
  end;
end;

function Read(var xml : TStream) : Boolean;
begin
  Result := False;
  try
    // Leer hasta desconexión del par remoto.
    tcp.Socket.ReadStream(xml, -1, True);
    Result := True;
  except
  end;
end;

function Read2(response : PChar) : Boolean;
begin
  Result := False;
  try
    tcp.Socket.ReadBytes(TIdBytes(response), Length(response));
    Result := True;
  except
  end;
end;

end.
 