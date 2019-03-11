unit ucMETADATA; // mMetadata / mCampo

interface

uses
  Classes, SysUtils, StrUtils, DB, DBClient, TypInfo, Math;

{
<DATABASE></DATABASE>
<METADATA>
<field cod="CD_TESTE" des="CD_TESTE" tpf="key" tpd="ftInteger" tam="0" dec="0" lst="" ent="" entcod="" entdes="" entwhr="" enttam="" dis="" vis="" def="" />
<field cod="DS_TESTE" des="DS_TESTE" tpf="req" tpd="ftString" tam="60" dec="0" />
</METADATA>
<ENTIDADE cd="PESSOA" ds="PESSOA" cod="CD_PESSOA" des="NM_PESSOA" whr="" tam="60" />
<CONTEUDO>
<reg CD_TESTE="1" DS_TESTE="TESTE=;" />
<reg CD_TESTE="1" DS_TESTE="TESTE=;" />
</CONTEUDO>
<VALIDACAO>8745786018A4CD4ABE95BAC3949A4BDF</VALIDACAO>
}

type
  TpFormato = (tpfAut, tpfMet);

  TcMETADATA = class
  public
    class procedure corrigir(pDataSet : TDataSet);

    class function pegar(pDataSet : TDataSet) : String;
    class procedure setar(pDataSet : TDataSet; pMetadata : String);

    //class function getMetadata(pParams: String): String;
    class function getMetadataEnt(pDataSet : TDataSet) : String;
    class function getMetadataXml(pMetadata, pOpcao : String; pFormato : TpFormato = tpfAut) : String;
    class function getMetadataTab(pMetadata : String) : String;

    class function IsTpAlfa(pTip : String) : Boolean;
    class function IsTpDate(pTip : String) : Boolean;
    class function IsTpNumber(pTip : String) : Boolean;
    class function IsTpBool(pTip : String) : Boolean;

    class function IsValBool(pVal : String) : Boolean;
    class function IsValDate(pVal : String) : Boolean;
    class function IsValNumber(pVal : String) : Boolean;

    class function getCamposCod(pDataSet : TDataSet) : String;
    class function getCamposDes(pDataSet : TDataSet) : String;
    class function getCamposTam(pDataSet : TDataSet) : String;
    class function getCamposDec(pDataSet : TDataSet) : String;
    class function getCamposKey(pDataSet : TDataSet) : String;
    class function getCamposReq(pDataSet : TDataSet) : String;

    class function getValueKey(pDataSet : TDataSet) : String;
    class function getChaveKey(pDataSet : TDataSet) : String;
  end;

  //TFieldType
  TcFieldType = class
  public
    class function tip(pTip : String) : TFieldType;
    class function str(pTip : TFieldType) : String;
  end;

implementation

uses
  ucARQUIVO, ucSTRING, ucFUNCAO, ucITEM, ucXML, ucCAMPO;

const
  cTIPOFIELD = 'key|req|nul|';

  cTIPODADO = 'A=Alfa;B=Boolean;C=Caracter;D=Data;DH=DataHora;H=Hora;I=Imagem;M=Memo;N=Numero;T=Texto;';

  cFIELD = '<field cod="@cod" des="@des" tpf="@tpf" tpd="@tpd" tam="@tam" dec="@dec" />';

  //TFieldType
  class function TcFieldType.tip(pTip : String) : TFieldType;
  begin
    Result := TFieldType(GetEnumValue(TypeInfo(TFieldType), pTip));
  end;

  class function TcFieldType.str(pTip : TFieldType) : String;
  begin
    Result := GetEnumName(TypeInfo(TFieldType), Ord(pTip));
  end;

{ TcMETADATA }

class procedure TcMETADATA.corrigir(pDataSet : TDataSet);
var
  vCod, vTpd : String;
  I : Integer;
