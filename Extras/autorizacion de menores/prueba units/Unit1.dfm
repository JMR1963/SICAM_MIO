object Form1: TForm1
  Left = 535
  Top = 310
  Width = 359
  Height = 240
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
    Left = 232
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Grabar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 232
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Revocar'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 232
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Modificar'
    TabOrder = 2
    OnClick = Button3Click
  end
end
