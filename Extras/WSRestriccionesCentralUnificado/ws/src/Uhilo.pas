unit Uhilo;

interface

uses
  system.Classes, SqlOracleManage, WsListaControlIntf, vcl.Dialogs, SysUtils, ActiveX, SyncObjs;

type
  TConsultaHilos = class(TThread)
  private
    FEv: TEvent;
    CsR: TCriticalSection;
    CsF: TCriticalSection;
    CsCTR: TCriticalSection;
    CsFz: TCriticalSection;
    FConsulta: persona;
    FRestricciones: resultadoConsulta;
    FFuente: TESTATMANYSOURCES_NEW;
    FCantidadTotalRestricciones: Integer;
    FFinalizado: Boolean;
    Query: TSqlOracle;
    function GetRestricciones: ResultadoConsulta;
    function GetFuente: TESTATMANYSOURCES_NEW;
    function GetCantidadTotalRestricciones: Integer;
    function GetFinalizado: Boolean;
    procedure SetRestricciones(Value: ResultadoConsulta);
    procedure SetFuente(Value: TESTATMANYSOURCES_NEW);
    procedure SetCantidadTotalRestricciones(Value: Integer);
    procedure SetFinalizado(Value: Boolean);
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    procedure Execute; override;
    function Resultado: Integer;
    property Ev: TEvent read FEv;
    property Consulta: persona read FConsulta write FConsulta;
    property Restricciones: ResultadoConsulta read GetRestricciones;
    property Fuente: TESTATMANYSOURCES_NEW read GetFuente;
    property CantidadTotalRestricciones: Integer read GetCantidadTotalRestricciones;
    property Finalizado: Boolean read GetFinalizado;
  end;

implementation

uses
  Math;

function TconsultaHilos.GetRestricciones: ResultadoConsulta;
begin
  CsR.Acquire;
  SetLength(Result, Length(FRestricciones));
  Result := Copy(FRestricciones);
  CsR.Release;
end;

function TconsultaHilos.GetFuente: TESTATMANYSOURCES_NEW;
begin
  CsF.Acquire;
  SetLength(Result, Length(FFuente));
  Result := Copy(FFuente);
  CsF.Release;
end;

function TconsultaHilos.GetCantidadTotalRestricciones: Integer;
begin
  CsCTR.Acquire;
  Result := FCantidadTotalRestricciones;
  CsCTR.Release;
end;

function TconsultaHilos.GetFinalizado: Boolean;
begin
  CsFz.Acquire;
  Result := FFinalizado;
  CsFz.Release;
end;

procedure TconsultaHilos.SetRestricciones(Value: ResultadoConsulta);
begin
  CsR.Acquire;
  SetLength(FRestricciones, Length(Value));
  FRestricciones := Copy(Value);
  CsR.Release;
end;

procedure TconsultaHilos.SetFuente(Value: TESTATMANYSOURCES_NEW);
begin
  CsF.Acquire;
  SetLength(FFuente, Length(Value));
  FFuente := Copy(Value);
  CsF.Release;
end;

procedure TconsultaHilos.SetCantidadTotalRestricciones(Value: Integer);
begin
  CsCTR.Acquire;
  FCantidadTotalRestricciones := Value;
  CsCTR.Release;
end;

procedure TconsultaHilos.SetFinalizado(Value: Boolean);
begin
  CsFz.Acquire;
  FFinalizado := Value;
  CsFz.Release;
end;

constructor TconsultaHilos.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FEv := TEvent.Create(nil, True, False, '');
  CsR := TCriticalSection.Create;
  CsF := TCriticalSection.Create;
  CsCTR := TCriticalSection.Create;
  CsFz := TCriticalSection.Create;
  FCantidadTotalRestricciones := 0;
  FFinalizado := False;
end;

destructor TconsultaHilos.Destroy;
begin
  CsR.Free;
  CsF.Free;
  CsCTR.Free;
  CsFz.Free;
  FEv.Free;
  inherited Destroy;
end;

procedure TconsultaHilos.Execute;
begin
  try
    //creo ecla clase de la consulta
    query := TSqlOracle.create;
    try
      //parametros de la consulta
      query.Individuo := FConsulta;//individuo;
      query.Ejecutar;
      //Retornar el resultado y la fuente
      SetRestricciones(query.resultado);
      SetCantidadTotalRestricciones(Length(query.resultado));
      SetFuente(query.fuente);
      SetFinalizado(True);
    finally
      query.Free;
    end;
  except
  end;
  FEv.SetEvent;
end;

function TconsultaHilos.resultado: Integer;
begin
  //La cantidad de registros devueltos. Modificar para que retorne la longitud
  Result := FCantidadTotalRestricciones;
end;

end.
