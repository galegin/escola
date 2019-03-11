unit ucCONST;

interface

const

  //Sistema

  BAN_SIS = 'BanSis'; //Banco de dados
  TIP_BAN = 'TipSis'; //Tipo de Banco de dados
  USU_BAN = 'UsuSis'; //Usuario de Banco de dados
  SEN_BAN = 'SenSis'; //Senha de Banco de dados

  CLR_SIS = 'ClrSis'; //Cor controle
  APA_SIS = 'ApaSis'; //Aparencia
  PRT_SIS = 'PrtSis'; //Protegido
  INS_SIS = 'InsSis'; //Data instalacao
  VRS_SIS = 'VrsSis'; //Versao
  TRA_SIS = 'TraSis'; //Tracer log do sistema
  ATU_SIS = 'AtuSis'; //Atualizacao sistema

  IND_DEB = 'IndDeb'; //Indicador debug

  //Manutencao

  AUT_MAN = 'AutMan'; //Consulta automatica
  FIL_MAN = 'FilMan'; //Filtro manutencao
  CTR_MAN = 'CtrMan'; //Tela centralizada
  DPL_MAN = 'DblMan'; //Duplo click F12

  INC_MAN = 'IncMan'; //Campo incremento
  COL_MAN = 'ColMan'; //Campos de manutencao visiveis
  DES_MAN = 'DesMan'; //Descricao dos campos
  KEY_MAN = 'KeyMan'; //Campos chave
  STP_MAN = 'StpMan'; //TabStop dos campos
  REA_MAN = 'ReaMan'; //Somente leitura dos campos
  TAM_MAN = 'TamMan'; //Tamanho dos campos
  DEC_MAN = 'DecMan'; //Decimais dos campos
  LAR_MAN = 'LarMan'; //Largura tela
  ALT_MAN = 'AltMan'; //Altura tela
  TAB_MAN = 'TabMan'; //Nome da tabela
  MOD_MAN = 'ModMan'; //Modo tela (consulta/manutencao/...)
  ATA_MAN = 'AtaMan'; //Atalho tela
  VAL_MAN = 'ValMan'; //Valida manutencao
  RED_MAN = 'RedMan'; //Manutencao reduzida
  CAD_DES = 'CadDes'; //Cadastra descricao campo chave estrangeira

  TIP_CNS = 'TipCns'; //Tipo consulta
  COD_CNS = 'CodCns'; //Campo consulta
  ORD_CNS = 'OrdCns'; //Ordenacao consulta
  DES_CNS = 'DesCns'; //Descricao consulta

  QTD_IMP = 'QtdImp'; //Qtde impressao

  //Tabela

  NOM_TAB = 'MonTab'; //Tabela filha da tela
  ALT_TAB = 'AltTab'; //Altura
  LAR_TAB = 'LarTab'; //Largura

  //Relatorio

  PAP_REP = 'PapRep'; //Papel
  ORI_REP = 'OriRep'; //Orientacao
  TIT_REP = 'TitRep'; //Titulo
  AGR_REP = 'AgrRep'; //Agrupadores
  COL_REP = 'ColRep'; //Colunas
  DES_REP = 'DesRep'; //Descricao
  POS_REP = 'PosRep'; //Posicao
  TAM_REP = 'TamRep'; //Tamanho
  FON_REP = 'FonRep'; //Fonte
  TOT_REP = 'TotRep'; //Totalizar
  AUT_REP = 'AutRep'; //Automatico
  VIS_REP = 'VisRep'; //Visualizar relatorio
  CFG_REP = 'CfgRep'; //Configura relatorio
  TXT_REP = 'TxtRep'; //Texto

  //Banda relatorio

  CAB_BND = 'CabBnd'; //Cabecalho
  TIT_BND = 'TitBnd'; //Titulo relatorio
  COL_BND = 'ColBnd'; //Titulo colunas
  DET_BND = 'DetBnd'; //Detalhe
  SUM_BND = 'SumBnd'; //Somatoria
  ROD_BND = 'RodBnd'; //Rodape
  AGR_BND = 'AgrBnd'; //Agrupador
  TOT_BND = 'TotBnd'; //Totalizador

  //Diretorio

  CFG_SIS = 'configuracao.exe';
  REL_SIS = 'relatorio.exe';
  GRF_SIS = 'grafico.exe';

  //Preview

  FNT_COD = 'FntCod';      //Codigo fonte
  FNT_TAM = 'FntTam';      //Tamanho fonte
  FNT_DEF = 'Courier New'; //Fonte padrao
  FNT_LEN = 8;             //Tamanho padrao

  //Email

  EML_SERV = 'EmlServ'; //Servidor
  EML_PORT = 'EmlPort'; //Porta
  EML_USER = 'EmlUser'; //Usuario
  EML_PASS = 'EmlPass'; //Password
  EML_MAIL = 'EmlMail'; //Email
  EML_NOME = 'EmlNome'; //Nome

  //Exportacao
  EXP_INI  = 'ExpIni';
  EXP_SEP  = 'ExpSep';
  EXP_VIS  = 'ExpVis';

  //Outros

  INF_LIV = 'InfLiv'; //Informa livro
  IMP_REC = 'ImpRec'; //Imprime recibo
  IMP_CAR = 'ImpCar'; //Imprime cartao
  IMP_LIV = 'ImpLiv'; //Imprime livro

  //Locacao

  ISE_MUL = 'IseMul'; // isenta multa
  ISE_MOT = 'IseMot'; // isenta motivo

  //Estados

  cLST_UF =
    'AC|AL|AM|AP|BA|CE|DF|ES|FN|GO|MA|MG|MS|MT|PA|PB|PE|PI|PR|RJ|RN|RO|RR|RS|SC|SE|SP|TO';

  //Tipagem

  cLST_TIPAGEM =
    '<TP_PARAMETRO>1=Data;2=Numerico;3=String</TP_PARAMETRO>' +
    '<TP_SITUACAO>1=Normal;2=Cancelado;3=Excluido</TP_SITUACAO>' +
    '<TP_PRIVILEGIO>1=Suporte;2=Administrador;3=Operador;4=Consulta</TP_PRIVILEGIO>' +
    '<TP_DOCUMENTO>1=Dinheiro;2=Cheque;3=Fatura</TP_DOCUMENTO>' +
    '<DS_UF>' + cLST_UF + '</DS_UF>' ;

  cLST_CONF =
    '<field cod="{cod}" des="{des}" tpf="{tpf}" tpd="{tdp}" tam="{tam}" dec="{dec}" ' +
           'lst="{lst}" def="{def}" inc="{inc}" cls="{cls}" />' ;

  cLST_TIPOFIELD =
    'key|req|nul';

  cLST_TIPODADO =
    'ftBoolean|ftDate|ftDateTime|ftFloat|ftGraphic|ftInteger|ftMemo|ftString';

  //Mensagem

  cMESSAGE_SEMPERMISSAO = 'Usuário sem permissão para acessar!';
  cMESSAGE_USERINVALIDO = 'Usuário inválido!';
  cMESSAGE_PASSINVALIDA = 'Senha inválida!';
  cMESSAGE_CONSULTAVAZIA = 'Consulta vazia!';
  cMESSAGE_NENHUMREGISTRO = 'Nenhum registro encontrado para a consulta!';
  cMESSAGE_DATAINVALIDA = 'Data inválida!';
  cMESSAGE_INTEIROINVALIDO = 'Inteiro inválido!';
  cMESSAGE_NUMEROINVALIDO = 'Numero inválido!';

implementation

end.
