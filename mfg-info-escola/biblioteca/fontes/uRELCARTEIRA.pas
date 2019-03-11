unit uRELCARTEIRA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucREPORT, ExtCtrls, QuickRpt, QRCtrls, DB, FMTBcd, SqlExpr,
  Provider, DBClient;

type
  TrRELCARTEIRA = class(TcREPORT)
    DetailBand: TQRBand;
    QRImageLogo: TQRImage;
    QRLabelEscola: TQRLabel;
    QRLabelTitulo: TQRLabel;
    QRLabelAluno: TQRLabel;
    QRDBTextAluno: TQRDBText;
    QRLabelTurma: TQRLabel;
    QRLabelPeriodo: TQRLabel;
    QRDBTextTurma: TQRDBText;
    QRDBTextPeriodo: TQRDBText;
  private
  protected
  public
    constructor create(Aowner : TComponent); override;
  published
  end;

implementation

{$R *.dfm}

{ TrRELCARTEIRA }

constructor TrRELCARTEIRA.create(Aowner: TComponent);
begin
  inherited;
  if FileExists('Logotipo.bmp') then
    QRImageLogo.Picture.LoadFromFile('Logotipo.bmp');
end;

end.
