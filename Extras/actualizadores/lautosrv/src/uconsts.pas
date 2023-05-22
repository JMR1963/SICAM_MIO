unit uConsts;

interface

const
  CNT_SERVICE_NAME                    = 'lautosrv';
  INI_FILE_NAME                       = 'config.ini';
  PARAMS_FILE_NAME                    = 'params.dat';
  FILENAME_DDDFE                      = '%s\%s\%s\%s.%s';
  FILENAME_DDFE                       = '%s\%s\%s.%s';
  FILENAME_DFE                        = '%s\%s.%s';
  FILENAME_DDF                        = '%s\%s\%s';
  FILENAME_DF                         = '%s\%s';
  LOG_DIRECTORY                       = 'logs';
  LOG_FILE_NAME                       = 'service';  // Este es el log del servicio. No el de proceso de lista
                                                    // de control
  END_OF_LINE                         = #$0D#$0A;
  FIRST_HOUR                          = 0;  // La primer hora del día
  LAST_HOUR                           = 23; // La última hora del día
  LAST_MONTH                          = 12;
  INCOMMING_DIR                       = 'Incomming';
  PROCESSED_DIR                       = 'Processed';
  LOG_FILE_EXT                        = 'log';  
  LIST_FILE_EXT                       = 'txt';
  CONFIRMATION_FILE_EXT               = 'cnf';  // Extensión de archivo de confirmación
  HTTP_GET_STRING                     = '%s://%s/%s/%s.%s';
  HTTP_FILE_ERROR                     = -1;     // Error al descargar un archivo por HTTP.
                                                // DEBE ser distinto de los códigos HTTP definidos (ver
                                                // más abajo) y distinto de HTTP_FILE_DOWNLOADED
  HTTP_FILE_DOWNLOADED                = 12555;  // Código arbitrario OK indicando que se bajo un archivo.
                                                // Este código no debe coincidir con ninguno de los definidos
                                                // para HTTP. Ver abajo
  DEFAULT_DB_CHARSET                  = 'WIN1251';

  {
    Códigos definidos para HTTP.

    100 - Continue
    101 - Switching Protocols

    200 - OK
    201 - Created
    202 - Accepted
    203 - Non-Authoritative Information
    204 - No Content
    205 - Reset Content
    206 - Partial Content

    300 - Multiple Choices
    301 - Moved Permanently
    302 - Found
    303 - See Other
    304 - Not Modified
    305 - Use Proxy
    306 - (Unused) Reserved
    307 - Temporary Redirect

    401 - Unauthorized
    402 - Payment Required
    403 - Forbidden
    404 - Not Found
    405 - Method Not Allowed
    406 - Not Acceptable
    407 - Proxy Authentication Required
    408 - Request Timeout
    409 - Conflict
    410 - Gone
    411 - Length Required
    412 - Precondition Failed
    413 - Request Entity Too Large
    414 - Request-URI Too Long
    415 - Unsupported Media Type
    416 - Requested Range Not Satisfiable
    417 - Expectation Failed

    500 - Internal Server Error
    501 - Not Implemented
    502 - Bad Gateway
    503 - Service Unavailable
    504 - Gateway Timeout
    505 - HTTP Version Not Supported
  }

  HTTP_FILE_NOT_FOUND                 = 404;    // El servidor http contesta con este código si el archivo
                                                // solicitado no existe.

  {
    Códigos definidos para FTP.

    100 - Series: The requested action is being initiated, expect another reply before proceeding with
          a new command.
    110 -	Restart marker reply. In this case, the text is exact and not left to the particular
          implementation; it must read: MARK yyyy = mmmm where yyyy is User-process data stream marker,
          and mmmm server's equivalent marker (note the spaces between markers and "=").
    120 -	Service ready in nnn minutes.
    125 -	Data connection already open; transfer starting.
    150 -	File status okay; about to open data connection.

    200 - Series: The requested action has been successfully completed.
    200 -	Command okay.
    202 -	Command not implemented, superfluous at this site.
    211 -	System status, or system help reply.
    212 -	Directory status.
    213 - File status.
    214 -	Help message.On how to use the server or the meaning of a particular non-standard command.
          This reply is useful only to the human user.
    215 -	NAME system type. Where NAME is an official system name from the list in the Assigned Numbers
          document.
    220 -	Service ready for new user.
    221 -	Service closing control connection.
    225 -	Data connection open; no transfer in progress.
    226 -	Closing data connection. Requested file action successful (for example, file transfer or file
          abort).
    227 -	Entering Passive Mode (h1,h2,h3,h4,p1,p2).
    230 -	User logged in, proceed. Logged out if appropriate.
    250 -	Requested file action okay, completed.
    257 -	"PATHNAME" created.

    300 - Series: The command has been accepted, but the requested action is dormant, pending receipt
          of further information.
    331 -	User name okay, need password.
    332 -	Need account for login.
    350 -	Requested file action pending further information

    400 - Series: The command was not accepted and the requested action did not take place, but the error
          condition is temporary and the action may be requested again.
    421 - Service not available, closing control connection.This may be a reply to any command if the
          service knows it must shut down.
    425 - Can't open data connection.
    426 - Connection closed; transfer aborted.
    450 -	Requested file action not taken.
    451 -	Requested action aborted. Local error in processing.
    452 -	Requested action not taken. Insufficient storage space in system.File unavailable (e.g., file
          busy).

    500 - Syntax error, command unrecognized. This may include errors such as command line too long.
    501 -	Syntax error in parameters or arguments.
    502 -	Command not implemented.
    503 -	Bad sequence of commands.
    504 -	Command not implemented for that parameter.
    530 -	Not logged in.
    532 -	Need account for storing files.
    550 -	Requested action not taken. File unavailable (e.g., file not found, no access).
    551 -	Requested action aborted. Page type unknown.
    552 -	Requested file action aborted. Exceeded storage allocation (for current directory or dataset).
    553 -	Requested action not taken. File name not allowed.
  }

  FTP_ACTION_NOT_TAKEN                = 550;  // El servidor FTP responde con este código si el
                                              // archivo/carpeta al que se quiere acceder/crear no existe.

  TOKEN_ENCLOSER                      = '$';
  CTRL_LIST_BEGIN                     = '$BEGIN$';
  CTRL_LIST_END                       = '$END$';
  CTRL_LIST_INSERT                    = '$INSERT$';
  CTRL_LIST_UPDATE                    = '$UPDATE$';
  CTRL_LIST_DELETE                    = '$DELETE$';
  CLT_INSERT                          = 'INSERT INTO %s (%s) VALUES (%s)';
  CLT_UPDATE                          = 'UPDATE %s SET %s WHERE %s';
  CLT_DELETE                          = 'DELETE FROM %s WHERE %s';
  FIELD_DELIMITER                     = '¦';
  PRMS_DELIMITER                      = ',';
  NULL_VALUE                          = 'NULL'; // Valor nulo en SQL
  INTEGER_FIELD                       = '%d';   // Indica valor tipo entero
  STRING_FIELD                        = '%s';   // Indica valor tipo string
  DATE_TIME_FIELD                     = '%t';   // Indica valor tipo fecha y hora
  // Mensajes al debugger
  MSG_START_SCD_FAILED                = 'Error al iniciar Service Control Dispatcher';
  MSG_REGISTERING_SCH                 = 'Error registrando Service Control Handle';
  MSG_SRV_STATUS_FAILED               = 'Error al actualizar Service Status';
  MSG_UNRECOGNIZED_CTRL_CODE          = 'Código de control desconocido';
  MSG_LEAVING_SERVICE                 = 'Terminando servicio';
  MSG_OPEN_SCM_FAILED                 = 'Error al abrir Service Control Manager';
  MSG_SRV_CREATION_FAILED             = 'Error al instalar el servicio';
  MSG_SRV_DELETION_FAILED             = 'Error al desinstalar el servicio';
  MSG_MAIN_THREAD_FAILED              = 'Error al iniciar hilo principal';
  // Comandos vía línea de comandos
  CMD_LINE_INSTALL                    = '-i';
  CMD_LINE_UNINSTALL                  = '-u';
  // Servicio
  SRV_DISPLAY_NAME                    = 'Actualizador Dirección Nacional de Migraciones';
  SRV_WORKINGDIR_VARIABLE             = 'LAUTOSRV';
  // Error en la inicialización del servicio
  STS_FAILED                          = -101;
  // Errores específicos del actualizador
  SE_READING_INI_FILE_FAILED          = -1001; // Error al leer el archivo de configuración
  SE_TIMER_CREATION_FAILED            = -1002; // Error al crear el timer
  SE_SET_TIMER_FAILED                 = -1003;
  SE_WAIT_TIME_FAILED                 = -1004;
  SE_LOAD_TABLES_FAILED               = -1005; // Error procesando archivo params.dat
  SE_OPEN_SRV_MANAGER_FAILED          = -1006; // Error al abrir el Service Control Manager
  SE_OPEN_SERVICE_FAILED              = -1007; // Error al abrir el servicio para consulta
  SE_QUERING_SERVICE_FAILED           = -1008; // Error al consultar configuración del servicio
  SE_LOG_FILE_CREATION_FAILED         = -1009; // Error al crear el archivo de logs.
  // Secciones del archivo de configuración
  SEC_BASE                            = 'Bases';
  SEC_HTTP                            = 'Http';
  SEC_LOCAL                           = 'Local';
  SEC_PROXY                           = 'Proxy';
  SEC_DIALUP                          = 'Dialup';

  // Mensajes de texto que salen en los logs.
  LOG_DATABASE_COMPONENTS_FAILED      = 'Error al crear los componentes de conexión a la base de datos';
  LOG_HTTP_PROTOCOL_NOT_FOUND         = 'No se especificó protocolo (http o https)';
  LOG_HTTP_INVALID_PROTOCOL           = 'Protocolo inválido: "%s"';
  LOG_HTTP_COMPONENT_CREATION_FAILED  = 'Error al crear componentes HTTP';
  LOG_DIALUP_COMPONENT_FAILED         = 'Error al crear el componente de conexión dial-up';
  LOG_ATTEMP_CONNECT_DATABASE         = 'Conectando con la base de datos "%s"';
  LOG_DATABASE_CONNECTED              = 'Conectado con la base de datos "%s"';
  LOG_DATABASE_CONNECT_FAILED         = 'Error en la conexión con la base de datos "%s"';
  LOG_DIALUP_CONNECTION_FAILED        = 'Error al establecer la conexión dial-up';
  LOG_DIALUP_CONNECTED                = 'Conexión dial-up completada con éxito';
  LOG_EXCEPTION_RAISED                = 'Excepción';
  LOG_NO_FILES_DOWNLOADED             = 'No se han bajado archivos desde la conexión http';
  LOG_FILE_DOWNLOADED                 = 'Archivo bajado';
  LOG_HTTP_ERROR                      = 'Error al bajar el archivo desde el servidor http';
  LOG_CREATION_FILE_ERROR             = 'Error al crear el stream file';
  LOG_ATTEMP_PROCESS_FILE             = 'Se dispone a procesar %s';
  LOG_FILE_MINOR_EQ_LASTFILE          = 'Archivo %s es de fecha menor o igual al último procesado confirmado %s';
  LOG_OPEN_LIST_FILE_FAILED           = 'Error al abrir el archivo para procesar';
  LOG_TOKEN_UNKNOWN                   = 'Token desconocido en línea %s';
  LOG_TOKEN_IN_BAD_PLACE              = 'Token %s no válido en éste lugar. Línea %s';
  LOG_TABLE_NAME                      = 'Tabla %s';
  LOG_TABLE_NOT_EXIST                 = 'La tabla %s no existe en el archivo de parámetros. Línea %d';
  LOG_FILE_COMPLETED                  = 'Archivo completo %s. Total líneas: %d, erroneas: %d, insertadas: %d, actualizadas: %d, borradas: %d';
  LOG_WRONG_LIST_FILE                 = 'Error en el formato del archivo %s';
  LOG_WRITE_RESUME                    = '%s: %s, erroneas: %s';
  LOG_OPERATION_ABORTED               = 'Proceso de actualización abortado';
  LOG_DIALUP_FAILED                   = 'Error en la conexión dial-up';
  LOG_LEAVING_PROCESS                 = 'Terminando el proceso de archivos para base "%s"';
  LOG_VALUE_WRONG_TYPE                = 'El valor "%s" no es válido para el tipo "%s"';
  LOG_NULL_DATA_BASE_DATA             = 'Falta %s para base "%s%d" en archivo de configuracion';
  LOG_DEFAULT_DB_CHARSET_MISSING      = 'Falta juego de caracteres para la base "%s". Se usara "%s"';
  LOG_CREATE_LOG_DIRECTORY_FAILED     = 'Error al crear el directorio para logs "%s"';
  LOG_LOG_DIRECTORY_CREATED           = 'Directorio para logs "%s" creado';
  LOG_PROCESS_BEGIN                   = 'Proceso de archivos iniciado';
  LOG_MOVING_FILES                    = 'Moviendo archivos...';
  LOG_LAST_CONTROL_LIST_FILE          = 'Ultimo archivo procesado para esta base es "%s"';
  LOG_NO_FILES_PROCESSED              = 'No hubo archivos que procesar';
  LOG_FILES_PROCESSED                 = 'Procesados: %d archivo%s';
  LOG_GOING_TO_SLEEP                  = 'Fin del proceso. El proceso vuelve a dormir';
  LOG_SERVICE_INITIATED               = 'Servicio iniciado';
  LOG_SERVICE_TERMINATED              = 'Servicio detenido';
  LOG_GENERAL                         = '[%s][%s]';


  lastdays : Array[False..True, 1..12] of Integer = ((31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31),
                                                     (31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31));

  // [ Agregado: 30/08/2007 ]
  SEC_XML                             = 'Xml';
  XML_GEN_DIR                         = 'Xml\Generated\';
  XML_SENT_DIR                        = 'Xml\Sent\';
  XML_EXT                             = '.xml';

implementation

end.
