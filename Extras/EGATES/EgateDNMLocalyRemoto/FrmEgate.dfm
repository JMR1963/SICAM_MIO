object FrmWSEgate: TFrmWSEgate
  Left = 271
  Top = 114
  BorderStyle = bsSingle
  Caption = 'LOCAL - WS DNM - Egate V-902'
  ClientHeight = 175
  ClientWidth = 340
  Color = clNavy
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
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
    TabOrder = 3
    Text = '8080'
  end
  object ButtonOpenBrowser: TButton
    Left = 24
    Top = 112
    Width = 107
    Height = 25
    Caption = 'Open Browser'
    TabOrder = 4
    OnClick = ButtonOpenBrowserClick
  end
  object btn1: TButton
    Left = 544
    Top = 252
    Width = 305
    Height = 49
    Caption = 'btn1'
    TabOrder = 8
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = -23
    Top = 238
    Width = 225
    Height = 73
    Caption = 'btn2'
    TabOrder = 7
    OnClick = btn2Click
  end
  object mmo1: TMemo
    Left = 208
    Top = 456
    Width = 489
    Height = 129
    Lines.Strings = (
      'mmo1')
    TabOrder = 12
  end
  object btn3: TButton
    Left = 504
    Top = 262
    Width = 75
    Height = 25
    Caption = 'btn3'
    TabOrder = 9
    OnClick = btn3Click
  end
  object mmo2: TMemo
    Left = -4297
    Top = 416
    Width = 5490
    Height = 146
    Lines.Strings = (
      '<?xml version="1.0" encoding="ISO-8859-1" standalone="yes"?>'
      
        '<MANIFIESTO><HEADER TIPO_MEDIO_TRANSPORTE="peaton" TIPO_ACCION="' +
        '" PROCEDENCIA_DESTINO="" PAIS_MATRICULA="" NOMBRE_DE_VIAJE="" MA' +
        'TRICULA_MEDIO_TRANSPORTE="EGATES" ID_SOBRE="" FUNCIONARIO="egate' +
        '-guest-user" FECHA_PROGRAMADA_TRANSPORTE="" EMPRESA=""/><ROW TRI' +
        'PULANTE_PASAJERO="#TIPO_PASAJERO#" TIPO_DOCUMENTO="#docType#" PA' +
        'IS_DOCUMENTO="#issuingCountry#" NUMERO_DOCUMENTO="#docNumber#" N' +
        'ACIONALIDAD="#nationality#" FECHA_EMISION_DOCUMENTO="" FECHA_EXP' +
        'IRACION_DOCUMENTO="" SEXO="#sex#" PRI_NOMBRE="#Npri#" SEG_NOMBRE' +
        '="#Nseg#" PRI_APELLIDO="#Apri#" SEG_APELLIDO="#Aseg#" FEC_NAC="#' +
        'FEC_NAC#" REVERSO_VISIBLE="#DOC_6.jpg#" REVERSO_ULTRAVIOLETA="#D' +
        'OC_8.jpg#" REVERSO_INFRAROJO="#DOC_7.jpg#" ANVERSO_INFRAROJO="#D' +
        'OC_4.jpg#" ANVERSO_ULTRAVIOLETA="#DOC_5.jpg#" ANVERSO_VISIBLE="#' +
        'DOC_3.jpg#" IMAGEN_WSQ_HUELLA_CAPTURADA="#huella2.wsq#" IMAGEN_R' +
        'OSTRO_EDOCUMENTO="#DOC_1.jpg#" IMAGEN_ROSTRO_DOCUMENTO="#DOC_2.j' +
        'pg#" IMAGEN_ROSTRO_CAPTURADO="#foto1.jpg#" ORDEN_HUELLA_CAPTURAD' +
        'A="0" OBSERVACIONES_ROSTRO_CAPTURADO="" OBSERVACIONES_HUELLA_CAP'
      
        'TURADA="" IMPEDIDO_PAIS_INGRESO="#POSEE_IMPEDIMENTO#" CALIDAD_HU' +
        'ELLA_CAPTURADA="#DACTILAR_SCORE#" CHECKSUM="" FECHA_TRANSITO="#F' +
        'ECHA_TRANSITO#"/></MANIFIESTO>')
    ScrollBars = ssBoth
    TabOrder = 11
  end
  object btn4: TButton
    Left = 272
    Top = 264
    Width = 75
    Height = 25
    Caption = 'btn4'
    TabOrder = 10
    OnClick = btn4Click
  end
  object btnReinciar: TButton
    Left = 240
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Reiniciar'
    TabOrder = 5
    OnClick = btnReinciarClick
  end
  object mmomrz: TMemo
    Left = 416
    Top = 16
    Width = 369
    Height = 121
    TabOrder = 2
  end
  object btnMRZ: TButton
    Left = 416
    Top = 143
    Width = 75
    Height = 25
    Caption = 'MRZ'
    TabOrder = 6
    OnClick = btnMRZClick
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 288
    Top = 24
  end
  object tmrReiniciar: TTimer
    Interval = 100000
    OnTimer = tmrReiniciarTimer
    Left = 176
    Top = 80
  end
  object tmrCmd: TTimer
    Interval = 60000
    Left = 336
    Top = 72
  end
end
