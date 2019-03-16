unit ucCONFCAMPO;

interface

uses
  Classes, SysUtils, StrUtils;

type
  TcCONFCAMPO = class;
  TcCONFCAMPOClass = class of TcCONFCAMPO;

  TcCONFCAMPO = class
  private
    FCodigo: String;
    FDescricao: String;
    FDecimal: Integer;
    FTamanho: Integer;
    FTamanhoRel: Integer;
    FInManut: Boolean;
    FInRelat: Boolean;
    FInObrig: boolean;
    FInChave: Boolean;
    FInVisib: Boolean;
    FInEdita: Boolean;
    FInIncre: Boolean;
    FInValid: Boolean;
    procedure SetCodigo(const Value: String);
    procedure SetDescricao(const Value: String);
    procedure SetTamanho(const Value: Integer);
    procedure SetTamanhoRel(const Value: Integer);
    procedure SetDecimal(const Value: Integer);
    procedure SetInManut(const Value: Boolean);
    procedure SetInRelat(const Value: Boolean);
    procedure SetInChave(const Value: Boolean);
    procedure SetInObrig(const Value: boolean);
    procedure SetInEdita(const Value: Boolean);
    procedure SetInVisib(const Value: Boolean);
    procedure SetInIncre(const Value: Boolean);
    procedure SetInValid(const Value: Boolean);
  protected
  public
  published
    property Codigo : String read FCodigo write SetCodigo;
    property Descricao : String read FDescricao write SetDescricao;
    property Tamanho : Integer read FTamanho write SetTamanho;
    property TamanhoRel : Integer read FTamanhoRel write SetTamanhoRel;
    property Decimal : Integer read FDecimal write SetDecimal;
    property InChave : Boolean read FInChave write SetInChave;
    property InIncre : Boolean read FInIncre write SetInIncre;
    property InObrig : boolean read FInObrig write SetInObrig;
    property InVisib : Boolean read FInVisib write SetInVisib;
    property InEdita : Boolean read FInEdita write SetInEdita;
    property InManut : Boolean read FInManut write SetInManut;
    property InRelat : Boolean read FInRelat write SetInRelat;
    property InValid : Boolean read FInValid write SetInValid;
  end;

  TcCONFCAMPOLIST = class;
  TcCONFCAMPOLISTClass = class of TcCONFCAMPOLIST;

  TcCONFCAMPOLIST = class(TList)
  private
    function GetItem(Index: Integer): TcCONFCAMPO;
    procedure SetItem(Index: Integer; const Value: TcCONFCAMPO);
  public
    function Adicionar : TcCONFCAMPO; overload;
    procedure Adicionar(item : TcCONFCAMPO); overload;
    property Item[Index: Integer] : TcCONFCAMPO read GetItem write SetItem;
    function Buscar(pCodigo : String) : TcCONFCAMPO;
    function IsContemChave() : Boolean;
    function GetListaChave() : TcCONFCAMPOLIST;
    function GetPrimeiraChave() : TcCONFCAMPO;
    function IsContemObrig() : Boolean;
    function GetListaObrig() : TcCONFCAMPOLIST;
    function GetPrimeiraObrig() : TcCONFCAMPO;
    function IsContemIncre() : Boolean;
    function GetListaIncre() : TcCONFCAMPOLIST;
    function GetPrimeiraIncre() : TcCONFCAMPO;
    function IsContemValid() : Boolean;
    function GetListaValid() : TcCONFCAMPOLIST;
    function GetPrimeiraValid() : TcCONFCAMPO;
    function IsContemManut() : Boolean;
    function GetListaManut() : TcCONFCAMPOLIST;
    function GetPrimeiraManut() : TcCONFCAMPO;
    function IsContemRelat() : Boolean;
    function GetListaRelat() : TcCONFCAMPOLIST;
    function GetPrimeiraRelat() : TcCONFCAMPO;
    function IsContemVisib() : Boolean;
    function GetListaVisib() : TcCONFCAMPOLIST;
    function GetPrimeiraVisib() : TcCONFCAMPO;
  end;

implementation

{ TcCONFCAMPO }

procedure TcCONFCAMPO.SetCodigo(const Value: String);
begin
  FCodigo := Value;
end;

procedure TcCONFCAMPO.SetDecimal(const Value: Integer);
begin
  FDecimal := Value;
