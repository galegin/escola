inherited fINATIVO: TfINATIVO
  Left = 450
  Top = 233
  Caption = 'fINATIVO'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    inherited TabSheet1: TTabSheet
      inherited Panel2: TPanel
        Top = 226
        Height = 180
      end
      inherited DBGrid1: TDBGrid
        Top = 226
        Height = 180
      end
      inherited Panel4: TPanel
        Top = 0
        Height = 137
        Visible = True
        object Label5: TLabel
          Left = 8
          Top = 8
          Width = 56
          Height = 13
          Caption = 'C'#243'd. inativo'
          Transparent = True
        end
        object Label7: TLabel
          Left = 8
          Top = 32
          Width = 45
          Height = 13
          Caption = 'Nome pai'
          Transparent = True
        end
        object Label8: TLabel
          Left = 8
          Top = 56
          Width = 51
          Height = 13
          Caption = 'Nome m'#227'e'
          Transparent = True
        end
        object Label9: TLabel
          Left = 8
          Top = 80
          Width = 51
          Height = 13
          Caption = 'C'#243'd. curso'
        end
        object Label4: TLabel
          Left = 584
          Top = 8
          Width = 44
          Height = 13
          Caption = 'Prateleira'
        end
        object Label10: TLabel
          Left = 584
          Top = 32
          Width = 40
          Height = 13
          Caption = 'Corredor'
        end
        object Label11: TLabel
          Left = 584
          Top = 56
          Width = 23
          Height = 13
          Caption = 'Livro'
        end
        object Label12: TLabel
          Left = 584
          Top = 80
          Width = 33
          Height = 13
          Caption = 'P'#225'gina'
        end
        object Label13: TLabel
          Left = 584
          Top = 104
          Width = 27
          Height = 13
          Caption = 'Pasta'
        end
        object fNM_INATIVO: TEdit
          Left = 224
          Top = 8
          Width = 313
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 1
        end
        object fNR_INATIVO: TEdit
          Left = 96
          Top = 8
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object fNM_PAI: TEdit
          Left = 96
          Top = 32
          Width = 441
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 2
        end
        object fNM_MAE: TEdit
          Left = 96
          Top = 56
          Width = 441
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 3
        end
        object fCD_CURSO: TEdit
          Left = 96
          Top = 80
          Width = 121
          Height = 21
          TabOrder = 4
        end
        object dfCD_CURSO: TEdit
          Left = 224
          Top = 80
          Width = 313
          Height = 21
          TabStop = False
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 5
        end
        object DBEdit1: TDBEdit
          Left = 648
          Top = 8
          Width = 121
          Height = 21
          TabStop = False
          Color = clBtnFace
          DataField = 'NR_PRATELEIRA'
          DataSource = DataSource1
          ReadOnly = True
          TabOrder = 6
        end
        object DBEdit2: TDBEdit
          Left = 648
          Top = 32
          Width = 121
          Height = 21
          TabStop = False
          Color = clBtnFace
          DataField = 'NR_CORREDOR'
          DataSource = DataSource1
          ReadOnly = True
          TabOrder = 7
        end
        object DBEdit3: TDBEdit
          Left = 648
          Top = 56
          Width = 121
          Height = 21
          TabStop = False
          Color = clBtnFace
          DataField = 'NR_LIVRO'
          DataSource = DataSource1
          ReadOnly = True
          TabOrder = 8
        end
        object DBEdit4: TDBEdit
          Left = 648
          Top = 80
          Width = 121
          Height = 21
          TabStop = False
          Color = clBtnFace
          DataField = 'NR_PAGINA'
          DataSource = DataSource1
          ReadOnly = True
          TabOrder = 9
        end
        object DBEdit5: TDBEdit
          Left = 648
          Top = 104
          Width = 121
          Height = 21
          TabStop = False
          Color = clBtnFace
          DataField = 'NR_INATIVO'
          DataSource = DataSource1
          ReadOnly = True
          TabOrder = 10
        end
      end
      inherited Panel5: TPanel
        Top = 185
      end
      object TabControl1: TTabControl
        Left = 0
        Top = 137
        Width = 788
        Height = 48
        Align = alTop
        TabOrder = 4
        OnChange = TabControl1Change
      end
    end
  end
  inherited CoolBar1: TCoolBar
    inherited ToolBar1: TToolBar
      object ToolButtonCartao: TToolButton
        Left = 475
        Top = 0
        Caption = 'Cart'#227'o'
        ImageIndex = 16
        OnClick = ToolButtonCartaoClick
      end
    end
  end
  inherited PopupMenu1: TPopupMenu
    object ImpressoCartaotexto1: TMenuItem
      Caption = 'Impress'#227'o cart'#227'o texto'
      OnClick = ImpressoCartaotexto1Click
    end
  end
end
