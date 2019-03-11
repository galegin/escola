unit ucXML; // mXml

interface

uses
  Classes, SysUtils, StrUtils, DB,
  ucITEM;

  //-- elemento

  procedure putitemX(var pXml: String; pVal: Variant); overload;
  procedure putitemX(var pXml: String; pTag: String; pVal: Variant); overload;

  function getitemX(pTag : String; pXml : String) : String; overload;
  function getitemX(pXml : String) : String; overload;

  procedure delitemX(pTag : String; var pXml: String); overload;
  procedure delitemX(var pXml : String); overload;

  function itemX(pTag, pXml: String) : String;
  function itemXB(pTag, pXml: String) : Boolean;
  function itemXD(pTag, pXml: String) : TDateTime;
  function itemXF(pTag, pXml: String) : Real;
  function itemXI(pTag, pXml: String) : Integer;

  function itemXV(pXml: String) : String;

  //-- atributo

  procedure putitemA(var pXml: String; pTag, pAtr: String; pVal: Variant);

  function itemA(pAtr, pXml: String) : String;
  function itemAB(pAtr, pXml: String) : Boolean;
  function itemAD(pAtr, pXml: String) : TDateTime;
  function itemAF(pAtr, pXml: String) : Real;
  function itemAI(pAtr, pXml: String) : Integer;

  procedure delitemA(pAtr : String; var pXml: String);

  function tagIni(pXml : String) : String;

  function listCdX(pXml : String) : String;
  function listDsX(pXml : String) : String;

  //-- dataset

  procedure putlistitensoccX(var pVar : String; pDataSet : TDataSet);
  procedure getlistitensoccX(pVar : String; pDataSet : TDataSet; pAcao : TpAcao = tpaAut);

  procedure putlistitensoccA(var pVar : String; pDataSet : TDataSet);
  procedure getlistitensoccA(pVar : String; pDataSet : TDataSet; pAcao : TpAcao = tpaAut);

implementation

{ TmXml }

uses
  ucSTRING, ucFUNCAO, ucREGXML;

const
	XML_ELM = '<{tag}>{val}</{tag}>';
	XML_REG = '<{elm}/>';
	XML_ATR = '{tag}="{val}"';

	LST_ELM : array [1..3] of String =
		( '<{tag}>(.*?)</{tag}>', '<{tag} (.*?)</{tag}>', '<{tag} (.*?) />' );
	LST_ATR : array [1..1] of String =
		( '{tag}="(.*?)"' );

	REGEX_ID = 0;
	REGEX_VALUE = 1;

//-- regex

  function RegEx(pXml, pReg : String; pInd : Integer) : String;
  var
    vRegEx : TcRegXml;
  begin
    vRegEx := TcRegXml.Create;
    vRegEx.Expression := pReg;
    if vRegEx.Exec(pXml) then begin
      Result := vRegEx.Match[pInd];
    end else begin
      Result := ''; 
    end;
    vRegEx.Free;
  end;

//-- encapsular

procedure putitemX(var pXml: String; pVal: Variant);
var
  vVal : String;
begin
  vVal := pVal;
  pXml := pXml + vVal;
end;

procedure putitemX(var pXml: String; pTag: String; pVal: Variant);
var
  vVal : String;
begin
  vVal := pVal;
  delitemX(pTag, pXml);
  pXml := pXml + AnsiReplaceStr( AnsiReplaceStr(XML_ELM, '{tag}', pTag), '{val}', vVal);
end;

//--

function itemX(pTag, pXml: String) : String;
var
  I : Integer;
begin
  Result := '';

  if pTag = '' then
    Exit;

  for I:=Low(LST_ELM) to High(LST_ELM) do begin
    Result := RegEx(pXml, AnsiReplaceStr(LST_ELM[I], '{tag}', pTag), REGEX_VALUE);
    if Result <> '' then Break;
  end;
end;

function itemXB(pTag, pXml: String) : Boolean;
begin
  Result := IsStringTrue(itemX(pTag, pXml));
end;

function itemXD(pTag, pXml: String) : TDateTime;
begin
  Result := StrToDateTimeDef(itemX(pTag, pXml), 0);
end;

function itemXF(pTag, pXml: String) : Real;
var
  vResult : String;
begin
  vResult := itemX(pTag, pXml);
  vResult := AnsiReplaceStr(vResult, '.', '');
  Result := StrToFloatDef(vResult, 0);
end;

function itemXI(pTag, pXml: String) : Integer;
var
  vResult : String;
