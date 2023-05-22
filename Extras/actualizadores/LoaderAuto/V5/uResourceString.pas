unit uResourceString;

interface

resourcestring

  DATE_TIME_FIELD = '%t';  // Indica valor tipo fecha y hora
  FIELD_DELIMITER = '¦';   // Delimitador de valores leidos desde archivo.
  INTEGER_FIELD = '%d';    // Indica valor tipo entero
  NULL_VALUE = 'NULL';     // Valor nulo en SQL
  PRMS_DELIMITER = ',';    // Delimitador de parámetros leidos desde archivo de parámetros
  STRING_FIELD = '%s';     // Indica valor tipo string
  TOKEN_ENCLOSER = '$';    // Usado para encerrar tokens

  MSG_PASSWORDMISSED = 'Falta la contraseña.';
  MSG_PWDNOALPHANUMERIC = 'La contraseña debe ser alfanumérica.';

  { Indica que todas las operaciones (inserción, actualización y borrado) estan completas }

  CLT_DELETE = 'DELETE FROM %s WHERE %s';
  CLT_INSERT = 'INSERT INTO %s (%s) VALUES (%s)';
  CLT_UPDATE = 'UPDATE %s SET %s WHERE %s';
  CTRL_LIST_BEGIN = '$BEGIN$';
  CTRL_LIST_DELETE = '$DELETE$';
  CTRL_LIST_END = '$END$';
  CTRL_LIST_INSERT = '$INSERT$';
  CTRL_LIST_UPDATE = '$UPDATE$';
  LOG_BAD_LINES = 'ERRONEAS';
  LOG_DB_ERROR = 'Error de Base de Datos';
  LOG_DELETED_LINES = 'BORRADAS';
  LOG_DELIMITER             = ' : ';
  LOG_DOUBLE_TABLE_NAME = 'Misma tabla en líneas contiguas';
  LOG_GOOD_LINES = 'CORRECTAS';
  LOG_INSERTED_LINES = 'INSERTADAS';
  LOG_LINE_NUMBER = 'en línea';
  LOG_LIST_FILE = 'ARCHIVO';
  LOG_LST_FILE_FAILED = 'Error de archivo lista control';
  LOG_LST_FILE_INS_FAILED = 'Error al insertar nuevo archivo en la base';
  LOG_OPERATION_ABORTED = 'Operación abortada';
  LOG_OPERATION_INFO = 'Los resultados fueron';
  LOG_TABLE_NAME = 'TABLA';
  LOG_TABLE_NOT_EXIST = 'Nombre de tabla inexistente';
  LOG_TOKEN_BAD_PLACE = 'Token no permitido en este lugar';
  LOG_TOKEN_UNKNOWN = 'Token desconocido';
  LOG_TOTAL_LINES = 'TOTAL LINEAS';
  LOG_UPDATED_LINES = 'ACTUALIZADAS';
  LOG_UPDATE_FAILURE = 'Error al actualizar en base';
  LOG_WRONG_LIST_FILE = 'El archivo no es correcto';
  PARAMS_FILE_EXT = '.dat';
  PARAMS_FILE_NAME = 'params';

  END_OF_LINE               = #$D#$A;
  { Secciones dentro del archivo de configuarción }
  SEC_BASE            = 'Base';
  SEC_DIALUP          = 'Dialup';
  SEC_HTTP            = 'Http';
  SEC_LOCAL           = 'Local';
  SEC_PROXY           = 'Proxy';
  { Campos de las secciones }
  BASE_NAME           = 'basename';
  BASIC_AUTH          = 'basicauthentication';
  CONNECTION          = 'connection';
  ID                  = 'id';
  MACHINE_IP          = 'machineip';
  PASSWORD            = 'password';
  PORT                = 'port';
  RES_PATH            = 'resourcepath';
  SERVER_IP           = 'serverip';
  TIMER_TIME          = 'timertime';
  USER_NAME           = 'username';
  _ACTIVE             = 'active';

  HTTP_GET_STRING = '%s://%s:%s@%s%s%s%s';
  HTTP_PROTOCOL = 'http';
  LOG_CREATION_FILE_ERROR = 'Error al crear stream file';
  LOG_FILE_DOWNLOADED = 'ARCHIVO BAJADO';
  LOG_HTTP_ERROR = 'Error HTTP';

  INCOMMING_DIR = 'Incomming\';
  INI_FILE_NAME = 'config.ini';
  LIST_FILE_EXT = '.txt';
  LOGS_DIR = 'Logs\';
  LOG_ATTEMP_TO_CONECT_DATA_BASE = 'Conectando con la base de datos ...';
  LOG_CONECTED_TO_DATA_BASE = 'Conexión con la base de datos establecida';
  LOG_DB_CONNECT_FAILED = 'No se pudo establecer conexión con la base de datos.';
  LOG_DTMDL_CREATION_FAILED = 'Error al intentar crear alguno de los módulos de datos.';
  LOG_FILE_EXT = '.log';
  LOG_FILE_PREPARED = 'SE DISPONE A PROCESAR';
  LOG_NO_FILES_DOWNLOADED = 'No hubo archivos que procesar.';
  LOG_TBL_INIT_FAILED = 'Error al cargar información de tablas.';
  MSG_BAD_INI_FILE = 'El archivo *.ini no es correcto.';
  MSG_FTP_FAILED = 'No se puede iniciar el cliente FTP.';
  MSG_INI_FILE_FAILED = 'No se pudo abrir el archivo de inicio.';
  MSG_LOG_FILE_FAILED = 'No se pudo crear el archivo log.';
  PROCESSED_DIR = 'Processed\';
  WGET_DIR = 'Wget\';

  //--------------------------------------------------------------------------------------------------
const
  INSERT_FLAG = $01;    // Flag indicando inserciones completas.
  UPDATE_FLAG = $02;    // Flag indicando actualizaciones completas.
  DELETE_FLAG = $04;    // Flag indicando borrados completos.
  ALL_OPERATIONS_DONE = $07;
  HTTP_FILE_DOWNLOADED      = $0010;

  { Código de no existencia de un recurso en HTTP }
  HTTP_FILE_NOT_EXIST       = 404;

  LastDays : Array[False..True, 1..12] of Integer = ((31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31),
                                                     (31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31));

  { Número de opciones del archivo *.ini }
  MAX_OPTIONS = 13;
  FIRST_HOUR = 1;  // La primer hora del día
  LAST_HOUR = 24; // La última hora del día
  LAST_MONTH = 12;
  MAX_INTENTS = 1;   // Númoro máximo de intentos para bajar archivos de actualización

implementation

end.

