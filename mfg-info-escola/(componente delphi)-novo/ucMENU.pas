unit ucMENU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, Menus, ExtCtrls, TypInfo,
  cAppProtect;

type
  TcMENU = class(TForm)
    _CoolBar: TCoolBar;
    _ToolBar: TToolBar;
    EditCancel: TEdit;
    Image1: TImage;
    TimerHora: TTimer;
    MainMenu1: TMainMenu;
    Usuario1: TMenuItem;
    bRelatorio: TMenuItem;
    bGrafico: TMenuItem;
    Backup1: TMenuItem;
    Parametro1: TMenuItem;
    Login1: TMenuItem;
    Configuracao1: TMenuItem;
    Sair1: TMenuItem;
    N4: TMenuItem;
    Ajuda1: TMenuItem;
    Sobre1: TMenuItem;
    ToolButtonFechar: TToolButton;
    N1: TMenuItem;
    TimerMenu: TTimer;
    Skin: TMenuItem;
    bColorControl: TMenuItem;
    N2: TMenuItem;
    bConfiguravel: TMenuItem;
    bGravarTracer: TMenuItem;
    Caminho1: TMenuItem;
    StatusBar1: TStatusBar;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure ToolButtonFormClick(Sender: TObject);

    procedure TimerHoraTimer(Sender: TObject);
    procedure TimerMenuTimer(Sender: TObject);

    procedure ManipulaExcecoes(Sender: TObject; E: Exception);

    procedure Sair1Click(Sender: TObject);
    procedure Usuario1Click(Sender: TObject);
    procedure Login1Click(Sender: TObject);
    procedure Parametro1Click(Sender: TObject);
    procedure Backup1Click(Sender: TObject);
    procedure Caminho1Click(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);

    procedure bColorControlClick(Sender: TObject);
    procedure bGravarTracerClick(Sender: TObject);
    procedure bGraficoClick(Sender: TObject);
    procedure bConfiguravelClick(Sender: TObject);
  private
    FClientInstance : TFarProc;
    FPrevClientProc : TFarProc;
    FParams: String;
    FResult: String;
    FLstMenu: String;
    FLstTipagem: String;
    FLstLookUp: String;
    FLstButton: TList;
    procedure ClientWndProc(var Message: TMessage);
    function GetResult: String;
    procedure SetParams(const Value: String);
    procedure SetLstMenu(const Value: String);
    procedure createMenu(pLstMenu : String);
    procedure ajusteMenu();
  protected
    _AppProtect : TcAppProtect;
    function AbreForm(ClassForm: TClass; pParams : String = '') : String; virtual;
  public
    bProtect, bLogin : Boolean;
    function AbreTela(pCampo : String; pParams : String = '') : String; virtual;
    function f_VerCB(pCdCampo : String) : String;
    function f_VerFK(pCdCampo : String; pCdEnt : String = '') : String;
    function f_VerLK(pCdCampo : String; pCdEnt : String = '') : String;
  published
    property _Params : String read FParams write SetParams;
    property _Result : String read GetResult write FResult;
    property _LstMenu : String read FLstMenu write SetLstMenu;
    property _LstTipagem : String read FLstTipagem write FLstTipagem;
    property _LstLookUp : String read FLstLookUp write FLstLookUp;
  end;

var
  cMENU: TcMENU;

implementation

{$R *.dfm}

uses
  ucDADOS, ucCADASTRO, ucFUNCAO, ucUSUARIO, ucLOGIN, ucPARAMETRO, ucCADASTROFUNC,
  ucBACKUP, ucSOBRE, ucCONST, ucCLIENT, ucITEM, ucXML, ucPROJETO;

