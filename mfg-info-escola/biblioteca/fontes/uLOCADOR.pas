unit uLOCADOR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, FMTBcd, SqlExpr, Provider, DB, DBClient, ExtCtrls, Grids,
  DBGrids, Buttons, StdCtrls, ComCtrls, ToolWin, DBCtrls, Menus, ucFORM;

type
  TfLOCADOR = class(TcCADASTRO)
    Label5: TLabel;
    fCD_LOCADOR: TEdit;
    fNM_LOCADOR: TEdit;
    Label8: TLabel;
    fCD_CURSO: TEdit;
    dfCD_CURSO: TEdit;
    ToolButtonCarteira: TToolButton;
    ToolButtonFoto: TToolButton;
    Label4: TLabel;
    ButtonClassificar: TButton;
    fTP_ENSINO: TEdit;
    dfTP_ENSINO: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ToolButtonConsultarClick(Sender: TObject);
    procedure _DataSetNewRecord(DataSet: TDataSet);
    procedure ToolButtonCarteiraClick(Sender: TObject);
    procedure ToolButtonFotoClick(Sender: TObject);
    procedure ButtonClassificarClick(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

uses
  ucSELECT, ucCONST, ucDADOS, ucFUNCAO, ucITEM, ucXML, uRELCARTEIRA,
  StrUtils;

procedure TfLOCADOR.FormCreate(Sender: TObject);
begin
  inherited;

  _TabMan := 'GER_LOCADOR';
  _KeyMan := 'CD_LOCADOR';
  _IncMan := 'CD_LOCADOR';
  _ValMan := 'NM_LOCADOR';

  fCD_CURSO.Tag := TAG_FK;
  fTP_ENSINO.Tag := TAG_FK;
end;

procedure TfLOCADOR.ToolButtonConsultarClick(Sender: TObject);
var
  vSql : String;
begin
  vSql := cSQL;

  with fCD_LOCADOR do
    if (Text <> '') then
      AddSqlWhere(vSql, 'CD_LOCADOR=''' + Text + ''' ');
  with fNM_LOCADOR do
    if (Text <> '') then
      AddSqlWhere(vSql, 'NM_LOCADOR like ''%' + ReplaceStr(Text,' ','%') + '%'' ');
  with fCD_CURSO do
    if (Text <> '') then
      AddSqlWhere(vSql, 'CD_CURSO=''' + Text + ''' ');
  with fTP_ENSINO do
    if (Text <> '') then
      AddSqlWhere(vSql, 'TP_ENSINO=''' + Text + ''' ');

  vSql := vSql + f_ObterFiltroSQL;

  p_Consultar(vSql);
  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_NENHUMREGISTRO);
end;

procedure TfLOCADOR._DataSetNewRecord(DataSet: TDataSet);
var
  vDsCidade : String;
begin
  inherited;
  putitem(_DataSet, 'DS_UF', 'PR');
  vDsCidade := dDADOS.f_LerParametro('NM_CIDADE');
  if (vDsCidade <> 'NOK') then
    putitem(_DataSet, 'DS_CIDADE', vDsCidade);
end;

procedure TfLOCADOR.ToolButtonCarteiraClick(Sender: TObject);
var
  vParams, vSql : String;
begin
  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_CONSULTAVAZIA);

  vSql :=
    'select loc.CD_LOCADOR || '' - '' || loc.NM_LOCADOR as NM_LOCADOR ' +
    ',      coalesce(tur.DS_TURMA, loc.CD_TURMA, loc.NR_ANO) as DS_TURMA ' +
    'from ({SQL}) loc ' +
    'left outer join GER_TURMA tur on (trim(tur.CD_TURMA) = trim(loc.CD_TURMA)) ' ;
  vSql := AnsiReplaceStr(vSql, '{SQL}', AnsiReplaceStr(_Query.SQL.Text, sLineBreak, ' '));

  if (PageControl1.ActivePage = TabSheet2) or not Pergunta('Imprimir todos ?') then
    vSql := vSql + 'where loc.CD_LOCADOR = ''' + item('CD_LOCADOR', _DataSet) + ''' ' ;

  vParams := '';
  putitemX(vParams, 'DS_SQL', vSql);
  TrRELCARTEIRA.execute(vParams);
end;

procedure TfLOCADOR.ToolButtonFotoClick(Sender: TObject);
begin
  inherited;
  Mensagem('Em desenvolvimento!');
end;

procedure TfLOCADOR.ButtonClassificarClick(Sender: TObject);
var
  vSql : String;
begin
  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_CONSULTAVAZIA);

  if fTP_ENSINO.Text = '' then
    raise Exception.Create('Tipo de ensino deve ser informado!');

  if not Pergunta('Deseja classificar tipo de ensino?') then
    Exit;

  with _DataSet do begin
    First;
    while not EOF do begin
      vSql :=
        'update GER_LOCADOR ' +
        'set TP_ENSINO=''' + fTP_ENSINO.Text + ''' ' +
        'where CD_LOCADOR=''' + FieldByName('CD_LOCADOR').asString + ''' ';
      dDADOS.f_RunSQL(vSql);
      Next;
    end;
  end;

  Mensagem('Tipo de ensino classificado com sucesso!');
end;

initialization
  RegisterClass(TfLOCADOR);

end.
