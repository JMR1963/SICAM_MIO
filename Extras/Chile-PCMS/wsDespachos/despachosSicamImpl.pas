{ Invokable implementation File for TdespachosSicam which implements IdespachosSicam }

unit despachosSicamImpl;

interface

uses Soap.InvokeRegistry, system.Types, Soap.XSBuiltIns, despachosSicamIntf, System.Dateutils, System.IniFiles;

type

  { TdespachosSicam }
  TdespachosSicam = class(TInvokableClass, IdespachosSicam)
  private

  public
    function despachosSicam(FECHA:TFECHA):TRESULTADO; stdcall;

    function despachosChile(DESPCHL:TDESPCHILES):TRESULTADO; stdcall;

    function ARGFaltantesEnMONTEAYMOND(DESPCHILES:TDESPCHILES):TRESULTADO; stdcall;

    function CHLFaltantesEnPIA(FECHA:TFECHA):TRESULTADO; stdcall;

    function DESPACHOSxmlToLs(aXML:TXML):TRESULTADO;stdcall;
    function FALTANTESxmlToLs(aXML:TXML):TRESULTADO;stdcall;
    function DifLsALsB(LS:TLS):TRESULTADO;stdcall;
    function valorNodoXML(aXML,aNodo:String):String;

  end;

implementation

{ TdespachosSicam }

uses uDMDespachos,system.SysUtils, System.StrUtils, Ipuentechileno1;

function TdespachosSicam.valorNodoXML(aXML,aNodo: String): String;

function ExtractTextInsideGivenTagEx(const Tag, Text: string): string;
var
  StartPos1, StartPos2, EndPos: integer;
  i: Integer;
begin
  result := '';
  StartPos1 := Pos('<' + Tag, Text);
  EndPos := Pos('</' + Tag + '>', Text);
  StartPos2 := 0;
  for i := StartPos1 + length(Tag) + 1 to EndPos do
    if Text[i] = '>' then
    begin
      StartPos2 := i + 1;
      break;
    end;


  if (StartPos2 > 0) and (EndPos > StartPos2) then
    result := Copy(Text, StartPos2, EndPos - StartPos2);
end;

begin
  Result := '';
  if aXML='' then
    Exit;
  Result := ExtractTextInsideGivenTagEx(UpperCase(aNodo),UpperCase(aXML));
end;


function TdespachosSicam.ARGFaltantesEnMONTEAYMOND(DESPCHILES:TDESPCHILES):TRESULTADO;
var
  str,FI,FF:String;
  rds,rdc,rfal:TRESULTADO;
  FECHA:TFECHA;
  dsXML,dcXML:TXML;
  LS:TLS;
begin
  try
    Result := TRESULTADO.Create;
    FECHA:= TFECHA.Create;
    dsXML:=TXML.Create;
    dcXML:=TXML.Create;
    LS:=TLS.Create;
    try

      FECHA.FINI := DESPCHILES.FINI;
      FECHA.FFIN := DESPCHILES.FFIN;

      dsXML.XML := despachosSicam(FECHA).RESULTADO;
      dcXML.XML := despachosChile(DESPCHILES).RESULTADO;

      LS.LSA := DESPACHOSxmlToLs(dsXML).RESULTADO;
      LS.LSB := DESPACHOSxmlToLs(dcXML).RESULTADO;

      Result := DifLsALsB(LS);

    finally
      FECHA.Free;
      dsXML.Free;
      dcXML.Free;
      LS.Free;
    end;
  except
    on e:Exception do
    begin
      Result.RESULTADO := 'Error:'+e.Message;
    end;
  end;

end;

function TdespachosSicam.CHLFaltantesEnPIA(FECHA: TFECHA): TRESULTADO;
begin

end;

function TdespachosSicam.despachosChile(DESPCHL:TDESPCHILES):TRESULTADO;
 var
   SocketChile: Ipuentechileno;
   filename , pathws: string;
   rta: DespachosChileResponseCHL;
   parametro: DespachosChileRequestCHL;
   inifile: TIniFile;

  procedure log(fileName,LogString: string);
  var f: TextFile;
  begin
    AssignFile(f,fileName);
    If FileExists(fileName) then
      Reset(f)
    else
      Rewrite(f);
    Append(f);
    Writeln(f ,logString);
    closeFile(f);
  end;

begin
  Result := TRESULTADO.Create;
  try
    try
       inifile := TIniFile.Create(Format('%sconfig.ini', [ExtractFilePath(ParamStr(0))]));
       try
         pathws:= inifile.ReadString('server', 'URLPUENTE', '');
       finally
         inifile.Free;
       end;

      SocketChile:= GetIpuentechileno(False, pathws);
      parametro := DespachosChileRequestCHL.Create;
      rta := DespachosChileResponseCHL.Create;

      DateTimeToString(filename,'yyyymmddHHmmss', Now);
      ForceDirectories(ExtractFilePath(ParamStr(0)) + 'logs\'+IntToStr(YearOf(Now))+'\'+FormatFloat('00',MonthOf(Now))+'\'+FormatFloat('00',DayOf(now)));
      filename:= ExtractFilePath(ParamStr(0)) + 'logs\'+IntToStr(YearOf(Now))+'\'+FormatFloat('00',MonthOf(Now))+'\'+FormatFloat('00',DayOf(now))+'\'+ filename+ '.log';
      parametro.FINI := DESPCHL.FINI;
      parametro.FFIN := DESPCHL.FFIN;
      rta:= SocketChile.DespachosChileCHL(parametro);

      if rta.Status = 0 then
        begin
          Result.RESULTADO := '<DESPACHOS>'+valorNodoXML(rta.Data,'DESPACHOS')+'</DESPACHOS>';

          log(filename,valorNodoXML(rta.Data,'DESPACHOS'));
        end
      else
        Result.RESULTADO := 'ERR:'+rta.Descripcion;


    finally
      parametro.free;
      rta.Free;
    end;
  except

    on e:Exception do
      Result.RESULTADO := e.message;
  end;

end;

function TdespachosSicam.despachosSicam(FECHA:TFECHA):TRESULTADO;
begin
  Result := TRESULTADO.Create;

  with TDMDespachos.Create(nil) do
  try
    Result.RESULTADO := consultarVehiculosSicam(FECHA.FINI,FECHA.FFIN);
  finally
    Free;
  end;

end;

function TdespachosSicam.DESPACHOSxmlToLs(aXML:TXML):TRESULTADO;stdcall;
begin
  Result := TRESULTADO.Create;

  with TDMDespachos.Create(nil) do
  try
    Result.RESULTADO := DESPACHOSxmlToLs(aXML.XML);
  finally
    Free;
  end;
end;

function TdespachosSicam.DifLsALsB(LS:TLS):TRESULTADO;
begin
  Result := TRESULTADO.Create;

  with TDMDespachos.Create(nil) do
  try
    Result.RESULTADO := DifLsALsB(LS.LSA, LS.LSB);
  finally
    Free;
  end;
end;

function TdespachosSicam.FALTANTESxmlToLs(aXML:TXML):TRESULTADO;
begin
  Result := TRESULTADO.Create;

  with TDMDespachos.Create(nil) do
  try
    Result.RESULTADO := FALTANTESxmlToLs(aXML.XML);
  finally
    Free;
  end;
end;

initialization
  { Invokable classes must be registered }
  InvRegistry.RegisterInvokableClass(TdespachosSicam);

end.
