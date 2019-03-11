unit ucSOBRE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TcSOBRE = class(TForm)
    Panel1: TPanel;
    RxLabel3: TLabel;
    Image1: TImage;
    BitBtn1: TBitBtn;
    RxLabel1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC;

procedure TcSOBRE.FormCreate(Sender: TObject);
begin
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);
end;

end.
