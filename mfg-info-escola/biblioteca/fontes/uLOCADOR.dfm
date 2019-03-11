inherited fLOCADOR: TfLOCADOR
  Caption = 'fLOCADOR'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    inherited TabSheet1: TTabSheet
      inherited Panel2: TPanel
        Top = 126
        Height = 319
      end
      inherited DBGrid1: TDBGrid
        Top = 126
        Height = 319
      end
      inherited Panel4: TPanel
        Top = 0
        Height = 89
        Visible = True
        object Label5: TLabel
          Left = 8
          Top = 8
          Width = 60
          Height = 13
          Caption = 'C'#243'd. locador'
        end
        object Label8: TLabel
          Left = 8
          Top = 32
          Width = 51
          Height = 13
          Caption = 'C'#243'd. curso'
        end
        object Label4: TLabel
          Left = 8
          Top = 56
          Width = 50
          Height = 13
          Caption = 'Tp. ensino'
        end
        object fCD_LOCADOR: TEdit
          Left = 80
          Top = 8
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object fNM_LOCADOR: TEdit
          Left = 208
          Top = 8
          Width = 289
          Height = 21
          TabOrder = 1
        end
        object fCD_CURSO: TEdit
          Left = 80
          Top = 32
          Width = 121
          Height = 21
          TabOrder = 2
        end
        object dfCD_CURSO: TEdit
          Left = 208
          Top = 32
          Width = 289
          Height = 21
          TabStop = False
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 3
        end
        object ButtonClassificar: TButton
          Left = 504
          Top = 56
          Width = 145
          Height = 17
          Caption = 'Classificar ensino'
          TabOrder = 4
          OnClick = ButtonClassificarClick
        end
        object fTP_ENSINO: TEdit
          Left = 80
          Top = 56
          Width = 121
          Height = 21
          TabOrder = 5
        end
        object dfTP_ENSINO: TEdit
          Left = 208
          Top = 56
          Width = 289
          Height = 21
          TabStop = False
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 6
        end
      end
      inherited Panel5: TPanel
        Top = 89
      end
    end
  end
  inherited _CoolBar: TCoolBar
    inherited _ToolBar: TToolBar
      object ToolButtonCarteira: TToolButton
        Left = 459
        Top = 0
        Caption = 'Carteira'
        ImageIndex = 16
        OnClick = ToolButtonCarteiraClick
      end
      object ToolButtonFoto: TToolButton
        Left = 510
        Top = 0
        Caption = 'Foto'
        ImageIndex = 15
        Visible = False
        OnClick = ToolButtonFotoClick
      end
    end
  end
end
