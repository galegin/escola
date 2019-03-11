unit uHIST;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, Provider, DB, DBClient, ExtCtrls, Grids,
  DBGrids, Buttons, StdCtrls, ComCtrls, ToolWin, FMTBcd,
  SqlExpr, Menus;

type
  TfHIST = class(TcCADASTRO)
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  fHIST: TfHIST;

implementation

{$R *.dfm}

procedure TfHIST.FormCreate(Sender: TObject);
begin
  inherited;
  cTabMan := 'GER_HIST';
  cKeyMan := 'CD_HIST';
end;

initialization
  RegisterClass(TfHIST)

end.