begin
  // metadata
  with pDataSet do begin
    for I:=0 to FieldCount-1 do begin
      with Fields[I] do begin
        vCod := FieldName;
        DisplayLabel := PriMaiuscula(FieldName);
        vTpd := TcFieldType.str(DataType);
        Tag := 0;

        if I=0 then begin
          ProviderFlags := ProviderFlags + [pfInKey];
        end;  

        if TcMETADATA.IsTpNumber(vTpd) then begin
          if startsWiths(vCod, 'Q') then begin
            DisplayWidth := 8; Tag := 3;
          end else if startsWiths(vCod, 'V') then begin
            DisplayWidth := 15; Tag := 2;
          end;
        end;

      end;
    end;
  end;
end;

class function TcMETADATA.pegar(pDataSet: TDataSet): String;
var
  vField, vCod, vDes, vTpF, vTpD : String;
  vTam, vDec, I : Integer;
begin
  Result := '';

  if (pDataSet = nil) then Exit;

  with pDataSet do begin
    for I:=0 to FieldCount-1 do begin
      with Fields[I] do begin
        vCod := FieldName;
        vDes := DisplayLabel;
        vTpF := IfThen(pfInKey in ProviderFlags, 'key',
                IfThen(Required, 'req', 'nul'));
        vTpD := TcFieldType.str(DataType);
        vTam := IfThen(Size > 0, Size, DisplayWidth);
        vDec := Tag;
      end;

      vField := cFIELD;
      vField := ReplaceStr(vField, '@cod', vCod);
      vField := ReplaceStr(vField, '@des', vDes);
      vField := ReplaceStr(vField, '@tpf', vTpF);
      vField := ReplaceStr(vField, '@tpd', vTpD);
      vField := ReplaceStr(vField, '@tam', vTam);
      vField := ReplaceStr(vField, '@dec', vDec);

      Result := Result + vField;
    end;
  end;

  Result := Result;
end;

class procedure TcMETADATA.setar(pDataSet: TDataSet; pMetadata: String);
var
  vLstKey, vLstDes,
  vField, vCod, vDes,
  vTpF, vTpD, vTam, vDec : String;
  vFieldType : TFieldType;
  I, iTam : Integer;
begin
  if (pDataSet = nil) then Exit;

  with TClientDataSet(pDataSet) do begin
    if (FieldCount > 0) then begin
      CreateDataSet();
      Exit;
    end;

    FieldDefs.Clear();

    vLstKey := TcMETADATA.getMetadataXml(pMetadata, 'key');
    vLstDes := '';

    while pMetadata <> '' do begin
      vField := itemX('field', pMetadata);
      if vField = '' then Break;
      delitemX('field', pMetadata);

      vCod := itemA('cod', vField);
      vDes := itemA('des', vField);
      vTpF := itemA('tpf', vField);
      vTpD := itemA('tpd', vField);
      vTam := itemA('tam', vField);
      vDec := itemA('dec', vField);

      if (Copy(vCod, 1, 3) = 'IN_') then begin
        vTpD := 'ftString';
      end else if (vTpD = 'ftChar') then begin
        vTpD := 'ftString';
      end;

      vFieldType := TcFieldType.tip(vTpD);

      putitem(vLstDes, vCod, vDes);

      iTam := IfThen(vFieldType in [ftString, ftWideString], StrToIntDef(vTam, 0), 0);

      FieldDefs.Add(vCod, vFieldType, iTam, (vTpF = 'req'));
    end;

    if (FieldDefs.Count > 0) then begin
      CreateDataSet();
    end;

    for I := 0 to FieldCount-1 do begin
      with Fields[I] do begin
        if (Pos(FieldName, vLstKey) > 0) then begin
          ProviderFlags := [pfInKey];
        end;
      end;
    end;
  end;
end;

(* class function TcMETADATA.getMetadata(pParams: String): String;
var
  vEntidade, vConteudo : String;
begin
  Result := '';

  vEntidade := item('CD_ENTIDADE', pParams);
  if (vEntidade = '') then Exit;

  vConteudo := TmArquivoCripto.carregarDados(vEntidade + '.xml');
  if (vConteudo = '') then Exit;

  // arquivo xml
  Result := item('METADATA', vConteudo);
  if (Result <> '') then Exit;

  // entidade no banco de dados
end; *)

