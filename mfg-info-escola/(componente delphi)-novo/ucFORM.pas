unit ucFORM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr, DBGrids, Grids, ToolWin,
  ComCtrls, StdCtrls, ExtCtrls, StrUtils, DBCtrls, ucCOMP, Menus, TypInfo,
  ucCOMPPESQ, Math;

const
  TAG_OCULTO   = -1;
  TAG_NORMAL   =  0;
  TAG_PK       =  1;
  TAG_FK       =  2;
  TAG_READONLY =  3;
  TAG_PFK      =  4;
  TAG_LK       =  5; // LookUp

  REG_LIMPO    = 00;
  REG_TOTAL    = 30;

  wEscala      = 08;
  hEscala      = 21;
  wRecuo       = 10;
  hRecuo       = 10;
  linRecuo     = 03;
  colRecuo     = 03;
  larLabel     = 100;

type
  TModoFormulario = (mfConsultaSomente, mfConsulta, mfConsultaManutencao, mfManutencao);

  TTipoClasseForm = (tcfCadastro, tcfConsulta, tcfManutencao);

  TcFORM = class(TForm)
    _Query: TSqlQuery;
    _Provider: TDataSetProvider;
    _DataSet: TClientDataSet;
    _DataSource: TDataSource;
    EditCancel: TEdit;
    _CoolBar: TCoolBar;
    _ToolBar: TToolBar;
    ToolButtonFechar: TToolButton;
    _CoolBarAtalho: TCoolBar;
    _ToolBarAtalho: TToolBar;
    ToolButtonFechar1: TToolButton;
    _PopupMenu: TPopupMenu;
    bConsultaLog: TMenuItem;
    bObservacao: TMenuItem;
    bConfigurarManutencao: TMenuItem;
    bConfigurarRelatorio: TMenuItem;
    bMoverCampo: TMenuItem;
    bAjustarCampo: TMenuItem;

    procedure ColorControl(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure p_LerIni;
    procedure p_Consultar(pSql : String; TOT_REG : Integer = REG_TOTAL);

    function f_VerObrigatorio : Boolean;

    procedure p_SetarDescr(pEditDes : TEdit; pModoFormulario : TModoFormulario);
    procedure p_CriarCampos(pParent : TWinControl);
    procedure p_AjustarCampos(pParent : TWinControl);

    procedure EditEnter(Sender: TObject);
    procedure EditExit(Sender: TObject);
    procedure EditExitVal(Sender: TObject);
    procedure EditExitCad(Sender: TObject);
    procedure EditKeyPressCad(Sender: TObject; var Key: Char);
    procedure EditDblClick(Sender: TObject);
    procedure EditChange(Sender: TObject);

    procedure EditMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure EditGravarDef();

    procedure EditAjuste(Sender: TObject);

    procedure p_CorrigeEditFkTela;

    procedure _DataSetAfterPost(DataSet: TDataSet);
    procedure _DataSetBeforePost(DataSet: TDataSet);

    procedure p_CarregarCampos(vCampo : String = '');
    procedure p_DesCarregarCampos(vCampo : String = '');

    procedure _DataSetAfterOpen(DataSet: TDataSet);
    procedure _DataSetAfterEdit(DataSet: TDataSet);
    procedure _DataSetNewRecord(DataSet: TDataSet);
    procedure _DataSetGetText_FK(Sender: TField; var Text: String; DisplayText: Boolean);
    procedure _DataSetGetText_IN(Sender: TField; var Text: String; DisplayText: Boolean);
    procedure _DataSetGetText_TP(Sender: TField; var Text: String; DisplayText: Boolean);

    function f_ConsultarChave : Boolean;
    function f_GerarChave(vParcial : Boolean = True) : String;

    procedure p_HabilitaChave(Tipo : Boolean);

    procedure p_GravarRegistro;
    procedure p_CarregaRegistro;

    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    function f_ObterFiltroSql : String;
    procedure TP_CONSULTAExit(Sender: TObject);
    procedure CD_CAMPOChange(Sender: TObject);
    procedure CD_CAMPOExit(Sender: TObject);
    procedure fDS_EXPRESSAOExit(Sender: TObject);
    procedure fDS_EXPRESSAOKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure p_CarreTabela(vStringGrid : TStringGrid);
    procedure p_CriarTabela(pParent : TWinControl);
    procedure p_LimpaTabela(vStringGrid : TStringGrid);
    procedure p_MontaTabela;
    procedure StringGridDblClick(Sender: TObject);
    procedure ToolButtonFecharClick(Sender: TObject);

    procedure p_CriarAtalho;
    procedure ToolButtonClick(Sender: TObject);
    procedure bConsultaLogClick(Sender: TObject);
    procedure bObservacaoClick(Sender: TObject);
    procedure bConfigurarManutencaoClick(Sender: TObject);
    procedure bConfigurarRelatorioClick(Sender: TObject);
    procedure bMoverCampoClick(Sender: TObject);
    procedure bAjustarCampoClick(Sender: TObject);
  private
    FInEditGravarDef : Boolean;
  protected
    function ClickButton(pName : String) : Boolean;
  public
    cModoFormulario : TModoFormulario;
    cTipoClasseForm : TTipoClasseForm;

    bClrSis,           // Cor sistema

    bCpoMan,           // Campo Fk
    bGrdMan,           // Grid F10
    bDplMan,           // Duplo click F12
    bCtrMan,           // Tela centralizada
    bAutMan : Boolean; // Consulta auto

    cTB,               // Campo tabela
    cTR : String;      // Texto relatorio

    cRegMan,           // Registro manutencao
    cLogMan,           // Log manutencao

    cSql,              // Comando sql

    cColMan,           // Colunas
    cTamMan,           // Tamanho colunas
    cDecMan,           // Decimais colunas
    cIncMan,           // Campo incremento
    cKeyMan,           // Chave primaria
    cTabMan,           // Nome tabela banco dados
    cAtaMan,           // Atalho de tela
    cValMan,           // Valida descricao manutencao ja existe

    cNomTab,           // Nome tabela filha
    cAltTab,           // Altura tabela filha
    cLarTab,           // Largura tabela filha

    cDesCns,           // Descricao consulta
    cOrdCns,           // Ordenacao consulta

    cCaption,
    cCaptionRel   : String;

    iTop,
    iLeft,
    iAltura,
    iLargura      : Integer;

    Capturing     : bool;
    MouseDownSpot : TPoint;

    FParams, FResult, FFiltro : String;

    FInImprimindo : Boolean;
  published
    property _Params : String read FParams write FParams;
    property _Filtro : String read FFiltro write FFiltro;
    property _Result : String read FResult write FResult;

    class function execute(pParams : String) : String;
  end;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucFUNCAO, ucITEM, ucDADOS, ucMENU, ucCONST, ucOBS, ucXML,
  ucLOGALTERACAO, ucCONFMANUT, ucCONFRELAT, ucSELECT, ucMETADATA;

  procedure TcFORM.p_LerIni;
  begin
    bClrSis := IfNullB(LerIni(CLR_SIS), True);

    bCtrMan := IfNullB(LerIni(CTR_MAN), True);
    bAutMan := IfNullB(LerIni(cCaption, AUT_MAN), False);
    bDplMan := IfNullB(LerIni(cCaption, DPL_MAN), False);

    iAltura := IfNullI(LerIni(cCaption, ALT_MAN), 0);
    iLargura := IfNullI(LerIni(cCaption, LAR_MAN), 0);

    cAtaMan := IfNullS(LerIni(cCaption, ATA_MAN), cAtaMan);
    cColMan := IfNullS(LerIni(cCaption, COL_MAN), cColMan);
    cTamMan := IfNullS(LerIni(cCaption, TAM_MAN), cTamMan);
    cDecMan := IfNullS(LerIni(cCaption, DEC_MAN), cDecMan);
    cIncMan := getitem(IfNullS(LerIni(cCaption, INC_MAN), cIncMan));
    cKeyMan := getitem(IfNullS(LerIni(cCaption, KEY_MAN), cKeyMan));
    cValMan := getitem(IfNullS(LerIni(cCaption, VAL_MAN), cValMan));

    cDesCns := LerIni(cCaption, DES_CNS);
    cOrdCns := LerIni(cCaption, ORD_CNS);

    bAjustarCampo.Checked := IfNullB(LerIni(cCaption, RED_MAN), False);
  end;

  function TcFORM.ClickButton(pName : String) : Boolean;
  var
    vToolButton : TToolButton;
  begin
    Result := False;
    vToolButton := TToolButton(FindComponent(pName));
    if (vToolButton = nil) then Exit;
    with vToolButton do begin
      if (Enabled) and (Visible) then begin
        Result := True;
        Click;
      end;
    end;
  end;

//--

class function TcFORM.execute(pParams : String) : String;
begin
  Result := '';
  Application.CreateForm(TComponentClass(Self), Self);
  with TcFORM(Self) do begin
    _Params := pParams;
    if (ShowModal = mrOK) then begin
      Result := _Result;
    end;
  end;
end;

procedure TcFORM.ColorControl(Sender: TObject);
var
  Cor: TColor;
  I: integer;
begin
  if Screen.ActiveForm = nil then
    Exit;

  with Screen.ActiveForm do begin
    for I := 0 to ComponentCount-1 do begin
      if (Components[I] is TCustomEdit) then begin
        if TCustomEdit(Components[I]).TabStop then begin
          if TCustomEdit(Components[I]).Focused then Cor := clYellow
            else Cor := clWindow;
          p_SetPropValue(Components[I], 'Color', IntToStr(Cor));
        end;
      end;
    end;
  end;
end;

procedure TcFORM.FormCreate(Sender: TObject);
begin
  _Query.SQLConnection := dDADOS._Conexao;
  _ToolBar.Images := dDADOS._ImageList;

  bConfigurarManutencao.Visible := FileExists(CFG_SIS);
  bConfigurarRelatorio.Visible := FileExists(REL_SIS);
end;

procedure TcFORM.FormShow(Sender: TObject);
var
  I : Integer;
begin
  p_LerIni;

  if BorderStyle in [bsSizeable] then
    if (iAltura > 0) and (iLargura > 0) then begin
      Height := iAltura * 21;
      Width := iLargura * 8;
      if bCtrMan then begin
        Top := (Screen.Height div 2) - (Height div 2);
        Left := (Screen.Width div 2) - (Width div 2);
      end;
    end else begin
      Top := 25;
      Left := 0;
      Width := Screen.WorkAreaWidth;
      Height := Screen.WorkAreaHeight - 25;
    end;

  for I := 0 to ComponentCount - 1 do
    if (Components[I] is TDBGrid) then begin
      with TDBGrid(Components[I]) do begin
        onDrawColumnCell := TcCADASTROFUNC.onDrawColumnCell;
        onTitleClick := DBGrid1TitleClick;
        onDblClick := DBGrid1DblClick;
        onKeyDown := DBGrid1KeyDown;
      end;
    end;

  if (bClrSis) then
    Screen.OnActiveControlChange := ColorControl;

  p_CorrigeEditFkTela;
  p_CriarAtalho;

  TcCADASTROFUNC.CorrigeDisplayTela(Self);
  TcCADASTROFUNC.CorrigeShapeTela(Self);
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);
end;

