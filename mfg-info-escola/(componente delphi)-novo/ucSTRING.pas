unit ucSTRING; // mString / mItem / mXml

interface

uses
  Classes, SysUtils;

type
  TcSTRING = class(TStringList)
  private
    function GetTexto: String;
    procedure SetTexto(const Value: String);
  public
    constructor create(pString : String);

    procedure putitem(pCod : String; pVal : Variant);

    function item(pCod : String) : String;
    function itemB(pCod : String) : Boolean;
    function itemD(pCod : String) : TDateTime;
    function itemF(pCod : String) : Real;
    function itemI(pCod : String) : Integer;
  published
    property _Texto : String read GetTexto write SetTexto;
  end;

var
  gSTRING : TcSTRING;

implementation

uses
  ucFUNCAO;

  function TcSTRING.GetTexto: String;
  var
    I : Integer;
  begin
    Result := '';
    for I:=0 to Count-1 do begin
      Result := Result + IfThenS(Result<>'',';','') + Self[I];
    end;
  end;

  procedure TcSTRING.SetTexto(const Value: String);
  begin
    Text := replaceStr(Value, ';', sLineBreak);
  end;

{ TcSTRING }

constructor TcSTRING.create(pString: String);
begin
  _Texto := pString;
end;

procedure TcSTRING.putitem(pCod: String; pVal: Variant);
var
  vValue : String;
begin
  vValue := pVal;
  Values[pCod] := vValue;
end;

function TcSTRING.item(pCod: String): String;
begin
  Result := Values[pCod];
end;

function TcSTRING.itemB(pCod: String): Boolean;
begin
  Result := Pos(item(pCod), cLST_TRUE) > 0;
end;

function TcSTRING.itemD(pCod: String): TDateTime;
begin
  Result := StrToDateTimeDef(item(pCod),0);
end;

function TcSTRING.itemF(pCod: String): Real;
begin
  Result := StrToFloatDef(item(pCod),0);
end;

function TcSTRING.itemI(pCod: String): Integer;
begin
  Result := StrToIntDef(item(pCod),0);
end;

initialization
  gSTRING := TcSTRING.create('');

finalization
  gSTRING.Free;

end.