var
  iNivelMenu: Integer = 0;

  procedure TcMENU.ClientWndProc(var Message: TMessage);
  var
    Dc : hDC;
    Row : Integer;  Col : Integer;
  begin
    if (Visible) then
      with Message do
        case Msg of
          WM_ERASEBKGND: begin
            Dc := TWMEraseBkGnd(Message).Dc;
            for Row := 0 to ClientHeight div Image1.Picture.Height do
              for Col := 0 to ClientWidth div Image1.Picture.Width do
                BitBlt(Dc, Col * Image1.Picture.Width, Row * Image1.Picture.Height, Image1.Picture.Width, Image1.Picture.Height, Image1.Picture.Bitmap.Canvas.Handle, 0, 0,SRCCOPY);
                Result := 1;
              end;
          else
            Result := CallWindowProc(FPrevClientProc, ClientHandle, Msg, wParam, lParam);
          end;
  end;

  //--

  procedure TcMENU.SetParams(const Value: String);
  begin
    FParams := Value;
  end;

  function TcMENU.GetResult: String;
  begin
    Result := FResult;
  end;

  procedure TcMENU.SetLstMenu(const Value: String);
  begin
    FLstMenu := Value;
    createMenu(Value);
  end;

  //--

  procedure TcMENU.createMenu(pLstMenu : String);
  var
    vLstCod, vCod, vDes, vXml : String;
    vToolButton : TToolButton;
    vImg : Integer;
  begin
    FLstButton.Add(ToolButtonFechar);

    vLstCod := listCdX(pLstMenu);
    while vLstCod <> '' do begin
      vCod := getitem(vLstCod);
      if vCod = '' then Break;
      delitem(vLstCod);

      vXml := itemX(vCod, pLstMenu);
      vDes := itemA('des', vXml);
      vImg := itemAI('img', vXml);

      if not itemAB('ata', vXml) then
        Continue;

      vToolButton := TToolButton.Create(Self);
      with vToolButton do begin
        Parent := _ToolBar;
        FreeNotification(_ToolBar);
        Name := 'ToolButton' + vCod;
        if itemAB('sep', vXml) then begin
          Style := tbsSeparator;
          Width := 8;
          Hint := vXml;
        end else begin
          Width := 48;
          Hint := vCod;
          Caption := vDes;
          ImageIndex := vImg;
          OnClick := ToolButtonFormClick;
        end;
      end;

      FLstButton.Add(vToolButton);
    end;

    FreeNotification(_ToolBar);
  end;

  procedure TcMENU.ajusteMenu();
  var
    vToolButton : TToolButton;
    vLeft, I : Integer;
  begin
    vLeft := 0;
    for I:=0 to FLstButton.Count-1 do begin
      vToolButton := TToolButton(FLstButton[I]);
      vToolButton.Left := vLeft;
      Inc(vLeft, vToolButton.Left + vToolButton.Width);
    end;

    FreeNotification(_ToolBar);
  end;

//--

function TcMENU.AbreForm(ClassForm: TClass; pParams : String = '') : String;
begin
  if (iNivelMenu=0) then
    TimerMenu.Enabled := False;

  Inc(iNivelMenu);

  with TForm(TComponentClass(ClassForm).Create(Application)) do
  try
    Hint := pParams;
    if ShowModal = mrOk then
      Result := Hint;
  finally
    Free;
  end;

  Dec(iNivelMenu);

  if (iNivelMenu=0) then
    TimerMenu.Enabled := True;
end;

function TcMENU.AbreTela(pCampo, pParams : String) : String;
var
  vXml, vDes, vCls : String;
  vClass : TClass;
begin
  vXml := itemX(pCampo, FLstMenu);
  if vXml = '' then
    Exit;

  vDes := itemA('des', vXml);
  vCls := itemA('cls', vXml);

  vClass := GetClass(vCls);
  if vClass = nil then
    Exit;

  Result := AbreForm(vClass, pParams);
end;

//--

procedure TcMENU.ToolButtonFormClick(Sender: TObject);
var
  vToolButton : TToolButton;
  vHint : String;
begin
  vToolButton := TToolButton(Sender);
  vHint := vToolButton.Hint;
  if vHint = '' then
    vHint := GetPropValue(Sender, 'Hint');
  if vHint <> '' then
    AbreTela(vHint);
end;

//--