procedure TcFORM.FormActivate(Sender: TObject);
begin
  inherited; //
  TcCADASTROFUNC.PosicaoTela(Self);
end;

procedure TcFORM.FormKeyPress(Sender: TObject; var Key: Char);
begin
  Key := TiraAcentosChar(UpCase(Key));
end;

procedure TcFORM.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  vResult : String;
begin
  if (Key = VK_ESCAPE) then begin
    if (ActiveControl is TComboBox) then
      if TComboBox(ActiveControl).DroppedDown then begin
        TComboBox(ActiveControl).DroppedDown := False;
        Exit;
      end;

    Close;
  end;

  if (Key = VK_RETURN) then
    if (ActiveControl is TMemo)
    or (ActiveControl is TDBMemo)
    or (ActiveControl is TStringGrid)
    or (ActiveControl is TDBGrid) then begin {} end
    else Perform(WM_NEXTDLGCTL, 0, 0);

  if (Key = VK_F12) then begin
    if (ActiveControl is TEdit) then begin
      with TEdit(ActiveControl) do begin
        if (Tag = TAG_FK) then begin
          vResult := cMENU.AbreTela(item('CD_CAMPO', Hint), Text);
          if (vResult <> '') then Text := vResult;
          ModalResult := mrNone;
          Key := 0;
        end;
      end;
    end;
  end;
end;

procedure TcFORM.FormResize(Sender: TObject);
begin
  p_AjustarCampos(Self);
end;

