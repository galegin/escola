unit ucCONFRELAT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin, CheckLst;

type
  TcCONFRELAT = class(TForm)
    Panel1: TPanel;
    RxLabel3: TLabel;
    Image1: TImage;
    SpeedButton5: TSpeedButton;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButtonOk: TToolButton;
    ToolButtonCancel: TToolButton;
    Label5: TLabel;
    Shape7: TShape;
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
    cCaption, cTabMan, cColRep, cMetadata : String;
    FValues : TStringList;
  public
    class procedure ConfigurarRelat(pCaption, pTabMan : String);
  end;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucFUNCAO, ucCONST, ucITEM, ucXML, ucDADOS, ucCAMPO,
  ucMETADATA;

class procedure TcCONFRELAT.ConfigurarRelat(pCaption, pTabMan : String);
begin
  with TcCONFRELAT.Create(Application) do
  try
    cCaption := pCaption;
    cTabMan := pTabMan;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TcCONFRELAT.FormCreate(Sender: TObject);
begin
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);
  FValues := TStringList.Create;
end;

procedure TcCONFRELAT.FormShow(Sender: TObject);
var
  vLstCod, vCod, vDes : String;
begin
  cColRep := LerIni(cCaption, COL_REP);

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
      Checked[Count-1] := (Pos(vCod, cColRep) > 0) or (cColRep = '');
    end;
  end;
end;

procedure TcCONFRELAT.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close();
  end;
end;

procedure TcCONFRELAT.ToolButtonOkClick(Sender: TObject);
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

  fGravaIni(cCaption, COL_REP, vLstCod);

  Mensagem('Gravação efetuado com sucesso');

  Close;
end;

procedure TcCONFRELAT.ToolButtonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TcCONFRELAT.ToolButtonSelClick(Sender: TObject);
var
  I : Integer;
begin
  with FItems do
    for I:=0 to Count-1 do
      Checked[I] := not Checked[I];
end;

end.
