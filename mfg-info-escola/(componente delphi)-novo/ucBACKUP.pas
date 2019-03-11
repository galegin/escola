unit ucBACKUP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, CheckLst, Mask, Registry, ComCtrls, ToolWin,
  IBServices;

type
  THorario = packed record
    Hora: TTime;
    Feito: Boolean;
    Agendado: Boolean;
  end;

  TcBACKUP = class(TForm)
    Panel1: TPanel;
    RxLabel3: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    sbBuscaBase: TSpeedButton;
    eBase: TEdit;
    eDirBackup: TEdit;
    Timer: TTimer;
    Shape1: TShape;
    Shape2: TShape;
    clbSemana: TCheckListBox;
    clbHorarios: TCheckListBox;
    Shape3: TShape;
    Label3: TLabel;
    sbBuscaBackup: TSpeedButton;
    Label4: TLabel;
    SpeedButtonSel: TSpeedButton;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButtonBackup: TToolButton;
    ToolButtonRestore: TToolButton;
    ToolButtonAgenda: TToolButton;
    ToolButtonFechar: TToolButton;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ToolButtonRestoreClick(Sender: TObject);
    procedure ToolButtonFecharClick(Sender: TObject);
    procedure ToolButtonAgendaClick(Sender: TObject);
    procedure ToolButtonBackupClick(Sender: TObject);
    procedure sbBuscaBaseClick(Sender: TObject);
    procedure sbCancelarClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure sbSairClick(Sender: TObject);
    procedure ssFormCreate(Sender: TObject);
    function HourOf(Data : TDateTime) : Word;
    procedure sbBuscaBackupClick(Sender: TObject);
    procedure SpeedButtonSelClick(Sender: TObject);
    procedure Agenda;
    procedure AgendaBackup;
  private
    sTitle: String;
    Horarios: array[0..23] of THorario;
    function DoBackup: Boolean;
    procedure AddStatusLine(S: string; Cor: TColor = clWindowText; Tamanho: byte = 10);
  public

  end;

var
  cBACKUP: TcBACKUP;

const
  Dia: array[1..7] of string =
    ('Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado');

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucPROJETO, ucPATH, ucFUNCAO, ucDADOS, ucCLIENT, ucDIR,
  StrUtils;

procedure TcBACKUP.FormCreate(Sender: TObject);
var
  reg: TRegistry;
  i: integer;
