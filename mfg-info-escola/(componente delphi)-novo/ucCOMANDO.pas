unit ucCOMANDO; // mComando

{ gerar comando DML (insert, update, delete) }

interface

uses
  Classes, SysUtils, StrUtils;

type
  TmComando = class
  public
    class function getExistsCmd(pEntidade, pMetadata, pValues : String; pParams : String = '') : String;
    class function getFuncaoCmd(pEntidade, pMetadata, pValues, pParams: String): String;
    class function getInsertCmd(pEntidade, pMetadata, pValues : String; pParams : String = '') : String;
    class function getUpdateCmd(pEntidade, pMetadata, pValues : String; pParams : String = '') : String;
    class function getDeleteCmd(pEntidade, pMetadata, pValues : String; pParams : String = '') : String;
  end;

implementation

uses
  // ucPARAMINI, ucVALUE, ucLOGCONF,
  ucMETADATA, ucFUNCAO, ucITEM;

const
  cEXISTS = 'select count(*) as TOTAL from <ENTIDADE> /*WHERE*/ ';
  cFUNCAO = 'select <FUNCAO> from <ENTIDADE> /*WHERE*/ ';
  cINSERT = 'insert into <ENTIDADE> (<FIELDS>) values (<VALUES>) ';
  cUPDATE = 'update <ENTIDADE> set <CAMPOS> /*WHERE*/ ';
  cDELETE = 'delete from <ENTIDADE> /*WHERE*/ ';

var
  gTpDatabase,
  gEntidade,
  gMetadata,
  gLstTip,
  gValues : String;

  gInUpdateDb,
  gInWhereVal : Boolean;

  procedure setParams(pEntidade, pMetadata, pValues, pParams: String);
  begin
    gTpDatabase := IfNullS(item('TIPO_DATABASE', pParams), LerIni('TP_DATABASE'));
    gEntidade := pEntidade;
    gMetadata := pMetadata;
    gValues := pValues;
    gLstTip := TcMETADATA.getMetadataXml(pMetadata, 'tip');
    gInUpdateDb := itemB('IN_UPDATEDB', pParams);
    gInWhereVal := itemB('IN_WHEREVAL', pParams); // TmDataSet.SelectFun()
  end;

  function getFiltro(pCpo, pVal : String) : String;
  begin
    Result := '';
    putitem(Result, 'TIPO_DATABASE', gTpDatabase);
    putitem(Result, 'CD_CAMPO', pCpo);
    putitem(Result, 'TP_DADO', item(pCpo, gLstTip));
    putitem(Result, 'VL_CAMPO', pVal);
    //Result := TmValue.GetFiltro(Result);
  end;

  function getValue(pCpo, pVal : String) : String;
  begin
    Result := '';
    putitem(Result, 'TIPO_DATABASE', gTpDatabase);
    putitem(Result, 'CD_CAMPO', pCpo);
    putitem(Result, 'TP_DADO', item(pCpo, gLstTip));
    putitem(Result, 'VL_CAMPO', pVal);
    //Result := TmValue.GetValue(Result);
  end;

  // insert
  function getFields() : String;
  var
    vLstCod, vCod : String;
  begin
    Result := '';

    vLstCod := listCd(gValues);
    if (vLstCod = '') then Exit;

    repeat
      vCod := getitem(vLstCod);
      delitem(vLstCod);
      Result := Result + IfThen(Result<>'',', ') + vCod;
    until (vLstCod = '');
  end;

  // insert
  function getValues() : String;
  var
    vLstCod, vCod, vVal : String;
  begin
    Result := '';

    vLstCod := listCd(gValues);
    if (vLstCod = '') then Exit;

    repeat
      vCod := getitem(vLstCod);
      delitem(vLstCod);
      vVal := item(vCod, gValues);
      vVal := getValue(vCod, vVal);
      Result := Result + IfThen(Result<>'',', ') + vVal;
    until (vLstCod = '');
  end;

  // exists / update / delete
  function getWhere() : String;
  var
    vLstKey,
    vLstCod, vCod, vVal : String;
  begin
    Result := '';

    vLstCod := listCd(gValues);
    if (vLstCod = '') then Exit;

    vLstKey := IfThen(gInWhereVal, vLstCod, TcMETADATA.getMetadataXml(gMetadata, 'key'));

    repeat
      vCod := getitem(vLstCod);
      delitem(vLstCod);
      vVal := item(vCod, gValues);
      if (Pos(vCod, vLstKey) > 0) then begin
        vVal := getFiltro(vCod, vVal);
        Result := Result + IfThen(Result<>'','and ', 'where /*WHERE*/ ') + vVal + ' ';
      end;
    until (vLstCod = '');
  end;

  // update
  function getCampos() : String;
  var
    vLstKey,
    vLstCod, vCod, vVal : String;
  begin
    Result := '';

    vLstCod := listCd(gValues);
    if (vLstCod = '') then Exit;

    vLstKey := TcMETADATA.getMetadataXml(gMetadata, 'key');

    repeat
      vCod := getitem(vLstCod);
      delitem(vLstCod);
      if (Pos(vCod, vLstKey) = 0) then begin
        vVal := item(vCod, gValues);
        if (gInUpdateDb = False) then begin
          vVal := getValue(vCod, vVal);
        end;
        Result := Result + IfThen(Result<>'',', ') + vCod + '=' + vVal + ' ';
      end;
    until (vLstCod = '');
  end;

  // funcao
  function getFuncao(pParams : String) : String;
  var
    vLstFun, vFun, vVal : String;
  begin
    vLstFun := listCd(pParams);
    if (vLstFun = '') then Exit;

    repeat
      vFun := getitem(vLstFun);
      delitem(vLstFun);
      vVal := item(vFun, pParams);
      Result := Result + IfThen(Result<>'',', ') + vVal + ' as ' + vFun + ' ';
    until (vLstFun = '');
  end;

