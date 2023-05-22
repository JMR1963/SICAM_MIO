object llamadas: Tllamadas
  Left = 420
  Top = 130
  Width = 582
  Height = 484
  Caption = 'llamadas'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 32
    Top = 16
    Width = 201
    Height = 25
    Caption = 'Directo a Col'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 280
    Top = 16
    Width = 169
    Height = 25
    Caption = 'Puente de Silvera'
    TabOrder = 1
    OnClick = Button2Click
  end
  object mRequest: TMemo
    Left = 27
    Top = 62
    Width = 525
    Height = 163
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
    WordWrap = False
  end
  object mResponse: TMemo
    Left = 19
    Top = 238
    Width = 525
    Height = 163
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 3
    WordWrap = False
  end
  object BitBtn1: TBitBtn
    Left = 480
    Top = 16
    Width = 75
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 4
    OnClick = BitBtn1Click
  end
  object HTTPRIO1: THTTPRIO
    OnAfterExecute = HTTPRIO1AfterExecute
    OnBeforeExecute = HTTPRIO1BeforeExecute
    WSDLLocation = 'http://172.20.3.115:8011/AlianzaPacifico/consultaArgentina?wsdl'
    HTTPWebNode.Agent = 'Borland SOAP 1.2'
    HTTPWebNode.UserName = 'ArgentinaDNM'
    HTTPWebNode.Password = '4rg3nt1naDNM'
    HTTPWebNode.UseUTF8InHeader = True
    HTTPWebNode.InvokeOptions = [soIgnoreInvalidCerts, soAutoCheckAccessPointViaUDDI]
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 88
    Top = 24
  end
end
