inherited fCONSULTA: TfCONSULTA
  Caption = 'fCONSULTA'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    inherited TabSheet1: TTabSheet
      inherited Panel2: TPanel
        Height = 223
      end
      inherited DBGrid1: TDBGrid
        Height = 223
      end
      inherited Panel4: TPanel
        Visible = True
      end
      object DBGrid2: TDBGrid [3]
        Left = 0
        Top = 320
        Width = 788
        Height = 125
        Align = alBottom
        DataSource = DataSource2
        FixedColor = 12615680
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        TabOrder = 4
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWhite
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = DBGrid1DblClick
        OnKeyDown = DBGrid1KeyDown
        OnTitleClick = DBGrid1TitleClick
      end
      inherited Panel5: TPanel
        Visible = True
      end
      object Panel6: TPanel
        Left = 0
        Top = 260
        Width = 788
        Height = 60
        Align = alBottom
        TabOrder = 5
        DesignSize = (
          788
          60)
        object Label8: TLabel
          Left = 8
          Top = 8
          Width = 59
          Height = 13
          Caption = 'Qt. exemplar'
        end
        object Label9: TLabel
          Left = 8
          Top = 32
          Width = 64
          Height = 13
          Caption = 'Qt. disponivel'
        end
        object Label10: TLabel
          Left = 592
          Top = 8
          Width = 44
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'Prateleira'
        end
        object Label11: TLabel
          Left = 592
          Top = 32
          Width = 40
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'Corredor'
        end
        object Label4: TLabel
          Tag = -1
          Left = 1
          Top = 1
          Width = 786
          Height = 58
          Align = alClient
          Alignment = taCenter
          Caption = 'LOCA'#199#195'O'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object DBEdit1: TDBEdit
          Left = 80
          Top = 8
          Width = 121
          Height = 21
          TabStop = False
          Color = clBtnFace
          DataField = 'QT_EXEMPLAR'
          DataSource = _DataSource
          ReadOnly = True
          TabOrder = 0
        end
        object DBEdit2: TDBEdit
          Left = 80
          Top = 32
          Width = 121
          Height = 21
          TabStop = False
          Color = clBtnFace
          DataField = 'QT_EXEMPLAR'
          DataSource = _DataSource
          ReadOnly = True
          TabOrder = 1
        end
        object DBEdit3: TDBEdit
          Left = 664
          Top = 32
          Width = 121
          Height = 21
          TabStop = False
          Anchors = [akTop, akRight]
          Color = clBtnFace
          DataField = 'NR_CORREDOR'
          DataSource = _DataSource
          ReadOnly = True
          TabOrder = 2
        end
        object DBEdit4: TDBEdit
          Left = 664
          Top = 8
          Width = 121
          Height = 21
          TabStop = False
          Anchors = [akTop, akRight]
          Color = clBtnFace
          DataField = 'NR_PRATELEIRA'
          DataSource = _DataSource
          ReadOnly = True
          TabOrder = 3
        end
      end
    end
  end
  object SQLQuery2: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dDADOS._Conexao
    Left = 632
    Top = 128
  end
  object DataSetProvider2: TDataSetProvider
    DataSet = SQLQuery2
    Options = [poAllowMultiRecordUpdates, poAutoRefresh, poAllowCommandText]
    Left = 664
    Top = 128
  end
  object ClientDataSet2: TClientDataSet
    Aggregates = <>
    PacketRecords = 30
    Params = <>
    ProviderName = 'DataSetProvider2'
    AfterOpen = ClientDataSet2AfterOpen
    Left = 696
    Top = 128
  end
  object DataSource2: TDataSource
    DataSet = ClientDataSet2
    OnStateChange = DataSource1StateChange
    Left = 728
    Top = 128
  end
end
