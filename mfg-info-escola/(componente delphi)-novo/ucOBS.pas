unit ucOBS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin,  FMTBcd, DB, SqlExpr,
  StdCtrls, DBClient, Menus;

type
  TcOBS = class(TForm)
    Panel1: TPanel;
    Shape6: TShape;
    MemoOBS: TMemo;
    SQLQueryOBS: TSQLQuery;
    CoolBar2: TCoolBar;
    ToolBar2: TToolBar;
    ToolButtonConfirma: TToolButton;
    ToolButtonCancela: TToolButton;
    ToolButtonFechar: TToolButton;
    Label1: TLabel;
    MemoDDL: TMemo;
    MemoMOD: TMemo;
    ToolButtonAbrir: TToolButton;
    ToolButtonSalvar: TToolButton;
    PopupMenu1: TPopupMenu;
    Inserir1: TMenuItem;
    Complemento1: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure Carregar;
    procedure Gravar;

    procedure ToolButtonConfirmaClick(Sender: TObject);
    procedure ToolButtonCancelaClick(Sender: TObject);
    procedure ToolButtonFecharClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure ArquivoPadrao;

    procedure ToolButtonAbrirClick(Sender: TObject);
    procedure ToolButtonSalvarClick(Sender: TObject);
    procedure Complemento1Click(Sender: TObject);
  private
    sTabela, sChave:String;
  public
    class procedure Editar(C: TClientDataSet; Tabela : String); overload;
    class procedure Editar(Tabela, Chave : String); overload;
    class procedure GravarTxt(Tabela, Chave, Arquivo : String);
  end;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucMETADATA, ucFUNCAO, ucDADOS, ucITEM, ucXML;

const
  cMOD_RECIBO =
    'COMPROVANTE|CUPOM|PRESTACAO';

procedure TcOBS.FormCreate(Sender: TObject);
begin
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);
end;

procedure TcOBS.FormShow(Sender: TObject);
begin
  Carregar;
end;

procedure TcOBS.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE, VK_F12: ToolButtonFechar.Click;
    VK_F6: ArquivoPadrao;
  end;
end;

procedure TcOBS.Carregar;
begin
  with MemoOBS.Lines do begin
    Clear;
    with SQLQueryOBS do begin
      Close;
      ParamByName('CD_ENTIDADE').asString := sTabela;
      ParamByName('CD_CHAVE').asString := sChave;
      Open;
      while not EOF do begin
        Add(FieldByName('DS_LINHA').asString);
        Next;
      end;
    end;
  end;
end;

procedure TcOBS.Gravar;
var
  iX: Integer;
begin
  dDADOS.f_RunSQL('delete from OBS_ENTIDADE where CD_ENTIDADE='''+sTabela+''' and CD_CHAVE='''+sChave+''' ');

  with MemoOBS, MemoOBS.Lines do
    for iX:=0 to Count-1 do
      dDADOS.f_RunSQL('insert into OBS_ENTIDADE (CD_ENTIDADE,CD_CHAVE,NR_LINHA,DS_LINHA) '+
                      'values (''' + sTabela + ''',''' + sChave + ''',' + IntToStr(iX) + ',''' + Lines[iX] + ''') ');
end;

procedure TcOBS.ToolButtonConfirmaClick(Sender: TObject);
begin
  Gravar;
  ModalResult := mrOk;
end;

procedure TcOBS.ToolButtonCancelaClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TcOBS.ToolButtonFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TcOBS.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Pos(sTabela, cMOD_RECIBO) > 0 then
    Exit;

  Key := TiraAcentosChar(UpCase(Key));
end;

procedure TcOBS.ArquivoPadrao;
begin
  if Pos(sTabela, cMOD_RECIBO) = 0 then
    Exit;

  MemoOBS.Text := itemX(sTabela, MemoMOD.Text);
end;

procedure TcOBS.ToolButtonAbrirClick(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do begin
    InitialDir := ExtractFilePath(Application.ExeName);
    Filter := 'Arquivo Texto (*.txt)|*.txt';
    DefaultExt := '*.txt';
    if Execute then
      MemoOBS.Lines.LoadFromFile(FileName);
  end;
end;

procedure TcOBS.ToolButtonSalvarClick(Sender: TObject);
begin
  with TSaveDialog.Create(nil) do begin
    InitialDir := ExtractFilePath(Application.ExeName);
    Filter := 'Arquivo Texto (*.txt)|*.txt';
    DefaultExt := '*.txt';
    if Execute then
      MemoOBS.Lines.SaveToFile(FileName);
  end;
end;

procedure TcOBS.Complemento1Click(Sender: TObject);
begin
  MemoOBS.Lines.Insert(0, 'Compl....:<COMPLEMENTO,40>');
end;

class procedure TcOBS.Editar(C : TClientDataSet; Tabela : String);
begin
  if (C.IsEmpty) then
    Exit;

  with TcOBS.Create(Application) do
  try
    sTabela := Tabela;
    sChave := TcMETADATA.getChaveKey(C);
    ShowModal;
  finally
    Free;
  end;
end;

class procedure TcOBS.Editar(Tabela, Chave : String);
begin
  with TcOBS.Create(Application) do
  try
    sChave := Chave;
    sTabela := Tabela;
    if Pos(sTabela, cMOD_RECIBO) > 0 then
      Caption := 'Config. ' + sTabela;
    ShowModal;
  finally
    Free;
  end;
end;

class procedure TcOBS.GravarTxt(Tabela, Chave, Arquivo : String);
var
  MyString : TStringList;
begin
  MyString := TStringList.Create;

  with dDADOS.getQuery() do
  try
    Close;
    SQL.Clear;
    SQL.Add('select DS_LINHA from OBS');
    SQL.Add('where CD_TABELA = :CD_TABELA');
    SQL.Add('and CD_CHAVE = :CD_CHAVE');
    ParamByName('CD_TABELA').asString := Tabela;
    ParamByName('CD_CHAVE').asString := Chave;
    Open;
    while not EOF do begin
      MyString.Add(FieldByName('DS_LINHA').asString);
      Next;
    end;
  finally
    Free;
  end;

  MyString.SaveToFile(Arquivo);
end;

end.
