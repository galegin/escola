inherited cMANUTENCAO: TcMANUTENCAO
  Left = 0
  Top = 25
  Width = 812
  Height = 563
  Caption = 'cMANUTENCAO'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox [0]
    Left = 0
    Top = 23
    Width = 796
    Height = 475
    HorzScrollBar.Tracking = True
    VertScrollBar.Tracking = True
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 3
    DesignSize = (
      796
      475)
    object LabelF12: TLabel
      Left = 616
      Top = 8
      Width = 165
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Duplo clique ou F12 para consultar'
      Transparent = True
    end
    object Image1: TImage
      Left = 440
      Top = 176
      Width = 337
      Height = 121
      Visible = False
    end
    object StringGrid1: TStringGrid
      Left = 440
      Top = 304
      Width = 337
      Height = 120
      DefaultRowHeight = 21
      FixedColor = 12615680
      FixedCols = 0
      TabOrder = 0
      Visible = False
      ColWidths = (
        64
        64
        64
        64
        64)
    end
    object Memo1: TMemo
      Left = 440
      Top = 48
      Width = 337
      Height = 121
      Lines.Strings = (
        'Memo1')
      TabOrder = 1
      Visible = False
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
      object ToolButtonConfirmar: TToolButton
        Left = 44
        Top = 0
        AutoSize = True
        Caption = 'Confirmar'
        ImageIndex = 13
        OnClick = ToolButtonConfirmarClick
      end
      object ToolButtonCancelar: TToolButton
        Left = 99
        Top = 0
        Hint = '(F4)'
        AutoSize = True
        Caption = 'Cancelar'
        ImageIndex = 12
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
  inherited _DataSet: TClientDataSet
    AfterEdit = _DataSetAfterEdit
  end
end
