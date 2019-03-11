unit ucFOTO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin;

type
  TcFOTO = class(TForm)
    Panel1: TPanel;
    Label5: TLabel;
    Shape7: TShape;
    Label6: TLabel;
    Shape8: TShape;
    RxLabel3: TLabel;
    Image1: TImage;
    Shape2: TShape;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton5: TSpeedButton;
    EditServ: TEdit;
    EditPort: TEdit;
    EditUser: TEdit;
    EditMail: TEdit;
    Shape1: TShape;
    Label1: TLabel;
    EditNome: TEdit;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButtonOk: TToolButton;
    ToolButtonCancel: TToolButton;
    Shape3: TShape;
    Label4: TLabel;
    Shape4: TShape;
    EditPass: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ToolButtonOkClick(Sender: TObject);
    procedure ToolButtonCancelClick(Sender: TObject);
  private
  public
    class procedure ConfigurarFoto;
  end;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucFUNCAO, ucCONST;

class procedure TcFOTO.ConfigurarFoto;
begin
  with TcFOTO.Create(Application) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TcFOTO.FormCreate(Sender: TObject);
begin
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);
end;

procedure TcFOTO.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close();
  end;
end;

procedure TcFOTO.ToolButtonOkClick(Sender: TObject);
begin
  Close;
end;

procedure TcFOTO.ToolButtonCancelClick(Sender: TObject);
begin
  Close;
end;

end.
