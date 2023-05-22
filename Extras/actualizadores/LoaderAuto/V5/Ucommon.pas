unit uCommon;

interface

uses
  System.Classes, System.SysUtils, uResourceString;

function CreateSections: Boolean;

procedure DestroySections;

var
  { Stringlist usados para las secciones del archivo de configuración }
  Base: TStringList;
  Http: TStringList;
  local: TStringList;
  Proxy: TStringList;
  Dialup: TStringList;

implementation


function CreateSections: Boolean;
begin
  try
    { Crear secciones }
    Base := TStringList.Create;
    Http := TStringList.Create;
    local := TStringList.Create;
    Proxy := TStringList.Create;
    Dialup := TStringList.Create;
    { Cargar nombres de campos }
    Base.Add(BASE_NAME + '=');
    Base.Add(USER_NAME + '=');
    Base.Add(PASSWORD + '=');
    Http.Add(_ACTIVE + '=');
    Http.Add(SERVER_IP + '=');
    Http.Add(USER_NAME + '=');
    Http.Add(PASSWORD + '=');
    Http.Add(RES_PATH + '=');
    Http.Add(BASIC_AUTH + '=');
    local.Add(TIMER_TIME + '=');
    Proxy.Add(PORT + '=');
    Proxy.Add(ID + '=');
    Proxy.Add(USER_NAME + '=');
    Proxy.Add(PASSWORD + '=');
    Proxy.Add(BASIC_AUTH + '=');
    Dialup.Add(_ACTIVE + '=');
    Dialup.Add(SERVER_IP + '=');
    Dialup.Add(CONNECTION + '=');
    Result := True;
  except
    Result := False;
  end;
end;

procedure DestroySections;
begin
  Base.Free;
  Http.Free;
  local.Free;
  Proxy.Free;
  Dialup.Free;
end;

end.

