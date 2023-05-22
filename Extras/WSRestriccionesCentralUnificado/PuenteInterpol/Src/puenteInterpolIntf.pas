{ Invokable interface IpuenteInterpol }

unit puenteInterpolIntf;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns;

type

  datosConsultaInterpol = class(TRemotable)
  private
    Fnombre: string;
    Fapellido: string;
    FfechaNacimiento: string;
    FtipoDoc: string;
    FnroDoc: string;
    Fpais: string;
    Fgenero: string;
    Ftransito: string;
    FusuarioNombre: string;
    FusuarioApellido: string;
    FusuarioIp: string;
    FusuarioDepen: string;
    FusuarioDepenId: string;
    FusuarioTipoDoc: string;
    FusuarioDoc: string;
    FusuarioJerarquia: string;
    Fusuario: string;
  published
    property nombre:           string  read Fnombre write fnombre ;
    property apellido:         string  read Fapellido write fapellido ;
    property fechaNacimiento:  string  read FfechaNacimiento write FfechaNacimiento ;
    property tipoDoc:          string  read FtipoDoc write ftipoDoc;
    property nroDoc:           string  read FnroDoc write fnroDoc ;
    property pais:             string  read Fpais write fpais ;
    property genero:           string  read Fgenero write fgenero ;
    property transito:         string  read Ftransito write ftransito ;
    property usuarioNombre:    string  read FusuarioNombre write fusuarioNombre ;
    property usuarioApellido:  string  read FusuarioApellido write fusuarioApellido ;
    property usuarioIp:        string  read FusuarioIp write fusuarioIp ;
    property usuarioDepen:     string  read FusuarioDepen write fusuarioDepen ;
    property usuarioDepenId:   string  read FusuarioDepenId write fusuarioDepenId ;
    property usuarioTipoDoc:   string  read FusuarioTipoDoc write fusuarioTipoDoc ;
    property usuarioDoc:       string  read FusuarioDoc write fusuarioDoc ;
    property usuarioJerarquia: string  read FusuarioJerarquia write fusuarioJerarquia ;
    property usuario:          string  read Fusuario write fusuario ;
  end;

  respuestaInterpol = class(TRemotable)
  private
    FCOD_DETALLE_RTA: string;
    FCOD_RTA: string;
    FCOLOR: string;
  published
    property COD_DETALLE_RTA: string  read FCOD_DETALLE_RTA write FCOD_DETALLE_RTA ;
    property COD_RTA:         string  read FCOD_RTA write FCOD_RTA ;
    property COLOR:           string  read FColor write FColor ;
  end;

  { Invokable interfaces must derive from IInvokable }
  IpuenteInterpol = interface(IInvokable)
  ['{E7337846-7C58-4A53-BFD5-AF9D5F9FDF60}']

    function ConsultaInterpol( datos : datosConsultaInterpol):respuestaInterpol; stdcall;
    function LoteDocumentosInterpol(LoteDnm : string ): string; stdcall;

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IpuenteInterpol));

end.
