unit ucDADOS;

interface

uses
  SysUtils, Classes, DBXpress, FMTBcd, DB, Provider, DBClient, SqlExpr,
  ImgList, Controls, Forms, MidasLib, ucCOMP, Dialogs;

type
  TdDADOS = class(TDataModule)
    _Conexao: TSqlConnection;
    _ImageList: TImageList;
    procedure DataModuleCreate(Sender: TObject);
    procedure _ConexaoBeforeConnect(Sender: TObject);
    procedure _QueryAfterOpen(DataSet: TDataSet);
  private
  protected
    vBanSis, vTipBan, vUsuBan, vSenBan : String;
    FTD : TTransactionDesc;
  public
    gNmUsuario, gDtSistema, gTpPrivilegio, gIpComputador, gNmComputador : String;
    function getQuery(pSql : String = ''; pOpen : Boolean = False) : TSqlQuery;
    procedure _ConexaoSetParam(Sender: TObject);
    procedure StartTransaction(pParams : String = '');
    procedure Commit();
    procedure Rollback();
    function GetMetadataEnt(pEnt : String) : String;
    function f_RunSql(pSql : String; pMessage : Boolean = True) : Boolean;
    function f_TotalRegSql(pSql : String) : Integer;
    function f_ExistSql(pSql : String) : Boolean;
    function f_ConsultaStrSql(pSql : String; pCpo : String = '*') : String;
    function f_LerParametro(pCdParametro : String; pAvisa : Boolean = False) : String;
    function f_BuscarDescricao(pParams : String; pDsValue : String = '') : String;
    function f_IncrementoCodigo(pTabela, pCampo : String; pWhere : String = '') : Integer;
    procedure p_IncrementoCodigo(pClientDataSet : TClientDataSet; pTabela, pCampo : String; pWhere : String = '');
    function f_VerPrivilegio(pTabela, pTpPrivilegio : String) : boolean;
    procedure p_GeraListaTabela(pStrings : TStrings; pParams : String);
    function f_GeraListaTabela(pParams : String) : String;
  end;

var
  dDADOS: TdDADOS;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucFUNCAO, ucITEM, ucXML, ucCONST, ucCLIENT,
  ucMETADATA, ucVERSAO, StrUtils;

  function TdDADOS.getQuery(pSql : String; pOpen : Boolean) : TSqlQuery;
  begin
    Result := TSqlQuery.Create(Self);
    Result.SqlConnection := _Conexao;
    Result.Sql.Text := pSql;
    if pOpen then Result.Open;
  end;

procedure TdDADOS.DataModuleCreate(Sender: TObject);
begin
  dDADOS := Self;

  gIpComputador := GetIpComputador();
  gNmComputador := GetNmComputador();

  TcCLIENT.validaPathBan();

  vBanSis := LerIni(BAN_SIS);
  vTipBan := IfNullS(LerIni(TIP_BAN), 'FIREBIRD');
  vUsuBan := IfNullS(LerIni(USU_BAN), 'sysdba');
  vSenBan := IfNullS(LerIni(SEN_BAN), 'masterkey');

  TcVERSAO.verificar();
end;

procedure TdDADOS._ConexaoSetParam(Sender: TObject);
begin
  with TSqlConnection(Sender) do begin
    Params.Clear;

    if Pos(vTipBan, 'INTERBASE|FIREBIRD') > 0 then begin
      DriverName := 'Interbase';
      GetDriverFunc := 'getSQLDriverINTERBASE';
      LibraryName := 'dbexpint.dll';
      VendorLib := IfThen(vTipBan = 'INTERBASE', 'gds32.dll', 'fbclient.dll');

      Params.Values['DriverName'] := 'Interbase';
      Params.Values['BlobSize'] := '-1';
      Params.Values['CommitRetain'] := 'False';
      Params.Values['ErrorResourceFile'] := '';
      Params.Values['LocaleCode'] := '0000';
      Params.Values['RoleName'] := 'RoleName';
      Params.Values['ServerCharSet'] := 'win1252';
      Params.Values['SqlDialect'] := '3';
      Params.Values['Interbase TransIsolation'] := 'ReadCommited';
      Params.Values['WaitOnLocks'] := 'True';
    end else if Pos(vTipBan, 'ORACLE') > 0 then begin
      DriverName := 'Oracle';
      GetDriverFunc := 'getSQLDriverORACLE';
      LibraryName := 'dbexpora.dll';
      VendorLib := 'oci.dll';

      Params.Values['BlobSize'] := '-1';
      Params.Values['ErrorResourceFile'] := '';
      Params.Values['LocaleCode'] := '0000';
      Params.Values['Oracle TransIsolation'] := 'ReadCommited';
    end;

    Params.Values['Database'] := vBanSis;
    Params.Values['User_Name'] := vUsuBan;
    Params.Values['Password'] := vSenBan;
  end;
