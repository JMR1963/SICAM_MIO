object FrmFaltantes: TFrmFaltantes
  Left = 238
  Top = 98
  BorderStyle = bsSingle
  Caption = 'Faltantes'
  ClientHeight = 574
  ClientWidth = 560
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 560
    Height = 115
    Align = alTop
    Color = clInfoBk
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 18
      Width = 45
      Height = 20
      Caption = 'Titulo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 56
      Width = 85
      Height = 16
      Caption = 'Fecha Desde:'
    end
    object Label3: TLabel
      Left = 8
      Top = 88
      Width = 80
      Height = 16
      Caption = 'Fecha Hasta:'
    end
    object btnMostrar: TBitBtn
      Left = 328
      Top = 64
      Width = 75
      Height = 25
      Caption = 'Mostrar'
      TabOrder = 0
      OnClick = btnMostrarClick
    end
    object FDesde: TDateTimePicker
      Left = 104
      Top = 56
      Width = 186
      Height = 24
      Date = 42649.435087685180000000
      Time = 42649.435087685180000000
      TabOrder = 1
    end
    object FHasta: TDateTimePicker
      Left = 104
      Top = 83
      Width = 186
      Height = 24
      Date = 42649.435087685180000000
      Time = 42649.435087685180000000
      TabOrder = 2
    end
  end
  object DBGrid1: TCRDBGrid
    Left = 0
    Top = 115
    Width = 560
    Height = 387
    OptionsEx = [dgeEnableSort, dgeFilterBar, dgeLocalFilter, dgeLocalSorting, dgeRecordCount]
    Align = alClient
    BorderStyle = bsNone
    Ctl3D = True
    DataSource = DataSource1
    FixedColor = clActiveBorder
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    OnDrawColumnCell = DBGrid1DrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'Visto'
        Width = 34
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Patente'
        Width = 175
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pais vehiculo'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fecha'
        Width = 143
        Visible = True
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 502
    Width = 560
    Height = 72
    Align = alBottom
    Color = clInfoBk
    TabOrder = 2
    object BitBtn2: TBitBtn
      Left = 336
      Top = 16
      Width = 217
      Height = 41
      Caption = 'CERRAR'
      TabOrder = 0
    end
    object BitBtn1: TBitBtn
      Left = 8
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Visto'
      TabOrder = 1
      OnClick = BitBtn1Click
    end
  end
  object tblFaltantes: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    ObjectView = False
    Params = <>
    StoreDefs = True
    Left = 312
    Top = 72
    object tblFaltantesVisto: TBooleanField
      FieldName = 'Visto'
    end
    object tblFaltantesPatente: TStringField
      FieldName = 'Patente'
      Size = 12
    end
    object tblFaltantesPaisvehiculo: TStringField
      FieldName = 'Pais vehiculo'
      Size = 10
    end
    object tblFaltantesFecha: TDateTimeField
      FieldName = 'Fecha'
    end
  end
  object DataSource1: TDataSource
    DataSet = tblFaltantes
    Left = 192
    Top = 152
  end
end
