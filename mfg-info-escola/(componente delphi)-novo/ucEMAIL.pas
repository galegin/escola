unit ucEMAIL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, ExtCtrls, DBClient, Buttons,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  {$IFDEF VER230} IdAttachmentFile, {$ENDIF}
  IdMessageClient, IdSMTP, IdMessage, IdSSLOpenSSL;

type
  TcEMAIL = class(TForm)
    Panel1: TPanel;
    Label5: TLabel;
    Shape7: TShape;
    Label6: TLabel;
    Shape8: TShape;
    RxLabel3: TLabel;
    Image1: TImage;
    Shape1: TShape;
    EditPara: TEdit;
    EditAssunto: TEdit;
    MemoMensagem: TMemo;
    Shape2: TShape;
    Label2: TLabel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    EditAnexo: TEdit;
    BtnPara: TSpeedButton;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButtonFechar: TToolButton;
    ToolButtonCancel: TToolButton;
    ToolButtonConfig: TToolButton;
    BtnAnexo: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnParaClick(Sender: TObject);
    procedure BtnAnexoClick(Sender: TObject);
    procedure ToolButtonEnviarClick(Sender: TObject);
    procedure ToolButtonFecharClick(Sender: TObject);
    procedure ToolButtonConfigClick(Sender: TObject);
    procedure ToolButtonCancelClick(Sender: TObject);
  private
    class procedure Ler_Configuracao;
  public
    ClientDataSetConfPg:TClientDataSet;
    class procedure Enviar(sPara, sAssunto, sAnexo : String; sMensagem : TStrings);
    class procedure EnviarAuto(sPara, sAssunto, sAnexo : String; sMensagem : TStrings);
  end;

implementation

{$R *.dfm}

uses
  ucFUNCAO, ucDADOS, ucITEM, ucCONST,
  ucCONFEMAIL, ucLISTAEMAIL, ucCADASTROFUNC;

var
  sEmlServ, sEmlPort, sEmlUser, sEmlPass, sEmlMail, sEmlNome : String;

  FInSMTP : Boolean = True;
  FInSSL : Boolean;

  class procedure TcEMAIL.Ler_Configuracao;
  begin
    sEmlServ := LerIni('EMAIL', EML_SERV);
    sEmlPort := LerIni('EMAIL', EML_PORT);
    sEmlUser := LerIni('EMAIL', EML_USER);
    sEmlPass := decript(LerIni('EMAIL', EML_PASS));
    sEmlMail := LerIni('EMAIL', EML_MAIL);
    sEmlNome := LerIni('EMAIL', EML_NOME);
  end;

class procedure TcEMAIL.Enviar(sPara, sAssunto, sAnexo : String; sMensagem : TStrings);
begin
  with TcEMAIL.Create(Application) do
  try
    EditPara.Text := sPara;
    EditAssunto.Text := PriMaiuscula(sAssunto);
    EditAnexo.Text := PriMaiuscula(sAnexo);
    MemoMensagem.Text := sMensagem.Text;
    ShowModal;
  finally
    Free;
  end;
end;

class procedure TcEMAIL.EnviarAuto(sPara, sAssunto, sAnexo : String; sMensagem : TStrings);
const
  cMETHOD = 'TcEMAIL.EnviaEmailAuto()';
var
  vLstAnexo, vAnexo : String;
  {$IFDEF VER230} IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;
  {$ELSE} IdSSLIOHandlerSocket : TIdSSLIOHandlerSocket;
  {$ENDIF}
  IdMessage : TIdMessage;
  IdSMTP : TIdSMTP;
