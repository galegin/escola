object cFORM: TcFORM
  Left = 258
  Top = 115
  Width = 696
  Height = 480
  Caption = 'cFORM'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMenu = _PopupMenu
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object EditCancel: TEdit
    Tag = -1
    Left = 577
    Top = 79
    Width = 1
    Height = 1
    TabStop = False
    AutoSize = False
    TabOrder = 0
  end
  object _CoolBar: TCoolBar
    Left = 0
    Top = 0
    Width = 680
    Height = 27
    AutoSize = True
    Bands = <
      item
        Control = _ToolBar
        ImageIndex = -1
        MinHeight = 23
        Width = 676
      end>
    object _ToolBar: TToolBar
      Left = 9
      Top = 0
      Width = 663
      Height = 23
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 40
      Caption = '_ToolBar'
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      object ToolButtonFechar: TToolButton
        Left = 0
        Top = 0
        Hint = '(ESC)'
        AutoSize = True
        Caption = 'Fechar'
        ImageIndex = 10
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonFecharClick
      end
    end
  end
  object _CoolBarAtalho: TCoolBar
    Left = 0
    Top = 415
    Width = 680
    Height = 27
    Align = alBottom
    AutoSize = True
    Bands = <
      item
        Control = _ToolBarAtalho
        ImageIndex = -1
        MinHeight = 23
        Width = 676
      end>
    object _ToolBarAtalho: TToolBar
      Left = 9
      Top = 0
      Width = 663
      Height = 23
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 40
      Caption = 'ToolBar1'
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      object ToolButtonFechar1: TToolButton
        Left = 0
        Top = 0
        Hint = '(ESC)'
        Caption = 'Fechar'
        ImageIndex = 10
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonFecharClick
      end
    end
  end
  object _Query: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    Left = 552
    Top = 8
  end
  object _Provider: TDataSetProvider
    DataSet = _Query
    Options = [poAllowMultiRecordUpdates, poAutoRefresh, poAllowCommandText]
    Left = 584
    Top = 8
  end
  object _DataSet: TClientDataSet
    Aggregates = <>
    PacketRecords = 30
    Params = <>
    ProviderName = '_Provider'
    AfterOpen = _DataSetAfterOpen
    BeforePost = _DataSetBeforePost
    AfterPost = _DataSetAfterPost
    OnNewRecord = _DataSetNewRecord
    Left = 616
    Top = 8
  end
  object _DataSource: TDataSource
    DataSet = _DataSet
    Left = 648
    Top = 8
  end
  object _PopupMenu: TPopupMenu
    Left = 520
    Top = 8
    object bConsultaLog: TMenuItem
      Caption = 'Consulta log'
      OnClick = bConsultaLogClick
    end
    object bObservacao: TMenuItem
      Caption = 'Observa'#231#227'o'
      OnClick = bObservacaoClick
    end
    object pConfigurarIncremento: TMenuItem
      Caption = 'Configurar incremento'
      OnClick = bConfigurarIncrementoClick
    end
    object bConfigurarManutencao: TMenuItem
      Caption = 'Configurar manuten'#231#227'o'
      OnClick = bConfigurarManutencaoClick
    end
    object bConfigurarValidacao: TMenuItem
      Caption = 'Configurar valida'#231#227'o'
      OnClick = bConfigurarValidacaoClick
    end
    object bConfigurarRelatorio: TMenuItem
      Caption = 'Configurar relat'#243'rio'
      OnClick = bConfigurarRelatorioClick
    end
    object bMoverCampo: TMenuItem
      Caption = 'Mover campo'
      OnClick = bMoverCampoClick
    end
    object bAjustarCampo: TMenuItem
      Caption = 'Ajustar campo'
      OnClick = bAjustarCampoClick
    end
  end
end
