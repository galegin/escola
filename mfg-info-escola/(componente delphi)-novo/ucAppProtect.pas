{**
*  TcAppProtect
*
*  Copyright 1999, 2000 by Sebastião Elivaldo Ribeiro
*  http://www.utranet.com.br/~elivaldo
*  e-mail: elivaldo@utranet.com.br
*}

unit ucAppProtect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Registry;

type
  TcAppProtect = class(TComponent)
  private
    FActive: Boolean;
    FRegKey: String;
    FIdApplication: Longint;
    FOnLoadError: TNotifyEvent;
    FAppName: TFileName;
    FCurrentLoad: Word;
    FDateStart: TDate;
    FDateEnd: TDate;
    FDecodeInfo: Boolean;
    FMaxLoad: Word;
    FOwner: TComponent;

    FDialog: Boolean;

    procedure SetActive(Value: Boolean);
    procedure SetRegKey(Value: String);
    function CheckLockInfo() : String;
    procedure DecodeLockInfo(S: String);
    procedure InitializeRegistry;
    procedure IncrementCounter;

    function ResetLockApplication() : String;
    function ValidateLockInfo(S: String) : Boolean;
    procedure WriteRegistry(S: String);
    function EncodeLockInfo: String;
    function IsLockApplication: Boolean;
    function ReadRegistry: String;
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;

    class function execute(pAppName : String = '') : String;
    class function verificar(Sender : TObject) : String;
    class function validar(S : String) : Boolean;

    class function GetKey(S: String): String;
    class function Criptografe(S, K: String): String;
    class function Uncriptografe(S, K: String): String;
    class function IsHexa(S: String): Boolean;

    class function GetNumberHD(pParams : String = '') : String;

    class function GetSerNumber(pParams : String = '') : String;
    class function GetLiberacao(pParams : String = '') : String;

    property DateStart: TDate read FDateStart;
    property DateEnd: TDate read FDateEnd;
    property MaxLoad: Word read FMaxLoad;
    property CurrentLoad: Word read FCurrentLoad;
  published
    property Active: Boolean read FActive write SetActive;
    property IdApplication: Longint read FIdApplication write FIdApplication;
    property RegKey: String read FRegKey write SetRegKey;
    property AppName: TFileName read FAppName write FAppName;
    property OnLoadError: TNotifyEvent read FOnLoadError write FOnLoadError;
    property _Dialog : Boolean read FDialog write FDialog;
  end;

const
  cMIN_DATA = '01/01/1900';
  cMAX_DATA = '31/12/2100';
  cMAX_LOAD = 65535;

procedure Register;

implementation

uses
  ufAppProtect, ucFuncao, ucItem, ucXml;

{ TcAppProtect }

const
  REGKEY_PATH = '\SOFTWARE\MFGInfo\';
  REGKEY_SIZE = 24;
  CODLIB_SIZE = 18;
  CODSER_SIZE = 14;

  ID_APLICACAO = 214375357;

var
  FSetup: Word;

