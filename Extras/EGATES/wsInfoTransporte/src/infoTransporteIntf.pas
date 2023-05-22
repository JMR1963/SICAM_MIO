{ Invokable interface IinfoTransporte }

unit infoTransporteIntf;

interface

uses Soap.InvokeRegistry, system.Types, soap.XSBuiltIns;

type

  trtaTransporte = class(tremotable)
  private
    fok: AnsiString;
    fvuelo : AnsiString;
    fpasajero: AnsiString;
    fhayTransporte: AnsiString;
  published
    property ok: AnsiString read Fok write fok ;
    property vuelo : AnsiString read Fvuelo  write fvuelo ;
    property pasajero: AnsiString read Fpasajero   write fpasajero ;
    property hayTransporte: AnsiString read FhayTransporte write fhayTransporte ;
  end;

  { Invokable interfaces must derive from IInvokable }
  IinfoTransporte = interface(IInvokable)
  ['{26927389-408A-4421-8FC0-03057150F6EE}']
      function InfTransporte(Ape1,ape2, nom1, nom2, nroDoc, nrolibreta, sentidoVuelo, tipopaso, paso, fecha_nac: AnsiString  ): trtaTransporte; stdcall;
    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IinfoTransporte));

end.
 