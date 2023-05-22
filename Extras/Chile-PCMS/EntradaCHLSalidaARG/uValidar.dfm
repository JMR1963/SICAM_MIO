object ValidarFrm: TValidarFrm
  Left = 204
  Top = 114
  Width = 580
  Height = 528
  ActiveControl = rgEstado
  Caption = 'Validar'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 57
    Height = 16
    Caption = 'Apellidos'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 24
    Top = 64
    Width = 56
    Height = 16
    Caption = 'Nombres'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 24
    Top = 112
    Width = 109
    Height = 16
    Caption = 'Fecha Nacimiento'
    FocusControl = DBEdit3
  end
  object Label4: TLabel
    Left = 197
    Top = 112
    Width = 31
    Height = 16
    Caption = 'Sexo'
    FocusControl = DBEdit4
  end
  object Label5: TLabel
    Left = 232
    Top = 112
    Width = 74
    Height = 16
    Caption = 'Emisor DOC'
    FocusControl = DBEdit5
  end
  object Label6: TLabel
    Left = 24
    Top = 160
    Width = 97
    Height = 16
    Caption = 'Nro. Documento'
    FocusControl = DBEdit6
  end
  object lbl1: TLabel
    Left = 24
    Top = 320
    Width = 77
    Height = 16
    Caption = 'Observaci'#243'n'
  end
  object rgEstado: TRadioGroup
    Left = 24
    Top = 220
    Width = 521
    Height = 89
    Caption = 'ESTADO'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      '&ACEPTO EL TR'#193'NSITO'
      '&DENIEGO EL TR'#193'NSITO')
    TabOrder = 0
  end
  object mmOBS: TMemo
    Left = 24
    Top = 336
    Width = 521
    Height = 89
    MaxLength = 254
    ScrollBars = ssBoth
    TabOrder = 1
    OnKeyPress = mmOBSKeyPress
  end
  object Panel1: TPanel
    Left = 0
    Top = 425
    Width = 547
    Height = 67
    Align = alBottom
    TabOrder = 2
    object btnAceptar: TBitBtn
      Left = 24
      Top = 16
      Width = 97
      Height = 33
      Caption = 'Aceptar'
      Default = True
      TabOrder = 0
      OnClick = btnAceptarClick
    end
    object bbCancelar: TBitBtn
      Left = 448
      Top = 16
      Width = 97
      Height = 33
      Cancel = True
      Caption = 'Cancelar'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object DBEdit1: TDBEdit
    Left = 24
    Top = 32
    Width = 505
    Height = 24
    TabStop = False
    DataField = 'Apellidos'
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 3
  end
  object DBEdit2: TDBEdit
    Left = 24
    Top = 80
    Width = 505
    Height = 24
    TabStop = False
    DataField = 'Nombres'
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 4
  end
  object DBEdit3: TDBEdit
    Left = 24
    Top = 128
    Width = 164
    Height = 24
    TabStop = False
    DataField = 'FechaNac'
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 5
  end
  object DBEdit4: TDBEdit
    Left = 197
    Top = 128
    Width = 20
    Height = 24
    TabStop = False
    DataField = 'genero'
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 6
  end
  object DBEdit5: TDBEdit
    Left = 232
    Top = 128
    Width = 164
    Height = 24
    TabStop = False
    DataField = 'EMISORDOC'
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 7
  end
  object DBEdit6: TDBEdit
    Left = 24
    Top = 176
    Width = 164
    Height = 24
    TabStop = False
    DataField = 'NroDOC'
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 8
  end
  object DataSource1: TDataSource
    DataSet = DMSem.tblArch
    Left = 264
    Top = 312
  end
  object DataSource2: TDataSource
    Left = 280
    Top = 280
  end
end
