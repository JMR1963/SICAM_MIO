{ Invokable interface IwsRestriccion }

unit wsRestriccionIntf;

interface

uses Soap.InvokeRegistry, system.Types, Soap.XSBuiltIns;

type

  TRespuesta = class(TRemotable)
  private
    FRestriccion: AnsiString;
    FTransporte: AnsiString;
    FTipoPasajero: AnsiString;
  published
    property Restriccion: AnsiString read FRestriccion write FRestriccion;
    property Transporte: AnsiString read FTransporte write FTransporte;
    property TipoPasajero: AnsiString read FTipoPasajero write FTipoPasajero;
  end;

  DatosEntrada = class(TRemotable)
  private

    FUSUARIO            : String;
    FCLAVE              : String;
    FOPERADOR           : String;
    FCODPAIS            : String;

    FNOMBRE1            : String;
    FNOMBRE2            : String;
    FAPELLIDO1          : String;
    FAPELLIDO2          : String;

    FNUMDOC             : String;
    FPUESTOCONTROL      : String;
    FTIPODOC             : String;
    FEMISORDOC           : String;
    FFECHANAC            : String;
    FGENERO              : String;
    FNACIONALIDAD        : String;
    FNUMEROIDENIFICACION : String;
    FPASO                : String;

  published

    property USUARIO              :String read FUSUARIO write FUSUARIO;
    property CLAVE                :String read FCLAVE write FCLAVE;
    property OPERADOR             :string read FOPERADOR write FOPERADOR;
    property CODPAIS              :String read FCODPAIS write FCODPAIS;

    property NOMBRE1              :string read FNOMBRE1 write FNOMBRE1;
    property NOMBRE2              :string read FNOMBRE2 write FNOMBRE2;
    property APELLIDO1            :string read FAPELLIDO1 write FAPELLIDO1;
    property APELLIDO2            :string read FAPELLIDO2 write FAPELLIDO2;
    property NUMDOC               :string read FNUMDOC write FNUMDOC;
    property PUESTOCONTROL        :string read FPUESTOCONTROL write FPUESTOCONTROL;
    property TIPODOC             :String read FTIPODOC write FTIPODOC;
    property EMISORDOC           :String read FEMISORDOC WRITE FEMISORDOC;
    property FECHANAC            :String read FFECHANAC write FFECHANAC;
    property GENERO              :String read FGENERO write FGENERO;
    property NACIONALIDAD        :String read FNACIONALIDAD write FNACIONALIDAD;
    property NUMEROIDENIFICACION :String read FNUMEROIDENIFICACION write FNUMEROIDENIFICACION;
    property PASO                :String read FPASO write FPASO;

  end;

  DatosSalida = class(TRemotable)
  private
    FCOD_RTA : string;
    FCOD_DETALLE_RTA  : string;
    FOBSERVACIONES : String;
  published
    property COD_RTA : string read FCOD_RTA write FCOD_RTA;
    property COD_DETALLE_RTA  : string read FCOD_DETALLE_RTA write FCOD_DETALLE_RTA;
    property OBSERVACIONES  : string read FOBSERVACIONES write FOBSERVACIONES;
  end;

  { Invokable interfaces must derive from IInvokable }
  IwsRestriccion = interface(IInvokable)
  ['{0D6BFEF1-3F4D-4B41-8F7A-ECD9858ADBD8}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
    function buscarRestricciones(Apellidos, Nombres, fechaNac, nroDoc,nrolibreta, genero,tipoDoc,paisEmisorDoc,nacionalidad:string ; fechaVTO:string=''): TRespuesta; stdcall;
    function ConsultaImpedimentosArgentina(consulta: DatosEntrada) : DatosSalida; stdcall;



  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IwsRestriccion));

end.
 