end;

procedure TdDADOS._ConexaoBeforeConnect(Sender: TObject);
begin
  try
    if (vBanSis = '') then
      raise Exception.Create('Caminho banco de dados não informado!');
    if (vTipBan = '') then
      raise Exception.Create('Tipo banco de dados não informado!');
    if (vUsuBan = '') then
      raise Exception.Create('Usuário banco de dados não informado!');
    if (vSenBan = '') then
      raise Exception.Create('Senha banco de dados não informado!');
  except
    Application.Terminate;
    raise;
  end;

  _ConexaoSetParam(_Conexao);
end;

function TdDADOS.f_RunSql(pSql : String; pMessage : Boolean) : Boolean;
begin
  try
    _Conexao.ExecuteDirect(pSql);
    Result := True;
  except
    on E: Exception do begin
      if pMessage then Mensagem('Erro ao executar sql! / Erro: ' + E.Message + ' / Sql: ' + pSql);
      Result := False;
    end;
  end;
end;

function TdDADOS.f_TotalRegSql(pSql : String) : Integer;
begin
  with getQuery() do begin
    try
      Close;
      Sql.Text := 'select count(*) as TOTAL from (' + pSql + ')';
      Open;
      Result := FieldByName('TOTAL').AsInteger;
    except
      on E: Exception do begin
        Mensagem('Erro ao totalizar sql! / Erro: ' + E.Message + ' / Sql: ' + pSql);
        Result := -1;
      end;
    end;

    Free;
  end;
end;

function TdDADOS.f_ExistSql(pSql : String) : Boolean; // f_ConsultaSql
begin
  Result := f_TotalRegSql(pSql) > 0;
end;

function TdDADOS.f_ConsultaStrSql(pSql, pCpo : String) : String; // f_ConsultaSqlRetorna
var
  vSqlQuery : TSqlQuery;
  vResult : String;
begin
  vResult := '';

  vSqlQuery := getQuery();
  with vSqlQuery do begin
    try
      Close;
      Sql.Text := pSql;
      Open;
      if (pCpo = '*') then begin
        putlistitensocc(vResult, vSqlQuery);
      end else if (pCpo = 'X') then begin
        putlistitensoccX(vResult, vSqlQuery);
      end else begin
        vResult := FieldByName(pCpo).asString;
      end;
    except
      on E: Exception do begin
        Mensagem('Erro ao consultar (ret) sql! / Erro: ' + E.Message + ' / Sql: ' + pSql);
        vResult := '';
      end;
    end;

    Free;
  end;

  Result := vResult;
end;

function TdDADOS.f_LerParametro(pCdParametro : String; pAvisa : Boolean) : String;
var
  vResult : String;
