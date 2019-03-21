unit uTURMA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, Provider, DB, DBClient, ExtCtrls, Grids,
  DBGrids, Buttons, StdCtrls, ComCtrls, ToolWin, FMTBcd,
  SqlExpr, Menus;

type
  TfTURMA = class(TcCADASTRO)
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

procedure TfTURMA.FormCreate(Sender: TObject);
begin
  inherited;
  _TabMan := 'GER_TURMA';
  _KeyMan := 'CD_TURMA';
  _IncMan := 'CD_TURMA';
  _ValMan := 'DS_TURMA';
end;

initialization
  RegisterClass(TfTURMA);

end.
