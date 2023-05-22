{ Invokable interface Ipuentechileno }

unit puentechilenoIntf;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns;

type

consultaPuenteCHL = class(TRemotable)
  private
    FCODPAIS: string;
    FNOMBRE1: string;
    FNOMBRE2: string;
    FAPELLIDO1: string;
    FAPELLIDO2: string;
    FNUMDOC: string;
    FPUESTOCONTROL: string;
    FTIPODOC: string;
    FEMISORDOC: string;
    FFECHANAC: string;
    FGENERO: string;
    FNACIONALIDAD: string;
    FNUMEROIDENTIFICACION: string;
  published
    property CODPAIS:              string  read FCODPAIS write FCODPAIS ;
    property NOMBRE1:              string  read FNOMBRE1 write FNOMBRE1 ;
    property NOMBRE2:              string  read FNOMBRE2 write FNOMBRE2 ;
    property APELLIDO1:            string  read FAPELLIDO1 write FAPELLIDO1 ;
    property APELLIDO2:            string  read FAPELLIDO2 write FAPELLIDO2 ;
    property NUMDOC:               string  read FNUMDOC write FNUMDOC ;
    property PUESTOCONTROL:        string  read FPUESTOCONTROL write FPUESTOCONTROL ;
    property TIPODOC:              string  read FTIPODOC write FTIPODOC ;
    property EMISORDOC:            string  read FEMISORDOC write FEMISORDOC ;
    property FECHANAC:             string  read FFECHANAC write FFECHANAC ;
    property GENERO:               string  read FGENERO write FGENERO ;
    property NACIONALIDAD:         string  read FNACIONALIDAD write FNACIONALIDAD ;
    property NUMEROIDENTIFICACION: string  read FNUMEROIDENTIFICACION write FNUMEROIDENTIFICACION ;
  end;



  respuestaDTOCHL = class(TRemotable)
  private
    FCOD_DETALLE_RTA: string;
    FCOD_RTA: string;
  published
    property COD_DETALLE_RTA: string  read FCOD_DETALLE_RTA write FCOD_DETALLE_RTA ;
    property COD_RTA:         string  read FCOD_RTA write FCOD_RTA ;
  end;


  consultaProcederCHL = class(TRemotable)
  private
    FTipoDocumento: string;
    FNumeroDocumento: string;
    FPaisDocumento: string;
    FObservacion: string;
    FFuncionario: string;
    FStatus: string;
  published
    property TipoDocumento:   string   read FTipoDocumento write FTipoDocumento;
    property NumeroDocumento: string   read FNumeroDocumento write FNumeroDocumento ;
    property PaisDocumento:   string   read FPaisDocumento write FPaisDocumento ;
    property Observacion:     string   read FObservacion write FObservacion;
    property Funcionario:     string   read FFuncionario write FFuncionario;
    property Status:          string   read FStatus write FStatus;
  end;

  respuestaProcederCHL = class(TRemotable)
  private
    FStatus: Integer;
    FDescripcion: string;
  published
    property Status:      Integer  read FStatus write FStatus;
    property Descripcion: string   read FDescripcion write FDescripcion;
  end;

  WriteRequestCHL = class(TRemotable)
  private
    FData: string;
    FFechaCierre: string;
    FFileName : string;
  published
    property Data:        string   read FData write FData;
    property FechaCierre: string   read FFechaCierre write FFechaCierre;
    property FileName:    string   read FFileName write FFileName;
  end;


  WriteResponseCHL = class(TRemotable)
  private
    FStatus: Integer;
    FDescripcion: string;
  published
    property Status:      Integer  read FStatus write FStatus;
    property Descripcion: string   read FDescripcion write FDescripcion;
  end;

  DespachosChileRequestCHL = class(TRemotable)
  private
    FFINI: string;
    FFFIN: string;
  published
    property FINI: string  read FFINI write FFINI;
    property FFIN: string  read FFFIN write FFFIN;
  end;

  DespachosChileResponseCHL = class(TRemotable)
  private
    FStatus: Integer;
    FDescripcion: string;
    FData: string;
  published
    property Status:      Integer  read FStatus write FStatus;
    property Descripcion: string   read FDescripcion write FDescripcion;
    property Data:        string   read FData write FData;
  end;



  { Invokable interfaces must derive from IInvokable }
  Ipuentechileno = interface(IInvokable)
  ['{39D46D5E-C541-475B-8B16-07E8D35D4A04}']

    function consultarPuenteCHL (a : consultaPuenteCHL)  : respuestaDTOCHL ; stdcall;
    function procederCHL (a : consultaProcederCHL)  : respuestaProcederCHL ; stdcall;
    function RegistraViajeCHL(request: WriteRequestCHL): WriteResponseCHL; stdcall;
    function DespachosChileCHL(const request: DespachosChileRequestCHL): DespachosChileResponseCHL; stdcall;

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(Ipuentechileno));

end.
