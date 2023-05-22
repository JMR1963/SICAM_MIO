{ Invokable implementation File for TpuenteInterpol which implements IpuenteInterpol }

unit puenteInterpolImpl;

interface

uses System.SysUtils , Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, puenteInterpolIntf, Soap.SOAPHTTPClient,inifiles;

type

  { TpuenteInterpol }
  TpuenteInterpol = class(TInvokableClass, IpuenteInterpol)
  public
      function ConsultaInterpol( datos : datosConsultaInterpol):respuestaInterpol; stdcall;
      function LoteDocumentosInterpol(LoteDnm : string ) :  string; stdcall;
  end;

implementation

uses DNM_INTERPOL_WSService1,DNM_INTI_WSService;

function TpuenteInterpol.ConsultaInterpol( datos : datosConsultaInterpol):respuestaInterpol;
var //ws : DNM_INTERPOL_WS;
    ws : DNM_INTI_WS;
    c: string;
    usuario, clave, wsInterpol : string;
    ini : tinifile;
begin
  try
    result := respuestaInterpol.Create;

    ini := TIniFile.Create('.\config.ini'); //ExtractFilePath(application.exename)+
    usuario:= ini.ReadString('CONFIG','USUARIO','');
    clave:= ini.ReadString('CONFIG','CLAVE','');
    wsInterpol:= ini.ReadString('CONFIG','WSINTERPOL','');

    //ws := GetDNM_INTERPOL_WS(FALSE,wsInterpol);

    ws := GetDNM_INTI_WS(false,wsInterpol);
    c:=ws.ConsultaInterpolPersonas(
    datos.nombre,
    datos.apellido,
    datos.fechaNacimiento,
    datos.tipoDoc,
    datos.nroDoc,
    datos.pais,
    datos.genero,
    datos.transito,
    formatdatetime('yyyy-mm-dd HH:mm:ss',now()),
    'ONLINE',
    //datos.usuarioGenerico,
    usuario,
    //datos.passGenerico,
    clave,
    datos.usuarioNombre,
    datos.usuarioApellido,
    datos.usuarioIp,
    datos.usuarioDepen,
    Datos.usuarioDepenId,
    datos.usuarioTipoDoc ,
    datos.usuarioDoc      ,
    datos.usuarioJerarquia,
    datos.usuario
    );

    Result.COD_RTA := copy( c, (Pos('<COD_RTA>', c)+ 9),1);
    Result.COLOR := copy( c, (Pos('<COLOR>', c)+ 7),(Pos('</COLOR>', c)-(Pos('<COLOR>', c)+ 7)));
    Result.COD_DETALLE_RTA := copy( c, (Pos('<COD_DETALLE_RTA>', c)+ 17),1 );

  except
    Result.COD_RTA :='0';
    Result.COLOR := 'NINGUNO';
    Result.COD_DETALLE_RTA :=  '-100';
  end;
end;


function TpuenteInterpol.LoteDocumentosInterpol(LoteDnm : string ) :  string;
var ws : DNM_INTI_WS;
    c: string;
    ini : tinifile;
    wsInterpol : string;
begin
  try
    ini := TIniFile.Create('.\config.ini'); //ExtractFilePath(application.exename)+
    wsInterpol:= ini.ReadString('CONFIG','WSINTERPOL','');
    ws := GetDNM_INTI_WS(false,wsInterpol);
    Result:=ws.LoteDocumentos(LoteDnm);
  except
    Result := 'ERROR - DNM';
  end;
end;

initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(TpuenteInterpol);
end.

