{ Invokable implementation File for TwsLLamadorAA2000B which implements IwsLLamadorAA2000B }

unit wsLLamadorAA2000BImpl;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, wsLLamadorAA2000BIntf,
     manager,System.SysUtils,System.DateUtils,System.Classes,System.IniFiles;

type

  { TwsLLamadorAA2000B }
  TwsLLamadorAA2000B = class(TInvokableClass, IwsLLamadorAA2000B)
  public
    function Call(Data:TData): TTurno; stdcall;
    function ReCall(Turno:TTurno): TRespuesta; stdcall;
    function Finish(Turno:TTurno): TRespuesta; stdcall;
    function QueuesList(): TArrayColas; stdcall;
  end;

implementation

procedure msgLOG(msg: String);
var
  archivo: TStringList;
  arch: String;
begin
  try
    archivo := TStringList.Create;
    try
      arch := ExtractFilePath(ParamStr(0)) + 'LOG_wsLlamadorAA200.log';

      if FileExists(arch) then
      begin
        archivo.LoadFromFile(arch);

      end;

      archivo.Add(FormatDateTime('dd-mm-yyyy hh:nn:ss', System.SysUtils.Now) +
        ' - ' + msg);
      archivo.SaveToFile(arch);
    finally
      archivo.Free;
    end;
  except
  end;
end;

function ValidarEntrada(COLA,BOX,LETRA:string):string;
var Cadena:string;
begin
     cadena:='';
     if cola = EmptyStr then
      cadena:= '- ID_COLA: Sin datos ';

     if BOX = EmptyStr then
      cadena:= cadena + '- BOX: Sin datos ';

     if LETRA = EmptyStr then
      cadena:= cadena + '- LETRA: Sin datos ';

  result:=Cadena;
end;

function ValidarTurno(Turno:TTurno;Metodo:integer):string;
var Cadena:string;
begin
   cadena:='';
   case Metodo of
      0:begin //RECALL QueuesShifts
         if Turno.ID_COLA = EmptyStr then
           cadena:= '- ID_COLA: Sin datos ';

         if turno.ID_TURNO = EmptyStr then
          cadena:= cadena + '- TURNO: Sin datos ';

         if turno.LETRA = EmptyStr then
          cadena:= cadena + '- LETRA: Sin datos ';

         if turno.ORDEN = EmptyStr then
          cadena:= cadena + '- ORDEN: Sin datos ';

         if Turno.BOX = EmptyStr then
           cadena:= '- BOX: Sin datos ';

         if turno.XDIA_COLA = EmptyStr then
          cadena:= cadena + '- DIA_COLA: Sin datos ';

         if turno.XINI_COLA = EmptyStr then
          cadena:= cadena + '- HORA_CREACION_COLA: Sin datos ';

         if turno.XSTAR_COLA = EmptyStr then
          cadena:= cadena + '- HORA_INICIO_COLA: Sin datos ';

        end;
      1:begin //FINISH QueuesShifts
         if Turno.ID_COLA = EmptyStr then
           cadena:= '- ID_COLA: Sin datos ';

         if turno.ID_TURNO = EmptyStr then
          cadena:= cadena + '- TURNO: Sin datos ';

         if turno.LETRA = EmptyStr then
          cadena:= cadena + '- LETRA: Sin datos ';

         if turno.ORDEN = EmptyStr then
          cadena:= cadena + '- ORDEN: Sin datos ';
        end;
    end;

  result:=Cadena;
end;

function GetURL():string;
var ini:TIniFile;
    mURL:string;
begin
    ini := TIniFile.Create('.\config.ini');
    try
     mURL := ini.ReadString('CONFIG', 'URL', 'N');
    finally
      ini.Free;
    end;
    Result:=mURL;
end;

function TwsLLamadorAA2000B.Call(Data:TData): TTurno; stdcall;
var mTurno:TTurno;
    mManager:ManagerSoap;
    shift:QueuesShifts;
    actualqueque:QueuesShifts;
    Day, Month, Year : Word;
    valid:string;

