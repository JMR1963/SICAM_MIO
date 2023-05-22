unit uMANIFIESTO;

interface

uses
  System.Classes, IdThreadSafe, Winapi.Windows;

const
  NombreXML = 'Transito.XML';

type
  Tmanifiesto = class
  private
    procedure reemplazarEnTemplate(Busco, reemplazo: string);
  public
    idLOC, TRANSACTIONID, XML, sentido, XMLTemplate: string;
    wsRRestriccion: string;
    wsRTransporte: string;
    wsRTipoPasajero: string;
    XML64: AnsiString;
    CalidadHuella: Integer;
    CSMani: TRTLCriticalSection;
    procedure CompletarDatosPersonales;
    procedure CompletarHuella;
    procedure CompletarCara;
    procedure CompletarRestriccion;
    function GenerarXMLVacio: AnsiString;
    function LeerArchivo(nombre: string): AnsiString;
  end;

  TManiDOCThread = class(TThread)
  private
    FActive: Boolean;
    FManifiesto: Tmanifiesto;
    procedure SetActive(const Value: Boolean);
  protected
    procedure Execute; override;
  public
    constructor Create(Manifiesto: Tmanifiesto);
    destructor Destroy; override;
    property Active: Boolean read FActive write SetActive;
  end;

  TManiHuellaThread = class(TThread)
  private
    FActive: Boolean;
    FManifiesto: Tmanifiesto;
    procedure SetActive(const Value: Boolean);
  protected
    procedure Execute; override;
  public
    constructor Create(Manifiesto: Tmanifiesto);
    destructor Destroy; override;
    property Active: Boolean read FActive write SetActive;
  end;

  TManiRestriccionThread = class(TThread)
  private
    FActive: Boolean;
    FManifiesto: Tmanifiesto;
    procedure SetActive(const Value: Boolean);
  protected
    procedure Execute; override;
  public
    constructor Create(Manifiesto: Tmanifiesto);
    destructor Destroy; override;
    property Active: Boolean read FActive write SetActive;
  end;

  TWSManifiesto = class
  public
    actManifiesto: Tmanifiesto;
    FechaCreacion: TDateTime;
    idLOC, TRANSACTIONID: AnsiString;
    ManiDOCThread: TManiDOCThread;
    ManiHuellaThread: TManiHuellaThread;
    ManiRestriccionThread: TManiRestriccionThread;
    CalidadHuella: Integer;
    wsRRestriccion: string;
    wsRTransporte: string;
    wsRTipoPasajero: string;
    constructor Create(idLOC, TRANSACTIONID: AnsiString);
    procedure CargarHuella;
    procedure CargarRestriccion;
    procedure CargarCara;
    procedure CargarTransporte;
    function finalizarMani: AnsiString;
    function ManiSentido: string;
  end;

procedure CrearManifiesto(TRANSACTIONID: AnsiString);

function CargarHuellaEnManifiesto(TRANSACTIONID: AnsiString): Boolean;



function CargarCalidadHuella(TRANSACTIONID: AnsiString; calidad: Integer): Boolean;

function CargarInfoRestricciones(TRANSACTIONID: AnsiString; wsRRestriccion: string; wsRTransporte: string; wsRTipoPasajero: string): Boolean;

function CargarInfoTransporte(TRANSACTIONID: AnsiString; wsRTransporte: string): Boolean;

function ManifiestoSentido(TRANSACTIONID: AnsiString): AnsiString;

function finalizarManifiesto(TRANSACTIONID: AnsiString): AnsiString;

procedure freeManifiesto(TRANSACTIONID: AnsiString);

function liberoManifiesto:String;

//var
//  GLOBAL_LOGICAINVERSA:Boolean = False;

implementation

{ Tmanifiesto }
uses
  XML.XMLDoc, XML.XMLIntf, DMBase, EGateMgrWSIntf, EgateFunciones, System.SysUtils,
  uGlobal, System.DateUtils;

