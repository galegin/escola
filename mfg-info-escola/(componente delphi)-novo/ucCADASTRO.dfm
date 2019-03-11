inherited cCADASTRO: TcCADASTRO
  Left = 250
  Top = 143
  Width = 812
  Height = 563
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'cCADASTRO'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited EditCancel: TEdit
    TabOrder = 3
  end
  object PageControl1: TPageControl [1]
    Left = 0
    Top = 27
    Width = 796
    Height = 471
    ActivePage = TabSheet1
    Align = alClient
    MultiLine = True
    TabOrder = 0
    TabPosition = tpBottom
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Pesquisa'
      object Panel2: TPanel
        Left = 0
        Top = 37
        Width = 788
        Height = 408
        Align = alClient
        TabOrder = 1
        object Panel1: TPanel
          Left = 8
          Top = 8
          Width = 761
          Height = 57
          TabOrder = 0
          object Label1: TLabel
            Left = 8
            Top = 8
            Width = 64
            Height = 13
            Caption = 'Pesquisar por'
          end
          object Shape1: TShape
            Left = 6
            Top = 22
            Width = 148
            Height = 25
            Shape = stRoundRect
          end
          object Bevel1: TBevel
            Left = 161
            Top = 3
            Width = 5
            Height = 50
          end
          object Label2: TLabel
            Left = 344
            Top = 8
            Width = 106
            Height = 13
            Caption = 'Express'#227'o a pesquisar'
          end
          object Shape2: TShape
            Left = 342
            Top = 22
            Width = 285
            Height = 25
            Shape = stRoundRect
          end
          object SpeedButton1: TSpeedButton
            Left = 640
            Top = 10
            Width = 113
            Height = 38
            Caption = 'Pesquisar'
            Flat = True
            Glyph.Data = {
              C20C0000424DC20C000000000000420000002800000028000000280000000100
              100003000000800C000000000000000000000000000000000000007C0000E003
              00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7CFF7FBD777B6F7B6FBD77FF7F1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CDE7BF75E
              1042EF3D734E39679C739C739C73BD77BD77DE7BFF7F1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C3D5F9F633F4F353A8C31EF3D3146524A734E734E
              B556F75E7B6FDE7BFF7F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CBE733D57
              9F5F7F57DA46773E563E353A343AF235D035AD3531461863DE7B1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7CDF773C5B5D5F7F5F7F5B7F5B7F5B7F5B7F5B
              5F53993EAE3110429C731F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CFF7FDE7BBD77BD77BD77BD77DE7B
              FF7FFF7F9E6F5C673C5F1B5B1B571C575D5B9F5FDB46CE397B6F1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CFF7FDE7B
              9C735A6BD65A9452734E734E9452F75E5A6B9C73DE7BBD775A6B39677B6FBD77
              5B6B7E5F7F5BCE397B6F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7CDE7B7B6FD65A5246D22992197211511150154D1D8C2D
              EF3D524AB556954E113ECE393146945254469F635E5B734EBD771F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CFF7FBD7718633532B615
              B815B919B921B921B9219921981D551510112D1DD031BA46BC423636B02DF235
              5C5BBF6798465A6BFF7F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7CFF7FBD77D84E1916DA11781D782195259525781D781D982199259929
              B925F829FC4A5F57FD46BC423D57FF73DF6B77421963DE7B1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CDE7BD9421B0E57153615150D
              150950156F15F5081509DB05DB09B9155A3AFC4A1D4F5F57DC467A3A5D5B9E63
              573ECE395A6BFF7F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7CFF7F3B533C0E350DF408F300F300D4002F058911F200D40078011C0A7A32
              BB42FC4A1D4F5F533E539B429B3EBC42793AAD351863FF7F1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C9D6F5B1A1405D300F300F4001401
              16015001A209670513011601760D7A3EBB42DC461D4F9F5FDF6BBF635E571D4F
              FD46123E3967FF7F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              FF7F1C433505D300140115013601360157015301A001A0016A013501D0003836
              9B421D4F9E639E63BF67DF67DF67BF63FC4EF85ABD77FF7F1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CBE6F7C1EF40015013601560157017701
              79019201C001C001C0018D01AF00D4293E579E633D53FC4A1D4F5E5B7E5B773E
              954E9C73FF7F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              7E579709150136015701780198019901B901E5010002E001E001E501F000EC14
              DA4AFC4E1E4F5F531E4FFB4AD6254D1D524A9C731F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1D473501560177019801B901BA01DB01
              DA010302200200020502F201330103000500A90C0D19F42D763ACE217019100D
              10427B6F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              DC36360177019901BA01DB01DD01FD0114022A0223022C021A02FE01B9013101
              E300A100210001000405A8118D19320DEF3D7B6FFF7F1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CBC3257019901BA01DB01FB0133024D02
              4B02540253023B023F021D021C0219020202E001C00140012001A50D8B115209
              CF397B6FFF7F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              BC327801BA01DC0118026606810A560273068F0A7D067F025F023E023D021C02
              0F020002E001C001A2018405880D5209EF397B6FFF7F1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CDC369901DB01FC016B0AA012A216C516
              C41AD616BF16BF129F0A7F025F023E021D020602E501C7018C01680186097209
              11427B6F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              3D47BA01DC013406A112C31AE41EE426E3260927182B1F2BFF22BF167F065F02
              3E020C020402E301C001A001A305730D734EBD771F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C9E5FDA01DD015506C31EE422052B262F
              263325332A377E435F3B1F27BF127F023F022E0220020002E001C001A401B415
              F75EDE7B1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              FF6F5D1AFB01A816E322052B2637483B6E436B3F483B73479F4B3F37DF1E9F0A
              5E0247020C020402E201C001AA01142E7B6FFF7F1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CFF7F7E4B6A0EE31E052B2737493F7643
              BF53B24FB153FD67DF575F3FFF26BF0E5F023C0215020002E701C001D20DD65A
              DE7B1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7CFF730B2BC21E252F483B6C47954FDB57D85FD96BFF6FB8532D371B27B816
              8E0A3B02FB010A02E001EB01362E7B6FFF7F1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CFF7FDD63082B062F4D377043B253
              D65FFD63D45BDE5F934B2537062BCF1679023C02FD01D801090238163967FF7F
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7CFF7BBB5BD2220F2F533B964B9C4BD95BB957BD4F70432637032BC81A
              5D021E02FB01FB015C123A5FDE7B1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CFF7FDD63503F3133563B
              9647964F97476F47693F26330427C51A3A02FD013D0A9C225B67DE7B1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7CFF7FFF6B9A4B3437172F513F6E434B3F2837042FE222A316
              590A9E16FC3E9C6FFF7F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CFF7BDE67
              9D4F5A3F543F513BF922F326112FF7323C477D63DE7BFF7F1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CFF7FFF77DF67BE5F9E5B9E5FBE6FDE7B
              FF7F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
              1F7C1F7C1F7C}
          end
          object Label3: TLabel
            Left = 176
            Top = 8
            Width = 66
            Height = 13
            Caption = 'Tipo pesquisa'
          end
          object Shape6: TShape
            Left = 174
            Top = 22
            Width = 148
            Height = 25
            Shape = stRoundRect
          end
          object Bevel2: TBevel
            Left = 329
            Top = 3
            Width = 5
            Height = 50
          end
        end
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 37
        Width = 788
        Height = 408
        Align = alClient
        DataSource = _DataSource
        FixedColor = 12615680
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        PopupMenu = _PopupMenu
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
      object Panel4: TPanel
        Left = 0
        Top = 37
        Width = 788
        Height = 0
        Align = alTop
        TabOrder = 2
        Visible = False
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 788
        Height = 37
        Align = alTop
        TabOrder = 3
        Visible = False
        DesignSize = (
          788
          37)
        object LabelTpConsulta: TLabel
          Left = 8
          Top = 8
          Width = 64
          Height = 13
          Caption = 'Tipo consulta'
        end
        object LabelPesquisarPor: TLabel
          Left = 192
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
          Width = 105
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
          Left = 264
          Top = 8
          Width = 105
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
          Width = 345
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          OnExit = fDS_EXPRESSAOExit
          OnKeyDown = fDS_EXPRESSAOKeyDown
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Cadastro'
      ImageIndex = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 788
        Height = 445
        Align = alClient
        TabOrder = 0
        object ScrollBox1: TScrollBox
          Left = 1
          Top = 1
          Width = 786
          Height = 443
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          TabOrder = 0
          DesignSize = (
            786
            443)
          object LabelF12: TLabel
            Left = 596
            Top = 8
            Width = 165
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Duplo clique ou F12 para consultar'
            Transparent = True
          end
        end
      end
    end
  end
  inherited _CoolBar: TCoolBar
    Width = 796
    Bands = <
      item
        Control = _ToolBar
        ImageIndex = -1
        MinHeight = 23
        Width = 792
      end>
    inherited _ToolBar: TToolBar
      Width = 779
      ButtonWidth = 51
      object ToolButtonS1: TToolButton
        Left = 44
        Top = 0
        Width = 8
        Caption = 'ToolButtonS1'
        ImageIndex = 17
        Style = tbsSeparator
      end
      object ToolButtonLimpar: TToolButton
        Left = 52
        Top = 0
        Hint = '(F2)'
        AutoSize = True
        Caption = 'Limpar'
        ImageIndex = 13
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonLimparClick
      end
      object ToolButtonConsultar: TToolButton
        Left = 94
        Top = 0
        Hint = '(F4)'
        AutoSize = True
        Caption = 'Consultar'
        ImageIndex = 12
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonConsultarClick
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
      object ToolButtonExtrair: TToolButton
        Left = 195
        Top = 0
        Hint = '(F7)'
        AutoSize = True
        Caption = 'Extrair'
        ImageIndex = 5
        OnClick = ToolButtonExtrairClick
      end
      object ToolButtonS2: TToolButton
        Left = 235
        Top = 0
        Width = 8
        Caption = 'ToolButtonS2'
        ImageIndex = 11
        Style = tbsSeparator
      end
      object ToolButtonNovo: TToolButton
        Left = 243
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
        Left = 280
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
        Left = 321
        Top = 0
        Hint = '(F8)'
        AutoSize = True
        Caption = 'Excluir'
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonExcluirClick
      end
      object ToolButtonGravar: TToolButton
        Left = 363
        Top = 0
        Hint = '(F5)'
        AutoSize = True
        Caption = 'Gravar'
        ImageIndex = 13
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonGravarClick
      end
      object ToolButtonCancelar: TToolButton
        Left = 406
        Top = 0
        Hint = '(ESC)'
        AutoSize = True
        Caption = 'Cancelar'
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonCancelarClick
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
  object PanelImpressao: TPanel [4]
    Left = 239
    Top = 80
    Width = 317
    Height = 33
    BevelInner = bvLowered
    Caption = 'Gerando impress'#227'o aguarde'
    Color = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -21
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Visible = False
    object _ProgressBar: TProgressBar
      Left = 2
      Top = 25
      Width = 313
      Height = 6
      Align = alBottom
      TabOrder = 0
    end
  end
  inherited _DataSet: TClientDataSet
    AfterEdit = _DataSetAfterEdit
    AfterScroll = _DataSetAfterScroll
  end
  inherited _DataSource: TDataSource
    OnStateChange = DataSource1StateChange
  end
end
