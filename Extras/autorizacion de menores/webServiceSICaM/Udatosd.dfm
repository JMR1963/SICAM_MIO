object DataModule1: TDataModule1
  Height = 295
  Width = 368
  object osConeccion: TOraSession
    Username = 'autusr'
    Server = 'nominas'
    Left = 72
    Top = 16
    EncryptedPassword = '8AFF8CFF8DFF9EFF8AFF8BFF'
  end
  object ospBusqueda_escribanos: TOraStoredProc
    StoredProcName = 'autorizaciones_viaje.PR_OBTENER_AUTORIZA_ESCRIBANO'
    Session = osConeccion
    SQL.Strings = (
      'begin'
      
        '  autorizaciones_viaje.PR_OBTENER_AUTORIZA_ESCRIBANO(:P_NUMERO_D' +
        'OC, :P_FECHA_NAC, :P_NRO_ACT_NOTARIAL_CERT_FIRMA, :P_SERIE_FOJA,' +
        ' :P_TIPO_FOJA, :P_MENOR, :P_AUTORIZANTE_1, :P_AUTORIZANTE_2, :P_' +
        'NOMBRES_ESCRIBANO, :P_APELLIDOS_ESCRIBANO, :P_FECHA_DEL_INSTRUME' +
        'NTO, :P_PAISES_TODOS, :P_APELLIDO_MENOR, :P_SAPELLIDO_MENOR, :P_' +
        'NOMBRE_MENOR, :P_SNOMBRE_MENOR, :P_NACIONALIDAD_MENOR, :P_TIPO_D' +
        'OC_MENOR, :P_EMISOR_DOC_MENOR, :P_ID, :P_NOMBRE_AUTORIZANTE1, :P' +
        '_OTROS_NOMBRES_AUTORIZANTE1, :P_APELLIDO_AUTORIZANTE1, :P_S_APEL' +
        'LIDO_AUTORIZANTE1, :P_NOMBRE_AUTORIZANTE2, :P_OTROS_NOMBRES_AUTO' +
        'RIZANTE2, :P_APELLIDO_AUTORIZANTE2, :P_S_APELLIDO_AUTORIZANTE2);'
      'end;')
    Left = 72
    Top = 80
    ParamData = <
      item
        DataType = ftString
        Name = 'P_NUMERO_DOC'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_FECHA_NAC'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NRO_ACT_NOTARIAL_CERT_FIRMA'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SERIE_FOJA'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_TIPO_FOJA'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_MENOR'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_AUTORIZANTE_1'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_AUTORIZANTE_2'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NOMBRES_ESCRIBANO'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_APELLIDOS_ESCRIBANO'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_FECHA_DEL_INSTRUMENTO'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_PAISES_TODOS'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_APELLIDO_MENOR'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SAPELLIDO_MENOR'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NOMBRE_MENOR'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SNOMBRE_MENOR'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NACIONALIDAD_MENOR'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_TIPO_DOC_MENOR'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_EMISOR_DOC_MENOR'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_ID'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NOMBRE_AUTORIZANTE1'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_OTROS_NOMBRES_AUTORIZANTE1'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_APELLIDO_AUTORIZANTE1'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_S_APELLIDO_AUTORIZANTE1'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NOMBRE_AUTORIZANTE2'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_OTROS_NOMBRES_AUTORIZANTE2'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_APELLIDO_AUTORIZANTE2'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_S_APELLIDO_AUTORIZANTE2'
        ParamType = ptOutput
        Value = nil
      end>
  end
  object ospBusquedaSacer: TOraStoredProc
    StoredProcName = 'autorizaciones_viaje.PR_OBTENER_AUTORIZACION_SACER'
    Session = osConeccion
    SQL.Strings = (
      'begin'
      
        '  autorizaciones_viaje.PR_OBTENER_AUTORIZACION_SACER(:P_NUMERO_D' +
        'OC, :P_FECHA_NAC, :P_NRO_SOLICITUD, :P_FECHA_SOLICITUD, :P_APELL' +
        'IDO_MENOR, :P_NOMBRE_MENOR, :P_NACIONALIDAD, :P_PA_APELLIDO_1, :' +
        'P_PA_APELLIDO_2, :P_PA_NOMBRE_1, :P_PA_NOMBRE_2, :P_PA_TIPO_DOCU' +
        'MENTO, :P_PA_NRO_DOCUMENTO, :P_PA_NACIONALIDAD, :P_SA_APELLIDO_1' +
        ', :P_SA_APELLIDO_2, :P_SA_NOMBRE_1, :P_SA_NOMBRE_2, :P_SA_TIPO_D' +
        'OCUMENTO, :P_SA_NRO_DOCUMENTO, :P_SA_NACIONALIDAD, :P_ACOMPANIAN' +
        'TE_DESCRIPCION);'
      'end;')
    Left = 72
    Top = 144
    ParamData = <
      item
        DataType = ftString
        Name = 'P_NUMERO_DOC'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_FECHA_NAC'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NRO_SOLICITUD'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftDateTime
        Name = 'P_FECHA_SOLICITUD'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_APELLIDO_MENOR'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NOMBRE_MENOR'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NACIONALIDAD'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_PA_APELLIDO_1'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_PA_APELLIDO_2'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_PA_NOMBRE_1'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_PA_NOMBRE_2'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_PA_TIPO_DOCUMENTO'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_PA_NRO_DOCUMENTO'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_PA_NACIONALIDAD'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SA_APELLIDO_1'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SA_APELLIDO_2'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SA_NOMBRE_1'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SA_NOMBRE_2'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SA_TIPO_DOCUMENTO'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SA_NRO_DOCUMENTO'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SA_NACIONALIDAD'
        ParamType = ptOutput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_ACOMPANIANTE_DESCRIPCION'
        ParamType = ptOutput
        Value = nil
      end>
  end
  object ospTerceros: TOraStoredProc
    StoredProcName = 'autorizaciones_viaje.FN_TERCEROS'
    Session = osConeccion
    SQL.Strings = (
      'begin'
      '  :RESULT := autorizaciones_viaje.FN_TERCEROS(:P_TRAMITE);'
      'end;')
    Left = 72
    Top = 208
    ParamData = <
      item
        DataType = ftCursor
        Name = 'RESULT'
        ParamType = ptOutput
        Value = 'Object'
      end
      item
        DataType = ftFloat
        Name = 'P_TRAMITE'
        ParamType = ptInput
        Value = nil
      end>
  end
  object oqProgenitores: TOraQuery
    Aggregates = <>
    Session = osConeccion
    SQL.Strings = (
      'SELECT'
      '  PE.ID,'
      '  PE.APELLIDO,'
      '  PE.SEGUNDO_APELLIDO,'
      '  PE.NOMBRE,'
      '  PE.OTROS_NOMBRES,'
      '  PE.TIPO_DOCUMENTO,'
      '  PE.NUMERO_DOCUMENTO'
      'FROM'
      '  AUTORIZACIONES_VIAJE.progenitores  AT'
      'INNER JOIN'
      '  AUTORIZACIONES_VIAJE.PERSONA PE ON(AT.progenitor = PE.ID)'
      'WHERE'
      '  AT.TRAMITE = :ptramite'
      'ORDER BY'
      '  PE.ID')
    Left = 224
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ptramite'
        Value = nil
      end>
  end
  object OqAcompaniantes: TOraQuery
    Aggregates = <>
    Session = osConeccion
    SQL.Strings = (
      'select '
      
        '    p1.nombre ||'#39' '#39' ||  p1.otros_nombres nombre1, p1.apellido ||' +
        #39' '#39' || p1.segundo_apellido apellido1,'
      
        '    p2.nombre ||'#39' '#39' ||  p2.otros_nombres nombre2, p2.apellido ||' +
        #39' '#39' || p2.segundo_apellido apellido2'
      'FROM '
      '    AUTORIZACIONES_VIAJE.AUTORIZACION au'
      'inner join '
      '    AUTORIZACIONES_VIAJE.persona p1'
      'on'
      '    p1.id = au.autorizante_1'
      'inner join '
      '   AUTORIZACIONES_VIAJE.persona p2'
      'on'
      '    p2.id = au.autorizante_2'
      'where '
      '    au.id = :pau')
    Left = 224
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pau'
        Value = nil
      end>
  end
  object ospAutorizacionesMenores: TOraStoredProc
    StoredProcName = 'AUTORIZACIONES_VIAJE.PR_OBTENER_AUTORIZACION_MENOR'
    Session = osConeccion
    Left = 224
    Top = 144
  end
end
