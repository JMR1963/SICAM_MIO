object Form1: TForm1
  Left = 284
  Top = 202
  Width = 614
  Height = 423
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 80
    Top = 16
    Width = 128
    Height = 49
    Caption = 'Interpol Unit'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 264
    Top = 16
    Width = 121
    Height = 49
    Caption = 'consulta arg unit'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 82
    Top = 91
    Width = 128
    Height = 49
    Caption = 'interpol ws'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 266
    Top = 91
    Width = 119
    Height = 49
    Caption = 'Consulta arg ws'
    TabOrder = 3
    OnClick = Button4Click
  end
  object BitBtn1: TBitBtn
    Left = 424
    Top = 16
    Width = 128
    Height = 49
    Caption = 'ws consulta local'
    TabOrder = 4
    OnClick = BitBtn1Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 249
    Width = 606
    Height = 143
    Align = alBottom
    TabOrder = 5
    object lbDesde: TLabel
      Left = 16
      Top = 8
      Width = 31
      Height = 13
      Caption = 'Desde'
    end
    object lbHasta: TLabel
      Left = 144
      Top = 8
      Width = 28
      Height = 13
      Caption = 'Hasta'
    end
    object lbPorProcesar: TLabel
      Left = 16
      Top = 56
      Width = 147
      Height = 29
      Caption = 'Por Procesar:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbVarProcesados: TLabel
      Left = 176
      Top = 57
      Width = 48
      Height = 29
      Caption = #39'-----'#39
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbProcesados: TLabel
      Left = 16
      Top = 96
      Width = 135
      Height = 29
      Caption = 'Procesados:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbVarTotal: TLabel
      Left = 176
      Top = 97
      Width = 48
      Height = 29
      Caption = #39'-----'#39
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnIguazu: TButton
      Left = 320
      Top = 24
      Width = 105
      Height = 25
      Caption = 'Transitos Iguazu'
      TabOrder = 0
      OnClick = btnIguazuClick
    end
    object txtDesde: TSicamMaskEdit
      Left = 16
      Top = 24
      Width = 118
      Height = 21
      Years = 10
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '12/07/2016'
    end
    object txtHasta: TSicamMaskEdit
      Left = 144
      Top = 24
      Width = 118
      Height = 21
      Years = 10
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '13/07/2016'
    end
  end
  object BitBtn2: TBitBtn
    Left = 432
    Top = 88
    Width = 128
    Height = 49
    Caption = 'ws consulta ws'
    TabOrder = 6
    OnClick = Button2Click
  end
  object Conexion: TOraSession
    Username = 'Travel_owner'
    Password = 'tulkas'
    Server = 'bcshq8'
    Left = 280
    Top = 264
  end
  object OTransitos: TOraQuery
    Session = Conexion
    SQL.Strings = (
      'SELECT *'
      '  FROM TRAVEL_OWNER.TRAN_OL_SICAM T'
      ' WHERE T.FECHAREGISTRO BETWEEN TO_DATE (:FECHA_1, '#39'DD/MM/YYYY'#39')'
      '                          AND TO_DATE (:FECHA_2, '#39'DD/MM/YYYY'#39')'
      '       AND (T.IDLOC = '#39'IGUA-MICROS'#39' OR T.IDLOC = '#39'IGUA-CABINAS'#39')')
    Left = 320
    Top = 264
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FECHA_1'
      end
      item
        DataType = ftUnknown
        Name = 'FECHA_2'
      end>
  end
end
