{
  Contiene todas las rutinas de inicializaci�n. Tales como la lectura del archivo de configuraci�n
  (*.ini).
}
unit uInit;

interface

uses
  uCommon;

  function ProcessIniFile( var LogFile: TextFile;
                           var WrkPth:  String;
                           var CfgVals: TCfgVals ): Boolean;

implementation

uses
  SysUtils, Classes, Dialogs;

const

  INI_FILE_NAME             = 'config.ini';
  MSG_INI_FILE_FAILED       = 'No se pudo abrir el archivo de inicio';
  MSG_BAD_OPTION            = 'Opci�n no v�lida en archivo de configuraci�n';
  MSG_IN_FILE               = ' en archivo';
  MSG_NO_OPTION_AT_BEGINING = 'Archivo de configuraci�n debe comenzar con una opci�n';

  OPT_DATA_BASES            = 'DataBases';
  OPT_USER_NAME             = 'UserName';
  OPT_PASSWORD              = 'PassWord';
  OPT_RESOURCE_PATH         = 'ResourcePath';
  OPT_LOCAL_MACHINE_IP      = 'LocalMachineIP';
  OPT_SERVER_IP             = 'ServerIP';
  OPT_PROXY_PORT            = 'ProxyPort';
  OPT_PROXY_ID              = 'ProxyID';
  OPT_PROXY_USER_NAME       = 'ProxyUserName';
  OPT_PROXY_PASSWORD        = 'ProxyPassWord';
  OPT_TIMER_TIME            = 'TimerTime';

  TOKEN_ENCLOSER_FIRST      = '[';
  TOKEN_ENCLOSER_LAST       = ']';

  { CfgOpts debe estar ordenado para que funcione la b�squeda dicot�mica }
  CfgOpts: TCfgOpts = ( OPT_DATA_BASES,          // Ruta de la/s base/s de datos
                        OPT_LOCAL_MACHINE_IP,    // Direcci�n IP de la m�quina local
                        OPT_PASSWORD,            // Contrase�a para el usuario en el servidor HTTP
                        OPT_PROXY_ID,            // Direcci�n IP o nombre del servidor proxy
                        OPT_PROXY_PASSWORD,      // Contrase�a para el usuario en el servidor proxy
                        OPT_PROXY_PORT,          // Puerto del servidor proxy
                        OPT_PROXY_USER_NAME,     // Nombre de usuario en el servidor proxy
                        OPT_RESOURCE_PATH,       // Directorio de trabajo en el servidor HTTP
                        OPT_SERVER_IP,           // Direcci�n IP del servidor HTTP
                        OPT_TIMER_TIME,          // Valor de tiempo para el temporizador
                        OPT_USER_NAME );         // Nombre de usuario en el servidor HTTP




{ ------------------------------ Funciones y Procedimientos privados ------------------------------ }

function BinarySearch( Target: String; SearchSet: TCfgOpts; Max: Integer ): Boolean;
{
  Realiza la b�squeda binaria de Target en el vector SearchSet.

  [In]

    Target: String a buscar en SearchSet.
    SearchSet: Vector de strings donde se realiza la b�squeda.
    Max: Indice que indica el valor m�ximo donde buscar.

  [Function Out]
  
    True si se encontr� el string buscado, False en caso contrario.
}
var
  Founded: Boolean;
  Inf, Cent, Sup: Integer;
begin

  Founded := False;
  Inf     := 1;
  Sup     := Max;

  while not Founded
  and   ( Inf <= Sup )
  do begin
    Cent := ( Inf + Sup ) div 2;
    if SearchSet[ Cent ] = Target
    then
      Founded := True
    else
      if SearchSet[ Cent ] > Target
      then
        Sup := Cent - 1
      else
        Inf := Cent + 1;

  end;

  Result := Founded;

end;

{ ------------------------------ Funciones y Procedimientos p�blicos ------------------------------ }

