unit ucSELECT; // mSelect / mValue

{ gerar comandos select }

interface

uses
  Classes, SysUtils, StrUtils, TypInfo;

type
  TpSelect = (tpsCount, tpsDistinct, tpsField, tpsTodos, tpsProximo);

  TcSELECT = class
  public
    class function cmd(pEntidade, pMetadata, pValues : String; pParams : String = '') : String;
    class function tip(pTip : String) : TpSelect;
    class function str(pTip : TpSelect) : String;
  end;

  procedure AddSqlField(var pSql : String; pFld : String);
  procedure AddSqlFrom(var pSql : String; pFrm : String);
  procedure AddSqlWhere(var pSql : String; pWhr : String; pStr : String = 'and'; pIni : String = 'where');
  procedure AddSqlGroup(var pSql : String; pGrp : String);
  procedure AddSqlHaging(var pSql : String; pHvn : String);
  procedure AddSqlOrder(var pSql : String; pOrd : String);

  procedure RemSqlWhere(var pSql : String; pIni : String);

  function GetSqlDecode(pCod, pFld, pLstVal : String) : String;

implementation

{ TcSELECT }

{ gRelation = '<PES_PESSOA>' +
                '<relation siglapai="" campopai="" siglafil="" campofil="" />' +
                '<relation siglapai="" campopai="" siglafil="" campofil="" />' +
              '</PES_PESSOA>' }

uses
  //ucCONEXAO, ucPARAMINI, ucVALUE, ucLOGCONF,
  ucMETADATA, ucFUNCAO, ucITEM, ucXML;

const
  cSELECT = 'select /*DISTINCT*/ /*FIRST*/ /*COUNT*/ <FIELDS> from <ENTIDADE> ' +
            '/*WHERE*/ /*ROWNUM*/ /*GROUP*/ /*HAVIN*/ /*ORDER*/ /*LIMIT*/ ';

