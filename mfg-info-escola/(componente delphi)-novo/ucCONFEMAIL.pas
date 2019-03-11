unit ucCONFEMAIL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin;

type
  TcCONFEMAIL = class(TForm)
    Panel1: TPanel;
    Label5: TLabel;
    Shape7: TShape;
    Label6: TLabel;
    Shape8: TShape;
    RxLabel3: TLabel;
    Image1: TImage;
    Shape2: TShape;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton5: TSpeedButton;
    EditServ: TEdit;
    EditPort: TEdit;
    EditUser: TEdit;
    EditMail: TEdit;
    Shape1: TShape;
    Label1: TLabel;
    EditNome: TEdit;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButtonOk: TToolButton;
    ToolButtonCancel: TToolButton;
    Shape3: TShape;
    Label4: TLabel;
    Shape4: TShape;
    EditPass: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ToolButtonOkClick(Sender: TObject);
    procedure ToolButtonCancelClick(Sender: TObject);
  private
  public
    class procedure ConfigurarEmail;
  end;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucFUNCAO, ucCONST;

const
  cDEF_SERV = '<<Coloque aqui o endereco do servidor SMTP>>';
  cDEF_PORT = '<<Coloque aqui a porta do servidor SMTP>>';
  cDEF_USER = '<<Coloque aqui o usuario do servidor SMTP>>';
  cDEF_PASS = '';
  cDEF_MAIL = '<<Coloque aqui o endereço do email>>';
  cDEF_NOME = '<<Coloque aqui o nome>>';

class procedure TcCONFEMAIL.ConfigurarEmail;
begin
  with TcCONFEMAIL.Create(Application) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TcCONFEMAIL.FormCreate(Sender: TObject);
begin
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);

  EditServ.Text := IfNullS(LerIni('EMAIL', EML_SERV), cDEF_SERV);
  EditPort.Text := IfNullS(LerIni('EMAIL', EML_PORT), cDEF_PORT);
  EditUser.Text := IfNullS(LerIni('EMAIL', EML_USER), cDEF_USER);
  EditPass.Text := encript(IfNullS(LerIni('EMAIL', EML_PASS), cDEF_PASS));
  EditMail.Text := IfNullS(LerIni('EMAIL', EML_MAIL), cDEF_MAIL);
  EditNome.Text := IfNullS(LerIni('EMAIL', EML_NOME), cDEF_NOME);
end;

procedure TcCONFEMAIL.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close();
  end;
end;

procedure TcCONFEMAIL.ToolButtonOkClick(Sender: TObject);
begin
  if EditServ.Text <> cDEF_SERV then fGravaIni('EMAIL', EML_SERV, EditServ.Text);
  if EditPort.Text <> cDEF_PORT then fGravaIni('EMAIL', EML_PORT, EditPort.Text);
  if EditUser.Text <> cDEF_USER then fGravaIni('EMAIL', EML_USER, EditUser.Text);
  if EditPass.Text <> cDEF_PASS then fGravaIni('EMAIL', EML_PASS, decript(EditPass.Text));
  if EditMail.Text <> cDEF_MAIL then fGravaIni('EMAIL', EML_MAIL, EditMail.Text);
  if EditNome.Text <> cDEF_NOME then fGravaIni('EMAIL', EML_NOME, EditNome.Text);
  Close;
end;

procedure TcCONFEMAIL.ToolButtonCancelClick(Sender: TObject);
begin
  Close;
end;

end.
