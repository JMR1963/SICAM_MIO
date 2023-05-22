object DtMdl: TDtMdl
  Height = 254
  Width = 349
  object FuncsIBDtbs: TIBDatabase
    Params.Strings = (
      'lc_ctype=WIN1251'
      'password=r4m24'
      'user_name=ACTUALIZADOR'
      'sql_dialect=1')
    LoginPrompt = False
    ServerType = 'IBServer'
    SQLDialect = 1
    Left = 52
    Top = 8
  end
  object UpdateFileIBStdPrc: TIBStoredProc
    Database = FuncsIBDtbs
    Transaction = TRNAll
    StoredProcName = 'UPDARCHIVOSPROCESADOS'
    Left = 52
    Top = 112
  end
  object ListFileIBStdPrc: TIBStoredProc
    Database = FuncsIBDtbs
    Transaction = TRNAll
    StoredProcName = 'CLTULTIMOPROCESADO'
    Left = 52
    Top = 60
    ParamData = <
      item
        DataType = ftString
        Name = 'ULTIMOPROCESADO'
        ParamType = ptOutput
      end>
  end
  object AllTablesIBQry: TIBQuery
    Database = FuncsIBDtbs
    Transaction = TRNAll
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 208
    Top = 68
  end
  object TRNAll: TIBTransaction
    DefaultDatabase = FuncsIBDtbs
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 124
    Top = 8
  end
  object InsertFileIBStdPrc: TIBStoredProc
    Database = FuncsIBDtbs
    Transaction = TRNAll
    StoredProcName = 'INSARCHIVOPROCESADO'
    Left = 56
    Top = 160
  end
end
