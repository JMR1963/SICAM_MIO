object FormWS32RemotofingerMatchImpl: TFormWS32RemotofingerMatchImpl
  Left = 271
  Top = 114
  Caption = 'WS32RemotofingerMatch V-901'
  ClientHeight = 149
  ClientWidth = 364
  Color = clNavy
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 48
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object ButtonStart: TButton
    Left = 24
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 105
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object EditPort: TEdit
    Left = 24
    Top = 67
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '8091'
  end
  object ButtonOpenBrowser: TButton
    Left = 24
    Top = 112
    Width = 107
    Height = 25
    Caption = 'Open Browser'
    TabOrder = 3
    OnClick = ButtonOpenBrowserClick
  end
  object btn1: TBitBtn
    Left = 24
    Top = 164
    Width = 65
    Height = 41
    Caption = 'btn1'
    TabOrder = 5
    OnClick = btn1Click
  end
  object edt1: TEdit
    Left = 95
    Top = 160
    Width = 473
    Height = 21
    TabOrder = 4
    Text = 'D:\Cache\LOCAL\7FA6DA80-9560-4C33-9646-C6B09CF2C051\huella1.wsq'
  end
  object edt2: TEdit
    Left = 95
    Top = 187
    Width = 473
    Height = 21
    TabOrder = 6
    Text = 'D:\Cache\LOCAL\7FA6DA80-9560-4C33-9646-C6B09CF2C051\huella2.wsq'
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 288
    Top = 24
  end
end
