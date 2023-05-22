{ Invokable interface IWSTransitos }

unit WSTransitosIntf;

interface

uses Soap.InvokeRegistry, system.Types, Soap.XSBuiltIns;

type

  ttransitoFile = class(TRemotable)
  private
    Ffile: widestring;
    Forganismo: string;
    ffecha: string;
  published
    property archivo: widestring read Ffile write Ffile;
    property organismo: string read Forganismo write Forganismo;
    property fecha: string read ffecha write ffecha;
  end;

  tconsulta = class(TRemotable)
  private
    Fdia : string;
    Forganismo : string;
  published
    property dia : string read Fdia write Fdia;
    property organismo : string read Forganismo write Forganismo;
  end;

  tusuario = class(TRemotable)
  private
    FUser : string;
    FPassword : string;
  published
    property user : string read FUser write FUser;
    property password : string read FPassword write FPassword;
  end;

  tarchivo = class(tremotable)
  private
    FFileStr : string;
    FFileName : string;
  published
    property FileStr : string read FFileStr write FFileStr;
    property FileName : string read FFileName write FFileName;
  end;

  { Invokable interfaces must derive from IInvokable }
  IWSTransitos = interface(IInvokable)
  ['{39BA30ED-D99C-453A-BB21-F9B73869CB66}']
    function ArgentinosPaso(dia: string): string; stdcall;
    function ExtrangerosPaso(dia: string): string; stdcall;
    function TodosPaso(dia: string): string; stdcall;
    function guardarRestricciones(transitos: ttransitoFile): boolean; stdcall;
    function guardarRestriccionesxml(transitos: ttransitoFile): boolean; stdcall;
    function Argentinos(dia: string): string; stdcall;

    (*Metodos para mandar y recibir los arachivos de los procesos Batch con otros organismos
        enviarSolicitud
        obtenerRespuestaSolicitud
    *)
    function enviarSolicitud(transitos: ttransitoFile; NRO_ENVIO:string): boolean; stdcall;
    function obtenerRespuestaSolicitud(consulta : tconsulta; NRO_ENVIO:string): ttransitoFile; stdcall;


    function validarUsuarioOrganismo(usuario : tusuario): boolean; stdcall;
    function Enviar_Transitos_SICaM (transitos: ttransitoFile): boolean;stdcall;// metodo a consumir por Ury. para enviar transitos.
    //function Enviar_Transitos_SICaM_alt (transitos: ttransitoFile): boolean; stdcall;
    function enviarManifiestoUry(archivo : tarchivo) : string; stdcall;
    function enviarManifiestoCHL(archivo : tarchivo) : string; stdcall;
    function enviarManifiestoPryBol(archivo : tarchivo) : string; stdcall;
    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IWSTransitos));

end.
 