{ Invokable implementation File for TpuenteUry which implements IpuenteUry }

unit puenteUryImpl;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, puenteUryIntf,  forms, dialogs, sysutils,
      inifiles, dateutils,
      //SemaforoCL,
      ConsultaImpedidos_v21 ;

type

  { TpuenteUry }
  TpuenteUry = class(TInvokableClass, IpuenteUry)
  private
    procedure log(fileName,LogString: string);
  public
    function consultarPuenteURY (a : consultaPuenteury): respuestaURY; stdcall;

  end;

implementation

procedure TpuenteUry.log(fileName,LogString: string);
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


function TpuenteUry.consultarPuenteUry (a : consultaPuenteury): respuestaUry;
var ws : IConsultaImpedidos_v2;
    R:ResponseSemaforo2;
    res :respuestaUry;
     wsury, WSUSER: string;
    ini : tinifile;
    Ds : RequestSemaforo2;
    filename : string;
    t: TieneImpedimento;
begin

  res:= respuestaUry.Create;
  R := ResponseSemaforo2.Create;

  DateTimeToString(filename,'yyyymmddHHmmss', Now);
  ForceDirectories(ExtractFilePath(ParamStr(0)) + 'logs\verificar\'+IntToStr(YearOf(Now))+'\'+FormatFloat('00',MonthOf(Now))+'\'+FormatFloat('00',DayOf(now)));
  filename:= ExtractFilePath(ParamStr(0)) + 'logs\verificar\'+IntToStr(YearOf(Now))+'\'+FormatFloat('00',MonthOf(Now))+'\'+FormatFloat('00',DayOf(now))+'\'+ filename+'.log';

  try
    ini := TIniFile.Create('.\config.ini'); //ExtractFilePath(application.exename)+
    wsury:= ini.ReadString('CONFIG','WSURY','');
    WSUSER:= ini.ReadString('CONFIG','WSUSER','');

    ds:= RequestSemaforo2.Create;

    ds.Persona := Persona2.Create;

    ds.Identificador := formatdatetime('yyyymmddhhmmss', now())+ a.NUMDOC;

    ds.persona.Apellidos:= a.APELLIDOS;
    DS.Persona.Nombres:=A.NOMBRES;
    ds.Persona.FechaNacimiento:= DateTimeToXSDateTime(STRTODATE(A.FECHANAC));        //'YYYY/MM/DD'
    ds.Persona.Sexo:= a.GENERO;
    ds.Persona.Nacionalidad := a.NACIONALIDAD;

    ds.Persona.Documento := Documento2.Create;

    if uppercase(a.TIPODOC) = 'ID' then
      ds.Persona.Documento.TipoDoc:= 'CI'
    else
      ds.Persona.Documento.TipoDoc:= 'PA';

    ds.Persona.Documento.OrigenDoc := A.EMISORDOC;
    DS.Persona.Documento.NumeroDoc := A.NUMDOC;
    DS.Persona.Documento.PlasticoDoc := A.NUMEROIDENTIFICACION;

    DS.PuestoControl := a.PUESTOCONTROL;
    DS.Usuario:= A.USER;
    ds.Aplicacion := WSUSER;

    ws :=  GetIConsultaImpedidos_v2(true, wsury,NIL, WSUSER);
    r:= ws.Semaforo(ds);
    res.COD_DETALLE_RTA := '0';
    case r.TieneImpedimento of
      TieneImpedimento(1)  :     begin   res.COD_RTA := '1';     log(filename, 'OK : identificadorURY: '+ds.identificador+' NroDoc : '+a.NUMDOC+' COD_RTA: '+ res.COD_RTA  +' COD_DETALLE_RTA '+ res.COD_DETALLE_RTA ) ; end ;
      TieneImpedimento(0)  : begin   res.COD_RTA := '2';     log(filename, 'OK : identificadorURY: '+ds.identificador+' NroDoc : '+a.NUMDOC+' COD_RTA: '+ res.COD_RTA  +' COD_DETALLE_RTA '+ res.COD_DETALLE_RTA ) ; end ;
      TieneImpedimento(2) :     begin   res.COD_RTA := '0';     log(filename, 'NOT_OK : identificadorURY: '+ds.identificador+' NroDoc : '+a.NUMDOC+' COD_RTA: '+ res.COD_RTA  +' COD_DETALLE_RTA '+ res.COD_DETALLE_RTA +'ERRORES : '+R.ListaErrores[0] ) ; end ;
    end;


  except
    on e: exception do
    begin
      log(filename, 'ERROR : identificadorURY: '+ds.identificador+'  NroDoc : '+a.NUMDOC+' +  desc: '+  e.message) ;
      res.COD_RTA := '-1';
      res.COD_DETALLE_RTA :='100';
    end;
  end;
  Result := res;
end;




initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(TpuenteUry);
end.