begin
  { TODO : Implement method echoEnum }
  valid:=ValidarEntrada(data.ID_COLA,data.BOX,data.LETRA);

  if valid = EmptyStr then
  begin

    mManager:=GetManagerSoap(False,GetURL);
    actualqueque:= manager.QueuesShifts.Create;
    shift:=manager.QueuesShifts.Create;

    shift.idQueue        :=Data.ID_COLA;
    shift.reason         :=UpperCase(Data.BOX);
    shift.letter         :=UpperCase(Data.LETRA);
    DecodeDate(System.SysUtils.Now,Year,Month,Day);

    shift.queueDate      := DateTimeToXSDateTime(EncodeDate(Year, Month, Day));
    shift.queueTime      := system.DateUtils.MilliSecondOfTheDay(system.SysUtils.Now);//queueTime;
    shift.queueStartTime := system.DateUtils.MilliSecondOfTheDay(system.SysUtils.Now);

    try
      actualqueque:=mManager.UpdateQueueShift(shift);

      mTurno:=TTurno.Create;
      mturno.ERROR:='OK';
      mturno.DESCRIPCION:='';
      mturno.ID_COLA:=actualqueque.idQueue;
      mturno.ID_TURNO:=actualqueque.idQueueShift;
      mturno.BOX:= actualqueque.reason;
      mturno.LETRA:=actualqueque.letter;
      mturno.ORDEN:= actualqueque.idNumber.ToString;
      mturno.XDIA_COLA:=actualqueque.queueDate.NativeToXS;
      mturno.XINI_COLA:=FloatToStr(shift.queueTime);
      mturno.XSTAR_COLA:=FloatToStr(shift.queueStartTime);
      mturno.CANT_RELLAMAR:=IntToStr(actualqueque.queueCalls);

      msgLOG('LLAMADOR: ' + Data.ID_COLA + ' BOX: ' + data.BOX + ' NRO: ' + actualqueque.idNumber.ToString);


    except on E: Exception do
    begin
      mTurno:=TTurno.Create;
      mturno.ERROR:='ERROR';
      mturno.DESCRIPCION:=e.Message;
      mturno.ID_COLA:='';
      mturno.ID_TURNO:='';
      mturno.BOX:= '';
      mturno.LETRA:='';
      mturno.ORDEN:= '';
      mturno.XDIA_COLA:='';
      mturno.XINI_COLA:='';
      mturno.XSTAR_COLA:='';
      mturno.CANT_RELLAMAR:='';
      msgLOG(e.Message);
    end;
    end;

  end
  else
  begin
    mTurno:=TTurno.Create;
    mturno.ERROR:='ERROR';
    mturno.DESCRIPCION:=valid;
    mturno.ID_COLA:='';
    mturno.ID_TURNO:='';
    mturno.BOX:= '';
    mturno.LETRA:='';
    mturno.ORDEN:= '';
    mturno.XDIA_COLA:='';
    mturno.XINI_COLA:='';
    mturno.XSTAR_COLA:='';
    mturno.CANT_RELLAMAR:='';
    msgLOG(valid);
  end;


  Result := mturno;
end;

function TwsLLamadorAA2000B.Finish(Turno:TTurno): TRespuesta; stdcall;
var Rspta:TRespuesta;
    mManager:ManagerSoap;
    actualqueque:QueuesShifts;
    XSDateTime: TXSDateTime;
    mDay, mMonth,mYear,part1,part2,Xstr : string;
    cola:Queues;
    valid:string;
begin

  mManager:=GetManagerSoap(false,GetURL);
  actualqueque:= manager.QueuesShifts.Create;

    try
      Rspta:=TRespuesta.Create;
      valid:=ValidarTurno(Turno,1);

      if valid = EmptyStr then
      begin
         actualqueque.idQueue:=Turno.ID_COLA;
         actualqueque.idQueueShift:=Turno.ID_TURNO;
         actualqueque.queueEndTime:=system.DateUtils.MilliSecondOfTheDay(system.SysUtils.Now);
         actualqueque.letter:=Turno.LETRA;
         actualqueque.idNumber:=StrToInt(turno.ORDEN);
         actualqueque.queueTime:=0;
         actualqueque.queueStartTime:=0;
         actualqueque.sentMail:=False;
         actualqueque.queueCalls:=0;
         //actualqueque.queueDate.XSToNative(turno.XDIA_COLA);

         Xstr:=turno.XDIA_COLA;
         part1:=Xstr.Split(['T'])[0];
         part2:=Xstr.Split(['T'])[0];

         mYear := part1.Split(['-'])[0];
         mMonth:= part1.Split(['-'])[1];
         mDay  := part1.Split(['-'])[2];

         actualqueque.queueDate:=DateTimeToXSDateTime(EncodeDate(StrToInt(mYear),StrToInt(mMonth),StrToInt(mDay)));

         mManager.UpdateQueueShift(actualqueque);
         rspta.ERROR:='OK';
         rspta.DESCRIPCION:='';
         msgLOG('EndShift: ' + Turno.ID_TURNO );

      end
      else
      begin
         rspta.ERROR:='ERROR';
         Rspta.DESCRIPCION:=valid;
         msgLOG(valid);
      end;

    except on E: Exception do
      begin
          rspta.ERROR:='ERROR';
          Rspta.DESCRIPCION:=E.Message;
          msgLOG(e.Message);
      end;
    end;

  result:=Rspta;
