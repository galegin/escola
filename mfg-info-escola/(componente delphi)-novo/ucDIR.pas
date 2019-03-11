unit ucDIR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, ComCtrls, ToolWin, ExtCtrls;

type
  TcDIR = class(TForm)
    PanelCorpo: TPanel;
    Shape1: TShape;
    RxLabel3: TLabel;
    Image1: TImage;
    LabelUnidade: TLabel;
    Shape3: TShape;
    LabelPasta: TLabel;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButtonOk: TToolButton;
    ToolButtonFechar: TToolButton;
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    LabelPath: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ToolButtonOkClick(Sender: TObject);
    procedure ToolButtonFecharClick(Sender: TObject);
  private
  public
    class function dialog(pDir : String = '') : String;
  end;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucFUNCAO, ucDADOS;

class function TcDIR.dialog(pDir: String): String;
begin
  Result := '';

  with TcDIR.Create(Application) do
  try
    if ShowModal = mrOk then
      Result := LabelPath.Caption;
  finally
    Free;
  end;
end;

procedure TcDIR.FormCreate(Sender: TObject);
begin
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);
end;

procedure TcDIR.ToolButtonOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TcDIR.ToolButtonFecharClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
