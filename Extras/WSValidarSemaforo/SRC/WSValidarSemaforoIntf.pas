{ Invokable interface IWSValidarSemaforo }

unit WSValidarSemaforoIntf;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns;

Type TDatosEntrada = class(TRemotable)
  private
    FCodigoPaisEmisor: string;
    FObservacion: string;
    FFlag: string;
    Ftdi: string;
    FFuncionario: String;
    FNumeroDocumento: String;
    procedure SetCodigoPaisEmisor(const Value: string);
    procedure SetFlag(const Value: string);
    procedure SetFuncionario(const Value: String);
    procedure Settdi(const Value: String);
    procedure SetNumeroDocumento(const Value: String);
    procedure SetObservacion(const Value: string);
  published
    Property CodigoPaisEmisor:string read FCodigoPaisEmisor write SetCodigoPaisEmisor;
    Property NumeroDocumento:String read FNumeroDocumento write SetNumeroDocumento;
    Property Flag:string read FFlag write SetFlag;
    Property TDI:string read Ftdi write Settdi;
    Property Observacion:string read FObservacion write SetObservacion;
    Property Funcionario:String read FFuncionario write SetFuncionario;
end;


type

  { Invokable interfaces must derive from IInvokable }
  IWSValidarSemaforo = interface(IInvokable)
  ['{2247BC87-089A-402F-BCD0-6B06B72C8A0E}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
    function  EnviarRespuesta(Datos:TDatosEntrada):string;stdcall;
    Function   RecibirRespuesta(Datos: TDatosEntrada):string;stdcall;
  end;

implementation


{ TDatosEntrada }

procedure TDatosEntrada.SetCodigoPaisEmisor(const Value: string);
begin
  FCodigoPaisEmisor := Value;
end;

procedure TDatosEntrada.SetFlag(const Value: string);
begin
  FFlag := Value;
end;

procedure TDatosEntrada.SetFuncionario(const Value: String);
begin
  FFuncionario := Value;
end;

procedure TDatosEntrada.SetTDI(const Value: String);
begin
  Ftdi := Value;
end;

procedure TDatosEntrada.SetNumeroDocumento(const Value: String);
begin
  FNumeroDocumento := Value;
end;

procedure TDatosEntrada.SetObservacion(const Value: string);
begin
  FObservacion := Value;
end;

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IWSValidarSemaforo));

end.
 