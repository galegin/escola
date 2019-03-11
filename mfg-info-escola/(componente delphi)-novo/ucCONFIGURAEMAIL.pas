unit ucCONFIGURAEMAIL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin;

type
  TcCONFIGURAEMAIL = class(TForm)
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
  ucFUNCOES, ucCONST, ucCADASTROFUNC;

const
  cDEF_SERV = '<<Coloque aqui o endereco do servidor SMTP>>';
  cDEF_PORT = '<<Coloque aqui a porta do servidor SMTP>>';
  cDEF_USER = '<<Coloque aqui o usuario do servidor SMTP>>';
  cDEF_PASS = '';
  cDEF_MAIL = '<<Coloque aqui o endereço do email>>';
  cDEF_NOME = '<<Coloque aqui o nome>>';

class procedure TcCONFIGURAEMAIL.ConfigurarEmail;
begin
  with TcCONFIGURAEMAIL.Create(Application) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TcCONFIGURAEMAIL.FormCreate(Sender: TObject);
begin
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);

  EditServ.Text := IfNull(LerIni('EMAIL', EML_SERV), cDEF_SERV);
  EditPort.Text := IfNull(LerIni('EMAIL', EML_PORT), cDEF_PORT);
  EditUser.Text := IfNull(LerIni('EMAIL', EML_USER), cDEF_USER);
  EditPass.Text := cripto_e(IfNull(LerIni('EMAIL', EML_PASS), cDEF_PASS));
  EditMail.Text := IfNull(LerIni('EMAIL', EML_MAIL), cDEF_MAIL);
  EditNome.Text := IfNull(LerIni('EMAIL', EML_NOME), cDEF_NOME);
end;

procedure TcCONFIGURAEMAIL.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Close;
end;

procedure TcCONFIGURAEMAIL.ToolButtonOkClick(Sender: TObject);
begin
  if EditServ.Text <> cDEF_SERV then fGravaIni('EMAIL', EML_SERV, EditServ.Text);
  if EditPort.Text <> cDEF_PORT then fGravaIni('EMAIL', EML_PORT, EditPort.Text);
  if EditUser.Text <> cDEF_USER then fGravaIni('EMAIL', EML_USER, EditUser.Text);
  if EditPass.Text <> cDEF_PASS then fGravaIni('EMAIL', EML_PASS, cripto_e(EditPass.Text));
  if EditMail.Text <> cDEF_MAIL then fGravaIni('EMAIL', EML_MAIL, EditMail.Text);
  if EditNome.Text <> cDEF_NOME then fGravaIni('EMAIL', EML_NOME, EditNome.Text);
  Close;
end;

procedure TcCONFIGURAEMAIL.ToolButtonCancelClick(Sender: TObject);
begin
  Close;
end;

end.