begin
  vResult := dDADOS.f_ConsultaStrSql('select VL_PARAMETRO from ADM_PARAM where CD_PARAMETRO = ''' + pCdParametro + ''' ','VL_PARAMETRO');
  if (vResult = '') and (pAvisa) then
    raise Exception.Create('Paramêtro ' + pCdParametro + ' deve ser informado!');
  Result := vResult;
end;

function TdDADOS.f_BuscarDescricao(pParams : String; pDsValue : String = '') : String;
var
  vDsTabela, vCdCampo, vDsCampo, vCdValue, vDsValue : String;
begin
  vDsTabela := item('DS_TABELA', pParams);
  vCdCampo := item('CD_CAMPO', pParams);
  vDsCampo := item('DS_CAMPO', pParams);
  vCdValue := item('CD_VALUE', pParams);

  vDsValue := pDsValue;

  if (vCdValue <> '') then begin
    with getQuery() do begin
      Close;
      Sql.Text := 'select ' + vDsCampo + ' from ' + vDsTabela + ' where ' + vCdCampo + '=''' + vCdValue + '''';
      Open;

      if not IsEmpty then
        vDsValue := FieldByName(vDsCampo).AsString;

      Free;
    end;
  end;

  Result := vDsValue;
end;

function TdDADOS.f_IncrementoCodigo(pTabela, pCampo, pwhere : String) : Integer;
begin
  Result := 0;
  if (pTabela = '') or (pCampo = '') then Exit;
  Result := StrToIntDef(f_ConsultaStrSql('select max(' + pCampo + ') as CODIGO from ' + pTabela + IfThen(pwhere<>'',' where ' + pwhere,''),'CODIGO'), 0) + 1;
end;

procedure TdDADOS.p_IncrementoCodigo(pClientDataSet : TClientDataSet; pTabela, pCampo, pWhere : String);
begin
  if pCampo = '' then Exit;
  with pClientDataSet do begin
    if not (State in [dsInsert]) then Exit;
    if (FieldByName(pCampo).asString <> '') then Exit;
    FieldByName(pCampo).asInteger := f_IncrementoCodigo(pTabela, pCampo, pWhere);
  end;
end;

function TdDADOS.f_VerPrivilegio(pTabela, pTpPrivilegio : String) : boolean;
const
  cLST_PERMISSAO =
    'IN_INCLUIR=Usuário sem permissão para incluir!;' +
    'IN_ALTERAR=Usuário sem permissão para alterar!;' +
    'IN_EXCLUIR=Usuário sem permissão para excluir!;' +
    'IN_IMPRIMIR=Usuário sem permissão para imprimir!;' ;
begin
  Result := False;

  if Pos(gTpPrivilegio, '1,2') > 0 then begin //Suporte / Administrador
    Result := True;
    Exit;
  end;

  if (gTpPrivilegio = '3') then begin //Operador
    Result := (f_ExistSql('select * from ADM_NIVEL where CD_ENTIDADE=''' + pTabela + ''' '+
                          'and NM_LOGIN=''' + gNmUsuario + ''' '+
                          'and ' + pTpPrivilegio + '=''T'' '));
  end;

  if (Result = False) or (gTpPrivilegio = '4') then begin //Consulta
    raise Exception.Create(item(pTpPrivilegio, cLST_PERMISSAO));
  end;
end;

procedure TdDADOS.p_GeraListaTabela(pStrings : TStrings; pParams : String);
begin
  TcStringList(pStrings).p_AddLista(f_GeraListaTabela(pParams));
end;

function TdDADOS.f_GeraListaTabela(pParams : String) : String;
var
  vTabela, vCdKey, vDsKey, vDsWhr : String;
begin
  Result := '';
  
  vTabela:= item('DS_TABELA', pParams);
  vCdKey := item('CD_KEY', pParams);
  vDsKey := item('DS_KEY', pParams);
  vDsWhr := item('DS_WHR', pParams);

  if (vTabela = '')
  or (vCdKey = '')
  or (vDsKey = '') then Exit;

  with getQuery() do begin
    Close;
    Sql.Text :=
       'select ' + vCdKey + ',' + vDsKey + ' ' +
       'from ' + vTabela + ' ' +
       IfThen(vDsWhr<>'', 'where ' + vDsWhr + ' ', '') +
       'order by ' + vDsKey;
    Open;

    while not EOF do begin
      putitem(Result, FieldByName(vCdKey).asString, FieldByName(vDsKey).asString);
      Next;
    end;

    Free;
  end;
end;

procedure TdDADOS._QueryAfterOpen(DataSet: TDataSet);
begin
  TcCADASTROFUNC.CorrigeDisplayLabel(DataSet);
end;

//--

procedure TdDADOS.StartTransaction(pParams : String);
const
  cMETHOD = 'TdDADOS.StartTransaction()';
begin
  if _Conexao.InTransaction then
    raise Exception.Create('Conexao ja contem transacao em andamento / ' + cMETHOD);

  FTD.TransactionID := IfNullI(itemX('ID_TRANSACAO', pParams), 1);
  FTD.IsolationLevel := xilREADCOMMITTED;
  _Conexao.StartTransaction(FTD);
end;

procedure TdDADOS.Commit();
const
  cMETHOD = 'TdDADOS.Commit()';
begin
  if not _Conexao.InTransaction then
    raise Exception.Create('Conexao ja nao contem transacao em andamento / ' + cMETHOD);

  _Conexao.Commit(FTD);
end;

procedure TdDADOS.Rollback();
const
  cMETHOD = 'TdDADOS.Rollback()';
begin
  if not _Conexao.InTransaction then
    raise Exception.Create('Conexao ja nao contem transacao em andamento / ' + cMETHOD);

  _Conexao.Rollback(FTD);
end;

//--

function TdDADOS.GetMetadataEnt(pEnt: String): String;
var
  vSqlQuery : TSqlQuery;
  vSql : String;
begin
  vSql := 'select * from ' + pEnt + ' where 1<>1 ';

  vSqlQuery := getQuery(vSql);
  vSqlQuery.Open;
  Result := TcMETADATA.GetMetadataEnt(vSqlQuery);
  vSqlQuery.Free;
end;

//--

initialization
  dDADOS := TdDADOS.Create(nil);

finalization
  dDADOS.Free;

end.
