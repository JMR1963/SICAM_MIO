object DMBaseIB: TDMBaseIB
  OnCreate = DataModuleCreate
  Height = 470
  Width = 831
  object bdMain: TIBDatabase
    DatabaseName = '172.16.192.151:c:\base puertas\gate.gdb'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=gl4dy5')
    LoginPrompt = False
    DefaultTransaction = trnMain
    ServerType = 'IBServer'
    AllowStreamedConnected = False
    Left = 376
    Top = 16
  end
  object trnMain: TIBTransaction
    AllowAutoStart = False
    DefaultDatabase = bdMain
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 376
    Top = 80
  end
  object qry_PERSON_DATA: TIBQuery
    Database = bdMain
    Transaction = trnMain
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 592
    Top = 272
  end
  object SPINSTRANSACTION: TIBStoredProc
    Database = bdMain
    Transaction = trnMain
    StoredProcName = 'INSTRANSACTION'
    Left = 752
    Top = 16
    ParamData = <
      item
        DataType = ftWideString
        Name = 'PIDTRAN'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'PEGATE'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'PSENTIDO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PIDGATE_LOG'
        ParamType = ptInput
      end>
  end
  object qryI_PERSON_DATA: TIBQuery
    Database = bdMain
    Transaction = trnMain
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      ''
      
        'INSERT INTO PERSON_DATA (TRANSACTIONID, DOC_TIPO, DOC_SUBTIPO, D' +
        'OC_NUMERO, NOMBRE, APELLIDO, ISSUING_COUNTRY, NACIONALIDAD, PASA' +
        'PORTE, SEXO, TRANSPORTE, TIPO_PASAJERO, POSEE_IMPEDIMENTO,FECHA_' +
        'NAC,FACE_SCORE,DACTILAR_SCORE,FECHA_EXPIRACION,MRZ) VALUES'
      
        ' (:TRANSACTIONID, :DOC_TIPO, :DOC_SUBTIPO, :DOC_NUMERO, :NOMBRE,' +
        ' :APELLIDO, :ISSUING_COUNTRY, :NACIONALIDAD, :PASAPORTE, :SEXO, ' +
        ':TRANSPORTE, :TIPO_PASAJERO, :POSEE_IMPEDIMENTO,:FECHA_NAC,0,0,:' +
        'FECHA_EXPIRACION,:MRZ);')
    PrecommittedReads = False
    Left = 584
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TRANSACTIONID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DOC_TIPO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DOC_SUBTIPO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DOC_NUMERO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NOMBRE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'APELLIDO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ISSUING_COUNTRY'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NACIONALIDAD'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PASAPORTE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SEXO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRANSPORTE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TIPO_PASAJERO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'POSEE_IMPEDIMENTO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FECHA_NAC'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FECHA_EXPIRACION'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MRZ'
        ParamType = ptUnknown
      end>
  end
  object SPINSTRANRESULT: TIBStoredProc
    Database = bdMain
    Transaction = trnMain
    StoredProcName = 'INSTRANRESULT'
    Left = 752
    Top = 128
    ParamData = <
      item
        DataType = ftInteger
        Name = 'RIDTRANRES'
        ParamType = ptOutput
      end
      item
        DataType = ftWideString
        Name = 'PTRANSACTIONID'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PERROR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PRESCODE'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'PSTATUS'
        ParamType = ptInput
      end>
  end
  object qryRestricciones: TIBQuery
    Database = bdMain
    Transaction = trnMain
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'update PERSON_DATA'
      'set  TRANSPORTE =:TRANSPORTE,'
      '       TIPO_PASAJERO =:TIPO_PASAJERO,'
      '       POSEE_IMPEDIMENTO =:POSEE_IMPEDIMENTO'
      'where TRANSACTIONID = :TRANSACTIONID')
    PrecommittedReads = False
    Left = 592
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TRANSPORTE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TIPO_PASAJERO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'POSEE_IMPEDIMENTO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRANSACTIONID'
        ParamType = ptUnknown
      end>
  end
  object qryI_TRANSACTION_CLOSURE: TIBQuery
    Database = bdMain
    Transaction = trnMain
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      ''
      
        'INSERT INTO TRANSACTION_CLOSURE (TRANSACTIONID, MANUAL_OPENED, E' +
        'LEGIBILIDAD) VALUES '
      '(:TRANSACTIONID, :MANUAL_OPENED, :ELEGIBILIDAD);')
    PrecommittedReads = False
    Left = 592
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TRANSACTIONID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MANUAL_OPENED'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ELEGIBILIDAD'
        ParamType = ptUnknown
      end>
  end
  object qryFACE_SCORE: TIBQuery
    Database = bdMain
    Transaction = trnMain
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 592
    Top = 80
  end
  object qryDACTILAR_SCORE: TIBQuery
    Database = bdMain
    Transaction = trnMain
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 464
    Top = 272
  end
  object ibtblConfiguracion: TIBTable
    Database = bdMain
    Transaction = trnMain
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'CONFIGURACION'
    PrecommittedReads = False
    UniDirectional = False
    Left = 752
    Top = 184
    object ibtblConfiguracionID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object ibtblConfiguracionCLAVE: TIBStringField
      FieldName = 'CLAVE'
      Size = 50
    end
    object ibtblConfiguracionVALOR: TIBStringField
      FieldName = 'VALOR'
      Size = 200
    end
    object ibtblConfiguracionNOTAS: TIBStringField
      FieldName = 'NOTAS'
      Size = 250
    end
  end
  object qry_IDLOC: TIBQuery
    Database = bdMain
    Transaction = trnMain
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 464
    Top = 208
  end
  object qry1: TIBQuery
    Database = bdMain
    Transaction = trnMain
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 464
    Top = 16
  end
  object qry2: TIBQuery
    Database = bdMain
    Transaction = trnMain
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 464
    Top = 80
  end
  object SPINSEVENTO: TIBStoredProc
    Database = bdMain
    Transaction = trnMain
    StoredProcName = 'INSEVENTO'
    Left = 752
    Top = 72
    ParamData = <
      item
        DataType = ftInteger
        Name = 'RIDEVENT'
        ParamType = ptOutput
      end
      item
        DataType = ftWideString
        Name = 'PTRANSACTIONID'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PEVENTTYPE'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'PFECHA'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'PEVENTDESC'
        ParamType = ptInput
      end>
  end
  object qry3: TIBQuery
    Database = bdMain
    Transaction = trnMain
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 464
    Top = 144
  end
  object qryPersonFlight: TIBQuery
    Database = bdMain
    Transaction = trnMain
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 592
    Top = 144
  end
  object qry_INS_MANIFIESTO: TIBQuery
    Database = bdMain
    Transaction = trnMain
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      ''
      'INSERT INTO MANIFIESTOS (TRANSACTIONID, NOMBRE) '
      'VALUES (:TRANSACTIONID, :NOMBRE);')
    PrecommittedReads = False
    Left = 464
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TRANSACTIONID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NOMBRE'
        ParamType = ptUnknown
      end>
  end
  object bdMain_: TFDConnection
    Left = 32
    Top = 8
  end
  object trmMain_: TFDTransaction
    Connection = bdMain_
    Left = 32
    Top = 64
  end
  object qry1_: TFDQuery
    Connection = bdMain_
    Transaction = trmMain_
    Left = 136
    Top = 8
  end
  object qry2_: TFDQuery
    Connection = bdMain_
    Transaction = trmMain_
    Left = 136
    Top = 64
  end
  object qry3_: TFDQuery
    Connection = bdMain_
    Transaction = trmMain_
    Left = 136
    Top = 120
  end
  object qry_IDLOC_: TFDQuery
    Connection = bdMain_
    Transaction = trmMain_
    Left = 136
    Top = 176
  end
  object qryDACTILAR_SCORE_: TFDQuery
    Connection = bdMain_
    Transaction = trmMain_
    Left = 136
    Top = 232
  end
  object qryFACE_SCORE_: TFDQuery
    Connection = bdMain_
    Transaction = trmMain_
    Left = 136
    Top = 400
  end
  object qryPersonFlight_: TFDQuery
    Connection = bdMain_
    Transaction = trmMain_
    Left = 272
    Top = 8
  end
  object qry_INS_MANIFIESTO_: TFDCommand
    Connection = bdMain_
    Transaction = trmMain_
    CommandText.Strings = (
      'INSERT INTO MANIFIESTOS (TRANSACTIONID, NOMBRE) '
      'VALUES (:TRANSACTIONID, :NOMBRE);')
    ParamData = <
      item
        Name = 'TRANSACTIONID'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
      end
      item
        Name = 'NOMBRE'
        DataType = ftString
        FDDataType = dtWideString
        ParamType = ptInput
      end>
    Left = 136
    Top = 288
  end
  object qryI_TRANSACTION_CLOSURE_: TFDCommand
    Connection = bdMain_
    Transaction = trmMain_
    CommandText.Strings = (
      
        'INSERT INTO TRANSACTION_CLOSURE (TRANSACTIONID, MANUAL_OPENED, E' +
        'LEGIBILIDAD) VALUES '
      '(:TRANSACTIONID, :MANUAL_OPENED, :ELEGIBILIDAD)')
    ParamData = <
      item
        Name = 'TRANSACTIONID'
        ParamType = ptInput
      end
      item
        Name = 'MANUAL_OPENED'
        ParamType = ptInput
      end
      item
        Name = 'ELEGIBILIDAD'
        ParamType = ptInput
      end>
    Left = 136
    Top = 344
  end
  object qryRestricciones_: TFDCommand
    Connection = bdMain_
    Transaction = trmMain_
    CommandText.Strings = (
      'update PERSON_DATA'
      'set  TRANSPORTE =:TRANSPORTE,'
      '       TIPO_PASAJERO =:TIPO_PASAJERO,'
      '       POSEE_IMPEDIMENTO =:POSEE_IMPEDIMENTO'
      'where TRANSACTIONID = :TRANSACTIONID')
    ParamData = <
      item
        Name = 'TRANSPORTE'
        DataType = ftString
        FDDataType = dtWideString
        ParamType = ptInput
      end
      item
        Name = 'TIPO_PASAJERO'
        DataType = ftString
        FDDataType = dtAnsiString
        ParamType = ptInput
      end
      item
        Name = 'POSEE_IMPEDIMENTO'
        DataType = ftString
        FDDataType = dtWideString
        ParamType = ptInput
      end
      item
        Name = 'TRANSACTIONID'
        DataType = ftString
        FDDataType = dtAnsiString
        ParamType = ptInput
      end>
    Left = 272
    Top = 64
  end
  object qry_PERSON_DATA_: TFDQuery
    Connection = bdMain_
    Left = 272
    Top = 120
  end
  object qryI_PERSON_DATA_: TFDCommand
    Connection = bdMain_
    Transaction = trmMain_
    CommandText.Strings = (
      
        'INSERT INTO PERSON_DATA (TRANSACTIONID, DOC_TIPO, DOC_SUBTIPO, D' +
        'OC_NUMERO, NOMBRE, APELLIDO, ISSUING_COUNTRY, NACIONALIDAD, PASA' +
        'PORTE, SEXO, TRANSPORTE, TIPO_PASAJERO, '
      
        'POSEE_IMPEDIMENTO,FECHA_NAC,FACE_SCORE,DACTILAR_SCORE,FECHA_EXPI' +
        'RACION,MRZ) '
      
        'VALUES (:TRANSACTIONID, :DOC_TIPO, :DOC_SUBTIPO, :DOC_NUMERO, :N' +
        'OMBRE, :APELLIDO, :ISSUING_COUNTRY, :NACIONALIDAD, :PASAPORTE, :' +
        'SEXO, :TRANSPORTE, :TIPO_PASAJERO, '
      ':POSEE_IMPEDIMENTO,:FECHA_NAC,0,0,:FECHA_EXPIRACION,:MRZ);'
      '')
    ParamData = <
      item
        Name = 'TRANSACTIONID'
        ParamType = ptInput
      end
      item
        Name = 'DOC_TIPO'
        ParamType = ptInput
      end
      item
        Name = 'DOC_SUBTIPO'
        ParamType = ptInput
      end
      item
        Name = 'DOC_NUMERO'
        ParamType = ptInput
      end
      item
        Name = 'NOMBRE'
        ParamType = ptInput
      end
      item
        Name = 'APELLIDO'
        ParamType = ptInput
      end
      item
        Name = 'ISSUING_COUNTRY'
        ParamType = ptInput
      end
      item
        Name = 'NACIONALIDAD'
        ParamType = ptInput
      end
      item
        Name = 'PASAPORTE'
        ParamType = ptInput
      end
      item
        Name = 'SEXO'
        ParamType = ptInput
      end
      item
        Name = 'TRANSPORTE'
        ParamType = ptInput
      end
      item
        Name = 'TIPO_PASAJERO'
        ParamType = ptInput
      end
      item
        Name = 'POSEE_IMPEDIMENTO'
        ParamType = ptInput
      end
      item
        Name = 'FECHA_NAC'
        ParamType = ptInput
      end
      item
        Name = 'FECHA_EXPIRACION'
        ParamType = ptInput
      end
      item
        Name = 'MRZ'
        ParamType = ptInput
      end>
    Left = 272
    Top = 176
  end
  object SPINSTRANSACTION_: TFDStoredProc
    Connection = bdMain_
    Transaction = trmMain_
    StoredProcName = 'INSTRANSACTION'
    Left = 272
    Top = 232
  end
  object INSEVENTO_: TFDStoredProc
    Connection = bdMain_
    Transaction = trmMain_
    StoredProcName = 'INSEVENTO'
    Left = 272
    Top = 288
  end
  object SPINSTRANRESULT_: TFDStoredProc
    Connection = bdMain_
    Transaction = trmMain_
    StoredProcName = 'SPINSTRANRESULT'
    Left = 272
    Top = 344
  end
  object ibtblConfiguracion_: TFDTable
    Connection = bdMain_
    Transaction = trmMain_
    TableName = 'CONFIGURACION'
    Left = 272
    Top = 400
  end
end
