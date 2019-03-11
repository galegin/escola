unit ucCONFIMPRESSAO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, ExtCtrls, DBClient, Math,
  ucTIPOIMPRESSAO;

type
  TcCONFIMPRESSAO = class(TForm)
    Panel1: TPanel;
    CoolBar1: TCoolBar;
    ToolBar2: TToolBar;
    ToolButtonFechar: TToolButton;
    ToolButtonCancela: TToolButton;
    Label5: TLabel;
    Shape7: TShape;
    ComboBoxTipo: TComboBox;
    RxLabel3: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Shape1: TShape;
    Label2: TLabel;
    Shape2: TShape;
    EditArquivo: TEdit;
    EditEmail: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ComboBoxTipoChange(Sender: TObject);
    procedure ToolButtonFecharClick(Sender: TObject);
    procedure ToolButtonCancelaClick(Sender: TObject);
  private
    function GetTipoImpressao: TTipoImpressao;
    procedure SetTipoImpressao(const Value: TTipoImpressao);
  public
  published
    property _TipoImpressao : TTipoImpressao read GetTipoImpressao write SetTipoImpressao;

    class function Executar(
      var v_TipoImpressao : TTipoImpressao; var v_Arquivo : String;
      var v_Email : String) : Boolean;
  end;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucFUNCAO;

class function TcCONFIMPRESSAO.Executar(
  var v_TipoImpressao : TTipoImpressao; var v_Arquivo : String;
  var v_Email : String) : Boolean;
begin
  Result := False;

  with TcCONFIMPRESSAO.Create(Application) do
    try
      _TipoImpressao := v_TipoImpressao;
      EditArquivo.Text := v_Arquivo;
      EditEmail.Text := v_Email;
      if ShowModal = mrOk then begin
        v_TipoImpressao := _TipoImpressao;
        v_Arquivo := EditArquivo.Text;
        v_Email := EditEmail.Text;
        Result := True
      end;
    finally
      Free;
    end;
end;

function TcCONFIMPRESSAO.GetTipoImpressao: TTipoImpressao;
begin
  with ComboBoxTipo do
    Result := TcTipoImpressao(Items.Objects[ItemIndex])._Tip;
end;

procedure TcCONFIMPRESSAO.SetTipoImpressao(const Value: TTipoImpressao);
begin
  ComboBoxTipo.ItemIndex := Ord(Value);
end;

procedure TcCONFIMPRESSAO.FormCreate(Sender: TObject);
begin
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);

  ComboBoxTipo.Items.Assign(ucTIPOIMPRESSAO.lst());
  ComboBoxTipo.ItemIndex := 0;
end;

procedure TcCONFIMPRESSAO.FormShow(Sender: TObject);
begin
  ComboBoxTipoChange(nil);
end;

procedure TcCONFIMPRESSAO.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case (Key) of
    VK_RETURN: ToolButtonFechar.Click;
    VK_ESCAPE: ToolButtonCancela.Click;
  end;
end;

procedure TcCONFIMPRESSAO.ComboBoxTipoChange(Sender: TObject);
begin
  EditArquivo.Enabled := False; // _TipoImpressao in [tpiArquivo];
  EditArquivo.Color := IfThen(EditArquivo.Enabled, clWindow, clBtnFace);

  EditEmail.Enabled := False; //_TipoImpressao in [tpiEmail];
  EditEmail.Color := IfThen(EditArquivo.Enabled, clWindow, clBtnFace);
end;

procedure TcCONFIMPRESSAO.ToolButtonFecharClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TcCONFIMPRESSAO.ToolButtonCancelaClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
