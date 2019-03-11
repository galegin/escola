object cOBS: TcOBS
  Left = 199
  Top = 110
  Width = 696
  Height = 480
  Caption = 'Obs'
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 66
    Width = 680
    Height = 376
    Align = alClient
    TabOrder = 0
    object Shape6: TShape
      Left = 6
      Top = 6
      Width = 675
      Height = 365
    end
    object MemoOBS: TMemo
      Left = 8
      Top = 8
      Width = 671
      Height = 361
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object MemoDDL: TMemo
      Left = 40
      Top = 256
      Width = 185
      Height = 89
      Lines.Strings = (
        
          '/***************************************************************' +
          '***************/'
        
          '/****                               DDL                         ' +
          '           ****/'
        
          '/***************************************************************' +
          '***************/'
        ''
        'CREATE TABLE OBS ('
        '    CD_TABELA    VARCHAR(20) NOT NULL,'
        '    CD_CHAVE     INTEGER NOT NULL,'
        '    CD_SEQ       INTEGER NOT NULL,'
        '    DS_LINHA     VARCHAR(80),'
        '    CD_USUARIO   INTEGER,'
        '    DT_CADASTRO  DATE'
        ') ^'
        ''
        
          '/***************************************************************' +
          '***************/'
        
          '/****                             Primary Keys                  ' +
          '           ****/'
        
          '/***************************************************************' +
          '***************/'
        ''
        
          'ALTER TABLE OBS ADD CONSTRAINT PK_OBS PRIMARY KEY (CD_SEQ, CD_TA' +
          'BELA, CD_CHAVE) ^'
        ''
        
          '/***************************************************************' +
          '***************/'
        
          '/****                               Triggers                    ' +
          '           ****/'
        
          '/***************************************************************' +
          '***************/'
        ''
        '/* Trigger: OBS_INC */'
        'CREATE TRIGGER OBS_INC FOR OBS'
        'ACTIVE BEFORE INSERT POSITION 0'
        'as'
        '  Declare Variable Cont Integer;'
        'begin'
        '  select Count( CD_SEQ ) From OBS'
        '  where CD_TABELA = new.CD_TABELA'
        '    And CD_CHAVE = new.CD_CHAVE'
        '  Into Cont;'
        '  if (Cont = 0) then'
        '  begin'
        '    new.CD_SEQ = 1;'
        '  end'
        '  else'
        '  begin'
        '    select Max( CD_SEQ ) From OBS'
        '    where CD_TABELA = new.CD_TABELA'
        '      And CD_CHAVE = new.CD_CHAVE'
        '    Into Cont;'
        '    new.CD_SEQ = Cont + 1;'
        '  end'
        'end'
        '^')
      TabOrder = 1
      Visible = False
      WordWrap = False
    end
    object MemoMOD: TMemo
      Left = 232
      Top = 256
      Width = 185
      Height = 89
      Lines.Strings = (
        '<COMPROVANTE>'
        '<COPIAS,2> <COLUNAS,1> <LARGURA,40>'
        ''
        '  **** COMPROVANTE DE PAGAMENTO ****'
        ''
        'CLIENTE:<CD_CLIENTE,6>-<NM_CLIENTE,25>'
        'CIDADE.:<DS_CIDADE,20>'
        ''
        '----------------------------------------'
        'No.Fatura:<CD_MOV,6>'
        'Prestacao:<DS_TITULO,20>'
        'Dt.Vencto:<DT_VENC,10>   Valor:<VL_TITULO,10>'
        '                      Acr/Desc:<VL_ACRDES,10>'
        'Dt.Pago..:<DT_PAGO,10> Vl.Pago:<VL_PAGO,10>'
        '----------------------------------------'
        '<NM_FANTASIA,40>'
        'CIANORTE - PR <DT_SIS,10> <HR_SIS,8>'
        '</COMPROVANTE>'
        ''
        '<CUPOM>'
        '<COPIAS,1> <COLUNAS,2> <LARGURA,50>'
        '<NM_FANTASIA,34> Data:<DT_SIS,10>'
        ''
        'Fone <FN_EMP,16>                   Hora:<HR_SIS,8>'
        '--------------------------------------------------'
        'Codigo...:<CD_CLIENTE,6>'
        'Nome.....:<NM_CLIENTE,20>'
        'Endereco.:<ENDERECO,40>'
        'Compl....:<COMPLEMENTO,40>'
        'Orcamento:<CD_MOV,6>'
        'Data.....:<DT_MOV,10>'
        'Usuario..:<CD_USUARIO,5>'
        '--------------------------------------------------'
        'Qtde Produto                      Unitario   Total'
        ''
        '<ITENS>'
        '<QT_MOV,4> <DS_PRODUTO,29> <VL_UNIT,7> <VL_TOTAL,7>'
        ''
        '          Total..........: <VL_PRODUTOS,8>'
        '          Descontos......: <VL_DESCONTOS,8>'
        '          A pagar........: <VL_APAGAR,8>'
        '--------------------------------------------------'
        '<MENSAGEM,50>'
        ''
        '        ASS:_____________________________'
        '--------------------------------------------------'
        '          * * * SEM VALOR FISCAL * * *'
        '</CUPOM>'
        '<PRESTACAO>'
        '<COPIAS,2> <COLUNAS,1> <LARGURA,40>'
        '<NM_FANTASIA,24> Data:<DT_SIS,10>'
        ''
        'Fone <FN_EMP,16>      Hora:<HR_SIS,8>'
        '----------------------------------------'
        'Codigo...:<CD_CLIENTE,6>'
        'Nome.....:<NM_CLIENTE,20>'
        'Endereco.:<ENDERECO,30>'
        'Compl....:<COMPLEMENTO,40>'
        'Orcamento:<CD_MOV,6>'
        'Data.....:<DT_MOV,10>'
        'Usuario..:<CD_USUARIO,5>'
        '----------------------------------------'
        'Qtde Produto            Unitario   Total'
        ''
        '<ITENS>'
        '<QT_MOV,4> <DS_PRODUTO,19> <VL_UNIT,7> <VL_TOTAL,7>'
        ''
        '----------------------------------------'
        'Servico                            Valor'
        ''
        '<SERVICOS>'
        '<DS_SERVICO,29> <VL_SERVICO,10>'
        ''
        '          Total..........: <VL_PRODUTOS,8>'
        '          Descontos......: <VL_DESCONTOS,8>'
        '          A pagar........: <VL_APAGAR,8>'
        '----------------------------------------'
        '<MENSAGEM,40>'
        ''
        '   ASS:_____________________________'
        '----------------------------------------'
        '     * * * SEM VALOR FISCAL * * *'
        '</PRESTACAO>')
      TabOrder = 2
      Visible = False
      WordWrap = False
    end
  end
  object CoolBar2: TCoolBar
    Left = 0
    Top = 0
    Width = 680
    Height = 66
    AutoSize = True
    Bands = <
      item
        Control = ToolBar2
        ImageIndex = -1
        MinHeight = 62
        Width = 676
      end>
    Images = dDADOS._ImageList
    object ToolBar2: TToolBar
      Left = 9
      Top = 0
      Width = 663
      Height = 62
      AutoSize = True
      ButtonHeight = 60
      ButtonWidth = 54
      Caption = 'ToolBar1'
      Flat = True
      Images = dDADOS._ImageList
      PopupMenu = PopupMenu1
      ShowCaptions = True
      TabOrder = 0
      object ToolButtonConfirma: TToolButton
        Left = 0
        Top = 0
        Hint = '(F5)'
        Caption = '&Confirma'
        ImageIndex = 12
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonConfirmaClick
      end
      object ToolButtonCancela: TToolButton
        Left = 54
        Top = 0
        Hint = '(ESC)'
        Caption = 'C&ancela'
        ImageIndex = 6
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonCancelaClick
      end
      object ToolButtonFechar: TToolButton
        Left = 108
        Top = 0
        Hint = '(ESC)'
        Caption = '&Fechar'
        ImageIndex = 10
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonFecharClick
      end
      object ToolButtonAbrir: TToolButton
        Left = 162
        Top = 0
        Caption = 'Abrir'
        ImageIndex = 11
        OnClick = ToolButtonAbrirClick
      end
      object ToolButtonSalvar: TToolButton
        Left = 216
        Top = 0
        Caption = 'Salvar'
        ImageIndex = 12
        OnClick = ToolButtonSalvarClick
      end
      object Label1: TLabel
        Left = 270
        Top = 0
        Width = 121
        Height = 60
        Caption = '    F5-Criar arquivo de obs'#13#10'    F6-Padr'#227'o'
        Transparent = True
      end
    end
  end
  object SQLQueryOBS: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'CD_ENTIDADE'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'CD_CHAVE'
        ParamType = ptUnknown
      end>
    SQL.Strings = (
      'select DS_LINHA From OBS_ENTIDADE'
      'where CD_ENTIDADE=:CD_ENTIDADE'
      '  And CD_CHAVE=:CD_CHAVE'
      'Order By NR_LINHA')
    SQLConnection = dDADOS._Conexao
    Left = 432
    Top = 80
  end
  object PopupMenu1: TPopupMenu
    Left = 400
    Top = 80
    object Inserir1: TMenuItem
      Caption = 'Inserir'
      object Complemento1: TMenuItem
        Caption = 'Complemento'
        OnClick = Complemento1Click
      end
    end
  end
end
