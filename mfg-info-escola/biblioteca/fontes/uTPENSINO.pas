unit uTPENSINO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, FMTBcd, Menus, DB, DBClient, Provider, SqlExpr, StdCtrls,
  Grids, ExtCtrls, DBGrids, Buttons, ComCtrls, ToolWin;

type
  TfTPENSINO = class(TcCADASTRO)
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

procedure TfTPENSINO.FormCreate(Sender: TObject);
begin
  inherited;
  _TabMan := 'GER_TPENSINO';
  _KeyMan := 'TP_ENSINO';
  _IncMan := 'TP_ENSINO';
end;

initialization
  RegisterClass(TfTPENSINO);

end.
