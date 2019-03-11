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
  cTabMan := 'GER_CURSO';
  cKeyMan := 'CD_CURSO';
  cIncMan := 'CD_CURSO';
end;

initialization
  RegisterClass(TfCURSO);

end.
