unit ucCOMBOPESQ;

interface

uses
  Classes, SysUtils, StdCtrls, StrUtils,
  Forms, Controls, Messages, Windows,
  ucCOMP;

type
  TcComboBoxPesq = class(TcComboBox)
  private
    FEditCod : TEdit;
    FEditDes : TEdit;
    procedure SetEditCod(const Value: TEdit);
  protected
  public
    constructor create(Aowner : TComponent); override;
    procedure DoEnter(); override;
    procedure DoExit(); override;
    procedure DropDown(); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    function pesquisar() : String;
  published
    property _EditCod : TEdit read FEditCod write SetEditCod;
    property _EditDes : TEdit read FEditDes write FEditDes;
  end;

implementation

uses
  ucFUNCAO, ucDADOS, ucITEM, ucXML;

{ TcComboBox }

constructor TcComboBoxPesq.create(Aowner: TComponent);
begin
  inherited;

  (* vCombo := TcComboBox.Create(vEditDes.Owner);
  with vCombo do begin
    Parent := vEditDes.Parent;
    Name := 'ComboEditCad';
    Top := vEditDes.Top;
    Left := vEditDes.Left;
    Height := vEditDes.Height;
    Width := vEditDes.Width;
    TabOrder := vEditDes.TabOrder + 1;
    TabStop := False;
    Style := csDropDownList;
    p_AddLista(vResult);
    _Value := vVal;
    Hint := vEditCod.Name + '|' + vEditDes.Name;
    DropDownCount := 5;
    DroppedDown := True;
    OnExit := ComboBox_OnExit;
    BringToFront;
    SetFocus;
    Exit;
  end; *)
end;

procedure TcComboBoxPesq.SetEditCod(const Value: TEdit);
begin
  if (FEditCod <> Value) then begin
    FEditCod := Value;
    FEditDes := TEdit(TForm(FEditCod.Owner).FindComponent('d' + FEditCod.Name));
  end;
end;

procedure TcComboBoxPesq.DoEnter();
begin

end;

procedure TcComboBoxPesq.DoExit();
begin
  FEditCod.Text := _Value;
  FEditDes.Text := Text;
  SendToBack;
end;

procedure TcComboBoxPesq.DropDown();
begin

end;

procedure TcComboBoxPesq.KeyDown(var Key: Word; Shift: TShiftState);
begin

end;

procedure TcComboBoxPesq.KeyPress(var Key: Char);
begin
  (* if Key = chr(VK_SPACE) then
    pesquisar(); *)
end;

function TcComboBoxPesq.pesquisar(): String;
(* var
  vParams, vResult,
  vEnt, vCod, vDes, vSeq, vExp, vVal : String;
  vEditDes : TEdit; *)
begin
  (* Result := '';

  vParams := FEditCod.Hint;
  if vParams = '' then
    Exit;

  vEnt := item('DS_TABELA', vParams);
  vCod := item('CD_CAMPO', vParams);
  vDes := item('DS_CAMPO', vParams);

  // busca exata
  vExp := AllTrim(vEditDes.Text);
  vParams := '';
  putitemX(vParams, 'DS_TABELA', vEnt);
  putitemX(vParams, 'CD_KEY', vCod);
  putitemX(vParams, 'DS_KEY', vDes);
  putitemX(vParams, 'DS_WHR', vDes + ' = ''' + vExp + '''');
  vResult := dDADOS.f_GeraListaTabela(vParams);

  // busca parcial
  if vResult = '' then begin
    vExp := AllTrim(vEditDes.Text);
    vExp := AnsiReplaceStr(vExp, ' ', '%') + '%';
    vParams := '';
    putitemX(vParams, 'DS_TABELA', vEnt);
    putitemX(vParams, 'CD_KEY', vCod);
    putitemX(vParams, 'DS_KEY', vDes);
    putitemX(vParams, 'DS_WHR', vDes + ' like ''' + vExp + '''');
    vResult := dDADOS.f_GeraListaTabela(vParams);
  end; *)
end;

end.
