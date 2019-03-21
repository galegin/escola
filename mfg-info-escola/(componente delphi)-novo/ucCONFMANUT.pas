unit ucCONFMANUT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin, CheckLst,
  ucCONFCAMPO, ucCONFCAMPOJSON, DB, DBClient, StrUtils, Grids, DBGrids;

type
  TcCONFMANUT = class(TForm)
    Panel1: TPanel;
    LabelCampo: TLabel;
    ShapeCampo: TShape;
    RxLabel3: TLabel;
    Image1: TImage;
    SpeedButton5: TSpeedButton;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButtonOk: TToolButton;
    ToolButtonCancel: TToolButton;
    ToolButtonSel: TToolButton;
    ComboBoxIncre: TComboBox;
    ShapeIncre: TShape;
    ShapeValid: TShape;
    ComboBoxValid: TComboBox;
    LabelIncre: TLabel;
    LabelValid: TLabel;
    ClientDataSetConf: TClientDataSet;
    DataSourceConf: TDataSource;
    ClientDataSetConfCodigo: TStringField;
    ClientDataSetConfDescricao: TStringField;
    ClientDataSetConfTipo: TStringField;
    ClientDataSetConfTam: TIntegerField;
    DBGridConf: TDBGrid;
    ClientDataSetConfVisivel: TBooleanField;
    ClientDataSetConfDec: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ToolButtonOkClick(Sender: TObject);
    procedure ToolButtonCancelClick(Sender: TObject);
    procedure ToolButtonSelClick(Sender: TObject);
    procedure DBGridConfColEnter(Sender: TObject);
    procedure DBGridConfTitleClick(Column: TColumn);
    procedure DBGridConfDblClick(Sender: TObject);
  private
    FCaption,
    FTabMan : String;
    FConfCampoList : TcCONFCAMPOLIST;
    FTitulo : String;
    FInManut: Boolean;
    procedure SetDataGrid();
    procedure CarregarConfCampoList;
    procedure SetCaption(const Value: String);
    procedure SetTabMan(const Value: String);
    procedure SetTitulo(const Value: String);
    procedure SetInManut(const Value: Boolean);
  protected
    procedure SetClientDataSetConf(pConfCampo : TcCONFCAMPO); virtual;
    procedure GetClientDataSetConf(pConfCampo : TcCONFCAMPO); virtual;
  public
    property _Titulo : String read FTitulo write SetTitulo;
    property _Caption : String read FCaption write SetCaption;
    property _TabMan : String read FTabMan write SetTabMan;
    property _InManut : Boolean read FInManut write SetInManut; 

    class procedure Executar(pCaption, pTabMan : String);
  end;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucFUNCAO, ucCONST, ucITEM, ucXML, ucDADOS, ucCAMPO,
  ucMETADATA, ucCONFCAMPOMET;

  procedure TcCONFMANUT.SetDataGrid();

    function GetColumn(pName : String) : TColumn;
    var
      I : Integer;
    begin
      Result := nil;
      with DBGridConf do
        for I := 0 to Columns.Count - 1 do
          if (Columns[I].FieldName = pName) then
            Result := Columns[I];
    end;

    procedure SetColumnBool(pName : String);
    begin
      with GetColumn(pName).PickList do begin
        Clear();
        Add('True');
        Add('False');
      end;
    end;

    procedure SetColumnTipo(pName : String);
    begin
      with GetColumn(pName).PickList do begin
        Clear();
        Add('Key');
        Add('Req');
        Add('Nul');
      end;
    end;

  begin
    SetColumnBool('Visivel');
    SetColumnTipo('Tipo');
  end;

  procedure TcCONFMANUT.SetClientDataSetConf(pConfCampo: TcCONFCAMPO);
  begin
    ClientDataSetConfCodigo.AsString := pConfCampo.Codigo;
    ClientDataSetConfDescricao.AsString := pConfCampo.Descricao;
    ClientDataSetConfTipo.AsString := TipoCampoToStr(pConfCampo.Tipo);
    ClientDataSetConfTam.AsInteger := pConfCampo.Tamanho;
    ClientDataSetConfDec.AsInteger := pConfCampo.Decimal;
    ClientDataSetConfVisivel.AsBoolean := pConfCampo.InManut;
  end;

  procedure TcCONFMANUT.GetClientDataSetConf(pConfCampo: TcCONFCAMPO);
  begin
    pConfCampo.Tipo := StrToTipoCampo(ClientDataSetConfTipo.AsString);
    pConfCampo.Tamanho := ClientDataSetConfTam.AsInteger;
    pConfCampo.Decimal := ClientDataSetConfDec.AsInteger;
    pConfCampo.InManut := ClientDataSetConfVisivel.AsBoolean;
  end;

  procedure InverteBool(pField : TField);
  begin
    putitem(pField.DataSet, pField.FieldName, not pField.AsBoolean);
  end;

  procedure InverteTodosBool(pField : TField);
  var
    vRecNo : Integer;
  begin
    with pField.DataSet do begin
      vRecNo := RecNo;
      DisableControls;

      First;
      while not EOF do begin
        InverteBool(pField);
        Next;
      end;

      if (vRecNo > -1) then
        RecNo := vRecNo;
      EnableControls;
    end;
  end;

  procedure InverteTipo(pField : TField);
  var
    vTipo : TpCONFCAMPO;
  begin
    vTipo := StrToTipoCampo(pField.AsString);
    case vTipo of
      tpcKey : vTipo := tpcReq;
      tpcReq : vTipo := tpcNul;
    else
      vTipo := tpcKey;
    end;

    putitem(pField.DataSet, pField.FieldName, TipoCampoToStr(vTipo));
  end;

  procedure InverteTodosTipo(pField : TField);
  var
    vRecNo : Integer;
  begin
    with pField.DataSet do begin
      vRecNo := RecNo;
      DisableControls;

      First;
      while not EOF do begin
        InverteTipo(pField);
        Next;
      end;

      if (vRecNo > -1) then
        RecNo := vRecNo;
      EnableControls;
    end;
  end;

