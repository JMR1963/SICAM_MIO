object dmdatos: Tdmdatos
  Height = 241
  Width = 351
  object OraSession1: TFDConnection
    Params.Strings = (
      'User_Name=usuarios')
    Left = 96
    Top = 16
  end
  object oqFechahora: TFDQuery
    Connection = OraSession1
    SQL.Strings = (
      'select to_char(sysdate, '#39'DDMMYYYY hh24miss'#39') as fecha from dual')
    Left = 96
    Top = 80
  end
  object oqOrganismos_externos: TFDQuery
    Connection = OraSession1
    SQL.Strings = (
      'select'
      '  password'
      'from'
      '  pwd_data.organismos_externos oe'
      'where'
      '  oe.usuario= :puser')
    Left = 96
    Top = 144
    ParamData = <
      item
        Name = 'PUSER'
        ParamType = ptInput
      end>
  end
end
