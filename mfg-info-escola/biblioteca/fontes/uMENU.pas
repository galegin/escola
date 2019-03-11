unit uMENU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucMENU, Menus, StdCtrls, ComCtrls, ToolWin, ExtCtrls;

type
  TfMENU = class(TcMENU)
    Processo1: TMenuItem;
    LimparDados1: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure Login1Click(Sender: TObject);
    procedure LimparDados1Click(Sender: TObject);
  private
  public
  end;

var
  fMENU: TfMENU;

implementation

{$R *.dfm}

uses
  ucDADOS, ucFUNCAO,  ucCONST,
  uLIVRO, uLOCACAO, uCONSULTA, uEDITORA, uGENERO, uCURSO,
  uLOCADOR, uCAIXA, uTPENSINO, uTURMA, uLIMPEZA;

const
  cLST_MENU =
    '<CD_SEQ1     ata="T" sep="T" btn="CD_LIVRO" />' +
    '<CD_LIVRO    des="Livro"     cls="TfLIVRO"    ata="T" img="0" ent="GER_LIVRO"    fld="DS_TITULO"  />' +
    '<CD_LOCADOR  des="Locador"   cls="TfLOCADOR"  ata="T" img="1" ent="GER_LOCADOR"  fld="NM_LOCADOR" />' +

    '<CD_SEQ2     ata="T" sep="T" btn="CD_CONSULTA" />' +
    '<CD_CONSULTA des="Consulta"  cls="TfCONSULTA" ata="T" img="2" ent="" fld="" />' +
    '<CD_LOCACAO  des="Locacao"   cls="TfLOCACAO"  ata="T" img="3" ent="GER_LOCACAO"  fld="" />' +

    '<CD_SEQ3     ata="T" sep="T" btn="CD_CAIXA" />' +
    '<CD_CAIXA    des="Caixa"     cls="TfCAIXA"    ata="T" img="4" ent="" fld="" />' +

    '<CD_CURSO    des="Curso"     cls="TfCURSO"    ata="F" img="5" ent="GER_CURSO"    fld="DS_CURSO"   />' +
    '<CD_EDITORA  des="Editora"   cls="TfEDITORA"  ata="F" img="6" ent="GER_EDITORA"  fld="DS_EDITORA" />' +
    '<CD_GENERO   des="Genero"    cls="TfGENERO"   ata="F" img="7" ent="GER_GENERO"   fld="DS_GENERO"  />' +
    '<TP_ENSINO   des="Tp Ensino" cls="TfTPENSINO" ata="F" img="8" ent="GER_TPENSINO" fld="DS_ENSINO"  />' +
    '<CD_TURMA    des="Turma"     cls="TfTURMA"    ata="F" img="9" ent="GER_TURMA"    fld="DS_TURMA"   />' ;

  cLST_TIPAGEM =
    '<TP_LOCACAO>1=Normal;2=Devolvido;3=Devolvido com atraso;4=Devolvido com isencao</TP_LOCACAO>' +
    '<TP_LOCADOR>1=Aluno;2=Professor</TP_LOCADOR>' ;

procedure TfMENU.FormCreate(Sender: TObject);
begin
  inherited;
  _LstMenu := cLST_MENU;
  _LstTipagem := cLST_TIPAGEM;
end;

procedure TfMENU.Login1Click(Sender: TObject);
begin
  inherited;
  if (dDADOS.gNmUsuario = 'CONSULTA') then begin
    AbreTela('CD_CONSULTA');
    Application.Terminate;
  end;
end;

procedure TfMENU.LimparDados1Click(Sender: TObject);
begin
  if Pos(dDADOS.gTpPrivilegio, '1|2') = 0 then
    raise Exception.Create(cMESSAGE_SEMPERMISSAO);

  TcLIMPEZA.Dados;
end;

end.