function ProcessIniFile( var LogFile: TextFile;
                         var WrkPth:  String;
                         var CfgVals: TCfgVals ): Boolean;
{
  Procesa el archivo de inicializaci�n *.ini.

  [In]

    LogFile: Archivo para almacenar log de las operaciones.
    WrkPth: Ruta de trabajo donde se encuentra el archivo de configuracion (*.ini).
    DtBss: Vector de rutas de bases de datos.
    CfgOpts: Vector con los valores leidos

  [Function Out]

    Si el proceso tuvo �xito devuelve True, caso contrario devuelve False.
}
var
  IniFile:  TextFile;
  Line:     String;
  Option:   String;
  PInt:     ^Integer;
  FileEof:  Boolean;
begin

  Result  := False;
  FileEof := False;

  try

    AssignFile( IniFile, WrkPth + INI_FILE_NAME );
    Reset( IniFile );

  except

    MessageDlg( MSG_INI_FILE_FAILED + LOG_DELIMITER + INI_FILE_NAME, mtError, [ mbOk ], 0 );
    Exit;

  end;

  while not FileEof
  do begin
    { Para leer nueva l�nea }
    Line := '';
    { Descartar l�neas vac�as o en blanco (con caracteres espacio) }
    while ( Trim( Line ) = '' )
    and not FileEof
    do
      if Eof( IniFile )
      then
        FileEof := True
      else
        ReadLn( IniFile, Line );

    if not FileEof
    then
      { Verificar si la l�nea leida es una opci�n }
      if GetToken( Line, Option, TOKEN_ENCLOSER_FIRST, TOKEN_ENCLOSER_LAST )
      then begin
        { Quitar enclosers }
        Option := Copy( Option, 2, Length( Option ) - 2 );
        { Buscar la l�nea leida en las opciones de archivo }
        if not BinarySearch( Option, CfgOpts, MAX_OPTIONS )
        then begin
          { Alguna de las opciones ha sido cambiada }
          MessageDlg( MSG_BAD_OPTION + LOG_DELIMITER + Line + MSG_IN_FILE +
                      LOG_DELIMITER + INI_FILE_NAME, mtError, [ mbOk ], 0 );
          CloseFile( IniFile );
          Exit;
        end

      end
      else begin

        if Option = OPT_DATA_BASES
        then begin
          { Ruta de base de datos }
          TStringList( CfgVals[ 1 ] ).Add( Line )
        end
        else
        if Option = OPT_USER_NAME
        then
          { Username }
          StrCopy( CfgVals[ 2 ], PChar( Line ) )
        else
        if Option = OPT_PASSWORD
        then
          { Password }
          StrCopy( CfgVals[ 3 ], PChar( Line ) )
        else
        if Option = OPT_RESOURCE_PATH
        then
          { Ruta de los recursos (archivos) }
          StrCopy( CfgVals[ 4 ], PChar( Line ) )
        else
        if Option = OPT_LOCAL_MACHINE_IP
        then
          { IP local }
          StrCopy( CfgVals[ 5 ], PChar( Line ) )
        else
        if Option = OPT_SERVER_IP
        then
          { IP del servidor }
          StrCopy( CfgVals[ 6 ], PChar( Line ) )
        else
        if Option = OPT_PROXY_PORT
        then begin
          { Puerto del proxy }
          PInt  := CfgVals[ 7 ];
          PInt^ := StrToInt( Line );
        end
        else
        if Option = OPT_PROXY_ID
        then
          { ID del proxy (IP o nombre) }
          StrCopy( CfgVals[ 8 ], PChar( Line ) )
        else
        if Option = OPT_PROXY_USER_NAME
        then
          { Proxy username }
          StrCopy( CfgVals[ 9 ], PChar( Line ) )
        else
        if Option = OPT_PROXY_PASSWORD
        then
          { Proxy password }
          StrCopy( CfgVals[ 10 ], PChar( Line ) )
        else
        if Option = OPT_TIMER_TIME
        then begin
          { Slice del timer }
          PInt  := CfgVals[ 11 ];
          PInt^ := StrToInt( Line );
        end
        else begin
          { Si no se encontr� ninguna opci�n como primera l�nea ... error }
          MessageDlg( MSG_NO_OPTION_AT_BEGINING + LOG_DELIMITER + INI_FILE_NAME, mtError, [ mbOk ], 0 );
          CloseFile( IniFile );
          Exit;
        end;

      end; // de if GetToken( Line, Option, ....

  end; // del while

  CloseFile( IniFile );
  { El proceso del *.ini result� bien }
  Result := True;

end;

end.
