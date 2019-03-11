unit ucCLIENT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBXpress, DB, SqlExpr, StrUtils, FMTBcd;

type
  TcCLIENT = class(TForm)
    ipLocal: TEdit;
    ipServidor: TEdit;
    lblMensagem: TLabel;
    dsCaminho: TEdit;
    LabelLocal: TLabel;
    LabelCaminho: TLabel;
    LabelServidor: TLabel;
    EditFocus: TEdit;
    btnTestar: TButton;
    btnGravar: TButton;
    _Conexao: TSQLConnection;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ipServidorChange(Sender: TObject);
    procedure LabelCaminhoClick(Sender: TObject);
    procedure btnTestarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
  public
  published
    class procedure validaPathBan();
    class function getPathBan() : String;
  end;

implementation

{$R *.dfm}

uses
  ucPROJETO, ucFUNCAO, ucDADOS, ucCONST, ucITEM, ucPATH;

class procedure TcCLIENT.validaPathBan();
var
  vLstIpComp, vIpComp,
  vBanSis, vIpPath, vDsPath : String;
begin
  vBanSis := LerIni(BAN_SIS);
  vIpPath := LowerCase(GetLeftStr(vBanSis, ':'));
  vDsPath := GetRightStr(vBanSis, ':');
  vIpComp := GetIpComputador();

  vLstIpComp := '';
  putitem(vLstIpComp, 'localhost');
  putitem(vLstIpComp, '127.0.0.1');
  putitem(vLstIpComp, vIpComp);

  if Pos(vIpPath, vLstIpComp) = 0 then
    Exit;

  if (Pos(':\', vDsPath) = 0) or FileExists(vDsPath) then
    Exit;

  with TcCLIENT.Create(nil) do begin
    ShowModal;
    Free;
  end;
end;

class function TcCLIENT.getPathBan(): String;
var
  vCaminho : String;
begin
  vCaminho := LerIni(BAN_SIS);
  Result := IfNull(GetRightStr(vCaminho, ':'), TcPATH.pathDados() + getCdProjeto() + '.gdb');
end;

procedure TcCLIENT.FormShow(Sender: TObject);
var
  vCaminho : String;
begin
  ipLocal.Text := dDADOS.gIpComputador;

  vCaminho := LerIni(BAN_SIS);
  ipServidor.Text := IfNull(GetLeftStr(vCaminho, ':'), '127.0.0.1');
  dsCaminho.Text := GetRightStr(vCaminho, ':');

  if dsCaminho.Text = '' then begin
    dsCaminho.Text := TcPATH.pathDados() + getCdProjeto() + '.gdb';
  end;

  ipServidorChange(nil);
end;

procedure TcCLIENT.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then Close;
end;

procedure TcCLIENT.ipServidorChange(Sender: TObject);
begin
  lblMensagem.Caption := 'Essa máquina é a ' + Iff(FileExists(dsCaminho.Text), 'SERVIDORA', 'CLIENTE') + '!';
  btnGravar.Enabled := False;
end;

procedure TcCLIENT.LabelCaminhoClick(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do begin
    Filter := 'Arquivo firebird (*.fdb)|*.fdb|Arquivo interbase (*.gdb)|*.gdb';
    InitialDir := ExtractFilePath(Application.ExeName);
    if Execute then
      dsCaminho.Text := FileName;
    Free;
  end;
end;

procedure TcCLIENT.btnTestarClick(Sender: TObject);
var
  vCaminho : String;
begin
  EditFocus.SetFocus;

  if (Alltrim(ipServidor.Text) = '') then
    raise Exception.Create('IP SERVIDOR deve ser informado!');
  if (Alltrim(dsCaminho.Text) = '') then
    raise Exception.Create('CAMINHO deve ser informado!');

  vCaminho := Alltrim(ipServidor.Text) + ':' + Alltrim(dsCaminho.Text);

  try
    with _Conexao do begin
      Connected := False;
      LoginPrompt := False;
      dDADOS._ConexaoSetParam(_Conexao);
      Params.Values['Database'] := vCaminho;
      Params.Values['User_Name'] := 'sysdba';
      Params.Values['Password'] := 'masterkey';
      Connected := True;
    end;

    lblMensagem.Caption := 'Conexão testada com sucesso!';
    btnGravar.Enabled := True;
  except
    lblMensagem.Caption := 'A tentativa de conexão falhou!';
    btnGravar.Enabled := False;
  end;
end;

procedure TcCLIENT.btnGravarClick(Sender: TObject);
var
  vCaminho : String;
begin
  EditFocus.SetFocus;

  if (Alltrim(ipServidor.Text) = '') then
    raise Exception.Create('IP SERVIDOR não informado!');
  if (Alltrim(dsCaminho.Text) = '') then
    raise Exception.Create('CAMINHO não informado!');

  vCaminho := Alltrim(ipServidor.Text) + ':' + Alltrim(dsCaminho.Text);

  fGravaIni(BAN_SIS, vCaminho);

  lblMensagem.Caption := 'IP SERVIDOR gravado com sucesso!';
end;

end.
