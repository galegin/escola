unit ucCADASTRO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, Grids, DBGrids, Buttons, StdCtrls, ExtCtrls,
  DB, DBClient, ImgList, Provider, DBTables, Mask, StrUtils, DBCtrls, TeeProcs,
  TeEngine, Chart, MidasLib, FMTBcd, SqlExpr, Menus, dbcgrids, ucFORM,
  ucCONFIMPRESSAO, ucTIPOIMPRESSAO;

type
  TcCADASTRO = class(TcFORM)
    ToolButtonNovo: TToolButton;
    ToolButtonAlterar: TToolButton;
    ToolButtonExcluir: TToolButton;
    ToolButtonGravar: TToolButton;
    ToolButtonCancelar: TToolButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    Shape1: TShape;
    Bevel1: TBevel;
    Label2: TLabel;
    Shape2: TShape;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Shape6: TShape;
    Bevel2: TBevel;
    ToolButtonImprimir: TToolButton;
    ToolButtonConsultar: TToolButton;
    ToolButtonLimpar: TToolButton;
    ToolButtonS2: TToolButton;
    Panel4: TPanel;
    Panel3: TPanel;
    ScrollBox1: TScrollBox;
    Panel5: TPanel;
    LabelTpConsulta: TLabel;
    TP_CONSULTA: TComboBox;
    LabelPesquisarPor: TLabel;
    CD_CAMPO: TComboBox;
    fDS_EXPRESSAO: TEdit;
    LabelExpressao: TLabel;
    ToolButtonS1: TToolButton;
    LabelF12: TLabel;
    PanelImpressao: TPanel;
    ToolButtonExtrair: TToolButton;
    _ProgressBar: TProgressBar;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);

    procedure ToolButtonNovoClick(Sender: TObject);
    procedure ToolButtonAlterarClick(Sender: TObject);
    procedure ToolButtonExcluirClick(Sender: TObject);
    procedure ToolButtonGravarClick(Sender: TObject);
    procedure ToolButtonCancelarClick(Sender: TObject);
    procedure ToolButtonLimparClick(Sender: TObject);
    procedure ToolButtonConsultarClick(Sender: TObject);
    procedure ToolButtonImprimirClick(Sender: TObject);
    procedure ToolButtonExtrairClick(Sender: TObject);
    procedure ToolButtonDuplicarClick(Sender: TObject);
    procedure ToolButtonCarregaClick(Sender: TObject);
    procedure ToolButtonProximoClick(Sender: TObject);

    procedure PageControl1Change(Sender: TObject);

    procedure DataSource1StateChange(Sender: TObject);

    procedure p_PageControl(Tp : String);
    procedure p_HabilitaModoFormulario;
    procedure p_HabilitaBotao(Habilita : Boolean);
    procedure p_FocusComp(pParent : TWinControl);
    procedure p_FocusFiltro;
    procedure p_FocusManut;

    procedure _DataSetAfterScroll(DataSet: TDataSet);
  private
    FTotal : Integer;
    procedure setInPanelImpressao(const Value: Boolean);
  protected
  public
  published
    property _InPanelImpressao : Boolean write setInPanelImpressao;
  end;

var
  cCADASTRO: TcCADASTRO;

implementation

{$R *.dfm}

uses
  ucDADOS, ucFUNCAO, ucITEM, ucRELATORIO, ucMENU, ucCONFPAGINA, ucPREVIEW_TXT,
  ucOBS, ucCADASTROFUNC, ucLOGALTERACAO, ucCONST, ucXML, ucARQUIVO;

  procedure TcCADASTRO.setInPanelImpressao(const Value: Boolean);
  begin
    FInImprimindo := Value;
    PanelImpressao.Visible := Value;
    if PanelImpressao.Visible then begin
      PanelImpressao.Top := (Height div 2) - (PanelImpressao.Height div 2);
      PanelImpressao.Left := (Width div 2) - (PanelImpressao.Width div 2);
      PanelImpressao.BringToFront;
    end;
  end;

//------------------------------------------------------------------------------

procedure TcCADASTRO.FormCreate(Sender: TObject);
begin
  inherited;

  cModoFormulario := mfConsultaManutencao;
  cTipoClasseForm := tcfCadastro;

  Caption := Copy(Caption,2,Length(Caption)-1);
  cCaption := Caption;
  cCaptionRel := cCaption;

  Panel5.Visible := IfNullB(LerIni(cCaption, FIL_MAN), True);

  cColMan := IfNullS(LerIni(cCaption, COL_MAN), cColMan);

  bCpoMan := False;
  bDplMan := True;

  EditCancel.Tag := TAG_OCULTO;

  CD_CAMPO.OnChange := CD_CAMPOChange;
  CD_CAMPO.OnExit := CD_CAMPOExit;
  fDS_EXPRESSAO.OnExit := fDS_EXPRESSAOExit;
  TP_CONSULTA.OnExit := TP_CONSULTAExit;
