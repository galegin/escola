inherited cUSUARIO: TcUSUARIO
  Caption = 'cUSUARIO'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    ActivePage = TabSheet2
    inherited TabSheet2: TTabSheet
      inherited Panel3: TPanel
        inherited ScrollBox1: TScrollBox
          object LabelIncluir: TLabel
            Tag = 2
            Left = 192
            Top = 184
            Width = 28
            Height = 13
            Cursor = crHandPoint
            Caption = 'Incluir'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = LabelIncluirClick
          end
          object LabelAlterar: TLabel
            Tag = 3
            Left = 232
            Top = 184
            Width = 30
            Height = 13
            Cursor = crHandPoint
            Caption = 'Alterar'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = LabelIncluirClick
          end
          object LabelExcluir: TLabel
            Tag = 4
            Left = 272
            Top = 184
            Width = 31
            Height = 13
            Cursor = crHandPoint
            Caption = 'Excluir'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = LabelIncluirClick
          end
          object LabelImprimir: TLabel
            Tag = 5
            Left = 312
            Top = 184
            Width = 35
            Height = 13
            Cursor = crHandPoint
            Caption = 'Imprimir'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = LabelIncluirClick
          end
          object LabelEntidade: TLabel
            Tag = 1
            Left = 16
            Top = 184
            Width = 42
            Height = 13
            Cursor = crHandPoint
            Caption = 'Entidade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = LabelIncluirClick
          end
          object gPerm: TDBCtrlGrid
            Left = 8
            Top = 200
            Width = 369
            Height = 220
            DataSource = dPerm
            PanelHeight = 22
            PanelWidth = 352
            TabOrder = 0
            RowCount = 10
            object DBTextEnt: TDBText
              Left = 8
              Top = 2
              Width = 169
              Height = 17
              Cursor = crHandPoint
              DataField = 'CD_ENTIDADE'
              DataSource = dPerm
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsUnderline]
              ParentFont = False
              OnClick = DBTextEntClick
            end
            object DBCheckBoxInc: TDBCheckBox
              Left = 192
              Top = 2
              Width = 15
              Height = 15
              DataField = 'IN_INCLUIR'
              DataSource = dPerm
              TabOrder = 0
              ValueChecked = 'T'
              ValueUnchecked = 'F'
            end
            object DBCheckBoxAlt: TDBCheckBox
              Left = 232
              Top = 2
              Width = 15
              Height = 15
              DataField = 'IN_ALTERAR'
              DataSource = dPerm
              TabOrder = 1
              ValueChecked = 'T'
              ValueUnchecked = 'F'
            end
            object DBCheckBoxExc: TDBCheckBox
              Left = 272
              Top = 2
              Width = 15
              Height = 15
              DataField = 'IN_EXCLUIR'
              DataSource = dPerm
              TabOrder = 2
              ValueChecked = 'T'
              ValueUnchecked = 'F'
            end
            object DBCheckBoxImp: TDBCheckBox
              Left = 312
              Top = 2
              Width = 15
              Height = 15
              DataField = 'IN_IMPRIMIR'
              DataSource = dPerm
              TabOrder = 3
              ValueChecked = 'T'
              ValueUnchecked = 'F'
            end
          end
        end
      end
    end
  end
  object dPerm: TDataSource
    DataSet = tPerm
    OnStateChange = DataSource1StateChange
    Left = 728
    Top = 128
  end
  object tPerm: TClientDataSet
    Aggregates = <>
    PacketRecords = 30
    Params = <>
    ProviderName = 'sPerm'
    OnNewRecord = tPermNewRecord
    Left = 696
    Top = 128
  end
  object sPerm: TDataSetProvider
    DataSet = qPerm
    Options = [poAllowMultiRecordUpdates, poAutoRefresh, poAllowCommandText]
    Left = 664
    Top = 128
  end
  object qPerm: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from ADM_NIVEL')
    SQLConnection = dDADOS._Conexao
    Left = 632
    Top = 128
  end
end
