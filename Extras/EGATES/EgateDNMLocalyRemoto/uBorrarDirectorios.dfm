object FmBorroCarpetas: TFmBorroCarpetas
  Left = 0
  Top = 0
  Caption = 'FmBorroCarpetas'
  ClientHeight = 357
  ClientWidth = 723
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object mmoIDLOC: TMemo
    Left = 40
    Top = 16
    Width = 521
    Height = 233
    Lines.Strings = (
      'LOCAL'
      'BQB'
      'BQB-CONTINGENCIA'
      'PLUMERILLO'
      'AJN-CONTINGENCIA'
      'AJN'
      'TPA'
      'COLONIAEXPRESS'
      'IGUA-ENTRADA'
      'IGUA-SALIDA'
      'ENT-EZEIZA'
      'POSADAS-A'
      'IGUA-SALIDA'
      'IGUA-ENTRADA'
      'LIBERTADORES-A'
      'POS-S-CONTINGENCIA'
      'EZE-CONTINGENCIA'
      'PLIBRES-CONTINGENCIA'
      'PLIBRES-SALIDA'
      'PLIBRES'
      'PLIBRESBR'
      'BQB-PRUEBA'
      'ROSARIO')
    TabOrder = 0
  end
  object mmoLisD: TMemo
    Left = 216
    Top = 255
    Width = 409
    Height = 89
    Lines.Strings = (
      'mmoLisD')
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object btn1: TButton
    Left = 40
    Top = 272
    Width = 121
    Height = 49
    Caption = 'btn1'
    TabOrder = 2
    OnClick = btn1Click
  end
  object Timer1: TTimer
    Interval = 36000000
    OnTimer = Timer1Timer
    Left = 608
    Top = 72
  end
end
