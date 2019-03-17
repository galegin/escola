inherited rRELETIQUETA: TrRELETIQUETA
  Functions.DATA = (
    '0'
    '0'
    #39#39)
  Page.Columns = 2
  Page.Values = (
    50.000000000000000000
    2970.000000000000000000
    50.000000000000000000
    2100.000000000000000000
    50.000000000000000000
    50.000000000000000000
    0.000000000000000000)
  object DetailBand: TQRBand [0]
    Left = 19
    Top = 19
    Width = 378
    Height = 240
    Frame.Color = clBlack
    Frame.DrawTop = True
    Frame.DrawBottom = True
    Frame.DrawLeft = True
    Frame.DrawRight = True
    Frame.Style = psDashDot
    AlignToBottom = False
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      635.000000000000000000
      1000.125000000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbDetail
    object QRImageLogo: TQRImage
      Left = 0
      Top = 0
      Width = 92
      Height = 113
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        298.979166666666700000
        0.000000000000000000
        0.000000000000000000
        243.416666666666700000)
      XLColumn = 0
      FullJustify = False
    end
    object QRLabelEscola: TQRLabel
      Left = 96
      Top = 4
      Width = 277
      Height = 55
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        145.520833333333300000
        254.000000000000000000
        10.583333333333330000
        732.895833333333300000)
      XLColumn = 0
      FullJustify = False
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'COL'#201'GIO ITACELINA BITTENCOURT'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      ExportAs = exptText
      FontSize = 14
    end
    object QRLabelTitulo: TQRLabel
      Left = 96
      Top = 64
      Width = 277
      Height = 49
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        129.645833333333300000
        254.000000000000000000
        169.333333333333300000
        732.895833333333300000)
      XLColumn = 0
      FullJustify = False
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'LOCACAO BIBLIOTECA'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      ExportAs = exptText
      FontSize = 14
    end
    object QRLabelLivro: TQRLabel
      Left = 4
      Top = 116
      Width = 89
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        10.583333333333330000
        306.916666666666700000
        235.479166666666700000)
      XLColumn = 0
      FullJustify = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Livro:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      ExportAs = exptText
      FontSize = 10
    end
    object QRDBTextTitulo: TQRDBText
      Left = 96
      Top = 116
      Width = 277
      Height = 41
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        108.479166666666700000
        254.000000000000000000
        306.916666666666700000
        732.895833333333300000)
      XLColumn = 0
      FullJustify = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = _DataSet
      DataField = 'DS_TITULO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      ExportAs = exptText
      FontSize = 10
    end
    object QRLabelEditora: TQRLabel
      Left = 4
      Top = 164
      Width = 89
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        10.583333333333330000
        433.916666666666700000
        235.479166666666700000)
      XLColumn = 0
      FullJustify = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Editora:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      ExportAs = exptText
      FontSize = 10
    end
    object QRLabelAutor: TQRLabel
      Left = 4
      Top = 188
      Width = 89
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        10.583333333333330000
        497.416666666666700000
        235.479166666666700000)
      XLColumn = 0
      FullJustify = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Autor:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      ExportAs = exptText
      FontSize = 10
    end
    object QRDBTextEditora: TQRDBText
      Left = 96
      Top = 164
      Width = 277
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        254.000000000000000000
        433.916666666666700000
        732.895833333333300000)
      XLColumn = 0
      FullJustify = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = _DataSet
      DataField = 'DS_EDITORA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      ExportAs = exptText
      FontSize = 10
    end
    object QRDBTextAutor: TQRDBText
      Left = 96
      Top = 188
      Width = 277
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        254.000000000000000000
        497.416666666666700000
        732.895833333333300000)
      XLColumn = 0
      FullJustify = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = _DataSet
      DataField = 'DS_AUTOR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      ExportAs = exptText
      FontSize = 10
    end
    object QRLabelAno: TQRLabel
      Left = 4
      Top = 210
      Width = 89
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        10.583333333333330000
        555.625000000000000000
        235.479166666666700000)
      XLColumn = 0
      FullJustify = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Ano:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      ExportAs = exptText
      FontSize = 10
    end
    object QRDBTextAno: TQRDBText
      Left = 96
      Top = 210
      Width = 277
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        254.000000000000000000
        555.625000000000000000
        732.895833333333300000)
      XLColumn = 0
      FullJustify = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = _DataSet
      DataField = 'NR_ANO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      ExportAs = exptText
      FontSize = 10
    end
  end
end
