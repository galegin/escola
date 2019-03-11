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
  uCONTA, uHIST, uMOVCONTA;

const
  cLST_MENU =
    '<CD_CONTA    des="Conta"    cls="TfCONTA"    ata="T" img="0" fld="DS_CONTA" />' +
    '<CD_HIST     des="Hist"     cls="TfHIST"     ata="T" img="1" fld="DS_HIST"  />' +
    '<CD_MOVCONTA des="MovConta" cls="TfMOVCONTA" ata="T" img="2" fld="" />' ;

  cLST_TIPAGEM =
    '<TP_CONTA lst="1=Caixa;2=Banco"    />' +
    '<TP_OPER  lst="D=Debito;C=Credito" />' ;

procedure TfMENU.FormCreate(Sender: TObject);
begin
  inherited;
  _LstMenu := cLST_MENU;
  _LstTipagem := cLST_TIPAGEM;
end;

end.
