object Form1: TForm1
  Left = 352
  Top = 184
  Width = 435
  Height = 434
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
  object lbl1: TLabel
    Left = 16
    Top = 8
    Width = 188
    Height = 13
    Caption = 'Test Conectrar a SERVER-LLAMADOR'
  end
  object lbl2: TLabel
    Left = 16
    Top = 85
    Width = 44
    Height = 13
    Caption = 'PUESTO'
  end
  object lbl3: TLabel
    Left = 152
    Top = 85
    Width = 35
    Height = 13
    Caption = 'LETRA'
  end
  object lbl4: TLabel
    Left = 292
    Top = 85
    Width = 48
    Height = 13
    Caption = 'NUMERO'
  end
  object lbl5: TLabel
    Left = 19
    Top = 169
    Width = 45
    Height = 13
    Caption = 'ID_COLA'
  end
  object lbl6: TLabel
    Left = 16
    Top = 208
    Width = 56
    Height = 13
    Caption = 'ID_TURNO'
  end
  object lbl7: TLabel
    Left = 184
    Top = 260
    Width = 107
    Height = 13
    Caption = 'CANT_RELLAMADAS'
  end
  object lbl8: TLabel
    Left = 16
    Top = 128
    Width = 48
    Height = 13
    Caption = 'INI_COLA'
  end
  object lbl9: TLabel
    Left = 152
    Top = 128
    Width = 63
    Height = 13
    Caption = 'STAR_COLA'
  end
  object btnHelloWord: TBitBtn
    Left = 216
    Top = 8
    Width = 193
    Height = 25
    Caption = 'Hello Word'
    Enabled = False
    TabOrder = 0
    OnClick = btnHelloWordClick
  end
  object btnTurnos: TBitBtn
    Left = 16
    Top = 48
    Width = 121
    Height = 25
    Caption = 'Turnos'
    TabOrder = 1
    OnClick = btnTurnosClick
  end
  object txtPuesto: TEdit
    Left = 16
    Top = 101
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object txtLetra: TEdit
    Left = 152
    Top = 101
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object txtNro: TEdit
    Left = 288
    Top = 101
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object mmo1: TMemo
    Left = 16
    Top = 288
    Width = 393
    Height = 57
    Lines.Strings = (
      '')
    TabOrder = 5
  end
  object btnFinalizar: TBitBtn
    Left = 152
    Top = 48
    Width = 121
    Height = 25
    Caption = 'Finalizar'
    TabOrder = 6
    OnClick = btnFinalizarClick
  end
  object btnReLLamar: TBitBtn
    Left = 288
    Top = 48
    Width = 121
    Height = 25
    Caption = 'Re-LLamar'
    TabOrder = 7
    OnClick = btnReLLamarClick
  end
  object btn1: TBitBtn
    Left = 16
    Top = 360
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 8
    OnClick = btn1Click
  end
  object txtCOLA: TEdit
    Left = 16
    Top = 185
    Width = 385
    Height = 21
    TabOrder = 9
  end
  object txtTurno: TEdit
    Left = 16
    Top = 224
    Width = 385
    Height = 21
    TabOrder = 10
  end
  object txtCant: TEdit
    Left = 312
    Top = 256
    Width = 89
    Height = 21
    TabOrder = 11
  end
  object txtINI_COLA: TEdit
    Left = 16
    Top = 144
    Width = 121
    Height = 21
    TabOrder = 12
  end
  object txtSTAR_COLA: TEdit
    Left = 152
    Top = 144
    Width = 121
    Height = 21
    TabOrder = 13
  end
end
