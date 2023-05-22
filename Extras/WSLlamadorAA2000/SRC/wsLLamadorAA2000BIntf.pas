{ Invokable interface IwsLLamadorAA2000B }

unit wsLLamadorAA2000BIntf;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns;

type

  TData = class(TRemotable)
  private
    FID_COLA: AnsiString;
    FBOX: AnsiString;
    FLETRA: AnsiString;
  published
    property ID_COLA: AnsiString read FID_COLA write FID_COLA;
    property BOX: AnsiString read FBOX write FBOX;
    property LETRA: AnsiString read FLETRA write FLETRA;
  end;

  TTurno = class(TRemotable)
  private
    FERROR: AnsiString;
    FDESCRIPCION: AnsiString;
    FID_COLA: AnsiString;
    FID_TURNO: AnsiString;
    FBOX: AnsiString;
    FLETRA: AnsiString;
    FORDEN: AnsiString;
    FXDIA_COLA: AnsiString;
    FXINI_COLA: AnsiString;
    FXSTAR_COLA: AnsiString;
    FCANT_RELLAMAR: AnsiString;
  published
    property ERROR: AnsiString read FERROR write FERROR;
    property DESCRIPCION: AnsiString read FDESCRIPCION write FDESCRIPCION;
    property ID_COLA: AnsiString read FID_COLA write FID_COLA;
    property ID_TURNO: AnsiString read FID_TURNO write FID_TURNO;
    property BOX: AnsiString read FBOX write FBOX;
    property LETRA: AnsiString read FLETRA write FLETRA;
    property ORDEN: AnsiString read FORDEN write FORDEN;
    property XDIA_COLA: AnsiString read FXDIA_COLA write FXDIA_COLA;
    property XINI_COLA: AnsiString read FXINI_COLA write FXINI_COLA;
    property XSTAR_COLA: AnsiString read FXSTAR_COLA write FXSTAR_COLA;
    property CANT_RELLAMAR: AnsiString read FCANT_RELLAMAR write FCANT_RELLAMAR;
  end;

  TRespuesta = class(TRemotable)
  private
    FERROR: AnsiString;
    FDESCRIPCION: AnsiString;
  published
    property ERROR: AnsiString read FERROR write FERROR;
    property DESCRIPCION: AnsiString read FDESCRIPCION write FDESCRIPCION;
  end;

  TCOLAS = class(TRemotable)
  private
    FID_COLA: AnsiString;
    FNOMBRE: AnsiString;
    FLUGAR: AnsiString;
    FLETRA: AnsiString;
  published
    property ID_COLA: AnsiString read FID_COLA write FID_COLA;
    property NOMBRE: AnsiString read FNOMBRE write FNOMBRE;
    property LUGAR: AnsiString read FLUGAR write FLUGAR;
    property LETRA: AnsiString read FLETRA write FLETRA;
  end;

  TArrayColas = Array of TCOLAS;

  { Invokable interfaces must derive from IInvokable }
  IwsLLamadorAA2000B = interface(IInvokable)
  ['{108B4444-4155-4F0D-819E-433A32DA3286}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
    function Call(Data:TData): TTurno; stdcall;
    function ReCall(Turno:TTurno): TRespuesta; stdcall;
    function Finish(Turno:TTurno): TRespuesta; stdcall;
    function QueuesList(): TArrayColas; stdcall;
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IwsLLamadorAA2000B));

end.
