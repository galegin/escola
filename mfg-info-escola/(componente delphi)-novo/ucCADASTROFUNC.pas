unit ucCADASTROFUNC;

interface

uses Forms, StdCtrls, ExtCtrls, Controls, Grids, SysUtils, DB,
  StrUtils, DBCtrls, Windows, DBGrids, Graphics, MidasLib, DBClient, Classes;

type
  TcCADASTROFUNC = class
  private
  public
    class procedure CorrigeCarregaImagem(F : TForm); virtual;
    class procedure CorrigeDisplayTela(F : TForm); virtual;
    class procedure CorrigeShapeTela(F : TForm); virtual;
    class procedure CorrigeDisplayLabel(C : TDataSet); virtual;

    class function IsFieldTable(N : String; C : TDataSet) : Boolean;
    class function IsFieldCd(N : String; C : TDataSet) : Boolean;
    class function IsFieldAlfa(N : String; C : TDataSet) : Boolean;
    class function IsFieldDate(N : String; C : TDataSet) : Boolean;
    class function IsFieldFloat(N : String; C : TDataSet) : Boolean;
    class function IsFieldInteger(N : String; C : TDataSet) : Boolean;

    class procedure onDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);

    class procedure clrPickList(Sender: TObject; Column : String);
    class procedure setPickList(Sender: TObject; Column, List : String; Padrao : String = '');

    class function EditValida(C : TDataSet; Sender: TObject; Cpo : String = '') : Boolean;
    class procedure EditValidaData(Sender : TObject);
    class procedure EditValidaInteiro(Sender : TObject);
    class procedure EditValidaNumero(Sender : TObject);

    class procedure CarregaCamposFiltro(Items : TStrings; DataSet : TDataSet);

    class procedure EditKeyPressData(Sender: TObject; var Key: Char);
    class procedure EditKeyPressDescr(Sender: TObject; var Key: Char);
    class procedure EditKeyPressInteiro(Sender: TObject; var Key: Char);
    class procedure EditKeyPressNumero(Sender: TObject; var Key: Char);

    class procedure PosicaoTela(F : TControl);
  end;

implementation

uses
  ucFUNCAO, ucCAMPO, ucCONST, ucITEM;

class procedure TcCADASTROFUNC.CorrigeCarregaImagem(F : TForm);
begin
//
end;

class procedure TcCADASTROFUNC.CorrigeDisplayTela(F : TForm);
var
  I : Integer;
begin
  with F do
    for I := 0 to ComponentCount - 1 do begin
      if (Components[I] is TLabel) then begin
        TLabel(Components[I]).Transparent := True;
        if (TLabel(Components[I]).Tag <> -1) then
          TLabel(Components[I]).Caption := PriMaiuscula( TLabel(Components[I]).Caption );
      end;
      if (Components[I] is TCheckBox) then begin
        TCheckBox(Components[I]).Caption := PriMaiuscula( TCheckBox(Components[I]).Caption );
      end;
    end;
end;

class procedure TcCADASTROFUNC.CorrigeShapeTela(F : TForm);
var
  Shape : TShape;
  I : Integer;
begin
  with F do
    for I := 0 to ComponentCount - 1 do begin
      if (TWinControl(Components[I]).Visible) then begin
        if (Components[I] is TEdit)
        or (Components[I] is TDBEdit)
        or (Components[I] is TCheckBox)
        or (Components[I] is TDBCheckBox)
        or (Components[I] is TStringGrid)
        or (Components[I] is TDBGrid)
        or (Components[I] is TMemo)
        or (Components[I] is TDBMemo)
        or (Components[I] is TComboBox)
        or (Components[I] is TDBComboBox) then begin
          Shape := TShape.Create(F);
          Shape.Name := 'Shape' + TWinControl(Components[I]).Name;
          Shape.Parent := TWinControl(Components[I]).Parent;
          Shape.Top := TWinControl(Components[I]).Top - 2;
          Shape.Left := TWinControl(Components[I]).Left - 2;
          Shape.Height := TWinControl(Components[I]).Height + 4;
          Shape.Width := TWinControl(Components[I]).Width + 4;
          Shape.Anchors := TWinControl(Components[I]).Anchors;
        end;
      end;
    end;
end;

class procedure TcCADASTROFUNC.CorrigeDisplayLabel(C : TDataSet);
var
  J, T: Integer;
begin
  T := 1;
  with C do begin
    for J := 0 to FieldCount - 1 do begin
      with Fields[J] do begin
        if (FieldName = 'TP_SITUACAO') then T := 0;
        Tag := T;

        if (DataType in [ftBCD,ftFMTBCD]) then begin
          TFMTBCDField(Fields[J]).DisplayFormat := '###,##0' + IfThen(Size>0,'.','') + Replicate('0', Size);
        end;

        DisplayLabel := CampoDes(FieldName);
      end;
    end;
  end;
end;

class function TcCADASTROFUNC.IsFieldTable(N : String; C : TDataSet) : Boolean;
var
  I : Integer;