end;

procedure TcCONFCAMPO.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TcCONFCAMPO.SetInValid(const Value: Boolean);
begin
  FInValid := Value;
end;

procedure TcCONFCAMPO.SetInChave(const Value: Boolean);
begin
  FInChave := Value;
end;

procedure TcCONFCAMPO.SetInEdita(const Value: Boolean);
begin
  FInEdita := Value;
end;

procedure TcCONFCAMPO.SetInIncre(const Value: Boolean);
begin
  FInIncre := Value;
end;

procedure TcCONFCAMPO.SetInManut(const Value: Boolean);
begin
  FInManut := Value;
end;

procedure TcCONFCAMPO.SetInObrig(const Value: boolean);
begin
  FInObrig := Value;
end;

procedure TcCONFCAMPO.SetInRelat(const Value: Boolean);
begin
  FInRelat := Value;
end;

procedure TcCONFCAMPO.SetInVisib(const Value: Boolean);
begin
  FInVisib := Value;
end;

procedure TcCONFCAMPO.SetTamanho(const Value: Integer);
begin
  FTamanho := Value;
end;

procedure TcCONFCAMPO.SetTamanhoRel(const Value: Integer);
begin
  FTamanhoRel := Value;
end;

{ TcCONFCAMPOLIST }

procedure TcCONFCAMPOLIST.Adicionar(item: TcCONFCAMPO);
begin
  Self.Add(item);
end;

function TcCONFCAMPOLIST.Adicionar: TcCONFCAMPO;
begin
  Result := TcCONFCAMPO.Create;
  Self.Add(Result);
end;

function TcCONFCAMPOLIST.Buscar(pCodigo: String): TcCONFCAMPO;
var
  I : Integer;
begin
  Result := nil;

  for I := 0 to Count - 1 do begin
    if (Item[I].Codigo = pCodigo) then begin
      Result := Item[I];
      Exit;
    end;
  end;

  if (Result = nil) then
    Result := TcCONFCAMPO.Create;
end;

//--

function TcCONFCAMPOLIST.GetItem(Index: Integer): TcCONFCAMPO;
begin
  Result := TcCONFCAMPO(Self[Index]);
end;

procedure TcCONFCAMPOLIST.SetItem(Index: Integer;
  const Value: TcCONFCAMPO);
begin
  Self[Index] := Value;
end;

//--

function TcCONFCAMPOLIST.IsContemChave: Boolean;
var
  I : Integer;
begin
  Result := False;

  for I := 0 to Count - 1 do begin
    if (Item[I].InChave) then begin
      Result := True;
      Exit;
    end;
  end;
end;

function TcCONFCAMPOLIST.GetListaChave: TcCONFCAMPOLIST;
var
  I : Integer;
begin
  Result := TcCONFCAMPOLIST.Create;

  for I := 0 to Count - 1 do
    if (Item[I].InChave) then
      Result.Adicionar(Item[I]);
end;

function TcCONFCAMPOLIST.GetPrimeiraChave: TcCONFCAMPO;
var
  vLista : TcCONFCAMPOLIST;
begin
  vLista := GetListaChave();
  if (vLista.Count > 0) then
    Result := vLista.Item[0]
  else
    Result := nil;
end;

//--

function TcCONFCAMPOLIST.IsContemObrig: Boolean;
var
  I : Integer;
begin
  Result := False;

  for I := 0 to Count - 1 do begin
    if (Item[I].InObrig) then begin
      Result := True;
      Exit;
    end;
  end;
end;

function TcCONFCAMPOLIST.GetListaObrig: TcCONFCAMPOLIST;
var
  I : Integer;
begin
  Result := TcCONFCAMPOLIST.Create;

  for I := 0 to Count - 1 do
    if (Item[I].InObrig) then
      Result.Adicionar(Item[I]);
end;

function TcCONFCAMPOLIST.GetPrimeiraObrig: TcCONFCAMPO;
var
  vLista : TcCONFCAMPOLIST;
begin
  vLista := GetListaObrig();
  if (vLista.Count > 0) then
    Result := vLista.Item[0]
  else
    Result := nil;
end;

//--

function TcCONFCAMPOLIST.IsContemIncre: Boolean;
var
  I : Integer;
