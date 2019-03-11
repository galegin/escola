unit ucCONFPAGINA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, ExtCtrls, DBClient, Math;

type
  TcCONFPAGINA = class(TForm)
    Panel1: TPanel;
    CoolBar1: TCoolBar;
    ToolBar2: TToolBar;
    ToolButtonFechar: TToolButton;
    ToolButtonCancela: TToolButton;
    Label5: TLabel;
    Shape7: TShape;
    Label6: TLabel;
    Shape8: TShape;
    ComboBoxOrientacao: TComboBox;
    ComboBoxPapel: TComboBox;
    RxLabel3: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ToolButtonFecharClick(Sender: TObject);
    procedure ToolButtonCancelaClick(Sender: TObject);
  private
  public
    class function Executar(var v_PapelSize : String;
      var v_Orientacao : String) : Boolean;
  end;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucFUNCAO;

class function TcCONFPAGINA.Executar(var v_PapelSize : String;
  var v_Orientacao : String) : Boolean;
begin
  Result := False;

  with TcCONFPAGINA.Create(Application) do
    try
      ComboBoxPapel.Text := v_PapelSize;
      ComboBoxOrientacao.ItemIndex := IfThen(v_Orientacao = 'P', 0, 1);
      if ShowModal = mrOk then begin
        v_PapelSize := ComboBoxPapel.Text;
        v_Orientacao := Copy(ComboBoxOrientacao.Text,1,1);
        Result := True
      end;
    finally
      Free;
    end;
end;

procedure TcCONFPAGINA.FormCreate(Sender: TObject);
begin
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);
end;

procedure TcCONFPAGINA.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case (Key) of
    VK_RETURN: ToolButtonFechar.Click;
    VK_ESCAPE: ToolButtonCancela.Click;
  end;
end;

procedure TcCONFPAGINA.ToolButtonFecharClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TcCONFPAGINA.ToolButtonCancelaClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