begin
  Result := False;
  with C do
    for I := 0 to FieldCount - 1 do
      if (Fields[I].FieldName = N) then Result := True;
end;

class function TcCADASTROFUNC.IsFieldCd(N : String; C : TDataSet) : Boolean;
begin
  with C.FieldByName(N) do begin
    Result := (DataType in [ftFloat, ftCurrency, ftInteger, ftBCD, ftFMTBcd]);
  end;
end;

class function TcCADASTROFUNC.IsFieldAlfa(N : String; C : TDataSet) : Boolean;
begin
  with C.FieldByName(N) do begin
    Result := (DataType in [ftString, ftWideString]);
  end;
end;

class function TcCADASTROFUNC.IsFieldDate(N : String; C : TDataSet) : Boolean;
begin
  with C.FieldByName(N) do begin
    Result := (DataType in [ftDate, ftDateTime]);
  end;
end;

class function TcCADASTROFUNC.IsFieldFloat(N : String; C : TDataSet) : Boolean;
begin
  with C.FieldByName(N) do begin
    Result := (DataType in [ftFloat, ftCurrency, ftBCD, ftFMTBcd]);
  end;
end;

class function TcCADASTROFUNC.IsFieldInteger(N : String; C : TDataSet) : Boolean;
begin
  with C.FieldByName(N) do begin
    Result := (DataType in [ftInteger]);
  end;
end;

class procedure TcCADASTROFUNC.onDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  vDataSet : TDataSet;
begin
  with TDBGrid(Sender) do begin
    vDataSet := TDataSource(DataSource).DataSet;

    if (gdselected in State) then begin
      Canvas.Font.Color := clWhite;
      Canvas.Brush.Color := $00C08080;
    end else begin
      if odd(vDataSet.RecNo) then begin
        Canvas.Font.Color := clBlack;
        Canvas.Brush.Color := $00DCDCBA;
      end else begin
        Canvas.Font.Color := clBlack;
        Canvas.Brush.Color := clWhite;
      end;
    end;

    Canvas.FillRect(Rect);
    DefaultDrawDataCell(Rect,columns[datacol].field,state);
  end;

  (* with Column do
    if (FieldName = 'SEL') then
      if (itemI(FieldName, vDataSet) >= 0) then begin
        with TDBGrid(Sender) do begin
          Canvas.Brush.Color := clWindow;
          Canvas.FillRect(Rect);
          ImageList1.Draw(Canvas, Rect.Left, Rect.Top, itemI(FieldName, vDataSet));
          if gdFocused in State then Canvas.DrawFocusRect(Rect);
        end;
      end; *)

end;

//--

  function fincColumn(Sender: TObject; Column : String) : TColumn;
  var
    I : Integer;
  begin
    Result := nil;

    if Column = '' then
      Exit;

    with TDBGrid(Sender) do
      for I:=0 to Columns.Count-1 do
        with Columns[I] do
          if (FieldName = Column) then
            Result := Columns[I];

  end;

class procedure TcCADASTROFUNC.clrPickList(Sender: TObject; Column : String);
var
  vColumn : TColumn;
begin
  vColumn := fincColumn(Sender, Column);
  if vColumn <> nil then
    with vColumn do
      PickList.Clear();
end;

class procedure TcCADASTROFUNC.setPickList(Sender: TObject; Column, List : String; Padrao : String = '');
var
  vColumn : TColumn;
  vAux : String;
begin
  if (Column = '')
  or (List = '') then Exit;

  vColumn := fincColumn(Sender, Column);
  if vColumn <> nil then
    with vColumn do
      with PickList do begin
        Clear();
        if (Padrao = '=') then Add('')
        else if (Padrao <> '') then Add(Padrao);

        while List <> '' do begin
          vAux := getitem(List);
          if vAux = '' then Break;
          delitem(List);
          Add(vAux);
        end;
      end;

end;

//--

class function TcCADASTROFUNC.EditValida(C : TDataSet; Sender: TObject; Cpo : String = '') : Boolean;
var
  vField : TField;
  vErro : String;
begin
  Result := True;

  Cpo := IfNullS(Cpo, TEdit(Sender).Name);
  if (Cpo = '') then
    Exit;

  vField := C.FindField(Cpo);
  if vField = nil then
    Exit;

  if TEdit(Sender).Text = '' then
    Exit;

  vErro := '';

  if (vField.DataType in [ftDate, ftDateTime]) then begin
    if StrToDateTimeDef(TEdit(Sender).Text,-1) = -1 then
      vErro := 'Data inválida!';
  end else if (vField.DataType in [ftFloat, ftCurrency, ftBCD, ftFMTBcd]) then begin
    if StrToFloatDef(TEdit(Sender).Text,-1) = -1 then
      vErro := 'Numero inválido!';
  end else if (vField.DataType in [ftInteger]) then begin
    if StrToIntDef(TEdit(Sender).Text,-1) = -1 then
      vErro := 'Inteiro inválido!';
  end;

  if vErro <> '' then begin
    Mensagem(vErro);
    TEdit(Sender).Text := '';
    TEdit(Sender).SetFocus;
    Result := False;
    Exit;
  end;

  if (vField.DataType in [ftDate, ftDateTime]) then begin
    with TEdit(Sender) do begin
      Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(Text,0));
    end;
  end;