var
  gTpDatabase,
  gEntidade,
  gMetadata,
  gRelation,
  gLstTipo,
  gValues,
  gProximo : String;

  gTpSelect : TpSelect;

  gQtReg : Integer;

  class function TcSELECT.tip(pTip : String) : TpSelect;
  begin
    Result := TpSelect(GetEnumValue(TypeInfo(TpSelect), pTip));
  end;

  class function TcSELECT.str(pTip : TpSelect) : String;
  begin
    Result := GetEnumName(TypeInfo(TpSelect), Integer(pTip));
  end;

  procedure setParams(pEntidade, pMetadata, pValues, pParams: String);
  begin
    gTpDatabase := IfNullS(item('TIPO_DATABASE', pParams), LerIni('TP_DATABASE'));
    gTpSelect := TcSELECT.tip(item('TIPO_SELECT', pParams));
    gEntidade := pEntidade;
    gMetadata := pMetadata;
    gRelation := item('RELATION', pParams);
    gValues := pValues;
    gLstTipo := TcMETADATA.getMetadataXml(pMetadata, 'tip');
    gQtReg := IfNullI(item('QTDE_REG', pParams), -1);
    gProximo := item('PROXIMO', pParams);
  end;

  function getFiltro(pCpo, pVal : String) : String;
  begin
    Result := '';
    putitem(Result, 'TIPO_DATABASE', gTpDatabase);
    putitem(Result, 'CD_CAMPO', pCpo);
    putitem(Result, 'TP_DADO', item(pCpo, gLstTipo));
    putitem(Result, 'VL_CAMPO', pVal);
    //Result := TmValue.GetFiltro(Result);
  end;

  function getFields() : String;
  var
    vLstCod, vCod : String;
  begin
    Result := '';

    vLstCod := TcMETADATA.getMetadataXml(gMetadata, 'cod');

    if (gTpSelect = tpsCount) then begin
      Result := 'count(*) as TOTAL'; Exit;
    end else if (gTpSelect = tpsProximo) then begin
      Result := 'coalesce(max({COD}),0)+1 as {COD}';
      Result := ReplaceStr(Result, '{COD}', gProximo);
      Exit;
    end else if (gTpSelect = tpsTodos) or (vLstCod = '') then begin
      Result := '*'; Exit;
    end;

    while (vLstCod <> '') do begin
      vCod := getitem(vLstCod);
      if (vCod = '') then Break;
      delitem(vLstCod);

      Result := Result + IfThen(Result<>'',', ') + vCod;
    end;
  end;

  function getRelation(pEntidade : String) : String;
  var
    vLstRel, vRel : String;
  begin
    Result := '';

    { select pai.*, fil.*
      from TABELA_PAI pai inner join TABELA_FIL on (fil.CD_CAMPOFIL = pai.CAMPOPAI) }

    vLstRel := item(pEntidade, gRelation);

    while (vLstRel <> '') do begin
      vRel := getitem(vLstRel);
      if (vRel = '') then Break;
      delitem(vLstRel);

      Result := Result + IfThen(Result<>'','and ', 'on (') +
                         itemA('siglafil', vRel) + '.' + itemA('campofil', vRel) + ' = ' +
                         itemA('siglapai', vRel) + '.' + itemA('campopai', vRel) + ' ' +
                         IfThen(vLstRel = '', ') ');
    end;
  end;

  function getFrom(pEntidade : String) : String;
  var
    vLstEnt, vEnt, vRel : String;
  begin
    Result := '';

    vLstEnt := IfNullS(listCd(pEntidade), pEntidade);

    while (vLstEnt <> '') do begin
      vEnt := getitem(vLstEnt);
      if (vEnt = '') then Break;
      delitem(vLstEnt);

      vRel := getRelation(vEnt);

      Result := Result + IfThen(Result<>'','inner join ') + vEnt + IfThen(vRel<>'',' ') + vRel;
    end;
  end;

  function getWhere() : String;
  var
    vLstCod, vCod, vVal : String;
  begin
    Result := '';

    vLstCod := listCd(gValues);

    while (vLstCod <> '') do begin
      vCod := getitem(vLstCod);
      if (vCod = '') then Break;
      delitem(vLstCod);

      vVal := item(vCod, gValues);
      vVal := getFiltro(vCod, vVal);

      Result := Result + IfThen(Result<>'', 'and ', 'where ') + vVal + ' ';
    end;
  end;

  function getGroup() : String;
  var
    vLstGrp, vGrp : String;
  begin
    Result := '';

    vLstGrp := TcMETADATA.getMetadataXml(gMetadata, 'grp');
    
    while (vLstGrp <> '') do begin
      vGrp := getitem(vLstGrp);
      if (vGrp = '') then Break;
      delitem(vLstGrp);

      Result := Result + IfThen(Result<>'',', ', 'group by ') + vGrp;
    end;
  end;

  function getHavin() : String;
  var
    vLstHvn, vHvn : String;
  begin
    Result := '';

    vLstHvn := TcMETADATA.getMetadataXml(gMetadata, 'hvn');

    while (vLstHvn <> '') do begin
      vHvn := getitem(vLstHvn);
      if (vHvn = '') then Break;
      delitem(vLstHvn);

      Result := Result + IfThen(Result<>'',', ', 'having ') + vHvn;
    end;
  end;

  function getOrder() : String;
  var
    vLstOrd, vOrd : String;
  begin
    Result := '';

    vLstOrd := TcMETADATA.getMetadataXml(gMetadata, 'ord');

    while (vLstOrd <> '') do begin
      vOrd := getitem(vLstOrd);
      if (vOrd = '') then Break;
      delitem(vLstOrd);

      Result := Result + IfThen(Result<>'',', ', 'order by ') + vOrd;
    end;
  end;

  //--

  procedure AddSqlField(var pSql : String; pFld : String);
  begin
    pSql := pSql + IfThen(Pos('select ', pSql) > 0, ', ', 'select ') + pFld;
  end;

  procedure AddSqlFrom(var pSql : String; pFrm : String);
  begin
    pSql := pSql + IfThen(Pos('from ', pSql) > 0, ', ', 'from ') + pFrm;
  end;

  procedure AddSqlWhere(var pSql : String; pWhr, pStr, pIni : String);
  var
    vStr : String;
  begin
    if (pSql = '') and (pWhr = '') then
      Exit;

    vStr := IfThen(Pos(pIni, LowerCase(pSql)) > 0, pStr, pIni);
    pSql := pSql + ' ' + vStr + ' ' + pWhr + ' ';
  end;

  procedure AddSqlGroup(var pSql : String; pGrp : String);
  begin
    pSql := pSql + IfThen(Pos('group by ', pSql) > 0, ', ', 'group by ') + pGrp;
  end;

  procedure AddSqlHaging(var pSql : String; pHvn : String);
  begin
    pSql := pSql + IfThen(Pos('having ', pSql) > 0, ', ', 'having ') + pHvn;
  end;

  procedure AddSqlOrder(var pSql : String; pOrd : String);
  begin
    pSql := pSql + IfThen(Pos('order by', pSql) > 0, ', ', 'order by ') + pOrd;
  end;

  //--

  procedure RemSqlWhere(var pSql : String; pIni : String);
  var
    P : Integer;
  begin
    if (pSql = '') or (pIni = '') then
      Exit;

    P := Pos(pIni, pSql);
    if (P > 0) then
      Delete(pSql, P, Length(pIni));
  end;

  //--

  function GetSqlDecode(pCod, pFld, pLstVal : String) : String;
  const
    cDECODE = 'decode({cod}, {lst}) as {fld}';
  var
    vLstDec,
    vLstCod, vCod, vVal : String;
  begin
    Result := '';

    vLstCod := listCd(pLstVal);
    if vLstCod = '' then
      Exit;

    vLstDec := '';

    while (vLstCod <> '') do begin
      vCod := getitem(vLstCod);
      if (vCod = '') then Break;
      delitem(vLstCod);

      vVal := item(vCod, pLstVal);

      putitemD(vLstDec, ' ''' + vCod + ''', ''' + vVal + '''', ',');
    end;

    Result := cDECODE;
    Result := ReplaceStr(Result, '{cod}', pCod);
    Result := ReplaceStr(Result, '{lst}', vLstDec);
    Result := ReplaceStr(Result, '{fld}', pFld);
  end;

  //--

class function TcSELECT.cmd(pEntidade, pMetadata, pValues, pParams: String): String;
var
  vWhere : String;
begin
  setParams(pEntidade, pMetadata, pValues, pParams);

  vWhere := getWhere();

  Result := cSELECT;
  Result := ReplaceStr(Result, '<ENTIDADE>', getFrom(pEntidade));
  Result := ReplaceStr(Result, '<FIELDS>', getFields());
  Result := ReplaceStr(Result, '/*WHERE*/', vWhere);
  Result := ReplaceStr(Result, '/*GROUP*/', getGroup());
  Result := ReplaceStr(Result, '/*HAVIN*/', getHavin());
  Result := ReplaceStr(Result, '/*ORDER*/', getOrder());

  if (gTpSelect = tpsDistinct) then
    Result := ReplaceStr(Result, '/*DISTINCT*/', 'distinct');

  Result := ReplaceStr(Result, '/*DISTINCT*/', '');
  Result := ReplaceStr(Result, '/*COUNT*/', '');

  //----------------------------------------------------------------------------
  //Primeiro registro
  (* vParams := '';
  putitemX(vParams, 'TIPO_DATABASE', gTpDatabase);
  putitemX(vParams, 'QTDE_REG', gQtReg);
  putitemX(vParams, 'DS_SQL', Result);
  Result := TmConexao.GetSqlLimits(vParams); *)
  //----------------------------------------------------------------------------

  //TmLogConf.mensagem(tpGravarLogSql, 'pSql: ' + Result);
end;

end.
