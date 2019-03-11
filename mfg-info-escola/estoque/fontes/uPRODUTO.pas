unit uPRODUTO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, Provider, DB, DBClient, ExtCtrls, Grids,
  DBGrids, Buttons, StdCtrls, ComCtrls, ToolWin, FMTBcd,
  SqlExpr, Menus;

type
  TfPRODUTO = class(TcCADASTRO)
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  fPRODUTO: TfPRODUTO;

implementation

{$R *.dfm}

procedure TfPRODUTO.FormCreate(Sender: TObject);
begin
  inherited;
  cTabMan := 'GER_PRODUTO';
  cKeyMan := 'CD_BARRAPRD';
end;

initialization
  RegisterClass(TfPRODUTO);

end.