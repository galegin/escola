unit ucLISTAEMAIL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, Provider, SqlExpr, DBClient, Grids, DBGrids,
  ExtCtrls, Buttons, ComCtrls, ToolWin, StdCtrls;

type
  TcLISTAEMAIL = class(TForm)
    Panel1: TPanel;
    RxLabel3: TLabel;
    Image1: TImage;
    SpeedButtonFechar: TSpeedButton;
    Shape1: TShape;
    DBGrid1: TDBGrid;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    ClientDataSet1EMAIL: TStringField;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButtonOk: TToolButton;
    ToolButtonCancel: TToolButton;
    ClientDataSet1NOME: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButtonPesquisarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    v_Arq : String;
  public
    class function Executar : String;
  end;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucFUNCAO;

class function TcLISTAEMAIL.Executar : String;
begin
  Result:='';

  with TcLISTAEMAIL.Create(Application) do
  try
    if ShowModal = mrOk then
      Result := LowerCase(ClientDataSet1EMAIL.asString);
    ClientDataSet1.Close;
  finally
    Free;
  end;
end;

procedure TcLISTAEMAIL.FormCreate(Sender: TObject);
begin
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);

  v_Arq := ExtractFilePath(Application.ExeName) + 'contatos.ctl';

  if FileExists(v_Arq) then
    ClientDataSet1.LoadFromFile(v_Arq);

  DBGrid1.onDrawColumnCell := TcCADASTROFUNC.onDrawColumnCell;
end;

procedure TcLISTAEMAIL.FormShow(Sender: TObject);
begin
  ClientDataSet1.Open;
  TcCADASTROFUNC.CorrigeDisplayLabel(ClientDataSet1);
end;

procedure TcLISTAEMAIL.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Close;
end;

procedure TcLISTAEMAIL.SpeedButtonPesquisarClick(Sender: TObject);
begin
  ClientDataSet1.SaveToFile(v_Arq);
  ModalResult:=mrOk;
end;

procedure TcLISTAEMAIL.SpeedButton1Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TcLISTAEMAIL.DBGrid1TitleClick(Column: TColumn);
begin
  ClientDataSet1.IndexFieldNames := Column.FieldName;
end;

end.