var
  StrL: TIdThreadSafeStringList;

function liberoManifiesto:String;
var
  sl: TStringList;
  Mani: TWSManifiesto;
  TRANSACTIONID: string;
begin
  Result := '';
  try
    try
      sl := StrL.Lock;
      if sl.Count > 0 then
      begin
        Mani := TWSManifiesto(sl.Objects[0]);
        if MinutesBetween(Now, Mani.FechaCreacion) > 15 then
          TRANSACTIONID := sl.Strings[0]
        else
          TRANSACTIONID := '';
      end;

      Result := TRANSACTIONID;
      if TRANSACTIONID <> '' then
      begin
        if Assigned(Mani) then
        begin
          try
            if Assigned(Mani.ManiDOCThread) then
              Mani.ManiDOCThread.Free;
          except
          end;
          try
            if Assigned(Mani.ManiHuellaThread) then
              Mani.ManiHuellaThread.Free;
          except
          end;
          try
            if Assigned(Mani.ManiRestriccionThread) then
              Mani.ManiRestriccionThread.Free;
          except
          end;

          try
            FreeAndNil(Mani.actManifiesto);
          except
          end;

          try
            FreeAndNil(Mani);
          except
          end;
          sl.Delete(0);
        end;
      end;

    finally
      StrL.Unlock;
    end;


  except
    on e: Exception do
    begin
      grabarEnArchivoLog('liberoManifiesto' + e.Message);
    end;
  end;

end;

procedure CrearManifiesto(TRANSACTIONID: AnsiString);
var
  Mani: TWSManifiesto;
begin
  Mani := TWSManifiesto.Create(idLOC, TRANSACTIONID);
  StrL.AddObject(TRANSACTIONID, Mani);
end;

function CargarCalidadHuella(TRANSACTIONID: AnsiString; calidad: Integer): Boolean;
var
  Mani: TWSManifiesto;
begin
  Result := False;
  Mani := TWSManifiesto(StrL.ObjectByItem(TRANSACTIONID));
  if Assigned(Mani) then
  begin
    Mani.CalidadHuella := calidad;
    Result := True;
  end;
end;



function CargarInfoRestricciones(TRANSACTIONID: AnsiString; wsRRestriccion: string; wsRTransporte: string; wsRTipoPasajero: string): Boolean;
var
  Mani: TWSManifiesto;
begin
  Result := False;
  Mani := TWSManifiesto(StrL.ObjectByItem(TRANSACTIONID));
  if Assigned(Mani) then
  begin
    Mani.wsRRestriccion := wsRRestriccion;
    Mani.wsRTransporte := wsRTransporte;
    Mani.wsRTipoPasajero := wsRTipoPasajero;
    Mani.CargarRestriccion;
    Result := True;
  end;
end;

function CargarInfoTransporte(TRANSACTIONID: AnsiString; wsRTransporte: string): Boolean;
var
  Mani: TWSManifiesto;
begin
  Result := False;
  Mani := TWSManifiesto(StrL.ObjectByItem(TRANSACTIONID));
  if Assigned(Mani) then
  begin
    if trim(Mani.wsRTransporte)<>'' then begin
      if trim(UpperCase(Mani.wsRTransporte)) <> trim(UpperCase(wsRTransporte)) then begin
        Result := False;
        Exit;

      end;

    end;


    Mani.wsRTransporte := wsRTransporte;
    Mani.CargarTransporte;
    Result := True;
  end;
end;

function CargarHuellaEnManifiesto(TRANSACTIONID: AnsiString): Boolean;
var
  Mani: TWSManifiesto;
begin
  Result := False;
  Mani := TWSManifiesto(StrL.ObjectByItem(TRANSACTIONID));
  if Assigned(Mani) then
  begin
//    if GLOBAL_LOGICAINVERSA then
//      Mani.CargarCara
//    else
      Mani.CargarHuella; //MEGATRAN

    Result := True;
  end;
end;

