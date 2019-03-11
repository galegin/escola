unit uPESSOA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, Provider, DB, DBClient, ExtCtrls, Grids,
  DBGrids, Buttons, StdCtrls, ComCtrls, ToolWin, FMTBcd,
  SqlExpr, Menus;

type
  TfPESSOA = class(TcCADASTRO)
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  fPESSOA: TfPESSOA;

implementation

{$R *.dfm}

procedure TfPESSOA.FormCreate(Sender: TObject);
begin
  inherited;
  cTabMan := 'GER_PESSOA';
  cKeyMan := 'NR_CPFCNPJ';
end;

initialization
  RegisterClass(TfPESSOA);

end.