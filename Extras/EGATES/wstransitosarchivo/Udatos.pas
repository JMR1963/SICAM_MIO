unit Udatos;

interface

uses
  Winapi.Windows, WinApi.Messages, system.Variants, Vcl.Graphics, Vcl.Controls,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.SysUtils, System.Classes, Data.DB,
  MemDS, DBAccess, Ora, WStransitosIntf, System.IniFiles, Vcl.Forms, uMD5,
  KAZip, WinApi.ShellAPI, OraCall;



type
  Tdmdatos = class(TDataModule)
    OraSession1: TOraSession;
    oqFechahora: TOraQuery;
    oqOrganismos_externos: TOraQuery;
  private
    { Private declarations }
    function conectarNOMINAS() : boolean;
  public
    function getFechaHora: string;
    function validarUsuarioOrganismo(usuario : tusuario): boolean;
    function descomprimir(exe, path, pathrelativo: string): boolean;
    function CreateProcessSimple(sExecutableFilePath: string): string;

  end;

var
  dmdatos: Tdmdatos;

implementation

{$R *.dfm}

{ TDataModule2 }

function Tdmdatos.CreateProcessSimple(sExecutableFilePath: string): string;
var
  pi: TProcessInformation;
  si: TStartupInfo;
begin
  FillMemory( @si, sizeof( si ), 0 );
  si.cb := sizeof( si );

  CreateProcess(
    Nil,

    // path to the executable file:
    PChar( sExecutableFilePath ),Nil, Nil, False, NORMAL_PRIORITY_CLASS, Nil, Nil,si, pi );

  // "after calling code" such as
  // the code to wait until the
  // process is done should go here

  CloseHandle( pi.hProcess );
  CloseHandle( pi.hThread );
end;



function Tdmdatos.descomprimir(exe, path, pathrelativo: string): boolean;
begin
  try
    result := true;
    CreateProcessSimple(exe);
    Sleep(5000);
  except
    Result := false;
  end;
   //ShellExecute(Application.Handle, 'runas', pchar(exe), pchar('x '+path+' '+pathrelativo), nil,  SW_HIDE);
   //Sleep(10000);
end;

function Tdmdatos.conectarNOMINAS():boolean;
var
  inifile : TIniFile;
begin
  try
    inifile := TIniFile.Create(Format('%sconfig.ini', [ExtractFilePath(Application.ExeName)]));
    OraSession1.server   := inifile.ReadString('server', 'base', '');
    OraSession1.Username := inifile.ReadString('server', 'user', '');
    OraSession1.Password := inifile.ReadString('server', 'pass', '');

    OraSession1.Connect;
    result := true;
  except
    Result := false;
  end;
end;

function Tdmdatos.getFechaHora: string;
var
  oraConn : TOraSession;
begin
  if not conectarNOMINAS() then
    exit;
  oqFechahora.Close;
  oqFechahora.Open;
  result := oqFechahora.fieldbyname('fecha').AsString;
end;

function Tdmdatos.validarUsuarioOrganismo(usuario : tusuario):boolean;
begin
  result := false;
  try
    if not conectarNOMINAS() then
      exit;
    oqOrganismos_externos.close;
    oqOrganismos_externos.Connection.StartTransaction;
    oqOrganismos_externos.ParamByName('puser').AsString     := UpperCase(usuario.user);
    oqOrganismos_externos.open;
    if not oqOrganismos_externos.IsEmpty then
      result := MD5Print(MD5String(oqOrganismos_externos.FieldByName('password').AsString)) = usuario.password;

    oqOrganismos_externos.Connection.Commit;
  except
    result := false;
  end;
end;


end.
