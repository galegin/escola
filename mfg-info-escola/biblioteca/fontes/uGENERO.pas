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
  cTabMan := 'GER_GENERO';
  cKeyMan := 'CD_GENERO';
  cIncMan := 'CD_GENERO';
end;

initialization
  RegisterClass(TfGENERO);

end.