begin
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);

  sTitle := TcPROJETO.Codigo();

  reg := TRegistry.Create;

  try
    try
      reg.RootKey := HKEY_LOCAL_MACHINE;
      if reg.OpenKey('\Software\' + sTitle, false) then begin
        eBase.Text := IfNullS(reg.ReadString('Base'), TcCLIENT.getPathBan());
        eDirBackup.Text := IfNullS(reg.ReadString('BackupDir'), TcPATH.Backup());
        for i := Low(Dia) to High(Dia) do begin
          clbSemana.Checked[i-1] := reg.ReadBool(Dia[i]);
        end;
        if reg.OpenKey('\Software\' + sTitle + '\Horarios', false) then begin
          for i := 0 to clbHorarios.Items.Count-1 do begin
            clbHorarios.Checked[i] := reg.ReadBool(FormatFloat('00', i) + ':00');
          end;
        end;
      end;
    except
      raise;
    end;
  finally
    reg.Free;
  end;

  ssFormCreate(Sender);
end;

procedure TcBACKUP.sbBuscaBaseClick(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do begin
    InitialDir := TcPATH.Dados();
    Filter := 'FireBird/InterBase Database(*.gdb)|*.gdb';
    if Execute then eBase.Text := FileName;
  end;
end;

procedure TcBACKUP.sbCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TcBACKUP.TimerTimer(Sender: TObject);
var
  i: integer;
begin
  for i := Low(Horarios) to High(Horarios) do begin
    if (Horarios[i].Agendado) and (not Horarios[i].Feito) and (Horarios[i].Hora = HourOf(now)) then begin
      Timer.Enabled := false;
      Horarios[i].Feito := DoBackup;
      Timer.Enabled := true;
      Break;
    end;
  end;
end;

function TcBACKUP.DoBackup: Boolean;
var
  reg: TRegistry;
  sArq: String;
begin
  sArq := 'Backup ' + FormatDateTime('yyyy" "MMM" "dd" as "hh" "nn" hs"', now)+ '.gbk';
  Result := true;
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if reg.OpenKey('\Software\' + sTitle, false) then begin
      dDADOS._Conexao.Connected := False;
      try
        CopyFile(PChar(reg.ReadString('Base')), PChar(reg.ReadString('BackupDir') + '\' + sArq), False);
      except
        Result := false;
      end;
      dDADOS._Conexao.Connected := True;
      AddStatusLine(Format('Backup finalizado às %s horas', [FormatDateTime('hh:nn:ss', now)]), clGreen);
    end;
  finally
    reg.CloseKey;
    reg.Free;
  end;
end;

procedure TcBACKUP.AddStatusLine(S: string; Cor: TColor; Tamanho: byte);
begin
  Label4.Caption := S;
end;

procedure TcBACKUP.sbSairClick(Sender: TObject);
begin
  Close;
end;

procedure TcBACKUP.ssFormCreate(Sender: TObject);
var
  DiaBackup: Boolean;
  reg: TRegistry;
  i: integer;
begin
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if not reg.OpenKey('\Software\' + sTitle, false) then begin
      AgendaBackup;
      Close;
    end else begin
      try
        DiaBackup := reg.ReadBool(Dia[DayOfWeek(date)]);
      except
        DiaBackup := false;
      end;
      if not DiaBackup or not reg.OpenKey('\Software\' + sTitle + '\Horarios', false) then
        AddStatusLine('Não existe Backup agendado para hoje...', clMaroon, 12)
      else begin
        AddStatusLine(Format('Backup inicializado às %s horas', [FormatDateTime('hh:nn:ss', now)]), clNavy, 12);
        for i := low(Horarios) to high(Horarios) do begin
          Horarios[i].Hora := I;
          Horarios[i].Agendado := reg.ReadBool(formatfloat('00', i) + ':00');
        end;
        Timer.Enabled := true;
      end;
    end;
  finally
    reg.CloseKey;
  end;
end;

function TcBACKUP.HourOf(Data : TDateTime) : Word;
var
  Min, Sec, MSec: Word;
begin
  DecodeTime(Data, Result, Min, Sec, MSec);
end;

procedure TcBACKUP.sbBuscaBackupClick(Sender: TObject);
begin
  eDirBackup.Text := TcDIR.dialog();
end;

procedure TcBACKUP.SpeedButtonSelClick(Sender: TObject);
var
  I : Integer;
begin
  with SpeedButtonSel do begin
    with clbSemana do
      for I := 0 to Items.Count - 1 do
        Checked[I] := (Caption = '+');
    with clbHorarios do
      for I := 0 to Items.Count - 1 do
        Checked[I] := (Caption = '+');
    Caption := IfThen(Caption = '+', '-', '+');
  end;  
end;

procedure TcBACKUP.ToolButtonBackupClick(Sender: TObject);
begin
  with TSaveDialog.Create(Self) do begin
    InitialDir := eDirBackup.Text;
    Filter := 'Arquivos de Backup (*.gbk)|*.gbk';
    FileName := 'Backup ' + Copy(sTitle,1,Pos(' ',sTitle)-1) + '.gbk';
    if Execute then begin
      dDADOS._Conexao.Connected := False;
      CopyFile(PChar(eBase.Text), PChar(FileName), False);
      Mensagem('Backup efetuado com sucesso!');
      dDADOS._Conexao.Connected := True;
    end;
  end;
end;

procedure TcBACKUP.ToolButtonRestoreClick(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do begin
    InitialDir := eDirBackup.Text;
    Filter := 'Arquivos de Backup (*.gbk)|*.gbk';
    if Execute then begin
      dDADOS._Conexao.Connected := False;
      CopyFile(PChar(FileName), PChar(eBase.Text), False);
      Mensagem('Backup restaurado com sucesso!');
      dDADOS._Conexao.Connected := True;
    end;
  end;
end;

procedure TcBACKUP.ToolButtonAgendaClick(Sender: TObject);
begin
  Agenda;
  Mensagem('Backup agendado com sucesso!');
end;

procedure TcBACKUP.Agenda;
var
  reg: TRegistry;
  i: integer;
begin
  reg := TRegistry.Create;
  try
    try
      reg.RootKey := HKEY_LOCAL_MACHINE;
      if reg.OpenKey('\Software\' + sTitle, true) then begin
        reg.WriteString('Base', eBase.Text);
        reg.WriteString('BackupDir', eDirBackup.Text);
        for i := Low(Dia) to High(Dia) do
          reg.WriteBool(Dia[i], clbSemana.Checked[i-1]);
        if reg.OpenKey('\Software\' + sTitle + '\Horarios', True) then begin
          for i := 0 to (clbHorarios.Items.Count - 1) do begin
            reg.WriteBool(FormatFloat('00', i) + ':00', clbHorarios.Checked[i]);
          end;
        end;
      end;
      reg.CloseKey;
    except
      raise;
    end;
  finally
    reg.Free;
  end;
end;

procedure TcBACKUP.ToolButtonFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TcBACKUP.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then Close;
end;

procedure TcBACKUP.AgendaBackup;
var
  I : Integer;
begin
  eBase.Text := TcCLIENT.getPathBan();
  eDirBackup.Text := TcPATH.Backup();

  for I:=0 to clbSemana.Items.Count-1 do
    clbSemana.Checked[I] := True;

  clbHorarios.Checked[11] := True;
  clbHorarios.Checked[17] := True;

  Agenda;
end;

initialization
  cBACKUP := TcBACKUP.Create(nil);

finalization
  cBACKUP.Free;

end.