end;

procedure TcCADASTRO.FormShow(Sender: TObject);
begin
  if (cSQL = '') and (cTabMan <> '') then
    cSQL := 'select * from ' + cTabMan + ' where TP_SITUACAO = 1 ';

  p_Consultar(cSQL, REG_LIMPO);
  p_CriarCampos(ScrollBox1);
  p_AjustarCampos(ScrollBox1);

  inherited;

  p_PageControl('P');

  bConfigurarManutencao.Visible := (dDADOS.gNmUsuario = 'SUPORTE');
  bConfigurarRelatorio.Visible := (dDADOS.gNmUsuario = 'SUPORTE');

  p_FocusFiltro;
  p_HabilitaChave(False);
  p_HabilitaModoFormulario;

  TcCADASTROFUNC.CarregaCamposFiltro(CD_CAMPO.Items, _DataSet);
  TP_CONSULTA.ItemIndex := IfNullI(LerIni(cCaption, TIP_CNS), 2);
  CD_CAMPO.ItemIndex := IfNullI(LerIni(cCaption, COD_CNS), -1);

  if (Hint <> '') and (cKeyMan <> '') then begin
    ToolButtonConsultar.Click;
  end else if (bAutMan) then begin
    ToolButtonConsultar.Click;
  end;

  if (Panel5.Visible) and (fDS_EXPRESSAO.Visible) then
    fDS_EXPRESSAO.SetFocus;
end;

procedure TcCADASTRO.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: begin
      if not (ClickButton('ToolButtonCancelar')) then begin
        ClickButton('ToolButtonFechar');
      end;
      Key := 0;
    end;

    VK_UP, VK_PRIOR: begin
      if (PageControl1.ActivePage = TabSheet1) then
        _DataSet.Prior
    end;

    VK_DOWN, VK_NEXT: begin
      if (PageControl1.ActivePage = TabSheet1) then
        _DataSet.Next;
    end;
  end;

  inherited;

  case Key of
    VK_F2: ClickButton('ToolButtonLimpar');
    VK_F3: ClickButton('ToolButtonGravar');
    VK_F4: ClickButton('ToolButtonConsultar');
    VK_F5: begin
      if (ClickButton('ToolButtonGravar')) then begin
        ClickButton('ToolButtonNovo');
      end else begin
        ClickButton('ToolButtonNovo');
      end;
    end;
    VK_F6: ClickButton('ToolButtonImprimir');
    VK_F7: ClickButton('ToolButtonExtrair');
    VK_F8: ClickButton('ToolButtonExcluir');
    VK_F12: begin
      if (PageControl1.ActivePage = TabSheet1) then begin
        if (cKeyMan <> '') then Hint := item(cKeyMan, _DataSet);
        ModalResult := mrOk;
        Key := 0;
      end;
    end;
  end;
end;

procedure TcCADASTRO.FormResize(Sender: TObject);
begin
  inherited;
  //PanelImpressao.Left := (Width div 2) - (PanelImpressao.Width div 2);
end;

//------------------------------------------------------------------------------

procedure TcCADASTRO.ToolButtonNovoClick(Sender: TObject);
begin
  if not dDADOS.f_VerPrivilegio(cTabMan,'IN_INCLUIR') then
    Exit;

  EditCancel.SetFocus;
  _DataSet.Insert;

  p_MontaTabela;

  if (_DataSet.State in [dsBrowse]) then
    _DataSet.Append;

  p_PageControl('C');
  p_HabilitaChave(True);
  p_FocusManut;
  p_CarregarCampos;
end;

procedure TcCADASTRO.ToolButtonAlterarClick(Sender: TObject);
begin
  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_CONSULTAVAZIA);

  p_MontaTabela;

  if not dDADOS.f_VerPrivilegio(cTabMan,'IN_ALTERAR') then
    Exit;

  _DataSet.Edit;
  
  p_GravarRegistro;
  p_HabilitaChave(False);
  p_PageControl('C');
  p_FocusManut;
  p_CarregarCampos;
end;

procedure TcCADASTRO.ToolButtonExcluirClick(Sender: TObject);
begin
  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_CONSULTAVAZIA);

  if not dDADOS.f_VerPrivilegio(cTabMan,'IN_EXCLUIR') then
    Exit;

  if not Pergunta('Deseja excluir registro?') then
    Exit;

  putitem(_DataSet, 'TP_SITUACAO', 3);
  Mensagem('Registro excluído com sucesso!');
  p_Consultar(cSQL);