procedure TcFORM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Screen.OnActiveControlChange := nil;
  EditGravarDef();
end;

//--

procedure TcFORM.p_Consultar(pSql : String; TOT_REG : Integer = REG_TOTAL);
begin
  _DataSet.PacketRecords := TOT_REG;
  _DataSet.Close;
  _Query.Sql.Text := pSql;
  if LerIniB(TRA_SIS) then
    p_Grava_Log('Form: ' + cCaption + ' Sql: '+ pSql);
  _DataSet.Open;
end;

//--

function TcFORM.f_VerObrigatorio : Boolean;
var
  I : Integer;
begin
  with _DataSet do begin
    for I := 0 to FieldCount-1 do begin
      with Fields[I] do begin
        if (Visible) and (Required) and (AsString='') then begin
          raise Exception.Create('Campo "' + DisplayLabel + '" é obrigatório!');
        end;
      end;
    end;
  end;

  Result := True;
end;

//--

procedure TcFORM.p_CriarCampos(pParent : TWinControl);
var
  vLarg, I, J, vTam, vDec, vCont, vTag : Integer;
  vVerFK, vVerLK, vVerCB : String;
  vComboBox : TcComboBox;
  vEdit, vEditD : TcEdit;
  vInCriado : boolean;
  vLabel : TLabel;
begin
  iTop  := hRecuo;
  iLeft := wRecuo;

  vTag  := TAG_PK;

  vCont := 0;
  vTam := 0;
  vDec := 0;

  with _DataSet do begin
    for I := 0 to FieldCount-1 do begin
      with Fields[I] do begin
        vInCriado := False;

        if (FieldName = 'TP_SITUACAO') or not Visible then begin
          vTag := TAG_NORMAL;
          vInCriado := True;
        end;

        if (cKeyMan <> '') then begin
          vTag := IfThen(Pos(FieldName, cKeyMan) > 0, TAG_PK, TAG_NORMAL);
        end;

        if not vInCriado and (cColMan <> '') then begin
          vInCriado := (Pos(FieldName, cColMan)=0);
          Inc(vCont);
          vTam := StrToIntDef(getitem(cTamMan, vCont),0);
          vDec := StrToIntDef(getitem(cDecMan, vCont),0);
        end;

        iLeft := wRecuo;

        if not vInCriado then begin
          vLabel := TLabel.Create(Self);
          vLabel.Name := 'label' + FieldName;
          vLabel.Caption := DisplayLabel + IfThen(Required, ' *', '');
          if (Required) then
            vLabel.Font.Style := vLabel.Font.Style + [fsBold];
          vLabel.Parent := pParent;
          vLabel.Top := iTop;
          vLabel.Left := iLeft;
          vLabel.Width := larLabel;
          vLabel.Transparent := True;
          //vLabel.Alignment := taCenter;
          vLabel.AutoSize := False;
          vLabel.Layout := tlCenter;

          Inc(iLeft, vLabel.Width + colRecuo);

          if not vInCriado then begin
            vVerLK := cMENU.f_VerLK(FieldName, cTabMan);
            if (vVerLK = '') then begin
              vVerCB := cMENU.f_VerCB(FieldName);
            end;

            if (vVerCB <> '') or (vVerLK <> '') then begin
              vComboBox := TcComboBox.Create(Self);
              vComboBox.Name := FieldName;
              vComboBox.Parent := pParent;
              vComboBox.Height := hEscala;
              vComboBox.Width := 40 * wEscala;
              vComboBox.Top := iTop;
              vComboBox.Left := iLeft;
              vComboBox.Tag := vTag;
              vComboBox.Style := csDropDownList;
              vComboBox._Campo := FieldName;

              if (vVerLK <> '') then begin
                dDADOS.p_GeraListaTabela(vComboBox.Items, vVerLK);
              end else if (vVerCB <> '') then begin
                vComboBox.p_AddLista(vVerCB);
              end;

              vLarg := 0;
              with vComboBox, vComboBox.Items do
                for J := 0 to Count-1 do
                  if Length(Items[J]) > vLarg then
                    vLarg := Length(Items[J]);

              vComboBox.Width := vLarg * wEscala + 30;

              Inc(iTop, vComboBox.Height + linRecuo);

              vInCriado := True;
            end;
          end;

          if not vInCriado then begin
            vEdit := TcEdit.Create(Self);
            vEdit.Name := FieldName;
            vEdit.AutoSize := False;
            vEdit.Parent := pParent;
            vEdit.Height := hEscala;
            vEdit.Width := DisplayWidth * wEscala;
            vEdit.Top := iTop;
            vEdit.Left := iLeft;
            vEdit.Tag := vTag;
            vEdit.Text := '';
            vEdit._Campo := FieldName;

            if (TcCADASTROFUNC.IsFieldAlfa(FieldName, _DataSet)) then begin
              vEdit.MaxLength := Size;
            end;

            if (TcCADASTROFUNC.IsFieldDate(FieldName, _DataSet)) then begin
              vEdit._TpDado := tpdData;
            end else if (TcCADASTROFUNC.IsFieldInteger(FieldName, _DataSet)) then begin
              vEdit._TpDado := tpdInteiro;
            end else if (TcCADASTROFUNC.IsFieldFloat(FieldName, _DataSet)) then begin
              vEdit._TpDado := tpdNumero;
            end else begin
              vEdit._TpDado := tpdAlfa;
            end;

            if (vTam <> 0) then vEdit.Width := vTam * wEscala;
            if (vDec <> 0) then vEdit.Height := vDec * hEscala;

            vEdit.OnChange := EditChange;
            vEdit.OnDblClick := EditDblClick;
            vEdit.OnEnter := EditEnter;
            vEdit.OnExit := EditExit;
            vEdit.OnMouseDown := EditMouseDown;

            Inc(iTop, vEdit.Height + linRecuo);

            if ((vEdit.Width + vEdit.Left) > Width) then begin
              vEdit.Width := Width - vEdit.Left - 100;
            end;

            vVerFK := cMENU.f_VerFK(FieldName, cTabMan);

            if (vVerFK <> '') then begin
              vEdit.Tag := TAG_FK;
              vEdit.Hint := vVerFK;

              vEditD := TcEdit.Create(Self);
              vEditD.Name := 'd' + FieldName;
              vEditD.Parent := pParent;
              vEditD.Height := hEscala;
              vEditD.Width := (50 * wEscala) - 2;
              vEditD.Top := vEdit.Top;
              vEditD.Left := vEdit.Left + vEdit.Width + 2;
              vEditD.Color := clBtnFace;
              vEditD.ReadOnly := True;
              vEditD.TabStop := False;
              vEditD.Text := '';

              if IfNullB(LerIni(cCaption, CAD_DES), False) then begin
                p_SetarDescr(vEditD, cModoFormulario);
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  p_CriarTabela(pParent);
end;

