unit ucCONFMANUT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin, CheckLst,
  ucCONFCAMPO, ucCONFCAMPOJSON;

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
    FCaption,
    FTabMan : String;
    FConfCampoList : TcCONFCAMPOLIST;
    FTitulo : String;
    procedure CarregarConfCampoList;
    procedure SetCaption(const Value: String);
    procedure SetTabMan(const Value: String);
    procedure SetTitulo(const Value: String);
  protected
    function GetFlag(pConfCampo : TcCONFCAMPO) : Boolean; virtual;
    procedure SetFlag(pConfCampo : TcCONFCAMPO; Value : Boolean); virtual;
  public
    property _Titulo : String read FTitulo write SetTitulo;
    property _Caption : String read FCaption write SetCaption;
    property _TabMan : String read FTabMan write SetTabMan;

    class procedure Executar(pCaption, pTabMan : String);
  end;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucFUNCAO, ucCONST, ucITEM, ucXML, ucDADOS, ucCAMPO,
  ucMETADATA, ucCONFCAMPOMET;

  function TcCONFMANUT.GetFlag(pConfCampo : TcCONFCAMPO) : Boolean;
  begin
    Result := pConfCampo.InManut;
  end;

  procedure TcCONFMANUT.SetFlag(pConfCampo : TcCONFCAMPO; Value : Boolean);
  begin
    pConfCampo.InManut := Value;
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
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);
end;

procedure TcCONFMANUT.FormShow(Sender: TObject);
var
  vConfCampo : TcCONFCAMPO;
  I : Integer;
begin
  FItems.Items.Clear();

  for I := 0 to FConfCampoList.Count-1 do begin
    vConfCampo := FConfCampoList.Item[I];

    if Pos(vConfCampo.Codigo, 'TP_SITUACAO') > 0 then
      Continue;

    with FItems, FItems.Items do begin
      AddObject(vConfCampo.Descricao, vConfCampo);
      Checked[Count-1] := GetFlag(vConfCampo);
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
  I : Integer;
begin
  if not Pergunta('Confirma gravação ?') then
    Exit;

  with FItems, FItems.Items do
    for I:=0 to Count-1 do
      SetFlag(TcCONFCAMPO(FItems.Items.Objects[I]), Checked[I]);

  TcCONFCAMPOJSON.Gravar(_Caption, FConfCampoList);

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
    for I := 0 to Count-1 do
      Checked[I] := not Checked[I];
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

end.
