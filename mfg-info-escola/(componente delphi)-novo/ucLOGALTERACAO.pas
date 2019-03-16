unit ucLOGALTERACAO;

interface

uses
  Classes, SysUtils, DBClient, DB, SqlExpr;

type
  TcLOGALTERACAO = class
  private
  public
    class procedure Gravar(C : TClientDataSet; cTabela, cLogAnterior : String); virtual;
    class procedure Consultar(C : TClientDataSet; cTabela : String); virtual;
  end;

implementation

uses
  ucPREVIEW_TXT, ucMETADATA, ucDADOS, ucMENU, ucFUNCAO, ucCONST, ucITEM, ucXML;

class procedure TcLOGALTERACAO.Gravar(C : TClientDataSet; cTabela, cLogAnterior : String);
var
  vCdChave, vLstKey, vSql, vDsLog, vAnt, vNov : String;
  vNrSeqLog, I : Integer;
begin
  vCdChave := TcMETADATA.getChaveKey(C);
  vLstKey := TcMETADATA.getCamposKey(C);
  vDsLog := '';

  with C do
    for I:=0 to FieldCount-1 do
      with Fields[I] do begin
        if Pos(FieldName, vLstKey + '|TP_SITUACAO') = 0 then begin
          if (cLogAnterior <> '') then begin
            vAnt := item(FieldName, cLogAnterior);
            vNov := AsString;
            if (vAnt <> vNov) then begin
              putitemD(vDsLog, 'C=' + IntToStr(I) + ';D=' + vAnt + ';P=' + vNov, '|');
            end;
          end;
        end;
      end;

  vNrSeqLog := IfNullI(dDADOS.f_ConsultaStrSql('select max(NR_SEQ) as ULTIMO from LOG_ENTIDADE ' +
                                               'where CD_ENTIDADE =''' + cTabela+''' ' +
                                               'and CD_CHAVE = ''' + vCdChave+''' ' +
                                               'and DT_LOG = ''' + FormatDateTime('yyyy/mm/dd',Date) + ''' ', 'ULTIMO'), 0) + 1;

  if (vDsLog = '') then vDsLog := 'INCLUSAO|';

  vSql := 'insert into LOG_ENTIDADE (CD_ENTIDADE,CD_CHAVE,DT_LOG,NR_SEQ,DS_LOG,NM_LOGIN,HR_LOG) ' +
          'values (''' + cTabela + ''',''' +
                         vCdChave + ''',''' +
                         FormatDateTime('yyyy/mm/dd',Date) + ''',' +
                         IntToStr(vNrSeqLog) + ',''' +
                         vDsLog + ''',''' +
                         dDADOS.gNmUsuario + ''',''' +
                         FormatDateTime('hh:nn:ss',Now) + ''' ) ';
  dDADOS.f_RunSQL(vSql);
end;

class procedure TcLOGALTERACAO.Consultar(C : TClientDataSet; cTabela : String);
var
  vCdChave, vCpo, vAnt, vNov, vLog,
  vDsReg, vDsLog, vNmLogin, vDtLog, vHrLog : String;
  MyStringList : TStringList;
  vSqlQuery : TSqlQuery;
  vPk : Boolean;
begin
  vCdChave := '';
  vDsLog := '';

  if C.IsEmpty then
    raise Exception.Create(cMESSAGE_NENHUMREGISTRO);

  vCdChave := TcMETADATA.getChaveKey(C);

  MyStringList := TStringList.Create;

  vSqlQuery := dDADOS.getQuery('select * from LOG_ENTIDADE ' +
                               'where CD_ENTIDADE = ''' + cTabela + ''' ' +
                               'and CD_CHAVE = ''' + vCdChave + ''' ' +
                               'order by CD_ENTIDADE, CD_CHAVE, NR_SEQ', True);
  with vSqlQuery do
  try
    if IsEmpty then
      raise Exception.Create(cMESSAGE_NENHUMREGISTRO);

    while not EOF do begin
      putlistitensoccX(vDsReg, vSqlQuery);
      vDtLog := itemX('DT_LOG', vDsReg);
      vNmLogin := itemX('NM_LOGIN', vDsReg);
      vHrLog := itemX('HR_LOG', vDsReg);
      vDsLog := itemX('DS_LOG', vDsReg);

      vCpo := item('C', vDsLog);
      if (vCpo = '') then begin
        MyStringList.Add('Data: ' + vDtLog + ' / Hora: ' + vHrLog + ' / Login: ' + vNmLogin + ' / Log: INCLUSAO' );
      end else begin
        MyStringList.Add('Data: ' + vDtLog + ' / Hora: ' + vHrLog + ' / Login: ' + vNmLogin);
        while vDsLog <> '' do begin
          vLog := getitem(vDsLog);
          if vLog = '' then Break;
          delitem(vDsLog);

          vCpo := item('C', vLog);
          vCpo := C.Fields[StrToIntDef(vCpo,0)].FieldName;
          vAnt := item('D', vLog);
          vNov := item('P', vLog);

          MyStringList.Add('Campo ' + vCpo + ' alterado de: ' + vAnt + ' para: ' + vNov);
        end;
      end;

      Next;
    end;
  finally
    Free;
  end;

  TcPREVIEW_TXT.VisualizarTxt(MyStringList);

  MyStringList.Free;
end;

end.