function ManifiestoSentido(TRANSACTIONID: AnsiString): AnsiString;
var
  Mani: TWSManifiesto;
  DMBaseIB: TDMBaseIB;
  sentido, usuario: string;
begin
  Result := '';
  try
    try
      Mani := TWSManifiesto(StrL.ObjectByItem(TRANSACTIONID));
      if Assigned(Mani) then
      begin
        Result := Mani.ManiSentido;
      end;
    except
      if Result = '' then
      begin
        DMBaseIB := TDMBaseIB.Create(nil);
        try
          DMBaseIB.DBTransaction(TRANSACTIONID, sentido, usuario);
          Result := sentido;
        finally
          DMBaseIB.Free;
        end;
      end;

    end;
  except
  end;
end;

function finalizarManifiesto(TRANSACTIONID: AnsiString): AnsiString;
var
  Mani: TWSManifiesto;
begin
  Result := '';
  Mani := TWSManifiesto(StrL.ObjectByItem(TRANSACTIONID));
  if Assigned(Mani) then
  begin

//    if GLOBAL_LOGICAINVERSA then
//      Mani.CargarHuella
//    else
      Mani.CargarCara; //MEGATRAN

    Result := Mani.finalizarMani;
    try
      if Assigned(Mani.ManiDOCThread) then
        Mani.ManiDOCThread.Free;
    except
    end;
    try
      if Assigned(Mani.ManiHuellaThread) then
        Mani.ManiHuellaThread.Free;
    except
    end;
    try
      if Assigned(Mani.ManiRestriccionThread) then
        Mani.ManiRestriccionThread.Free;
    except
    end;
    try
      FreeAndNil(Mani.actManifiesto);
    except
    end;
    try
      FreeAndNil(Mani);
    except
    end;
    freeManifiesto(TRANSACTIONID);
  end
  else
  begin
    try
      freeManifiesto(TRANSACTIONID);
    except
    end;
    raise Exception.Create('Error al generar el Manifiesto');
    // CrearManifiesto(TRANSACTIONID);
    // CargarCalidadHuella(TRANSACTIONID,-1);
    // CargarHuellaEnManifiesto(TRANSACTIONID);
    // finalizarManifiesto(TRANSACTIONID);
  end;
end;

procedure freeManifiesto(TRANSACTIONID: AnsiString);
begin
  StrL.Remove(TRANSACTIONID);
end;


function Tmanifiesto.LeerArchivo(nombre: string): AnsiString;
var
  arch: AnsiString;
begin
  Result := '';
  arch := DirTransac(idLOC, TRANSACTIONID) + nombre;

  if FileExists(arch) then
    Result := ConvertFileToStrBase64(arch);
end;

procedure Tmanifiesto.CompletarCara;
begin
//  reemplazarEnTemplate('#foto1.jpg#', LeerArchivo('foto1.jpg'));
  reemplazarEnTemplate('#foto2.jpg#', LeerArchivo('foto2.jpg'));
end;

procedure Tmanifiesto.CompletarDatosPersonales;
var
  Pd: PersonData2;
  DMBaseIB: TDMBaseIB;
  pri, seg: string;
  sentido, usuario: string;
