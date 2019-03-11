unit ucSPLASH;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBTables, ComCtrls;

type
  TcSPLASH = class(TForm)
    LabelVersao: TLabel;
    LabelSistema: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
  public
    v_Alias:String;
  end;

var
  cSPLASH: TcSPLASH;

implementation

{$R *.DFM}

uses
  ucFUNCAO, ucCONST, ucPROJETO;

procedure TcSPLASH.FormCreate(Sender: TObject);
begin
  LabelSistema.Caption := TcPROJETO.Nome();
  LabelVersao.Caption := TcPROJETO.Versao();
end;

end.
