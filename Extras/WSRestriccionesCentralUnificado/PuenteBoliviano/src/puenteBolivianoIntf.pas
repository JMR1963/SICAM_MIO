{ Invokable interface IpuenteBoliviano }

unit puenteBolivianoIntf;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns;

type


  DatosEntradaPte = class(TRemotable)
  private
    FUSUARIO: string;
    FCLAVE: string;
    FOPERADOR: string;
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
    FNUMEROIDENIFICACION: string;
  published
    property USUARIO:             string  read FUSUARIO write FUSUARIO;
    property CLAVE:               string  read FCLAVE write FCLAVE;
    property OPERADOR:            string  read FOPERADOR write FOPERADOR;
    property CODPAIS:             string  read FCODPAIS write FCODPAIS;
    property NOMBRE1:             string  read FNOMBRE1 write FNOMBRE1 ;
    property NOMBRE2:             string  read FNOMBRE2 write FNOMBRE2;
    property APELLIDO1:           string  read FAPELLIDO1 write FAPELLIDO1;
    property APELLIDO2:           string  read FAPELLIDO2 write FAPELLIDO2;
    property NUMDOC:              string  read FNUMDOC write FNUMDOC;
    property PUESTOCONTROL:       string  read FPUESTOCONTROL write FPUESTOCONTROL;
    property TIPODOC:             string  read FTIPODOC write FTIPODOC;
    property EMISORDOC:           string  read FEMISORDOC write FEMISORDOC;
    property FECHANAC:            string  read FFECHANAC write FFECHANAC;
    property GENERO:              string  read FGENERO write FGENERO ;
    property NACIONALIDAD:        string  read FNACIONALIDAD write FNACIONALIDAD ;
    property NUMEROIDENIFICACION: string  read FNUMEROIDENIFICACION write FNUMEROIDENIFICACION ;
  end;



  // ************************************************************************ //
  // XML       : DatosSalida, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  DatosSalidaPte = class(TRemotable)
  private
    FCOD_RTA: string;
    FCOD_DETALLE_RTA: string;
  published
    property COD_RTA:         string  read FCOD_RTA write FCOD_RTA;
    property COD_DETALLE_RTA: string  read FCOD_DETALLE_RTA write FCOD_DETALLE_RTA;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/ConsultaImpedimentosBolivia
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : wsImpedimentosBoliviaSoap
  // service   : wsImpedimentosBolivia
  // port      : wsImpedimentosBoliviaSoap
  // URL       : http://servicios.migracion.gob.bo/wsArgentina/wsImpedimentosBolivia.asmx
  // ************************************************************************ //

  { Invokable interfaces must derive from IInvokable }
  IpuenteBoliviano = interface(IInvokable)
  ['{1F3A5BAD-C071-4DA2-BD46-CE866910DA8E}']
    function ConsultaBolivia(Consulta: DatosEntradaPte): DatosSalidaPte; stdcall;
    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IpuenteBoliviano));

end.
