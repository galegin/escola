unit uMOVESTOQ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, Provider, DB, DBClient, ExtCtrls, Grids,
  DBGrids, Buttons, StdCtrls, ComCtrls, ToolWin, FMTBcd,
  SqlExpr, Menus;

type
  TfMOVESTOQ = class(TcCADASTRO)
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  fMOVESTOQ: TfMOVESTOQ;

implementation

{$R *.dfm}

procedure TfMOVESTOQ.FormCreate(Sender: TObject);
begin
  inherited;
  cTabMan := 'GER_MOV';
  cKeyMan := 'CD_DNAMOV';
end;

initialization
  RegisterClass(TfMOVESTOQ);

end.