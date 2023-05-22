{ Invokable implementation File for TEGateMgrWS which implements IEGateMgrWS }

unit EGateMgrWSImpl;

interface

uses
  Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, EGateMgrWSIntf;

type

  { TEGateMgrWS }
  TEGateMgrWS = class(TInvokableClass, IEGateMgrWS)
  public
    function test(const a: string): string; stdcall;
    function getBiometricData(const t: Transaction): BiometricData; stdcall;
    function doMatch(const Transaction: Transaction; const image: TByteDynArray): Integer; stdcall;
    function closeTransaction(const t: TransactionClosure): TransactionResult; stdcall;
    function initTransaction(const t: Transaction): TransactionResult; stdcall;
    function watchListSearch(const fa: FaceData): Boolean; stdcall;
    function initTransaction2(const t: Transaction): TransactionResult2; stdcall;
  end;

implementation

{ TEGateMgrWS }

uses
  System.Classes, uScannerICAO, EgateFunciones, SysUtils, DMBase, IWSTransitos1,
  uMANIFIESTO, Winapi.ActiveX, Winapi.Windows, uGlobal, IWSRemotoEGATE1,
  HiloWsRestriccionesLOCAL, IWS32RemotofingerMatch1, IWSArchAdminImpl1,
  DateUtils, HiloWsRestricciones;

type
  TWSFoto1fttThread = class(TThread)
  private
    FActive: Boolean;
    FlParamList: TStringList;
    procedure SetActive(const Value: Boolean);
  protected
    procedure Execute; override;
  public
    constructor Create(lParamList: TStringList);
    destructor Destroy; override;
    property Active: Boolean read FActive write SetActive;
  end;

  TWSHuella1WSQThread = class(TThread)
  private
    FActive: Boolean;
    FlParamList: TStringList;
    procedure SetActive(const Value: Boolean);
  protected
    procedure Execute; override;
  public
    constructor Create(lParamList: TStringList);
    destructor Destroy; override;
    property Active: Boolean read FActive write SetActive;
  end;

var
  CSXML: TRTLCriticalSection;

function TEGateMgrWS.getBiometricData(const t: Transaction): BiometricData;
var
  pd: PersonData2;
  fecha, fechaV: TDate;
  sfecha, sfechaV, sentido: string;
  DMBaseIB: TDMBaseIB;
  lParamList: TStringList;
  faseJpg, HuellaWSQ: AnsiString;
  wsRestriccionesLOCAL: TwsRestriccionesLocal;
  wsRestriccionesApache: TwsRestricciones;
  codE: string;
  strF: AnsiString;
  iniH, FinH: string;
  v, i, cantD: Integer;
