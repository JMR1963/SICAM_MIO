object DialupDtMdl: TDialupDtMdl
  OldCreateOrder = False
  Left = 693
  Top = 328
  Height = 150
  Width = 215
  object DialUpConn: TDialUp
    DialMode = dmSync
    Language = English
    OnDialing = DialUpConnDialing
    OnConnect = DialUpConnConnect
    OnNotConnected = DialUpConnNotConnected
    Left = 40
    Top = 12
  end
end
