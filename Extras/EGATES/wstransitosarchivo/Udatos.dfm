object dmdatos: Tdmdatos
  Height = 271
  Width = 325
  object OraSession1: TOraSession
    Username = 'usuarios'
    AutoCommit = False
    Left = 88
    Top = 24
    EncryptedPassword = '9DFF90FF8DFF90FF92FF96FF8DFFCDFFCBFF'
  end
  object oqFechahora: TOraQuery
    Aggregates = <>
    Session = OraSession1
    SQL.Strings = (
      'select to_char(sysdate, '#39'DDMMYYYY hh24miss'#39') as fecha from dual')
    Left = 96
    Top = 88
  end
  object oqOrganismos_externos: TOraQuery
    Aggregates = <>
    Session = OraSession1
    SQL.Strings = (
      'select'
      '  password'
      'from'
      '  pwd_data.organismos_externos oe'
      'where'
      '  oe.usuario= :puser')
    Left = 96
    Top = 152
    ParamData = <
      item
        DataType = ftString
        Name = 'puser'
        Value = ''
      end>
  end
end
