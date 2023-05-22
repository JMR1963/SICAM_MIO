{ Invokable interface ITAMS }

unit uTAMSIntf;

interface

uses
  Soap.InvokeRegistry, system.Types, Soap.XSBuiltIns, uAA2000;

type
  { Invokable interfaces must derive from IInvokable }
  ITAMS = interface(IInvokable)
  ['{8E09131F-B0DD-4B0E-85C5-3DC92624E44B}']
    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
    function GetFlightsOpSoap(const Airport: String): ArrayOfFlightOp; stdcall;
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(ITAMS));

end.