class function TcMETADATA.getMetadataEnt(pDataSet : TDataSet) : String;
var
  vLstXml, vXml,
  vCod, vDes, vTpf, vTpd : String;
  vTam, vDec, I : Integer;
  vKey : Boolean;
begin
  Result := '';

  vLstXml := '';

  vKey := True;
  with pDataSet do begin
    for I:=0 to FieldCount-1 do begin
      with Fields[I] do begin
        if Pos(FieldName, 'TP_SITUACAO') > 0 then
          vKey := False;

        vCod := FieldName;
        vDes := CampoDes(vCod);
        vTpf := IfThen(vKey, 'key', IfThen(Required, 'req', 'nul'));
        vTpd := TcFieldType.str(DataType);
        vTam := DisplayWidth; // CampoTam(vCod);
        vDec := CampoDec(vCod);

        vXml := '';
        putitemA(vXml, 'field', 'cod', vCod);
        putitemA(vXml, 'field', 'des', vDes);
        putitemA(vXml, 'field', 'tpf', vTpf);
        putitemA(vXml, 'field', 'tpd', vTpd);
        putitemA(vXml, 'field', 'tam', vTam);
        putitemA(vXml, 'field', 'dec', vDec);
        putitemD(vLstXml, vXml);
      end;
    end;
  end;

  putitemX(Result, 'fields', vLstXml);
end;

class function TcMETADATA.getMetadataXml(pMetadata, pOpcao : String; pFormato : TpFormato) : String;
var
  vClc, vWhr, vGrp, vHvn, vOrd, vVis, vFld, vNeg, vPwd, vEdt : Boolean;
  vCod, vDes, vTpd, vFun, vXml, vTag, vTpf, vLst, vDef, vInc, vDna, vFor, vTot : String;
  vTam, vDec, vDis : Real;
