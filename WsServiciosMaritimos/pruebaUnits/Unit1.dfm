object Form1: TForm1
  Left = 387
  Top = 339
  Width = 439
  Height = 342
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
  object Label1: TLabel
    Left = 88
    Top = 192
    Width = 36
    Height = 13
    Caption = 'Fecha1'
  end
  object Label2: TLabel
    Left = 248
    Top = 192
    Width = 33
    Height = 13
    Caption = 'fecha2'
  end
  object Jurisdiccion: TLabel
    Left = 88
    Top = 232
    Width = 55
    Height = 13
    Caption = 'Jurisdiccion'
  end
  object Button1: TButton
    Left = 160
    Top = 64
    Width = 153
    Height = 65
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object edtFecha1: TEdit
    Left = 88
    Top = 208
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '28042010000000'
  end
  object edtFecha2: TEdit
    Left = 248
    Top = 208
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '30042010235959'
  end
  object edtJurisdiccion: TEdit
    Left = 88
    Top = 248
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '18'
  end
end