begin
  vResult := itemX(pTag, pXml);
  vResult := AnsiReplaceStr(vResult, '.', '');
  Result := StrToIntDef(vResult, 0);
end;

//--

function getitemX(pTag : String; pXml : String) : String; overload;
var
  I : Integer;
begin
  Result := '';

  if pTag = '' then
    Exit;

  for I:=Low(LST_ELM) to High(LST_ELM) do begin
    Result := RegEx(pXml, AnsiReplaceStr(LST_ELM[I], '{tag}', pTag), REGEX_ID);
    if Result <> '' then Break;
  end;
end;

function getitemX(pXml : String) : String;
var
  vTag : String;
begin
  vTag := tagIni(pXml);
  Result := itemX(vTag, pXml);
end;

//--

procedure delitemX(pTag : String; var pXml: String);
var
  vVal : String;
  I : Integer;
begin
  if pTag = '' then
    Exit;

  for I:=Low(LST_ELM) to High(LST_ELM) do begin
    vVal := RegEx(pXml, AnsiReplaceStr(LST_ELM[I], '{tag}', pTag), REGEX_ID);
    if vVal <> '' then begin
      pXml := AnsiReplaceStr(pXml, vVal, '');
      Break;
    end;
  end;
end;

procedure delitemX(var pXml : String);
var
  vTag, vVal : String;
begin
  vTag := tagIni(pXml);
  vVal := itemX(vTag, pXml);
  pXml := AnsiReplaceStr(pXml, vVal, '');
end;

//--

// entrada: <SPAN class=reposta>TESTE</SPAN>
// saida: TESTE
function itemXV(pXml: String) : String;
begin
  Result := GetRightStr(pXml, '>');
  Result := GetLeftStr(Result, '<');
end;

//--

procedure putitemA(var pXml: String; pTag, pAtr: String; pVal: Variant);
var
  vAtr, vVal : String;
begin
  vVal := pVal;

  if Pos('<' + pTag + ' ', pXml) = 0 then begin
    pXml := AnsiReplaceStr(XML_REG, '{elm}', pTag + ' ');
  end;

  vAtr := AnsiReplaceStr( AnsiReplaceStr(XML_ATR, '{tag}', pAtr), '{val}', vVal) + ' ';

  pXml := AnsiReplaceStr(pXml, '/>', vAtr + '/>');
end;

//--

function itemA(pAtr, pXml: String) : String;
var
  I : Integer;
begin
  Result := '';

  if pAtr = '' then
    Exit;

  for I:=Low(LST_ATR) to High(LST_ATR) do begin
    Result := RegEx(pXml, AnsiReplaceStr(LST_ATR[I], '{tag}', pAtr), REGEX_VALUE);
    if Result <> '' then Break;
  end;
end;

function itemAB(pAtr, pXml: String) : Boolean;
begin
  Result := IsStringTrue(itemA(pAtr, pXml));
end;

function itemAD(pAtr, pXml: String) : TDateTime;
begin
  Result := StrToDateTimeDef(itemA(pAtr, pXml), 0);
end;

function itemAF(pAtr, pXml: String) : Real;
var
  vResult : String;
begin
  vResult := itemA(pAtr, pXml);
  vResult := AnsiReplaceStr(vResult, '.', '');
  Result := StrToFloatDef(vResult, 0);
end;

function itemAI(pAtr, pXml: String) : Integer;
var
  vResult : String;
begin
  vResult := itemA(pAtr, pXml);
  vResult := AnsiReplaceStr(vResult, '.', '');
  Result := StrToIntDef(vResult, 0);
end;

//--

procedure delitemA(pAtr : String; var pXml: String);
var
  vVal : String;
  I : Integer;
begin
  if pAtr = '' then
    Exit;

  for I:=Low(LST_ATR) to High(LST_ATR) do begin
    vVal := RegEx(pXml, AnsiReplaceStr(LST_ATR[I], '{tag}', pAtr), REGEX_ID);
    if vVal <> '' then begin
      pXml := AnsiReplaceStr(pXml, vVal, '');
      Break;
    end;
  end;
end;

//--

function tagIni(pXml : String) : String;
var
  P, I : Integer;
begin
  Result := '';

  P := Pos('<', pXml);
  if P = 0 then Exit;

  for I:=P+1 to Length(pXml) do begin
    if pXml[I] in [' ','/','>'] then Break;
    Result := Result + pXml[I];
  end;
end;

function listCdX(pXml : String) : String;
var
  vTag : String;
begin
  Result := '';

  while pXml <> '' do begin
    vTag := tagIni(pXml);
    if vTag = '' then Break;
    delitemX(vTag, pXml);
    putitem(Result, vTag);
  end;
