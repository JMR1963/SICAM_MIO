{ Invokable interface IWSActuaciones }

unit WSActuacionesIntf;

interface

uses Soap.InvokeRegistry, system.Types, Soap.XSBuiltIns;

type

  THabilitaciones = class(TRemotable)
  private
    fIDACTUACION:WideString;
    fAPELLIDOS:WideString;
    fNOMBRES:WideString;
    fNACIONALIDAD:WideString;
    fSEXO:WideString;
    fFECHA_ALTA:WideString;
    fEXPEDIENTE:WideString;
    fTIPO_DOCUMENTO:WideString;
    fNUMERO_DOCUMENTO:WideString;
    fPAIS_DOCUMENTO:WideString;
    fNRO_SOLICITUD:WideString;
    fCONDICION_PAGO:WideString;
    fFECHA_PAGO:WideString;
    fBURE:WideString;
    fIMPORTE:WideString;
    fPASO:WideString;
    fTIPO_TRAMITE:WideString;
    fid_pers:WideString;
    fID_LOC:WideString;
    fCOD_PAIS_EMISOR:WideString;
    fCOD_NACIONALIDAD:WideString;
published
    property APELLIDOS:WideString	read	    fAPELLIDOS	write	    fAPELLIDOS;
    property NOMBRES:WideString	read	    fNOMBRES	write	    fNOMBRES;
    property SEXO:WideString	read	    fSEXO	write	    fSEXO;
    property NACIONALIDAD:WideString	read	    fNACIONALIDAD	write	    fNACIONALIDAD;
    property FECHA_ALTA:WideString	read	    fFECHA_ALTA	write	    fFECHA_ALTA;
    property EXPEDIENTE:WideString	read	    fEXPEDIENTE	write	    fEXPEDIENTE;
    property TIPO_DOCUMENTO:WideString	read	    fTIPO_DOCUMENTO	write	    fTIPO_DOCUMENTO;
    property NUMERO_DOCUMENTO:WideString	read	    fNUMERO_DOCUMENTO	write	    fNUMERO_DOCUMENTO;
    property PAIS_DOCUMENTO:WideString	read	    fPAIS_DOCUMENTO	write	    fPAIS_DOCUMENTO;
    property NRO_SOLICITUD:WideString	read	    fNRO_SOLICITUD	write	    fNRO_SOLICITUD;
    property CONDICION_PAGO:WideString	read	    fCONDICION_PAGO	write	    fCONDICION_PAGO;
    property FECHA_PAGO:WideString	read	    fFECHA_PAGO	write	    fFECHA_PAGO;
    property BURE:WideString	read	    fBURE	write	    fBURE;
    property IMPORTE:WideString	read	    fIMPORTE	write	    fIMPORTE;
    property PASO:WideString	read	    fPASO	write	    fPASO;
    property TIPO_TRAMITE:WideString	read	    fTIPO_TRAMITE	write	    fTIPO_TRAMITE;
    property IDACTUACION:WideString  read	  fIDACTUACION	 write	fIDACTUACION;
    property ID_PERS:WideString  read	  fid_pers	 write	fid_pers;
    property ID_LOC:WideString  read	  fid_loc	 write	fid_loc;
    property COD_PAIS_EMISOR:WideString read fCOD_PAIS_EMISOR write fCOD_PAIS_EMISOR;
    property COD_NACIONALIDAD:WideString read fCOD_NACIONALIDAD write fCOD_NACIONALIDAD;
  end;


  TExpedientes = class(TRemotable)
  private
    fIDACTUACION:WideString;
    fAPELLIDO:WideString;
    fNOMBRE:WideString;
    fNRO_CUIM:WideString;
    fTIPO_DOC:WideString;
    fNUM_DOC:WideString;
    fFECHA_NAC:WideString;
    fSEXO:WideString;
    fE_CIVIL:WideString;
    fPAIS_NAC:WideString;
    fNACIONALIDAD:WideString;
    fFECHA_INGRESO:WideString;
    fDOMICILIO:WideString;
    fLOCALIDAD:WideString;
    fPROFESION:WideString;
    fDATO_MADRE:WideString;
    fDATO_PADRE:WideString;
    fTIPO_ACTUACION:WideString;
    fNRO_EXPEDIENTE:WideString;
    fFECHA_INICIO:WideString;
    fDELEGACION_INICIO:WideString;
    fMOTIVO:WideString;
    fNORMA:WideString;
    fCATEGORIA_OBTENIDA:WideString;
    fNRO_DISPO:WideString;
    fFECHA_DISPO:WideString;
    fFECHA_RADICACION_DESDE:WideString;
    fFECHA_VENCIMIENTO:WideString;
    fCONSULADO:WideString;
    fNRO_ACTO_CONSULAR:WideString;
    fANIO_ACTO_CONSULAR:WideString;
    fPERMANENCIA_AUTORIZADA_DNM:WideString;
    fPERMANENCIA_AUTORIZADA_CONSUL:WideString;
    fNRO_PRESOLICITUD:WideString;
    fANIO_DISPOSICION:WideString;
    fDIAS:WideString;
    fDIAS_CONSULADO:WideString;
    fDIAS_CON_INGRESO:WideString;
    fFECHA_ULTIMO_INGRESO:WideString;
    fCOD_PAIS_EMISOR:WideString;
    fCOD_NACIONALIDAD:WideString;
  published
    property APELLIDO:WideString	read	    fAPELLIDO	write	    fAPELLIDO;
    property NOMBRE:WideString	read	    fNOMBRE	write	    fNOMBRE;
    property NRO_CUIM:WideString	read	    fNRO_CUIM	write	    fNRO_CUIM;
    property TIPO_DOC:WideString	read	    fTIPO_DOC	write	    fTIPO_DOC;
    property NUM_DOC:WideString	read	    fNUM_DOC	write	    fNUM_DOC;
    property FECHA_NAC:WideString	read	    fFECHA_NAC	write	    fFECHA_NAC;
    property SEXO:WideString	read	    fSEXO	write	    fSEXO;
    property E_CIVIL:WideString	read	    fE_CIVIL	write	    fE_CIVIL;
    property PAIS_NAC:WideString	read	    fPAIS_NAC	write	    fPAIS_NAC;
    property NACIONALIDAD:WideString	read	    fNACIONALIDAD	write	    fNACIONALIDAD;
    property FECHA_INGRESO:WideString	read	    fFECHA_INGRESO	write	    fFECHA_INGRESO;
    property DOMICILIO:WideString	read	    fDOMICILIO	write	    fDOMICILIO;
    property LOCALIDAD:WideString	read	    fLOCALIDAD	write	    fLOCALIDAD;
    property PROFESION:WideString	read	    fPROFESION	write	    fPROFESION;
    property DATO_MADRE:WideString	read	    fDATO_MADRE	write	    fDATO_MADRE;
    property DATO_PADRE:WideString	read	    fDATO_PADRE	write	    fDATO_PADRE;
    property TIPO_ACTUACION:WideString	read	    fTIPO_ACTUACION	write	    fTIPO_ACTUACION;
    property NRO_EXPEDIENTE:WideString	read	    fNRO_EXPEDIENTE	write	    fNRO_EXPEDIENTE;
    property FECHA_INICIO:WideString	read	    fFECHA_INICIO	write	    fFECHA_INICIO;
    property DELEGACION_INICIO:WideString	read	    fDELEGACION_INICIO	write	    fDELEGACION_INICIO;
    property MOTIVO:WideString	read	    fMOTIVO	write	    fMOTIVO;
    property NORMA:WideString	read	    fNORMA	write	    fNORMA;
    property CATEGORIA_OBTENIDA:WideString	read	    fCATEGORIA_OBTENIDA	write	    fCATEGORIA_OBTENIDA;
    property NRO_DISPO:WideString	read	    fNRO_DISPO	write	    fNRO_DISPO;
    property FECHA_DISPO:WideString	read	    fFECHA_DISPO	write	    fFECHA_DISPO;
    property FECHA_RADICACION_DESDE:WideString	read	    fFECHA_RADICACION_DESDE	write	    fFECHA_RADICACION_DESDE;
    property FECHA_VENCIMIENTO:WideString	read	    fFECHA_VENCIMIENTO	write	    fFECHA_VENCIMIENTO;
    property CONSULADO:WideString	read	    fCONSULADO	write	    fCONSULADO;
    property NRO_ACTO_CONSULAR:WideString	read	    fNRO_ACTO_CONSULAR	write	    fNRO_ACTO_CONSULAR;
    property ANIO_ACTO_CONSULAR:WideString	read	    fANIO_ACTO_CONSULAR	write	    fANIO_ACTO_CONSULAR;
    property PERMANENCIA_AUTORIZADA_DNM:WideString	read	    fPERMANENCIA_AUTORIZADA_DNM	write	    fPERMANENCIA_AUTORIZADA_DNM;
    property PERMANENCIA_AUTORIZADA_CONSUL:WideString	read	    fPERMANENCIA_AUTORIZADA_CONSUL	write	    fPERMANENCIA_AUTORIZADA_CONSUL;
    property NRO_PRESOLICITUD:WideString read    fNRO_PRESOLICITUD write   fNRO_PRESOLICITUD;
    property IDACTUACION:WideString  read	  fIDACTUACION	 write	fIDACTUACION;
    property ANIO_DISPOSICION:WideString  read	  fANIO_DISPOSICION	 write	fANIO_DISPOSICION;
    property DIAS:WideString read fDIAS write fDIAS;
    property DIAS_CONSULADO:WideString read fDIAS_CONSULADO write fDIAS_CONSULADO;
    property DIAS_CON_INGRESO:WideString read fDIAS_CON_INGRESO write fDIAS_CON_INGRESO;
    property FECHA_ULTIMO_INGRESO:WideString read fFECHA_ULTIMO_INGRESO write fFECHA_ULTIMO_INGRESO;
    property COD_PAIS_EMISOR:WideString read fCOD_PAIS_EMISOR write fCOD_PAIS_EMISOR;
    property COD_NACIONALIDAD:WideString read fCOD_NACIONALIDAD write fCOD_NACIONALIDAD;
  end;

  TVectExpedientes = Array of TExpedientes;
  TVectHabilitaciones =  Array of THabilitaciones;

  TResultado = class(TRemotable)
  private
    fFilasExpedientes: TVectExpedientes;
    fExpedientesNroFilas:Integer;
    fFilasHabilitaciones: TVectHabilitaciones;
    fHabilitacionesNroFilas:Integer;
  published
    property FilasExpedientes: TVectExpedientes read fFilasExpedientes write fFilasExpedientes;
    property NroFilasExpedientes: Integer read fExpedientesNroFilas write fExpedientesNroFilas;

    property FilasHabilitaciones: TVectHabilitaciones read fFilasHabilitaciones write fFilasHabilitaciones;
    property NroFilasHabilitaciones: Integer read fHabilitacionesNroFilas write fHabilitacionesNroFilas;
  end;




  TSituacionMig = class(TRemotable)
  private
    FSituacionMig : WideString;
    FFechaVto : WideString;
  published
    property SituacionMig : WideString read FSituacionMig write FSituacionMig;
    property FechaVto   : WideString read FFechaVto	write	FFechaVto;
  end;


//  TArrayRet = array of WideString;

  { Invokable interfaces must derive from IInvokable }
  IWSActuaciones = interface(IInvokable)
  ['{A553EC1B-109E-4949-BD9D-DA9DC7D7AD0D}']
    function GetDisposiciones(const nro_dispo:Int64;const anio:Integer):TResultado; stdcall;
    function GetExpedientes(const nro_exp:Int64):TResultado; stdcall;
    function GetFotoExpedientes(const nro_presol:Int64):String; stdcall;
    function GetHabilitaciones(const nro_habilitacion:string):TResultado; stdcall;
    function GetFotoHabilitaciones(id_pers,ID_LOC:WideString): String; stdcall;

    function GetSituacionMigratoria(documento:WideString): TSituacionMig; stdcall;

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }

  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IWSActuaciones));

end.
