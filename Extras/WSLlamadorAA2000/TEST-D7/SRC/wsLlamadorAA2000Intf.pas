{ Invokable interface IwsLlamadorAA2000 }

unit wsLlamadorAA2000Intf;

interface

uses InvokeRegistry, Types, XSBuiltIns,manager;

type

   TData = class(TRemotable)
  private
    FID_Queue: AnsiString;
    FBOX: AnsiString;
    Fletter:AnsiString;
  published
    property ID_Queue: AnsiString read FID_Queue write FID_Queue;
    property BOX: AnsiString read FBOX write FBOX;
    property letter: AnsiString read Fletter write Fletter;
  end;

  TTurnInfo = class(TRemotable)
  private
    FERROR:AnsiString;
    FDESCRIPTION:AnsiString;
    FidQueue: AnsiString;
    FidQueueShift: AnsiString;
    FidParentQueue: AnsiString;
    Freason: AnsiString;
    Fletter: AnsiString;
    Forder: AnsiString;
    FidPlayer:AnsiString;
  published
    property ERROR: AnsiString read FERROR write FERROR;
    property DESCRIPTION: AnsiString read FDESCRIPTION write FDESCRIPTION;
    property idQueue:            AnsiString          read FidQueue write FidQueue;
    property idQueueShift:       AnsiString          read FidQueueShift write FidQueueShift;
    property idParentQueue:      AnsiString          read FidParentQueue write FidParentQueue;
    property reason:             AnsiString          read Freason write Freason;
    property letter:             AnsiString          read Fletter write Fletter;
    property order:           AnsiString             read Forder write Forder;
    property idPlayer: AnsiString read FidPlayer write FidPlayer;
  end;

  { Invokable interfaces must derive from IInvokable }
  IwsLlamadorAA2000 = interface(IInvokable)
  ['{80E9408F-75C8-48CA-B7B5-F966E24FDD31}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
   function Call(Data:TData): TTurnInfo; stdcall;
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IwsLlamadorAA2000));

end.
 