begin
  Ler_Configuracao;

  if (sEmlServ = '')
  or (sEmlUser = '')
  or (sEmlMail = '')
  or (sEmlNome = '') then
    raise Exception.Create('Configure o Email!');

  if (sPara = '') then
    raise Exception.Create('Email Para é obrigatório!');
  if (sAssunto = '') then
    raise Exception.Create('Assunto é obrigatório!');

  //Enviar copia do email para o remetente
  //if FInRemet then
  //  putitemX(FDsEmailCC, FDsEmailDe);

  //Configuração do IdMessage (dados da mensagem)
  IdMessage := TIdMessage.Create(Application);

  IdMessage.AttachmentEncoding := 'MIME';
  IdMessage.ContentType := 'text/html';
  IdMessage.Encoding := meMIME;

  IdMessage.From.Address := sEmlMail;           //e-mail do remetente
  IdMessage.Recipients.EMailAddresses := sPara; //e-mail do destinatário
  IdMessage.CCList.EMailAddresses := '';        //e-mail com copia
  IdMessage.BCCList.EMailAddresses := '';       //e-mail com copia oculta
  IdMessage.Subject := sAssunto;                //assunto

  //Anexo
  IdMessage.MessageParts.Clear;
  vLstAnexo := sAnexo;
  while vLstAnexo <> '' do begin
    vAnexo := getitem(vLstAnexo);
    if vAnexo = '' then Break;
    delitem(vLstAnexo);

    {$IFDEF VER230} TIdAttachmentFile.Create(IdMessage.MessageParts, vAnexo);
    {$ELSE} TIdAttachment.Create(IdMessage.MessageParts, vAnexo);
    {$ENDIF}
  end;

  //Tipo de conteudo
  //if PosItem(FTpConteudo, cLST_TPCONTENT) > 0 then begin
  //  IdMessage.ContentType := FTpConteudo;
  //end;

  //Conteudo
  IdMessage.Body.Text := IfNullS(sMensagem.Text, 'EMAIL GERADO AUTOMATICO');

  //Configuração do IdSMTP
  IdSMTP := TIdSMTP.Create(Application);
  IdSMTP.Host := sEmlServ;                 // Host do SMTP
  IdSMTP.Port := IfNullI(sEmlPort, 25);    // Porta do SMTP
  IdSMTP.Username := sEmlUser;             // Login do usuário
  IdSMTP.Password := sEmlPass;             // Senha do usuário

  //-- requer autenticacao
  if FInSMTP then begin
    {$IFDEF VER230} IdSMTP.AuthType := satSASL
    {$ELSE} IdSMTP.AuthenticationType:= atLogin
    {$ENDIF}
  end else begin
    {$IFDEF VER230} IdSMTP.AuthType := satNone
    {$ELSE} IdSMTP.AuthenticationType := atNone;
    {$ENDIF}
  end;

  //-- conexao segura SSL
  if FInSSL then begin
    {$IFDEF VER230} IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    {$ELSE} IdSSLIOHandlerSocket := TIdSSLIOHandlerSocket.Create(nil);
    {$ENDIF}
    IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv3; //sslvTLSv1; //sslvSSLv2;
    IdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;  //sslmUnassigned;
    IdSMTP.IOHandler := IdSSLIOHandlerSocket;
  end else begin
    IdSMTP.IOHandler := nil;
  end;

  //Envia o email
  try
    IdSMTP.Connect;           //Estabelece a conexão
    if (IdSMTP.Connected) then begin
      IdSMTP.Send(IdMessage); //Envia a mensagem
    end;
  except
    IdSMTP.Free;
    IdMessage.Free;
    raise;
  end;

  IdSMTP.Free;
  IdMessage.Free;
end;

procedure TcEMAIL.FormCreate(Sender: TObject);
begin
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);

  Ler_Configuracao;
end;

procedure TcEMAIL.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

procedure TcEMAIL.BtnParaClick(Sender: TObject);
begin
  EditPara.Text:= TcLISTAEMAIL.Executar;
end;

procedure TcEMAIL.BtnAnexoClick(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do begin
    InitialDir := ExtractFilePath(Application.ExeName)+'..\';
    Filter := 'Todos Arquivos (*.*)|*.*';
    if Execute then EditAnexo.Text := FileName;
  end;
end;

procedure TcEMAIL.ToolButtonEnviarClick(Sender: TObject);
begin
  if not Pergunta('Confirma Enviar Email?') then
    Exit;

  EnviarAuto(EditPara.Text, EditAssunto.Text, EditAnexo.Text, MemoMensagem.Lines);

  ModalResult := mrOk;
end;

procedure TcEMAIL.ToolButtonFecharClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TcEMAIL.ToolButtonConfigClick(Sender: TObject);
begin
  TcCONFEMAIL.ConfigurarEmail;
  Ler_Configuracao;
end;

procedure TcEMAIL.ToolButtonCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
