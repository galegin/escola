unit uLOCACAO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, Provider, DB, DBClient, ExtCtrls, Grids,
  DBGrids, Buttons, StdCtrls, ComCtrls, ToolWin, FMTBcd,
  SqlExpr, DBCtrls, Menus, StrUtils, ucFORM;

type
  TfLOCACAO = class(TcCADASTRO)
    LabelLocador: TLabel;
    fCD_LOCADOR: TEdit;
    dfCD_LOCADOR: TEdit;
    LabelTurma: TLabel;
    fCD_TURMA: TEdit;
    dfCD_TURMA: TEdit;
    LabelLivro: TLabel;
    fCD_LIVRO: TEdit;
    dfCD_LIVRO: TEdit;
    ToolButtonLocar: TToolButton;
    ToolButtonRenovar: TToolButton;
    ToolButtonDevolver: TToolButton;
    ToolButtonPgDebito: TToolButton;
    ToolButtonConsulta: TToolButton;
    LabelTipo: TLabel;
    fTP_LOCACAO: TComboBox;
    LabelAtrasado: TLabel;
    fIN_ATRASADO: TCheckBox;
    LabelAgrupar: TLabel;
    fTP_AGRUPAR: TComboBox;
    LabelSaldo: TLabel;
    eSALDO: TEdit;
    N5: TMenuItem;
    bImprimeRecibo: TMenuItem;
    bInformaLivro: TMenuItem;
    bInformaLivroAuto: TMenuItem;
    bIsentaMulta: TMenuItem;
    bIsentaMotivo: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure fTP_LOCACAOKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ToolButtonConsultarClick(Sender: TObject);
    procedure ToolButtonImprimirClick(Sender: TObject);
    procedure ToolButtonLocarClick(Sender: TObject);
    procedure ToolButtonDevolverClick(Sender: TObject);
    procedure ToolButtonRenovarClick(Sender: TObject);
    procedure ToolButtonPgDebitoClick(Sender: TObject);
    procedure ToolButtonPgTodosDebitoClick(Sender: TObject);
    procedure ToolButtonLimparClick(Sender: TObject);
    procedure ToolButtonConsultaClick(Sender: TObject);
    procedure bImprimeReciboClick(Sender: TObject);
    procedure bInformaLivroClick(Sender: TObject);
    procedure bInformaLivroAutoClick(Sender: TObject);
    procedure bIsentaMultaClick(Sender: TObject);
    procedure bIsentaMotivoClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure EditExit(Sender: TObject);
    procedure _DataSetAfterOpen(DataSet: TDataSet);
  private
    FVlSaldo: Real;
    procedure SetVlSaldo(const Value: Real);
  public
  published
    property _VlSaldo : Real read FVlSaldo write SetVlSaldo;
  end;

var
  vInConsulta : Boolean;

implementation

{$R *.dfm}

uses
  ucRELATORIO, ucSELECT, ucFUNCAO, ucITEM, ucDADOS, ucCOMPPESQ, ucCOMP,
  ucCADASTROFUNC, uINFLIV, ucCONST, ucMENU, ucXML;

