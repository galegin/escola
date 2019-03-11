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
  cTabMan := 'GER_TURMA';
  cKeyMan := 'CD_TURMA';
  cIncMan := 'CD_TURMA';
end;

initialization
  RegisterClass(TfTURMA);

end.
