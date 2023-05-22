{ Invokable interface IWsListaControl }

unit WsListaControlIntf;

interface

uses soap.InvokeRegistry, system.Types, soap.XSBuiltIns;

type




  TESTATSOURCE_NEW = class(TRemotable)
  private
    FFUENTES : string;
    FESTADO  : string;
  published
    property FUENTES : string read FFUENTES write FFUENTES;
    property ESTADO  : string read FESTADO write FESTADO;
  end;

  TESTATMANYSOURCES_NEW = Array of TESTATSOURCE_NEW;

  XML_CONSULTA_NEW = class(TRemotable)
  private
    FFUENTES            : String;
    FUSUARIO            : String;
    FCLAVE              : String;
    FOPERADOR           : String;
    FNOMBRE1            : String;
    FNOMBRE2            : String;
    FAPELLIDO1          : String;
    FAPELLIDO2          : String;
    FNUMDOC             : String;
    FIP                 : String;

    FTIPODOC             : String;
    FEMISORDOC           : String;
    FFECHANAC            : String;
    FGENERO              : String;
    FNACIONALIDAD        : String;
    FNUMEROIDENIFICACION : String;
    FPASO                : String;

  published
    property FUENTES              :String read FFUENTES write FFUENTES;
    property USUARIO              :String read FUSUARIO write FUSUARIO;
    property CLAVE                :String read FCLAVE write FCLAVE;
    property OPERADOR             :string read FOPERADOR write FOPERADOR;
    property IP                   :string read FIP write FIP;

    property NOMBRE1              :string read FNOMBRE1 write FNOMBRE1;
    property NOMBRE2              :string read FNOMBRE2 write FNOMBRE2;
    property APELLIDO1            :string read FAPELLIDO1 write FAPELLIDO1;
    property APELLIDO2            :string read FAPELLIDO2 write FAPELLIDO2;
    property NUMDOC               :string read FNUMDOC write FNUMDOC;
    property TIPODOC             :String read FTIPODOC write FTIPODOC;
    property EMISORDOC           :String read FEMISORDOC WRITE FEMISORDOC;
    property FECHANAC            :String read FFECHANAC write FFECHANAC;
    property GENERO              :String read FGENERO write FGENERO;
    property NACIONALIDAD        :String read FNACIONALIDAD write FNACIONALIDAD;
    property NUMEROIDENIFICACION :String read FNUMEROIDENIFICACION write FNUMEROIDENIFICACION;
    property PASO                :String read FPASO write FPASO;

  end;

  Restriccion = Class(TRemotable)
  private
    FFUENTE    : String;
    FID_PERS_PADRE: Integer;
    FID_PERS: Integer;
    FID_MOV_C: Integer;
    FDESC_TIPO_DOC : String;
    FDOCTIPO : String;
    FNUM_DOC : String;
    FPAIS_EMISOR_DOC : String;
    FAPELLIDO : String;
    FAPELLIDO2 : String;
    FNOMBRE : String;
    FNOMBRE2 : String;
    FNACIONALIDAD : String;
    FFECHA_NAC : String;
    FSEXO : String;
    FDESC_TIPO_RESTRICCION: String;
    FEXPED_DNM : String;
    FDESC_RESTRICCION : String;
    FDESC_CAUSA : String;
    FDESC_INSTRUCCION : String;
    FDESC_TIPO_JUSTICIA : String;
    FDESC_PROVINCIA : String;
    FDESC_JUZGADOS : String;
    FDESC_LOCALIDAD : String;
    FJUZGADO : String;
    FSECRETARIA : String;
    FSALA : String;
    FDESTINO : String;
    FFECHA_DESDE : String;
    FFECHA_HASTA : String;
    FFEC_RECEP_DNM : String;
    FDESC_ENTIDAD : String;
    FNRO_DISPO : String;
    FANIO_DISPO : String;
    FNRO_NOTA : String;
    FANIO_NOTA : String;
    FACTA : String;
    FDESC_DELEGACION : String;
    FFECHA_SALIDA : String;
    FFECHA_BAJA : String;
    FOBSERVACIONES : String;
    FFOTO : String;
    FEXTRA_INFO : String;
  published
    property FUENTE                : String read FFUENTE write FFUENTE;
    property ID_PERS_PADRE         : Integer read FID_PERS_PADRE write FID_PERS_PADRE;
    property ID_PERS               : Integer read FID_PERS write FID_PERS;
    property ID_MOV_C              : Integer read FID_MOV_C write FID_MOV_C;
    property DESC_TIPO_DOC         : String read FDESC_TIPO_DOC write FDESC_TIPO_DOC;
    property DOCTIPO               : String read FDOCTIPO write FDOCTIPO;
    property NUM_DOC               : String read FNUM_DOC write FNUM_DOC;
    property PAIS_EMISOR_DOC       : String read FPAIS_EMISOR_DOC write FPAIS_EMISOR_DOC;
    property APELLIDO              : String read FAPELLIDO write FAPELLIDO;
    property APELLIDO2             : String read FAPELLIDO2 write FAPELLIDO2;
    property NOMBRE                : String read FNOMBRE write FNOMBRE;
    property NOMBRE2               : String read FNOMBRE2  write FNOMBRE2;
    property NACIONALIDAD          : String read FNACIONALIDAD write FNACIONALIDAD;
    property FECHA_NAC             : String read FFECHA_NAC write FFECHA_NAC;
    property SEXO                  : String read FSEXO write FSEXO;
    property DESC_TIPO_RESTRICCION : String read FDESC_TIPO_RESTRICCION write FDESC_TIPO_RESTRICCION;
    property EXPED_DNM             : String read FEXPED_DNM write FEXPED_DNM;
    property DESC_RESTRICCION      : String read FDESC_RESTRICCION write FDESC_RESTRICCION;
    property DESC_CAUSA            : String read FDESC_CAUSA write FDESC_CAUSA;
    property DESC_INSTRUCCION      : String read FDESC_INSTRUCCION write FDESC_INSTRUCCION;
    property DESC_TIPO_JUSTICIA    : String read FDESC_TIPO_JUSTICIA write FDESC_TIPO_JUSTICIA;
    property DESC_PROVINCIA        : String read FDESC_PROVINCIA write FDESC_PROVINCIA;
    property DESC_JUZGADOS         : String read FDESC_JUZGADOS write FDESC_JUZGADOS;
    property DESC_LOCALIDAD        : String read FDESC_LOCALIDAD write FDESC_LOCALIDAD;
    property JUZGADO               : String read FJUZGADO write FJUZGADO;
    property SECRETARIA            : String read FSECRETARIA write FSECRETARIA;
    property SALA                  : String read FSALA write FSALA;
    property DESTINO               : String read FDESTINO write FDESTINO;
    property FECHA_DESDE           : String read FFECHA_DESDE write FFECHA_DESDE;
    property FECHA_HASTA           : String read FFECHA_HASTA write FFECHA_HASTA;
    property FEC_RECEP_DNM         : String read FFEC_RECEP_DNM write FFEC_RECEP_DNM;
    property DESC_ENTIDAD          : String read FDESC_ENTIDAD write FDESC_ENTIDAD;
    property NRO_DISPO             : String read FNRO_DISPO write FNRO_DISPO;
    property ANIO_DISPO            : String read FANIO_DISPO write FANIO_DISPO;
    property NRO_NOTA              : String read FNRO_NOTA write FNRO_NOTA;
    property ACTA                  : String read FACTA write FACTA;
    property DESC_DELEGACION       : String read FDESC_DELEGACION write FDESC_DELEGACION;
    property FECHA_SALIDA          : String read FFECHA_SALIDA write FFECHA_SALIDA;
    property FECHA_BAJA            : String read FFECHA_BAJA write FFECHA_BAJA;
    property OBSERVACIONES         : String read FOBSERVACIONES write FOBSERVACIONES;
    property FOTO                  : String read FFOTO write FFOTO;
    property EXTRA_INFO             : String read FEXTRA_INFO write FEXTRA_INFO;
  end;

  XML_RESPUESTA_NEW = array of Restriccion;

  TRESULTADO_NEW = class(Tremotable)
  private
    Frestricciones: XML_RESPUESTA_NEW;
    Ffuentes: Testatmanysources_NEW;
  published
    property restricciones: XML_RESPUESTA_NEW read Frestricciones write Frestricciones;
    property fuentes: Testatmanysources_NEW read Ffuentes write Ffuentes;
  end;

  TRESPUESTA_ARG = class(TRemotable)
  private
    FCOD_RTA : string;
    FCOD_DETALLE_RTA  : string;
  published
    property COD_RTA : string read FCOD_RTA write FCOD_RTA;
    property COD_DETALLE_RTA  : string read FCOD_DETALLE_RTA write FCOD_DETALLE_RTA;
  end;


  { Invokable interfaces must derive from IInvokable }
  IWsListaControl_Unif = interface(IInvokable)
  ['{BE28D501-B079-48C0-B5B0-F38AAE9C441F}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }

      function ConsultaRestriccion(Consulta: XML_CONSULTA_NEW): TRESULTADO_NEW; stdcall;
      function ConsultaRestriccionARG(consulta: XML_CONSULTA_NEW) : TRESPUESTA_ARG; stdcall;

      function ConsultaRestriccionLocal(Consulta: XML_CONSULTA_NEW): TRESULTADO_NEW; stdcall;

  end;

implementation

{ Restriccion }



initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IWsListaControl_Unif));

end.



