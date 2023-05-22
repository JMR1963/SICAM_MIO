object UsuarioIngresoFrm: TUsuarioIngresoFrm
  Left = 186
  Top = 188
  ActiveControl = edtUsuario
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'SEMAFORO - SICAM'
  ClientHeight = 104
  ClientWidth = 523
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblNombrePaso: TLabel
    Left = 21
    Top = 36
    Width = 274
    Height = 23
    AutoSize = False
    Caption = 'lblNombrePaso'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblUsuario: TLabel
    Left = 335
    Top = 9
    Width = 88
    Height = 11
    Caption = 'Usuario supervisor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 10841658
    Font.Height = -9
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblPassword: TLabel
    Left = 335
    Top = 50
    Width = 51
    Height = 11
    Caption = 'Contrase'#241'a'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 10841658
    Font.Height = -9
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object edtPassword: TMaskEdit
    Left = 333
    Top = 61
    Width = 169
    Height = 21
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 40
    ParentCtl3D = False
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 1
    OnKeyPress = edtPasswordKeyPress
  end
  object edtUsuario: TMaskEdit
    Left = 333
    Top = 21
    Width = 169
    Height = 21
    CharCase = ecUpperCase
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 50
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    OnKeyPress = edtUsuarioKeyPress
  end
end
