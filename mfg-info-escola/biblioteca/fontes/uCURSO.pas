unit uCURSO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, Provider, DB, DBClient, ExtCtrls, Grids,
  DBGrids, Buttons, StdCtrls, ComCtrls, ToolWin, FMTBcd,
  SqlExpr, Menus;

type
  TfCURSO = class(TcCADASTRO)
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

procedure TfCURSO.FormCreate(Sender: TObject);
begin
  inherited;
  _TabMan := 'GER_CURSO';
  _KeyMan := 'CD_CURSO';
  _IncMan := 'CD_CURSO';
end;

initialization
  RegisterClass(TfCURSO);

end.