resourceString
  SCodErro = 'O código de liberação informando não é válido ou foi digitado incorretamente.';

  //--
  // ReadRegistry
  function TcAppProtect.ReadRegistry: String;
  var
    Reg: TRegistry;
  begin
    Result := '';
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      if Reg.OpenKey(FRegKey + FAppName, False) then begin
        Result := Reg.ReadString('LockInfo');
      end;
    finally
      Reg.CloseKey;
      Reg.Free;
    end;
  end;

  // WriteRegistry
  procedure TcAppProtect.WriteRegistry(S: String);
  var
    Reg: TRegistry;
  begin
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      if Reg.OpenKey(FRegKey + FAppName, True) then begin
        Reg.WriteString('LockInfo', S);
      end;
    finally
      Reg.CloseKey;
      Reg.Free;
    end;
  end;

  //--
  // GetKey
  class function TcAppProtect.GetKey(S: String): String;
  var
    I, T: Integer;
  begin
    T := 0;
    for I := 1 to Length(S) do begin
      T := T + (StrToInt('$' + S[I]) * I);
    end;
    Result := Format('%.2x', [T mod 256]);
  end;

  //--
  // HexaString
  function GetHexaString(S : String) : String;
  var
    I : Integer;
  begin
    Result := '';
    for I:=1 to Length(S) do begin
      Result := Result + IntToHex(Ord(S[I]),3);
    end;
  end;

  function GetStringHexa(S : String) : String;
  begin
    Result := '';
    while (S <> '') do begin
      Result := Result + Chr(StrToInt('$' + Copy(S,1,3)));
      Delete(S,1,3);
    end;
  end;

  //--
  // Uncriptografe
  class function TcAppProtect.Uncriptografe(S, K: String): String;
  var
    I, JK, JS: Byte;
  begin
    Result := '';
    for I := 1 to Length(S) do begin
      JK := StrToInt('$' + K[I mod Length(K) + 1]);
      JS := StrToInt('$' + S[I]);
      Result := Result + Format('%.1x', [JK xor JS]);
    end;
  end;

  // Criptografe
  class function TcAppProtect.Criptografe(S, K: String): String;
  begin
    Result := Uncriptografe(S, K);
  end;

  // IsHexa
  class function TcAppProtect.IsHexa(S: String): Boolean;
  var
    I: Byte;
  begin
    Result := True;
    for I := 1 to Length(S) do begin
      Result := Result and (S[I] in ['0'..'9', 'A'..'F']);
    end;
  end;

  //--
  class function TcAppProtect.execute(pAppName : String) : String;
  var
    vAux, vSen : String;
    vForm : TForm;
  begin
    Result := '';

    if IsDelphiOpen() then
      Exit;

    // ambiente + empresa + terminal + number HD
    (* vAux := LerIni('CD_SERIALAMB');
    if vAux <> '' then begin
      vSen := TmAppSerial.GetSerialAmb(pAppName);
      if vAux = vSen then Exit;
    end; *)

    vForm := TForm.Create(Application);
    with TcAppProtect.Create(vForm) do begin
      AppName := IfNull(pAppName, AppName);
      Active := True;
      Result := CheckLockInfo();
      Free;
    end;

    FreeAndNil(vForm);
  end;

  class function TcAppProtect.verificar(Sender : TObject) : String;
  begin
    with TcAppProtect.Create(TForm(Sender)) do begin
      FDialog := (Sender <> nil);
      Result := CheckLockInfo();
      Free;
    end;
  end;

  class function TcAppProtect.validar(S : String) : Boolean;
  begin
    with TcAppProtect.Create(nil) do begin
      FDialog := False;
      Result := ValidateLockInfo(S);
      Free;
    end;
  end;

  //--
  class function TcAppProtect.GetNumberHD(pParams : String) : String;
  var
    SerNumber, CompLen, SysFlags: DWORD;
    LabName: array[0..199] of Char;
    FileSys: array[0..19] of Char;
    Unidade: String;
  begin
    Unidade := IfNull(itemX('CD_UNIDADE', pParams), 'C');
    if (Pos(':\', Unidade) = 0) then Unidade := Unidade + ':\';
    if GetVolumeInformation(PChar(Unidade), @LabName, 200, @SerNumber, CompLen, SysFlags, @FileSys, 20) then begin
      Result := Format('%.8x', [SerNumber]);
    end;
  end;

  //--
  class function TcAppProtect.GetSerNumber(pParams : String) : String;
  var
    Body : String;
  begin
    with TcAppProtect.Create(nil) do begin
      Body := Format('%.4x', [FSetup]) + GetNumberHD();
      Result := Criptografe(Body, Format('%.x', [FIdApplication])) + GetKey(Body);
      Free;
    end;
  end;

  //--
  class function TcAppProtect.GetLiberacao(pParams : String) : String;
  var
    FNumberHD, FNumberProc, FNumberRede, S, C, Body, Key : String;
  begin
    Result := '';

    with TcAppProtect.Create(nil) do begin

      //--------------------------------------------------------------------------
      // numero de serie SETUP (4) + HD (8) = 12 + KEY(2) = 14
      // numero de serie SETUP (4) + HD (8) + CPU (8) + MAC (12) = 32 + KEY(2) = 30
      S := item('NR_SERIAL', pParams);
      if (Length(S) = CODSER_SIZE)
      and IsHexa(S) then begin
        Body := Uncriptografe(Copy(S,1,CODSER_SIZE-2), Format('%.x', [FIdApplication]));
        Key := GetKey(Body);
        if (GetKey(Body) = Copy(S,CODSER_SIZE-1,2)) then begin
          FSetup := StrToInt('$' + Copy(Body, 1, 4));
          FNumberHD := Copy(Body, 5, 8);
          FNumberProc := Copy(Body, 13, 8);
          FNumberRede := Copy(Body, 21, 12);
        end else begin
          Result := 'erro digito de validacao do serial';
          Exit;
        end;
      end else begin
        Result := 'formato invalido de serial';
        Exit;
      end;

      //--------------------------------------------------------------------------
      // codigo de liberacao SERIAL (16) + KEY (2)
      // DT_INICIAL (4) + DT_FINAL (4) + NR_EXECUCAO (4) + SETUP (4)
      FDateStart := StrToDate(IfNull(item('DT_INICIAL', pParams), cMIN_DATA));
      FDateEnd := StrToDate(IfNull(item('DT_FINAL', pParams), cMAX_DATA));
      FMaxLoad := IfNullI(item('QT_EXECUCAO', pParams), cMAX_LOAD);

      C := Format('%.4x', [trunc(FDateStart)]) +
           Format('%.4x', [trunc(FDateEnd)]) +
           Format('%.4x', [FMaxLoad]) +
           Format('%.4x', [FSetup]);

      Body := Criptografe(C, FNumberHD) + GetKey(C);

      //----------------------------------------------------------------------------
      // retorna
      putitem(Result, 'NR_SETUP', FSetup);
      putitem(Result, 'CD_LIBERACAO', Body);
      putitem(Result, 'NR_DISCORIGIDO', FNumberHD);
      putitem(Result, 'NR_PROCESSADOR', FNumberProc);
      putitem(Result, 'NR_PLACAREDE', FNumberRede);

      Free;
    end;
  end;

//--
// Register
procedure Register;
begin
  RegisterComponents('Comps MIGUEL', [TcAppProtect]);
end;

//--
// Create
constructor TcAppProtect.Create(AOwner: TComponent);
const
  bShareware : Boolean = False;
begin
  inherited Create(AOwner);
  FActive := True;
  FIdApplication := ID_APLICACAO;
  FAppName := IfNull(Application.Name, Application.Title);
  FRegKey := REGKEY_PATH;
  FOwner := AOwner;
  FDialog := True;
  Randomize;
end;

//--
// SetActive
procedure TcAppProtect.SetActive(Value: Boolean);
begin
  if FActive <> Value then begin
    FActive := Value;
    if not (csDesigning in ComponentState)
    and not (csLoading in ComponentState)
    and FActive then begin
      CheckLockInfo;
    end;
  end;
end;

// SetRegKey
procedure TcAppProtect.SetRegKey(Value: String);
begin
  if Value = '' then Value := REGKEY_PATH;
  if Copy(Value, Length(Value), 1) <> '\' then Value := Value + '\';
  FRegKey := Value;
end;

// Loaded
procedure TcAppProtect.Loaded;
begin
  inherited Loaded;
  if not (csDesigning in ComponentState)
  and FActive then begin
    CheckLockInfo;
  end;
end;

// InitializeRegistry
procedure TcAppProtect.InitializeRegistry;
var
  S: String;
begin
  S := ReadRegistry;
  if (Length(S) <> REGKEY_SIZE)
  or not IsHexa(S) then begin
    FDateStart := Random(1000);
    FDateEnd := $FFFF - Random(1000);
    FMaxLoad := 0;
    FCurrentLoad := 1;
    FSetup := Random(High(Word));
    WriteRegistry(EncodeLockInfo);
  end;
end;

// EncodeLockInfo
function TcAppProtect.EncodeLockInfo: String;
var
  S: String;
begin
  S := Format('%.4x', [Trunc(FDateStart)]) +
       Format('%.4x', [Trunc(FDateEnd)]) + Format('%.4x', [FMaxLoad]) +
       Format('%.4x', [FCurrentLoad]) + Format('%.4x', [FSetup]) +
       GetKey(GetNumberHD());
  Result := Criptografe(S, Format('%.x', [FIdApplication])) + GetKey(S);
end;

// DecodeLockInfo
procedure TcAppProtect.DecodeLockInfo(S: String);
var
  Info: String;
begin
  FDecodeInfo := False;
  if (Length(S) = REGKEY_SIZE) and IsHexa(S) then begin
    Info := Uncriptografe(Copy(S, 1, 22), Format('%.x', [FIdApplication]));
    if (GetKey(Info) = Copy(S, 23, 2))
    and (GetKey(GetNumberHD()) = Copy(Info, 21, 2)) then begin
      FDateStart := StrToInt('$' + Copy(Info, 1, 4));
      FDateEnd := StrToInt('$' + Copy(Info, 5, 4));
      FMaxLoad := StrToInt('$' + Copy(Info, 9, 4));
      FCurrentLoad := StrToInt('$' + Copy(Info, 13, 4));
      FSetup := StrToInt('$' + Copy(Info, 17, 4));
      FDecodeInfo := True;
    end;
  end;
end;

// CheckLockInfo
function TcAppProtect.CheckLockInfo() : String;
begin
  InitializeRegistry;
  DecodeLockInfo(ReadRegistry);

  if IsLockApplication then begin
    // se o motivo do bloqueio foi expiração de data então define
    // um novo valor para Setup
    if (Date > FDateEnd)
    or (Date < FDateStart) then begin
      WriteRegistry('');
      InitializeRegistry;
    end;

    // tenta obter novo código de liberação
    Result := ResetLockApplication();

    // verifica novamente
    if IsLockApplication then begin
      if Assigned(FOnLoadError) then begin
        FOnLoadError(Self)
      end else begin
        if (FDialog) then Application.Terminate
        else Exit;
      end;
    end else begin
      IncrementCounter; // salva incremento do contador
    end;
  end else begin
    IncrementCounter; // salva incremento do contador
  end;
end;

// IsLockApplication
function TcAppProtect.IsLockApplication: Boolean;
begin
  Result := not (FDecodeInfo and (FMaxLoad > FCurrentLoad) and
                (Date >= FDateStart) and (Date <= FDateEnd));
end;

// IncrementCounter
procedure TcAppProtect.IncrementCounter;
begin
  Inc(FCurrentLoad);
  if FMaxLoad <= FCurrentLoad then FSetup := Random(High(Word));
  WriteRegistry(EncodeLockInfo);
end;

// ResetLockApplication
function TcAppProtect.ResetLockApplication() : String;
var
  SerNumber: String;
begin
  Result := '';

  // número de série
  SerNumber := GetSerNumber();

  // grava resultado
  putitemX(Result, 'IN_BLOQUEIO', True);
  putitemX(Result, 'NR_SERIAL', SerNumber);

  // formulário de reset
  if (FDialog) then begin
    with TfAppProtect.CreateNew(Self) do begin
      CreateDialog(FOwner);
      EdtSN.Text := SerNumber;
      if ShowModal = mrOk then  begin
        ValidateLockInfo(EdtCR.Text);
        DecodeLockInfo(ReadRegistry);
      end;
      Free;
    end;
  end;
end;

// ValidateLockInfo
function TcAppProtect.ValidateLockInfo(S : String) : Boolean;
var
  Body: String;
begin
  Result := False;

  // verifica a validade no Código de Liberação
  if (Length(S) = CODLIB_SIZE)
  and IsHexa(S) then begin
    Body := Uncriptografe(Copy(S, 1, 16), GetNumberHD());
    if (GetKey(Body) = Copy(S, 17, 2))
    and (FSetup = StrToInt('$' + Copy(Body, 13, 4))) then begin
      FDateStart := StrToInt('$' + Copy(Body, 1, 4));
      FDateEnd := StrToInt('$' + Copy(Body, 5, 4));
      FMaxLoad := StrToInt('$' + Copy(Body, 9, 4));
      FCurrentLoad := 0;
      Result := True;
      WriteRegistry(EncodeLockInfo);
    end;
  end;

  // validade do número
  if (Result = False)
  and (FDialog) then ShowMessage(SCodErro);
end;

//--
begin
  FSetup := Random(High(Word));

//--
end.