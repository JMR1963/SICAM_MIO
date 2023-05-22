object dmMenor: TdmMenor
  OnCreate = DataModuleCreate
  Height = 631
  Width = 909
  object OS1: TOraSession
    Username = 'autusr'
    Server = 'NOMINAS'
    HomeName = 'OraHome92'
    Left = 56
    Top = 24
    EncryptedPassword = '8AFF8CFF8DFF9EFF8AFF8BFF'
  end
  object oqGacompaniante: TOraQuery
    Aggregates = <>
    Session = OS1
    Left = 168
    Top = 24
  end
  object oqInsMenor: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      'call AUTORIZACIONES_VIAJE.PR_INSERT_PERSONA '
      
        '( :pid, :papellido, :psegundo_apellido, :pnombre, :potros_nombre' +
        's, :pnacionalidad,'
      
        '  :ptipo_documento, :pemisor_documento, :pnumero_documento, :pfe' +
        'cha_nacimiento, :psexo, :pdomicilio)'
      '')
    Left = 272
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'papellido'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'psegundo_apellido'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pnombre'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'potros_nombres'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pnacionalidad'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ptipo_documento'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pemisor_documento'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pnumero_documento'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pfecha_nacimiento'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'psexo'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pdomicilio'
        Value = nil
      end>
  end
  object oqInsAutorizante: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      'insert into'
      '  autorizaciones_viaje.persona'
      
        '( id, apellido, segundo_apellido, nombre, otros_nombres, naciona' +
        'lidad,'
      
        '  tipo_documento, emisor_documento, numero_documento, fecha_naci' +
        'miento, sexo, domicilio)'
      'value'
      
        '( :pid, :papellido, :psegundo_apellido, :pnombre, :potros_nombre' +
        's, :pnacionalidad,'
      
        '  :ptipo_documento, :pemisor_documento, :pnumero_documento, :pfe' +
        'cha_nacimiento, :psexo, :pdomicilio)'
      '')
    Left = 368
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'papellido'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'psegundo_apellido'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pnombre'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'potros_nombres'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pnacionalidad'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ptipo_documento'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pemisor_documento'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pnumero_documento'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pfecha_nacimiento'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'psexo'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pdomicilio'
        Value = nil
      end>
  end
  object oqInsAutorizante_final: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      'insert into'
      '  autorizaciones_viaje.autorizante'
      '('
      '  ID,'
      '  PERSONA,'
      '  CARACTER,'
      '  VINCULO,'
      '  TELEFONO'
      ')'
      'value'
      '('
      '  :pid,'
      '  :ppersona,'
      '  :pcaracter,'
      '  :pvinculo,'
      '  :ptelefono'
      ')'
      ''
      ''
      '')
    Left = 56
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ppersona'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pcaracter'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pvinculo'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ptelefono'
        Value = nil
      end>
  end
  object oqInsTramite: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      'insert into'
      '  autorizaciones_viaje.tramite'
      '('
      '  ID,'
      '  DISTRITO,'
      '  MATRICULA,'
      '  NOMBRES_ESCRIBANO,'
      '  APELLIDOS_ESCRIBANO,'
      '  NRO_ACTUAC_NOTARIAL_CERT_FIRMA,'
      '  FECHA_DEL_INSTRUMENTO,'
      '  PAISES_TODOS,'
      '  PAISES,'
      '  VIGENCIA'
      ')'
      'value'
      '('
      '  :pID,'
      '  :pDISTRITO,'
      '  :pMATRICULA,'
      '  :pNOMBRES_ESCRIBANO,'
      '  :pAPELLIDOS_ESCRIBANO,'
      '  :pNRO_ACTUAC_NOTARIAL_CERT_FIRMA,'
      '  :pFECHA_DEL_INSTRUMENTO,'
      '  :pPAISES_TODOS,'
      '  :pPAISES,'
      '  :pVIGENCIA'
      ')'
      ''
      ''
      '')
    Left = 168
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pDISTRITO'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pMATRICULA'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pNOMBRES_ESCRIBANO'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pAPELLIDOS_ESCRIBANO'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pNRO_ACTUAC_NOTARIAL_CERT_FIRMA'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pFECHA_DEL_INSTRUMENTO'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pPAISES_TODOS'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pPAISES'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pVIGENCIA'
        Value = nil
      end>
  end
  object oqSecPersona: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      
        'select cast(AUTORIZACIONES_VIAJE.SEQ_PERSONA.nextval as int) as ' +
        'numero from dual')
    Left = 64
    Top = 160
  end
  object oqSecAutorizante: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      
        'select AUTORIZACIONES_VIAJE.SEQ_AUTORIZANTE.nextval as numero fr' +
        'om dual'
      '')
    Left = 168
    Top = 160
  end
  object oqSecautorizacion: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      
        'select AUTORIZACIONES_VIAJE.SEQ_AUTORIZACION.nextval as numero f' +
        'rom dual')
    Left = 264
    Top = 160
  end
  object oqInsProgenitor: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      'insert into'
      '  autorizaciones_viaje.persona'
      
        '( id, apellido, segundo_apellido, nombre, otros_nombres, naciona' +
        'lidad,'
      
        '  tipo_documento, emisor_documento, numero_documento, fecha_naci' +
        'miento, sexo, domicilio)'
      'value'
      
        '( :pid, :papellido, :psegundo_apellido, :pnombre, :potros_nombre' +
        's, :pnacionalidad,'
      
        '  :ptipo_documento, :pemisor_documento, :pnumero_documento, :pfe' +
        'cha_nacimiento, :psexo, :pdomicilio)'
      '')
    Left = 264
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'papellido'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'psegundo_apellido'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pnombre'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'potros_nombres'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pnacionalidad'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ptipo_documento'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pemisor_documento'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pnumero_documento'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pfecha_nacimiento'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'psexo'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pdomicilio'
        Value = nil
      end>
  end
  object oqInsTerceros: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      'insert into'
      '  autorizaciones_viaje.persona'
      
        '( id, apellido, segundo_apellido, nombre, otros_nombres, tipo_do' +
        'cumento, numero_documento)'
      'value'
      
        '( :pid, :papellido, :psegundo_apellido, :pnombre, :potros_nombre' +
        's, :ptipo_documento, :pnumero_documento)'
      '')
    Left = 368
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'papellido'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'psegundo_apellido'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pnombre'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'potros_nombres'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ptipo_documento'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pnumero_documento'
        Value = nil
      end>
  end
  object oqSecAcompaniantes: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      
        'select AUTORIZACIONES_VIAJE.SEQ_ACOMPANIANTES.nextval as numero ' +
        'from dual')
    Left = 368
    Top = 160
  end
  object oqGuardarAcompaniante: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      'insert into'
      '  autorizaciones_viaje.acompaniante'
      '(id, progenitor, acompaniantes)'
      'values'
      '(:pid, :pprogenitor, :pacompaniantes)'
      '')
    Left = 480
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pprogenitor'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pacompaniantes'
        Value = nil
      end>
  end
  object ospInsMenor: TOraStoredProc
    StoredProcName = 'AUTORIZACIONES_VIAJE.PR_INSERT_PERSONA'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  AUTORIZACIONES_VIAJE.PR_INSERT_PERSONA(:P_ID, :P_APELLIDO, :P_' +
        'SEGUNDO_APELLIDO, :P_NOMBRE, :P_OTROS_NOMBRES, :P_NACIONALIDAD, ' +
        ':P_TIPO_DOCUMENTO, :P_EMISOR_DOCUMENTO, :P_NUMERO_DOCUMENTO, :P_' +
        'FECHA_NACIMIENTO, :P_SEXO, :P_DOMICILIO);'
      'end;')
    Left = 56
    Top = 224
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_ID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_APELLIDO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SEGUNDO_APELLIDO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NOMBRE'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_OTROS_NOMBRES'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_NACIONALIDAD'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_TIPO_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_EMISOR_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NUMERO_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_FECHA_NACIMIENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SEXO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_DOMICILIO'
        ParamType = ptInput
        Value = nil
      end>
  end
  object ospInsAutorizante: TOraStoredProc
    StoredProcName = 'AUTORIZACIONES_VIAJE.PR_INSERT_AUTORIZANTE'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  AUTORIZACIONES_VIAJE.PR_INSERT_AUTORIZANTE(:P_ID, :P_PERSONA, ' +
        ':P_CARACTER, :P_VINCULO, :P_TELEFONO);'
      'end;')
    Left = 168
    Top = 224
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_ID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_PERSONA'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_CARACTER'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_VINCULO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_TELEFONO'
        ParamType = ptInput
        Value = nil
      end>
  end
  object ospInsProgenitor: TOraStoredProc
    StoredProcName = 'AUTORIZACIONES_VIAJE.PR_INSERT_PERSONA'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  AUTORIZACIONES_VIAJE.PR_INSERT_PERSONA(:P_ID, :P_APELLIDO, :P_' +
        'SEGUNDO_APELLIDO, :P_NOMBRE, :P_OTROS_NOMBRES, :P_NACIONALIDAD, ' +
        ':P_TIPO_DOCUMENTO, :P_EMISOR_DOCUMENTO, :P_NUMERO_DOCUMENTO, :P_' +
        'FECHA_NACIMIENTO, :P_SEXO, :P_DOMICILIO);'
      'end;')
    Left = 272
    Top = 224
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_ID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_APELLIDO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SEGUNDO_APELLIDO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NOMBRE'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_OTROS_NOMBRES'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_NACIONALIDAD'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_TIPO_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_EMISOR_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NUMERO_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_FECHA_NACIMIENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SEXO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_DOMICILIO'
        ParamType = ptInput
        Value = nil
      end>
  end
  object ospInsPersona: TOraStoredProc
    StoredProcName = 'AUTORIZACIONES_VIAJE.PR_INSERT_PERSONA'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  AUTORIZACIONES_VIAJE.PR_INSERT_PERSONA(:P_ID, :P_APELLIDO, :P_' +
        'SEGUNDO_APELLIDO, :P_NOMBRE, :P_OTROS_NOMBRES, :P_NACIONALIDAD, ' +
        ':P_TIPO_DOCUMENTO, :P_EMISOR_DOCUMENTO, :P_NUMERO_DOCUMENTO, :P_' +
        'FECHA_NACIMIENTO, :P_SEXO, :P_DOMICILIO);'
      'end;')
    Left = 368
    Top = 224
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_ID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_APELLIDO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SEGUNDO_APELLIDO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NOMBRE'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_OTROS_NOMBRES'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_NACIONALIDAD'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_TIPO_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_EMISOR_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NUMERO_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_FECHA_NACIMIENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SEXO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_DOMICILIO'
        ParamType = ptInput
        Value = nil
      end>
  end
  object ospInsAcompanante: TOraStoredProc
    StoredProcName = 'AUTORIZACIONES_VIAJE.PR_INSERT_ACOMPANIANTE'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  AUTORIZACIONES_VIAJE.PR_INSERT_ACOMPANIANTE(:P_ID, :P_PROGENIT' +
        'OR, :P_ACOMPANIANTES);'
      'end;')
    Left = 472
    Top = 224
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_ID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_PROGENITOR'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_ACOMPANIANTES'
        ParamType = ptInput
        Value = nil
      end>
  end
  object ospInsTramite: TOraStoredProc
    StoredProcName = 'AUTORIZACIONES_VIAJE.PR_INSERT_TRAMITE'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  AUTORIZACIONES_VIAJE.PR_INSERT_TRAMITE(:P_ID, :P_DISTRITO, :P_' +
        'MATRICULA, :P_NOMBRES_ESCRIBANO, :P_APELLIDOS_ESCRIBANO, :P_NRO_' +
        'ACTUAC_NOTARIAL_CERT_FIR, :P_FECHA_DEL_INSTRUMENTO, :P_PAISES_TO' +
        'DOS, :P_PAISES, :P_VIGENCIA_DESDE, :P_VIGENCIA_HASTA, :P_VIGENCI' +
        'A_HASTA_MAYORIA_EDAD, :P_SERIE_FOJA, :P_TIPO_FOJA, :P_INSTRUMENT' +
        'O, :P_NRO_FOJA);'
      'end;')
    Left = 56
    Top = 320
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_ID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_DISTRITO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_MATRICULA'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NOMBRES_ESCRIBANO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_APELLIDOS_ESCRIBANO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NRO_ACTUAC_NOTARIAL_CERT_FIR'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_FECHA_DEL_INSTRUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_PAISES_TODOS'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_PAISES'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_VIGENCIA_DESDE'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_VIGENCIA_HASTA'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_VIGENCIA_HASTA_MAYORIA_EDAD'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SERIE_FOJA'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_TIPO_FOJA'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_INSTRUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NRO_FOJA'
        ParamType = ptInput
        Value = nil
      end>
  end
  object ospInsAutorizacion: TOraStoredProc
    StoredProcName = 'AUTORIZACIONES_VIAJE.PR_INSERT_AUTORIZACION'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  AUTORIZACIONES_VIAJE.PR_INSERT_AUTORIZACION(:P_ID, :P_MENOR, :' +
        'P_AUTORIZANTE_1, :P_AUTORIZANTE_2, :P_ACOMPANIANTE, :P_TRAMITE);'
      'end;')
    Left = 168
    Top = 320
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_ID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_MENOR'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_AUTORIZANTE_1'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_AUTORIZANTE_2'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_ACOMPANIANTE'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_TRAMITE'
        ParamType = ptInput
        Value = nil
      end>
  end
  object ospInsProgenitores: TOraStoredProc
    StoredProcName = 'autorizaciones_viaje.PR_INSERT_PROGENITORES'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  autorizaciones_viaje.PR_INSERT_PROGENITORES(:P_ID, :P_TRAMITE,' +
        ' :P_PROGENITOR);'
      'end;')
    Left = 56
    Top = 400
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_ID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_TRAMITE'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_PROGENITOR'
        ParamType = ptInput
        Value = nil
      end>
  end
  object oqSecProgenitores: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      
        'select cast(AUTORIZACIONES_VIAJE.SEQ_progenitores.nextval as int' +
        ') as numero from dual')
    Left = 176
    Top = 400
  end
  object oqSecTerceros: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      
        'select cast(AUTORIZACIONES_VIAJE.SEQ_terceros.nextval as int) as' +
        ' numero from dual')
    Left = 280
    Top = 400
  end
  object ospInsTerceros: TOraStoredProc
    StoredProcName = 'autorizaciones_viaje.PR_INSERT_TERCEROS'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  autorizaciones_viaje.PR_INSERT_TERCEROS(:P_ID, :P_TRAMITE, :P_' +
        'TERCERO);'
      'end;')
    Left = 400
    Top = 400
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_ID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_TRAMITE'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_TERCERO'
        ParamType = ptInput
        Value = nil
      end>
  end
  object oqTipoDoc: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      'SELECT codigo, descripcion, codigo_dnm'
      '    FROM catalogos.cat_tipo_documento'
      '   WHERE control = '#39't'#39' AND flag = '#39't'#39' and codigo = :pcodigo'
      '')
    Left = 272
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pcodigo'
        Value = nil
      end>
  end
  object oqNacionalidad: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      'SELECT'
      '  codigo, descripcion, nacionalidad, codigo_dnm'
      'FROM'
      '  CATALOGOS.CAT_PAISes'
      'WHERE'
      '  flag = '#39't'#39'  and'
      '  codigo = :pnac'
      '')
    Left = 352
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pnac'
        Value = nil
      end>
  end
  object oqEmisor: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      'SELECT'
      '  codigo, descripcion, nacionalidad'
      'FROM'
      '  CATALOGOS.CAT_PAISes'
      'WHERE'
      '  flag = '#39't'#39' and'
      '  codigo = :pemi'
      '')
    Left = 432
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pemi'
        Value = nil
      end>
  end
  object ospInsRevocaciones: TOraStoredProc
    StoredProcName = 'autorizaciones_viaje.PR_INSERT_REVOCACIONES'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  autorizaciones_viaje.PR_INSERT_REVOCACIONES(:P_DNI, :P_FECHA, ' +
        ':P_MATRICULA);'
      'end;')
    Left = 56
    Top = 472
    ParamData = <
      item
        DataType = ftString
        Name = 'P_DNI'
        ParamType = ptInput
        Size = 100
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_FECHA'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_MATRICULA'
        ParamType = ptInput
        Size = 100
        Value = nil
      end>
  end
  object oqPersonasRevocadas: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      'select'
      '    *'
      'from'
      '    autorizaciones_viaje.persona ap'
      'inner join'
      '    AUTORIZACIONES_VIAJE.AUTORIZACION au'
      'on'
      '    au.menor = ap.id'
      'inner join'
      '  AUTORIZACIONES_VIAJE.tramite tra'
      'on'
      '  tra.id = au.id'
      'where'
      '  AP.NUMERO_DOCUMENTO = :pnumero_documento and'
      
        '  to_date(tra.fecha_del_instrumento, '#39'DD/MM/YYYY'#39') < to_date(:pf' +
        'echa_revocacion, '#39'DDMMYYYY'#39') and'
      '  ap.revocado is null'
      ''
      ''
      ' '
      '')
    Left = 176
    Top = 472
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pnumero_documento'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pfecha_revocacion'
        Value = nil
      end>
  end
  object oqMarcarRevocados: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      'update'
      '    autorizaciones_viaje.persona pe'
      'set'
      '    revocado = '#39't'#39','
      '    fecha_revocado = TO_DATE(:p_fecha,'#39'DDMMYYYY'#39'),'
      '    usuario_revocado = :p_usuario'
      'where'
      '   pe.id = :p_id')
    Left = 288
    Top = 472
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'p_fecha'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'p_usuario'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'p_id'
        Value = nil
      end>
  end
  object ospMarcarRevocados: TOraStoredProc
    StoredProcName = 'autorizaciones_viaje.PR_REVOCAR_PERSONA'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  autorizaciones_viaje.PR_REVOCAR_PERSONA(:P_ID, :P_FECHA, :P_US' +
        'UARIO_REVOCADO);'
      'end;')
    Left = 408
    Top = 472
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_ID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_FECHA'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_USUARIO_REVOCADO'
        ParamType = ptInput
        Value = nil
      end>
  end
  object ospActualizarMenor: TOraStoredProc
    StoredProcName = 'autorizaciones_viaje.PR_UPDATE_PERSONA'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  autorizaciones_viaje.PR_UPDATE_PERSONA(:P_ID, :P_APELLIDO, :P_' +
        'SEGUNDO_APELLIDO, :P_NOMBRE, :P_OTROS_NOMBRES, :P_NACIONALIDAD, ' +
        ':P_TIPO_DOCUMENTO, :P_EMISOR_DOCUMENTO, :P_NUMERO_DOCUMENTO, :P_' +
        'FECHA_NACIMIENTO, :P_SEXO, :P_DOMICILIO);'
      'end;')
    Left = 688
    Top = 40
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_ID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_APELLIDO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SEGUNDO_APELLIDO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NOMBRE'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_OTROS_NOMBRES'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_NACIONALIDAD'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_TIPO_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_EMISOR_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NUMERO_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_FECHA_NACIMIENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SEXO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_DOMICILIO'
        ParamType = ptInput
        Value = nil
      end>
  end
  object ospActualizarAutorizante: TOraStoredProc
    StoredProcName = 'autorizaciones_viaje.PR_UPDATE_AUTORIZANTE'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  autorizaciones_viaje.PR_UPDATE_AUTORIZANTE(:P_ID, :P_PERSONA, ' +
        ':P_CARACTER, :P_VINCULO, :P_TELEFONO);'
      'end;')
    Left = 688
    Top = 120
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_ID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_PERSONA'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_CARACTER'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_VINCULO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_TELEFONO'
        ParamType = ptInput
        Value = nil
      end>
  end
  object ospActualizarPersona: TOraStoredProc
    StoredProcName = 'autorizaciones_viaje.PR_UPDATE_PERSONA'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  autorizaciones_viaje.PR_UPDATE_PERSONA(:P_ID, :P_APELLIDO, :P_' +
        'SEGUNDO_APELLIDO, :P_NOMBRE, :P_OTROS_NOMBRES, :P_NACIONALIDAD, ' +
        ':P_TIPO_DOCUMENTO, :P_EMISOR_DOCUMENTO, :P_NUMERO_DOCUMENTO, :P_' +
        'FECHA_NACIMIENTO, :P_SEXO, :P_DOMICILIO);'
      'end;')
    Left = 688
    Top = 184
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_ID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_APELLIDO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SEGUNDO_APELLIDO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NOMBRE'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_OTROS_NOMBRES'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_NACIONALIDAD'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_TIPO_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_EMISOR_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NUMERO_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_FECHA_NACIMIENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SEXO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_DOMICILIO'
        ParamType = ptInput
        Value = nil
      end>
  end
  object ospActualizarProgenitor: TOraStoredProc
    StoredProcName = 'autorizaciones_viaje.PR_UPDATE_PERSONA'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  autorizaciones_viaje.PR_UPDATE_PERSONA(:P_ID, :P_APELLIDO, :P_' +
        'SEGUNDO_APELLIDO, :P_NOMBRE, :P_OTROS_NOMBRES, :P_NACIONALIDAD, ' +
        ':P_TIPO_DOCUMENTO, :P_EMISOR_DOCUMENTO, :P_NUMERO_DOCUMENTO, :P_' +
        'FECHA_NACIMIENTO, :P_SEXO, :P_DOMICILIO);'
      'end;')
    Left = 688
    Top = 248
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_ID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_APELLIDO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SEGUNDO_APELLIDO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NOMBRE'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_OTROS_NOMBRES'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_NACIONALIDAD'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_TIPO_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_EMISOR_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NUMERO_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_FECHA_NACIMIENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SEXO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_DOMICILIO'
        ParamType = ptInput
        Value = nil
      end>
  end
  object ospActualizarTramite: TOraStoredProc
    StoredProcName = 'autorizaciones_viaje.PR_UPDATE_TRAMITE'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  autorizaciones_viaje.PR_UPDATE_TRAMITE(:P_ID, :P_DISTRITO, :P_' +
        'MATRICULA, :P_NOMBRES_ESCRIBANO, :P_APELLIDOS_ESCRIBANO, :P_NRO_' +
        'ACTUAC_NOTARIAL_CERT_FIR, :P_FECHA_DEL_INSTRUMENTO, :P_PAISES_TO' +
        'DOS, :P_PAISES, :P_VIGENCIA_DESDE, :P_VIGENCIA_HASTA, :P_VIGENCI' +
        'A_HASTA_MAYORIA_EDAD, :P_SERIE_FOJA, :P_TIPO_FOJA);'
      'end;')
    Left = 688
    Top = 320
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_ID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_DISTRITO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_MATRICULA'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NOMBRES_ESCRIBANO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_APELLIDOS_ESCRIBANO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NRO_ACTUAC_NOTARIAL_CERT_FIR'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_FECHA_DEL_INSTRUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_PAISES_TODOS'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_PAISES'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_VIGENCIA_DESDE'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_VIGENCIA_HASTA'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_VIGENCIA_HASTA_MAYORIA_EDAD'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SERIE_FOJA'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_TIPO_FOJA'
        ParamType = ptInput
        Value = nil
      end>
  end
  object ospActualizarAutorizacion: TOraStoredProc
    StoredProcName = 'autorizaciones_viaje.PR_UPDATE_AUTORIZACION'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  autorizaciones_viaje.PR_UPDATE_AUTORIZACION(:P_ID, :P_MENOR, :' +
        'P_AUTORIZANTE_1, :P_AUTORIZANTE_2, :P_ACOMPANIANTE, :P_TRAMITE);'
      'end;')
    Left = 688
    Top = 392
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_ID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_MENOR'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_AUTORIZANTE_1'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_AUTORIZANTE_2'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_ACOMPANIANTE'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_TRAMITE'
        ParamType = ptInput
        Value = nil
      end>
  end
  object oqIds: TOraQuery
    Aggregates = <>
    Session = OS1
    SQL.Strings = (
      'select '
      '    au.id, '
      '    autorizante_1, '
      '    autorizante_2,'
      '    au.menor'
      'from '
      '    autorizaciones_viaje.tramite tr'
      'inner join '
      '    autorizaciones_viaje.autorizacion au'
      'on '
      '    tr.id = au.id'
      'where'
      '    tr.id = :pid')
    Left = 688
    Top = 456
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pid'
        Value = nil
      end>
  end
  object ospBajaProjenitores: TOraStoredProc
    StoredProcName = 'autorizaciones_viaje.PR_BAJA_PROGENITORES'
    Session = OS1
    SQL.Strings = (
      'begin'
      '  autorizaciones_viaje.PR_BAJA_PROGENITORES(:P_TRAMITE);'
      'end;')
    Left = 800
    Top = 40
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_TRAMITE'
        ParamType = ptInput
        Value = nil
      end>
  end
  object ospBajaTerceros: TOraStoredProc
    StoredProcName = 'autorizaciones_viaje.PR_BAJA_TERCEROS'
    Session = OS1
    SQL.Strings = (
      'begin'
      '  autorizaciones_viaje.PR_BAJA_TERCEROS(:P_TRAMITE);'
      'end;')
    Left = 800
    Top = 112
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_TRAMITE'
        ParamType = ptInput
        Value = nil
      end>
  end
  object ospInsertRevocacionSiger: TOraStoredProc
    StoredProcName = 'siger.PR_INSERT_R_AUT'
    Session = OS1
    SQL.Strings = (
      'begin'
      
        '  siger.PR_INSERT_R_AUT(:P_APE1, :P_APE2, :P_NOM1, :P_NOM2, :P_N' +
        'UMERO_DOC, :P_FECHA, :P_NUMERO_MATRICULA, :P_NUMERO_ACT_NOTARIAL' +
        ', :P_TIPO_DOCUMENTO, :P_NACIONALIDAD_DOCUMENTO, :P_NACIONALIDAD,' +
        ' :P_FEC_NAC, :P_SEXO, :P_ENTIDAD_EMISORA, :P_OBSERVACIONES);'
      'end;')
    Left = 552
    Top = 464
    ParamData = <
      item
        DataType = ftString
        Name = 'P_APE1'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_APE2'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NOM1'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NOM2'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NUMERO_DOC'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_FECHA'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NUMERO_MATRICULA'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NUMERO_ACT_NOTARIAL'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_TIPO_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NACIONALIDAD_DOCUMENTO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_NACIONALIDAD'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_FEC_NAC'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_SEXO'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'P_ENTIDAD_EMISORA'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'P_OBSERVACIONES'
        ParamType = ptInput
        Value = nil
      end>
  end
end