end;

procedure TcCADASTRO.ToolButtonGravarClick(Sender: TObject);
var
  vTpPrivilegio : String;
begin
  vTpPrivilegio := IfThen(_DataSet.State in [dsInsert], 'IN_INCLUIR', 'IN_ALTERAR');

  if not dDADOS.f_VerPrivilegio(cTabMan, vTpPrivilegio) then
    Exit;

  EditCancel.SetFocus;
  p_DesCarregarCampos;

  dDADOS.p_IncrementoCodigo(_DataSet, cTabMan, cIncMan, f_GerarChave);
  if not f_VerObrigatorio then
    Exit;

  TcLOGALTERACAO.Gravar(_DataSet, cTabMan, cLogMan);

  _DataSet.Post;

  p_GravarRegistro;
  p_HabilitaChave(False);
  p_PageControl('P');
end;

procedure TcCADASTRO.ToolButtonCancelarClick(Sender: TObject);
begin
  EditCancel.SetFocus;
  _DataSet.Cancel;
  p_HabilitaChave(False);
  p_PageControl('P');
end;

procedure TcCADASTRO.ToolButtonImprimirClick(Sender: TObject);
var
  vClientDataSet : TClientDataSet;
  I, vQtdImp, vQtdTot, vQtdReg, vQtdAux : Integer;
  vTipoImpressao : TTipoImpressao;
  vArquivo, vEmail : String;

  function CarregarRegistro : Integer;
  var
    vReg : String;
  begin
    Result := 0;

    vClientDataSet.EmptyDataSet();

    vQtdReg := 0;
    while not _DataSet.EOF do begin
      if (vQtdReg >= vQtdImp) then begin
        Break;
      end;

      putlistitensocc(vReg, _DataSet);

      vClientDataSet.Append();
      getlistitensocc(vReg, vClientDataSet);
      vClientDataSet.Post();

      Result := 1;

      Inc(vQtdAux);
      Inc(vQtdReg);

      _ProgressBar.Position := _ProgressBar.Position + 1;
      if (_ProgressBar.Position mod 50) = 0 then
        Application.ProcessMessages;

      _DataSet.Delete;
    end;
  end;

begin
  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_NENHUMREGISTRO);

  if not dDADOS.f_VerPrivilegio(cTabMan, 'IN_IMPRIMIR') then
    Exit;

  vTipoImpressao := tpiVisualizar;
  vArquivo := '';
  vEmail := '';
  if not TcCONFIMPRESSAO.Executar(vTipoImpressao, vArquivo, vEmail) then
    Exit;

  if (vTipoImpressao in [tpiVisualizar]) then begin
    TcRELATORIO.Executar(_DataSet, cCaptionRel, f_ObterFiltroSQL, cSQL, nil);
    Exit;
  end;

  vQtdImp := IfNullI(LerIni(QTD_IMP), 500);
  vQtdTot := dDADOS.f_TotalRegSql(_Query.SQL.Text);
  vQtdAux := 0;

  if (vQtdTot > vQtdImp) then begin
    if not Pergunta('Qtde de registro acima de ' + IntToStr(vQtdImp) + '!' + #13 +
                    'Imprimir em lote?') then Exit;
  end;

  _DataSet.DisableControls();
  _DataSet.First();
  _DataSet.PacketRecords := vQtdImp;

  vClientDataSet := TClientDataSet.Create(Self);
  vClientDataSet.FieldDefs.Assign(_DataSet.FieldDefs);
  vClientDataSet.CreateDataSet();

  if (cModoFormulario = mfManutencao) then
    with _DataSet do
      for I := 0 to FieldCount-1 do
        with Fields[I] do
          if (cMENU.f_VerFK(FieldName) <> '') then begin
            OnGetText := _DataSetGetText_FK;
            Alignment := taLeftJustify;
          end;

  _InPanelImpressao := True;
  _ProgressBar.Max := vQtdTot;

  CarregarRegistro();

  repeat
    TcRELATORIO.Executar(vClientDataSet, cCaptionRel, f_ObterFiltroSQL, cSQL, nil);

    if not _DataSet.EOF then begin
      if (vQtdTot > vQtdImp) then begin
        if not Pergunta('Imprimido registro ' + IntToStr(vQtdAux) + ' de ' + IntToStr(vQtdTot) + '!' + #13 +
                        'Continuar imprimindo?') then Break;
      end;
    end;
  until (CarregarRegistro() = 0);

  _InPanelImpressao := False;

  _DataSet.EnableControls();
  _DataSet.First();
  _DataSet.PacketRecords := 30;

  if (vQtdTot > vQtdImp) then begin
    if not _DataSet.EOF then begin
      Mensagem('Impressão cancelada!');
    end else begin
      Mensagem('Impressão finalizada!');
    end;
  end;

  if (cModoFormulario = mfManutencao) then
    with _DataSet do
      for I := 0 to FieldCount-1 do
        with Fields[I] do
          if (cMENU.f_VerFK(FieldName) <> '') then begin
            OnGetText := nil;
            Alignment := taRightJustify;
          end;

  FreeAndNil(vClientDataSet);
