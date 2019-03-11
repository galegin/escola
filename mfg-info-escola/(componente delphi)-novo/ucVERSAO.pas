unit ucVERSAO;

interface

uses
  Classes, SysUtils;

type
  TcVERSAO = class
  public
    class procedure verificar();
  end;

implementation

uses
  ucARQUIVO, ucFUNCAO, ucDADOS, ucCONST, ucITEM, ucXML;

{ TcVERSAO }

class procedure TcVERSAO.verificar();
var
  vArq, vXml, vScr, vCmd, vVrs, vSis : String;
  vDtVersaoSis, vDtVersaoArq : TDateTime;
begin
  vArq := ChangeFileExt(ParamStr(0), '.sql');
  vXml := TcARQUIVO.carregar(vArq);
  if vXml = '' then
    Exit;

  vDtVersaoSis := LerIniD(ATU_SIS);
  vDtVersaoArq := TcARQUIVO.DataDeCriacao(vArq);
  if vDtVersaoSis = vDtVersaoArq then
    Exit;

  vSis := FormatDateTime('yyyy.mm.dd', vDtVersaoSis);

  while vXml <> '' do begin
    vScr := itemX('script', vXml);
    if vScr = '' then Break;
    delitemX('script', vXml);

    vVrs := itemA('vrs', vScr);
    if vVrs <= vSis then
      Continue;

    while vScr <> '' do begin
      vCmd := itemX('cmd', vScr);
      if vCmd = '' then Break;
      delitemX('cmd', vScr);

      try
        dDADOS.f_RunSql(vCmd, False);
      except
        on E : Exception do begin
        end;
      end;
    end;
  end;

  fGravaIni(ATU_SIS, vDtVersaoArq);

  Mensagem('Versao atualizada!');
end;

end.