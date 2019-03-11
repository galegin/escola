inherited cCONSULTA: TcCONSULTA
  Left = 280
  Top = 73
  Width = 812
  Height = 563
  Caption = 'cCONSULTA'
  OldCreateOrder = True
  PopupMenu = nil
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 0
    Top = 23
    Width = 796
    Height = 39
    Align = alTop
    TabOrder = 3
    DesignSize = (
      796
      39)
    object LabelTpConsulta: TLabel
      Left = 8
      Top = 8
      Width = 64
      Height = 13
      Caption = 'Tipo consulta'
    end
    object LabelPesquisarPor: TLabel
      Left = 176
      Top = 8
      Width = 64
      Height = 13
      Caption = 'Pesquisar por'
    end
    object LabelExpressao: TLabel
      Left = 376
      Top = 8
      Width = 49
      Height = 13
      Caption = 'Express'#227'o'
    end
    object TP_CONSULTA: TComboBox
      Left = 80
      Top = 8
      Width = 89
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 2
      TabOrder = 0
      Text = 'Qualquer'
      Items.Strings = (
        'Completa'
        'Parcial'
        'Qualquer')
    end
    object CD_CAMPO: TComboBox
      Left = 248
      Top = 8
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnChange = CD_CAMPOChange
      OnExit = CD_CAMPOExit
    end
    object fDS_EXPRESSAO: TEdit
      Left = 432
      Top = 8
      Width = 353
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      OnExit = fDS_EXPRESSAOExit
    end
  end
  object Panel2: TPanel [1]
    Left = 0
    Top = 62
    Width = 796
    Height = 436
    Align = alClient
    TabOrder = 4
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 794
      Height = 434
      Align = alClient
      FixedColor = 12615680
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWhite
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      OnKeyDown = DBGrid1KeyDown
      OnTitleClick = DBGrid1TitleClick
    end
  end
  inherited _CoolBar: TCoolBar
    Width = 796
    Height = 23
    Bands = <
      item
        ImageIndex = -1
        MinHeight = 23
        Width = 792
      end>
    inherited _ToolBar: TToolBar
      Width = 787
      ButtonWidth = 51
      object ToolButtonS1: TToolButton
        Left = 44
        Top = 0
        Width = 8
        Caption = 'ToolButtonS1'
        ImageIndex = 17
        Style = tbsSeparator
      end
      object ToolButtonConsultar: TToolButton
        Left = 52
        Top = 0
        Hint = '(F4)'
        AutoSize = True
        Caption = 'Consultar'
        ImageIndex = 12
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonConsultarClick
      end
      object ToolButtonLimpar: TToolButton
        Left = 107
        Top = 0
        Hint = '(F2)'
        AutoSize = True
        Caption = 'Limpar'
        ImageIndex = 13
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonLimparClick
      end
      object ToolButtonImprimir: TToolButton
        Left = 149
        Top = 0
        Hint = '(F6)'
        AutoSize = True
        Caption = 'Imprimir'
        ImageIndex = 16
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonImprimirClick
      end
      object ToolButtonS2: TToolButton
        Left = 195
        Top = 0
        Width = 8
        Caption = 'ToolButtonS2'
        ImageIndex = 11
        Style = tbsSeparator
      end
      object ToolButtonNovo: TToolButton
        Left = 203
        Top = 0
        Hint = '(F5)'
        AutoSize = True
        Caption = 'Novo'
        ImageIndex = 12
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonNovoClick
      end
      object ToolButtonAlterar: TToolButton
        Left = 240
        Top = 0
        Hint = '(ENTER)'
        AutoSize = True
        Caption = 'Alterar'
        ImageIndex = 6
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonAlterarClick
      end
      object ToolButtonExcluir: TToolButton
        Left = 281
        Top = 0
        Hint = '(F8)'
        AutoSize = True
        Caption = 'Excluir'
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonExcluirClick
      end
    end
  end
  inherited _CoolBarAtalho: TCoolBar
    Top = 498
    Width = 796
    Bands = <
      item
        Control = _ToolBarAtalho
        ImageIndex = -1
        MinHeight = 23
        Width = 792
      end>
    inherited _ToolBarAtalho: TToolBar
      Width = 779
    end
  end
end
