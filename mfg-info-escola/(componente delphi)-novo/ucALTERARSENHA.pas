unit ucALTERARSENHA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Mask, DB, DBCtrls;

type
  TcALTERARSENHA = class(TForm)
    Panel1: TPanel;
    LabelTitulo: TLabel;
    Image1: TImage;
    BtnOk: TBitBtn;
    BtnCancel: TBitBtn;
    LabelUsuario: TLabel;
    Shape1: TShape;
    LabelSenha: TLabel;
    Shape2: TShape;
    EditNome: TEdit;
    EditSenha: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnOkClick(Sender: TObject);
  protected
    sNomeUsuario : String;
  public
    class procedure Alterar(v_Nome : String = '');
  end;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucDADOS, ucFUNCAO;

class procedure TcALTERARSENHA.Alterar(v_Nome : String);
begin
  with TcALTERARSENHA.Create(Application) do begin
    try
      sNomeUsuario := v_Nome;
      LabelTitulo.Caption := IfThenS(v_Nome<>'','Alterar Senha','Cadastro de Usuário');
      EditNome.Text := v_Nome;
      if (v_Nome = '') then
        EditSenha.Text := '123MUDAR';
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TcALTERARSENHA.FormShow(Sender: TObject);
begin
  EditNome.SetFocus;
end;

procedure TcALTERARSENHA.FormCreate(Sender: TObject);
begin
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);
end;

procedure TcALTERARSENHA.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close();
    VK_RETURN: Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TcALTERARSENHA.BtnOkClick(Sender: TObject);
begin
  if (sNomeUsuario <> '') then begin
    dDADOS.f_RunSQL('update ADM_USUARIO set NM_LOGIN = ''' + EditNome.Text + ''', CD_SENHA = ''' + cripto(EditSenha.Text) + ''' where NM_LOGIN = ''' + sNomeUsuario + ''' ');
    Mensagem('Senha alterada com sucesso!');
  end else begin
    dDADOS.f_RunSQL('insert into ADM_USUARIO (NM_USUARIO,NM_LOGIN,CD_SENHA) values (''' + EditNome.Text + ''', ''' + EditNome.Text + ''', ''' + cripto(EditSenha.Text) + ''') ');
    Mensagem('Usuário cadastrado com sucesso!');
  end;
end;

end.
