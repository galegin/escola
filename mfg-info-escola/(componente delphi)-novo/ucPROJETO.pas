unit ucPROJETO; // mProjeto

interface

uses
  Classes, SysUtils, StrUtils, Forms;

type
  TcPROJETO = class
  public
    class function Codigo() : String;
    class function Nome() : String;
    class function Versao() : String;
  end;

implementation

uses
  ucARQUIVO, ucPATH, ucVERSAOEXE;

class function TcPROJETO.Codigo() : String;
begin
  Result := TcPATH.ArquivoDll();
  Result := AnsiReplaceStr(Result, ExtractFilePath(Result), '');
  Result := AnsiReplaceStr(Result, ExtractFileExt(Result), '');
end;

class function TcPROJETO.Nome() : String;
begin
  Result := IfThen(Application.Title <> '', Application.Title, Application.Name);
end;

class function TcPROJETO.Versao() : String;
var
  vDtCriacao : TDateTime;
begin
  Result := ucVersaoExe.Instance._VersaoSis;
  if (Result <> '00.00.00') then
    Exit;

  vDtCriacao := TcARQUIVO.DataDeCriacao(TcPATH.ArquivoDll());
  Result := FormatDateTime('yy.mm.dd', vDtCriacao);
end;

end.
