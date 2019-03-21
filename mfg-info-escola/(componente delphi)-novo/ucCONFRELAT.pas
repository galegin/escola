unit ucCONFRELAT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin, CheckLst,
  ucCONFMANUT, ucCONFCAMPO, DB, DBClient, Grids, DBGrids;

type
  TcCONFRELAT = class(TcCONFMANUT)
    procedure FormCreate(Sender: TObject);
  private
  protected
    procedure SetClientDataSetConf(pConfCampo : TcCONFCAMPO); override;
    procedure GetClientDataSetConf(pConfCampo : TcCONFCAMPO); override;
  public
  end;

implementation

{$R *.dfm}

  procedure TcCONFRELAT.SetClientDataSetConf(pConfCampo: TcCONFCAMPO);
  begin
    ClientDataSetConfCodigo.AsString := pConfCampo.Codigo;
    ClientDataSetConfDescricao.AsString := pConfCampo.Descricao;
    ClientDataSetConfTam.AsInteger := pConfCampo.TamanhoRel;
    ClientDataSetConfDec.AsInteger := pConfCampo.Decimal;
    ClientDataSetConfVisivel.AsBoolean := pConfCampo.InRelat;
  end;

  procedure TcCONFRELAT.GetClientDataSetConf(pConfCampo: TcCONFCAMPO);
  begin
    pConfCampo.Tipo := StrToTipoCampo(ClientDataSetConfTipo.AsString);
    pConfCampo.TamanhoRel := ClientDataSetConfTam.AsInteger;
    pConfCampo.Decimal := ClientDataSetConfDec.AsInteger;
    pConfCampo.InRelat := ClientDataSetConfVisivel.AsBoolean;
  end;

procedure TcCONFRELAT.FormCreate(Sender: TObject);
begin
  inherited;
  _Titulo := 'Configura Relatório';
  _InManut := False;
end;

end.