procedure TcFORM.p_AjustarCampos(pParent : TWinControl);
var
  iLinha, iColuna, iLargura, I : Integer;
  vCampo, vDescr : TWinControl;
  vCod, sXY : String;
  vLabel : TLabel;

  procedure prcPosicaoAnt();
  begin
    if bAjustarCampo.Checked then begin
      if (iLeft + iLargura + (larLabel div 2)) > Width then begin
        Inc(iTop, vCampo.Height + colRecuo);
        iLeft := wRecuo;
      end;
      Exit;
    end;

    sXY := LerIni(cCaption, vCampo.Name + 'xy');
    iLinha := itemI('NR_LINHA', sXY);
    iColuna := itemI('NR_COLUNA', sXY);
    if (iLinha <> 0) then vCampo.Top := iLinha;
    if (iColuna <> 0) then vCampo.Left := iColuna;
  end;

  procedure prcPosicaoPos();
  begin
    if bAjustarCampo.Checked then begin
      if (iLeft + iLargura + (larLabel div 2)) > Width then begin
        Inc(iTop, vCampo.Height + colRecuo);
        iLeft := wRecuo;
      end else begin
        Inc(iLeft, iLargura);
      end;
      Exit;
    end;

    Inc(iTop, vCampo.Height + colRecuo);
  end;

begin
  if not Visible then
    Exit;

  iTop := hRecuo;
  iLeft := wRecuo;

  with _DataSet do begin
    for I:=0 to FieldCount-1 do begin
      with Fields[I] do begin
        vCod := FieldName;

        vLabel := TLabel(Self.FindComponent('label' + vCod));
        vCampo := TWinControl(Self.FindComponent(vCod));
        vDescr := TWinControl(Self.FindComponent('d' + vCod));

        if vCampo = nil then
          Continue;

        iLargura := 0;
        if vLabel <> nil then Inc(iLargura, vLabel.Width + colRecuo);
        if vCampo <> nil then Inc(iLargura, vCampo.Width + colRecuo);
        if vDescr <> nil then Inc(iLargura, vDescr.Width + colRecuo);

        prcPosicaoAnt();

        vCampo.Top := iTop;
        vCampo.Left := iLeft + larLabel;
        EditAjuste(vCampo);

        prcPosicaoPos();
      end;
    end;
  end;
end;

//--

procedure TcFORM.EditEnter(Sender: TObject);
begin
//
end;

procedure TcFORM.EditExit(Sender: TObject);
var
  vEditCod, vEditDes : TEdit;
  vParams : String;
begin
  vEditCod := TEdit(Sender);

  if not TcCADASTROFUNC.EditValida(_DataSet, Sender) then
    Exit;

  if vEditCod.Tag = TAG_PK then begin
    if not f_ConsultarChave then begin
      vEditCod.Text := '';
      vEditCod.SetFocus;
    end else begin
      Exit;
    end;
  end;

  if (vEditCod.Hint <> '') and (vEditCod.Tag = TAG_FK) then begin
    vEditDes := TEdit(FindComponent('d' + vEditCod.Name));
    if vEditDes <> nil then begin
      vParams := vEditCod.Hint;
      putitem(vParams, 'CD_VALUE', vEditCod.Text);
      vEditDes.Text := dDADOS.f_BuscarDescricao(vParams);
    end;
  end;

  if vEditCod.Name = cValMan then
    EditExitVal(Sender);
end;

procedure TcFORM.EditExitVal(Sender: TObject);
var
  vEditKey, vEditVal : TEdit;
  vResult, vSql : String;
