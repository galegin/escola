unit uMENU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucMENU, Menus, StdCtrls, ComCtrls, ToolWin, ExtCtrls;

type
  TfMENU = class(TcMENU)
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  fMENU: TfMENU;

implementation

{$R *.dfm}

uses
  uCURSO, uINATIVO;

const
  cLST_MENU =
    '<CD_CURSO    des="Curso"   cls="TfCURSO"   ata="T" img="0" />' +
    '<CD_INATIVO  des="Inativo" cls="TfINATIVO" ata="T" img="1" />' ;

procedure TfMENU.FormCreate(Sender: TObject);
begin
  inherited;
  _LstMenu := cLST_MENU;
end;

end.