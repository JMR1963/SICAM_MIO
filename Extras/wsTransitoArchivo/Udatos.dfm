object dmdatos: Tdmdatos
  Height = 241
  Width = 351
  object OraSession1: TFDConnection
    Left = 64
    Top = 16
  end
  object oqFechahora: TFDQuery
    Connection = OraSession1
    Left = 64
    Top = 88
  end
  object oqOrganismos_externos: TFDQuery
    Connection = OraSession1
    Left = 64
    Top = 160
  end
end