end;

//--

class procedure TcCADASTROFUNC.EditValidaData(Sender : TObject);
begin
  with TEdit(Sender) do begin
    if Text = '' then
      Exit;

    if StrToDateTimeDef(Text,-1) = -1 then begin
      SetFocus;
      raise Exception.Create(cMESSAGE_DATAINVALIDA);
    end;

    Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(Text,0));
  end;
end;

class procedure TcCADASTROFUNC.EditValidaInteiro(Sender : TObject);
begin
  with TEdit(Sender) do begin
    if Text = '' then
      Exit;

    if StrToIntDef(Text,-1) = -1 then begin
      SetFocus;
      raise Exception.Create(cMESSAGE_INTEIROINVALIDO);
    end;
  end;
end;

class procedure TcCADASTROFUNC.EditValidaNumero(Sender : TObject);
begin
  with TEdit(Sender) do begin
    if Text = '' then
      Exit;

    if StrToFloatDef(Text,-1) = -1 then begin
      SetFocus;
      raise Exception.Create(cMESSAGE_NUMEROINVALIDO);
    end;
  end;
end;

//--

class procedure TcCADASTROFUNC.CarregaCamposFiltro(Items : TStrings; DataSet : TDataSet);
var
  I : Integer;
begin
  Items.Clear;
  for I := 0 to DataSet.FieldCount-1 do begin
    Items.Add( DataSet.Fields[I].DisplayLabel );
  end;
end;

//--

class procedure TcCADASTROFUNC.EditKeyPressData(Sender: TObject; var Key: Char);
begin
  if not (Key in  ['0'..'9', '/', ':', Chr(8)]) then
    Key := #0;
end;

class procedure TcCADASTROFUNC.EditKeyPressDescr(Sender: TObject; var Key: Char);
begin
  if not (Key in  ['0'..'9', 'a'..'z', 'A'..'Z', '*', ' ', Chr(8)]) then
    Key := #0;
end;

class procedure TcCADASTROFUNC.EditKeyPressInteiro(Sender: TObject; var Key: Char);
begin
  if not (Key in  ['0'..'9', Chr(8)]) then
    Key := #0;
end;

class procedure TcCADASTROFUNC.EditKeyPressNumero(Sender: TObject; var Key: Char);
begin
  if not (Key in  ['0'..'9', DecimalSeparator, Chr(8)]) then
    Key := #0;
end;

//--

(* Procedure Le_Imagem_JPEG(Campo:TBlobField; Foto:TImage);
var
  BS:TBlobStream;
  MinhaImagem:TJPEGImage;
Begin
  if Campo.AsString <> '' Then Begin
    BS := TBlobStream.Create((Campo as TBlobField), BMREAD);
    MinhaImagem := TJPEGImage.Create;
    MinhaImagem.LoadFromStream(BS);
    Foto.Picture.Assign(MinhaImagem);
    BS.Free;
    MinhaImagem.Free;
  End Else
    Foto.Picture.LoadFromFile('c:\temp\limpa.jpg');
End;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Le_Imagem_JPEG(TbClientesCli_Foto, Image1);
  // TbClientesCli_Foto é um variavel da tabela do tipo Blob
  // Image1 é um componente
end; *)

(* Procedure Grava_Imagem_JPEG(Tabela:TTable; Campo:TBlobField; Foto:TImage; Dialog:TOpenPictureDialog);
var
  BS:TBlobStream;
  MinhaImagem:TJPEGImage;
Begin
  Dialog.InitialDir := 'c:\temp';
  Dialog.Execute;
  if Dialog.FileName <> '' Then begin
    if not (Tabela.State in [dsEdit, dsInsert]) Then
      Tabela.Edit;
    BS := TBlobStream.Create((Campo as TBlobField), BMWRITE);
    MinhaImagem := TJPEGImage.Create;
    MinhaImagem.LoadFromFile(Dialog.FileName);
    MinhaImagem.SaveToStream(BS);
    Foto.Picture.Assign(MinhaImagem);
    BS.Free;
    MinhaImagem.Free;
    Tabela.Post;
    DBISaveChanges(Tabela.Handle);
  End;
End;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Grava_Imagem_JPEG(TbClientes,TbClientesCli_Foto, Image1,
  OpenPictureDialog1);
  // TbClientes é o nome de alguma Tabela
  // TbClientesCli_Foto é um variavel da tabela do tipo Blob
  // Image1 é um componente
  // OpenPictureDialog1 é o componente para abrir a figura
end; *)

class procedure TcCADASTROFUNC.PosicaoTela(F: TControl);
begin
  if FindWindow('TAppBuilder', nil) > 0 then
    with F do begin
      Top := Screen.WorkAreaTop;
      Left := Screen.WorkAreaLeft;
      Height := Screen.WorkAreaHeight;
      Width := Screen.WorkAreaWidth div 2;
    end;
end;

end.
