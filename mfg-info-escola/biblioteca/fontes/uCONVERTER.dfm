object fCONVERTER: TfCONVERTER
  Left = 191
  Top = 110
  Width = 643
  Height = 347
  Caption = 'CONVERTER'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 300
    Width = 635
    Height = 13
    Align = alBottom
    Caption = 'Convertendo'
  end
  object Button1: TButton
    Left = 8
    Top = 16
    Width = 617
    Height = 25
    Caption = 'Converter'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 48
    Width = 617
    Height = 17
    Min = 0
    Max = 100
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 104
    Width = 457
    Height = 185
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object Button2: TButton
    Left = 8
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Parar'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 104
    Width = 489
    Height = 185
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    TabOrder = 4
    WordWrap = False
  end
  object CheckBox1: TCheckBox
    Left = 160
    Top = 72
    Width = 97
    Height = 17
    Caption = 'Incremental'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object RadioGroup1: TRadioGroup
    Left = 504
    Top = 104
    Width = 121
    Height = 185
    Caption = 'Converter'
    ItemIndex = 0
    Items.Strings = (
      'Todos'
      'Curso'
      'Genero'
      'Editora'
      'Livro'
      'Locador'
      'Loca'#231#227'o')
    TabOrder = 6
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    OnNewRecord = ClientDataSet1NewRecord
    Left = 336
    Top = 136
  end
  object SQLQuery1: TSQLQuery
    SQLConnection = SQLConnection1
    Params = <>
    Left = 272
    Top = 136
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = SQLQuery1
    Constraints = True
    Options = [poAllowMultiRecordUpdates, poAutoRefresh, poAllowCommandText]
    Left = 304
    Top = 136
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'IBLocal'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpint.dll'
    LoginPrompt = False
    Params.Strings = (
      'BlobSize=-1'
      'CommitRetain=False'
      'Database=database.gdb'
      'DriverName=Interbase'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Password=masterkey'
      'RoleName=RoleName'
      'ServerCharSet=win1252'
      'SQLDialect=3'
      'Interbase TransIsolation=ReadCommited'
      'User_Name=sysdba'
      'WaitOnLocks=True')
    VendorLib = 'FBCLIENT.DLL'
    BeforeConnect = SQLConnection1BeforeConnect
    Left = 240
    Top = 136
  end
  object TGeneros: TTable
    DatabaseName = 'scb'
    IndexFieldNames = 'SCBCODGEN'
    TableName = 'scbgeneros.db'
    Left = 24
    Top = 136
    object TGenerosSCBCODGEN: TFloatField
      FieldName = 'SCBCODGEN'
    end
    object TGenerosSCBNOME: TStringField
      DisplayWidth = 40
      FieldName = 'SCBNOME'
    end
  end
  object TLivros: TTable
    DatabaseName = 'scb'
    TableName = 'scblivros.db'
    Left = 88
    Top = 136
    object TLivrosSCBCODLIV: TFloatField
      FieldName = 'SCBCODLIV'
    end
    object TLivrosSCBTITULO: TStringField
      FieldName = 'SCBTITULO'
      Size = 60
    end
    object TLivrosSCBAUTOR: TStringField
      FieldName = 'SCBAUTOR'
      Size = 50
    end
    object TLivrosSCBCODGEN: TFloatField
      FieldName = 'SCBCODGEN'
    end
    object TLivrosSCBEDITORA: TStringField
      FieldName = 'SCBEDITORA'
      Size = 40
    end
    object TLivrosSCBCODEDI: TFloatField
      FieldName = 'SCBCODEDI'
    end
    object TLivrosSCBVOLUME: TFloatField
      FieldName = 'SCBVOLUME'
    end
    object TLivrosSCBDE: TFloatField
      FieldName = 'SCBDE'
    end
    object TLivrosSCBCOMP: TStringField
      FieldName = 'SCBCOMP'
      Size = 50
    end
    object TLivrosSCBESTANTE: TFloatField
      FieldName = 'SCBESTANTE'
    end
    object TLivrosSCBPARTELEIRA: TFloatField
      FieldName = 'SCBPARTELEIRA'
    end
    object TLivrosSCBEXEMPLARES: TFloatField
      FieldName = 'SCBEXEMPLARES'
    end
    object TLivrosSCBINDICES: TStringField
      FieldName = 'SCBINDICES'
      Size = 7
    end
    object TLivrosSCBFORMA: TStringField
      FieldName = 'SCBFORMA'
      Size = 40
    end
    object TLivrosSCBORIGEM: TStringField
      FieldName = 'SCBORIGEM'
      Size = 40
    end
    object TLivrosSCBDTCADASTRO: TDateField
      FieldName = 'SCBDTCADASTRO'
    end
    object TLivrosSCBCIDADE: TStringField
      FieldName = 'SCBCIDADE'
    end
    object TLivrosSCBANO: TStringField
      FieldName = 'SCBANO'
      Size = 4
    end
  end
  object TLocadores: TTable
    DatabaseName = 'scb'
    TableName = 'scblocadores.db'
    Left = 120
    Top = 136
    object TLocadoresSCBCODLOC: TFloatField
      FieldName = 'SCBCODLOC'
    end
    object TLocadoresSCBNOME: TStringField
      FieldName = 'SCBNOME'
      Size = 30
    end
    object TLocadoresSCBENDERECO: TStringField
      FieldName = 'SCBENDERECO'
      Size = 30
    end
    object TLocadoresSCBCIDADE: TStringField
      FieldName = 'SCBCIDADE'
    end
    object TLocadoresSCBUF: TStringField
      FieldName = 'SCBUF'
      Size = 2
    end
    object TLocadoresSCBFONE: TStringField
      FieldName = 'SCBFONE'
      Size = 11
    end
    object TLocadoresSCBCOMP1: TStringField
      FieldName = 'SCBCOMP1'
      Size = 30
    end
    object TLocadoresSCBCOMP2: TStringField
      FieldName = 'SCBCOMP2'
      Size = 30
    end
    object TLocadoresSCBDEVEDOR: TCurrencyField
      FieldName = 'SCBDEVEDOR'
      DisplayFormat = '0.00'
    end
  end
  object TLocacoes: TTable
    DatabaseName = 'scb'
    Filtered = True
    TableName = 'scblocacoes.db'
    Left = 152
    Top = 136
    object TLocacoesSCBCODLOC: TFloatField
      FieldName = 'SCBCODLOC'
    end
    object TLocacoesSCBCODLIV: TFloatField
      FieldName = 'SCBCODLIV'
    end
    object TLocacoesSCBDTLOCACAO: TDateField
      FieldName = 'SCBDTLOCACAO'
    end
    object TLocacoesSCBDTDEVOLUCAO: TDateField
      FieldName = 'SCBDTDEVOLUCAO'
    end
    object TLocacoesSCBDTDEVOLVIDO: TDateField
      FieldName = 'SCBDTDEVOLVIDO'
    end
    object TLocacoesSCBSITUACAO: TFloatField
      FieldName = 'SCBSITUACAO'
    end
    object TLocacoesSCBBAIXA: TStringField
      FieldName = 'SCBBAIXA'
      Size = 1
    end
  end
  object TEditoras: TTable
    DatabaseName = 'SCB'
    TableName = 'scbeditoras.db'
    Left = 56
    Top = 136
    object TEditorasSCBCODEDI: TFloatField
      FieldName = 'SCBCODEDI'
    end
    object TEditorasSCBDESCRICAO: TStringField
      FieldName = 'SCBDESCRICAO'
      Size = 30
    end
  end
  object DataSource1: TDataSource
    Left = 152
    Top = 168
  end
  object SQLQuery2: TSQLQuery
    SQLConnection = SQLConnection1
    Params = <>
    Left = 272
    Top = 168
  end
end
