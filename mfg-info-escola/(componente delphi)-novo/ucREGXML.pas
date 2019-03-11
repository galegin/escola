unit ucRegXml;

interface

uses
  Classes, SysUtils;

type
  TcRegXml = class
  private
    FMatch : TStrings;
    FTagI, FTagF : String;
    FExpression: String;
    procedure SetExpression(const Value: String);
    function GetMatch(Idx: Integer): String;
  public
    constructor create;
    destructor destroy; override;
    function Exec(pStr : String) : Boolean;
    property Expression : String read FExpression write SetExpression;
    property Match[Idx : Integer] : String read GetMatch;
  end;

implementation

uses
  ucFuncao;

const
	VAL_EML = '(.*?)';

  procedure TcRegXml.SetExpression(const Value: String);
  begin
    FExpression := Value;
    FTagI := GetLeftStr(Value, VAL_EML);
    FTagF := GetRightStr(Value, VAL_EML);
  end;

  function TcRegXml.GetMatch(Idx: Integer): String;
  begin
    Result := FMatch[Idx];
  end;

{ TcRegXml }

constructor TcRegXml.create;
begin
  FMatch := TStringList.Create;
end;

destructor TcRegXml.destroy;
begin
  FMatch.Free;
end;

function TcRegXml.Exec(pStr: String): Boolean;
var
  PI, PF : Integer;
begin
  Result := False;

  //-- limpar valores
  FMatch.Clear;

  //-- verifica tag ini
  PI := Pos(FTagI, pStr);
  if PI = 0 then Exit;
  if PI > 1 then Delete(pStr, 1, PI-1);
  Delete(pStr, 1, Length(FTagI));

  //-- verifica tag fin
  PF := Pos(FTagF, pStr);
  if PF = 0 then Exit;
  pStr := Copy(pStr, 1, PF-1);

  //-- adicionar valores
  FMatch.Add(FTagI + pStr + FTagF);
  FMatch.Add(pStr);

  Result := True;
end;

end.
