object Form1: TForm1
  Left = 414
  Top = 179
  Width = 475
  Height = 511
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
  object DoRequestNew: TButton
    Left = 168
    Top = 56
    Width = 161
    Height = 25
    Caption = 'DoRequestNew'
    TabOrder = 0
    OnClick = DoRequestNewClick
  end
  object doRequestAmpliada: TButton
    Left = 168
    Top = 96
    Width = 161
    Height = 57
    Caption = 'doRequestAmpliada'
    TabOrder = 1
    OnClick = doRequestAmpliadaClick
  end
  object doRequest: TButton
    Left = 168
    Top = 160
    Width = 161
    Height = 57
    Caption = 'doRequest'
    TabOrder = 2
    OnClick = doRequestClick
  end
  object Button1: TButton
    Left = 168
    Top = 240
    Width = 161
    Height = 57
    Caption = 'doRequestStr'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 160
    Top = 336
    Width = 161
    Height = 57
    Caption = 'Matricula'
    TabOrder = 4
    OnClick = Button1Click
  end
end
