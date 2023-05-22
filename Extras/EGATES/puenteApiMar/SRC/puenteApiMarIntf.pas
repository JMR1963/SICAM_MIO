{ Invokable interface IpuenteApiMar }

unit puenteApiMarIntf;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns;

type

  { Invokable interfaces must derive from IInvokable }
  IpuenteApiMar = interface(IInvokable)
  ['{07888BC1-483A-444D-AEF4-96C828F062CD}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
    function dameApi(Paso , Ape1, ape2, nombre1, nombre2, FechaNac, nroDoc,Libreta: string) : string; stdcall;
  end;

implementation



initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IpuenteApiMar));

end.
