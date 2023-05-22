{ Invokable interface IWS32RemotofingerMatch }

unit WS32RemotofingerMatchIntf;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns;

type

  { Invokable interfaces must derive from IInvokable }
  IWS32RemotofingerMatch = interface(IInvokable)
  ['{39640983-475C-4844-A13E-22B75CFD4A35}']
    function fingerMatch(paramList:AnsiString;const image: TByteDynArray):Integer;stdcall;
    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
    function formateoSoloHuella1WSQ(paramList:AnsiString):Integer;stdcall;
    procedure reinicioWS64Remoto;stdcall;
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IWS32RemotofingerMatch));

end.
