unit uEDITORA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, Provider, DB, DBClient, ExtCtrls, Grids,
  DBGrids, Buttons, StdCtrls, ComCtrls, ToolWin, FMTBcd,
  SqlExpr, Menus;

type
  TfEDITORA = class(TcCADASTRO)
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

procedure TfEDITORA.FormCreate(Sender: TObject);
begin
  inherited;
  cTabMan := 'GER_EDITORA';
  cKeyMan := 'CD_EDITORA';
  cIncMan := 'CD_EDITORA';
end;

initialization
  RegisterClass(TfEDITORA);

end.
