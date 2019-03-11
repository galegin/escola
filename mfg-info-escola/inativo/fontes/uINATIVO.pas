unit uINATIVO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, DBTables, DB, DBClient, ImgList, ExtCtrls,
  Grids, DBGrids, Buttons, StdCtrls, ComCtrls, ToolWin,
  Provider, FMTBcd, SqlExpr, Mask, DBCtrls, Menus, ucFORM;

type
  TfINATIVO = class(TcCADASTRO)
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    fNM_INATIVO: TEdit;
    fNR_INATIVO: TEdit;
    fNM_PAI: TEdit;
    fNM_MAE: TEdit;
    ToolButtonCartao: TToolButton;
    fCD_CURSO: TEdit;
    dfCD_CURSO: TEdit;
    Label9: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    DBEdit5: TDBEdit;
    Label13: TLabel;
    ImpressoCartaotexto1: TMenuItem;
    TabControl1: TTabControl;
    procedure FormCreate(Sender: TObject);
    procedure ToolButtonConsultarClick(Sender: TObject);
    procedure ToolButtonGravarClick(Sender: TObject);
    procedure ToolButtonCartaoClick(Sender: TObject);
    procedure ImpressoCartaoTexto1Click(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
  private
  public
    bImpCartaoTexto : Boolean;
  end;

var
  fINATIVO: TfINATIVO;

implementation

{$R *.dfm}

uses
  ucDADOS, ucFUNCAO, ucITEM, ucCONST, ucXML, ucSELECT,
  ucPREVIEW_TXT, ucRELATORIO, ucCONFPAGINA;

procedure TfINATIVO.FormCreate(Sender: TObject);
var
   I : Integer;
begin
  inherited;

  cTabMan := 'GER_INATIVO';
  cKeyMan := 'NR_INATIVO';

  bImpCartaoTexto := IfNullB(LerIni(cCaption, IMP_CAR), True);
  ImpressoCartaoTexto1.Checked := bImpCartaoTexto;

  fCD_CURSO.Tag := TAG_FK;

  bDplMan := False;

  putitemX(cFK, 'CD_CURSO', 'DS_TABELA=GER_CURSO;DS_CAMPO=NM_CURSO');

  TabControl1.Tabs.Clear;
  TabControl1.Tabs.Add('Todos');
  for I:=0 to 25 do begin
    TabControl1.Tabs.Add(Chr(I + 65));
  end;
end;

procedure TfINATIVO.ToolButtonConsultarClick(Sender: TObject);
var
  vSql, vLetra : String;
begin
  vSql := cSQL;

  with fNM_INATIVO do
    if (Text <> '') then
      AddSqlWhere(vSql, 'NM_INATIVO like ''%' + ReplaceStr(Text,' ','%') + '%'' ');
  with fNR_INATIVO do
    if (Text <> '') then
      AddSqlWhere(vSql, 'NR_INATIVO=''' + Text + ''' ');
  with fNM_PAI do
    if (Text <> '') then
      AddSqlWhere(vSql, 'NM_PAI like ''%' + ReplaceStr(Text,' ','%') + '%'' ');
  with fNM_MAE do
    if (Text <> '') then
      AddSqlWhere(vSql, 'NM_MAE like ''%' + ReplaceStr(Text,' ','%') + '%'' ');
  with fCD_CURSO do
    if (Text <> '') then
      AddSqlWhere(vSql, 'CD_CURSO = ''' + Text + ''' ');

  vLetra := TabControl1.Tabs[TabControl1.TabIndex];
  if (vLetra <> 'Todos') then
    AddSqlWhere(vSql, 'NM_INATIVO like ''' + vLetra + '%'' ');

  vSql := vSql + f_ObterFiltroSQL;

  p_Consultar(vSql);
end;

procedure TfINATIVO.ToolButtonGravarClick(Sender: TObject);
var
  vNrInativo : Integer;
begin
  p_DesCarregarCampos;

  if (item('NM_INATIVO', _DataSet) = '') then 
    raise Exception.Create('Nome do INATIVO é obrigatório!');

  if (item('NR_INATIVO', _DataSet) = '') then begin
    vNrInativo := IfNullI(dDADOS.f_ConsultaSQLRetorna('select max(NR_INATIVO) as ULTIMO from GER_INATIVO where NM_INATIVO like '''+Copy(item('NM_INATIVO',_DataSet),1,1)+'%'' ','ULTIMO'),0) + 1;
    putitem(_DataSet, 'NR_INATIVO', vNrInativo);
    p_CarregarCampos('NR_INATIVO');
  end;

  inherited;
end;

procedure TfINATIVO.ToolButtonCartaoClick(Sender: TObject);
var
  vStringList : TStringList;
begin
  inherited;

  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_CONSULTAVAZIA);

  {

  NOME: ________________________________________________
  NUMERO: _______________ LIVRO: _______ PAGINA: _______
  PRATELEIRA: _______________ CORREDOR: ________________
  FILIACAO: MAE ________________________________________
            PAI ________________________________________
  DATA DE NASC.: ______ de ___________________ de ______
  CURSO: _______________________________________________
  INICIO: ______________________________________________
  TERMINO: _____________________________________________
  OBSERVACOES: _________________________________________
  ______________________________________________________
  ______________________________________________________
  ______________________________________________________

  }

  vStringList := TStringList.Create;
  with vStringList do begin
    Add('NOME: ' + InverteNomeCarta(item('NM_INATIVO', _DataSet)));
    Add('NUMERO: ' + item('NR_INATIVO', _DataSet) + '          ' +
                     'LIVRO: ' + item('NR_LIVRO', _DataSet) + '          ' +
                     'PAGINA: ' + item('NR_PAGINA', _DataSet) );
    Add('PRATELEIRA: ' + item('NR_PRATELEIRA', _DataSet) + '          ' +
                     'CORREDOR: ' + item('NR_CORREDOR', _DataSet) );
    Add('FILIACAO: MAE ' + item('NM_MAE', _DataSet) );
    Add('          PAI ' + item('NM_PAI', _DataSet) );
    Add('CURSO: ' + item('CD_CURSO', _DataSet) + ' - ' + dDADOS.f_ConsultaSQLRetorna('select NM_CURSO from GER_CURSO where CD_CURSO = ''' +item('CD_CURSO', _DataSet)+ ''' ','NM_CURSO'));
    Add('INICIO: ' + item('DS_INICIO', _DataSet));
    Add('TERMINO: ' + item('DS_TERMINO', _DataSet));
    Add('OBSERVACOES: ' + Copy(item('DS_OBS', _DataSet),01,40));
    Add('             ' + Copy(item('DS_OBS', _DataSet),41,40));
    Add('             ' + Copy(item('DS_OBS', _DataSet),81,40));
  end;
  
  if (bImpCartaoTexto) then begin
    TcPREVIEW_TXT.VisualizarTxt(vStringList);
  end else begin
    TcRELATORIO.Monta_Relatorio(nil, 'CARTAO', '', cSQL, vStringList);
  end;

  vStringList.Free;
end;

procedure TfINATIVO.ImpressoCartaoTexto1Click(Sender: TObject);
begin
  inherited;
  bImpCartaoTexto := not bImpCartaoTexto;
  fGravaIni(cCaption, IMP_CAR, bImpCartaoTexto);
  ImpressoCartaotexto1.Checked := bImpCartaoTexto;
end;

procedure TfINATIVO.TabControl1Change(Sender: TObject);
begin
  inherited;
  ToolButtonConsultarClick(nil);
end;

initialization
  RegisterClass(TfINATIVO);

end.
