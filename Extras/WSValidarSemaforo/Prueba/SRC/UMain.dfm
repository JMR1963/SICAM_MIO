object FMain: TFMain
  Left = 374
  Top = 146
  Width = 601
  Height = 292
  AutoSize = True
  Caption = 'FMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 593
    Height = 265
    TabOrder = 0
    object lbPaisDoc: TLabel
      Left = 8
      Top = 8
      Width = 136
      Height = 13
      Caption = 'Codigo Pais Documento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbNumeroDocumento: TLabel
      Left = 184
      Top = 8
      Width = 112
      Height = 13
      Caption = 'Numero Documento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbFlag: TLabel
      Left = 356
      Top = 9
      Width = 25
      Height = 13
      Caption = 'Flag'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbFuncionario: TLabel
      Left = 418
      Top = 8
      Width = 67
      Height = 13
      Caption = 'Funcionario'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbObservacion: TLabel
      Left = 8
      Top = 56
      Width = 72
      Height = 13
      Caption = 'Observaci'#243'n'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object txtCodigoPaisDocumento: TEdit
      Left = 8
      Top = 24
      Width = 161
      Height = 21
      TabOrder = 0
      Text = 'ARG'
    end
    object txtNumeroDocumento: TEdit
      Left = 184
      Top = 24
      Width = 161
      Height = 21
      TabOrder = 1
      Text = '38468928'
    end
    object txtFlag: TEdit
      Left = 356
      Top = 24
      Width = 49
      Height = 21
      TabOrder = 2
      Text = '1'
    end
    object txtFuncionario: TEdit
      Left = 418
      Top = 24
      Width = 163
      Height = 21
      TabOrder = 3
      Text = 'biacchi adrian emanuel'
    end
    object txtObservacion: TMemo
      Left = 7
      Top = 76
      Width = 574
      Height = 137
      TabOrder = 4
    end
    object btnEnviarRespuesta: TButton
      Left = 489
      Top = 221
      Width = 92
      Height = 25
      Caption = 'Enviar Respuesta'
      TabOrder = 5
      OnClick = btnEnviarRespuestaClick
    end
    object btn1: TButton
      Left = 392
      Top = 224
      Width = 75
      Height = 25
      Caption = 'btn1'
      TabOrder = 6
      OnClick = btn1Click
    end
  end
end
