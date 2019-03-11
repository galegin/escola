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
  uPESSOA, uPRODUTO, uMOVESTOQ;

const
  cLST_MENU =
    '<NR_CPFCNPJ  des="Pessoa"  cls="TfPESSOA"   ata="T" img="0" fld="NM_PESSOA"  />' +
    '<CD_BARRAPRD des="Produto" cls="TfPRODUTO"  ata="T" img="1" fld="DS_PRODUTO" />' +
    '<CD_DNAMOV   des="Movto"   cls="TfMOVESTOQ" ata="T" img="2" fld="" />' ;

  cLST_TIPAGEM =
    '<TP_MOV lst="-2=SAIDA;-1=VENDA;0=BALANCO;1=COMPRA;2=ENTRADA" />' ;

procedure TfMENU.FormCreate(Sender: TObject);
begin
  inherited;
  _LstMenu := cLST_MENU;
  _LstTipagem := cLST_TIPAGEM;
end;

end.
