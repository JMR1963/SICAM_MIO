object DMDatos: TDMDatos
  Height = 180
  Width = 371
  object oraConn: TOraSession
    Left = 64
    Top = 32
  end
  object OraQuery1: TOraQuery
    Aggregates = <>
    Session = oraConn
    Left = 192
    Top = 32
  end
end