procedure TfLOCACAO.FormCreate(Sender: TObject);
begin
  inherited;

  cModoFormulario := mfConsulta;
  _TabMan := 'GER_LOCACAO';
  _KeyMan := 'CD_LOCACAO';

  bCpoMan := False;

  vInConsulta := True;

  cSQL :=
    'select a.CD_LOCACAO ' +
    ',      a.TP_SITUACAO ' +
    ',      a.CD_LIVRO || ''-'' || a.NR_EXEMPLAR as CD_LIVEXE ' +
    ',      a.CD_LIVRO ' +
    ',      a.NR_EXEMPLAR ' +
    ',      b.DS_TITULO ' +
    ',      a.CD_LOCADOR ' +
    ',      c.NM_LOCADOR ' +
    ',      c.CD_TURMA ' +
    ',      c.NR_ANO ' +
    ',      a.DT_LOCACAO ' +
    ',      a.DT_DEVOLUCAO ' +
    ',      a.DT_DEVOLVIDO ' +
    ',      a.VL_MULTA ' +
    ',      a.DT_PAGOMULTA ' +
    ',      a.TP_LOCACAO ' +
    ',      a.DS_ISENTAMOT ' +
    'from GER_LOCACAO a ' +
    'inner join GER_LIVRO b on (b.CD_LIVRO = a.CD_LIVRO) ' +
    'inner join GER_LOCADOR c on (c.CD_LOCADOR  = a.CD_LOCADOR) ' +
    'where a.TP_SITUACAO = 1 ' ;

  Panel4.Visible := True;

  bDplMan := False;

  fCD_LIVRO.Tag := TAG_FK;
  fCD_TURMA.Tag := TAG_FK;
  fCD_LOCADOR.Tag := TAG_FK;

  TcStringList(fTP_LOCACAO.Items).p_AddLista(listDs(cMENU.f_VerCB('TP_LOCACAO')) + '|Todos');
  fTP_LOCACAO.ItemIndex := 0;

  bImprimeRecibo.Checked := IfNullB(LerIni(_Caption, IMP_REC), True);
  bInformaLivro.Checked := IfNullB(LerIni(_Caption, INF_LIV), True);
  bInformaLivroAuto.Checked := IfNullB(LerIni(_Caption, INF_LIV_AUT), False);
  bIsentaMulta.Checked := IfNullB(LerIni(_Caption, ISE_MUL), False);
  bIsentaMotivo.Checked := IfNullB(LerIni(_Caption, ISE_MOT), False);

  if IfNullB(LerIni(_Caption, CAD_DES), False) then begin
    p_SetarDescr(dfCD_LIVRO, cModoFormulario);
    p_SetarDescr(dfCD_LOCADOR, cModoFormulario);
    p_SetarDescr(dfCD_TURMA, cModoFormulario);
  end;
end;

procedure TfLOCACAO.FormShow(Sender: TObject);
begin
  inherited;
  ToolButtonImprimir.Visible := True;
  fCD_LOCADOR.OnExit := EditExit;
  fCD_LOCADOR.OnKeyPress := TcCADASTROFUNC.EditKeyPressInteiro;
  fCD_TURMA.OnExit := EditExit;
  fCD_TURMA.OnKeyPress := TcCADASTROFUNC.EditKeyPressInteiro;
  fCD_LIVRO.OnExit := EditExit;
  fCD_LIVRO.OnKeyPress := TcCADASTROFUNC.EditKeyPressInteiro;
  DBGrid1.OnDblClick := DBGrid1DblClick;
end;

procedure TfLOCACAO.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then begin
    ToolButtonConsultar.Click;
  end else if Key = VK_F5 then begin
    ToolButtonLocar.Click;
  end else if Key = VK_F6 then begin
    ToolButtonRenovar.Click;
  end else if Key = VK_F7 then begin
    ToolButtonDevolver.Click;
  end else if Key = VK_F8 then begin
    ToolButtonPgDebito.Click;
  end else if Key = VK_F9 then begin
    ToolButtonConsulta.Click;
  end else begin
    inherited; //
  end;
end;

procedure TfLOCACAO.fTP_LOCACAOKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then begin
    //ToolButtonConsultar.Click;
    Key := 0;
  end;
end;

procedure TfLOCACAO.ToolButtonConsultarClick(Sender: TObject);
var
  vVlSaldo : Real;
  vSql : String;
