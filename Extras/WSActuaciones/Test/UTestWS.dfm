object Form1: TForm1
  Left = 254
  Top = 128
  Width = 892
  Height = 568
  Caption = 'Test WSActuaciones'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 696
    Top = 152
    Width = 105
    Height = 105
    Stretch = True
  end
  object Button1: TButton
    Left = 504
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Todo'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 40
    Top = 64
    Width = 609
    Height = 353
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 696
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Solo Foto'
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object Edit1: TEdit
    Left = 312
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'exp y a'#241'o'
  end
  object Button2: TButton
    Left = 280
    Top = 448
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Edit2: TEdit
    Left = 112
    Top = 448
    Width = 145
    Height = 21
    TabOrder = 5
    Text = 'Edit2'
  end
end