begin
  DMBaseIB := TDMBaseIB.Create(nil);
  try
    Pd := DMBaseIB.DBPersonData(TRANSACTIONID);
    try
      DMBaseIB.DBTransaction(TRANSACTIONID, sentido, usuario);
      Self.sentido := sentido;

      reemplazarEnTemplate('#FECHA_TRANSITO#', FormatDateTime('DD/MM/YYYY hh:mm:ss', DMBaseIB.DBFechaHora));
      // reemplazarEnTemplate('#TIPO_PASAJERO#', Pd.TIPO_PASAJERO);
      reemplazarEnTemplate('#docType#', Pd.docType);
      reemplazarEnTemplate('#issuingCountry#', Pd.issuingCountry);
      reemplazarEnTemplate('#docNumber#', Pd.docNumber);
      reemplazarEnTemplate('#nationality#', Pd.nationality);
      reemplazarEnTemplate('#FUNCIONARIO#', usuario);
      reemplazarEnTemplate('#NRO_LIBRETA#', Pd.passportNumber);

      pri := '';
      seg := '';
      FixNames(Pd.firstName, pri, seg);
      reemplazarEnTemplate('#Npri#', pri);
      reemplazarEnTemplate('#Nseg#', seg);

      reemplazarEnTemplate('#sex#', Pd.sex);

      pri := '';
      seg := '';
      FixNames(Pd.lastName, pri, seg);
      reemplazarEnTemplate('#Apri#', pri);
      reemplazarEnTemplate('#Aseg#', seg);

      reemplazarEnTemplate('#FEC_NAC#', FormatDateTime('DD/MM/YYYY', YYMMDDtoDate(Pd.dob)));

      reemplazarEnTemplate('#FECHA_EXPIRACION_DOCUMENTO#', FormatDateTime('DD/MM/YYYY', YYMMDDtoDateSumo2000(Pd.FECHA_EXPIRACION)));

      reemplazarEnTemplate('#TIPO_ACCION#', sentido);
      reemplazarEnTemplate('#TIPO_MEDIO_TRANSPORTE#', TIPO_MEDIO_TRANSPORTE);

      reemplazarEnTemplate('#DOC_6.jpg#', LeerArchivo('DOC_6.jpg'));
      reemplazarEnTemplate('#DOC_8.jpg#', LeerArchivo('DOC_8.jpg'));
      reemplazarEnTemplate('#DOC_7.jpg#', LeerArchivo('DOC_7.jpg'));
      reemplazarEnTemplate('#DOC_4.jpg#', LeerArchivo('DOC_4.jpg'));
      reemplazarEnTemplate('#DOC_5.jpg#', LeerArchivo('DOC_5.jpg'));
      reemplazarEnTemplate('#DOC_3.jpg#', LeerArchivo('DOC_3.jpg'));
      reemplazarEnTemplate('#DOC_1.jpg#', LeerArchivo('DOC_1.jpg'));
      reemplazarEnTemplate('#DOC_2.jpg#', LeerArchivo('DOC_2.jpg'));

    finally
      Pd.Free;
    end;

  finally
    DMBaseIB.Free;
  end;
end;

procedure Tmanifiesto.CompletarHuella;
begin
  reemplazarEnTemplate('#CALIDAD_HUELLA_CAPTURADA#', IntToStr(CalidadHuella));
  reemplazarEnTemplate('#huella2.wsq#', LeerArchivo('huella2.wsq'));
  reemplazarEnTemplate('#foto1.jpg#', LeerArchivo('foto1.jpg'));
end;

procedure Tmanifiesto.CompletarRestriccion;
var
  DMBaseIB: TDMBaseIB;
begin
  DMBaseIB := TDMBaseIB.Create(nil);
  try
    DMBaseIB.DBRestriccion(TRANSACTIONID, wsRTransporte, wsRTipoPasajero, wsRRestriccion);
  finally
    DMBaseIB.Free;
  end;

  reemplazarEnTemplate('#POSEE_IMPEDIMENTO#', wsRRestriccion);
  if not WSEsKiosko then
    reemplazarEnTemplate('#MATRICULA_MEDIO_TRANSPORTE#', wsRTransporte);
  reemplazarEnTemplate('#TRIPULANTE_PASAJERO#', wsRTipoPasajero);
end;