begin
  vSql := cSQL;

  _VlSaldo := 0;

  if fIN_ATRASADO.Checked then begin
    AddSqlWhere(vSql, 'a.TP_LOCACAO = 1 and a.DT_DEVOLUCAO < current_date ');

    p_Consultar(vSql);
    if _DataSet.IsEmpty then
      raise Exception.Create(cMESSAGE_NENHUMREGISTRO);

    Exit;
  end;

  with fCD_LIVRO do
    if Text <> '' then
      AddSqlWhere(vSql, 'a.CD_LIVRO=''' + Text + ''' ');
  with fCD_TURMA do
    if Text <> '' then
      AddSqlWhere(vSql, 'c.CD_TURMA=''' + Text + ''' ');
  with fCD_LOCADOR do
    if Text <> '' then
      AddSqlWhere(vSql, 'a.CD_LOCADOR=''' + Text + ''' ');

  with fTP_LOCACAO do
    if (Text <> '') and (Text <> 'Todos') then begin
      if ItemIndex = 0 then // Normal / Devolvido com atraso
        AddSqlWhere(vSql, 'a.TP_LOCACAO in (1,3)')
      else
        AddSqlWhere(vSql, 'a.TP_LOCACAO=''' + IntToStr(ItemIndex+1) + ''' ');
      if ItemIndex in [0, 2] then
        AddSqlWhere(vSql, 'a.DT_PAGOMULTA is null ');
    end;

  vSql := vSql + f_ObterFiltroSQL;

  p_Consultar(vSql);
  if _DataSet.IsEmpty then
    Exit;

  if fCD_LOCADOR.Text <> '' then begin
    vVlSaldo := IfNullF(dDADOS.f_ConsultaStrSql(
                        'select sum(VL_MULTA) as SALDO from GER_LOCACAO ' +
                        'where CD_LOCADOR = ''' + fCD_LOCADOR.Text + ''' ' +
                        'and TP_SITUACAO = 1 '+
                        'and TP_LOCACAO = 3 '+
                        'and VL_MULTA > 0 ' +
                        'and DT_PAGOMULTA is null ', 'SALDO'),0);
    if vVlSaldo > 0 then begin
      _VlSaldo := vVlSaldo;
    end;
  end;
end;

procedure TfLOCACAO.ToolButtonImprimirClick(Sender: TObject);
var
  vVlMultaDia : Real;
begin
  _CaptionRel := _Caption;

  if fIN_ATRASADO.Checked then
    _CaptionRel := _CaptionRel + ' - ATRASADO';
  if fTP_AGRUPAR.ItemIndex = 0 then // Por Locador
    _CaptionRel := _CaptionRel + ' / LOCADOR'
  else if fTP_AGRUPAR.ItemIndex = 1 then // Por Livro
    _CaptionRel := _CaptionRel + ' / LIVRO';

  vVlMultaDia := IfNullF(dDADOS.f_LerParametro('VL_MULTA_DIA'),0);
  if vVlMultaDia = 0 then
    Exit;

  cTR := '';

  if fTP_LOCACAO.ItemIndex = 0 then begin
    cTR :=
      '' + sLineBreak +
      '' + sLineBreak +
      'Atenção: O atraso na devolução do(s) livro(s), acarretará multa diária de R$ ' + FormatFloat('0.00', vVlMultaDia) + ' ao dia ' + sLineBreak +
      '' + sLineBreak +
      '                         ________________________________________' + sLineBreak +
      '                                       Assinatura ' + sLineBreak ;
  end;

  inherited;
end;

procedure TfLOCACAO.ToolButtonLocarClick(Sender: TObject);
var
  vQtLivroExemplar, vQtLivroLocador, vQtLivroLocado,
  vNrExemplar, vNrDiasLocacao, vNrMaxLivro : Integer;
  vParams, vResult, vSql : String;
  vDtDevolucao : TDateTime;
begin
  inherited;

  vInConsulta := False;

  //Verificar parametro de numero dias para locacao
  vNrDiasLocacao := IfNullI(dDADOS.f_LerParametro('NR_DIAS_LOCACAO'), 0);
  if vNrDiasLocacao = 0 then
    Exit;

  vDtDevolucao := Date + vNrDiasLocacao;
  vNrExemplar := 0;

  try
    if bInformaLivro.Checked then begin
      vParams := '';
      putitemX(vParams, 'CD_LIVRO', fCD_LIVRO.Text);
      putitemX(vParams, 'CD_LOCADOR', fCD_LOCADOR.Text);
      putitemX(vParams, 'DT_DEVOLUCAO', vDtDevolucao);
      putitemX(vParams, 'NR_EXEMPLAR', 1);
      vResult := TfINFLIV.execute(vParams);
      if itemXF('status', vResult) <> 1 then begin
        vInConsulta := True;
        Exit;
      end;
      fCD_LIVRO.Text := itemX('CD_LIVRO', vResult);
      fCD_LOCADOR.Text := itemX('CD_LOCADOR', vResult);
      vDtDevolucao := itemXD('DT_DEVOLUCAO', vResult);
      vNrExemplar := itemXI('NR_EXEMPLAR', vResult);
    end;

    vInConsulta := True;

    if not Pergunta('Confirmar locação!') then
      Exit;

    //Efetua validacao do locador
    if fCD_LOCADOR.Text = '' then begin
      fCD_LOCADOR.SetFocus;
      raise Exception.Create('Locador deve ser informado!');
    end;
    if dfCD_LOCADOR.Text = '' then begin
      fCD_LOCADOR.SetFocus;
      raise Exception.Create('Locador informado não cadastrado!');
    end;

    //Efetua validacao do livro
    if fCD_LIVRO.Text = '' then begin
      fCD_LIVRO.SetFocus;
      raise Exception.Create('Livro deve ser informado!');
    end;
    if dfCD_LIVRO.Text = '' then begin
      fCD_LIVRO.SetFocus;
      raise Exception.Create('Livro informado não cadastrado!');
    end;

    //Verificar parametro de numero maximo de livro
    vNrMaxLivro := IfNullI(dDADOS.f_LerParametro('NR_MAX_LIVRO'), 0);
    if vNrMaxLivro = 0 then
      raise Exception.Create('Parametro NR_MAX_LIVRO deve ser configurado!');

    //Verificar a qtde exemplar
    vQtLivroExemplar := IfNullI(dDADOS.f_ConsultaStrSql('select QT_EXEMPLAR from GER_LIVRO where CD_LIVRO = ''' + fCD_LIVRO.Text + ''' ','QT_EXEMPLAR'), 0);
    if vQtLivroExemplar = 0 then
      raise Exception.Create('Livro não contem qtde de exemplar informada!');

    //Verificar se o locador contem debito em aberto
    if dDADOS.f_ExistSql('select * from GER_LOCACAO ' +
                         'where CD_LOCADOR = ''' + fCD_LOCADOR.Text + ''' ' +
                         'and TP_SITUACAO = 1 ' +
                         'and TP_LOCACAO = 3 ' +
                         'and VL_MULTA > 0 ' +
                         'and DT_PAGOMULTA is null ') then begin
      fCD_LIVRO.Text := '';
      fTP_LOCACAO.ItemIndex := 2;
      fTP_LOCACAO.Text := fTP_LOCACAO.Items[ fTP_LOCACAO.ItemIndex ];
      ToolButtonConsultar.Click;
      raise Exception.Create('Locador contem débito em aberto!');
    end;

    //Verificar se o livro já esta locado para o locador
    if dDADOS.f_ExistSql('select * from GER_LOCACAO ' +
                         'where CD_LOCADOR = ''' + fCD_LOCADOR.Text + ''' '  +
                         'and CD_LIVRO = ''' + fCD_LIVRO.Text + ''' ' +
                         'and TP_LOCACAO = 1 ' +
                         'and TP_SITUACAO = 1 ') then begin
      ToolButtonConsultar.Click;
      raise Exception.Create('Livro já locado pelo locador!');
    end;

    //Verificar se o exemplar está locado
    if vNrExemplar > 0 then
      if dDADOS.f_ExistSql('select * from GER_LOCACAO ' +
                           'where CD_LIVRO = ''' + fCD_LIVRO.Text + ''' ' +
                           'and NR_EXEMPLAR = ''' + IntToStr(vNrExemplar) + ''' ' +
                           'and TP_LOCACAO = 1 ' +
                           'and TP_SITUACAO = 1 ') then begin
        ToolButtonConsultar.Click;
        raise Exception.Create('Exemplar do livro já locado!');
      end;

    //Verificar a qtde locado
    vQtLivroLocado := IfNullI(dDADOS.f_ConsultaStrSql('select count(*) as QT_LOCADO from GER_LOCACAO where CD_LIVRO = ''' + fCD_LIVRO.Text + ''' and TP_LOCACAO = 1','QT_LOCADO'), 0);

    //Verificar a qtde disponivel
    if vQtLivroLocado >= vQtLivroExemplar then
      raise Exception.Create('Livro não contem qtde disponível para locação!');

    //Verificar qtde locada pelo locador
    vQtLivroLocador := IfNullI(dDADOS.f_ConsultaStrSql('select count(*) as QT_LOCADO from GER_LOCACAO where CD_LOCADOR = ''' + fCD_LOCADOR.Text + ''' and TP_LOCACAO = 1','QT_LOCADO'),0);

    //Verificar a qtde disponivel
    if vQtLivroLocador >= vNrMaxLivro then
      raise Exception.Create('Qtde de livro locado não pode exceder a ' + IntToStr(vNrMaxLivro) + ' livros por locador!');

    //Efetuar locacao
    vSql :=
      'insert into GER_LOCACAO (CD_LOCADOR,CD_LIVRO,DT_LOCACAO,TP_LOCACAO,DT_DEVOLUCAO,NR_EXEMPLAR) ' +
      'values (' + fCD_LOCADOR.Text + ',' + fCD_LIVRO.Text + ',''' + FormatDateTime('yyyy/mm/dd',Date) + ''',1,''' + FormatDateTime('yyyy/mm/dd',vDtDevolucao) + ''',' + IntToStr(vNrExemplar) + ')';

    try
      dDADOS.f_RunSQL(vSql);
    except
      on E: Exception do begin
        Mensagem('Erro: ' + E.Message + ' / SQL: ' + vSql);
        Exit;
      end;
    end;

    Mensagem('Locação efetuada com sucesso!');

    if bImprimeRecibo.Checked then begin
      if Pergunta('Deseja imprimir recibo?') then begin
        fCD_LIVRO.Text := '';
        fTP_LOCACAO.ItemIndex := 0;
        fTP_LOCACAO.Text := fTP_LOCACAO.Items[ fTP_LOCACAO.ItemIndex ];
        ToolButtonConsultar.Click;
        ToolButtonImprimir.Click;
      end;
    end else begin
      fCD_LIVRO.Text := '';
      //ToolButtonConsultar.Click;
      if bInformaLivroAuto.Checked then
        ToolButtonLocar.Click;
    end;
  except
    on E: Exception do begin
      Mensagem('Erro: ' + E.Message);
      ToolButtonLocar.Click;
    end;
  end;
end;

procedure TfLOCACAO.ToolButtonDevolverClick(Sender: TObject);
var   
  vNrDiasCarencia, vNrDiasAtraso, vTpLocador : Integer;
  vSql, vDsMulta, vDsMotivo : String;
  vVlMultaDia, vVlMulta : Real;
  vInIsenta : Boolean;
begin
  inherited;

  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_CONSULTAVAZIA);

  if item('DT_DEVOLVIDO', _DataSet) <> '' then
    raise Exception.Create('Locação de livro já devolvida!');

  if not Pergunta('Confirmar devolução!') then
    Exit;

  //Verificar parametro de numero maximo de livro
  vVlMultaDia := IfNullF(dDADOS.f_LerParametro('VL_MULTA_DIA'),0);
  if vVlMultaDia = 0 then
    Exit;

  //Verificar se professor nao cobrar multa
  vTpLocador := IfNullI(dDADOS.f_ConsultaStrSql('select TP_LOCADOR from GER_LOCADOR where CD_LOCADOR = ''' + item('CD_LOCADOR', _DataSet) + ''' ','TP_LOCADOR'),1);

  //Verificar se atrasado gravar multa de acordo com a qtde de dias em atraso
  vNrDiasAtraso := 0;
  vVlMulta := 0;
  if vTpLocador = 1 then begin
    // Verifica dias de carencia
    vNrDiasCarencia := IfNullI(dDADOS.f_LerParametro('NR_DIAS_TOLERANCIA'),0);

    // Verifica dias de atraso
    vNrDiasAtraso := VerDiasUtil(itemD('DT_DEVOLUCAO', _DataSet) + 1, Date);
    if vNrDiasAtraso > 0 then begin
      vVlMulta := vVlMultaDia * (vNrDiasAtraso - vNrDiasCarencia);
      if vVlMulta > 0 then begin
        Mensagem('Livro devolvido com atraso! Valor multa: R$ ' + FormatFloat('0.00', vVlMulta));
      end else begin
        Mensagem('Livro devolvido com atraso!');
        vVlMulta := 0;
      end;
    end;
  end;

  //Isencao multa
  vInIsenta := False;
  vDsMotivo := '';
  if bIsentaMulta.Checked and (vNrDiasAtraso > 0) then begin
    vInIsenta := Pergunta('Confirma isenção da multa ?');
    if bIsentaMotivo.Checked and vInIsenta then begin
      if not InputQuery('Informe', 'Motivo isenção', vDsMotivo) then
        Exit;
      if vDsMotivo = '' then
        raise Exception.Create('Motivo deve ser informado');
    end;
  end;

  vDsMulta := FloatToStr(vVlMulta);
  vDsMulta := ReplaceStr(vDsMulta, ',', '.');

  try
    dDADOS.StartTransaction;

    //Efetuar devolucao
    if vNrDiasAtraso > 0 then
      vSql := 'update GER_LOCACAO set TP_LOCACAO = 3, DT_DEVOLVIDO = ''' + FormatDateTime('yyyy/mm/dd',Date) + ''', VL_MULTA = ''' + vDsMulta + ''' ' +
              'where CD_LOCACAO = ''' + item('CD_LOCACAO', _DataSet) + ''' '
    else
      vSql := 'update GER_LOCACAO set TP_LOCACAO = 2, DT_DEVOLVIDO = ''' + FormatDateTime('yyyy/mm/dd',Date) + ''' ' +
              'where CD_LOCACAO = ''' + item('CD_LOCACAO', _DataSet) + ''' ';
    dDADOS.f_RunSQL(vSql);

    //Isencao multa
    if vInIsenta then begin
      vSql := 'update GER_LOCACAO set TP_LOCACAO = 4, DT_PAGOMULTA = current_date ' +
              'where CD_LOCACAO = ''' + item('CD_LOCACAO', _DataSet) + ''' ';
      dDADOS.f_RunSQL(vSql);

      if vDsMotivo <> '' then begin
        vSql := 'update GER_LOCACAO set DS_ISENTAMOT = ''' + vDsMotivo + ''' ' +
                'where CD_LOCACAO = ''' + item('CD_LOCACAO', _DataSet) + ''' ';
        dDADOS.f_RunSQL(vSql);
      end;
    end;

    dDADOS.Commit();
  except
    on E : Exception do begin
      dDADOS.Rollback();
      raise;
    end;
  end;

  Mensagem('Devolução efetuada com sucesso!');

  if bImprimeRecibo.Checked then begin
    if Pergunta('Deseja imprimir recibo?') then begin
      fCD_LOCADOR.Text := item('CD_LOCADOR', _DataSet);
      fCD_LIVRO.Text := '';
      fTP_LOCACAO.ItemIndex := 0;
      fTP_LOCACAO.Text := fTP_LOCACAO.Items[ fTP_LOCACAO.ItemIndex ];
      ToolButtonConsultar.Click;
      ToolButtonImprimir.Click;
    end;
  end else begin
    ToolButtonConsultar.Click;
  end;
end;

procedure TfLOCACAO.ToolButtonRenovarClick(Sender: TObject);
var
  vNrDiasLocacao : Integer;
  vSql : String;
begin
  inherited;

  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_CONSULTAVAZIA);

  if not Pergunta('Confirmar renovação!') then
    Exit;

  if item('DT_DEVOLVIDO', _DataSet) <> '' then
    raise Exception.Create('Locação de livro já devolvida!');

  //Verificar parametro de numero dias para locacao
  vNrDiasLocacao := IfNullI(dDADOS.f_LerParametro('NR_DIAS_LOCACAO'), 0);
  if vNrDiasLocacao = 0 then
    Exit;

  //Acrescenta o numero de dias na data de devolucao
  vSql := 'update GER_LOCACAO set DT_DEVOLUCAO = DT_DEVOLUCAO + ' + IntToStr(vNrDiasLocacao) + ' '+
          'where CD_LOCACAO = ''' + item('CD_LOCACAO', _DataSet) + ''' ';

  try
    dDADOS.f_RunSQL(vSql);
  except
    on E: Exception do begin
      Mensagem('Erro: ' + E.Message + ' / SQL: ' + vSql);
      Exit;
    end;
  end;

  ToolButtonConsultar.Click;

  Mensagem('Renovação efetuada com sucesso!');
end;

procedure TfLOCACAO.ToolButtonPgDebitoClick(Sender: TObject);
var
  vSql : String;
begin
  inherited;

  if IfNullB(LerIni(PAG_DEB), True) then begin
    ToolButtonPgTodosDebitoClick(Sender);
    Exit;
  end;

  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_CONSULTAVAZIA);

  if not Pergunta('Confirmar pagar débito!') then
    Exit;

  if itemI('TP_LOCACAO', _DataSet) <> 3 then
    raise Exception.Create('Locação não gerou multa a receber!');

  if itemD('DT_PAGOMULTA', _DataSet) <> 0 then
    raise Exception.Create('Pagamento da multa já efetuado!');

  //Efetua pagamento do debito
  vSql := 'update GER_LOCACAO set DT_PAGOMULTA = current_date ' +
          'where CD_LOCACAO = ''' + item('CD_LOCACAO', _DataSet) + ''' ';

  try
    dDADOS.f_RunSQL(vSql);
  except
    on E: Exception do begin
      Mensagem('Erro: ' + E.Message + ' / SQL: ' + vSql);
      Exit;
    end;
  end;

  ToolButtonConsultar.Click;

  Mensagem('Débito pago com sucesso!');
end;

procedure TfLOCACAO.ToolButtonPgTodosDebitoClick(Sender: TObject);
var
  vSql : String;
begin
  inherited;

  if (fCD_LOCADOR.Text = '') then
    Exit;

  if not Pergunta('Confirmar pagar todos débito!') then
    Exit;

  if (_VlSaldo <= 0) then
    raise Exception.Create('Nenhum saldo de débito a pagar!');

  //Efetua pagamento do debito
  vSql := 'update GER_LOCACAO set DT_PAGOMULTA = current_date ' +
          'where CD_LOCADOR = ''' + fCD_LOCADOR.Text + ''' and DT_PAGOMULTA is null ';

  try
    dDADOS.f_RunSQL(vSql);
  except
    on E: Exception do begin
      Mensagem('Erro: ' + E.Message + ' / SQL: ' + vSql);
      Exit;
    end;
  end;

  ToolButtonConsultar.Click;

  Mensagem('Todos débitos pagos com sucesso!');
end;

procedure TfLOCACAO.ToolButtonLimparClick(Sender: TObject);
begin
  inherited;
  _VlSaldo := 0;
  fCD_LOCADOR.SetFocus;
end;

procedure TfLOCACAO.ToolButtonConsultaClick(Sender: TObject);
begin
  cMENU.AbreTela('CD_CONSULTA');
end;

procedure TfLOCACAO.bImprimeReciboClick(Sender: TObject);
begin
  bImprimeRecibo.Checked := not bImprimeRecibo.Checked;
  fGravaIni(_Caption, IMP_REC, bImprimeRecibo.Checked);
end;

procedure TfLOCACAO.bInformaLivroClick(Sender: TObject);
begin
  bInformaLivro.Checked := not bInformaLivro.Checked;
  fGravaIni(_Caption, INF_LIV, bInformaLivro.Checked);
end;

procedure TfLOCACAO.bInformaLivroAutoClick(Sender: TObject);
begin
  bInformaLivroAuto.Checked := not bInformaLivroAuto.Checked;
  fGravaIni(_Caption, INF_LIV_AUT, bInformaLivroAuto.Checked);
end;

procedure TfLOCACAO.bIsentaMultaClick(Sender: TObject);
begin
  bIsentaMulta.Checked := not bIsentaMulta.Checked;
  fGravaIni(_Caption, ISE_MUL, bIsentaMulta.Checked);
end;

procedure TfLOCACAO.bIsentaMotivoClick(Sender: TObject);
begin
  bIsentaMotivo.Checked := not bIsentaMotivo.Checked;
  fGravaIni(_Caption, ISE_MOT, bIsentaMotivo.Checked);
end;

procedure TfLOCACAO._DataSetAfterOpen(DataSet: TDataSet);
var
  vCampos : String;
begin
  vCampos := '';

  if (fCD_LOCADOR.Text = '') then begin
    putitem(vCampos, 'CD_LOCADOR', 06);
    putitem(vCampos, 'NM_LOCADOR', 30);
  end;

  if (fCD_LIVRO.Text = '') then begin
    if IfNullB(LerIni(_Caption, RED_LIV), False) then begin
      putitem(vCampos, 'CD_LIVEXE', 06);
    end else begin
      putitem(vCampos, 'CD_LIVRO', 06);
      putitem(vCampos, 'NR_EXEMPLAR', 05);
    end;

    putitem(vCampos, 'DS_TITULO', 30);
  end;

  putitem(vCampos, 'CD_TURMA', 06);
  putitem(vCampos, 'NR_ANO', 06);
  putitem(vCampos, 'DT_LOCACAO', 10);
  putitem(vCampos, 'DT_DEVOLUCAO', 10);
  putitem(vCampos, 'DT_DEVOLVIDO', 10);
  putitem(vCampos, 'VL_MULTA', 10);
  putitem(vCampos, 'DT_PAGOMULTA', 10);
  putitem(vCampos, 'TP_LOCACAO', 15);

  TcCADASTROFUNC.SetInVisibleAll(_DataSet);
  TcCADASTROFUNC.SetVisibleAll(_DataSet, vCampos);

  inherited;
end;

procedure TfLOCACAO.DBGrid1DblClick(Sender: TObject);
begin
  if itemI('TP_LOCACAO', _DataSet) = 1 then
    ToolButtonDevolver.Click
  else
    inherited;
end;


procedure TfLOCACAO.EditExit(Sender: TObject);
begin
  if TEdit(Sender).Name = 'fCD_LOCADOR' then
    if (fCD_LOCADOR.Text <> '') and (fCD_LIVRO.Text <> '') then
      fCD_LIVRO.Text := '';

  if vInConsulta = False then
    Exit;

  if (fCD_LOCADOR.Text <> '') or (fCD_LIVRO.Text <> '') then
    ToolButtonConsultar.Click;

  inherited;
end;

procedure TfLOCACAO.SetVlSaldo(const Value: Real);
begin
  FVlSaldo := Value;
  eSALDO.Text := FormatFloat('0.00', FVlSaldo);
end;

initialization
  RegisterClass(TfLOCACAO);

end.