begin
  Result := '';

  if (pMetadata = '') then Exit;

  //<field cod="DS_DOCUMENTO" des="Tp. docto" tpd="A" tpf="nul" tam="15" dec="0" clc="T" fun="" whr="F" grp="F" hvn="F" ord="F" vis="T" />' +

  while pMetadata <> '' do begin
    vXml := itemX('field', pMetadata);
    if vXml = '' then Break;
    delitemX('field', pMetadata);

    vCod := itemA('cod', vXml);

    if (pOpcao = 'cod') then begin // codigo
      if (pFormato = tpfMet) then begin
        vTam := itemAF('tam', vXml);
        vDec := itemAF('dec', vXml);
        putitem(Result, vCod + ':' + vTpd + '(' + FloatToStr(vTam) + IfThen(vDec>0, ':' + FloatToStr(vDec)) + ')');
      end else begin
        putitem(Result, vCod);
      end;

    end else if (pOpcao = 'des') then begin // descricao
      vDes := itemA('des', vXml);
      putitem(Result, vCod, vDes);

    end else if (pOpcao = 'tip') then begin // tipo dado
      vTpd := itemA('tpd', vXml);
      putitem(Result, vCod, vTpd);
    end else if (pOpcao = 'tam') then begin // tamanho
      vTam := itemAF('tam', vXml);
      putitem(Result, vCod, vTam);
    end else if (pOpcao = 'dec') then begin // decimail
      vDec := itemAF('dec', vXml);
      if (vDec > 0) then putitem(Result, vCod, vDec);
    end else if (pOpcao = 'dis') then begin // display
      vTam := itemAF('tam', vXml);
      vDis := IfNullF(itemA('dis', vXml), vTam);
      putitem(Result, vCod, vDis);

    end else if (pOpcao = 'clc') then begin // calculado
      vClc := itemAB('clc', vXml);
      if (vClc) then begin
        vTam := itemAF('tam', vXml);
        vDec := itemAF('dec', vXml);
        putitem(Result, vCod + ':' + vTpd + '(' + FloatToStr(vTam) + IfThen(vDec>0, ':' + FloatToStr(vDec)) + ')');
      end;

    end else if (pOpcao = 'for') then begin // formula
      vFor := itemA('for', vXml);
      if (vFor <> '') then putitemX(Result, vCod, vFor);

    end else if (pOpcao = 'vis') then begin // visible
      vVis := itemAB('vis', vXml);
      if (vVis) then putitem(Result, vCod);

    end else if (pOpcao = 'edt') then begin // editavel
      vEdt := itemAB('edt', vXml);
      if (vEdt) then putitemD(Result, vCod, '|');

    end else if (pOpcao = 'fld') then begin // field
      vFld := itemAB('fld', vXml);
      if (vFld) then putitem(Result, vCod);
    end else if (pOpcao = 'fun') then begin // funct
      vFun := itemA('fun', vXml);
      if (vFun <> '') then putitem(Result, vCod, vFun);
    end else if (pOpcao = 'whr') then begin // where
      vWhr := itemAB('whr', vXml);
      if (vWhr) then putitem(Result, vCod);
    end else if (pOpcao = 'grp') then begin // group
      vGrp := itemAB('grp', vXml);
      if (vGrp) then putitem(Result, vCod);
    end else if (pOpcao = 'hvn') then begin // havin
      vHvn := itemAB('hvn', vXml);
      if (vHvn) then putitem(Result, vCod);
    end else if (pOpcao = 'ord') then begin // order
      vOrd := itemAB('ord', vXml);
      if (vOrd) then putitem(Result, vCod);

    end else if (pOpcao = 'tag') then begin // tag
      vTag := itemA('tag', vXml);
      if (vTag <> '') then putitem(Result, vCod, vTag);

    end else if (pOpcao = 'lst') then begin // lista
      vLst := itemA('lst', vXml);
      if (vLst <> '') then putitemX(Result, vCod, vLst);

    end else if (pOpcao = 'def') then begin // default
      vDef := itemA('def', vXml);
      if (vDef <> '') then putitemX(Result, vCod, vDef);

    end else if (pOpcao = 'inc') then begin // incremento
      vInc := itemA('inc', vXml);
      if (vInc <> '') then putitemX(Result, vCod, vInc);

    end else if (pOpcao = 'neg') then begin // valor permite negativo
      vNeg := itemAB('neg', vXml);
      if (vNeg) then putitem(Result, vCod);

    end else if (Pos(pOpcao, 'key|req|nul|') > 0) then begin // key / req / nul
      vTpf := itemA('tpf', vXml);
      if (vTpf = pOpcao) then putitem(Result, vCod);

    end else if (pOpcao = 'pwd') then begin // password
      vPwd := itemAB('pwd', vXml);
      if (vPwd) then putitem(Result, vCod);

    end else if (pOpcao = 'dna') then begin // dna (campo composto)
      vDna := itemA('dna', vXml);
      if (vDna <> '') then putitemX(Result, vCod, vDna);

    end else if (pOpcao = 'dat') then begin // tipo dado data
      vTpd := itemA('tpd', vXml);
      if IsTpDate(vTpd) then putitem(Result, vCod);
    end else if (pOpcao = 'num') then begin // tipo dado numero
      vTpd := itemA('tpd', vXml);
      if IsTpNumber(vTpd) then putitem(Result, vCod);

    end else if (pOpcao = 'tot') then begin // totalizador
      vTot := itemA('tot', vXml);
      if (vTot <> '') then putitem(Result, vCod, vTot);

    end;

  end;

  Result := Result;
end;

class function TcMETADATA.getMetadataTab(pMetadata : String) : String;
var
  vXml, vCod, vTpf, vCol : String;
  vKey, vCpo : Integer;
begin
  Result := '';

  if (pMetadata = '') then Exit;

  vKey := 0;
  vCpo := 0;

  while pMetadata <> '' do begin
    vXml := itemX('field', pMetadata);
    if vXml = '' then Break;
    delitemX('field', pMetadata);

    vCod := itemA('cod', vXml);
    vTpf := itemA('tpf', vXml);

    if (vTpf = 'key') then begin
      Inc(vKey);
      vCol := 'K' + FormatFloat('000', vKey);
    end else begin
      Inc(vCpo);
      vCol := 'C' + FormatFloat('000', vCpo);
    end;

    putitem(Result, vCol, vCpo);
  end;

  Result := Result;
