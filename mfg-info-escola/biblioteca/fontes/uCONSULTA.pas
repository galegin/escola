unit uCONSULTA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, Provider, DB, DBClient, ExtCtrls, Grids,
  DBGrids, Buttons, StdCtrls, ComCtrls, ToolWin, FMTBcd,
  SqlExpr, Mask, DBCtrls, Menus, ucFORM;

type
  TfCONSULTA = class(TcCADASTRO)
    DBGrid2: TDBGrid;
    SQLQuery2: TSQLQuery;
    DataSetProvider2: TDataSetProvider;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    Panel6: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure _DataSetAfterScroll(DataSet: TDataSet);
    procedure ClientDataSet2AfterOpen(DataSet: TDataSet);
  private
  public
  end;

implementation

{$R *.dfm}

uses
  ucFUNCAO, ucITEM, ucCADASTROFUNC;

procedure TfCONSULTA.FormCreate(Sender: TObject);
begin
  inherited;

  cModoFormulario := mfConsultaSomente;
  cTabMan := 'GER_LIVRO';
  cKeyMan := 'CD_LIVRO';

  cSQL :=
    'select * from ( ' +
      'select a.CD_LIVRO ' +
      ',      a.TP_SITUACAO ' +
      ',      a.DS_TITULO ' +
      ',      a.DS_AUTOR ' +
      ',      a.NR_VOLUME ' +
      ',      a.NR_VOLUMEDE ' +
      ',      a.NR_CORREDOR ' +
      ',      a.NR_PRATELEIRA ' +
      ',      a.NR_ANDAR ' +
      ',      a.QT_EXEMPLAR ' +
      ',      a.CD_CURSO ' +
      ',      b.DS_CURSO ' +
      ',      a.CD_EDITORA ' +
      ',      c.DS_EDITORA ' +
      ',      a.CD_GENERO ' +
      ',      d.DS_GENERO ' +
      'from GER_LIVRO a ' +
      'inner join GER_CURSO b on (b.CD_CURSO = a.CD_CURSO) ' +
      'inner join GER_EDITORA c on (c.CD_EDITORA = a.CD_EDITORA) ' +
      'inner join GER_GENERO d on (d.CD_GENERO = a.CD_GENERO) ' +
      //'where a.TP_SITUACAO = 1 ' +
    ') where TP_SITUACAO = 1 ' ;
end;

procedure TfCONSULTA._DataSetAfterScroll(DataSet: TDataSet);
var
  vSql : String;
begin
  inherited;

  vSql :=
    'select a.CD_LOCACAO ' +
    ',      a.CD_LIVRO ' +
    ',      b.DS_TITULO ' +
    ',      a.CD_LOCADOR ' +
    ',      c.NM_LOCADOR ' +
    ',      a.DT_LOCACAO ' +
    ',      a.TP_LOCACAO ' +
    ',      a.DT_DEVOLUCAO ' +
    ',      a.DT_DEVOLVIDO ' +
    'from GER_LOCACAO a ' +
    'inner join GER_LIVRO b on (b.CD_LIVRO = a.CD_LIVRO) ' +
    'inner join GER_LOCADOR c on (c.CD_LOCADOR = a.CD_LOCADOR) ' +
    'where a.TP_SITUACAO = 1  ' +
    'and a.TP_LOCACAO = 1 ' +
    'and b.CD_LIVRO = ''' + item('CD_LIVRO', _DataSet) + ''' ' ;

  ClientDataSet2.Close;
  SQLQuery2.SQL.Text := vSql;
  ClientDataSet2.Open;
end;

procedure TfCONSULTA.ClientDataSet2AfterOpen(DataSet: TDataSet);
begin
  TcCADASTROFUNC.CorrigeDisplayLabel(ClientDataSet2);
end;

initialization
  RegisterClass(TfCONSULTA);

end.
