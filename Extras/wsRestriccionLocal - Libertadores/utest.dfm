object Form1: TForm1
  Left = 191
  Top = 133
  Width = 554
  Height = 380
  Caption = 'TEST WSRestriccion'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 52
    Top = 26
    Width = 57
    Height = 16
    Caption = 'Apellidos'
  end
  object Label3: TLabel
    Left = 53
    Top = 59
    Width = 56
    Height = 16
    Caption = 'Nombres'
  end
  object Label5: TLabel
    Left = 58
    Top = 89
    Width = 54
    Height = 16
    Caption = 'Nro DOC'
  end
  object Label6: TLabel
    Left = 71
    Top = 121
    Width = 41
    Height = 16
    Caption = 'Libreta'
  end
  object Label7: TLabel
    Left = 272
    Top = 301
    Width = 143
    Height = 16
    Caption = 'Servidor WSRestriccion'
  end
  object Label8: TLabel
    Left = 46
    Top = 158
    Width = 69
    Height = 16
    Caption = 'Fecha Nac:'
  end
  object BitBtn1: TBitBtn
    Left = 112
    Top = 208
    Width = 401
    Height = 73
    Caption = 'Buscar'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object Edit1: TEdit
    Left = 424
    Top = 296
    Width = 89
    Height = 24
    TabOrder = 1
    Text = '127.0.0.1'
  end
  object EA1: TEdit
    Left = 120
    Top = 24
    Width = 313
    Height = 24
    CharCase = ecUpperCase
    TabOrder = 2
  end
  object EN1: TEdit
    Left = 120
    Top = 55
    Width = 313
    Height = 24
    CharCase = ecUpperCase
    TabOrder = 3
  end
  object ED: TEdit
    Left = 120
    Top = 86
    Width = 313
    Height = 24
    CharCase = ecUpperCase
    TabOrder = 4
  end
  object EL: TEdit
    Left = 120
    Top = 117
    Width = 313
    Height = 24
    CharCase = ecUpperCase
    TabOrder = 5
  end
  object DateTimePicker1: TDateTimePicker
    Left = 120
    Top = 157
    Width = 186
    Height = 24
    Date = 41768.513835578710000000
    Time = 41768.513835578710000000
    TabOrder = 6
  end
end
