unit ucCOMP;

interface

uses
  Classes, StdCtrls, Graphics, SysUtils,
  Messages, Controls, Forms, Windows;

type
  TcString = class // mString
  private
    FStr : String;
  public
    constructor create(); overload;
    constructor create(pStr : String); overload;
  published
    property _Str : String read FStr write FStr;
  end;

  TcStringList = class(TStringList) // mStringList
  private
    function GetValueInd(vIndex : Integer) : String;
  public
    procedure p_Clear;
    procedure p_AddRow(pDsValue, pDsItem : String);
    procedure p_AddLista(pDsLista : String);
  end;

  TcComboBox = class(TComboBox) // mCombo
  private
    FCampo : String;
    function GetValueInd(vIndex : Integer) : String;
    function GetValue: String;
    procedure SetValue(const Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    procedure p_Clear;
    procedure p_AddRow(pDsValue, pDsItem : String);
    procedure p_AddLista(pDsLista : String);
  published
    property _Campo : String read FCampo write FCampo;
    property _Value : String read GetValue write SetValue;
  end;

  TpDado = (tpdAlfa, tpdData, tpdInteiro, tpdNumero);

  TcEdit = class(TEdit) // mEdit
  private
    FAlignment : TAlignment;
    FColorEnter : TColor;
    FColorExit : TColor;
    FLstTeclas : String;
    FTpDado : TpDado;
    FCampo : String;
    procedure SetTpDado(const Value: TpDado);
    procedure SetAlignment(const Value: TAlignment);
    function GetValue: String;
    procedure SetValue(const Value: String);
  protected
    procedure CMChanged(var Message: TMessage); message CM_CHANGED;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyPress(var Key: Char); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property _Alignment : TAlignment Read FAlignment Write SetAlignment Default taLeftJustify;
    property _TpDado : TpDado read FTpDado write SetTpDado;
    property _Campo : String read FCampo write FCampo;
    property _Value : String read GetValue write SetValue;
  end;

  procedure register;

implementation

uses
  ucFUNCAO, ucITEM;

procedure register;
begin
  RegisterComponents('Comps ANT', [TcComboBox]);
  RegisterComponents('Comps ANT', [TcEdit]);
end;

{ TcString }

constructor TcString.create;
begin
  FStr := '';
end;

constructor TcString.create(pStr: String);
begin
  FStr := pStr;
end;

{ TcStringList }

function TcStringList.GetValueInd(vIndex: Integer): String;
var
  vObject : TObject;
begin
  if vIndex > -1 then begin
    vObject := Objects[vIndex];
    if vObject.InheritsFrom(TcString) then
      Result := TcString(vObject)._Str;
  end else
    Result := '';
end;

//--

procedure TcStringList.p_Clear;
begin
  Clear;
end;

procedure TcStringList.p_AddRow(pDsValue, pDsItem: String);
begin
  AddObject(pDsItem, TcString.create(pDsValue));
end;

procedure TcStringList.p_AddLista(pDsLista: String);
var
  vLstCod, vCod, vVal : String;
  I : Integer;
begin
  p_Clear;

  if Pos('|', pDsLista) > 0 then begin
    while pDsLista <> '' do begin
      vVal := getitem(pDsLista);
      if vVal = '' then Break;
      delitem(pDsLista);
      p_AddRow(IntToStr(I), vVal);
      Inc(I);
    end;
    Exit;
  end;

  vLstCod := listCd(pDsLista);
  while vLstCod <> '' do begin
    vCod := getitem(vLstCod);
    if vCod = '' then Break;
    delitem(vLstCod);
    vVal := item(vCod, pDsLista);
    p_AddRow(vCod, vVal);
  end;
end;

{ TcComboBox }

constructor TcComboBox.Create(AOwner: TComponent);
begin
  inherited;
end;

//--

function TcComboBox.GetValue: String;
begin
  Result := GetValueInd(ItemIndex);
end;

procedure TcComboBox.SetValue(const Value: String);
var
  I : Integer;
begin
  with Items do
    for I:=0 to Count-1 do
      if GetValueInd(I) = Value then begin
        ItemIndex := I;
        Exit;
      end;
end;

//--

function TcComboBox.GetValueInd(vIndex : Integer) : String;
begin
  Result := TcStringList(Items).GetValueInd(vIndex);
end;

//--

procedure TcComboBox.p_Clear;
begin
  TcStringList(Items).p_Clear;
end;

procedure TcComboBox.p_AddRow(pDsValue, pDsItem : String);
begin
  TcStringList(Items).p_AddRow(pDsValue, pDsItem);
end;

procedure TcComboBox.p_AddLista(pDsLista : String);
begin
  TcStringList(Items).p_AddLista(pDsLista);
end;

{ TcEdit }

constructor TcEdit.Create(AOwner: TComponent);
begin
  inherited;
  FColorEnter := clYellow;
  FColorExit := clWindow;
  FAlignment := taLeftJustify;
  FTpDado := tpdAlfa;
end;

procedure TcEdit.SetAlignment(const Value: TAlignment);
begin
  if FAlignment <> Value then begin
    FAlignment := Value;
    if Handle <> 0 then begin
      Perform(CM_RECREATEWND, 0, 0);
    end;
  end;
end;

procedure TcEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: Array[TAlignment] of Cardinal = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style and (not 0) or (Alignments[FAlignment]);
end;

procedure TcEdit.SetTpDado(const Value: TpDado);
begin
  FTpDado := Value;

  if (FTpDado in [tpdInteiro, tpdNumero]) then begin
    _Alignment := taRightJustify;
  end else if (FTpDado in [tpdData]) then begin
    _Alignment := taCenter;
  end;
end;

procedure TcEdit.CMChanged(var Message: TMessage);
begin
  if Parent <> nil then Parent.WindowProc(Message);
end;

procedure TcEdit.CMEnter(var Message: TCMEnter);
begin
  if TabStop and not ReadOnly then begin
    Color := FColorEnter;
  end;

  if SysLocale.MiddleEast then
    if UseRightToLeftReading then begin
      if Application.BiDiKeyboard <> '' then
        LoadKeyboardLayout(PChar(Application.BiDiKeyboard), KLF_ACTIVATE);
    end else
      if Application.NonBiDiKeyboard <> '' then
        LoadKeyboardLayout(PChar(Application.NonBiDiKeyboard), KLF_ACTIVATE);

  selectAll;

  DoEnter;
end;

procedure TcEdit.CMExit(var Message: TCMExit);
var
  vTexto, vErro : String;

  procedure getValueData();
  var
    vText : String;
  begin
    if (Pos('/', Text) > 0) then Exit;
    vText := SoDigitos(Text);
    if (Length(vText) = 2) then begin
      vTexto := vText + '/' + FormatDateTime('mm/yyyy', Date);
    end else if (Length(vText) = 4) then begin
      vTexto := Copy(vText,1,2) + '/' + Copy(vText,3,2) + '/' + FormatDateTime('yyyy', Date);
    end else if (Length(vText) = 6) then begin
      vTexto := Copy(vText,1,2) + '/' + Copy(vText,3,2) + '/' + Copy(vText,5,2);
      vTexto := FormatDateTime('dd/mm/yyyy', StrToDate(vTexto));
    end;
  end;

begin
  if TabStop and not ReadOnly then begin
    Color := FColorExit;
  end;

  vTexto := Text;

  if (vTexto <> '') then begin
    vErro := '';

    if (FTpDado in [tpdData]) then begin
      getValueData();

      if (StrToDateTimeDef(vTexto, -1) = -1) then begin
        vErro := 'Data invalida';
      end;

    end else if (FTpDado in [tpdInteiro]) then begin
      if (StrToIntDef(vTexto, -1) = -1) then begin
        vErro := 'Inteiro invalido';
      end;

    end else if (FTpDado in [tpdNumero]) then begin
      if (StrToFloatDef(vTexto, -1) = -1) then begin
        vErro := 'Numero invalido';
      end;

    end;

    if (vErro <> '') then begin
      Text := '';
      SetFocus;
      raise Exception.Create(vErro);
    end;

    Text := vTexto;
  end;

  DoExit;
end;

procedure TcEdit.KeyPress(var Key: Char);
var
  vLstTecla, vTecla : String;
  vKey : Boolean;
begin
  if (FTpDado in [tpdData]) then begin
    if not (Key in  ['0'..'9', '/', ':', Chr(8)]) then Key := #0;
  end else if (FTpDado in [tpdInteiro]) then begin
    if not (Key in  ['0'..'9', Chr(8)]) then Key := #0;
  end else if (FTpDado in [tpdNumero]) then begin
    if not (Key in  ['0'..'9', DecimalSeparator, Chr(8)]) then Key := #0;
  end else begin
    vLstTecla := IfNullS(FLstTeclas, '0..9|A..Z|a..z|.|,|!|@|#|%|$|%|&|*|(|)|[|]|{|}|_|-|+|=|/|\|?|<|>|:|chr(32)|') + 'chr(8)|';
    vKey := False;

    while vLstTecla <> '' do begin
      vTecla := getitem(vLstTecla);
      if vTecla = '' then Break;
      delitem(vLstTecla);

      if (vTecla = '0..9') then begin
        if (Key in  ['0'..'9']) then vKey := True;
      end else if (vTecla = 'A..Z') then begin
        if (Key in  ['A'..'Z']) then vKey := True;
      end else if (vTecla = 'a..z') then begin
        if (Key in  ['a'..'z']) then vKey := True;
      end else if (Pos('chr', vTecla) > 0) then begin
        vTecla := SoDigitos(vTecla);
        if (Ord(Key) = StrToIntDef(vTecla,0)) then vKey := True;
      end else if (Key = vTecla) then begin
        vKey := True;
      end;
    end;

    if not vKey then begin
      Key := #0;
    end;  
  end;

  inherited; //
end;

function TcEdit.GetValue: String;
begin
  if Text = '' then begin
    Result := '';
    Exit;
  end;

  if (FTpDado in [tpdData]) then begin
    Result := DateTimeToStr(StrToDateTimeDef(Text,0));
  end else if (FTpDado in [tpdNumero]) then begin
    Result := FloatToStr(StrToFloatDef(Text,0));
  end else if (FTpDado in [tpdInteiro]) then begin
    Result := IntToStr(StrToIntDef(Text,0));
  end else begin
    Result := Text;
  end;  
end;

procedure TcEdit.SetValue(const Value: String);
begin
  if Value = '' then begin
    Text := '';
    Exit;
  end;

  if (FTpDado in [tpdData]) then begin
    Text := DateTimeToStr(StrToDateTimeDef(Value,0));
  end else if (FTpDado in [tpdNumero]) then begin
    Text := FloatToStr(StrToFloatDef(Value,0));
  end else if (FTpDado in [tpdInteiro]) then begin
    Text := IntToStr(StrToIntDef(Value,0));
  end else begin
    Text := Value;
  end;  
end;

end.