begin
  Result := False;

  for I := 0 to Count - 1 do begin
    if (Item[I].InIncre) then begin
      Result := True;
      Exit;
    end;
  end;
end;

function TcCONFCAMPOLIST.GetListaIncre: TcCONFCAMPOLIST;
var
  I : Integer;
begin
  Result := TcCONFCAMPOLIST.Create;

  for I := 0 to Count - 1 do
    if (Item[I].InIncre) then
      Result.Adicionar(Item[I]);
end;

function TcCONFCAMPOLIST.GetPrimeiraIncre: TcCONFCAMPO;
var
  vLista : TcCONFCAMPOLIST;
begin
  vLista := GetListaIncre();
  if (vLista.Count > 0) then
    Result := vLista.Item[0]
  else
    Result := nil;
end;

//--

function TcCONFCAMPOLIST.IsContemValid: Boolean;
var
  I : Integer;
begin
  Result := False;

  for I := 0 to Count - 1 do begin
    if (Item[I].InValid) then begin
      Result := True;
      Exit;
    end;
  end;
end;

function TcCONFCAMPOLIST.GetListaValid: TcCONFCAMPOLIST;
var
  I : Integer;
begin
  Result := TcCONFCAMPOLIST.Create;

  for I := 0 to Count - 1 do
    if (Item[I].InValid) then
      Result.Adicionar(Item[I]);
end;

function TcCONFCAMPOLIST.GetPrimeiraValid: TcCONFCAMPO;
var
  vLista : TcCONFCAMPOLIST;
begin
  vLista := GetListaValid();
  if (vLista.Count > 0) then
    Result := vLista.Item[0]
  else
    Result := nil;
end;

//--

function TcCONFCAMPOLIST.IsContemManut: Boolean;
var
  I : Integer;
begin
  Result := False;

  for I := 0 to Count - 1 do begin
    if (Item[I].InManut) then begin
      Result := True;
      Exit;
    end;
  end;
end;

function TcCONFCAMPOLIST.GetListaManut: TcCONFCAMPOLIST;
var
  I : Integer;
begin
  Result := TcCONFCAMPOLIST.Create;

  for I := 0 to Count - 1 do
    if (Item[I].InManut) then
      Result.Adicionar(Item[I]);
end;

function TcCONFCAMPOLIST.GetPrimeiraManut: TcCONFCAMPO;
var
  vLista : TcCONFCAMPOLIST;
begin
  vLista := GetListaManut();
  if (vLista.Count > 0) then
    Result := vLista.Item[0]
  else
    Result := nil;
end;

//--

function TcCONFCAMPOLIST.IsContemRelat: Boolean;
var
  I : Integer;
begin
  Result := False;

  for I := 0 to Count - 1 do begin
    if (Item[I].InRelat) then begin
      Result := True;
      Exit;
    end;
  end;
end;

function TcCONFCAMPOLIST.GetListaRelat: TcCONFCAMPOLIST;
var
  I : Integer;
begin
  Result := TcCONFCAMPOLIST.Create;

  for I := 0 to Count - 1 do
    if (Item[I].InRelat) then
      Result.Adicionar(Item[I]);
end;

function TcCONFCAMPOLIST.GetPrimeiraRelat: TcCONFCAMPO;
var
  vLista : TcCONFCAMPOLIST;
begin
  vLista := GetListaRelat();
  if (vLista.Count > 0) then
    Result := vLista.Item[0]
  else
    Result := nil;
end;

//--

function TcCONFCAMPOLIST.IsContemVisib: Boolean;
var
  I : Integer;
begin
  Result := False;

  for I := 0 to Count - 1 do begin
    if (Item[I].InVisib) then begin
      Result := True;
      Exit;
    end;
  end;
end;

function TcCONFCAMPOLIST.GetListaVisib: TcCONFCAMPOLIST;
var
  I : Integer;
begin
  Result := TcCONFCAMPOLIST.Create;

  for I := 0 to Count - 1 do
    if (Item[I].InVisib) then
      Result.Adicionar(Item[I]);
end;

function TcCONFCAMPOLIST.GetPrimeiraVisib: TcCONFCAMPO;
var
  vLista : TcCONFCAMPOLIST;
begin
  vLista := GetListaVisib();
  if (vLista.Count > 0) then
    Result := vLista.Item[0]
  else
    Result := nil;
end;

//--

end.
