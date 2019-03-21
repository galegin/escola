unit ucCONFCAMPOMET;

interface

uses
  Classes, SysUtils, StrUtils,
  ucCONFCAMPO, ucCONFCAMPOJSON;

type
  TcCONFCAMPOMET = class
  private
  protected
  public
    class function Carregar(pCaption, pTabMan : String) : TcCONFCAMPOLIST;
    class function CarregarCaption(pCaption : String) : TcCONFCAMPOLIST;
    class function CarregarTabMan(pTabMan : String) : TcCONFCAMPOLIST;
  end;

implementation

uses
  ucFUNCAO, ucCONST, ucITEM, ucXML, ucDADOS, ucCAMPO,
  ucMETADATA;

{ TcCONFCAMPOMET }

class function TcCONFCAMPOMET.Carregar(
  pCaption, pTabMan: String): TcCONFCAMPOLIST;
const
  cMETHOD = 'TcCONFCAMPOMET.Carregar()';
var
  vMetadata, vLstCod, vCod, vDes : String;
  vTipo : TpCONFCAMPO;
begin
  if (pCaption = '') then
    raise Exception.Create('Caption deve ser informado / ' + cMETHOD);
  if (pTabMan = '') then
    raise Exception.Create('TabMan deve ser informado / ' + cMETHOD);

  Result := TcCONFCAMPOJSON.Ler(pCaption);

  if (Result.Count > 0) then
    Exit;

  vMetadata := dDADOS.GetMetadataEnt(pTabMan);
  vMetadata := itemX('fields', vMetadata);
  vLstCod := TcMETADATA.getMetadataXml(vMetadata, 'cod');
  vTipo := tpcKey;

  while (vLstCod <> '') do begin
    vCod := getitem(vLstCod);
    if (vCod = '') then Break;
    delitem(vLstCod);

    if (Pos(vCod, 'TP_SITUACAO') > 0) then begin
      vTipo := tpcReq;
      Continue;
    end;

    vDes := CampoDes(vCod);

    with Result.Adicionar do begin
      Codigo := vCod;
      Tipo := vTipo;
      Descricao := vDes;
      InManut := True;
      InRelat := True;
    end;
  end;
end;

class function TcCONFCAMPOMET.CarregarCaption(pCaption: String): TcCONFCAMPOLIST;
begin
  Result := Carregar(pCaption, 'GER_' + pCaption);
end;

class function TcCONFCAMPOMET.CarregarTabMan(pTabMan: String): TcCONFCAMPOLIST;
begin
  Result := Carregar(ReplaceStr(pTabMan, 'GER_', ''), pTabMan);
end;

end.