end;

procedure TcCADASTRO.ToolButtonConsultarClick(Sender: TObject);
var
  vSql : String;
begin
  vSql := cSQL + f_ObterFiltroSQL;

  p_Consultar(vSql);
  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_NENHUMREGISTRO);
end;

//------------------------------------------------------------------------------

procedure TcCADASTRO.ToolButtonLimparClick(Sender: TObject);
var
  I : Integer;
begin
  p_Consultar(cSQL,REG_LIMPO);
  fDS_EXPRESSAO.Text := '';
  Hint := '';

  for I := 0 to ComponentCount - 1 do begin
    if (Components[I] is TEdit) then begin
      if not TEdit(Components[I]).ReadOnly then begin
        TEdit(Components[I]).Text := '';
      end;
    end;
  end;
end;

procedure TcCADASTRO.ToolButtonCarregaClick(Sender: TObject);
begin
  p_CarregaRegistro;
end;

procedure TcCADASTRO.ToolButtonDuplicarClick(Sender: TObject);
var
  vDsReg : String;
begin
  if not Pergunta('Duplicar registro') then
    Exit;

  p_DesCarregarCampos;
  putlistitensocc(vDsReg,_DataSet);
  if (_DataSet.State in [dsInsert,dsEdit]) then
    _DataSet.Cancel;
  _DataSet.Insert;
  getlistitensocc(vDsReg,_DataSet);
  p_CarregarCampos;
end;

procedure TcCADASTRO.ToolButtonProximoClick(Sender: TObject);
var
  vEdit : TEdit;
begin
  vEdit := TEdit(FindComponent(cIncMan));
  if vEdit <> nil then begin
    vEdit.Text := IntToStr(dDADOS.f_IncrementoCodigo(cTabMan, cIncMan));
    vEdit.SetFocus;
  end;
end;

//------------------------------------------------------------------------------

procedure TcCADASTRO.p_FocusComp(pParent : TWinControl);
var
  I : Integer;
begin
  for I := 0 to ComponentCount - 1 do begin
    if (Components[I] is TEdit) then begin
      with TEdit(Components[I]) do begin
        if (Visible)
        and (Enabled)
        and (TabStop)
        and (Parent = pParent) then begin
          SetFocus;
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TcCADASTRO.p_FocusFiltro;
begin
  p_FocusComp(Panel4);
end;

procedure TcCADASTRO.p_FocusManut;
begin
  p_FocusComp(ScrollBox1);
end;

//------------------------------------------------------------------------------

procedure TcCADASTRO.PageControl1Change(Sender: TObject);
begin
  if (cModoFormulario = mfConsulta) then
    Exit;

  if (PageControl1.ActivePage = TabSheet1) then
    if (_DataSet.State in [dsinsert,dsedit]) then
      ToolButtonCancelar.Click;

  if (PageControl1.ActivePage = TabSheet2) then
    if (_DataSet.IsEmpty) then
      ToolButtonNovo.Click
    else if not (_DataSet.State in [dsinsert,dsedit]) then
      ToolButtonAlterar.Click;
end;

//------------------------------------------------------------------------------

procedure TcCADASTRO.DataSource1StateChange(Sender: TObject);
begin
  if (cModoFormulario <> mfConsultaManutencao) then
    Exit;

  if _DataSet.Active then
    p_HabilitaBotao(_DataSet.State in [dsBrowse])
  else
    p_HabilitaBotao(True);

  Caption := cCaption;

  case _DataSet.State of
    dsBrowse: Caption := cCaption + ' - Consultando';
    dsInsert: Caption := cCaption + ' - Inserindo';
    dsEdit: Caption := cCaption + ' - Alterando';
  end;  
end;

//------------------------------------------------------------------------------

procedure TcCADASTRO.p_PageControl(Tp : String);
begin
  if (Tp = 'P') then
    PageControl1.ActivePage := TabSheet1
  else if (Tp = 'C') then
    PageControl1.ActivePage := TabSheet2;
