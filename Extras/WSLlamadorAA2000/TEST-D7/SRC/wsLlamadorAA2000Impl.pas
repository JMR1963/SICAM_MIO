{ Invokable implementation File for TwsLlamadorAA2000 which implements IwsLlamadorAA2000 }

unit wsLlamadorAA2000Impl;

interface

uses InvokeRegistry, Types, XSBuiltIns, wsLlamadorAA2000Intf,SysUtils,Classes,manager,
     DateUtil;

type

  { TwsLlamadorAA2000 }
  TwsLlamadorAA2000 = class(TInvokableClass, IwsLlamadorAA2000)
  public
    function Call(Data:TData): TTurnInfo; stdcall;
  end;

implementation

uses DateUtils;

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

      archivo.Add(FormatDateTime('dd-mm-yyyy hh:nn:ss', SysUtils.Now) +
        ' - ' + msg);
      archivo.SaveToFile(arch);
    finally
      archivo.Free;
    end;
  except
  end;
end;

function TwsLlamadorAA2000.Call(Data:TData): TTurnInfo; stdcall;
var ws:ManagerSoap;
    shift:QueuesShifts;
    actualqueque:QueuesShifts;
    queueDate:TXSDateTime;
    queueTime:Double;
    Day, Month, Year : Word;
    Turn:TTurnInfo;
begin
  { TODO : Implement method echoEnum }

  Turn:=TTurnInfo.Create;

   try
    actualqueque:= manager.QueuesShifts.Create;
    ws:=manager.GetManagerSoap(false);
    msgLOG('GetManagerSoap');

    DecodeDate(SysUtils.Now,Year,Month,Day);
    msgLOG('DecodeDate');
    queueDate:= DateTimeToXSDateTime(EncodeDate(Year, Month, Day));
    msgLOG('DateTimeToXSDateTime');
    //MilliSecondsBetween(Now,0);
    //queueTime:=System.DateUtils.MilliSecondSpan(System.SysUtils.Now,0);
    queueTime:= MilliSecondOfTheDay(SysUtils.Now);
    msgLOG('MilliSecondSpan');

    shift:=manager.QueuesShifts.Create;
    msgLOG('QueuesShifts.Create - COLA: ' + 'Data.COLA');
    shift.idQueue        :=Data.ID_Queue;
    shift.reason         :=Data.BOX;
    shift.letter         :=Data.letter;
    shift.queueDate      :=queueDate; //Format TXSDateTime
    shift.queueTime      := 02021137555;//queueTime;
    shift.queueStartTime := 02021137555;//queueTime;

    actualqueque:= ws.UpdateQueueShift(shift);
    msgLOG('ws.UpdateQueueShift');
    msgLOG(actualqueque.idQueueShift + '-' + actualqueque.reason + '-' + actualqueque.letter + '-' + IntToStr(actualqueque.idNumber));

    turn.ERROR        :='OK';
    turn.DESCRIPTION  :='';
    Turn.idQueue      :=actualqueque.idQueue;
    Turn.idQueueShift :=actualqueque.idQueueShift;
    Turn.idParentQueue:=actualqueque.idParentQueue;
    Turn.letter       :=actualqueque.letter;
    Turn.reason       :=actualqueque.reason;
    Turn.order        :=inttostr(actualqueque.idNumber);
    turn.idPlayer     :=actualqueque.idPlayer;

  except on E: Exception do
    begin
       Turn.ERROR:= 'ERROR';
       Turn.DESCRIPTION:=E.Message;
       msgLOG(e.Message);
    end;
  end;

  Result := Turn;
end;

initialization
  { Invokable classes must be registered }
  InvRegistry.RegisterInvokableClass(TwsLlamadorAA2000);

end.
 