begin
  lParamList := nil;
  iniH := 'getBiometricData ' + FormatDateTime('hh:mm:ss', Now);
  try
    try
      codE := '0';
      grabarEnArchivoTraza('getBiometricData', 'getBiometricData 1-' + t.transactionId);

      DMBaseIB := TDMBaseIB.Create(nil);
      try
        CoInitialize(nil);
        try
          codE := '1';
          Result := BiometricData.Create;

          with DMBaseIB do
          begin
            codE := '2';

            pd := DBPersonData(t.transactionId);

            if pd = nil then
            begin
              grabarEnArchivoLog('getBiometricData: pd ' + codE + '-' + t.transactionId + ' ' + IDLOC);
              Result.allowed := False;
              Result.transport := '';
              Exit;
            end;

            grabarEnArchivoTraza('getBiometricData', ' 3' + t.transactionId);

            codE := '3';
            fecha := YYMMDDtoDate(Trim(pd.dob));
            sfecha := FormatDateTime('YYYYMMDD', fecha);

            codE := '4';
            fechaV := YYMMDDtoDateSumo2000(Trim(PersonData2(pd).FECHA_EXPIRACION));
            sfechaV := FormatDateTime('YYYYMMDD', fechaV);
            codE := '5';

            if WSUsarResLocal then
            begin
              wsRestriccionesLOCAL := TwsRestriccionesLocal.Create(t.transactionId, pd.lastName, pd.firstName, sfecha, pd.docNumber, pd.passportNumber, pd.sex, pd.docType, pd.issuingCountry, pd.nationality, sfechaV);
            end
            else
            begin
              wsRestriccionesApache := TwsRestricciones.Create(t.transactionId, pd.lastName, pd.firstName, sfecha, pd.docNumber, pd.passportNumber, pd.sex, pd.docType, pd.issuingCountry, pd.nationality, sfechaV);
            end;

            codE := '6';
            try
              lParamList := TStringList.Create;
              lParamList.Add('IDLOC=' + IDLOC);
              lParamList.Add('transactionId=' + t.transactionId);
              lParamList.Add('docType=' + pd.docType);
              lParamList.Add('subDocType=' + pd.subDocType);
              lParamList.Add('issuingCountry=' + pd.issuingCountry);
              lParamList.Add('docNumber=' + pd.docNumber);
              lParamList.Add('passportNumber=' + pd.passportNumber);
              lParamList.Add('nationality=' + pd.nationality);
              lParamList.Add('sex=' + pd.sex);
              lParamList.Add('wsbiometricdevices=' + wsbiometricdevices);

              if GLOBAL_NROREMOTO = 0 then
                lParamList.Add('wsfingerMatch=' + wsfingerMatch)
              else
                lParamList.Add('wsfingerMatch=' + wsfingerMatch2);

              cantD := 0;
              for v := 1 to 3 do
              try
                var sl := TStringList.Create;
                try
                  sl.Text := StringReplace(GetIWSRemotoEGATE.biometricdevices(lParamList.Text), SEPADADORIMAGEN, #13#10, []);
                  cantD := sl.Count;

                  faseJpg := sl.Strings[0];
                  HuellaWSQ := '';
                  if sl.Count > 1 then
                    HuellaWSQ := sl.Strings[1];

                finally
                  sl.free;
                end;
                Break;
              except
                on e: Exception do
                begin
                  var Addr: string;

                  if GLOBAL_NROREMOTO = 0 then
                    Addr := wsbiometric
                  else
                    Addr := wsbiometric2;

                  grabarEnArchivoLog('getBiometricData REI ' + e.Message + ' ' + t.transactionId + '-CantD' + cantD.ToString + ' - ' + Addr);
                  if usoCambioAutoRemoto then
                  begin
                    if GLOBAL_NROREMOTO = 0 then
                      GLOBAL_NROREMOTO := 1
                    else
                      GLOBAL_NROREMOTO := 0;
                  end;

                  if v = 3 then
                  begin
                    Result.allowed := False;
                    Result.transport := '';
                    Exit;
                  end;

                  Sleep(100);
                end;
              end;

              codE := '7';

              if WSUsarResLocal then
              begin
                wsRestriccionesLOCAL.WaitFor;

                codE := '8';

                grabarEnArchivoTraza('getBiometricData', 'pd.VUELO:' + pd.VUELO);
                grabarEnArchivoTraza('getBiometricData', 'wsRestriccionesLOCAL.transport:' + wsRestriccionesLOCAL.transport);

                if Trim(pd.VUELO) <> '' then
                  wsRestriccionesLOCAL.transport := pd.VUELO;

                Result.transport := wsRestriccionesLOCAL.transport;

                grabarEnArchivoTraza('getBiometricData', 'wsRestriccionesLOCAL.transport:' + wsRestriccionesLOCAL.transport);

                if Result.transport.Trim = '' then
                  Result.allowed := False
                else
                  Result.allowed := wsRestriccionesLOCAL.allowed;

                codE := '9';
                CargarInfoRestricciones(t.transactionId, wsRestriccionesLOCAL.wsRRestriccion, wsRestriccionesLOCAL.wsRTransporte, wsRestriccionesLOCAL.wsRTipoPasajero);

              end
              else
              begin
                wsRestriccionesApache.WaitFor;

                codE := '8';

                grabarEnArchivoTraza('getBiometricData', 'pd.VUELO:' + pd.VUELO);
                grabarEnArchivoTraza('getBiometricData', 'wsRestriccionesApache.transport:' + wsRestriccionesApache.transport);

                if Trim(pd.VUELO) <> '' then
                  wsRestriccionesApache.transport := pd.VUELO;

                Result.transport := wsRestriccionesApache.transport;
                if Result.transport.Trim = '' then
                  Result.allowed := False
                else
                  Result.allowed := wsRestriccionesApache.allowed;

                grabarEnArchivoTraza('getBiometricData', 'wsRestriccionesApache.transport:' + wsRestriccionesApache.transport);

                codE := '9';
                CargarInfoRestricciones(t.transactionId, wsRestriccionesApache.wsRRestriccion, wsRestriccionesApache.wsRTransporte, wsRestriccionesApache.wsRTipoPasajero);
              end;

            finally
              if WSUsarResLocal then
              begin
                if Assigned(wsRestriccionesLOCAL) then
                  wsRestriccionesLOCAL.Free;
              end
              else
              begin
                if Assigned(wsRestriccionesApache) then
                  wsRestriccionesApache.Free;
              end;
            end;

//          grabarEnArchivoTraza('getBiometricData',t.transactionId+' - transport:'+Result.transport+' - allowed:'+wsRestricciones.wsRRestriccion+' - info:'+wsRestricciones.wsRInfoExtra+'-'+StringReplace(lParamList.Text,#13#10,'|',[rfReplaceAll])+'- -'+wsRestricciones.wsRestriccionEntradaSalida);
            grabarEnArchivoTraza('getBiometricData', t.transactionId + ' - transport:' + Result.transport + ' - ' + StringReplace(lParamList.Text, #13#10, '|', [rfReplaceAll]));
            if (Trim(faseJpg) <> '') then
            begin

              codE := '10';
              SysUtils.DeleteFile(DirTransac(IDLOC, t.transactionId) + 'foto1.jpg');
              SysUtils.DeleteFile(DirTransac(IDLOC, t.transactionId) + 'foto1.bmp');

              ConvertStrBase64ToFile(faseJpg, DirTransac(IDLOC, t.transactionId) + 'foto1.jpg');
              ConvertStrBase64ToFile(HuellaWSQ, DirTransac(IDLOC, t.transactionId) + 'huella1.wsq');

              codE := '11';
              try
                Jpeg2BmpOLD(DirTransac(IDLOC, t.transactionId) + 'foto1.jpg', DirTransac(IDLOC, t.transactionId) + 'foto1.bmp');
              except
              end;

              codE := '12';
              Result.fingerprintImage := nil;
              try
                Result.faceImage := FIleToByteArray(DirTransac(IDLOC, t.transactionId) + 'foto1.jpg');
              except
                codE := '12.5';
                strF := File2Str(DirTransac(IDLOC, t.transactionId) + 'foto1.jpg');
                Result.faceImage := strToByteArray(strF);
              end;
            //grabarEnArchivoTraza('getBiometricData','5-'+t.transactionId);
              codE := '13';
            //TWSFoto1fttThread.Create(lParamList);
              TWSHuella1WSQThread.Create(lParamList);
            end
            else if Assigned(lParamList) then
            begin
              FreeAndNil(lParamList);
            end;
          end;
        finally
          try
          //codE := '14';
            CoUninitialize;
          except
            on e: Exception do
            begin
              grabarEnArchivoLog('getBiometricData: CoUninitialize ' + codE + '-' + t.transactionId + ' ' + e.Message);
            end;
          end;
        end;
      finally
        try
       // codE := '15';
          DMBaseIB.Free;
        except
          on e: Exception do
          begin
            grabarEnArchivoLog('getBiometricData: DMBaseIB.Free ' + codE + '-' + t.transactionId + ' ' + e.Message);
          end;
        end;
      end;
    //grabarEnArchivoTraza('getBiometricData','10-FIN'+t.transactionId);
    except
      on e: Exception do
      begin
        grabarEnArchivoLog('getBiometricData:' + codE + '-' + t.transactionId + ' ' + e.Message);
      end;
    end;
  finally
    FinH := iniH + ' ' + FormatDateTime('hh:mm:ss', Now);
    //grabarEnArchivoDUR(FinH);
  end;
end;

function TEGateMgrWS.doMatch(const Transaction: Transaction; const image: TByteDynArray): Integer;
var
  lParamList: TStringList;
  R, v: Integer;
  DMBaseIB: TDMBaseIB;
  dir, sentido: string;
  iniH, FinH: string;
begin
  iniH := 'doMatch ' + FormatDateTime('hh:mm:ss', Now);


//  if GLOBAL_LOGICAINVERSA then
//    CargarHuellaEnManifiesto(Transaction.transactionId);
  Result := -1;
  try
    DMBaseIB := TDMBaseIB.Create(nil);
    try
      dir := DirTransac(IDLOC, Transaction.transactionId);

      ByteArrayToFIle(image, dir + 'huella2.wsq');

      if TamArchivo(dir + 'huella2.wsq') < 50 then
      begin
        Exit;
      end;

      CoInitialize(nil);
      try

        for v := 1 to 3 do
        try

          lParamList := TStringList.Create;

          try
            lParamList.Add('IDLOC=' + IDLOC);
            lParamList.Add('transactionId=' + Transaction.transactionId);

            R := GetIWS32RemotofingerMatch.fingerMatch(lParamList.Text, image);

            grabarEnArchivoLog('End doMatch');
            Break;
          finally
            lParamList.Free;
          end;
        except
          on e: Exception do
          begin
            var Addr: string;
            if GLOBAL_NROREMOTO = 0 then
              Addr := wsfingerMatch
            else
              Addr := wsfingerMatch2;
            try
              GetIWSRemotoEGATE.reinicioWS32RemotofingerMatch;
            except
              on e1: exception do
              begin
                grabarEnArchivoLog('doMatch: reinicioWS32RemotofingerMatch' + e1.Message);
              end;
            end;

            grabarEnArchivoLog('doMatch: 1' + e.Message + '-' + Addr);
            R := -1;
            if usoCambioAutoRemoto then
            begin
              if GLOBAL_NROREMOTO = 0 then
                GLOBAL_NROREMOTO := 1
              else
                GLOBAL_NROREMOTO := 0;
            end;
            sleep(300);
          end;
        end;
      finally
        try
          CoUninitialize;
        except
        end;
      end;

      if R >= 68 then
        Result := 0
      else if (R <= 67) and (R >= 20) then
        Result := 1
      else if R = -1 then
        Result := -2
      else
        Result := -1;

      // Result := 0;
      CargarCalidadHuella(Transaction.transactionId, R);

      DMBaseIB.BDDACTILAR_SCORE(Transaction.transactionId, R);
    except
      on e: Exception do
      begin

        grabarEnArchivoLog('doMatch: 2' + e.Message);
        DMBaseIB.BDInstResult(Transaction.transactionId, -8, 0, 'ERR');
        Result := -1;
      end;
    end;
  finally
    FinH := iniH + ' ' + FormatDateTime('hh:mm:ss', Now);
    //grabarEnArchivoDUR(FinH);
    DMBaseIB.Free;
  end;
end;

function TEGateMgrWS.initTransaction(const t: Transaction): TransactionResult;
var
  lsICAO: TStringList;
  L1, L2, L3, dir: AnsiString;
  ICAO: TscannerICAO;
  pd: PersonData;
  I, idgate_log: Integer;
  DI: DocumentImage;
  P2: PersonData2;
  Usuario, sentido, IP, auxDoc: string;
  DMBaseIB: TDMBaseIB;
  hayImagenes: Boolean;
  iniH, FinH: string;
begin
  for var v := 0 to 10 do
  begin
    if liberoManifiesto = '' then
      Break;
  end;

  iniH := 'initTransaction-' + FormatDateTime('hh:mm:ss', Now);
  DMBaseIB := TDMBaseIB.Create(nil);
  try
    Result := TransactionResult.Create;
    try

      if not DMBaseIB.DBUsuarios(t.egateId, Usuario, idgate_log) then
      begin
        Result.transactionResultCode := -5;
        Result.transactionId := t.transactionId;
        DMBaseIB.BDInstResult(t.transactionId, -5, 0, 'ERR');
        grabarEnArchivoLog('initTransaction: -5 ' + t.egateId + ' - ' + Usuario + ' - ' + idgate_log.ToString);
        IP := DMBaseIB.DBEgateIP(t.egateId);
        if IP <> '' then
          PostEgate(IP, 'userNotLogged');

        Exit;
      end;

      if WSHabilitoPORSicam then
      begin
        if not GLOBAL_HABILITO_SICAM_PUERTAS then
        begin
          Result.transactionResultCode := -123;
          Result.transactionId := t.transactionId;
          grabarEnArchivoLog('GLOBAL_HABILITO_SICAM_PUERTAS: ' + t.transactionId + ' - ' + t.egateId + ' - ');
          DMBaseIB.BDInstResult(t.transactionId, -123, 0, 'NOSIC');
          Exit;
        end;
      end;

      sentido := DMBaseIB.DBSentido(t.egateId);
      if sentido = '' then
      begin
        Result.transactionResultCode := -6;
        Result.transactionId := t.transactionId;
        DMBaseIB.BDInstResult(t.transactionId, -6, 0, 'ERR');
        Exit;
      end;

//End debug
      Result.transactionResultCode := -1;
      Result.transactionId := t.transactionId;
      L1 := '';
      L2 := '';
      L3 := '';

      ICAO := TscannerICAO.Create;
      try
        lsICAO := TStringList.Create;
        try
          lsICAO.Text := t.MRZ;

          if lsICAO.Count < 2 then
          begin
            Result.transactionResultCode := -14;
            Result.transactionId := t.transactionId;
            grabarEnArchivoLog('initTransaction MRZ: ' + t.transactionId + ' - ' + t.egateId + ' - ' + t.MRZ);
            DMBaseIB.BDInstResult(t.transactionId, -14, 0, 'ERR');
            Exit;
          end;

          // DEGUB
          // L1 := 'IDARG21431989<7<<<<<<<<<<<<<<<';
          // L2 := '7004166M2812106ARG<<<<<<<<<<<6';
          // L3 := 'MARABINI<<FRANCISCO<JOSE<<<<<<';

          L1 := lsICAO.Strings[0] + ansichar(0);
          L2 := lsICAO.Strings[1] + ansichar(0);
          if lsICAO.Count = 3 then
            L3 := lsICAO.Strings[2] + ansichar(0);

          ICAO.linesAticao(L1, 0);
          ICAO.linesAticao(L2, 1);
          ICAO.nlines := 2;
          if lsICAO.Count = 3 then
          begin
            ICAO.nlines := 3;
            ICAO.linesAticao(L3, 2);
          end;

          ICAO.ExtractMRZ;
        finally
          lsICAO.Free;
        end;

        P2 := PersonData2.Create;
        pd := ICAO.ToPersonData;
        P2.FECHA_EXPIRACION := ICAO.dateOfExpiry;
        Result.PersonData := pd;

        dir := DirTransac(IDLOC, t.transactionId);
        hayImagenes := False;
        for I := Low(t.DocumentImages) to High(t.DocumentImages) do
        begin
          hayImagenes := True;
          DI := t.DocumentImages[I];
          ByteArrayToFIle(DI.image, dir + 'DOC_' + IntToStr(DI.documentImageType) + '.jpg');
        end;

        if not hayImagenes then
        begin
          Result.transactionResultCode := -10;
          Result.transactionId := t.transactionId;
          DMBaseIB.BDInstResult(t.transactionId, -22, 0, 'ERR');
          grabarEnArchivoLog('initTransaction:' + t.egateId + ' _ ' + t.transactionId + ' - ' + t.MRZ);
          Exit;
        end;

        P2.firstName := pd.firstName;
        P2.lastName := pd.lastName;
        P2.dob := pd.dob;
        P2.docNumber := pd.docNumber;
        P2.passportNumber := pd.passportNumber;
        P2.docType := pd.docType;
        P2.subDocType := pd.subDocType;
        P2.issuingCountry := pd.issuingCountry;
        P2.nationality := pd.nationality;
        P2.sex := pd.sex;

        if P2.docType = 'P' then
        begin
          auxDoc := P2.docNumber;
          P2.docNumber := P2.passportNumber;
          P2.passportNumber := auxDoc;
        end;

        DMBaseIB.DBInstPersona(t.transactionId, P2, t.MRZ);

        Result.transactionStatus := 'CREATED';
        Result.transactionResultCode := 0;

        DMBaseIB.BDInstTrans(t.transactionId, t.egateId, sentido, idgate_log);
        DMBaseIB.BDInstResult(t.transactionId, 0, 0, 'CRE');

        CrearManifiesto(t.transactionId);

      finally
        //pd := nil;
        ICAO.Free;
        P2.Free;
      end;
    except
      on e: Exception do
      begin
        grabarEnArchivoLog('initTransaction:' + e.Message + ' - ' + t.transactionId + ' - ' + t.egateId + ' - ' + t.MRZ);
        Result.transactionStatus := 'ERROR';
        Result.transactionResultCode := -1;
        DMBaseIB.BDInstResult(t.transactionId, -1, 0, 'ERR');
      end;
    end;
  finally
    FinH := iniH + ' ' + FormatDateTime('hh:mm:ss', Now);
    //grabarEnArchivoDUR(FinH);
    DMBaseIB.Free;
  end;

end;

function TEGateMgrWS.initTransaction2(const t: Transaction): TransactionResult2;
var
  R: TransactionResult;
begin
  try
    R := initTransaction(t);
    try
      Result := TransactionResult2.Create;
      Result.transactionId := R.transactionId;
      Result.transactionResultCode := R.transactionResultCode;
      Result.transactionStatus := R.transactionStatus;
    finally
      R.Free;
    end;
  except
  end;
end;






function TEGateMgrWS.watchListSearch(const fa: FaceData): Boolean;
var
  dir: string;
  score: Integer;
begin
  Result := False;
  Exit;
end;



function TEGateMgrWS.closeTransaction(const t: TransactionClosure): TransactionResult;
var
  tf: ttransitoFile;
  DMBaseIB: TDMBaseIB;
  sentido, Usuario: string;
  XML: AnsiString;
  e: Event;
  codE, dir: string;
  res: Boolean;
  wstransitosarchivoEntradaSalida: string;
  iniH, FinH: string;
  nombreMani: string;
begin

  iniH := 'closeTransaction ' + FormatDateTime('hh:mm:ss', Now);
  codE := '1';
  Result := TransactionResult.Create;
  CoInitialize(nil);
  try
    codE := '2';
    //if not GLOBAL_LOGICAINVERSA then
    CargarHuellaEnManifiesto(t.transactionId);
    try
      codE := '3';
      DMBaseIB := TDMBaseIB.Create(nil);
      try
        DMBaseIB.DBTRANSACTION_CLOSURE(t.transactionId, t.manualDoorOpened, t.localElegibilityFailed);

        codE := '4';
        try
          for e in t.eventLog do
          begin
            DMBaseIB.DBINSEVENTO(t.transactionId, e.eventType, e.date.AsDateTime, e.eventDesc);
          end;
        except
        end;

        codE := '5';

        sentido := ManifiestoSentido(t.transactionId);

        if sentido = 'E' then
          wstransitosarchivoEntradaSalida := wstransitosarchivoEntrada
        else
          wstransitosarchivoEntradaSalida := wstransitosarchivoSalida;

        codE := '5.5';

        XML := finalizarManifiesto(t.transactionId);
        nombreMani := '';

        codE := '6';

        var strfechahora: string;
        if XML <> '' then
        begin
          var fecha: TDateTime;
          tf := ttransitoFile.Create;
          try
            tf.organismo := 'DNM';
            tf.archivo := XML;

            fecha := now;
            tf.fecha := FormatDateTime('DD/MM/YYYY hh:mm:ss', fecha);
            res := GetIWSTransitos2(wstransitosarchivoEntradaSalida).Enviar_Transitos_SICaM(tf);

            if not res then
              raise Exception.Create('Error en Enviar_Transitos_SICaM');

          finally
            tf.Free;
          end;
          codE := '7';
          Result.transactionId := t.transactionId;
          Result.transactionStatus := 'FINISH';
          Result.transactionResultCode := 0;
          DMBaseIB.BDInstResult(Result.transactionId, 1, 0, 'FIN');
          DMBaseIB.DBInstManifiesto(Result.transactionId, nombreMani);
          try
            dir := directorioArchivosEgate + normalizoDir(IDLOC) + normalizoDir('MANI_' + FormatDateTime('YYYYMMDD', Now));
            ForceDirectories(dir);
            grabarArchivo(dir + t.transactionId, XML);
          except
          end;

        end
        else
        begin
          DMBaseIB.BDInstResult(t.transactionId, -11, 0, 'ERR');
          Result.transactionStatus := 'ERROR';
          Result.transactionResultCode := -1;
        end;

        codE := '8';

      finally
        DMBaseIB.Free;
      end;
    except
      on e: Exception do
      begin
        grabarEnArchivoLog('closeTransaction:' + codE + ' ' + t.transactionId + ' ' + e.Message);
        DMBaseIB.BDInstResult(t.transactionId, -10, 0, 'ERR');
        Result.transactionStatus := 'ERROR';
        Result.transactionResultCode := -1;
      end;
    end;
  finally
    FinH := iniH + ' ' + FormatDateTime('hh:mm:ss', Now);
    //grabarEnArchivoDUR(FinH);
    try
      CoUninitialize;
    except
    end;
  end;

end;

{ TWSFoto1fttThread }

constructor TWSFoto1fttThread.Create(lParamList: TStringList);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  // You practically always need to pass 'True' because 'False' is just meaningless...
  FlParamList := TStringList.Create;
  FlParamList.Text := lParamList.Text;
  Resume; // Now that everything is created, we officially start the thread.

end;

destructor TWSFoto1fttThread.Destroy;
begin
  FlParamList.Free;
  FActive := False; // Make sure our process is stopped...
  WaitFor; // Wait for the process to stop before we continue freeing things...
  //try
  //  if Assigned(FlParamList) then FlParamList.Free;
  //except
  //end;
  inherited;
end;

procedure TWSFoto1fttThread.Execute;
begin
  Active := True;
  CoInitializeEx(0, COINIT_MULTITHREADED);
  try
    try
      GetIWSRemotoEGATE.foto1fft(FlParamList.Text);
    except
      on e: Exception do
      begin
        grabarEnArchivoLog('TWSFoto1fttThread:' + e.Message);
      end;
    end;
  finally
    try
      CoUninitialize();
    except
    end;
  end;
  Active := False;
end;

procedure TWSFoto1fttThread.SetActive(const Value: Boolean);
begin
  FActive := Value;
end;

{ TWSHuella1WSQThread }

constructor TWSHuella1WSQThread.Create(lParamList: TStringList);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  // You practically always need to pass 'True' because 'False' is just meaningless...
  FlParamList := TStringList.Create;
  FlParamList.Text := lParamList.Text;
  Resume; // Now that everything is created, we officially start the thread.
end;

destructor TWSHuella1WSQThread.Destroy;
begin
  FlParamList.Free;
  FActive := False; // Make sure our process is stopped...
  WaitFor; // Wait for the process to stop before we continue freeing things...

  inherited;
end;

procedure TWSHuella1WSQThread.Execute;
var
  v: Integer;
begin
  Active := True;
  CoInitializeEx(0, COINIT_MULTITHREADED);
  try
    for v := 1 to 3 do
    begin
      try
        GetIWS32RemotofingerMatch.formateoSoloHuella1WSQ(FlParamList.Text);
        Break;
      except
        on e: Exception do
        begin
          var Addr: string;
          if GLOBAL_NROREMOTO = 0 then
            Addr := wsfingerMatch
          else
            Addr := wsfingerMatch2;
          try
            GetIWSRemotoEGATE.reinicioWS32RemotofingerMatch;
          except
            on e1: exception do
            begin
              grabarEnArchivoLog('doMatch: reinicioWS32RemotofingerMatch' + e1.Message);
            end;
          end;

          grabarEnArchivoLog('formateoSoloHuella1WSQ: 1' + e.Message + '-' + Addr);
          if usoCambioAutoRemoto then
          begin
            if GLOBAL_NROREMOTO = 0 then
              GLOBAL_NROREMOTO := 1
            else
              GLOBAL_NROREMOTO := 0;
          end;
          sleep(300);
        end;
      end;
    end;
  finally
    try
      CoUninitialize();
    except
    end;
  end;
  Active := False;
end;

procedure TWSHuella1WSQThread.SetActive(const Value: Boolean);
begin
  FActive := Value;
end;

function TEGateMgrWS.test(const a: string): string;
begin
  try
    var c: string;

    Result := 'OK';

  except
    on e: Exception do
      Result := 'ERROR:' + e.Message;
  end;

end;

initialization

{ Invokable classes must be registered }
  InvRegistry.RegisterInvokableClass(TEGateMgrWS);
  InitializeCriticalSection(CSXML);


finalization
  DeleteCriticalSection(CSXML);

end.