begin
  vEditVal := TEdit(Sender);
  vEditKey := TEdit(FindComponent(cKeyMan));

  vSql :=
    'select * from ' + cTabMan + ' ' +
    'where ' + cValMan + '=''' + vEditVal.Text + ''' ' +
    'and ' + cKeyMan + '<>' + vEditKey.Text + ' ' ;

  vResult := dDADOS.f_ConsultaStrSql(vSql, '*');
  if item(cKeyMan, vResult) = '' then
    Exit;

  if not Pergunta('Registro "' + item(cKeyMan, vResult) + '" já existe cadastrado com a descrição! Deseja carregar ?') then
    Exit;

  vEditKey.Text := item(cKeyMan, vResult);
  f_ConsultarChave;
end;

//-- pesquisa

procedure TcFORM.p_SetarDescr(pEditDes : TEdit; pModoFormulario : TModoFormulario);
var
  vCombo : TcComboBoxPesq;
  vEditCod : TEdit;
  vForm : TForm;
  vCod : String;
begin
  if pModoFormulario in [mfConsulta, mfConsultaSomente] then begin
    vCod := pEditDes.Name;
    Delete(vCod, 1, 1);

    vForm := TForm(pEditDes.Owner);
    if vForm = nil then
      Exit;

    vEditCod := TEdit(vForm.FindComponent(vCod));
    if vEditCod = nil then
      Exit;

    vCombo := TcComboBoxPesq.create(pEditDes.Owner);
    with vCombo do begin
      _EditCod := vEditCod;
      Parent := pEditDes.Parent;
      Name := pEditDes.Name + '_Pesq';
      TabOrder := pEditDes.TabOrder;
      Top := pEditDes.Top;
      Left := pEditDes.Left;
      Height := pEditDes.Height;
      Width := pEditDes.Width;
      Text := '';
    end;

    FreeAndNil(pEditDes);

    with vCombo do
      Name := AnsiReplaceStr(Name, '_Pesq', '');

    Exit;
  end;

  with pEditDes do begin
    Color := clWindow;
    ReadOnly := False;
    TabStop := True;
    OnExit := EditExitCad;
    OnKeyPress := EditKeyPressCad;
  end;
end;

//--
procedure TcFORM.EditKeyPressCad(Sender: TObject; var Key: Char);
begin
  TcCADASTROFUNC.EditKeyPressDescr(Sender, Key);
end;

procedure TcFORM.EditExitCad(Sender: TObject);
var
  vLstCod,
  vParams, vResult,
  vSql, vEnt, vCod, vDes, vSeq, vVal : String;
  vEditCod, vEditDes : TEdit;
  vTotal : Integer;
  vForm : TForm;
begin
  vEditDes := TEdit(Sender);
  if vEditDes = nil then
    Exit;

  vForm := TForm(vEditDes.Owner);
  if vForm = nil then
    Exit;

  vCod := vEditDes.Name;
  Delete(vCod, 1, 1);

  vEditCod := TEdit(vForm.FindComponent(vCod));
  if vEditCod = nil then
    Exit;
  if vEditDes.Text = '' then begin
    vEditCod.Text := '';
    Exit;
  end;

  vParams := vEditCod.Hint;
  if vParams = '' then
    Exit;

  vEnt := item('DS_TABELA', vParams);
  vCod := item('CD_CAMPO', vParams);
  vDes := item('DS_CAMPO', vParams);
  vVal := AllTrim(vEditDes.Text);

  vParams := '';
  putitemX(vParams, 'DS_TABELA', vEnt);
  putitemX(vParams, 'CD_CAMPO', vCod);
  putitemX(vParams, 'DS_CAMPO', vDes);
  putitemX(vParams, 'VL_CAMPO', vVal);
  vResult := TcComboBoxPesq.Pesquisar(vParams);

  vLstCod := listCd(vResult);
  vVal := getitem(vLstCod);
  vTotal := itemcount(vLstCod);
  if vTotal > 0 then begin
    vEditCod.Text := vVal;
    vEditDes.Text := item(vVal, vResult);
    Exit;
  end;

  if not Pergunta('Registro não cadastrado! Deseja cadastrar ?') then
    Exit;

  vSeq := IntToStr(dDADOS.f_IncrementoCodigo(vEnt, vCod));

  vSql :=
    'insert into ' + vEnt + ' (' + vCod + ', ' + vDes + ') ' +
    'values (' + vSeq + ', ''' + vEditDes.Text + ''') ' ;

  dDADOS.f_RunSql(vSql);

  vEditCod.Text := vSeq;
end;

procedure TcFORM.EditChange(Sender: TObject);
begin
  if (TEdit(Sender).Tag <> TAG_FK) then
    Exit;
  EditExit(Sender);
end;

procedure TcFORM.EditDblClick(Sender: TObject);
var
  vResult : String;
begin
  vResult := cMENU.AbreTela(item('CD_CAMPO', TEdit(Sender).Hint), TEdit(Sender).Text);
  if (vResult <> '') then TEdit(Sender).Text := vResult;
  ModalResult := mrNone;
end;

//--

procedure TcFORM.EditMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  SC_MOVE = $F012;

  function Prop(p1, p2 : Integer) : Integer;
  begin
    Result := (p1 div p2) * p2;
  end;

begin
  if not bMoverCampo.Checked then
    Exit;

  ReleaseCapture;

  with TWinControl(Sender) do begin
    Perform(WM_SYSCOMMAND, SC_MOVE, 0);
    Top := hRecuo + Prop(Top, hEscala + linRecuo);
    Left := wRecuo + Prop(Left, wEscala + colRecuo) + 1;
    EditAjuste(Sender);
    SetFocus;
  end;

  FInEditGravarDef := True;
end;

procedure TcFORM.EditGravarDef();
var
  vParams : String;
  I : Integer;
begin
  if not FInEditGravarDef then
    Exit;

  for I := ComponentCount-1 downto 0 do begin
    if (Components[I] is TEdit) then begin
      with TWinControl(Components[I]) do begin
        vParams := '';
        putitem(vParams, 'NR_LINHA', Top);
        putitem(vParams, 'NR_COLUNA', Left);
        fGravaIni(cCaption, Name + 'xy', vParams);
      end;
    end;
  end;
end;

procedure TcFORM.EditAjuste(Sender: TObject);
var
  vShape : TShape;
  vLabel : TLabel;
  vEdit : TEdit;
begin
  vLabel := TLabel(FindComponent('label' + TEdit(Sender).Name));
  if (vLabel <> nil) then begin
    vLabel.Parent := TEdit(Sender).Parent;
    vLabel.Left := TEdit(Sender).Left - larLabel - colRecuo;
    vLabel.Top := TEdit(Sender).Top {- 2};
  end;

  vShape := TShape(FindComponent('Shape' + TEdit(Sender).Name));
  if (vShape <> nil) then begin
    vShape.Parent := TEdit(Sender).Parent;
    vShape.Left := TEdit(Sender).Left - 2;
    vShape.Top := TEdit(Sender).Top - 2;
  end;

  if (TEdit(Sender).Tag = TAG_FK) then begin
    vEdit := TEdit(FindComponent('d' + TEdit(Sender).Name));
    if (vEdit <> nil) then begin
      vEdit.Left := TEdit(Sender).Left + TEdit(Sender).Width + 2;
      vEdit.Top := TEdit(Sender).Top;

      vShape := TShape(FindComponent('Shape' + vEdit.Name));
      if (vShape <> nil) then begin
        vShape.Left := vEdit.Left - 2;
        vShape.Top := vEdit.Top - 2;
      end;
    end;
  end;
end;

//--

procedure TcFORM.p_CorrigeEditFkTela;
var
  I : Integer;
begin
  for I := 0 to ComponentCount - 1 do begin
    if (Components[I] is TEdit) then begin
        with TEdit(Components[I]) do begin
        if (Tag = TAG_FK) then begin
          if (Hint = '') then begin
            Hint := cMENU.f_VerFK(Copy(Name, 2, Length(Name)-1));
          end;
          if (Hint <> '') then begin
            OnChange := EditChange;
            OnExit := EditExit;
            OnDblClick := EditDblClick;
          end;
        end;
      end;
    end;
  end;
end;

procedure TcFORM._DataSetAfterPost(DataSet: TDataSet);
begin
  _DataSet.ApplyUpdates(0);
end;

//--

procedure TcFORM._DataSetBeforePost(DataSet: TDataSet);
begin
  dDADOS.p_IncrementoCodigo(_DataSet, cTabMan, cIncMan);
end;

//--

procedure TcFORM.p_CarregarCampos(vCampo : String);
var
  Component : TComponent;
  vCod : String;
  I : Integer;
begin
  if (FInImprimindo) then
    Exit;

  try
    with _DataSet do begin
      for I := 0 to FieldCount-1 do begin
        with Fields[I] do begin
          vCod := FieldName;
          if (Visible) and ((vCampo = '') or (vCod = vCampo)) then begin
            Component := Self.FindComponent(vCod);
            p_SetPropValue(Component, '_Value', AsString);
          end;
        end;
      end;
    end;
  except
  end;
end;

procedure TcFORM.p_DesCarregarCampos(vCampo : String);
var
  Component : TComponent;
  vCod : String;
  I : Integer;
begin
  EditCancel.SetFocus;

  with _DataSet do begin
    for I := 0 to FieldCount - 1 do begin
      with Fields[I] do begin
        vCod := FieldName;
        if (Visible) and ((vCampo = '') or (vCod = vCampo)) then begin
          Component := Self.FindComponent(vCod);
          AsString := p_GetPropValue(Component, '_Value');
        end;
      end;
    end;
  end;
end;

//--

procedure TcFORM._DataSetAfterOpen(DataSet: TDataSet);
var
  I : Integer;
begin
  TcCADASTROFUNC.CorrigeDisplayLabel(DataSet);

  with _DataSet do begin
    for I := 0 to _DataSet.FieldCount-1 do begin
      with Fields[I] do begin
        if (Copy(FieldName, 1, 3) = 'TP_') then begin
          if (FieldName = 'TP_SITUACAO') then begin
            Visible := False;
          end else begin
            if (cMENU.f_VerCB(FieldName) <> '') then begin
              OnGetText := _DataSetGetText_TP;
              Alignment := taLeftJustify;
            end;
          end;
        end;

        if (Copy(FieldName, 1, 3) = 'IN_') then begin
          OnGetText := _DataSetGetText_IN;
          Alignment := taLeftJustify;
        end;
      end;
    end;
  end;
end;

procedure TcFORM._DataSetAfterEdit(DataSet: TDataSet);
begin
  putlistitensocc(cLogMan, _DataSet);
end;

procedure TcFORM._DataSetNewRecord(DataSet: TDataSet);
begin
  cLogMan := '';
  putitem(DataSet, 'TP_SITUACAO', 1);
  dDADOS.p_IncrementoCodigo(_DataSet, cTabMan, cIncMan);
end;

//--

procedure TcFORM._DataSetGetText_FK(Sender: TField; var Text: String; DisplayText: Boolean);
var
  vVerFK : String;
begin
  vVerFK := cMENU.f_VerFK(TField(Sender).FieldName);
  if (vVerFK <> '') then begin
    putitem(vVerFK, 'CD_VALUE', TField(Sender).asString);
    Text := dDADOS.f_BuscarDescricao(vVerFK);
  end;
end;

procedure TcFORM._DataSetGetText_IN(Sender: TField; var Text: String; DisplayText: Boolean);
const
  cLST_BOOL = 'T=Sim;F=Nao';
begin
  with TField(Sender) do
    if Text <> '' then
      Text := item(Text, cLST_BOOL);
end;

procedure TcFORM._DataSetGetText_TP(Sender: TField; var Text: String; DisplayText: Boolean);
var
  vDsCampo : String;
begin
  if (Copy(TField(Sender).FieldName, 1, 3) = 'TP_') then begin
    vDsCampo := cMENU.f_VerCB(TField(Sender).FieldName);
    Text := item(TField(Sender).asString, vDsCampo);
  end else begin
    Text := TField(Sender).asString;
  end;
end;

//--

function TcFORM.f_ConsultarChave : Boolean;
var
  vSql, vSqlChave : String;
begin
  Result := True;

  if cModoFormulario in [mfConsulta, mfConsultaSomente] then
    Exit;

  vSqlChave := f_GerarChave(False);
  if vSqlChave = '' then
    Exit;

  vSql := 'select * from ' + cTabMan + ' where ' + vSqlChave;

  if dDADOS.f_ExistSql(vSql) then begin
    if Pergunta('Registro já existe no banco de dados! Deseja consultar?') then begin
      p_Consultar(vSql);
      if itemI('TP_SITUACAO', _DataSet) = 3 then begin
        if Pergunta('Registro excluído no banco de dados! Deseja reativá-lo novamente?') then begin
          putitem(_DataSet, 'TP_SITUACAO', 1);
          Mensagem('Registro reativado com sucesso!');
        end;
      end;
      _DataSet.Edit;
      p_CarregarCampos;
    end else begin
      Result := False;
    end;
  end;
end;

function TcFORM.f_GerarChave(vParcial : Boolean) : String;
var
  vDsValue, vSql : String;
  vAchei : Boolean;
  vEdit : TEdit;
  I : Integer;
begin

  {
  ConsultaChave - OK
  Incremento    - OK
  MontaTabela   - OK
  }

  vAchei := False;

  vSql := '';

  with _DataSet do begin
    for I := 0 to FieldCount-1 do begin
      with Fields[I] do begin
        if (Tag = TAG_PK) then begin
          vEdit := TEdit(Self.FindComponent(FieldName));
          if (vEdit <> nil) then vDsValue := vEdit.Text;
          if (vDsValue <> '') then begin
            if (vSql <> '') then vSql := vSql + ' and ';
            vSql := vSql + FieldName + '=''' + vDsValue + '''';
          end else begin
            vAchei := True;
          end;
        end;
      end;
    end;
  end;

  if vAchei and not vParcial then vSql := '';

  Result := vSql;
end;

//--

procedure TcFORM.p_HabilitaChave(Tipo : Boolean);
var
  vEdit : TEdit;
  I : Integer;
begin
  with _DataSet do begin
    for I := 0 to FieldCount - 1 do begin
      if (Fields[I].Tag = TAG_PK) then begin
        vEdit := TEdit(Self.FindComponent(Fields[I].FieldName));
        if (vEdit <> nil) then begin
          vEdit.Enabled := Tipo;
          vEdit.TabStop := Tipo;
        end;
      end;
    end;
  end;
end;

//--

procedure TcFORM.p_GravarRegistro;
begin
  putlistitensocc(cRegMan, _DataSet);
end;

procedure TcFORM.p_CarregaRegistro;
begin
  if (cRegMan = '') then Exit;
  getlistitensocc(cRegMan, _DataSet);
  p_CarregarCampos
end;

//--

procedure TcFORM.DBGrid1TitleClick(Column: TColumn);
begin
  _DataSet.IndexFieldNames := Column.FieldName;
end;

procedure TcFORM.DBGrid1DblClick(Sender: TObject);
var
  Component : TComponent;
begin
  if (cModoFormulario = mfConsulta) then Exit;
  if (bDplMan) then begin
    if (cKeyMan <> '') then
      Hint := item(cKeyMan, _DataSet);
    ModalResult := mrOk;
  end else begin
    Component := FindComponent('ToolButtonAlterar');
    if (Component is TToolButton) then
      TToolButton(Component).Click;
  end;
end;

procedure TcFORM.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (bDplMan) then begin
    if (Key = VK_RETURN) then begin
      bGrdMan := not bGrdMan;
      with TDBGrid(Sender) do begin
        if (bGrdMan) then begin
          Options := Options - [dgRowselect];
          Options := Options + [dgEditing];
        end else begin
          Options := Options - [dgEditing];
          Options := Options + [dgRowselect];
        end;
      end;
    end;
  end;
end;

//--

function TcFORM.f_ObterFiltroSql : String;
var
  TP_CONSULTA, CD_CAMPO : TComboBox;
  fDS_EXPRESSAO : TEdit;
  vCod, vVal : String;
begin
  Result := '/*WHERE*/';

  TP_CONSULTA := TComboBox(FindComponent('TP_CONSULTA'));
  CD_CAMPO := TComboBox(FindComponent('CD_CAMPO'));
  fDS_EXPRESSAO :=  TEdit(FindComponent('fDS_EXPRESSAO'));

  if (TP_CONSULTA = nil)
  or (CD_CAMPO = nil)
  or (fDS_EXPRESSAO = nil) then Exit;

  with _DataSet do begin
    if Active then begin
      if (fDS_EXPRESSAO.Text <> '') and (CD_CAMPO.ItemIndex >- 1) then begin
        vCod := Fields[CD_CAMPO.ItemIndex].FieldName;
        vVal := fDS_EXPRESSAO.Text;

        if (Fields[CD_CAMPO.ItemIndex].DataType in [ftDate, ftDateTime]) then
          vVal := FormatDateTime('yyyy/mm/dd', StrToDateDef(fDS_EXPRESSAO.Text,0));

        with TP_CONSULTA do begin
          if (ItemIndex = 0) then begin // Completa
            AddSqlWhere(Result, vCod + '=''' + vVal + ''' ');
          end else if (ItemIndex = 1) then begin // Parcial
            AddSqlWhere(Result, vCod + ' like ''' + vVal + '%'' ');
          end else if (ItemIndex = 2) then begin // Qualquer
            AddSqlWhere(Result, vCod + ' like ''%' + ReplaceStr(vVal,' ','%') + '%'' ');
          end;
        end;
      end;
    end;
  end;

  if (Hint <> '') and (cKeyMan <> '') then
    AddSqlWhere(Result, cKeyMan + '=''' + Hint + ''' ');

  if cOrdCns <> '' then
    AddSqlOrder(Result, cOrdCns + ' ');
end;

procedure TcFORM.TP_CONSULTAExit(Sender: TObject);
begin
  fGravaIni(cCaption, TIP_CNS, TComboBox(Sender).ItemIndex);
end;

procedure TcFORM.CD_CAMPOChange(Sender: TObject);
var
  vTP_CONSULTA : TComboBox;
begin
  vTP_CONSULTA := TComboBox(FindComponent('TP_CONSULTA'));
  if (vTP_CONSULTA = nil) then
    Exit;

  with TComboBox(Sender) do
    if (_DataSet.Fields[ItemIndex].DataType in [ftDate, ftDateTime]) then
      vTP_CONSULTA.ItemIndex := 0;
end;

procedure TcFORM.CD_CAMPOExit(Sender: TObject);
begin
  fGravaIni(cCaption, COD_CNS, TComboBox(Sender).ItemIndex);
end;

procedure TcFORM.fDS_EXPRESSAOExit(Sender: TObject);
var
  vCD_CAMPO : TComboBox;
begin
  vCD_CAMPO := TComboBox(FindComponent('CD_CAMPO'));
  if (vCD_CAMPO = nil) then
    Exit;

  if (vCD_CAMPO.ItemIndex=-1) then
    Exit;

  if (TEdit(Sender).Text <> '') then begin
    TcCADASTROFUNC.EditValida(_DataSet, Sender, _DataSet.Fields[vCD_CAMPO.ItemIndex].FieldName);
  end;
end;

procedure TcFORM.fDS_EXPRESSAOKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_SPACE then
    ClickButton('ToolButtonConsultar');
end;

//--

procedure TcFORM.p_CriarTabela(pParent : TWinControl);
var
  vLstCod, vCod, vTB, vAux : String;
  I, J, T, vLargura : Integer;
  vStringGrid : TStringGrid;
  vLabel : TLabel;
begin
  cNomTab := LerIni(cCaption, NOM_TAB);
  cAltTab := LerIni(cCaption, ALT_TAB);
  cLarTab := LerIni(cCaption, LAR_TAB);

  if (cNomTab <> '') then begin
    T := itemcount(cNomTab);
    for I := 1 to T do begin
      putitemX(cTB, getitem(cNomTab, I),
               'DS_TABELA=' + getitem(cNomTab, I) + ';' +
               'DS_CAMPO=' + LerIni(getitem(cNomTab, I), COL_MAN) + ';' +
               'DS_TAM=' + LerIni(getitem(cNomTab, I), TAM_MAN) + ';' +
               'DS_CHAVE=' + LerIni(getitem(cNomTab, I), KEY_MAN) + ';' +
               'NR_ALTURA=' + getitem(cAltTab, I) + ';' +
               'NR_LARGURA=' + getitem(cLarTab, I));
    end;
  end;

  vLstCod := listCdX(cTB);
  while vLstCod <> '' do begin
    vCod := getitem(vLstCod);
    if vCod = '' then Break;
    delitem(vLstCod);

    vTB := itemX(vCod, cTB);

    vLabel := TLabel.Create(Self);
    vLabel.Name := 'label' + 't' + item('DS_TABELA', vTB);
    vLabel.Caption := item('DS_TABELA', vTB);
    vLabel.Parent := pParent;
    vLabel.Top := iTop;
    vLabel.Left := iLeft;
    vLabel.Transparent := True;

    vStringGrid := TStringGrid.Create(Self);
    vStringGrid.Name := 't' + item('DS_TABELA', vTB);
    vStringGrid.Parent := pParent;
    vStringGrid.Left := iLeft + 100;
    vStringGrid.Top := iTop;
    vStringGrid.ColCount := itemcount(item('DS_CAMPO', vTB));
    vStringGrid.RowCount := itemI('NR_ALTURA', vTB);
    vStringGrid.Height := (vStringGrid.RowCount + 1) * hEscala;
    if (item('NR_LARGURA', vTB) <> '') then
      vStringGrid.Width := itemI('NR_LARGURA', vTB) * wEscala;
    vStringGrid.Hint := vTB;
    vStringGrid.DefaultRowHeight := hEscala;
    vStringGrid.FixedColor := 12615680;
    vStringGrid.FixedCols := 0;
    vStringGrid.OnDblClick := StringGridDblClick;
    vAux := item('DS_TAM', vTB);
    vLargura := 0;
    for J := 0 to itemcount(item('DS_CAMPO', vTB))-1 do begin
      vStringGrid.ColWidths[J] := StrToIntDef(getitem(vAux, J+1),0) * wEscala;
      vLargura := vLargura + StrToIntDef(getitem(vAux, J+1),0) * wEscala;
    end;
    if (item('NR_LARGURA', vTB) = '') then
      vStringGrid.Width := vLargura + 20;
    iTop := iTop + vStringGrid.Height + 3;
  end;
end;

procedure TcFORM.p_CarreTabela(vStringGrid : TStringGrid);
var
  vTB, vTabela, vCampo, vChave, vSql, vCod : String;
begin
  vTB := vStringGrid.Hint;

  vTabela := IfNullS(LerIni('GER_' + item('DS_TABELA', vTB), TAB_MAN), item('DS_TABELA', vTB));
  vCampo := item('DS_CAMPO', vTB);
  vChave := item('DS_CHAVE', vTB);

  vSql := '';

  while vCampo <> '' do begin
    AddSqlField(vSql, getitem(vCampo));
    delitem(vCampo)
  end;

  AddSqlFrom(vSql, vTabela);

  while vChave <> '' do begin
    vCod := getitem(vChave);
    AddSqlField(vSql, vCod + '=' + item(vCod, _DataSet));
    delitem(vChave)
  end;

  with dDADOS.getQuery() do begin
    Close;
    SQL.Text := vSql;
    Open;
  end;
end;

procedure TcFORM.p_LimpaTabela(vStringGrid : TStringGrid);
var
  L : Integer;
begin
  //Limpar o conteudo dos registros
  with vStringGrid do begin
    RowCount := 1;
    RowCount := 2;
    FixedRows := 1;
    with dDADOS.getQuery() do
      for L := 0 to FieldCount-1 do
        Cells[L, RowCount-2] := Fields[L].DisplayLabel;
  end;
end;

procedure TcFORM.p_MontaTabela;
var
  vLstCod, vCod, vTB : String;
  vStringGrid : TStringGrid;
  Component : TComponent;
  L : Integer;
begin
  vLstCod := listCdX(cTB);
  while vLstCod <> '' do begin
    vCod := getitem(vLstCod);
    if vCod = '' then Break;
    delitem(vLstCod);

    vTB := itemX(vCod, cTB);

    Component := FindComponent('t' + item('DS_TABELA', vTB));

    if (Component is TStringGrid) then begin
      vStringGrid := TStringGrid(Component);

      p_CarreTabela(vStringGrid);
      p_LimpaTabela(vStringGrid);

      with dDADOS.getQuery() do begin
        if not IsEmpty then begin

          First;
          while not EOF do begin
            for L := 0 to FieldCount-1 do
              vStringGrid.Cells[L, vStringGrid.RowCount-1] := Fields[L].Text;
            Next;
            if not EOF then
              vStringGrid.RowCount := vStringGrid.RowCount + 1;
          end;

        end;
      end;
    end;
  end;
end;

//--

procedure TcFORM.StringGridDblClick(Sender: TObject);
var
  vCampo : String;
begin
  with TStringGrid(Sender) do begin
    if (Hint = '') then Exit;

    vCampo := getitem(LerIni(item('DS_TABELA', Hint), KEY_MAN), 1);
    if (vCampo = '') then Exit;

    cMENU.AbreTela(vCampo);
  end;
end;

//--

procedure TcFORM.ToolButtonFecharClick(Sender: TObject);
begin
  Close;
end;

//--

procedure TcFORM.p_CriarAtalho;
var
  T, I : Integer;
begin
  _CoolBarAtalho.Visible := (cAtaMan <> '');

  if (cAtaMan = '') then
    Exit;

  T := itemcount(cAtaMan);

  for I := 1 to T do begin
    with TToolButton.Create(Self) do begin
      Name := 'ToolButton' + getitem(cAtaMan, I);
      Caption := PriMaiuscula(getitem(cAtaMan, I));
      Hint := getitem(cAtaMan, I);
      AutoSize := True;
      Parent := _ToolBarAtalho;
      OnClick := ToolButtonClick;
    end;
  end;
end;

procedure TcFORM.ToolButtonClick(Sender: TObject);
var
  vCampo : String;
begin
  if (TToolButton(Sender).Hint = '') then
    Exit;

  vCampo := getitem(LerIni(TToolButton(Sender).Hint, KEY_MAN), 1);
  if (vCampo = '') then Exit;

  cMENU.AbreTela(vCampo, '');
end;

procedure TcFORM.bConsultaLogClick(Sender: TObject);
begin
  TcLOGALTERACAO.Consultar(_DataSet, cTabMan);
end;

procedure TcFORM.bObservacaoClick(Sender: TObject);
begin
  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_CONSULTAVAZIA);

  TcOBS.Editar(_DataSet, cTabMan);
end;

procedure TcFORM.bConfigurarManutencaoClick(Sender: TObject);
begin
  TcCONFMANUT.Executar(cCaption, cTabMan);
end;

procedure TcFORM.bConfigurarRelatorioClick(Sender: TObject);
begin
  TcCONFRELAT.ConfigurarRelat(cCaption, cTabMan);
end;

procedure TcFORM.bMoverCampoClick(Sender: TObject);
begin
  bMoverCampo.Checked := not bMoverCampo.Checked;
end;

procedure TcFORM.bAjustarCampoClick(Sender: TObject);
begin
  bAjustarCampo.Checked := not bAjustarCampo.Checked;
  fGravaIni(cCaption, RED_MAN, bAjustarCampo.Checked);
  p_AjustarCampos(Self);
end;

//--

end.
