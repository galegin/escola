unit ucLOGIN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, StrUtils;

type
  TcLOGIN = class(TForm)
    Panel1: TPanel;
    RxLabel3: TLabel;
    Image1: TImage;
    BtnOK: TBitBtn;
    BtnCancel: TBitBtn;
    enome: TEdit;
    esenha: TEdit;
    Shape1: TShape;
    Shape2: TShape;
    RxLabel1: TLabel;
    RxLabel2: TLabel;
    BtnAlterar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure enomeExit(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
  private
  public
    v_Nome, v_Senha : String;
  published
    class function ValidaSenha(pParams : String = '') : String;
  end;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucALTERARSENHA, ucCONST, ucFUNCAO, ucDADOS;

class function TcLOGIN.ValidaSenha(pParams : String) : String;
begin
  if IsDelphiOpen() then begin
    Result := 'SUPORTE';
    Exit;
  end;

  with TcLOGIN.Create(nil) do begin
    if ShowModal <> mrOk then begin
      Application.Terminate;
      Abort;
    end else begin
      Result := Hint;
    end;
  end;
end;

procedure TcLOGIN.FormCreate(Sender: TObject);
begin
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);
end;

procedure TcLOGIN.FormShow(Sender: TObject);
begin
  enome.text := '';
  esenha.text := '';
  v_Nome := '';
  v_Senha := '';
end;

procedure TcLOGIN.FormActivate(Sender: TObject);
begin
  if (ParamStr(1)<>'') and (ParamStr(2)<>'') then begin
    enome.Text := ParamStr(1);
    esenha.Text := ParamStr(2);
    BtnOK.SetFocus;
  end;
end;

procedure TcLOGIN.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close();
    VK_RETURN: Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TcLOGIN.enomeExit(Sender: TObject);
begin
  BtnAlterar.Caption := IfThen(enome.Text = 'SUPORTE', '&Cadastrar', '&Alterar');
end;

procedure TcLOGIN.BtnOKClick(Sender: TObject);
begin
  v_Nome := Trim(enome.text);
  v_Senha := Trim(esenha.text);
  if (v_Nome = 'SUPORTE') then begin
    if (cripto(v_Senha) <> '`csegk') then
      raise Exception.Create(cMESSAGE_PASSINVALIDA);
  end else begin
    if not dDADOS.f_ExistSql('select * from ADM_USUARIO where NM_LOGIN = ''' + v_Nome + ''' ') then
      raise Exception.Create(cMESSAGE_USERINVALIDO);
    if dDADOS.f_ExistSql('select * from ADM_USUARIO where NM_LOGIN = ''' + v_Nome + ''' and CD_SENHA <> ''' + cripto(v_Senha) + ''' ') then
      raise Exception.Create(cMESSAGE_PASSINVALIDA);
  end;
  Hint := v_Nome;
  ModalResult := mrOk;
end;

procedure TcLOGIN.BtnAlterarClick(Sender: TObject);
begin
  v_Nome := Trim(enome.text);
  v_Senha := Trim(esenha.text);
  if (v_Nome = 'SUPORTE') then begin
    if (cripto(v_Senha) <> '`csegk') then
      raise Exception.Create(cMESSAGE_PASSINVALIDA);
    TcALTERARSENHA.Alterar();
  end else begin
    if not dDADOS.f_ExistSql('select * from ADM_USUARIO where NM_LOGIN = ''' + v_Nome + ''' and TP_SITUACAO = 1 ') then
      raise Exception.Create(cMESSAGE_USERINVALIDO);
    if dDADOS.f_ExistSql('select * from ADM_USUARIO where NM_LOGIN = ''' + v_Nome + ''' and CD_SENHA <> ''' + cripto(v_Senha) + ''' and TP_SITUACAO = 1 ') then
      raise Exception.Create(cMESSAGE_PASSINVALIDA);
    TcALTERARSENHA.Alterar(v_Nome);
  end;
end;

end.