end;

//--

class function TcMETADATA.IsTpAlfa(pTip : String) : Boolean;
begin
  Result := (TcFieldType.tip(pTip) in [ftString, ftWideString]);
end;

class function TcMETADATA.IsTpDate(pTip : String) : Boolean;
begin
  Result := (TcFieldType.tip(pTip) in [ftDate, ftDateTime, ftTime, ftTimeStamp]);
end;

class function TcMETADATA.IsTpNumber(pTip : String) : Boolean;
begin
  Result := (TcFieldType.tip(pTip) in [ftBCD, ftFloat, ftFmtMemo, ftCurrency, ftSmallint, ftInteger]);
end;

class function TcMETADATA.IsTpBool(pTip : String) : Boolean;
begin
  Result := (TcFieldType.tip(pTip) in [ftBoolean]);
end;

//--

class function TcMETADATA.IsValBool(pVal : String) : Boolean;
begin
  Result := StrToBoolDef(pVal, False);
end;

class function TcMETADATA.IsValDate(pVal : String) : Boolean;
begin
  Result := (StrToDateTimeDef(pVal, -1) <> -1);
end;

class function TcMETADATA.IsValNumber(pVal : String) : Boolean;
begin
  Result := (StrToFloatDef(pVal, -1) <> -1);
end;

//--

class function TcMETADATA.getCamposCod(pDataSet: TDataSet): String;
var
  I : Integer;
begin
  Result := '';

  with pDataSet do
    for I:=0 to FieldCount-1 do
      with Fields[I] do
        putitemD(Result, FieldName, '|');
end;

class function TcMETADATA.getCamposDes(pDataSet: TDataSet): String;
var
  I : Integer;
begin
  Result := '';

  with pDataSet do
    for I:=0 to FieldCount-1 do
      with Fields[I] do
        putitem(Result, FieldName, CampoDes(FieldName));
end;

class function TcMETADATA.getCamposTam(pDataSet : TDataSet) : String;
var
  I : Integer;
begin
  Result := '';

  with pDataSet do
    for I:=0 to FieldCount-1 do
      with Fields[I] do
        putitem(Result, FieldName, CampoTam(FieldName));
end;

class function TcMETADATA.getCamposDec(pDataSet : TDataSet) : String;
var
  I : Integer;
begin
  Result := '';

  with pDataSet do
    for I:=0 to FieldCount-1 do
      with Fields[I] do
        putitem(Result, FieldName, CampoDec(FieldName));
end;

class function TcMETADATA.getCamposKey(pDataSet: TDataSet): String;
var
  vKey : Boolean;
  I : Integer;
begin
  Result := '';

  vKey := True;
  with pDataSet do
    for I:=0 to FieldCount-1 do
      with Fields[I] do begin
        if Pos(FieldName, 'TP_SITUACAO') > 0 then vKey := False;
        if (vKey) then begin
          putitemD(Result, FieldName, '|');
        end;
      end;
end;

class function TcMETADATA.getCamposReq(pDataSet: TDataSet): String;
var
  I : Integer;
begin
  Result := '';

  with pDataSet do
    for I:=0 to FieldCount-1 do
      with Fields[I] do
        if Required then
          putitemD(Result, FieldName, '|');
end;

//--

class function TcMETADATA.getValueKey(pDataSet : TDataSet) : String;
var
  vLstKey, vKey : String;
begin
  Result := '';

  vLstKey := getCamposKey(pDataSet);
  while vLstKey <> '' do begin
    vKey := getitem(vLstKey);
    if vKey = '' then Break;
    delitem(vLstKey);
    putitemX(Result, vKey, item(vKey, pDataSet));
  end;
end;

class function TcMETADATA.getChaveKey(pDataSet : TDataSet) : String;
var
  vLstKey, vKey : String;
begin
  Result := '';

  vLstKey := getCamposKey(pDataSet);
  while vLstKey <> '' do begin
    vKey := getitem(vLstKey);
    if vKey = '' then Break;
    delitem(vLstKey);
    putitemD(Result, item(vKey, pDataSet), '#');
  end;
end;

//--

end.
