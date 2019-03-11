object cCLIENT: TcCLIENT
  Left = 1032
  Top = 116
  BorderStyle = bsDialog
  Caption = 'Configurar Caminho Acesso Banco de Dados'
  ClientHeight = 321
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 24
  object lblMensagem: TLabel
    Left = 8
    Top = 200
    Width = 569
    Height = 32
    Alignment = taCenter
    AutoSize = False
    Caption = 'SERVIDOR'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
  end
  object LabelLocal: TLabel
    Left = 8
    Top = 0
    Width = 569
    Height = 32
    Alignment = taCenter
    AutoSize = False
    Caption = 'IP LOCAL'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
  end
  object LabelCaminho: TLabel
    Left = 8
    Top = 128
    Width = 569
    Height = 32
    Alignment = taCenter
    AutoSize = False
    Caption = 'CAMINHO SERVIDOR'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
    OnClick = LabelCaminhoClick
  end
  object LabelServidor: TLabel
    Left = 7
    Top = 64
    Width = 569
    Height = 32
    Alignment = taCenter
    AutoSize = False
    Caption = 'IP SERVIDOR'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
  end
  object ipLocal: TEdit
    Left = 8
    Top = 32
    Width = 569
    Height = 32
    TabStop = False
    AutoSize = False
    BorderStyle = bsNone
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ipServidor: TEdit
    Left = 8
    Top = 96
    Width = 569
    Height = 32
    AutoSize = False
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = ipServidorChange
  end
  object dsCaminho: TEdit
    Left = 8
    Top = 160
    Width = 569
    Height = 32
    AutoSize = False
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnChange = ipServidorChange
    OnDblClick = LabelCaminhoClick
  end
  object EditFocus: TEdit
    Left = 24
    Top = 240
    Width = 1
    Height = 32
    TabStop = False
    TabOrder = 3
  end
  object btnTestar: TButton
    Left = 4
    Top = 240
    Width = 577
    Height = 32
    Caption = 'Testar'
    TabOrder = 4
    OnClick = btnTestarClick
  end
  object btnGravar: TButton
    Left = 3
    Top = 284
    Width = 577
    Height = 32
    Caption = 'Gravar'
    Enabled = False
    TabOrder = 5
    OnClick = btnGravarClick
  end
  object _Conexao: TSQLConnection
    Left = 320
    Top = 164
  end
end
