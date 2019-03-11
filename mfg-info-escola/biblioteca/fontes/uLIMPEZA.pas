unit uLIMPEZA;

interface

uses
  Classes, StrUtils, SysUtils, Dialogs;

type
  TcLIMPEZA = class
  private
  public
    class procedure Dados;
  end;

implementation

uses
  ucFUNCAO, ucITEM, ucXML, ucDADOS;

const
  cLST_LIMPAR =
    '<LOG_ENTIDADE  cmd="" />' +
    '<OBS_ENTIDADE  cmd="" />' +

    '<GER_LOCACAO   cmd="delete from GER_LOCACAO ' +
                        'where extract(YEAR from DT_LOCACAO) <= {ANO} ' +
                        'and CD_LOCADOR in (select CD_LOCADOR from GER_LOCADOR where TP_LOCADOR = 1)" />' +
    '<GER_LIVRO     cmd="" />' +
    '<GER_INDLIVRO  cmd="" />' +

    '<GER_LOCADOR   cmd="delete from GER_LOCADOR ' +
                        'where TP_LOCADOR = 1 ' +
                        'and CD_LOCADOR not in (select CD_LOCADOR from GER_LOCADOR where TP_LOCADOR = 1)" />' +
    '<GER_CURSO     cmd="" />' +
    '<GER_EDITORA   cmd="" />' +
    '<GER_GENERO    cmd="" />' +
    '<GER_TPENSINO  cmd="" />' +

    '<ADM_NIVEL     cmd="" />' +
    '<ADM_PARAM     cmd="" />' +
    '<ADM_USUARIO   cmd="" />' +

    '<GEN_GER_LOCACAO_ID cmd="SET GENERATOR GEN_GER_LOCACAO_ID TO 1" />' ;

class procedure TcLIMPEZA.Dados;
var
  vLstEnt, vEnt, vXml, vCmd, vAno : String;
begin
  vAno := FormatDateTime('yyyy',Date);

  if not InputQuery('Informar', 'Ano:', vAno) then
    exit;

  if not Pergunta('Deseja limpar os dados anterior ao ano de ' + vAno + '?') then
    exit;

  if not Pergunta('Tem certeza que deseja limpar os dados anterior ao ano de ' + vAno + '?') then
    exit;

  vLstEnt := listCdX(cLST_LIMPAR);

  while vLstEnt <> '' do begin
    vEnt := getitem(vLstEnt);
    if vEnt = '' then Break;
    delitem(vLstEnt);

    vXml := itemX(vEnt, cLST_LIMPAR);
    vCmd := IfNullS(itemA('cmd', vXml), 'delete from ' + vEnt);
    vCmd := replaceStr(vCmd, '{ano}', vAno);

    dDADOS.f_RunSQL(vCmd);
  end;
end;

end.
