unit ucCONFMANUT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin, CheckLst;

type
  TcCONFMANUT = class(TForm)
    Panel1: TPanel;
    Label5: TLabel;
    Shape7: TShape;
    RxLabel3: TLabel;
    Image1: TImage;
    SpeedButton5: TSpeedButton;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButtonOk: TToolButton;
    ToolButtonCancel: TToolButton;
    FItems: TCheckListBox;
    ToolButtonSel: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ToolButtonOkClick(Sender: TObject);
    procedure ToolButtonCancelClick(Sender: TObject);
    procedure ToolButtonSelClick(Sender: TObject);
  private
  protected
    cCaption, cTabMan, cColMan, cMetadata : String;
    FValues : TStringList;
  public
    class procedure Executar(pCaption, pTabMan : String);
  end;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucFUNCAO, ucCONST, ucITEM, ucXML, ucDADOS, ucCAMPO,
  ucMETADATA;

class procedure TcCONFMANUT.Executar(pCaption, pTabMan : String);
begin
  with TcCONFMANUT.Create(Application) do
  try
    cCaption := pCaption;
    cTabMan := pTabMan;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TcCONFMANUT.FormCreate(Sender: TObject);
begin
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);
  FValues := TStringList.Create;
end;

procedure TcCONFMANUT.FormShow(Sender: TObject);
var
  vLstCod, vCod, vDes : String;
begin
  cColMan := LerIni(cCaption, COL_MAN);

  cMetadata := dDADOS.GetMetadataEnt(cTabMan);
  cMetadata := itemX('fields', cMetadata);
  vLstCod := TcMETADATA.getMetadataXml(cMetadata, 'cod');

  FValues.Text := '';
  FItems.Items.Text := '';

  while vLstCod <> '' do begin
    vCod := getitem(vLstCod);
    if vCod = '' then Break;
    delitem(vLstCod);

    if Pos(vCod, 'TP_SITUACAO') > 0 then
      Continue;

    vDes := CampoDes(vCod);

    FValues.Add(vCod);
    with FItems, FItems.Items do begin
      Add(vDes);
      Checked[Count-1] := (Pos(vCod, cColMan) > 0) or (cColMan = '');
    end;
  end;
end;

procedure TcCONFMANUT.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close();
  end;
end;

procedure TcCONFMANUT.ToolButtonOkClick(Sender: TObject);
var
  vLstCod : String;
  I : Integer;
begin
  if not Pergunta('Confirma gravação ?') then
    Exit;

  with FItems, FItems.Items do
    for I:=0 to Count-1 do
      if Checked[I] then
        putitemD(vLstCod, FValues[I], '|');

  fGravaIni(cCaption, COL_MAN, vLstCod);

  Mensagem('Gravação efetuado com sucesso');

  Close;
end;

procedure TcCONFMANUT.ToolButtonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TcCONFMANUT.ToolButtonSelClick(Sender: TObject);
var
  I : Integer;
begin
  with FItems do
    for I:=0 to Count-1 do
      Checked[I] := not Checked[I];
end;

end.
