object DMDespachos: TDMDespachos
  OnCreate = DataModuleCreate
  Height = 182
  Width = 339
  object bdMain: TIBDatabase
    Params.Strings = (
      'lc_ctype=WIN1251'
      'password=evangelion'
      'user_name=CLIENTE')
    LoginPrompt = False
    DefaultTransaction = trnMain
    AllowStreamedConnected = False
    Left = 33
    Top = 4
  end
  object trnMain: TIBTransaction
    AllowAutoStart = False
    DefaultDatabase = bdMain
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 120
    Top = 4
  end
  object qryTran: TIBQuery
    Database = bdMain
    Transaction = trnMain
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select RVEHICULOFECHACTIVACION,cast(RVEHICULOPATENTE  as VARCHAR' +
        '(19)) as RVEHICULOPATENTE,RGNANACIONALIDAD,count(DISTINCT RDOCNU' +
        'MERO) as cant'
      'from TRAN_OL_SICAM t1'
      'where RVEHICULOFECHACTIVACION between :FINI and :FFIN'
      
        ' and RTRANSITOESTADODESC = '#39'ACEPTADO'#39' and RTRANSITODIRECCION = '#39 +
        'S'#39' and (RVEHICULOPATENTE is not null) '
      ' AND T1.FECHAREGISTRO ='
      '                (  SELECT MAX (T2.FECHAREGISTRO)'
      '                     FROM TRAN_OL_SICAM T2'
      '                    WHERE     T1.IDLOC = T2.IDLOC'
      '                          AND T1.IDTRANSITO = T2.IDTRANSITO'
      
        '                          AND T1.RTRANSITOFECHA = T2.RTRANSITOFE' +
        'CHA'
      
        '                 GROUP BY T2.IDLOC, T2.IDTRANSITO, T2.RTRANSITOF' +
        'ECHA)'
      
        'group by RVEHICULOFECHACTIVACION,RVEHICULOPATENTE,RGNANACIONALID' +
        'AD'
      'union'
      
        'select DISTINCT FECHAREGISTRO,RDOCNUMERO as RVEHICULOPATENTE,RGN' +
        'ANACIONALIDAD,1 as cant'
      'from TRAN_OL_SICAM'
      
        'where FECHAREGISTRO between :FINI and :FFIN and RTRANSITOESTADOD' +
        'ESC = '#39'ACEPTADO'#39' and RTRANSITODIRECCION = '#39'S'#39' and (RVEHICULOPATE' +
        'NTE is null)'
      'order by 1')
    PrecommittedReads = False
    Left = 208
    Top = 4
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'FINI'
        ParamType = ptUnknown
      end
      item
        DataType = ftDateTime
        Name = 'FFIN'
        ParamType = ptUnknown
      end
      item
        DataType = ftDateTime
        Name = 'FINI'
        ParamType = ptUnknown
      end
      item
        DataType = ftDateTime
        Name = 'FFIN'
        ParamType = ptUnknown
      end>
    object qryTranRVEHICULOFECHACTIVACION: TDateTimeField
      FieldName = 'RVEHICULOFECHACTIVACION'
      ProviderFlags = []
    end
    object qryTranRVEHICULOPATENTE: TIBStringField
      FieldName = 'RVEHICULOPATENTE'
      ProviderFlags = []
      Size = 10
    end
    object qryTranRGNANACIONALIDAD: TIBStringField
      FieldName = 'RGNANACIONALIDAD'
      ProviderFlags = []
      Size = 90
    end
    object qryTranCANT: TIntegerField
      FieldName = 'CANT'
      ProviderFlags = []
    end
  end
  object bdMainNew: TFDConnection
    Params.Strings = (
      'DriverID=Ora')
    Left = 32
    Top = 64
  end
  object trnMainNew: TFDTransaction
    Connection = bdMainNew
    Left = 120
    Top = 64
  end
  object qryTranNew: TFDQuery
    Connection = bdMainNew
    Transaction = trnMainNew
    SQL.Strings = (
      
        'select RVEHICULOFECHACTIVACION,cast(RVEHICULOPATENTE  as VARCHAR' +
        '(19)) as RVEHICULOPATENTE,RGNANACIONALIDAD,count(DISTINCT RDOCNU' +
        'MERO) as cant'
      'from TRAN_OL_SICAM t1'
      'where RVEHICULOFECHACTIVACION between :FINI and :FFIN'
      
        ' and RTRANSITOESTADODESC = '#39'ACEPTADO'#39' and RTRANSITODIRECCION = '#39 +
        'S'#39' and (RVEHICULOPATENTE is not null) '
      ' AND T1.FECHAREGISTRO ='
      '                (  SELECT MAX (T2.FECHAREGISTRO)'
      '                     FROM TRAN_OL_SICAM T2'
      '                    WHERE     T1.IDLOC = T2.IDLOC'
      '                          AND T1.IDTRANSITO = T2.IDTRANSITO'
      
        '                          AND T1.RTRANSITOFECHA = T2.RTRANSITOFE' +
        'CHA'
      
        '                 GROUP BY T2.IDLOC, T2.IDTRANSITO, T2.RTRANSITOF' +
        'ECHA)'
      
        'group by RVEHICULOFECHACTIVACION,RVEHICULOPATENTE,RGNANACIONALID' +
        'AD'
      'union'
      
        'select DISTINCT FECHAREGISTRO,RDOCNUMERO as RVEHICULOPATENTE,RGN' +
        'ANACIONALIDAD,1 as cant'
      'from TRAN_OL_SICAM'
      
        'where FECHAREGISTRO between :FINI and :FFIN and RTRANSITOESTADOD' +
        'ESC = '#39'ACEPTADO'#39' and RTRANSITODIRECCION = '#39'S'#39' and (RVEHICULOPATE' +
        'NTE is null)')
    Left = 208
    Top = 64
    ParamData = <
      item
        Name = 'FINI'
        ParamType = ptInput
      end
      item
        Name = 'FFIN'
        ParamType = ptInput
      end>
  end
end
