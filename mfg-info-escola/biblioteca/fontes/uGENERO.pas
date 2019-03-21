unit uGENERO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, Provider, DB, DBClient, ExtCtrls, Grids,
  DBGrids, Buttons, StdCtrls, ComCtrls, ToolWin, FMTBcd,
  SqlExpr, Menus;

type
  TfGENERO = class(TcCADASTRO)
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

procedure TfGENERO.FormCreate(Sender: TObject);
begin
  inherited;
  _TabMan := 'GER_GENERO';
  _KeyMan := 'CD_GENERO';
  _IncMan := 'CD_GENERO';
  _ValMan := 'DS_GENERO';
end;

initialization
  RegisterClass(TfGENERO);

end.
