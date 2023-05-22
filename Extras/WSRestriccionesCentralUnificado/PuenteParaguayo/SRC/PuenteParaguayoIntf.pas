{ Invokable interface IPuenteParaguayo }

unit PuenteParaguayoIntf;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns;

type

consultaPuentePry = class(TRemotable)
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



  respuestaDTOPry = class(TRemotable)
  private
    FCOD_DETALLE_RTA: string;
    FCOD_RTA: string;
  published
    property COD_DETALLE_RTA: string  read FCOD_DETALLE_RTA write FCOD_DETALLE_RTA ;
    property COD_RTA:         string  read FCOD_RTA write FCOD_RTA ;
  end;


  { Invokable interfaces must derive from IInvokable }
  IPuenteParaguayo = interface(IInvokable)
  ['{39D46D5E-C541-475B-8B16-07E8D35D4A04}']

    function consultarPuentePry (a : consultaPuentePry)  : respuestaDTOPry ; stdcall;

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IPuenteParaguayo));

end.
