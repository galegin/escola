unit uCONTA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, Provider, DB, DBClient, ExtCtrls, Grids,
  DBGrids, Buttons, StdCtrls, ComCtrls, ToolWin, FMTBcd,
  SqlExpr, Menus;

type
  TfCONTA = class(TcCADASTRO)
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  fCONTA: TfCONTA;

implementation

{$R *.dfm}

procedure TfCONTA.FormCreate(Sender: TObject);
begin
  inherited;
  cTabMan := 'GER_CONTA';
  cKeyMan := 'CD_CONTA';
end;

initialization
  RegisterClass(TfCONTA)

end.