unit uRELETIQUETA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucREPORT, ExtCtrls, QuickRpt, QRCtrls, DB, FMTBcd, SqlExpr,
  Provider, DBClient;

type
  TrRELETIQUETA = class(TcREPORT)
    DetailBand: TQRBand;
    QRImageLogo: TQRImage;
    QRLabelEscola: TQRLabel;
    QRLabelTitulo: TQRLabel;
    QRLabelLivro: TQRLabel;
    QRDBTextTitulo: TQRDBText;
    QRLabelEditora: TQRLabel;
    QRLabelAutor: TQRLabel;
    QRDBTextEditora: TQRDBText;
    QRDBTextAutor: TQRDBText;
    QRLabelAno: TQRLabel;
    QRDBTextAno: TQRDBText;
  private
  protected
  public
    constructor create(Aowner : TComponent); override;
  published
  end;

implementation

{$R *.dfm}

uses
  ucDADOS;

{ TrRELETIQUETA }

constructor TrRELETIQUETA.create(Aowner: TComponent);
begin
  inherited;

  if FileExists('Logotipo.bmp') then
    QRImageLogo.Picture.LoadFromFile('Logotipo.bmp');

  QRLabelEscola.Caption := dDADOS.f_LerParametro('NM_ESCOLA');
end;

end.