procedure TcMENU.FormCreate(Sender: TObject);
begin
  cMENU := Self;

  _AppProtect := TcAppProtect.Create(Self);

  Top := Screen.WorkAreaTop;
  Left := Screen.WorkAreaLeft;
  Height := Screen.WorkAreaHeight;
  Width := Screen.WorkAreaWidth;

  ShortDateFormat := 'dd/mm/yyyy';
  DecimalSeparator := ',';

  Application.OnException := ManipulaExcecoes;

  FClientInstance := MakeObjectInstance(ClientWndProc);
  FPrevClientProc := Pointer(GetWindowLong(ClientHandle, GWL_WNDPROC));
  SetWindowLong(ClientHandle, GWL_WNDPROC, LongInt(FClientInstance));

  dDADOS.gNmUsuario := 'SUPORTE';
  dDADOS.gTpPrivilegio := '1';

  bColorControl.Checked := IfNullB(LerIni(CLR_SIS), True);
  bGravarTracer.Checked := LerIniB(TRA_SIS);

  bGrafico.Visible := FileExists(GRF_SIS);
  bConfiguravel.Visible := FileExists(REL_SIS);
  bRelatorio.Visible := (bGrafico.Visible) or (bConfiguravel.Visible);

  FLstButton:= TList.Create;
end;

procedure TcMENU.FormShow(Sender: TObject);
var
  v_Dias : Real;
begin
  bProtect := IfNullB(LerIni(PRT_SIS), True);

  if LerIniD(INS_SIS) = 0 then
    fGravaIni(INS_SIS,Date);

  bLogin := False;

  try
    if dDADOS.f_ExistSql('select * from ADM_USUARIO where TP_SITUACAO = 1') then
      Login1.Click;
  except
    Exit;
  end;

  if not _AppProtect.Active then begin
    v_Dias := Date - IfNullD(LerIni(INS_SIS),Date);
    if v_Dias > 30 then _AppProtect.Active := bProtect;
  end;

  Caption := Application.Title;
  if not _AppProtect.Active then
    Caption := Application.Title + ' - [ Demonstração ]';

  StatusBar1.Panels[1].Text := 'versão ' + TcPROJETO.Versao();

  TimerHoraTimer(nil);
end;

procedure TcMENU.FormActivate(Sender: TObject);
begin
  TimerHora.Enabled := True;
  TimerMenu.Enabled := True;
  ajusteMenu();
  TcCADASTROFUNC.PosicaoTela(Self);
end;

procedure TcMENU.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close();
    VK_RETURN: Sair1.Click;
  end;
end;

procedure TcMENU.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not Pergunta('Deseja sair da aplicação') then
    Action := caNone;
end;

//--

procedure TcMENU.TimerHoraTimer(Sender: TObject);
begin
  StatusBar1.Panels[2].Text := dDADOS.gNmUsuario;
  StatusBar1.Panels[3].Text := FormatDateTime('dd/mm/yy" - "hh:mm', Now);
  StatusBar1.Panels[4].Text := 'ip: ' + dDADOS.gIpComputador;
  StatusBar1.Panels[5].Text := '';
end;

procedure TcMENU.ManipulaExcecoes(Sender: TObject; E: Exception);
begin
  if (E.Message = 'Key violation') then
    raise Exception.Create('Registro já existe cadastrado no banco de dados!');

  Mensagem(E.Message);
  p_Grava_Log(E.Message);
end;

///--

procedure TcMENU.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TcMENU.Usuario1Click(Sender: TObject);
begin
  if Pos(dDADOS.gTpPrivilegio, '1|2') = 0 then
    raise Exception.Create(cMESSAGE_SEMPERMISSAO);

  AbreForm(TcUSUARIO);
end;

procedure TcMENU.Login1Click(Sender: TObject);
var
  vResult : String;
