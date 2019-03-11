unit ucUSUARIO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, FMTBcd, SqlExpr, Provider, DB, DBClient, Grids, DBGrids,
  Buttons, ExtCtrls, StdCtrls, ComCtrls, ToolWin, DBCtrls, dbcgrids, Menus,
  StrUtils;

type
  TcUSUARIO = class(TcCADASTRO)
    LabelIncluir: TLabel;
    LabelAlterar: TLabel;
    LabelExcluir: TLabel;
    LabelImprimir: TLabel;
    gPerm: TDBCtrlGrid;
    DBTextEnt: TDBText;
    DBCheckBoxInc: TDBCheckBox;
    DBCheckBoxAlt: TDBCheckBox;
    DBCheckBoxExc: TDBCheckBox;
    DBCheckBoxImp: TDBCheckBox;
    dPerm: TDataSource;
    tPerm: TClientDataSet;
    sPerm: TDataSetProvider;
    qPerm: TSQLQuery;
    LabelEntidade: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure _DataSetAfterOpen(DataSet: TDataSet);
    procedure _DataSetNewRecord(DataSet: TDataSet);
    procedure _DataSetAfterScroll(DataSet: TDataSet);
    procedure tPermNewRecord(DataSet: TDataSet);
    procedure FTpPrivilegioOnClick(Sender: TObject);
    procedure ToolButtonGravarClick(Sender: TObject);
    procedure LabelIncluirClick(Sender: TObject);
    procedure DBTextEntClick(Sender: TObject);
  private
  protected
    FNmLogin : TEdit;
    FTpPrivilegio : TComboBox;
    procedure CarregaPrivilegio;
    procedure GravaPrivilegio;
  public
  end;

implementation

{$R *.dfm}

uses
  ucFUNCAO, ucDADOS, ucMENU, ucCOMP, ucITEM, ucXML;

procedure TcUSUARIO.FormCreate(Sender: TObject);
begin
  inherited;
  cTabMan := 'ADM_USUARIO';
  cKeyMan := 'CD_USUARIO';
end;

procedure TcUSUARIO.FormShow(Sender: TObject);
begin
  inherited; //
  FNmLogin := TEdit(FindComponent('NM_LOGIN'));
  FTpPrivilegio := TComboBox(FindComponent('TP_PRIVILEGIO'));
  if FTpPrivilegio <> nil then FTpPrivilegio.OnClick := FTpPrivilegioOnClick;
end;

procedure TcUSUARIO.PageControl1Change(Sender: TObject);
begin
  inherited;
  CarregaPrivilegio;
end;

procedure TcUSUARIO._DataSetAfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('CD_SENHA').Visible := False;
  inherited;
end;

procedure TcUSUARIO._DataSetNewRecord(DataSet: TDataSet);
begin
  inherited;
  putitem(DataSet, 'CD_SENHA', cripto('123MUDAR'));
end;

procedure TcUSUARIO.CarregaPrivilegio;
var
  MyStringList : TStringList;
  vSql : String;
  I : Integer;
begin
  LabelEntidade.Visible := (FTpPrivilegio.Text = 'Operador');
  LabelIncluir.Visible := LabelEntidade.Visible;
  LabelAlterar.Visible := LabelEntidade.Visible;
  LabelExcluir.Visible := LabelEntidade.Visible;
  LabelImprimir.Visible := LabelEntidade.Visible;
  gPerm.Visible := LabelEntidade.Visible;

  if (FNmLogin.Text <> '') and (LabelEntidade.Visible) then begin
    vSql :=
      'select * '+
      'from ADM_NIVEL a '+
      'where TP_SITUACAO = 1 ' +
      'and NM_LOGIN = ''' + FNmLogin.Text + ''' ';

    with tPerm do begin
      Close;
      qPerm.SQL.Text := vSql;
      Open;
      if (IsEmpty) then begin
        MyStringList := TStringList.Create;
        dDADOS._Conexao.GetTableNames(MyStringList);
        for I:=0 to MyStringList.Count-1 do begin
          if (Copy(MyStringList[I],1,4) = 'GER_') then begin
            Append;
            putitem(tPerm, 'NM_LOGIN', FNmLogin.Text);
            putitem(tPerm, 'CD_ENTIDADE', MyStringList[I]);
            putitem(tPerm, 'IN_INCLUIR', 'F');
            putitem(tPerm, 'IN_ALTERAR', 'F');
            putitem(tPerm, 'IN_EXCLUIR', 'F');
            putitem(tPerm, 'IN_IMPRIMIR', 'F');
            Post;
          end;
        end;
      end;
    end;
  end;
end;

procedure TcUSUARIO.GravaPrivilegio;
begin
  if not tPerm.IsEmpty then
    tPerm.ApplyUpdates(0);
end;

procedure TcUSUARIO._DataSetAfterScroll(DataSet: TDataSet);
begin
  inherited;
  CarregaPrivilegio;
end;

procedure TcUSUARIO.tPermNewRecord(DataSet: TDataSet);
begin
  inherited;
  putitem(DataSet, 'TP_SITUACAO', 1);
end;

procedure TcUSUARIO.FTpPrivilegioOnClick(Sender: TObject);
begin
  CarregaPrivilegio;
end;

procedure TcUSUARIO.ToolButtonGravarClick(Sender: TObject);
begin
  inherited;
  GravaPrivilegio;
end;

procedure TcUSUARIO.LabelIncluirClick(Sender: TObject);
begin
  inherited;
  with tPerm do begin
    DisableControls;
    First;
    while not EOF do begin
      with TLabel(Sender) do begin
        if Tag in [1, 2] then
          putitem(tPerm, 'IN_INCLUIR', IfThen(item('IN_INCLUIR', tPerm) = 'F', 'T', 'F'));
        if Tag in [1, 3] then
          putitem(tPerm, 'IN_ALTERAR', IfThen(item('IN_ALTERAR', tPerm) = 'F', 'T', 'F'));
        if Tag in [1, 4] then
          putitem(tPerm, 'IN_EXCLUIR', IfThen(item('IN_EXCLUIR', tPerm) = 'F', 'T', 'F'));
        if Tag in [1, 5] then
          putitem(tPerm, 'IN_IMPRIMIR', IfThen(item('IN_IMPRIMIR', tPerm) = 'F', 'T', 'F'));
      end;
      Next;
    end;
    First;
    EnableControls;
  end;
end;

procedure TcUSUARIO.DBTextEntClick(Sender: TObject);
begin
  inherited;
  with tPerm do begin
    Edit;
    putitem(tPerm, 'IN_INCLUIR', IfThen(item('IN_INCLUIR', tPerm) = 'F', 'T', 'F'));
    putitem(tPerm, 'IN_ALTERAR', IfThen(item('IN_ALTERAR', tPerm) = 'F', 'T', 'F'));
    putitem(tPerm, 'IN_EXCLUIR', IfThen(item('IN_EXCLUIR', tPerm) = 'F', 'T', 'F'));
    putitem(tPerm, 'IN_IMPRIMIR', IfThen(item('IN_IMPRIMIR', tPerm) = 'F', 'T', 'F'));
    Post;
  end;
end;

end.