function Tmanifiesto.GenerarXMLVacio: AnsiString;
begin
  Result := '<?xml version="1.0" encoding="ISO-8859-1" standalone="yes"?>' + '<MANIFIESTO><HEADER TIPO_MEDIO_TRANSPORTE="#TIPO_MEDIO_TRANSPORTE#"' + ' TIPO_ACCION="#TIPO_ACCION#" PROCEDENCIA_DESTINO="" PAIS_MATRICULA="" NOMBRE_DE_VIAJE="" MATRICULA_MEDIO_TRANSPORTE="#MATRICULA_MEDIO_TRANSPORTE#" ID_SOBRE="" FUNCIONARIO="#FUNCIONARIO#" FECHA_PROGRAMADA_TRANSPORTE="" EMPRESA=""/>' + '<ROW TRIPULANTE_PASAJERO="#TRIPULANTE_PASAJERO#" TIPO_DOCUMENTO="#docType#" PA' +
    'IS_DOCUMENTO="#issuingCountry#" NUMERO_DOCUMENTO="#docNumber#" N' + 'ACIONALIDAD="#nationality#" NRO_LIBRETA="#NRO_LIBRETA#" FECHA_EMISION_DOCUMENTO="" FECHA_EXPIRACION_DOCUMENTO="#FECHA_EXPIRACION_DOCUMENTO#" SEXO="#sex#" PRI_NOMBRE="#Npri#" SEG_NOMBRE' + '="#Nseg#" PRI_APELLIDO="#Apri#" SEG_APELLIDO="#Aseg#" FEC_NAC="#' + 'FEC_NAC#" IMAGEN_ROSTRO_CAPTURADO="#foto2.jpg#" IMAGEN_WSQ_HUELLA_CAPTURADA="#huella2.wsq#" REVERSO_VISIBLE="#DOC_6.jpg#" REVERSO_ULTRAVIOLETA="#D' +
    'OC_8.jpg#" REVERSO_INFRAROJO="#DOC_7.jpg#" ANVERSO_INFRAROJO="#D' + 'OC_4.jpg#" ANVERSO_ULTRAVIOLETA="#DOC_5.jpg#" ANVERSO_VISIBLE="#' + 'DOC_3.jpg#" IMAGEN_ROSTRO_EDOCUMENTO="#DOC_1.jpg#" IMAGEN_ROSTRO_DOCUMENTO="#foto1.j' + 'pg#" ORDEN_HUELLA_CAPTURADA="0" OBSERVACIONES_ROSTRO_CAPTURADO="" OBSERVACIONES_HUELLA_CAP' + 'TURADA="" IMPEDIDO_PAIS_INGRESO="#POSEE_IMPEDIMENTO#" CALIDAD_HUELLA_CAPTURADA="#CALIDAD_HUELLA_CAPTURADA#" CHECKSUM="" FECHA_TRANSITO="#F' + 'ECHA_TRANSITO#"/></MANIFIESTO>';
end;

{ TManiThread }

constructor TManiDOCThread.Create(Manifiesto: Tmanifiesto);
begin
  inherited Create(True);
  // You practically always need to pass 'True' because 'False' is just meaningless...
  FManifiesto := Manifiesto;
  Resume; // Now that everything is created, we officially start the thread.

end;

destructor TManiDOCThread.Destroy;
begin
  FActive := False; // Make sure our process is stopped...
  WaitFor; // Wait for the process to stop before we continue freeing things...
  inherited;
end;

procedure TManiDOCThread.Execute;
begin
  Active := True;
  EnterCriticalSection(FManifiesto.CSMani);
  try
    FManifiesto.CompletarDatosPersonales;
  finally
    LeaveCriticalSection(FManifiesto.CSMani);
  end;
  Active := False;
end;

procedure Tmanifiesto.reemplazarEnTemplate(Busco, reemplazo: string);
begin
  XMLTemplate := StringReplace(XMLTemplate, Busco, reemplazo, []);
end;

procedure TManiDOCThread.SetActive(const Value: Boolean);
begin
  FActive := Value;
end;

{ TManiHuellaThread }

constructor TManiHuellaThread.Create(Manifiesto: Tmanifiesto);
begin
  inherited Create(True);
  // You practically always need to pass 'True' because 'False' is just meaningless...
  FManifiesto := Manifiesto;
  Resume; // Now that everything is created, we officially start the thread.
end;