{ TmComando }

class function TmComando.getExistsCmd(pEntidade, pMetadata, pValues, pParams: String): String;
begin
  setParams(pEntidade, pMetadata, pValues, pParams);

  Result := cEXISTS;
  Result := ReplaceStr(Result, '<ENTIDADE>', pEntidade);
  Result := ReplaceStr(Result, '/*WHERE*/', getWhere());

  //TmLogConf.mensagem(tpGravarLogSql, 'pSql: ' + Result);
end;

class function TmComando.getFuncaoCmd(pEntidade, pMetadata, pValues, pParams: String): String;
begin
  setParams(pEntidade, pMetadata, pValues, pParams);

  gInWhereVal := True;

  Result := cFUNCAO;
  Result := ReplaceStr(Result, '<ENTIDADE>', pEntidade);
  Result := ReplaceStr(Result, '<FUNCAO>', getFuncao(pParams));
  Result := ReplaceStr(Result, '/*WHERE*/', getWhere());

  //TmLogConf.mensagem(tpGravarLogSql, 'pSql: ' + Result);
end;

class function TmComando.getInsertCmd(pEntidade, pMetadata, pValues, pParams: String): String;
begin
  setParams(pEntidade, pMetadata, pValues, pParams);

  Result := cINSERT;
  Result := ReplaceStr(Result, '<ENTIDADE>', pEntidade);
  Result := ReplaceStr(Result, '<FIELDS>', getFields());
  Result := ReplaceStr(Result, '<VALUES>', getValues());

  //TmLogConf.mensagem(tpGravarLogSql, 'pSql: ' + Result);
end;

class function TmComando.getUpdateCmd(pEntidade, pMetadata, pValues, pParams: String): String;
begin
  setParams(pEntidade, pMetadata, pValues, pParams);

  Result := cUPDATE;
  Result := ReplaceStr(Result, '<ENTIDADE>', pEntidade);
  Result := ReplaceStr(Result, '<CAMPOS>', GetCampos());
  Result := ReplaceStr(Result, '/*WHERE*/', getWhere());

  //TmLogConf.mensagem(tpGravarLogSql, 'pSql: ' + Result);
end;

class function TmComando.getDeleteCmd(pEntidade, pMetadata, pValues, pParams: String): String;
begin
  setParams(pEntidade, pMetadata, pValues, pParams);

  Result := cDELETE;
  Result := ReplaceStr(Result, '<ENTIDADE>', pEntidade);
  Result := ReplaceStr(Result, '/*WHERE*/', getWhere());

  //TmLogConf.mensagem(tpGravarLogSql, 'pSql: ' + Result);
end;

end.