end;

procedure TcCADASTRO.p_HabilitaModoFormulario;
begin
  if (cModoFormulario in [mfConsulta, mfConsultaSomente]) then begin
    ToolButtonNovo.Visible := False;
    ToolButtonAlterar.Visible := False;
    ToolButtonExcluir.Visible := False;
    ToolButtonGravar.Visible := False;
    ToolButtonCancelar.Visible := False;
    ToolButtonImprimir.Visible := False;
    ToolButtonExtrair.Visible := False;
    if (cModoFormulario = mfConsultaSomente) then
      TabSheet2.TabVisible := False
    else
      Panel3.Enabled := False;
  end;
  if (cModoFormulario = mfManutencao) then begin
    ToolButtonNovo.Visible := False;
    ToolButtonAlterar.Visible := False;
    ToolButtonExcluir.Visible := False;
    TabSheet1.TabVisible := False
  end;
end;

procedure TcCADASTRO.p_HabilitaBotao(Habilita : Boolean);
begin
  ToolButtonConsultar.Visible := Habilita;
  ToolButtonLimpar.Visible := Habilita;

  ToolButtonNovo.Visible := Habilita;
  ToolButtonAlterar.Visible := Habilita;
  ToolButtonExcluir.Visible := Habilita;
  ToolButtonGravar.Visible := not Habilita;
  ToolButtonCancelar.Visible := not Habilita;
  ToolButtonImprimir.Visible := Habilita;
  ToolButtonExtrair.Visible := Habilita;
  ToolButtonFechar.Visible := Habilita;

  Panel4.Enabled := Habilita;
end;

//------------------------------------------------------------------------------

procedure TcCADASTRO._DataSetAfterScroll(DataSet: TDataSet);
begin
  inherited;
  p_CarregarCampos;
end;

//------------------------------------------------------------------------------

procedure TcCADASTRO.ToolButtonExtrairClick(Sender: TObject);
const
  cEXP_INI = '"';
  cEXP_SEP = ',';
var
  vEXP_INI, vEXP_SEP,
  vParams, vArquivo, vConteudo, vLinha : String;
  I : Integer;
begin
  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_CONSULTAVAZIA);

  // file
  vParams := '';
  putitemX(vParams, 'DS_DIR', GetCurrentDir());
  putitemX(vParams, 'DS_FIL', 'Arquivo TEXTO (*.txt)|*.txt');
  putitemX(vParams, 'DS_ARQ', AnsiReplaceStr(cTabMan, 'GER_', '') + '.txt');
  vArquivo := TcARQUIVO.dialogSave(vParams);
  if vArquivo = '' then
    Exit;

  vEXP_INI := IfNullS(LerIni(EXP_INI), cEXP_INI);
  vEXP_SEP := IfNullS(LerIni(EXP_SEP), cEXP_SEP);

  _InPanelImpressao := True;

  _DataSet.First;
  _DataSet.DisableControls;

  // header
  vLinha := '';
  with _DataSet do
    for I:=0 to FieldCount-1 do
      with Fields[I] do
        putitemD(vLinha, vEXP_INI + AnsiReplaceStr(DisplayLabel, vEXP_SEP, '') + vEXP_INI, vEXP_SEP);
  putitemD(vConteudo, vLinha, sLineBreak);

  FTotal := dDADOS.f_TotalRegSql(cSQL + f_ObterFiltroSQL);

  _ProgressBar.Max := FTotal;
  _ProgressBar.Position := 0;

  // detail
  with _DataSet do
    while not EOF do begin
      vLinha := '';
      for I:=0 to FieldCount-1 do
        with Fields[I] do
          putitemD(vLinha, vEXP_INI + AnsiReplaceStr(Text, vEXP_SEP, '') + vEXP_INI, vEXP_SEP);
      putitemD(vConteudo, vLinha, sLineBreak);

      _ProgressBar.Position := _ProgressBar.Position + 1;
      if (_ProgressBar.Position mod 1000) = 0 then
        Application.ProcessMessages;

      Next;
    end;

  _InPanelImpressao := False;

  _DataSet.First;
  _DataSet.EnableControls;

  TcARQUIVO.descarregar(vArquivo, vConteudo);

  if IfNullB(LerIni(EXP_VIS), False) then
    ucFUNCAO.ExecutePrograma(vArquivo);

  MensagemBal('Extracao efetuada com sucesso!' + #13 + 'Arquivo: ' + vArquivo);
end;

//------------------------------------------------------------------------------

end.
