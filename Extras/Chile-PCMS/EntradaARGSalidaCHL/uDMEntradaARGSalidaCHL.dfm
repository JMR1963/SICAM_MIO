object DMSem: TDMSem
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 164
  Top = 145
  Height = 308
  Width = 453
  object bdMain: TIBDatabase
    DatabaseName = '172.16.192.151:c:\basedatos\anselmo\sicam.gdb'
    Params.Strings = (
      'lc_ctype=WIN1251'
      'password=evangelion'
      'user_name=CLIENTE')
    LoginPrompt = False
    DefaultTransaction = trnMain
    AllowStreamedConnected = False
    Left = 113
    Top = 44
  end
  object trnMain: TIBTransaction
    AllowAutoStart = False
    DefaultDatabase = bdMain
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 192
    Top = 12
  end
  object qryValidate: TIBQuery
    Database = bdMain
    Transaction = trnMain
    SQL.Strings = (
      'SELECT'
      ' CLAVESISTEMA, IDUSUARIOSESTADOS'
      'FROM'
      ' USUARIOS'
      'WHERE'
      ' IDUSUARIOSTIPOS = 1 AND '
      ' USUARIOSISTEMA = :PNOMBREUSUARIO AND'
      ' IDPASOSFRONTERIZOS = :PIDPASO;')
    Left = 176
    Top = 92
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PNOMBREUSUARIO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PIDPASO'
        ParamType = ptUnknown
      end>
  end
  object tblArch: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    ObjectView = False
    Params = <>
    StoreDefs = True
    Left = 312
    Top = 72
    object tblArcharchivo: TStringField
      DisplayWidth = 50
      FieldName = 'archivo'
      Size = 50
    end
    object tblArchcont: TIntegerField
      DisplayWidth = 10
      FieldName = 'cont'
    end
    object tblArchFECHA_HORA: TStringField
      FieldName = 'FECHA_HORA'
    end
    object tblArchFuncionario: TStringField
      FieldName = 'Funcionario'
      Size = 15
    end
    object tblArchObservacion: TStringField
      FieldName = 'Observacion'
      Size = 120
    end
    object tblArchNumeroDocumento: TStringField
      FieldName = 'NumeroDocumento'
      Size = 10
    end
    object tblArchCodigoPaisEmisor: TStringField
      FieldName = 'CodigoPaisEmisor'
      Size = 10
    end
    object tblArchFlag: TBooleanField
      FieldName = 'Flag'
    end
  end
end
