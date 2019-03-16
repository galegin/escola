unit ucCONSULTA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, Grids, DBGrids, StdCtrls,
  FMTBcd, DB, DBClient, Provider, SqlExpr, ucFORM, Menus, ExtCtrls;

type
  TcCONSULTA = class(TcFORM)
    ToolButtonS1: TToolButton;
    ToolButtonConsultar: TToolButton;
    ToolButtonLimpar: TToolButton;
    ToolButtonImprimir: TToolButton;
    ToolButtonS2: TToolButton;
    ToolButtonNovo: TToolButton;
    ToolButtonAlterar: TToolButton;
    ToolButtonExcluir: TToolButton;
    Panel1: TPanel;
    LabelTpConsulta: TLabel;
    LabelPesquisarPor: TLabel;
    LabelExpressao: TLabel;
    TP_CONSULTA: TComboBox;
    CD_CAMPO: TComboBox;
    fDS_EXPRESSAO: TEdit;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ToolButtonNovoClick(Sender: TObject);
    procedure ToolButtonAlterarClick(Sender: TObject);
    procedure ToolButtonExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ToolButtonConsultarClick(Sender: TObject);
    procedure ToolButtonLimparClick(Sender: TObject);
    procedure ToolButtonImprimirClick(Sender: TObject);
  private
  published
    class function execute(pParams : String = '') : String;
  end;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucMANUTENCAO, ucRELATORIO, ucDADOS, ucITEM, ucFUNCAO, ucCONST;

//------------------------------------------------------------------------------

class function TcCONSULTA.execute(pParams : String) : String;
begin
  with TcCONSULTA.Create(nil) do begin  
    Name := item('DS_CAPTION', pParams);
	
    try
      _Params := pParams;
      ShowModal;
      Result := _Result + Hint;
    finally
      Free;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TcCONSULTA.FormCreate(Sender: TObject);
begin
  cModoFormulario:=mfConsultaManutencao;
  cTipoClasseForm:=tcfConsulta;
  
  inherited;
  
  bConfigurarManutencao.Visible := FileExists(CFG_SIS);
  bConfigurarRelatorio.Visible := FileExists(REL_SIS);

  CD_CAMPO.OnChange := CD_CAMPOChange;
  CD_CAMPO.OnExit := CD_CAMPOExit;
  fDS_EXPRESSAO.OnExit := fDS_EXPRESSAOExit;
  TP_CONSULTA.OnExit := TP_CONSULTAExit;
end;

procedure TcCONSULTA.FormShow(Sender: TObject);
begin
  _Caption := item('DS_CAPTION', _Params);
  _CaptionRel := _Caption;
  _TabMan := item('DS_TABELA', _Params);
  cSQL := 'select * from ' + _TabMan + ' where TP_SITUACAO = 1';
  Caption := _Caption;
  p_Consultar(cSQL,REG_LIMPO);
  
  inherited;
  
  TcCADASTROFUNC.CarregaCamposFiltro(CD_CAMPO.Items,_DataSet);
  TP_CONSULTA.ItemIndex := IfNullI(LerIni(_Caption, TIP_CNS), 0);
  CD_CAMPO.ItemIndex := IfNullI(LerIni(_Caption, COD_CNS), -1);
  
  if (bAutMan) then ToolButtonConsultar.Click;
  if (Panel1.Visible) then fDS_EXPRESSAO.SetFocus;
end;

//------------------------------------------------------------------------------

procedure TcCONSULTA.ToolButtonNovoClick(Sender: TObject);
var
  vParams, vResult : String;
begin
  if not dDADOS.f_VerPrivilegio(_TabMan,'IN_INCLUIR') then
    Exit;

  putitem(vParams,'IN_CONSULTA', 'FALSE');
  putitem(vParams,'IN_INCLUIR', 'TRUE');
  putitem(vParams,'DS_CAPTION', _Caption);
  putitem(vParams,'DS_TABELA', _TabMan);
  putitem(vParams,'DS_SQL', cSQL);

  vResult := TcMANUTENCAO.Execute(vParams);

  if itemB('IN_OK', vResult) then 
    ToolButtonConsultar.Click;
end;

procedure TcCONSULTA.ToolButtonAlterarClick(Sender: TObject);
var
  vParams, vFiltro : String;
begin
  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_CONSULTAVAZIA);

  if not dDADOS.f_VerPrivilegio(_TabMan,'IN_ALTERAR') then
    Exit;

  putitem(vParams,'IN_CONSULTA', 'FALSE');
  putitem(vParams,'IN_ALTERAR', 'TRUE');
  putitem(vParams,'DS_CAPTION', _Caption);
  putitem(vParams,'DS_TABELA', _TabMan);
  putitem(vParams,'DS_SQL', cSQL);
  putlistitensocc(vFiltro, _DataSet);
  TcMANUTENCAO.Execute(vParams, vFiltro);
  ToolButtonConsultar.Click;
end;

procedure TcCONSULTA.ToolButtonExcluirClick(Sender: TObject);
var
  vParams, vFiltro : String;
begin
  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_CONSULTAVAZIA);

  if not dDADOS.f_VerPrivilegio(_TabMan,'IN_EXCLUIR') then
    Exit;

  putitem(vParams,'IN_CONSULTA','TRUE');
  putitem(vParams,'IN_EXCLUIR','TRUE');
  putitem(vParams,'DS_CAPTION',_Caption);
  putitem(vParams,'DS_TABELA',_TabMan);
  putitem(vParams,'DS_SQL',cSQL);
  putlistitensocc(vFiltro,_DataSet);
  TcMANUTENCAO.Execute(vParams, vFiltro);

  if Pergunta('Excluir registro?') then begin
    _DataSet.Delete;
    _DataSet.ApplyUpdates(0);
    Mensagem('Registro excluído com sucesso!');
    ToolButtonConsultar.Click;
  end;
end;

procedure TcCONSULTA.ToolButtonConsultarClick(Sender: TObject);
var
  vSql : String;
begin
  vSql := cSQL;

  vSql := vSql + f_ObterFiltroSQL;

  p_Consultar(vSql);
  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_NENHUMREGISTRO);
end;

procedure TcCONSULTA.ToolButtonLimparClick(Sender: TObject);
begin
  p_Consultar(cSQL,REG_LIMPO);
end;

procedure TcCONSULTA.ToolButtonImprimirClick(Sender: TObject);
begin
  if not dDADOS.f_VerPrivilegio(_TabMan, 'IN_IMPRIMIR') then 
    Exit;
  
  TcRELATORIO.Executar(_DataSet, _CaptionRel, f_ObterFiltroSQL, cSQL, nil);
end;

//------------------------------------------------------------------------------

procedure TcCONSULTA.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_F2) then ClickButton('ToolButtonLimpar')
  else if (Key = VK_F4) then ClickButton('ToolButtonConsultar')
  else if (Key = VK_F5) then ClickButton('ToolButtonNovo')
  else if (Key = VK_F6) then ClickButton('ToolButtonImprimir')
  else if (Key = VK_F8) then ClickButton('ToolButtonExcluir')
  else if (Key = VK_F12) then begin
    if (_KeyMan <> '') then
      Hint := item(_KeyMan, _DataSet);
    ModalResult := mrOk;
  end;
end;

end.
