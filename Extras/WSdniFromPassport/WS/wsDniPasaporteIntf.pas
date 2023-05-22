{ Invokable interface IwsDniPasaporte }

unit wsDniPasaporteIntf;

interface

uses Soap.InvokeRegistry, system.Types, Soap.XSBuiltIns;

type

  { Invokable interfaces must derive from IInvokable }
  IwsDniPasaporte = interface(IInvokable)
  ['{FA65F8E5-6186-4C60-85C8-1A77E8084CE9}']
     function dniDePasaporte(unPasaporte: string): string; stdcall;
    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IwsDniPasaporte));

end.
 