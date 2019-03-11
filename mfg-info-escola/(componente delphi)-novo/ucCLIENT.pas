unit ucCLIENT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin, DBXpress, DB,
  SqlExpr;

type
  TcCLIENT = class(TForm)
    Panel1: TPanel;
    LabelLocal: TLabel;
    Shape7: TShape;
    LabelCaminho: TLabel;
    Shape8: TShape;
    RxLabel3: TLabel;
    Image1: TImage;
    LabelServidor: TLabel;
    SpeedButton5: TSpeedButton;
    EditLocal: TEdit;
    EditServidor: TEdit;
    EditCaminho: TEdit;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButtonOk: TToolButton;
    ToolButtonCancel: TToolButton;
    Shape3: TShape;
    LabelMensagem: TLabel;
    Shape4: TShape;
    EditMensagem: TEdit;
    ToolButtonTestar: TToolButton;
    _Conexao: TSQLConnection;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditServidorChange(Sender: TObject);
    procedure LabelCaminhoClick(Sender: TObject);
    procedure ToolButtonTestarClick(Sender: TObject);
    procedure ToolButtonOkClick(Sender: TObject);
    procedure ToolButtonCancelClick(Sender: TObject);
  private
  public
    class procedure validaPathBan();
    class function getPathBan() : String;
  end;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucPROJETO, ucFUNCAO, ucDADOS, ucCONST, ucITEM, ucPATH,
  StrUtils;

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
  Result := IfNullS(GetRightStr(vCaminho, ':'), TcPATH.Dados() + TcPROJETO.Codigo() + '.gdb');
end;

procedure TcCLIENT.FormCreate(Sender: TObject);
begin
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);
end;

procedure TcCLIENT.FormShow(Sender: TObject);
var
  vCaminho : String;
begin
  EditLocal.Text := dDADOS.gIpComputador;

  vCaminho := LerIni(BAN_SIS);
  EditServidor.Text := IfNullS(GetLeftStr(vCaminho, ':'), '127.0.0.1');
  EditCaminho.Text := GetRightStr(vCaminho, ':');

  if EditCaminho.Text = '' then begin
    EditCaminho.Text := TcPATH.Dados() + TcPROJETO.Codigo() + '.gdb';
  end;

  EditServidorChange(nil);
end;

procedure TcCLIENT.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close();
  end;
end;

procedure TcCLIENT.EditServidorChange(Sender: TObject);
begin
  EditMensagem.Text := 'Essa máquina é a ' + IfThen(FileExists(EditCaminho.Text), 'SERVIDORA', 'CLIENTE') + '!';
  ToolButtonOk.Enabled := False;
end;

procedure TcCLIENT.LabelCaminhoClick(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do begin
    Filter := 'Arquivo firebird (*.fdb)|*.fdb|Arquivo interbase (*.gdb)|*.gdb';
    InitialDir := ExtractFilePath(Application.ExeName);
    if Execute then
      EditCaminho.Text := FileName;
    Free;
  end;
end;

procedure TcCLIENT.ToolButtonTestarClick(Sender: TObject);
var
  vCaminho : String;
begin
  if Alltrim(EditServidor.Text) = '' then
    raise Exception.Create('IP SERVIDOR deve ser informado!');
  if Alltrim(EditCaminho.Text) = '' then
    raise Exception.Create('CAMINHO deve ser informado!');

  vCaminho := Alltrim(EditServidor.Text) + ':' + Alltrim(EditCaminho.Text);

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

    EditMensagem.Text := 'Conexão testada com sucesso!';
    ToolButtonOk.Enabled := True;
  except
    EditMensagem.Text := 'A tentativa de conexão falhou!';
    ToolButtonOk.Enabled := False;
  end;
end;

procedure TcCLIENT.ToolButtonOkClick(Sender: TObject);
var
  vCaminho : String;
begin
  if Alltrim(EditServidor.Text) = '' then
    raise Exception.Create('IP SERVIDOR deve ser informado!');
  if Alltrim(EditCaminho.Text) = '' then
    raise Exception.Create('CAMINHO deve ser informado!');

  vCaminho := Alltrim(EditServidor.Text) + ':' + Alltrim(EditCaminho.Text);

  fGravaIni(BAN_SIS, vCaminho);

  EditMensagem.Text := 'IP SERVIDOR gravado com sucesso!';

  Close;
end;

procedure TcCLIENT.ToolButtonCancelClick(Sender: TObject);
begin
  Close;
end;

end.
