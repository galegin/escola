unit ucPREVIEW_TXT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ToolWin, ExtCtrls, StdCtrls, Grids, DBGrids,
  Mask, FMTBcd, Provider, SqlExpr, DB, DBClient, DBCtrls, DBXpress, Printers,
  Menus;

type
  TcPREVIEW_TXT = class(TForm)
    PrinterSetupDialog1: TPrinterSetupDialog;
    FontDialog1: TFontDialog;
    PopupMenu1: TPopupMenu;
    Fonte1: TMenuItem;
    MemoCnt: TMemo;
    Panel1: TPanel;
    RxLabel3: TLabel;
    Shape1: TShape;
    Image1: TImage;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButtonImp: TToolButton;
    ToolButtonFechar: TToolButton;
    ToolButtonCancel: TToolButton;
    ToolButton1: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Fonte1Click(Sender: TObject);
    procedure ToolButtonFecharClick(Sender: TObject);
    procedure ToolButtonCancelClick(Sender: TObject);
    procedure ToolButtonImpClick(Sender: TObject);
  private
  public
    class procedure VisualizarArq(v_Arquivo : String);
    class procedure VisualizarTxt(v_Linha : TStringList);
    class procedure ImprimirTxt(v_Strings: TStrings);
  end;

implementation

{$R *.dfm}

uses
  ucDADOS, ucFUNCAO, ucCONST, ucCADASTROFUNC;

class procedure TcPREVIEW_TXT.VisualizarArq(v_Arquivo : String);
begin
  with TcPREVIEW_TXT.Create(Application) do
  try
    if FileExists(v_Arquivo) then
      MemoCnt.Lines.LoadFromFile(v_Arquivo);
    ShowModal;
  finally
    Free;
  end;
end;

class procedure TcPREVIEW_TXT.VisualizarTxt(v_Linha : TStringList);
begin
  with TcPREVIEW_TXT.Create(Application) do
  try
    if v_Linha <> nil then
      MemoCnt.Lines.Text := v_Linha.Text;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TcPREVIEW_TXT.FormCreate(Sender: TObject);
begin
  TcCADASTROFUNC.CorrigeCarregaImagem(Self);
end;

procedure TcPREVIEW_TXT.FormShow(Sender: TObject);
begin
  with MemoCnt.Font do begin
    Name := IfNullS(LerIni('PREVIEW_TXT', FNT_COD), FNT_DEF);
    Size := IfNullI(LerIni('PREVIEW_TXT', FNT_TAM), FNT_LEN);
  end;
end;

procedure TcPREVIEW_TXT.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE, VK_F12: ToolButtonCancel.Click;
    VK_F9: ToolButtonImp.Click;
  end;
end;

procedure TcPREVIEW_TXT.Fonte1Click(Sender: TObject);
begin
  FontDialog1.Font := MemoCnt.Font;
  if FontDialog1.Execute then begin
    MemoCnt.Font := FontDialog1.Font;
    fGravaIni('PREVIEW_TXT', FNT_COD, MemoCnt.Font.Name);
    fGravaIni('PREVIEW_TXT', FNT_TAM, MemoCnt.Font.Size);
  end;
end;

procedure TcPREVIEW_TXT.ToolButtonFecharClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TcPREVIEW_TXT.ToolButtonCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TcPREVIEW_TXT.ToolButtonImpClick(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    ImprimirTxt(MemoCnt.Lines);
end;

class procedure TcPREVIEW_TXT.ImprimirTxt(v_Strings: TStrings);
var
  Prn: TextFile;
  i: Word;
begin
  with Printer.Canvas.Font do begin
    Name := IfNullS(LerIni('PREVIEW_TXT', FNT_COD), FNT_DEF);
    Size := IfNullI(LerIni('PREVIEW_TXT', FNT_TAM), FNT_LEN);
  end;

  AssignPrn(Prn);

  try
    Rewrite(Prn);

    try
      for i := 0 to v_Strings.Count-1 do
        WriteLn(Prn, v_Strings[i]);
    finally
      CloseFile(Prn);
    end;

  except
    on E : Exception do begin
	  raise Exception.Create('Erro na impressao do texto / Erro: ' + E.Message);
	end;  
  end;
end;

end.
