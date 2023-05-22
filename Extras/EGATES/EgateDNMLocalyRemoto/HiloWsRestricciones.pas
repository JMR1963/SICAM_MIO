unit HiloWsRestricciones;

interface

uses
  System.Classes;

type
  TwsRestricciones = class(TThread)
  private
    FActive: Boolean;
    FtransactionId: string;
    FApellidos: string;
    FNombres: string;
    FfechaNac, FfechaVTO: string;
    FnroDoc: string;
    Fnrolibreta: string;
    Fgenero: string;
    FtipoDoc: string;
    FpaisEmisorDoc: string;
    Fnacionalidad: string;
    procedure SetActive(const Value: Boolean);
  protected
    procedure Execute; override;
  public
    wsFin: Boolean;
    wsRRestriccion: string;
    wsRTransporte: string;
    wsRTipoPasajero: string;
    //wsRInfoExtra : string;
    wsRestriccionEntradaSalida: string;
    allowed: Boolean;
    transport: string;
    constructor Create(transactionId: string; Apellidos: string; Nombres: string; fechaNac: string; nroDoc: string; nrolibreta: string; genero: string; tipoDoc: string; paisEmisorDoc: string; nacionalidad: string; fechaVTO: string);
    destructor Destroy; override;
    property Active: Boolean read FActive write SetActive;

  end;

implementation

uses
  DMBase, Winapi.ActiveX, IwsRestriccion1, uGlobal, EgateFunciones, System.SysUtils;

constructor TwsRestricciones.Create(transactionId: string; Apellidos: string; Nombres: string; fechaNac: string; nroDoc: string; nrolibreta: string; genero: string; tipoDoc: string; paisEmisorDoc: string; nacionalidad: string; fechaVTO: string);
begin
  inherited Create(True);
  // You practically always need to pass 'True' because 'False' is just meaningless...
  FtransactionId := transactionId;
  FApellidos := Apellidos;
  FNombres := Nombres;
  FfechaNac := fechaNac;
  FnroDoc := nroDoc;
  Fnrolibreta := nrolibreta;
  Fgenero := genero;
  FtipoDoc := tipoDoc;
  FpaisEmisorDoc := paisEmisorDoc;
  Fnacionalidad := nacionalidad;
  FfechaVTO := fechaVTO;
  Resume; // Now that everything is created, we officially start the thread.
end;

destructor TwsRestricciones.Destroy;
begin
  FActive := False; // Make sure our process is stopped...
  WaitFor; // Wait for the process to stop before we continue freeing things...
  inherited;
end;

procedure TwsRestricciones.Execute;
var
  DMBaseIB: TDMBaseIB;
  sentido, usuario: string;
  wsR: IwsRestriccion;
  e: DatosEntrada;
  s: TRespuesta;
begin

  DMBaseIB := TDMBaseIB.Create(nil);
  WSFin := False;
  try
    CoInitializeEx(0, COINIT_MULTITHREADED);
    try
      DMBaseIB.DBTransaction(FtransactionId, sentido, usuario);

      wsRRestriccion := '';
      wsRTransporte := '';
      wsRTipoPasajero := '';
      //wsRInfoExtra := '';


      if sentido = 'E' then
        wsRestriccionEntradaSalida := wsRestriccionEntrada
      else
        wsRestriccionEntradaSalida := wsRestriccionSalida;

      try

        grabarEnArchivoLog('*** wsRestricciones:' + wsRestriccionEntradaSalida);

        for var i := 0 to 4 do
        begin
          try
            s := IwsRestriccion1.GetIwsRestriccion2(wsRestriccionEntradaSalida).buscarRestricciones(FApellidos, FNombres, FfechaNac, FnroDoc, Fnrolibreta, Fgenero, FtipoDoc, FpaisEmisorDoc, Fnacionalidad, FfechaVTO);
            break
          except
            on e1: Exception do
            begin
              grabarEnArchivoLog('wsRestricciones - Intento wsRestricciones ' + e1.Message);
              Sleep(1050);
              if i >= 2 then
                raise Exception.Create(e1.Message);
            end;
          end;
        end;

        grabarEnArchivoLog('wsRestricciones: nro DOC' + FnroDoc + '-REST:' + s.Restriccion + '-TRANS:' + s.Transporte);
        allowed := s.Restriccion <> 'T';
        transport := s.Transporte;

        wsRRestriccion := s.Restriccion;
        wsRTransporte := s.Transporte;
        wsRTipoPasajero := s.TipoPasajero;
        //wsRInfoExtra := s.InfoExtra;
      except
        on e: Exception do
        begin
          grabarEnArchivoLog('Error - wsRestricciones:' + e.Message);
        end;
      end;
    finally
  //    CoUninitialize;
      freeAndNil(s);
    end;
  finally
    DMBaseIB.Free;
    wsFin := True;
  end;
end;

procedure TwsRestricciones.SetActive(const Value: Boolean);
begin
  FActive := Value;
end;

end.

