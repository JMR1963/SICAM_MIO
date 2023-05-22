{ Invokable interface Iws_obtener_autorizacion }

unit ws_obtener_autorizacionIntf;

interface

uses InvokeRegistry, Types, XSBuiltIns;

type
  Tdatos_busqueda = class(TRemotable)
    private
      Ffecha_nacimiento: string;
      Fnumero_documento: string;
    published
      property fecha_nacimiento: string read Ffecha_nacimiento write Ffecha_nacimiento;
      property numero_documento: string read Fnumero_documento write Fnumero_documento;
  end;

  tautorizacion_full = class(tremotable)
    private
      p_numero_doc                : string;
      p_fecha_nac                 : string;
      v_tipo                      : string;
      v_nro_solicitud             : string;
      v_fecha_solicitud           : string;
      v_serie_foja                : string;
      v_tipo_foja                 : string;
      v_nombre_escribano          : string;
      v_apellido_escribano        : string;
      v_consulado                 : string;
      v_juzgado                   : string;
      v_apellido_menor            : string;
      v_apellido2_menor           : string;
      v_nombre_menor              : string;
      v_nombre2_menor             : string;
      v_nac_menor                 : string;
      v_tipo_doc_menor            : string;
      v_pais_doc_menor            : string;
      v_nro_doc_menor             : string;
      v_fecha_nac_menor           : string;
      v_pa_tipo_aut               : string;
      v_pa_apellido_1             : string;
      v_pa_apellido_2             : string;
      v_pa_nombre_1               : string;
      v_pa_nombre_2               : string;
      v_pa_tipo_doc               : string;
      v_pa_nro_doc                : string;
      v_pa_nacionalidad           : string;
      v_pa_observacion            : string;
      v_sa_tipo_aut               : string;
      v_sa_apellido_1             : string;
      v_sa_apellido_2             : string;
      v_sa_nombre_1               : string;
      v_sa_nombre_2               : string;
      v_sa_tipo_doc               : string;
      v_sa_nro_doc                : string;
      v_sa_nacionalidad           : string;
      v_sa_observacion            : string;
      v_ta_tipo_aut               : string;
      v_ta_apellido_1             : string;
      v_ta_apellido_2             : string;
      v_ta_nombre_1               : string;
      v_ta_nombre_2               : string;
      v_ta_tipo_doc               : string;
      v_ta_nro_doc                : string;
      v_ta_nacionalidad           : string;
      v_ta_observacion            : string;
      v_tipo_acompaniante         : string;
      v_datos_acompaniante        : string;
      v_tipo_vigencia             : string;
      v_vigencia_desde            : string;
      v_vigencia_hasta            : string;
      v_pais_viaje                : string;
      v_estado                    : string;
    published
      property numero_doc          : string read p_numero_doc             write p_numero_doc;
      property fecha_nac           : string read p_fecha_nac              write p_fecha_nac;
      property tipo                : string read v_tipo                   write v_tipo;
      property nro_solicitud       : string read v_nro_solicitud          write v_nro_solicitud;
      property fecha_solicitud     : string read v_fecha_solicitud        write v_fecha_solicitud;
      property serie_foja          : string read v_serie_foja             write v_serie_foja;
      property tipo_foja           : string read v_tipo_foja              write v_tipo_foja;
      property nombre_escribano    : string read v_nombre_escribano       write v_nombre_escribano;
      property apellido_escribano  : string read v_apellido_escribano     write v_apellido_escribano;
      property consulado           : string read v_consulado              write v_consulado;
      property juzgado             : string read v_juzgado                write v_juzgado;
      property apellido_menor      : string read v_apellido_menor         write v_apellido_menor;
      property apellido2_menor     : string read v_apellido2_menor        write v_apellido2_menor;
      property nombre_menor        : string read v_nombre_menor           write v_nombre_menor;
      property nombre2_menor       : string read v_nombre2_menor          write v_nombre2_menor;
      property nac_menor           : string read v_nac_menor              write v_nac_menor;
      property tipo_doc_menor      : string read v_tipo_doc_menor         write v_tipo_doc_menor;
      property pais_doc_menor      : string read v_pais_doc_menor         write v_pais_doc_menor;
      property nro_doc_menor       : string read v_nro_doc_menor          write v_nro_doc_menor;
      property fecha_nac_menor     : string read v_fecha_nac_menor        write v_fecha_nac_menor;
      property pa_tipo_aut         : string read v_pa_tipo_aut            write v_pa_tipo_aut;
      property pa_apellido_1       : string read v_pa_apellido_1          write v_pa_apellido_1;
      property pa_apellido_2       : string read v_pa_apellido_2          write v_pa_apellido_2;
      property pa_nombre_1         : string read v_pa_nombre_1            write v_pa_nombre_1;
      property pa_nombre_2         : string read v_pa_nombre_2            write v_pa_nombre_2;
      property pa_tipo_doc         : string read v_pa_tipo_doc            write v_pa_tipo_doc;
      property pa_nro_doc          : string read v_pa_nro_doc             write v_pa_nro_doc;
      property pa_nacionalidad     : string read v_pa_nacionalidad        write v_pa_nacionalidad;
      property pa_observacion      : string read v_pa_observacion       write v_pa_observacion;
      property sa_tipo_aut         : string read v_sa_tipo_aut            write v_sa_tipo_aut;
      property sa_apellido_1       : string read v_sa_apellido_1          write v_sa_apellido_1;
      property sa_apellido_2       : string read v_sa_apellido_2          write v_sa_apellido_2;
      property sa_nombre_1         : string read v_sa_nombre_1            write v_sa_nombre_1;
      property sa_nombre_2         : string read v_sa_nombre_2            write v_sa_nombre_2;
      property sa_tipo_doc         : string read v_sa_tipo_doc            write v_sa_tipo_doc;
      property sa_nro_doc          : string read v_sa_nro_doc             write v_sa_nro_doc;
      property sa_nacionalidad     : string read v_sa_nacionalidad        write v_sa_nacionalidad;
      property sa_observacion     : string read v_sa_observacion        write v_sa_observacion;
      property ta_tipo_aut         : string read v_ta_tipo_aut            write v_ta_tipo_aut;
      property ta_apellido_1       : string read v_ta_apellido_1          write v_ta_apellido_1;
      property ta_apellido_2       : string read v_ta_apellido_2          write v_ta_apellido_2;
      property ta_nombre_1         : string read v_ta_nombre_1            write v_ta_nombre_1;
      property ta_nombre_2         : string read v_ta_nombre_2            write v_ta_nombre_2;
      property ta_tipo_doc         : string read v_ta_tipo_doc            write v_ta_tipo_doc;
      property ta_nro_doc          : string read v_ta_nro_doc             write v_ta_nro_doc;
      property ta_nacionalidad     : string read v_ta_nacionalidad        write v_ta_nacionalidad;
      property ta_observacion     : string read v_ta_observacion        write v_ta_observacion;
      property tipo_acompaniante   : string read v_tipo_acompaniante      write v_tipo_acompaniante;
      property datos_acompaniante  : string read v_datos_acompaniante     write v_datos_acompaniante;
      property tipo_vigencia       : string read v_tipo_vigencia          write v_tipo_vigencia;
      property vigencia_desde      : string read v_vigencia_desde         write v_vigencia_desde;
      property vigencia_hasta      : string read v_vigencia_hasta         write v_vigencia_hasta;
      property pais_viaje          : string read v_pais_viaje             write v_pais_viaje;
      property estado              : string read v_estado                 write v_estado;
    end;

  tautorizacion = class(tremotable)
    private
      P_NUMERO_DOCUMENTO            : string;
      P_FECHA_NACIMIENTO            : string;
      P_NRO_ACT_NOTARIAL_CERT_FIRMA : string;
      P_SERIE_FOJA            : string;
      P_TIPO_FOJA             : string;
      P_MENOR                 : string;
      P_AUTORIZANTE_1         : string;
      P_AUTORIZANTE_2         : string;
      P_ACOMPANIANTE          : string;
      P_NOMBRES_ESCRIBANO     : string;
      P_APELLIDOS_ESCRIBANO   : string;
      P_FECHA_DEL_INSTRUMENTO : string;
      P_PAISES_TODOS          : string;
      P_APELLIDO_MENOR        : string;
      P_SAPELLIDO_MENOR       : string;
      P_NOMBRE_MENOR          : string;
      P_SNOMBRE_MENOR         : string;
      P_NACIONALIDAD_MENOR    : string;
      P_TIPO_DOC_MENOR        : string;
      P_EMISOR_DOC_MENOR      : string;
      P_NUMERO_TRAMITE        : string;

      P_NOMBRE_AUTORIZANTE1         : STRING;
      P_OTROS_NOMBRES_AUTORIZANTE1  : STRING;
      P_APELLIDO_AUTORIZANTE1       : STRING;
      P_S_APELLIDO_AUTORIZANTE1     : STRING;
      P_NOMBRE_AUTORIZANTE2         : STRING;
      P_OTROS_NOMBRES_AUTORIZANTE2  : STRING;
      P_APELLIDO_AUTORIZANTE2       : STRING;
      P_S_APELLIDO_AUTORIZANTE2     : STRING;

    published
      property NUMERO_DOCUMENTO             : string read P_NUMERO_DOCUMENTO              write P_NUMERO_DOCUMENTO;
      property FECHA_NACIMIENTO             : string read P_FECHA_NACIMIENTO              write P_FECHA_NACIMIENTO;
      property NRO_ACT_NOTARIAL_CERT_FIRMA  : string read P_NRO_ACT_NOTARIAL_CERT_FIRMA   write P_NRO_ACT_NOTARIAL_CERT_FIRMA;
      property SERIE_FOJA                   : string read P_SERIE_FOJA            write P_SERIE_FOJA;
      property TIPO_FOJA                    : string read P_TIPO_FOJA             write P_TIPO_FOJA;
      property MENOR                        : string read P_MENOR                 write P_MENOR;
      property AUTORIZANTE_1                : string read P_AUTORIZANTE_1         write P_AUTORIZANTE_1;
      property AUTORIZANTE_2                : string read P_AUTORIZANTE_2         write  P_AUTORIZANTE_2;
      property ACOMPANIANTE                 : string read P_ACOMPANIANTE          write P_ACOMPANIANTE;
      property NOMBRES_ESCRIBANO            : string read P_NOMBRES_ESCRIBANO     write P_NOMBRES_ESCRIBANO;
      property APELLIDOS_ESCRIBANO          : string read P_APELLIDOS_ESCRIBANO   write P_APELLIDOS_ESCRIBANO;
      property FECHA_DEL_INSTRUMENTO        : string read P_FECHA_DEL_INSTRUMENTO write P_FECHA_DEL_INSTRUMENTO;
      property PAISES_TODOS                 : string read P_PAISES_TODOS          write P_PAISES_TODOS;
      property APELLIDO_MENOR               : string read P_APELLIDO_MENOR        write P_APELLIDO_MENOR;
      property SAPELLIDO_MENOR              : string read P_SAPELLIDO_MENOR       write P_SAPELLIDO_MENOR;
      property NOMBRE_MENOR                 : string read P_NOMBRE_MENOR          write P_NOMBRE_MENOR;
      property SNOMBRE_MENOR                : string read P_SNOMBRE_MENOR         write P_SNOMBRE_MENOR;
      property NACIONALIDAD_MENOR           : string read P_NACIONALIDAD_MENOR    write P_NACIONALIDAD_MENOR;
      property TIPO_DOC_MENOR               : string read P_TIPO_DOC_MENOR        write P_TIPO_DOC_MENOR;
      property EMISOR_DOC_MENOR             : string read P_EMISOR_DOC_MENOR      write P_EMISOR_DOC_MENOR;
      property NUMERO_TRAMITE               : string read P_NUMERO_TRAMITE        write P_NUMERO_TRAMITE;
      property NOMBRE_AUTORIZANTE1        : string read P_NOMBRE_AUTORIZANTE1        write P_NOMBRE_AUTORIZANTE1;
      property OTROS_NOMBRES_AUTORIZANTE1 : string read P_OTROS_NOMBRES_AUTORIZANTE1 write P_OTROS_NOMBRES_AUTORIZANTE1;
      property APELLIDO_AUTORIZANTE1      : string read P_APELLIDO_AUTORIZANTE1      write P_APELLIDO_AUTORIZANTE1;
      property S_APELLIDO_AUTORIZANTE1    : string read P_S_APELLIDO_AUTORIZANTE1    write P_S_APELLIDO_AUTORIZANTE1;
      property NOMBRE_AUTORIZANTE2        : string read P_NOMBRE_AUTORIZANTE2        Write P_NOMBRE_AUTORIZANTE2;
      property OTROS_NOMBRES_AUTORIZANTE2 : string read P_OTROS_NOMBRES_AUTORIZANTE2 write P_OTROS_NOMBRES_AUTORIZANTE2;
      property APELLIDO_AUTORIZANTE2      : string read P_APELLIDO_AUTORIZANTE2      write P_APELLIDO_AUTORIZANTE2;
      property S_APELLIDO_AUTORIZANTE2    : string read P_S_APELLIDO_AUTORIZANTE2    write P_S_APELLIDO_AUTORIZANTE2;

    end;




    tautorizacion_sacer = class(tremotable)
    private
      P_NUMERO_DOC            : string;
      P_FECHA_NAC             : string;
      P_NRO_SOLICITUD         : string;
      P_FECHA_SOLICITUD       : string;
      P_APELLIDO_MENOR        : string;
      P_NOMBRE_MENOR          : string;
      P_NACIONALIDAD          : string;
      P_PA_APELLIDO_1         : string;
      P_PA_APELLIDO_2         : string;
      P_PA_NOMBRE_1           : string;
      P_PA_NOMBRE_2           : string;
      P_PA_TIPO_DOCUMENTO     : string;
      P_PA_NRO_DOCUMENTO      : string;
      P_PA_NACIONALIDAD       : string;
      P_SA_APELLIDO_1         : string;
      P_SA_APELLIDO_2         : string;
      P_SA_NOMBRE_1              : string;
      P_SA_NOMBRE_2              : string;
      P_SA_TIPO_DOCUMENTO        : string;
      P_SA_NRO_DOCUMENTO         : string;
      P_SA_NACIONALIDAD          : string;
      P_ACOMPANIANTE_DESCRIPCION : string;
    published
      property NUMERO_DOC            : string read P_NUMERO_DOC     write P_NUMERO_DOC;
      property FECHA_NAC             : string read P_FECHA_NAC      write P_FECHA_NAC;
      property NRO_SOLICITUD         : string read P_NRO_SOLICITUD    write P_NRO_SOLICITUD;
      property FECHA_SOLICITUD       : string read P_FECHA_SOLICITUD  write P_FECHA_SOLICITUD;
      property APELLIDO_MENOR        : string read P_APELLIDO_MENOR   write P_APELLIDO_MENOR;
      property NOMBRE_MENOR          : string read P_NOMBRE_MENOR   write P_NOMBRE_MENOR;
      property NACIONALIDAD          : string read P_NACIONALIDAD   write P_NACIONALIDAD;
      property PA_APELLIDO_1         : string read P_PA_APELLIDO_1  write P_PA_APELLIDO_1;
      property PA_APELLIDO_2         : string read P_PA_APELLIDO_2  write P_PA_APELLIDO_2;
      property PA_NOMBRE_1           : string read P_PA_NOMBRE_1 write P_PA_NOMBRE_1;
      property PA_NOMBRE_2           : string read P_PA_NOMBRE_2 write P_PA_NOMBRE_2;
      property PA_TIPO_DOCUMENTO     : string read P_PA_TIPO_DOCUMENTO  write P_PA_TIPO_DOCUMENTO;
      property PA_NRO_DOCUMENTO      : string read P_PA_NRO_DOCUMENTO   write P_PA_NRO_DOCUMENTO;
      property PA_NACIONALIDAD       : string read P_PA_NACIONALIDAD  write P_PA_NACIONALIDAD;
      property SA_APELLIDO_1         : string read P_SA_APELLIDO_1    write P_SA_APELLIDO_1;
      property SA_APELLIDO_2         : string read P_SA_APELLIDO_2    write P_SA_APELLIDO_2;
      property SA_NOMBRE_1              : string read P_SA_NOMBRE_1   write P_SA_NOMBRE_1;
      property SA_NOMBRE_2              : string read P_SA_NOMBRE_2   write P_SA_NOMBRE_2;
      property SA_TIPO_DOCUMENTO        : string read P_SA_TIPO_DOCUMENTO write P_SA_TIPO_DOCUMENTO;
      property SA_NRO_DOCUMENTO         : string read P_SA_NRO_DOCUMENTO  write P_SA_NRO_DOCUMENTO;
      property SA_NACIONALIDAD          : string read P_SA_NACIONALIDAD   write P_SA_NACIONALIDAD;
      property ACOMPANIANTE_DESCRIPCION : string read P_ACOMPANIANTE_DESCRIPCION write P_ACOMPANIANTE_DESCRIPCION;
    end;

    ttercero = class(tremotable)
    private
      fnombre1  : string;
      fnombre2  : string;
      fapellido1: string;
      fapellido2: string;
    published
      property nombre1          : string read fnombre1 write fnombre1;
      property nombre2          : string read fnombre2 write fnombre2;
      property apellido1        : string read fapellido1 write fapellido1;
      property apellido2        : string read fapellido2 write fapellido2;
    end;

    tterceros = array of ttercero;

  { Invokable interfaces must derive from IInvokable }
  Iws_obtener_autorizacion = interface(IInvokable)
  ['{3E646A5A-387A-48CB-BEA4-628F993E0C14}']
    function obtener_autorizacion_escribanos(datos_busqueda:Tdatos_busqueda):tautorizacion; stdcall;
    function obtener_autorizacion_sacer(datos_busqueda:Tdatos_busqueda):tautorizacion_sacer; stdcall;
    function obtener_terceros(tramite: string):tterceros; stdcall;
    function obtener_autorizantes(tramite: string):tterceros; stdcall;
    function autorizacion_menores(datos_busqueda:Tdatos_busqueda):tautorizacion_full; stdcall;
    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(Iws_obtener_autorizacion));

end.
 