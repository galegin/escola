unit ucITEM; // mItem

interface

uses
  Classes, SysUtils, StrUtils, DB, Variants;

type
  TpAcao = (tpaAut, tpaApp, tpaIns);

  function editDataSet(pDataSet : TDataSet; pAcao : TpAcao) : Boolean;
  procedure postDataSet(pDataSet : TDataSet; pAcao : TpAcao; pEdit : Boolean);

  // string

  procedure putitem(var pVar: String; pVal: Variant); overload;
  procedure putitem(var pVar: String; pCod: String; pVal: Variant); overload;

  function item(pCod, pVar: String) : String; overload;
  function itemB(pCod, pVar: String) : Boolean; overload;
  function itemD(pCod, pVar: String) : TDateTime; overload;
  function itemF(pCod, pVar: String) : Real; overload;
  function itemI(pCod, pVar: String) : Integer; overload;

  function tagIni(pVar : String) : String;

  function listCd(pVar : String) : String;
  function listDs(pVar : String) : String; overload;

  function itemDs(pVal, pVar : String) : String;

  function getitem(pVar : String; pItem : Integer) : String; overload;
  function getitem(pVar : String) : String; overload;
  function getitemB(pVar : String) : Boolean;
  function getitemD(pVar : String) : TDateTime;
  function getitemF(pVar : String) : Real;
  function getitemI(pVar : String) : Integer;

  procedure delitem(var pVar : String); overload;
  procedure delitem(pCod : String; var pVar : String); overload;

  // dataset

  procedure putitem(pDataSet : TDataSet; pCod: String; pVal: Variant); overload;

  function item(pCod: String; pDataSet : TDataSet) : String; overload;
  function itemB(pCod: String; pDataSet : TDataSet) : Boolean; overload;
  function itemD(pCod: String; pDataSet : TDataSet) : TDateTime; overload;
  function itemF(pCod: String; pDataSet : TDataSet) : Real; overload;
  function itemI(pCod: String; pDataSet : TDataSet) : Integer; overload;

  procedure putlistitensocc(var pVar : String; pDataSet : TDataSet);
  procedure getlistitensocc(pVar : String; pDataSet : TDataSet; pAcao : TpAcao = tpaAut);

implementation

{ TmItem }

uses
  ucSTRING, ucFUNCAO, ucXML;

  function editDataSet(pDataSet : TDataSet; pAcao : TpAcao) : Boolean;
  begin
    with pDataSet do begin
      Result := not (State in [dsInsert, dsEdit]);
      if (pAcao = tpaApp) then Append()
      else if (pAcao = tpaIns) then Insert()
      else if (Result) then Edit();
    end;
  end;

  procedure postDataSet(pDataSet : TDataSet; pAcao : TpAcao; pEdit : Boolean);
  begin
    with pDataSet do begin
      if (pAcao = tpaApp) then Post()
      else if (pAcao = tpaIns) then Post()
      else if (pEdit) then Post();
    end;
  end;

//--

procedure putitem(var pVar: String; pVal: Variant); overload;
var
  vVal : String;
begin
  if Copy(pVar,1,1) = '<' then begin
    putitemX(pVar, pVal);
    Exit;
  end;

  vVal := pVal;
  pVar := pVar + IfThen(pVar<>'','|') + vVal;
end;

procedure putitem(var pVar: String; pCod: String; pVal: Variant); overload;
var
  vVal : String;
begin
  if Copy(pVar,1,1) = '<' then begin
    putitemX(pVar, pCod, pVal);
    Exit;
  end;

  vVal := pVal;
  pVar := pVar + IfThen(pVar<>'',';') + pCod + '=' + vVal;
end;

//--

function item(pCod, pVar: String) : String;
var
  P : Integer;
