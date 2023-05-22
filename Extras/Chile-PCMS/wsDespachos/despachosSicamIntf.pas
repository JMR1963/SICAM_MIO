{ Invokable interface IdespachosSicam }

unit despachosSicamIntf;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns;

type

  TFECHA = class(TRemotable)
  private
    FFINI: AnsiString;
    FFFIN: AnsiString;
  published
    property FINI: AnsiString read FFINI write FFINI;
    property FFIN: AnsiString read FFFIN write FFFIN;
  end;

  TRESULTADO = class(TRemotable)
  private
    FRESULTADO: WideString;
  published
    property RESULTADO: WideString read FRESULTADO write FRESULTADO;
  end;


  TDESPCHILES = class(TRemotable)
  private
    FFINI: AnsiString;
    FFFIN: AnsiString;
    FID : AnsiString;
    FFUN : AnsiString;
  published
    property FINI: AnsiString read FFINI write FFINI;
    property FFIN: AnsiString read FFFIN write FFFIN;
    property ID: AnsiString read FID write FID;
    property FUN: AnsiString read FFUN write FFUN;
  end;

  TXML = class(TRemotable)
  private
    FXML: AnsiString;
  published
    property XML: AnsiString read FXML write FXML;
  end;

  TLS = class(TRemotable)
  private
    FLSA: AnsiString;
    FLSB: AnsiString;
  published
    property LSA: AnsiString read FLSA write FLSA;
    property LSB: AnsiString read FLSB write FLSB;
  end;

  { Invokable interfaces must derive from IInvokable }
  IdespachosSicam = interface(IInvokable)
  ['{56E63CEA-137A-41AE-8846-0CE010470175}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
    function despachosSicam(FECHA:TFECHA):TRESULTADO; stdcall;
    function despachosChile(DESPCHL:TDESPCHILES):TRESULTADO; stdcall;
//    function despachosUruguay(DESPCHL:TDESPCHILES):TRESULTADO; stdcall;

//    function ARGFaltantesEnMONTEAYMOND(DESPCHILES:TDESPCHILES):TRESULTADO; stdcall;

    function DESPACHOSxmlToLs(aXML:TXML):TRESULTADO;stdcall;
    function FALTANTESxmlToLs(aXML:TXML):TRESULTADO;stdcall;
    function DifLsALsB(LS:TLS):TRESULTADO;stdcall;

  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IdespachosSicam));

end.
 