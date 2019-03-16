unit ucCONFCAMPOJSON;

interface

uses
  Classes, SysUtils, StrUtils,
  ucCONFCAMPO;

type
  TcCONFCAMPOJSON = class
  public
    class procedure Gravar(pArquivo : String; pLista : TcCONFCAMPOLIST);
    class function Ler(pArquivo : String) : TcCONFCAMPOLIST;
  end;

implementation

uses
  uLkJSON, ucARQUIVO, ucPATH;

  function GetNomeArquivo(pArquivo : String) : String;
  begin
    Result := TcPATH.Dados() + pArquivo + '.json';
  end;

{ TcCONFCAMPOJSON }

class procedure TcCONFCAMPOJSON.Gravar(pArquivo: String; pLista: TcCONFCAMPOLIST);
var
  vConfCampo : TcCONFCAMPO;
  vJsonClass : TlkJSON;
  vJsonList : TlkJSONlist;
  vJsonObj : TlkJSONobject;
  vConteudo : String;
  I : Integer;
begin
  pArquivo := GetNomeArquivo(pArquivo);

  vJsonList := TlkJSONlist.Create;
  for I := 0 to pLista.Count - 1 do begin
    vConfCampo := pLista.Item[I];

    vJsonObj := TlkJSONobject.Create();
    vJsonObj.Add('Codigo', vConfCampo.Codigo);
    vJsonObj.Add('Descricao', vConfCampo.Descricao);
    vJsonObj.Add('Tamanho', vConfCampo.Tamanho);
    vJsonObj.Add('TamanhoRel', vConfCampo.TamanhoRel);
    vJsonObj.Add('Decimal', vConfCampo.Decimal);
    vJsonObj.Add('InChave', vConfCampo.InChave);
    vJsonObj.Add('InIncre', vConfCampo.InIncre);
    vJsonObj.Add('InObrig', vConfCampo.InObrig);
    vJsonObj.Add('InVisib', vConfCampo.InVisib);
    vJsonObj.Add('InEdita', vConfCampo.InEdita);
    vJsonObj.Add('InManut', vConfCampo.InManut);
    vJsonObj.Add('InRelat', vConfCampo.InRelat);
    vJsonObj.Add('InValid', vConfCampo.InValid);
    vJsonList.Add(vJsonObj);
  end;

  vJsonClass := TlkJSON.Create;
  vConteudo := vJsonClass.GenerateText(vJsonList);

  TcARQUIVO.descarregar(pArquivo, vConteudo)
end;

class function TcCONFCAMPOJSON.Ler(pArquivo: String): TcCONFCAMPOLIST;
var
  vJsonClass : TlkJSON;
  vJsonList : TlkJSONlist;
  vJsonObj : TlkJSONbase;
  vConteudo : String;
  I : Integer;
begin
  pArquivo := GetNomeArquivo(pArquivo);

  Result := TcCONFCAMPOLIST.Create;

  vConteudo := TcARQUIVO.carregar(pArquivo);
  if (vConteudo = '') then begin
    Exit;
  end;

  vJsonClass := TlkJSON.Create;
  vJsonList := vJsonClass.ParseText(vConteudo) as TlkJSONlist;

  for I := 0 to vJsonList.Count - 1 do begin
    vJsonObj :=  vJsonList.Child[I];

    with Result.Adicionar do begin
      Codigo := vJsonObj.Field['Codigo'].Value;
      Descricao := vJsonObj.Field['Descricao'].Value;
      Tamanho := vJsonObj.Field['Tamanho'].Value;
      TamanhoRel := vJsonObj.Field['TamanhoRel'].Value;
      Decimal := vJsonObj.Field['Decimal'].Value;
      InChave := vJsonObj.Field['InChave'].Value;
      InIncre := vJsonObj.Field['InIncre'].Value;
      InObrig := vJsonObj.Field['InObrig'].Value;
      InVisib := vJsonObj.Field['InVisib'].Value;
      InEdita := vJsonObj.Field['InEdita'].Value;
      InManut := vJsonObj.Field['InManut'].Value;
      InRelat := vJsonObj.Field['InRelat'].Value;
      InValid := vJsonObj.Field['InValid'].Value;
    end;
  end;
end;

end.
