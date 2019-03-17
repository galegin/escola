unit uLIVRO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, DBTables, DB, DBClient, ImgList, ExtCtrls, Grids, DBGrids,
  Buttons, StdCtrls, ComCtrls, ToolWin, Provider, FMTBcd, SqlExpr, Mask, DBCtrls,
  Menus, StrUtils, ucFORM;

type
  TfLIVRO = class(TcCADASTRO)
    Label5: TLabel;
    fCD_LIVRO: TEdit;
    fDS_TITULO: TEdit;
    Label7: TLabel;
    fDS_AUTOR: TEdit;
    fCD_CURSO: TEdit;
    dfCD_CURSO: TEdit;
    Label8: TLabel;
    dfCD_GENERO: TEdit;
    fCD_GENERO: TEdit;
    Label9: TLabel;
    dfCD_EDITORA: TEdit;
    fCD_EDITORA: TEdit;
    Label10: TLabel;
    ButtonClassificar: TButton;
    dfTP_ENSINO: TEdit;
    fTP_ENSINO: TEdit;
    Label6: TLabel;
    PanelTotal: TPanel;
    EditTotal: TEdit;
    Label4: TLabel;
    LabelExemplar: TLabel;
    EditExemplar: TEdit;
    ToolButtonEtiqueta: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure ToolButtonConsultarClick(Sender: TObject);
    procedure ButtonClassificarClick(Sender: TObject);
    procedure ToolButtonEtiquetaClick(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

uses
  ucSELECT, ucFUNCAO, ucCONST, ucDADOS, ucITEM, ucXML,
  uRELETIQUETA;

procedure TfLIVRO.FormCreate(Sender: TObject);
begin
  _TabMan := 'GER_LIVRO';
  _KeyMan := 'CD_LIVRO';
  _IncMan := 'CD_LIVRO';

  fCD_CURSO.Tag := TAG_FK;
  fCD_GENERO.Tag := TAG_FK;
  fCD_EDITORA.Tag := TAG_FK;
  fTP_ENSINO.Tag := TAG_FK;

  inherited;
end;

procedure TfLIVRO.ToolButtonConsultarClick(Sender: TObject);
var
  vSqlTot, vSql, vRes : String;
begin
  vSql := cSQL;

  EditTotal.Text := '0';
  EditExemplar.Text := '0';

  with fCD_LIVRO do
    if Text <> '' then
      AddSqlWhere(vSql, 'CD_LIVRO=''' + Text + ''' ');
  with fDS_TITULO do
    if Text <> '' then
      AddSqlWhere(vSql, 'DS_TITULO like ''%' + ReplaceStr(Text,' ','%') + '%'' ');
  with fDS_AUTOR do
    if Text <> '' then
      AddSqlWhere(vSql, 'DS_AUTOR like ''%' + ReplaceStr(Text,' ','%') + '%'' ');
  with fCD_CURSO do
    if Text <> '' then
      AddSqlWhere(vSql, 'CD_CURSO=''' + Text + ''' ');
  with fCD_EDITORA do
    if Text <> '' then
      AddSqlWhere(vSql, 'CD_EDITORA=''' + Text + ''' ');
  with fCD_GENERO do
    if Text <> '' then
      AddSqlWhere(vSql, 'CD_GENERO=''' + Text + ''' ');
  with fTP_ENSINO do
    if Text <> '' then
      AddSqlWhere(vSql, 'TP_ENSINO=''' + Text + ''' ');

  vSql := vSql + f_ObterFiltroSQL;

  p_Consultar(vSql);
  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_NENHUMREGISTRO);

  vSqlTot := 'select count(*) as QT_TOTAL, sum(coalesce(QT_EXEMPLAR,0)) as QT_EXEMPLAR from ({SQL})';
  vSqlTot := AnsiReplaceStr(vSqlTot, '{SQL}', vSql);
  vRes := dDADOS.f_ConsultaStrSql(vSqlTot, 'X');
  EditTotal.Text := FormatFloat('0', itemXF('QT_TOTAL', vRes));
  EditExemplar.Text := FormatFloat('0', itemXF('QT_EXEMPLAR', vRes));
end;

procedure TfLIVRO.ButtonClassificarClick(Sender: TObject);
var
  vSql : String;
begin
  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_CONSULTAVAZIA);

  if fTP_ENSINO.Text = '' then
    raise Exception.Create('Tipo de ensino deve ser informado!');

  if not Pergunta('Deseja classificar tipo de ensino?') then
    Exit;

  _DataSet.First;
  while not _DataSet.EOF do begin
    vSql :=
      'update GER_LIVRO ' +
      'set TP_ENSINO=''' + fTP_ENSINO.Text + ''' ' +
      'where CD_LIVRO=''' + item('CD_LIVRO', _DataSet) + ''' ';
    dDADOS.f_RunSQL(vSql);
    _DataSet.Next;
  end;

  Mensagem('Tipo de ensino classificado com sucesso!');
end;

procedure TfLIVRO.ToolButtonEtiquetaClick(Sender: TObject);
var
  vParams, vSql : String;
begin
  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_CONSULTAVAZIA);

  vSql :=
    'select liv.CD_LIVRO || '' - '' || liv.DS_TITULO as DS_TITULO ' +
    ',      edi.DS_EDITORA ' +
    ',      liv.DS_AUTOR ' +
    ',      liv.NR_ANO ' +
    'from ({SQL}) liv ' +
    'left outer join GER_EDITORA edi on (edi.CD_EDITORA = liv.CD_EDITORA) ' ;
  vSql := AnsiReplaceStr(vSql, '{SQL}', AnsiReplaceStr(_Query.SQL.Text, sLineBreak, ' '));

  if (PageControl1.ActivePage = TabSheet2) or not Pergunta('Imprimir todos ?') then
    vSql := vSql + 'where liv.CD_LIVRO = ''' + item('CD_LIVRO', _DataSet) + ''' ' ;

  vParams := '';
  putitemX(vParams, 'DS_SQL', vSql);
  TrRELETIQUETA.execute(vParams);
end;

initialization
  RegisterClass(TfLIVRO);

end.