class procedure TcCONFMANUT.Executar(pCaption, pTabMan : String);
begin
  Application.CreateForm(TComponentClass(Self), Self);
  with TcCONFMANUT(Self) do
  try
    _Caption := pCaption;
    _TabMan := pTabMan;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TcCONFMANUT.FormCreate(Sender: TObject);
begin
  _InManut := True;
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);
  SetDataGrid();
end;

procedure TcCONFMANUT.FormShow(Sender: TObject);
var
  vConfCampo : TcCONFCAMPO;
  I : Integer;
begin
  ClientDataSetConf.EmptyDataSet;
  ComboBoxIncre.Items.Clear();
  ComboBoxValid.Items.Clear();

  for I := 0 to FConfCampoList.Count-1 do begin
    vConfCampo := FConfCampoList.Item[I];

    if Pos(vConfCampo.Codigo, 'TP_SITUACAO') > 0 then
      Continue;

    if (_InManut) then begin
      with ComboBoxIncre, ComboBoxIncre.Items do begin
        AddObject(vConfCampo.Descricao, vConfCampo);
        if (vConfCampo.InIncre) then
          ItemIndex := I;
      end;
      with ComboBoxValid, ComboBoxValid.Items do begin
        AddObject(vConfCampo.Descricao, vConfCampo);
        if (vConfCampo.InValid) then
          ItemIndex := I;
      end;
    end;  

    ClientDataSetConf.Append;
    SetClientDataSetConf(vConfCampo);
    ClientDataSetConf.Post;
  end;

  if (_InManut) then begin
    with ComboBoxIncre, ComboBoxIncre.Items do begin
      AddObject('', nil);
    end;
    with ComboBoxValid, ComboBoxValid.Items do begin
      AddObject('', nil);
    end;
  end;  

  ClientDataSetConf.First;
end;

procedure TcCONFMANUT.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close();
  end;
