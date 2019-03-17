inherited fLIVRO: TfLIVRO
  Caption = 'fLIVRO'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    inherited TabSheet1: TTabSheet
      inherited Panel2: TPanel
        Top = 198
        Height = 218
      end
      inherited DBGrid1: TDBGrid
        Top = 198
        Height = 218
      end
      inherited Panel4: TPanel
        Top = 0
        Height = 161
        Visible = True
        object Label5: TLabel
          Left = 8
          Top = 8
          Width = 44
          Height = 13
          Caption = 'C'#243'd. livro'
        end
        object Label7: TLabel
          Left = 8
          Top = 32
          Width = 43
          Height = 13
          Caption = 'Ds. autor'
        end
        object Label8: TLabel
          Left = 8
          Top = 56
          Width = 51
          Height = 13
          Caption = 'C'#243'd. curso'
        end
        object Label9: TLabel
          Left = 8
          Top = 80
          Width = 58
          Height = 13
          Caption = 'C'#243'd. genero'
        end
        object Label10: TLabel
          Left = 8
          Top = 104
          Width = 57
          Height = 13
          Caption = 'C'#243'd. editora'
        end
        object Label6: TLabel
          Left = 8
          Top = 128
          Width = 50
          Height = 13
          Caption = 'Tp. ensino'
        end
        object fCD_LIVRO: TEdit
          Left = 80
          Top = 8
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object fDS_TITULO: TEdit
          Left = 208
          Top = 8
          Width = 289
          Height = 21
          TabOrder = 1
        end
        object fDS_AUTOR: TEdit
          Left = 80
          Top = 32
          Width = 417
          Height = 21
          TabOrder = 2
        end
        object fCD_CURSO: TEdit
          Left = 80
          Top = 56
          Width = 121
          Height = 21
          TabOrder = 3
        end
        object dfCD_CURSO: TEdit
          Left = 208
          Top = 56
          Width = 289
          Height = 21
          TabStop = False
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 4
        end
        object dfCD_GENERO: TEdit
          Left = 208
          Top = 80
          Width = 289
          Height = 21
          TabStop = False
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 5
        end
        object fCD_GENERO: TEdit
          Left = 80
          Top = 80
          Width = 121
          Height = 21
          TabOrder = 6
        end
        object dfCD_EDITORA: TEdit
          Left = 208
          Top = 104
          Width = 289
          Height = 21
          TabStop = False
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 7
        end
        object fCD_EDITORA: TEdit
          Left = 80
          Top = 104
          Width = 121
          Height = 21
          TabOrder = 8
        end
        object ButtonClassificar: TButton
          Left = 504
          Top = 128
          Width = 145
          Height = 21
          Caption = 'Classificar ensino'
          TabOrder = 9
          OnClick = ButtonClassificarClick
        end
        object dfTP_ENSINO: TEdit
          Left = 208
          Top = 128
          Width = 289
          Height = 21
          TabStop = False
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 10
        end
        object fTP_ENSINO: TEdit
          Left = 80
          Top = 128
          Width = 121
          Height = 21
          TabOrder = 11
        end
      end
      inherited Panel5: TPanel
        Top = 161
      end
      object PanelTotal: TPanel
        Left = 0
        Top = 416
        Width = 788
        Height = 29
        Align = alBottom
        BevelOuter = bvNone
        Caption = ' '
        TabOrder = 4
        object Label4: TLabel
          Left = 8
          Top = 4
          Width = 41
          Height = 13
          Caption = 'Tot. livro'
        end
        object LabelExemplar: TLabel
          Left = 208
          Top = 4
          Width = 64
          Height = 13
          Caption = 'Tot. exemplar'
        end
        object EditTotal: TEdit
          Left = 80
          Top = 4
          Width = 121
          Height = 21
          TabStop = False
          Color = clYellow
          ReadOnly = True
          TabOrder = 0
        end
        object EditExemplar: TEdit
          Left = 280
          Top = 4
          Width = 121
          Height = 21
          TabStop = False
          Color = clYellow
          ReadOnly = True
          TabOrder = 1
        end
      end
    end
  end
  inherited _CoolBar: TCoolBar
    inherited _ToolBar: TToolBar
      object ToolButtonEtiqueta: TToolButton
        Left = 459
        Top = 0
        AutoSize = True
        Caption = 'Etiqueta'
        ImageIndex = 16
        OnClick = ToolButtonEtiquetaClick
      end
    end
  end
end
