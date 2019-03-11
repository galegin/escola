unit ucCAMPO; // mCampo;

interface

uses
  SysUtils;

  function CampoDes(pParams : String) : String;  // TraduzCampo
  function CampoTam(pParams : String) : Integer; // TamanhoCampo
  function CampoDec(pParams : String) : Integer; // TamanhoCampoDec
  function CampoTip(pParams : String) : String;  // TipoCampo
  function CampoAtr(pParams : String) : String;

implementation

uses
  ucSTRING, ucFUNCAO, ucITEM, ucXML;

const
  cLST_TIPO =
    '<CD des="Cod." tpd="ftInteger"  tam="10" dec="0" />' +  // COD_
    '<DS des="Ds."  tpd="ftString"   tam="60" dec="0" />' +  // DESCR_
    '<DT des="Dt."  tpd="ftDate"     tam="10" dec="0" />' +  // DATA_
    '<DH des="Dh."  tpd="ftDateTime" tam="10" dec="0" />' +  // DATAHORA_
    '<HR des="Hr."  tpd="ftTime"     tam="10" dec="0" />' +  // HORA_
    '<IN des=""     tpd="ftChar"     tam="01" dec="0" />' +  // INDICA_
    '<KM des="Km."  tpd="ftFloat"    tam="10" dec="0" />' +  // KILOM_
    '<NM des="Nome" tpd="ftString"   tam="60" dec="0" />' +  // NOME_
    '<NR des="Nr."  tpd="ftFloat"    tam="10" dec="0" />' +  // NUMERO_
    '<PR des="Pr."  tpd="ftFloat"    tam="10" dec="3" />' +  // PERC_
    '<QT des="Qt."  tpd="ftFloat"    tam="10" dec="3" />' +  // QTDE_
    '<TP des="Tp."  tpd="ftInteger"  tam="10" dec="0" />' +  // TIPO_
    '<VL des="Vl."  tpd="ftFloat"    tam="15" dec="2" />' +  // VALOR_
    '<U  des=""     tpd="ftChar"     tam="01" dec="0" />' ;  // VERSION_

  function PriMaiuscula(S : String) : String;
  var
    I : Integer;
  begin
    Result := '';
    if (S = '') then Exit;
    for I:=1 to Length(S) do begin
      if (I = 1)
      or (Copy(S, I-1, 1) = ' ')
      or (Copy(S, I-1, 1) = '.') then
        Result := Result + UpperCase(Copy(S,I,1))
      else
        Result := Result + LowerCase(Copy(S,I,1));
    end;
  end;

function CampoDes(pParams : String) : String;
var
  vCampo, vConf, vPre, vDes : String;
begin
  Result := '';

  vCampo := IfNullS(item('CD_CAMPO', pParams), pParams);
  if (vCampo = '') then Exit;

  vPre := GetLeftStr(vCampo, '_');
  vConf := itemX(vPre, cLST_TIPO);
  vDes := itemA('des', vConf);

  Result := vCampo;
  Result := ReplaceStr(Result, vPre + '_', vDes + ' ');
  Result := ReplaceStr(Result, '_', ' ');
  Result := AllTrim(Result);

  if itemB('IN_MAIUSCULA', pParams) then begin
    Result := UpperCase(Result);
  end else if itemB('IN_MINUSCULA', pParams) then begin
    Result := LowerCase(Result);
  end else begin
    Result := PriMaiuscula(Result);
  end;

  Result := ReplaceStr(Result, 'cao', 'ção');
  Result := ReplaceStr(Result, 'CAO', 'ÇÃO');

  if itemB('IN_RETESPACO', pParams) then begin
    Result := ReplaceStr(Result, ' ', '');
  end;
end;

function CampoTam(pParams : String) : Integer;
var
  vCampo, vConf, vPre : String;
begin
  Result := 0;

  vCampo := IfNullS(item('CD_CAMPO',pParams), pParams);
  if (vCampo = '') then Exit;

  vPre := GetLeftStr(vCampo, '_');
  vConf := itemX(vPre, cLST_TIPO);
  Result := StrToIntDef(itemA('tam', vConf), 10);
end;

function CampoDec(pParams : String) : Integer;
var
  vCampo, vConf, vPre : String;
begin
  Result := 0;

  vCampo := IfNullS(item('CD_CAMPO', pParams), pParams);
  if (vCampo = '') then Exit;

  vPre := GetLeftStr(vCampo, '_');
  vConf := itemX(vPre, cLST_TIPO);
  Result := StrToIntDef(itemA('dec', vConf), 0);
end;

function CampoTip(pParams : String) : String;
var
  vCampo, vConf, vPre : String;
begin
  Result := '';

  vCampo := IfNullS(item('CD_CAMPO', pParams), pParams);
  if (vCampo = '') then Exit;

  vPre := GetLeftStr(vCampo, '_');
  vConf := itemX(vPre, cLST_TIPO);
  Result := IfNullS(itemA('tpd', vConf), 'ftString');
end;

function CampoAtr(pParams : String) : String;
var
  vCampo, vConf, vPre, vCod : String;
begin
  Result := '';

  vCampo := IfNullS(item('CD_CAMPO', pParams), pParams);
  if (vCampo = '') then Exit;

  vPre := GetLeftStr(vCampo, '_');
  vCod := GetRightStr(vCampo, '_');

  Result := LowerCase(vPre) + PriMaiuscula(vCod);
end;

end.
