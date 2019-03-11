object fINFLIV: TfINFLIV
  Left = 352
  Top = 215
  BorderStyle = bsDialog
  Caption = 'Informar livro'
  ClientHeight = 159
  ClientWidth = 665
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 665
    Height = 159
    Align = alClient
    TabOrder = 0
    object LabelLivro: TLabel
      Left = 8
      Top = 40
      Width = 44
      Height = 13
      Caption = 'C'#243'd. livro'
      Transparent = True
    end
    object LabelLocador: TLabel
      Left = 8
      Top = 16
      Width = 60
      Height = 13
      Caption = 'C'#243'd. locador'
      Transparent = True
    end
    object LabelDevolucao: TLabel
      Left = 8
      Top = 88
      Width = 76
      Height = 13
      Caption = 'Data devolu'#231#227'o'
      Transparent = True
    end
    object LabelExemplar: TLabel
      Left = 8
      Top = 64
      Width = 59
      Height = 13
      Caption = 'Nr. exemplar'
      Transparent = True
    end
    object Label1: TLabel
      Left = 256
      Top = 64
      Width = 59
      Height = 13
      Caption = 'Qt. exemplar'
      Transparent = True
    end
    object fCD_LOCADOR: TEdit
      Left = 128
      Top = 16
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object fCD_LIVRO: TEdit
      Left = 128
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 2
    end
    object dfCD_LIVRO: TEdit
      Left = 256
      Top = 40
      Width = 393
      Height = 21
      TabStop = False
      CharCase = ecUpperCase
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 3
    end
    object dfCD_LOCADOR: TEdit
      Left = 256
      Top = 16
      Width = 393
      Height = 21
      TabStop = False
      CharCase = ecUpperCase
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object BtnOk: TBitBtn
      Left = 128
      Top = 124
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 7
      OnClick = BtnOkClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BtnCancel: TBitBtn
      Left = 208
      Top = 124
      Width = 75
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 8
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object fDT_DEVOLUCAO: TEdit
      Left = 128
      Top = 88
      Width = 121
      Height = 21
      TabOrder = 6
      Text = '  /  /'
    end
    object fNR_EXEMPLAR: TEdit
      Left = 128
      Top = 64
      Width = 121
      Height = 21
      TabOrder = 4
      OnEnter = fNR_EXEMPLAREnter
    end
    object QT_EXEMPLAR: TEdit
      Left = 324
      Top = 64
      Width = 121
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 5
    end
  end
end