end;

function listDsX(pXml : String) : String;
var
  vTag, vVal : String;
begin
  Result := '';

  while pXml <> '' do begin
    vTag := tagIni(pXml);
    if vTag = '' then Break;
    vVal := itemX(vTag, pXml);
    delitemX(vTag, pXml);
    putitem(Result, vVal);
  end;
end;

//-- dataset

procedure putlistitensoccX(var pVar : String; pDataSet : TDataSet);
var
  I : Integer;
begin
  pVar := '';
  with pDataSet do
    for I:=0 to FieldCount-1 do
      with Fields[I] do
        putitemX(pVar, FieldName, AsString);
end;

procedure getlistitensoccX(pVar : String; pDataSet : TDataSet; pAcao : TpAcao);
var
  vEdit : Boolean;
  I : Integer;
begin
  with pDataSet do begin
    vEdit := editDataSet(pDataSet, pAcao);

    for I:=0 to FieldCount-1 do
      with Fields[I] do
        if Pos(FieldName, pVar) > 0 then
          AsString := itemX(FieldName, pVar);

    postDataSet(pDataSet, pAcao, vEdit);
  end;
end;

//--

procedure putlistitensoccA(var pVar : String; pDataSet : TDataSet);
var
  I : Integer;
begin
  pVar := '';
  with pDataSet do
    for I:=0 to FieldCount-1 do
      with Fields[I] do
        putitemA(pVar, 'reg', FieldName, AsString);
end;

procedure getlistitensoccA(pVar : String; pDataSet : TDataSet; pAcao : TpAcao);
var
  vEdit : Boolean;
  I : Integer;
begin
  with pDataSet do begin
    vEdit := editDataSet(pDataSet, pAcao);

    for I:=0 to FieldCount-1 do
      with Fields[I] do
        if Pos(FieldName, pVar) > 0 then
          AsString := itemA(FieldName, pVar);

    postDataSet(pDataSet, pAcao, vEdit);
  end;
end;

//-- teste

function teste() : String;
const
  cLST_XML =
    '<cliente cod="1" nom="TESTE 1" />' +
    '<cliente cod="2" nom="TESTE 2" />' +
    '<cliente cod="3" nom="TESTE 3" />' +
    '<cliente cod="4" nom="TESTE 4" />' +
    '<cliente cod="5" nom="TESTE 5" />' +
    '<cliente cod="6" nom="TESTE 6" />' ;
  cVAL_XML =
    '<cliente reg="1" >' +
      '<cod>1</cod>' +
      '<nom>TESTE</nom>' +
      '<dat>01/01/2014</dat>' +
      '<val>15,0</val>' +
      '<ind>T</ind>' +
    '</cliente>' ;
var
  vLstCod, vLstVal : String;
begin
  vLstCod := listCdX(cLST_XML);
  vLstVal := listDsX(cLST_XML);
  vLstVal := vLstVal;

  vLstCod := listCdX(cVAL_XML);
  vLstVal := listDsX(cVAL_XML);
  vLstVal := itemX('cliente', cVAL_XML);
  vLstVal := vLstVal;

  vLstCod := cVAL_XML;
  delitemX('cod', vLstCod);
  delitemX('nom', vLstCod);
  vLstCod := vLstCod;

  vLstCod := '';
  putitemX(vLstCod, 'cod', 1);
  putitemX(vLstCod, 'nom', 'TESTE');
  putitemX(vLstCod, 'dat', date);
  putitemX(vLstCod, 'val', 10);
  putitemX(vLstCod, 'bol', True);
  vLstCod := vLstCod;
  delitemX('dat', vLstCod);
  vLstCod := itemX('nom', vLstCod);
  vLstCod := vLstCod;

  vLstCod := '';
  putitemA(vLstCod, 'reg', 'cod', 1);
  putitemA(vLstCod, 'reg', 'nom', 'TESTE');
  putitemA(vLstCod, 'reg', 'dat', date);
  putitemA(vLstCod, 'reg', 'val', 10);
  putitemA(vLstCod, 'reg', 'bol', True);
  vLstCod := vLstCod;
  vLstCod := itemA('nom', vLstCod);
  vLstCod := vLstCod;

  vLstCod := '';
  putitemX(vLstCod, 'lst', cLST_XML);
  putitemX(vLstCod, 'str', cVAL_XML);
  vLstVal := itemX('lst', vLstCod);
  vLstVal := itemX('str', vLstCod);
  vLstVal := vLstVal;
end;

//--

initialization
  //teste();

end.
