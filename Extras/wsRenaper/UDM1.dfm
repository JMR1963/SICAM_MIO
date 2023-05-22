object dm1: Tdm1
  Height = 181
  Width = 330
  object OraSession1: TOraSession
    Left = 56
    Top = 16
  end
  object OraQuery: TOraQuery
    Aggregates = <>
    Session = OraSession1
    Left = 168
    Top = 16
  end
  object OraStoredProc2: TOraStoredProc
    StoredProcName = 'TRAVEL_OWNER.PR_INS_INFO_ADIC_RENAPER'
    Session = OraSession1
    Left = 56
    Top = 80
  end
  object OraStoredProc3: TOraStoredProc
    StoredProcName = 'TRAVEL_OWNER.PR_ACTUALIZAR_CONTADOR_RENAPER'
    Session = OraSession1
    Left = 168
    Top = 80
  end
end
