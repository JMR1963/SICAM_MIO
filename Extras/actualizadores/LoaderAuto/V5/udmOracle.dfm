object dmOracle: TdmOracle
  Height = 295
  Width = 379
  object conOracle: TFDConnection
    Params.Strings = (
      
        'Database=(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = local' +
        'host)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVIC' +
        'E_NAME = SICAM)))'
      'Password=sicam'
      'User_Name=SICAM'
      'DriverID=Ora')
    LoginPrompt = False
    Transaction = trnOracle
    Left = 56
    Top = 24
  end
  object trnOracle: TFDTransaction
    Connection = conOracle
    Left = 128
    Top = 24
  end
  object cmdSql: TFDCommand
    Connection = conOracle
    Transaction = trnOracle
    SchemaName = 'SICAM'
    CommandText.Strings = (
      'UPDATE '
      '  ESTACIONESTRABAJO'
      'SET'
      '  BIOMETRIA = :PBIOMETRIA,'
      '  CARGADIFERIDA = :PCARGADIFERIDA,'
      '  IMPRIMETARJETA = :PIMPRIMETARJETA,'
      '  LETRA = :PLETRA,'
      '  BOXNOMBRE = :PBOXNOMBRE'
      'WHERE '
      '  NOMBREESTACION = :PNOMBREESTACION')
    ParamData = <
      item
        Name = 'PBIOMETRIA'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PCARGADIFERIDA'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PIMPRIMETARJETA'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PLETRA'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PBOXNOMBRE'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PNOMBREESTACION'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 56
    Top = 96
  end
  object spArchivoProcesado: TFDStoredProc
    AutoCalcFields = False
    Connection = conOracle
    SchemaName = 'SICAM'
    PackageName = 'PKGOTROS'
    StoredProcName = 'INSARCHIVOPROCESADO'
    Left = 56
    Top = 155
    ParamData = <
      item
        Position = 1
        Name = 'PNOMBREARCHIVO'
        DataType = ftString
        FDDataType = dtAnsiString
        ParamType = ptInput
        Size = 10
      end
      item
        Position = 2
        Name = 'PFECHA'
        DataType = ftTimeStamp
        FDDataType = dtDateTimeStamp
        NumericScale = 1000
        ParamType = ptInput
      end
      item
        Position = 3
        Name = 'PCORRECTOS'
        DataType = ftFMTBcd
        FDDataType = dtFmtBCD
        Precision = 38
        ParamType = ptInput
      end
      item
        Position = 4
        Name = 'PERRONEOS'
        DataType = ftFMTBcd
        FDDataType = dtFmtBCD
        Precision = 38
        ParamType = ptInput
      end
      item
        Position = 5
        Name = 'PCONFIRMADO'
        DataType = ftFixedChar
        FDDataType = dtAnsiString
        ParamType = ptInput
        Size = 1
      end
      item
        Position = 6
        Name = 'RIDPROCESADO'
        DataType = ftFMTBcd
        FDDataType = dtFmtBCD
        Precision = 38
        ParamType = ptOutput
      end>
  end
  object cw: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 128
    Top = 88
  end
end
