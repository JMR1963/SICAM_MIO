{ Invokable interface IwsSolicitudConsular }

unit wsSolicitudConsularIntf;

interface

uses InvokeRegistry, Types, XSBuiltIns, classes;

type





  TDatos = class(TRemotable)
  private
    FAPELLIDO     : String;
    FAPELLIDO1    : String;
    FNOMBRE       : String;
    FNOMBRE1      : String;
    FNACIONALIDAD : String;
    FNRO_DOC      : String;
    FFECHA_NAC    : String;
    FIMGDOC       : String;
    FIMGFACIL     : String;
  published
    property APELLIDO : String read FAPELLIDO write FAPELLIDO;
    property APELLIDO1 : String read FAPELLIDO1 write FAPELLIDO1;
    property NOMBRE : String read FNOMBRE write FNOMBRE;
    property NOMBRE1 : String read FNOMBRE1 write FNOMBRE1;
    property NACIONALIDAD : String read FNACIONALIDAD write FNACIONALIDAD;
    property NRO_DOC : String read FNRO_DOC write FNRO_DOC;
    property FECHA_NAC : String read FFECHA_NAC write FFECHA_NAC;
    property IMGDOC : String read FIMGDOC write FIMGDOC;
    property IMGFACIL : String read FIMGFACIL write FIMGFACIL;
  end;

  TConstancia = class(TRemotable)
  private
    FRESULTADO : String;
    FDATOS     : TDatos;
  published
    property RESULTADO : String read FRESULTADO write FRESULTADO;
    property DATOS : TDatos read FDATOS write FDATOS;
  end;



  { Invokable interfaces must derive from IInvokable }
  IwsSolicitudConsular = interface(IInvokable)
  ['{86087505-35DB-4662-8E94-5326394FD761}']

   function DataSolicitud(nro_doc, Nacionalidad:string):TConstancia; stdcall;

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }


  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IwsSolicitudConsular));

end.
 