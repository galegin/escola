unit ucCOMPPESQ;

interface

uses
  Classes, SysUtils, StdCtrls, StrUtils,
  Forms, Controls, Messages, Windows,
  ucCOMP;

type
  TcComboBoxPesq = class(TcComboBox)
  private
    FEditCod : TEdit;
  protected
  public
    constructor create(Aowner : TComponent); override;
    procedure DoEnter(); override;
    procedure DoExit(); override;
    procedure DropDown(); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    function pesquisar() : String; overload;
    class function Pesquisar(pParams : String) : String; overload;
  published
    property _EditCod : TEdit read FEditCod write FEditCod;
  end;

  TcEditCad = class(TcEdit)
  private
    FEditCod : TEdit;
  protected
  public
    constructor create(Aowner : TComponent); override;
    procedure DoEnter(); override;
    procedure DoExit(); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    function pesquisar() : String; overload;
  published
    property _EditCod : TEdit read FEditCod write FEditCod;
  end;

implementation

uses
  ucFUNCAO, ucDADOS, ucITEM, ucXML, ucCADASTROFUNC;

{ TcComboBoxPesq }

constructor TcComboBoxPesq.create(Aowner: TComponent);
begin
  inherited;
  Style := csDropDown;
  DropDownCount := 5;
end;

procedure TcComboBoxPesq.DoEnter(); begin {} end;
procedure TcComboBoxPesq.DoExit(); begin {} end;
procedure TcComboBoxPesq.DropDown(); begin {} end;
procedure TcComboBoxPesq.KeyDown(var Key: Word; Shift: TShiftState); begin {} end;

procedure TcComboBoxPesq.KeyPress(var Key: Char);
begin
  if Key = chr(VK_SPACE) then begin
    pesquisar();
  end else begin
    TcCADASTROFUNC.EditKeyPressDescr(Self, Key);
  end;
end;

function TcComboBoxPesq.pesquisar(): String;
var
  vParams, vResult,
  vLstCod, vCod, vEnt, vDes, vVal : String;
  vTotal : Integer;
begin
  Result := '';

  vParams := FEditCod.Hint;
  if vParams = '' then
    Exit;

  vEnt := item('DS_TABELA', vParams);
  vCod := item('CD_CAMPO', vParams);
  vDes := item('DS_CAMPO', vParams);
  vVal := AllTrim(Text);
  vVal := AnsiReplaceStr(vVal, '*', '%');
  if vVal = '' then
    Exit;

  vParams := '';
  putitemX(vParams, 'DS_TABELA', vEnt);
  putitemX(vParams, 'CD_CAMPO', vCod);
  putitemX(vParams, 'DS_CAMPO', vDes);
  putitemX(vParams, 'VL_CAMPO', vVal);
  vResult := Pesquisar(vParams);

  p_Clear();

  vLstCod := listCd(vResult);
  vVal := getitem(vLstCod);
  vTotal := ucFuncao.itemcount(vLstCod);
  if vTotal > 1 then begin
    p_AddLista(vResult);
    FEditCod.Text := vVal;
    Text := item(vVal, vResult);
    ItemIndex := 0;
    DroppedDown := True;
    SetFocus;
    keybd_event(VK_DOWN, 0, 0, 0);
    keybd_event(VK_UP, 0, 0, 0);
  end else if vTotal = 1 then begin
    FEditCod.Text := vVal;
    Text := item(vVal, vResult);
    SelStart := Length(Text);
  end else if vTotal = 0 then begin
    FEditCod.Text := '';
    Text := '';
  end;
end;

class function TcComboBoxPesq.Pesquisar(pParams : String) : String;
var
  vParams,
  vEnt, vCod, vDes, vVal : String;
begin
  Result := '';

  vEnt := item('DS_TABELA', pParams);
  vCod := item('CD_CAMPO', pParams);
  vDes := item('DS_CAMPO', pParams);
  vVal := AllTrim(item('VL_CAMPO', pParams));

  // busca exata
  vParams := '';
  putitemX(vParams, 'DS_TABELA', vEnt);
  putitemX(vParams, 'CD_KEY', vCod);
  putitemX(vParams, 'DS_KEY', vDes);
  putitemX(vParams, 'DS_WHR', vDes + ' = ''' + vVal + '''');
  Result := dDADOS.f_GeraListaTabela(vParams);

  // busca parcial
  if Result = '' then begin
    vVal := AnsiReplaceStr(vVal, ' ', '%') + '%';

    vParams := '';
    putitemX(vParams, 'DS_TABELA', vEnt);
    putitemX(vParams, 'CD_KEY', vCod);
    putitemX(vParams, 'DS_KEY', vDes);
    putitemX(vParams, 'DS_WHR', vDes + ' like ''' + vVal + '''');
    Result := dDADOS.f_GeraListaTabela(vParams);
  end;
end;

{ TcEditCad }

constructor TcEditCad.create(Aowner: TComponent);
begin
  inherited;
end;

procedure TcEditCad.DoEnter;
begin
  inherited;
end;

procedure TcEditCad.DoExit;
begin
  inherited;
end;

procedure TcEditCad.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
end;

procedure TcEditCad.KeyPress(var Key: Char);
begin
  inherited;
end;

function TcEditCad.pesquisar: String; begin {} end;

end.
