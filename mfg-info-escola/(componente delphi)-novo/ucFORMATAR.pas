unit ucFORMATAR;

interface

uses
  Classes, SysUtils, StrUtils, TypInfo;

type
  TpFormatar =
    (tfCEP, tfCNPJ, tfCPF, tfDATA, tfFONE, tfINSC, tfNUMERO, tfPLACA);

  TcFormatar = class
  public
    class function tip(pTip : String) : TpFormatar;
    class function str(pTip : TpFormatar) : String;
    class function xml(pTip : TpFormatar) : String;
    class function fmt(pTip : TpFormatar) : String;
    class function dec(pTip : TpFormatar) : Integer;
  end;

implementation

uses
  ucXML;

const
  cLST_FORMATAR =
    '<tfCEP    fmt="99.999-999"          dec="0" />' +
    '<tfCNPJ   fmt="X99.999.999/9999-99" dec="0" />' +
    '<tfCPF    fmt="999.999.999-99"      dec="0" />' +
    '<tfDATA   fmt="99/99/9999"          dec="0" />' +
    '<tfFONE   fmt="(99)XX999-9999"      dec="0" />' +
    '<tfINSC   fmt="999.999.999.999"     dec="0" />' +
    '<tfNUMERO fmt="#,###,###,##0.000"   dec="3" />' +
    '<tfPLACA  fmt="ZZZ-9999"            dec="0" />' ;

class function TcFormatar.tip(pTip : String) : TpFormatar;
begin
  Result := TpFormatar(GetEnumValue(TypeInfo(TpFormatar), pTip));
end;

class function TcFormatar.str(pTip : TpFormatar) : String;
begin
  Result := GetEnumName(TypeInfo(TpFormatar), Integer(pTip));
end;

class function TcFormatar.xml(pTip : TpFormatar) : String;
begin
  Result := Str(pTip);
  Result := itemX(Result, cLST_FORMATAR);
end;

class function TcFormatar.fmt(pTip : TpFormatar) : String;
begin
  Result := itemA('fmt', xml(pTip));
end;

class function TcFormatar.dec(pTip : TpFormatar) : Integer;
begin
  Result := itemAI('dec', xml(pTip));
end;

end.
