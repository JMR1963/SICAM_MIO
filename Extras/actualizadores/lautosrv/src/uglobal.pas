unit uGlobal;

interface

uses
  System.Classes, System.SyncObjs, Winapi.Windows, Winapi.WinSvc, Ora, Data.DB;

type
  TTableInfo = record
    tablename: string;     // Nombre de la tabla
    tablefields: string;   // Campos de la tabla
    tableparams: string;   // Tipos de los campos de la tabla
    fieldcount: Integer;   // Total de campos
    keyfcount: Integer;    // Total de campos que conforman la clave de la tabla
  end;
  // Agregado 13/03/2008 -------------------------------------

  TBaseInfo = record
    path: string;
    user: string;
    password: string;
    charset: string;
  end;

  PTBaseInfo = ^TBaseInfo;
  //-------------------------Nueva declaracion

  TDBComponents = record
    // Variables para el manejo con la base de datos
    database: TOraSession; // Conexión a la base de datos
    transaction: TOraSession;       // Transacción para todas las operaciones sobre la base de datos
                                    //Innesesario en oracle pero pasamos el store para mantener la estruct
    insertfilesp: TOraStoredProc;   // Stored para inserción de archivo a procesar
    updatefilesp: TOraStoredProc;   // Stored para actualización de archivo procesado
    querylastfilesp: TOraQuery;     // Consulta del último archivo procesado
    alloperationsqry: TOraQuery;    // Query utilizado para inserts, updates y deletes

  end;

  //-----FIN

    {   Declaracion Antrerior
  TDBComponents = record
    // Variables para el manejo con la base de datos
    database : TIBDataBase;             // Conexión a la base de datos
    transaction : TIBTransaction;       // Transacción para todas las operaciones sobre la base de datos
    insertfilesp : TIBStoredProc;       // Stored para inserción de archivo a procesar
    updatefilesp : TIBStoredProc;       // Stored para actualización de archivo procesado
    querylastfilesp : TIBStoredProc;    // Consulta del último archivo procesado
    alloperationsqry : TIBQuery;        // Query utilizado para inserts, updates y deletes
  end;
  }
  PTDBComponents = ^TDBComponents;
  // ---------------------------------------------------------

  TLog = record
    logfile: TextFile;
    filename: string;
  end;

  PTLog = ^TLog;

  TDBRecord = record
    pbi: PTBaseInfo;
    pdbc: PTDBComponents;
    pl: PTLog;
  end;

  PTDBRecord = ^TDBRecord;

var
  // Variables que respectan al servicio y al hilo principal
  g_sstatus: SERVICE_STATUS;           // Status del servicio
  g_sshandle: SERVICE_STATUS_HANDLE;   // Handle del servicio
  g_thmain: THandle;                   // Handle del hilo principal
  g_thparam: WORD;                     // Parámetro pasado al hilo principal cuando se crea
  g_thmainid: DWORD;                   // Identificador del hilo principal
  g_terminated: Boolean;               // Indica cuando el hilo principal termina

  g_somefile: Boolean;
  g_minfile: string;       // Archivo mínimo de lista de control.
  g_maxfile: string;       // Archivo máximo bajado vía http.
  g_workingdir: string;
  g_logdir: string;        // Directorio donde los hilos dejan sus logs. Cambia en cada consulta
  // Variables que contienen los settings del actualizador. Inicialmente se leen del archivo de
  // configuración TODO: luego puede cambiarse vía línea de comandos
  g_baselist: TList; // Lista de bases de datos (ruta, usuario, password y charset)
  g_httpactive: Boolean;
  g_httpprotocol: string;
  g_httpsrvid: string;
  g_httpuser: string;
  g_httppswrd: string;
  g_httprespath: string;
  g_httpbscauth: Boolean;
  g_httpreadtimeout: Integer;
  g_ignoreconffile: Boolean;
  g_startminutes: Integer;
  g_timertime: Longint;
  g_proxyport: Integer;
  g_proxyid: string;
  g_proxyuser: string;
  g_proxypswrd: string;
  g_proxybscauth: Boolean;
  g_dialupactive: Boolean;
  g_dialupconn: string;
  // Otras variables que hacen al estado del actualizador
  g_timer: THandle;
  g_timeratt: SECURITY_ATTRIBUTES;
  g_tables: array of TTableInfo;
  g_logfile: TextFile;
  // Agregado: 30/08/2007 -------------------------------------

  // Para generación de un archivo con formato XML con los tránsitos no actualizados en central.
  // Dicho archivo se envía a central vía HTTP en los pasos donde no existe vínculo directo.
  g_xmlbasename: string;
  g_xmlbaseuser: string;
  g_xmlbasepwd: string;
  g_xmlbasechrset: string;
  g_xmlactive: Boolean;
  g_xmlsrvip: string;
  g_xmluser: string;
  g_xmlpswrd: string;
  g_xmlputpath: string;
  // ---------------------------------------------------------

procedure custom_log(s: string);

implementation

uses
  System.SysUtils;

procedure custom_log(s: string);
var
  ts: tstrings;
begin
  ts := TStringList.Create;
  if FileExists('C:\SICaM\extra\actualizadores\lautosrv\bin\log1.txt') then
    ts.LoadFromFile('C:\SICaM\extra\actualizadores\lautosrv\bin\log1.txt');
  ts.Add((datetostr(now())) + '-' + s);
  ts.SaveToFile('C:\SICaM\extra\actualizadores\lautosrv\bin\log1.txt');
  ts.Free;
end;

end.

