inherited fLOCACAO: TfLOCACAO
  Left = 112
  Top = 222
  Caption = 'fLOCACAO'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    inherited TabSheet1: TTabSheet
      inherited Panel2: TPanel
        Top = 169
        Height = 276
      end
      inherited DBGrid1: TDBGrid
        Top = 169
        Height = 276
      end
      inherited Panel4: TPanel
        Top = 0
        Height = 132
        Visible = True
        object LabelLivro: TLabel
          Left = 8
          Top = 56
          Width = 44
          Height = 13
          Caption = 'C'#243'd. livro'
          Transparent = True
        end
        object LabelLocador: TLabel
          Left = 8
          Top = 8
          Width = 60
          Height = 13
          Caption = 'C'#243'd. locador'
          Transparent = True
        end
        object LabelTipo: TLabel
          Left = 8
          Top = 80
          Width = 57
          Height = 13
          Caption = 'Tp. loca'#231#227'o'
        end
        object LabelAtrasado: TLabel
          Left = 280
          Top = 82
          Width = 42
          Height = 13
          Caption = 'Atrasado'
        end
        object LabelTurma: TLabel
          Left = 8
          Top = 32
          Width = 51
          Height = 13
          Caption = 'C'#243'd. turma'
        end
        object LabelAgrupar: TLabel
          Left = 8
          Top = 104
          Width = 55
          Height = 13
          Caption = 'Agrupar por'
        end
        object LabelSaldo: TLabel
          Left = 400
          Top = 80
          Width = 123
          Height = 24
          Caption = 'Saldo devedor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object fCD_LOCADOR: TEdit
          Left = 128
          Top = 8
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object fCD_LIVRO: TEdit
          Left = 128
          Top = 56
          Width = 121
          Height = 21
          TabOrder = 4
        end
        object dfCD_LIVRO: TEdit
          Left = 256
          Top = 56
          Width = 393
          Height = 21
          TabStop = False
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 5
        end
        object dfCD_LOCADOR: TEdit
          Left = 256
          Top = 8
          Width = 393
          Height = 21
          TabStop = False
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 1
        end
        object fTP_LOCACAO: TComboBox
          Left = 128
          Top = 80
          Width = 121
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 6
          OnKeyDown = fTP_LOCACAOKeyDown
        end
        object fIN_ATRASADO: TCheckBox
          Left = 259
          Top = 83
          Width = 12
          Height = 12
          Caption = 'Atrasado'
          TabOrder = 7
        end
        object fCD_TURMA: TEdit
          Left = 128
          Top = 32
          Width = 121
          Height = 21
          TabOrder = 2
        end
        object fTP_AGRUPAR: TComboBox
          Left = 128
          Top = 104
          Width = 121
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 8
          Text = 'Locador'
          OnKeyDown = fTP_LOCACAOKeyDown
          Items.Strings = (
            'Locador'
            'Livro'
            'Nenhum')
        end
        object eSALDO: TEdit
          Left = 528
          Top = 80
          Width = 121
          Height = 32
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
          Text = '0.00'
        end
        object dfCD_TURMA: TEdit
          Left = 256
          Top = 32
          Width = 393
          Height = 21
          TabStop = False
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 3
        end
      end
      inherited Panel5: TPanel
        Top = 132
      end
    end
    inherited TabSheet2: TTabSheet
      inherited Panel3: TPanel
        Height = 406
        inherited ScrollBox1: TScrollBox
          Height = 404
        end
      end
    end
  end
  inherited _CoolBar: TCoolBar
    inherited _ToolBar: TToolBar
      object ToolButtonLocar: TToolButton
        Left = 459
        Top = 0
        Hint = '(F5)'
        AutoSize = True
        Caption = 'Locar'
        ImageIndex = 11
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonLocarClick
      end
      object ToolButtonRenovar: TToolButton
        Left = 497
        Top = 0
        Hint = '(F6)'
        AutoSize = True
        Caption = 'Renovar'
        ImageIndex = 12
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonRenovarClick
      end
      object ToolButtonDevolver: TToolButton
        Left = 549
        Top = 0
        Hint = '(F7)'
        AutoSize = True
        Caption = 'Devolver'
        ImageIndex = 13
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonDevolverClick
      end
      object ToolButtonPgDebito: TToolButton
        Left = 603
        Top = 0
        Hint = '(F8)'
        AutoSize = True
        Caption = 'Pg. D'#233'b.'
        ImageIndex = 14
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonPgDebitoClick
      end
      object ToolButtonConsulta: TToolButton
        Left = 656
        Top = 0
        Hint = '(F9)'
        AutoSize = True
        Caption = 'Consulta'
        ImageIndex = 15
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonConsultaClick
      end
    end
  end
  inherited _PopupMenu: TPopupMenu
    object N5: TMenuItem
      Caption = '-'
    end
    object bImprimeRecibo: TMenuItem
      Caption = 'Imprime recibo'
      OnClick = bImprimeReciboClick
    end
    object bInformaLivro: TMenuItem
      Caption = 'Informa livro'
      OnClick = bInformaLivroClick
    end
    object bInformaLivroAuto: TMenuItem
      Caption = 'Informa livro auto'
      OnClick = bInformaLivroAutoClick
    end
    object bIsentaMulta: TMenuItem
      Caption = 'Isenta multa'
      OnClick = bIsentaMultaClick
    end
    object bIsentaMotivo: TMenuItem
      Caption = 'Isenta motivo'
      OnClick = bIsentaMotivoClick
    end
  end
end
