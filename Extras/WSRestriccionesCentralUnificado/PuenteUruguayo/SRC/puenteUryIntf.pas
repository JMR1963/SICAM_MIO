{ Invokable interface IpuenteUry }

unit puenteUryIntf;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns;

type

consultaPuenteURY = class(TRemotable)
  private
    FNOMBRES: string;
    FAPELLIDOS: string;
    FNUMDOC: string;
    FPUESTOCONTROL: string;
    FTIPODOC: string;
    FEMISORDOC: string;
    FFECHANAC: string;
    FGENERO: string;
    FNACIONALIDAD: string;
    FNUMEROIDENTIFICACION: string;
    FUSER: string;
  published
    property NOMBRES:              string  read FNOMBRES write FNOMBRES ;
    property APELLIDOS:            string  read FAPELLIDOS write FAPELLIDOS ;
    property NUMDOC:               string  read FNUMDOC write FNUMDOC ;
    property PUESTOCONTROL:        string  read FPUESTOCONTROL write FPUESTOCONTROL ;
    property TIPODOC:              string  read FTIPODOC write FTIPODOC ;
    property EMISORDOC:            string  read FEMISORDOC write FEMISORDOC ;
    property FECHANAC:             string  read FFECHANAC write FFECHANAC ;
    property GENERO:               string  read FGENERO write FGENERO ;
    property NACIONALIDAD:         string  read FNACIONALIDAD write FNACIONALIDAD ;
    property NUMEROIDENTIFICACION: string  read FNUMEROIDENTIFICACION write FNUMEROIDENTIFICACION ;
    property USER:                 string  read FUSER write FUSER;
  end;



  respuestaURY = class(TRemotable)
  private
    FCOD_DETALLE_RTA: string;
    FCOD_RTA: string;
  published
    property COD_DETALLE_RTA: string  read FCOD_DETALLE_RTA write FCOD_DETALLE_RTA ;
    property COD_RTA:         string  read FCOD_RTA write FCOD_RTA ;
  end;






  { Invokable interfaces must derive from IInvokable }
  IpuenteUry = interface(IInvokable)
  ['{39D46D5E-C541-475B-8B16-07E8D35D4A04}']

    function consultarPuenteUry (a : consultaPuenteURY)  : respuestaUry ; stdcall;

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IpuenteUry));

end.