end;

function TwsLLamadorAA2000B.QueuesList(): TArrayColas; stdcall;
var mManager:ManagerSoap;
    cola:Queues;
    v:TArrayColas;
    i:Integer;
    mCola:TCOLAS;
begin
    mManager:=GetManagerSoap(false,GetURL);
    i:=0;
    try
       for cola in mManager.GetQueues do
       begin
         mcola:=TCOLAS.Create;
         mcola.ID_COLA:=cola.idQueue;
         mcola.NOMBRE:=cola.name_;
         mcola.LUGAR:=cola.place;
         mcola.LETRA:=cola.letter;

         //msgLOG(cola.name_);
         SetLength(v,i+1);
         v[i]:=mCola;
         i:=i+1;
       end;
    except on E: Exception do
      begin
        msgLOG(e.Message);
        mcola:=mCola.Create;
        SetLength(v,1);
        v[0]:=mCola;
      end;
    end;
    result:=v;
end;

function TwsLLamadorAA2000B.ReCall(Turno:TTurno): TRespuesta; stdcall;
var mTurno:TTurno;
    mManager:ManagerSoap;
    shift:QueuesShifts;
    actualqueque:QueuesShifts;
    r:TRespuesta;
    mDay, mMonth,mYear,part1,part2,Xstr : string;
    mStarTime,mIni:Double;
    valid:string;
begin
    mManager:=GetManagerSoap(false,GetURL);
    actualqueque:= manager.QueuesShifts.Create;

    valid:=ValidarTurno(Turno,0);
    if valid = EmptyStr then
    begin
      try
         r:=TRespuesta.Create;
         actualqueque.idQueue:=Turno.ID_COLA;
         actualqueque.idQueueShift:=Turno.ID_TURNO;
         actualqueque.queueEndTime:=0;
         actualqueque.letter:=UpperCase(Turno.LETRA);
         actualqueque.idNumber:=StrToInt(turno.ORDEN);
         actualqueque.reason:=uppercase(turno.BOX);

         actualqueque.queueTime:=double.Parse(turno.XINI_COLA);
         actualqueque.queueStartTime:=double.Parse(turno.XSTAR_COLA);
         actualqueque.sentMail:=False;
         actualqueque.queueCalls:=StrToInt(Turno.CANT_RELLAMAR);
         //actualqueque.queueDate.XSToNative(turno.XDIA_COLA);


         Xstr:=turno.XDIA_COLA;
         part1:=Xstr.Split(['T'])[0];
         part2:=Xstr.Split(['T'])[0];

         mYear := part1.Split(['-'])[0];
         mMonth:= part1.Split(['-'])[1];
         mDay  := part1.Split(['-'])[2];


         actualqueque.queueDate:=DateTimeToXSDateTime(EncodeDate(StrToInt(mYear),StrToInt(mMonth),StrToInt(mDay)));

         mManager.UpdateQueueShift(actualqueque);
         r.ERROR:='OK';
         r.DESCRIPCION:='';
         msgLOG('ReCall: {' + Turno.ID_TURNO + '} CANT_Rellamadas: ' +  Turno.CANT_RELLAMAR );


      except on E: Exception do
        begin
          msgLOG(e.Message);
          r.ERROR:='ERROR';
          r.DESCRIPCION:=e.Message;
        end;
      end;
    end
    else
    begin
     r.ERROR:='ERROR';
     r.DESCRIPCION:=valid;
     msgLOG(valid);
    end;

    result:=r;
end;

initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(TwsLLamadorAA2000B);
end.

