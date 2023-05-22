{ Invokable interface IWSRemotoEGATE }

unit WSRemotoEGATEIntf;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns;

type

  { Invokable interfaces must derive from IInvokable }
  IWSRemotoEGATE = interface(IInvokable)
  ['{784B57AC-8859-4A4F-B961-8BF82E7DF2D0}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
    function biometricdevices(paramList:AnsiString):AnsiString; stdcall;
    function fingerMatch(paramList:AnsiString;const image: TByteDynArray):Integer;stdcall;
    function faceMatch(paramList:AnsiString;const strImgB64:AnsiString):Integer;stdcall;
    function foto1fft(paramList:AnsiString):Integer;stdcall;
    procedure reinicioWS32RemotofingerMatch;stdcall;
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IWSRemotoEGATE));

end.