end;

procedure TcCONFMANUT.ToolButtonOkClick(Sender: TObject);
var
  vConfCampo, vConfCampoIncre, vConfCampoValid : TcCONFCAMPO;
  vRecNo : Integer;
begin
  if not Pergunta('Confirma gravação ?') then
    Exit;

  if (_InManut) then begin
    with ComboBoxIncre do begin
      vConfCampoIncre := TcCONFCAMPO(Items.Objects[ItemIndex]);
    end;
    with ComboBoxValid do begin
      vConfCampoValid := TcCONFCAMPO(Items.Objects[ItemIndex]);
    end;
  end;  

  with ClientDataSetConf do begin
    vRecNo := RecNo;
    DisableControls;

    First;
    while not EOF do begin

      vConfCampo := FConfCampoList.Buscar(ClientDataSetConfCodigo.AsString);
      GetClientDataSetConf(vConfCampo);

      if (_InManut) then begin
        vConfCampo.InIncre := False;
        if (vConfCampoIncre <> nil) and (vConfCampoIncre.Codigo = vConfCampo.Codigo) then
          vConfCampoIncre.InIncre := True;
        vConfCampo.InValid := False;
        if (vConfCampoValid <> nil) and (vConfCampoValid.Codigo = vConfCampo.Codigo) then
          vConfCampoValid.InValid := True;
      end;

      Next;
    end;

    if (vRecNo > -1) then
      RecNo := vRecNo;
    EnableControls;

  end;

  TcCONFCAMPOJSON.Gravar(_Caption, FConfCampoList);

  Mensagem('Gravação efetuado com sucesso');

  Close;
end;

procedure TcCONFMANUT.ToolButtonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TcCONFMANUT.ToolButtonSelClick(Sender: TObject);
begin
  InverteTodosBool(ClientDataSetConfVisivel);
end;

procedure TcCONFMANUT.SetTitulo(const Value: String);
begin
  FTitulo := Value;
  Caption := Value;
  RxLabel3.Caption := Value;
end;

procedure TcCONFMANUT.SetCaption(const Value: String);
begin
  FCaption := Value;
  CarregarConfCampoList();
end;

procedure TcCONFMANUT.SetTabMan(const Value: String);
begin
  FTabMan := Value;
  CarregarConfCampoList();
end;

procedure TcCONFMANUT.CarregarConfCampoList;
begin
  if (FCaption <> '') and (FTabMan <> '') then
    FConfCampoList := TcCONFCAMPOMET.Carregar(_Caption, _TabMan);
end;

procedure TcCONFMANUT.DBGridConfColEnter(Sender: TObject);
begin
  with DBGridConf do
    if (Pos(SelectedField.FieldName, 'Tam,Dec') > 0) then
      Options := Options + [dgEditing]
    else
      Options := Options - [dgEditing];
end;

procedure TcCONFMANUT.DBGridConfTitleClick(Column: TColumn);
begin
  if (Pos(Column.FieldName, 'Visivel') > 0) then
    InverteTodosBool(Column.Field)
  else if (Pos(Column.FieldName, 'Tipo') > 0) then
    InverteTodosTipo(Column.Field);
end;

procedure TcCONFMANUT.DBGridConfDblClick(Sender: TObject);
begin
  with DBGridConf do begin
    if (Pos(SelectedField.FieldName, 'Visivel') > 0) then
      InverteBool(SelectedField)
    else if (Pos(SelectedField.FieldName, 'Tipo') > 0) then
      InverteTipo(SelectedField);
  end;
end;

procedure TcCONFMANUT.SetInManut(const Value: Boolean);
begin
  FInManut := Value;

  LabelIncre.Visible := Value;
  ComboBoxIncre.Visible := Value;
  ShapeIncre.Visible := Value;

  LabelValid.Visible := Value;
  ComboBoxValid.Visible := Value;
  ShapeValid.Visible := Value;

  ClientDataSetConfTipo.Visible := Value;
end;

end.
