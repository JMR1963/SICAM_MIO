object FrmLs: TFrmLs
  Left = 247
  Top = 193
  Width = 549
  Height = 464
  Caption = 'Listado'
  Color = 16776176
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 20
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 51
    Height = 20
    Caption = 'SICAM'
  end
  object Label2: TLabel
    Left = 272
    Top = 8
    Width = 48
    Height = 20
    Caption = 'CHILE'
  end
  object Label3: TLabel
    Left = 16
    Top = 368
    Width = 189
    Height = 20
    Caption = '*    PATENTE | PAIS | PAX'
  end
  object lsc: TLabel
    Left = 96
    Top = 8
    Width = 9
    Height = 20
    Caption = '0'
  end
  object lcc: TLabel
    Left = 336
    Top = 8
    Width = 9
    Height = 20
    Caption = '0'
  end
  object BitBtn1: TBitBtn
    Left = 216
    Top = 376
    Width = 97
    Height = 41
    Caption = 'CERRAR'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object ListSICAM: TListBox
    Left = 16
    Top = 32
    Width = 249
    Height = 329
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Terminal'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    Sorted = True
    TabOrder = 1
  end
  object ListCHILE: TListBox
    Left = 272
    Top = 32
    Width = 249
    Height = 329
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Terminal'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    Sorted = True
    TabOrder = 2
  end
end
