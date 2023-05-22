object DMSem: TDMSem
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 403
  Top = 216
  Height = 308
  Width = 453
  object bdMain: TIBDatabase
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
      
        'select clavesistema, idusuariosestados from usuarios where idusu' +
        'ariostipos in(1,3) and usuariosistema= :PNOMBREUSUARIO and idpas' +
        'osfronterizos= :PIDPASO;')
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
    Left = 72
    Top = 200
    object tblArcharchivo: TStringField
      DisplayWidth = 50
      FieldName = 'archivo'
      Size = 50
    end
    object tblArchcont: TIntegerField
      DisplayWidth = 10
      FieldName = 'cont'
    end
    object tblArchApellidos: TStringField
      FieldName = 'Apellidos'
      Size = 30
    end
    object tblArchNombres: TStringField
      FieldName = 'Nombres'
      Size = 30
    end
    object tblArchFechaNac: TStringField
      FieldName = 'FechaNac'
      Size = 10
    end
    object tblArchNroDOC: TStringField
      FieldName = 'NroDOC'
      Size = 10
    end
    object tblArchNroLibreta: TStringField
      FieldName = 'NroLibreta'
      Size = 10
    end
    object tblArchEMISORDOC: TStringField
      FieldName = 'EMISORDOC'
      Size = 10
    end
    object tblArchFECHA_HORA: TStringField
      FieldName = 'FECHA_HORA'
    end
    object tblArchgenero: TStringField
      FieldName = 'genero'
      Size = 1
    end
    object tblArchtdi: TStringField
      FieldName = 'tdi'
      Size = 5
    end
    object strngfldArchorigen: TStringField
      FieldName = 'origen'
      Size = 3
    end
  end
end
