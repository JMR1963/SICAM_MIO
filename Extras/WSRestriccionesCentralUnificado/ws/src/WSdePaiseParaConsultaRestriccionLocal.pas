unit WSdePaiseParaConsultaRestriccionLocal;



interface

uses system.SysUtils, WsListaControlIntf,IPuenteParaguayo1, UGLOBAL, IpuenteBoliviano1, Ipuentechileno2, DateUtils;//Semaforo1;

procedure  consultarParaguay(consulta : XML_CONSULTA_NEW; var Cod_rta, rta_Detalle : integer);
procedure  consultarBolivia(consulta : XML_CONSULTA_NEW; var Cod_rta, rta_Detalle : integer );
procedure  consultarCHILE(consulta : XML_CONSULTA_NEW; var Cod_rta, rta_Detalle : integer);

implementation


procedure  consultarParaguay(consulta : XML_CONSULTA_NEW; var Cod_rta, rta_Detalle : integer);
var ws : IPuenteParaguayo;
    r: respuestaDTOPry;
    a: consultaPuentePry;
begin
  r:= respuestaDTOPry.Create;
  try
    ws :=  GetIPuenteParaguayo(false,uglobal.WSPUENTE); //, uglobal.WSPUENTE
    a := consultaPuentePry.Create;
    a.CODPAIS:= consulta.FUENTES;
    A.NOMBRE1:= consulta.NOMBRE1;
    A.NOMBRE2:= consulta.NOMBRE2;
    A.APELLIDO1:= consulta.APELLIDO1;
    A.APELLIDO2:= consulta.APELLIDO2;
    A.NUMDOC:= consulta.NUMDOC;
    A.PUESTOCONTROL:= consulta.PASO;
    A.TIPODOC:= consulta.TIPODOC;
    A.EMISORDOC := consulta.EMISORDOC;
    A.FECHANAC := consulta.FECHANAC;
    if consulta.GENERO = 'M' then
      a.GENERO := 'MALE'
    ELSE
      A.GENERO := 'FEMALE';
    //A.GENERO:= consulta.GENERO;
    A.NACIONALIDAD := consulta.NACIONALIDAD;
    A.NUMEROIDENTIFICACION := consulta.NUMEROIDENIFICACION;

    r:= ws.consultarPuentePry(a);
    Cod_rta := strtoint(r.COD_RTA);
    rta_Detalle := strtoint(r.COD_DETALLE_RTA);
  except
    Cod_rta := 0;
    rta_Detalle := 101;
  end;
end;



procedure  consultarBolivia(consulta : XML_CONSULTA_NEW; var Cod_rta, rta_Detalle : integer);
var ws : IpuenteBoliviano;
    r: DatosSalidaPte;
    a: DatosEntradaPte;
begin
  r:= DatosSalidaPte.Create;
  try
    ws :=  GetIpuenteBoliviano(FALSE,uglobal.WSPUENTE); //, uglobal.WSPUENTE
    a := DatosEntradaPte.Create;
    a.CODPAIS:= consulta.FUENTES;
    A.NOMBRE1:= pchar(trim(consulta.NOMBRE1));
    A.NOMBRE2:= pchar(trim(consulta.NOMBRE2));
    A.APELLIDO1:= pchar(trim(consulta.APELLIDO1));
    A.APELLIDO2:= pchar(trim(consulta.APELLIDO2));
    A.NUMDOC:= pchar(trim(consulta.NUMDOC));
    A.PUESTOCONTROL:= consulta.PASO;
    A.TIPODOC:= consulta.TIPODOC;
    A.EMISORDOC := consulta.EMISORDOC;
    A.FECHANAC := consulta.FECHANAC;
    A.GENERO:= consulta.GENERO;
    A.NACIONALIDAD := consulta.NACIONALIDAD;
    A.NUMEROIDENIFICACION := consulta.NUMEROIDENIFICACION;

    r:= ws.ConsultaBolivia(a);
    Cod_rta := strtoint(r.COD_RTA);
    rta_Detalle := strtoint(r.COD_DETALLE_RTA);
  except
    Cod_rta := -1;
    rta_Detalle := 101;
  end;
end;

procedure  consultarCHILE(consulta : XML_CONSULTA_NEW; var Cod_rta, rta_Detalle : integer);
var ws : Ipuentechileno;
    r: respuestaDTOCHL;
    a: consultaPuenteCHL;
      procedure log(LogString: string);
    var f: TextFile;
        fechaHoy : TDateTime;
        fileName : string;

    begin
      try
        fechaHoy := Now;
        ForceDirectories(ExtractFilePath(ParamStr(0)) + 'log\'+IntToStr(YearOf(fechaHoy))+'\'+FormatFloat('00',MonthOf(fechaHoy))+'\'+FormatFloat('00',DayOf(fechaHoy)));
        filename:= ExtractFilePath(ParamStr(0)) + 'log\'+IntToStr(YearOf(fechaHoy))+'\'+FormatFloat('00',MonthOf(fechaHoy))+'\'+FormatFloat('00',DayOf(fechaHoy))+'\'+FormatDateTime('YYYYMMDDhhmmss',fechaHoy) +'_'+ consulta.NUMDOC+ '.log';
        AssignFile(f,fileName);
        If FileExists(fileName) then
          Reset(f)
        else
          Rewrite(f);
        Append(f);
        Writeln(f,logString);
        closeFile(f);
      except
      end;
    end;
begin
  r := respuestaDTOCHL.Create;
  try
    ws :=  GetIpuentechileno(false,uglobal.WSPUENTE);
    a := consultaPuenteCHL.Create;

   
    a.CODPAIS:= consulta.FUENTES;
    A.NOMBRE1:= consulta.NOMBRE1;
    A.NOMBRE2:= consulta.NOMBRE2;
    A.APELLIDO1:= consulta.APELLIDO1;
    A.APELLIDO2:= consulta.APELLIDO2;
    A.NUMDOC:= consulta.NUMDOC;
    A.PUESTOCONTROL:= consulta.PASO;
    A.TIPODOC:= consulta.TIPODOC;
    A.EMISORDOC := consulta.EMISORDOC;
    A.FECHANAC := consulta.FECHANAC;
    a.GENERo:= consulta.GENERO;

    A.NACIONALIDAD := consulta.NACIONALIDAD;
    A.NUMEROIDENTIFICACION := consulta.NUMEROIDENIFICACION;

    r:= ws.consultarPuenteCHL(a);

    Cod_rta := StrToInt(r.COD_RTA);
    if r.COD_DETALLE_RTA ='ACK'then
        rta_detalle:= 0
       else
           if r.COD_DETALLE_RTA ='NAK'then
            rta_Detalle:=2
            else
            if r.COD_DETALLE_RTA ='No se encontró uno de los campos obligatorios (Tipo, Numero y Pais Documento, Apellido Paterno y Primer Nombre)'then
              rta_Detalle:=30
              else
               if r.COD_DETALLE_RTA ='No se encontró código país chile para país documento: [Numero del documento]'then
                rta_Detalle:=31;

   // rta_Detalle := r.COD_DETALLE_RTA;
    {
    AOD = 0
    CVM = ACK

    AOD = 2
    CVM = NAK

    AOD = 30
    CVM =No se encontró uno de los campos obligatorios (Tipo, Numero y Pais Documento, Apellido Paterno y Primer Nombre)

    AOD = 31
    CVM = No se encontró código país chile para país documento: [Numero del documento]}

  except on e:Exception do
    begin
      Cod_rta := -1;
      rta_Detalle := 101;
      log(e.Message);
    end;
  end;
end;



end.