begin
  Result := '';

  if Copy(pVar,1,1) = '<' then begin
    Result := itemX(pCod, pVar);
    Exit;
  end;

  P := Pos(pCod + '=', pVar);
  if P = 0 then Exit;
  if P > 1 then Delete(pVar, 1, P-1);

  P := Pos('=', pVar);
  if P > 1 then Delete(pVar, 1, P);

  P := Pos(';', pVar);
  if P > 0 then
    Result := Copy(pVar, 1, P-1)
  else
    Result := pVar;
end;

function item(pCod: String; pDataSet : TDataSet) : String;
begin
  Result := '';
  with pDataSet do
    if Active or (FindField(pCod) <> nil) then
      Result := FieldByName(pCod).AsString;
end;

function itemB(pCod, pVar: String) : Boolean;
begin
  Result := IsStringTrue(item(pCod, pVar));
end;

function itemD(pCod, pVar: String) : TDateTime;
begin
  Result := StrToDateTimeDef(item(pCod, pVar), 0);
end;

function itemF(pCod, pVar: String) : Real;
var
  vResult : String;
begin
  vResult := item(pCod, pVar);
  vResult := AnsiReplaceStr(vResult, '.', '');
  Result := StrToFloatDef(vResult, 0);
end;

function itemI(pCod, pVar: String) : Integer;
var
  vResult : String;
begin
  vResult := item(pCod, pVar);
  vResult := AnsiReplaceStr(vResult, '.', '');
  Result := StrToIntDef(vResult, 0);
end;

//--

function tagIni(pVar : String) : String;
var
  P : Integer;
begin
  Result := '';

  P := Pos('=', pVar);
  if P = 0 then Exit;

  Result := Copy(pVar, 1, P-1); 
end;

//--

function listCd(pVar : String) : String;
var
  vCod : String;
begin
  Result := '';

  if Copy(pVar,1,1) = '<' then begin
    Result := listCdX(pVar);
    Exit;
  end;

  while pVar <> '' do begin
    vCod := tagIni(pVar);
    if vCod = '' then Break;
    delitem(vCod, pVar);
    putitem(Result, vCod);
  end;
end;

function listDs(pVar : String) : String;
var
  vCod, vVal : String;
begin
  Result := '';

  if Copy(pVar,1,1) = '<' then begin
    Result := listDsX(pVar);
    Exit;
  end;

  while pVar <> '' do begin
    vCod := tagIni(pVar);
    if vCod = '' then Break;
    vVal := item(vCod, pVar);
    delitem(vCod, pVar);
    putitem(Result, vVal);
  end;
end;

//--

function itemDs(pVal, pVar : String) : String;
var
  vCod, vVal : String;
begin
  Result := '';

  while pVar <> '' do begin
    vCod := tagIni(pVar);
    if vCod = '' then Break;
    vVal := item(vCod, pVar);
    delitem(vCod, pVar);

    if vVal = pVal then begin
      Result := vCod;
      Exit;
    end;
  end;
end;

//--

function getitem(pVar : String; pItem : Integer) : String;
begin
  Result := '';

  while pItem > 0 do begin
    Result := getitem(pVar);
    delitem(pVar);
    Dec(pItem);
  end;
end;

function getitem(pVar : String) : String;
var
  P : Integer;
begin
  Result := '';

  P := Pos('|', pVar);
  if P > 0 then
    Result := Copy(pVar, 1, P-1)
  else
    Result := pVar;
end;

//--

function getitemB(pVar : String) : Boolean;
begin
  Result := IsStringTrue(getitem(pVar));
end;

function getitemD(pVar : String) : TDateTime;
begin
  Result := StrToDateTimeDef(getitem(pVar), 0);
end;

function getitemF(pVar : String) : Real;
begin
  Result := StrToFloatDef(getitem(pVar), 0);
end;

function getitemI(pVar : String) : Integer;
begin
  Result := StrToIntDef(getitem(pVar), 0);
end;

//--

procedure delitem(var pVar : String);
var
  P : Integer;
begin
  P := Pos('|', pVar);
  if P > 0 then
    Delete(pVar, 1, P)
  else
    pVar := '';
end;

procedure delitem(pCod : String; var pVar : String);
var
  vVal, vRel : String;