destructor TManiHuellaThread.Destroy;
begin
  FActive := False; // Make sure our process is stopped...
  WaitFor; // Wait for the process to stop before we continue freeing things...
  inherited;
end;

procedure TManiHuellaThread.Execute;
begin
  Active := True;
  FManifiesto.CompletarHuella;
  Active := False;
end;

procedure TManiHuellaThread.SetActive(const Value: Boolean);
begin
  FActive := Value;
end;

{ TCrearManifiesto }

procedure TWSManifiesto.CargarCara;
begin
  try
    if Assigned(ManiRestriccionThread) then
      ManiRestriccionThread.WaitFor;
    if Assigned(ManiHuellaThread) then
      ManiHuellaThread.WaitFor;
  except
  end;
  actManifiesto.CompletarCara;
end;

procedure TWSManifiesto.CargarHuella;
begin
  actManifiesto.CalidadHuella := Self.CalidadHuella;
  ManiHuellaThread := TManiHuellaThread.Create(actManifiesto);
end;

procedure TWSManifiesto.CargarRestriccion;
begin
  actManifiesto.wsRRestriccion := Self.wsRRestriccion;
  actManifiesto.wsRTransporte := Self.wsRTransporte;
  actManifiesto.wsRTipoPasajero := Self.wsRTipoPasajero;
  ManiRestriccionThread := TManiRestriccionThread.Create(actManifiesto);
end;

procedure TWSManifiesto.CargarTransporte;
begin
  EnterCriticalSection(actManifiesto.CSMani);
  try
    actManifiesto.reemplazarEnTemplate('#MATRICULA_MEDIO_TRANSPORTE#', wsRTransporte);
  finally
    LeaveCriticalSection(actManifiesto.CSMani);
  end;
end;

constructor TWSManifiesto.Create(idLOC, TRANSACTIONID: AnsiString);
begin
  FechaCreacion := Now;
  Self.idLOC := idLOC;
  Self.TRANSACTIONID := TRANSACTIONID;
  actManifiesto := Tmanifiesto.Create;
  InitializeCriticalSection(actManifiesto.CSMani);
  actManifiesto.XMLTemplate := actManifiesto.GenerarXMLVacio;
  actManifiesto.idLOC := idLOC;
  actManifiesto.TRANSACTIONID := TRANSACTIONID;
  ManiDOCThread := TManiDOCThread.Create(actManifiesto);
end;

function TWSManifiesto.finalizarMani: AnsiString;
begin
  ManiDOCThread.WaitFor;
  ManiHuellaThread.WaitFor;
  ManiRestriccionThread.WaitFor;
  Result := StrToBase64(actManifiesto.XMLTemplate);
  DeleteCriticalSection(actManifiesto.CSMani);
end;

function TWSManifiesto.ManiSentido: string;
begin
  Result := actManifiesto.sentido;
end;

{ TManiRestriccionThread }

constructor TManiRestriccionThread.Create(Manifiesto: Tmanifiesto);
begin
  inherited Create(True);
  // You practically always need to pass 'True' because 'False' is just meaningless...
  FManifiesto := Manifiesto;
  Resume; // Now that everything is created, we officially start the thread.
end;

destructor TManiRestriccionThread.Destroy;
begin
  FActive := False; // Make sure our process is stopped...
  WaitFor; // Wait for the process to stop before we continue freeing things...
  inherited;
end;

procedure TManiRestriccionThread.Execute;
begin
  Active := True;
  EnterCriticalSection(FManifiesto.CSMani);
  try
    FManifiesto.CompletarRestriccion;
  finally
    LeaveCriticalSection(FManifiesto.CSMani);
  end;
  Active := False;
end;

procedure TManiRestriccionThread.SetActive(const Value: Boolean);
begin
  FActive := Value;
end;

initialization
  StrL := TIdThreadSafeStringList.Create;
//  GLOBAL_LOGICAINVERSA := LogicaInversa=1;

finalization
  StrL.Free;

end.

