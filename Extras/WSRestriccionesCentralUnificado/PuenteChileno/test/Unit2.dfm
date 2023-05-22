object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 216
  ClientWidth = 206
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 40
    Top = 24
    Width = 135
    Height = 25
    Caption = 'VERIFICAR'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object Button1: TButton
    Left = 40
    Top = 72
    Width = 135
    Height = 25
    Caption = 'PROCEDER'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 40
    Top = 120
    Width = 135
    Height = 25
    Caption = 'ENVIO DE TRANSITO'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 40
    Top = 167
    Width = 135
    Height = 25
    Caption = 'DESPACHO'
    TabOrder = 3
    OnClick = Button2Click
  end
end