begin
  vVal := item(pCod, pVar);
  vRel := pCod + '=' + vVal;
  if Pos(vRel + ';', pVar) > 0 then
    pVar := AnsiReplaceStr(pVar, vRel + ';', '')
  else if Pos(vRel, pVar) > 0 then
    pVar := AnsiReplaceStr(pVar, vRel, '');
end;

//--

procedure putitem(pDataSet : TDataSet; pCod: String; pVal: Variant); overload;
var
  vEdit : Boolean;
  vVal : String;
begin
  vVal := pVal;
  with pDataSet do begin
    if Active or (FindField(pCod) <> nil) then begin
      vEdit := not (State in [dsInsert, dsEdit]);
      if (vEdit) then Edit;
      FieldByName(pCod).AsString := vVal;
      if (vEdit) then Post;
    end;
  end;
end;

//--

function itemB(pCod: String; pDataSet : TDataSet) : Boolean;
begin
  Result := IsStringTrue(item(pCod, pDataSet));
end;

function itemD(pCod: String; pDataSet : TDataSet) : TDateTime;
begin
  Result := StrToDateTimeDef(item(pCod, pDataSet), 0);
end;

function itemF(pCod: String; pDataSet : TDataSet) : Real;
var
  vResult : String;
begin
  vResult := item(pCod, pDataSet);
  vResult := AnsiReplaceStr(vResult, '.', '');
  Result := StrToFloatDef(vResult, 0);
end;

function itemI(pCod: String; pDataSet : TDataSet) : Integer;
var
  vResult : String;
begin
  vResult := item(pCod, pDataSet);
  vResult := AnsiReplaceStr(vResult, '.', '');
  Result := StrToIntDef(vResult, 0);
end;

//--

procedure putlistitensocc(var pVar : String; pDataSet : TDataSet);
var
  I : Integer;
begin
  pVar := '';
  with pDataSet do
    for I:=0 to FieldCount-1 do
      with Fields[I] do
        putitem(pVar, FieldName, AsString);
end;

//--

procedure getlistitensocc(pVar : String; pDataSet : TDataSet; pAcao : TpAcao);
var
  vEdit : Boolean;
  I : Integer;
begin
  with pDataSet do begin
    vEdit := editDataSet(pDataSet, pAcao);

    for I:=0 to FieldCount-1 do
      with Fields[I] do
        if Pos(FieldName, pVar) > 0 then
          AsString := item(FieldName, pVar);

    postDataSet(pDataSet, pAcao, vEdit);
  end;
end;

//-- teste

function teste() : String;
const
  cLST_STR =
    '1=TESTE 1;' +
    '2=TESTE 2;' +
    '3=TESTE 3;' +
    '4=TESTE 4;' +
    '5=TESTE 5;' +
    '6=TESTE 6' ;
  cVAL_STR =
    'cod=1;' +
    'nom=TESTE;' +
    'dat=01/01/2014;' +
    'val=15,0;' +
    'ind=T' ;
var
  vLstCod, vLstVal : String;
begin
  vLstCod := listCd(cLST_STR);
  vLstVal := listDs(cLST_STR);
  vLstVal := vLstVal;

  vLstCod := listCd(cVAL_STR);
  vLstVal := listDs(cVAL_STR);
  vLstVal := item('1', cVAL_STR);
  vLstVal := vLstVal;

  vLstCod := cVAL_STR;
  delitem('cod', vLstCod);
  delitem('nom', vLstCod);
  vLstCod := vLstCod;

  vLstCod := '';
  putitem(vLstCod, 'cod', 1);
  putitem(vLstCod, 'nom', 'TESTE');
  putitem(vLstCod, 'dat', date);
  putitem(vLstCod, 'val', 10);
  putitem(vLstCod, 'bol', True);
  vLstCod := vLstCod;
  delitem('dat', vLstCod);
  vLstCod := item('nom', vLstCod);
  vLstCod := vLstCod;
end;

//--

initialization
  //teste();

//--
end.
