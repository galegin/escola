unit uMOVCONTA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, Provider, DB, DBClient, ExtCtrls, Grids,
  DBGrids, Buttons, StdCtrls, ComCtrls, ToolWin, FMTBcd,
  SqlExpr, Menus;

type
  TfMOVCONTA = class(TcCADASTRO)
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  fMOVCONTA: TfMOVCONTA;

implementation

{$R *.dfm}

procedure TfMOVCONTA.FormCreate(Sender: TObject);
begin
  inherited;
  cTabMan := 'GER_MOVCONTA';
  cKeyMan := 'CD_CONTA|DT_MOV|NR_SEQMOV';
end;

initialization
  RegisterClass(TfMOVCONTA)

end.