{ Invokable implementation File for TPuenteParaguayo which implements IPuenteParaguayo }

unit PuenteParaguayoImpl;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, PuenteParaguayoIntf, vcl.forms, vcl.dialogs, System.sysutils,
      System.inifiles,
      //WebService1,
      wspersonas,
      System.dateutils; //ConsultarImpedimentosWS1

type

  { TPuenteParaguayo }
  TPuenteParaguayo = class(TInvokableClass, IPuenteParaguayo)
  private
    procedure log(fileName,LogString: string);
  public
    function consultarPuentePry (a : consultaPuentePry):respuestaDTOPry; stdcall;
  end;

implementation

procedure TPuenteParaguayo.log(fileName,LogString: string);
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


function TPuenteParaguayo.consultarPuentePry (a : consultaPuentePry): respuestaDTOPry;
var ws : WebService1Soap;
    R:ConsultarImpedimentosPRYResponse;
    res :respuestaDTOPry;
    usuario, clave, wsPry : string;
    ini : tinifile;
    Ds : DatosSalida;
    filename : string;
begin
  res:= respuestaDToPry.Create;
  R := ConsultarImpedimentosPRYResponse.Create;

  DateTimeToString(filename,'yyyymmddHHmmss', Now);
  ForceDirectories(ExtractFilePath(ParamStr(0)) + 'logs\'+IntToStr(YearOf(Now))+'\'+FormatFloat('00',MonthOf(Now))+'\'+FormatFloat('00',DayOf(now)));
  filename:= ExtractFilePath(ParamStr(0)) + 'logs\'+IntToStr(YearOf(Now))+'\'+FormatFloat('00',MonthOf(Now))+'\'+FormatFloat('00',DayOf(now))+'\'+ filename+'.log';

  try
    ini := TIniFile.Create('.\config.ini'); //ExtractFilePath(application.exename)+
    usuario:= ini.ReadString('CONFIG','USUARIO','');
    clave:= ini.ReadString('CONFIG','CLAVE','');
    wsPry:= ini.ReadString('CONFIG','WSPRY','');

    ds:= DatosSalida.Create;
   ds.USUARIO:= usuario;
   ds.clave:= clave;
   ds.operador:= 'DNM_ARG';
   ds.CODPAIS := a.CODPAIS;
   ds.NOMBRE1 := a.NOMBRE1;
   ds.NOMBRE2 := a.NOMBRE2;
   ds.APELLIDO1 := a.APELLIDO1;
   ds.APELLIDO2 := a.APELLIDO2;
   ds.NUMDOC := a.NUMDOC;
   ds.PUESTOCONTROL := a.PUESTOCONTROL;
   ds.TIPODOC := a.TIPODOC;
   ds.EMISORDOC := a.EMISORDOC;
   ds.FECHANAC := a.FECHANAC;
   ds.GENERO := a.GENERO;
   ds.NACIONALIDAD := a.NACIONALIDAD;
   ds.NUMEROIDENIFICACION := A.NUMEROIDENTIFICACION;
    ws :=  GetWebService1Soap(false, wspry);
    r:= ws.ConsultarImpedimentosPRY( ds);
    res.COD_RTA := R.ConsultarImpedimentosPRYResult.COD_RTA;
    res.COD_DETALLE_RTA := r.ConsultarImpedimentosPRYResult.COD_DETALLE_RTA;
  except
    on e: exception do
    begin
      log(filename, 'ERROR - NroDoc : '+a.NUMDOC+' desc: '+  e.message) ;
      res.COD_RTA := '0';
      res.COD_DETALLE_RTA :='100'; //res.COD_DETALLE_RTA :=    e.message;
    end;
  end;
  Result := res;


{var ws : ConsultarImpedimentosWS;
    R:respuestaDTO;
    res :respuestaDTOPry;
    usuario, clave, wsPry : string;
    ini : tinifile;
begin
  res:= respuestaDToPry.Create;
  R := respuestaDTO.Create;
  try
    ini := TIniFile.Create('.\config.ini'); //ExtractFilePath(application.exename)+
    usuario:= ini.ReadString('CONFIG','USUARIO','');
    clave:= ini.ReadString('CONFIG','CLAVE','');
    wsPry:= ini.ReadString('CONFIG','WSPRY','');

    ws :=  GetConsultarImpedimentosWS(false, wspry);
    r:= ws.consultaImpedimentosDGM(
    usuario,
    clave,
    a.CODPAIS,
    a.NOMBRE1,
    a.NOMBRE2,
    a.APELLIDO1,
    a.APELLIDO2,
    a.NUMDOC,
    a.PUESTOCONTROL,
    a.TIPODOC,
    a.EMISORDOC,
    a.FECHANAC,
    a.GENERO,
    a.NACIONALIDAD,
    A.NUMEROIDENTIFICACION);
    res.COD_RTA := R.COD_RTA;
    res.COD_DETALLE_RTA := r.COD_DETALLE_RTA;
  except
    on e: exception do
    begin
      res.COD_RTA := '0';
      res.COD_DETALLE_RTA :='100'; //res.COD_DETALLE_RTA :=    e.message;
    end;
  end;
  Result := res;  }
end;

initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(TPuenteParaguayo);
end.

