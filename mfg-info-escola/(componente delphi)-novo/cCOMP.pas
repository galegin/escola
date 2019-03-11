unit cCOMP;

interface

uses StdCtrls, Classes;

type
//-------------------------------------------------------------------- COMBOBOX

  TcComboBox = class(TComboBox)
    Values : TStringList;
    procedure p_Clear;
    procedure p_AddRow(pDsValue, pDsItem : String);
  private
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

//-------------------------------------------------------------------- COMBOBOX

constructor TcComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Values := TStringList.Create;
end;

procedure TcComboBox.p_Clear;
begin
  Values.Clear;
  Items.Clear;
end;

procedure TcComboBox.p_AddRow(pDsValue, pDsItem : String);
begin
  Values.Add(pDsValue);
  Items.Add(pDsItem);
end;

end.