begin
  vResult := TcLOGIN.ValidaSenha();

  dDADOS.gNmUsuario := vResult;
  dDADOS.gTpPrivilegio := '1';
  if (dDADOS.gNmUsuario <> 'SUPORTE') then begin
    dDADOS.gTpPrivilegio := dDADOS.f_ConsultaStrSql(
      'select TP_PRIVILEGIO from ADM_USUARIO where NM_LOGIN=''' + dDADOS.gNmUsuario + ''' ', 'TP_PRIVILEGIO');
  end;

  bConfiguravel.Visible := (dDADOS.gNmUsuario = 'SUPORTE');
  bGrafico.Visible := (dDADOS.gNmUsuario = 'SUPORTE');

  bLogin := True;

  _AppProtect.Active := (bProtect);
end;

procedure TcMENU.Parametro1Click(Sender: TObject);
begin
  if Pos(dDADOS.gTpPrivilegio, '1|2') = 0 then
    raise Exception.Create(cMESSAGE_SEMPERMISSAO);

  AbreForm(TcPARAMETRO);
end;

procedure TcMENU.Backup1Click(Sender: TObject);
begin
  if Pos(dDADOS.gTpPrivilegio, '1|2') = 0 then
    raise Exception.Create(cMESSAGE_SEMPERMISSAO);

  TimerMenu.Enabled := False;
  cBACKUP.ShowModal;
  TimerMenu.Enabled := True;
end;

procedure TcMENU.Caminho1Click(Sender: TObject);
begin
  if Pos(dDADOS.gTpPrivilegio, '1|2') = 0 then
    raise Exception.Create(cMESSAGE_SEMPERMISSAO);

  AbreForm(TcCLIENT);
end;

procedure TcMENU.Sobre1Click(Sender: TObject);
begin
  AbreForm(TcSOBRE);
end;

//--

procedure TcMENU.TimerMenuTimer(Sender: TObject);
begin
  if (dDADOS.f_ExistSql('select * from ADM_USUARIO where TP_SITUACAO = 1')) then begin
    Login1Click(nil);
  end;
end;

//--

procedure TcMENU.bColorControlClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  fGravaIni(CLR_SIS, TMenuItem(Sender).Checked);
end;

procedure TcMENU.bGravarTracerClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  fGravaIni(TRA_SIS, TMenuItem(Sender).Checked);
end;

procedure TcMENU.bGraficoClick(Sender: TObject);
begin
  WinExec(PChar(GRF_SIS + ' "' + ParamStr(0) + '"'), 0);
end;

procedure TcMENU.bConfiguravelClick(Sender: TObject);
begin
  WinExec(PChar(REL_SIS + ' "' + ParamStr(0) + '"'), 0);
end;

//-- combobox
//   Codigo [                              ]|V|
function TcMENU.f_VerCB(pCdCampo : String) : String;
begin
  Result := itemX(pCdCampo, FLstTipagem);
  if Result = '' then Result := itemX(pCdCampo, cLST_TIPAGEM);
end;

//-- foregn key (origem de uma entidade)
//   Codigo [     ][                              ]|V|
function TcMENU.f_VerFK(pCdCampo : String; pCdEnt : String) : String;
var
  vXml : String;
begin
  Result := '';

  vXml := itemX(pCdCampo, FLstMenu);
  if vXml <> '' then begin
    if pCdEnt = itemA('ent', vXml) then
      Exit;
    putitem(Result, 'CD_CAMPO', pCdCampo);
    putitem(Result, 'DS_TABELA', itemA('ent', vXml));
    putitem(Result, 'DS_CAMPO', itemA('fld', vXml));
  end;
end;

//-- lookup (combobox gerado origem de uma entidade)
//   Codigo [                              ]|V|
function TcMENU.f_VerLK(pCdCampo : String; pCdEnt : String) : String;
var
  vXml : String;
begin
  Result := '';

  vXml := itemX(pCdCampo, FLstLookUp);
  if vXml <> '' then begin
    if pCdEnt = itemA('ent', vXml) then
      Exit;   
    putitem(Result, 'CD_CAMPO', pCdCampo);
    putitem(Result, 'DS_TABELA', itemA('ent', vXml));
    putitem(Result, 'DS_CAMPO', itemA('fld', vXml));
  end;
end;

//--

end.
