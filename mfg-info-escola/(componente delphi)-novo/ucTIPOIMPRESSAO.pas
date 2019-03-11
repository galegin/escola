unit ucTIPOIMPRESSAO;

interface

uses
  Classes, SysUtils, TypInfo;

type
  TTipoImpressao = (tpiArquivo,
                    tpiEmail,
                    tpiImpressora,
                    tpiVisualizar);

  TcTipoImpressao = class
  private
    FTip : TTipoImpressao;
    function GetDes: String;
  public
    constructor Create(pTip : TTipoImpressao);
  published
    property _Tip : TTipoImpressao read FTip;
    property _Des : String read GetDes;
  end;

  function lst() : TStringList;
  function tip(pTip : String) : TTipoImpressao;
  function cod(pTip : TTipoImpressao) : String;
  function des(pTip : TTipoImpressao) : String;

implementation

{ TcTipoImpressao }

constructor TcTipoImpressao.Create(pTip: TTipoImpressao);
begin
  FTip := pTip;
end;

function TcTipoImpressao.GetDes: String;
begin
  Result := des(FTip);
end;

{ TcTIPOIMPRESSAO }

const
  TTipoImpressaoArray : Array[TTipoImpressao] of String =
    ('Arquivo', 'Email', 'Impressora', 'Vizualizar');

function lst: TStringList;
var
  vTipo : TcTipoImpressao;
  I : Integer;
begin
  Result := TStringList.Create;
  for I := Ord(Low(TTipoImpressao)) to Ord(High(TTipoImpressao)) do begin
    vTipo := TcTipoImpressao.Create(TTipoImpressao(I));
    Result.AddObject(vTipo._Des, vTipo);
  end;
end;

function tip(pTip: String): TTipoImpressao;
begin
  Result := TTipoImpressao(GetEnumValue(TypeInfo(TTipoImpressao), pTip));
  if ord(Result) = -1 then
    Result := tpiVisualizar;
end;

function cod(pTip: TTipoImpressao): String;
begin
  Result := GetEnumName(TypeInfo(TTipoImpressao), Integer(pTip));
end;

function des(pTip: TTipoImpressao): String;
begin
  Result := TTipoImpressaoArray[pTip];
end;

end.
