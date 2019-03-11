unit ucPREVIEW;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, QRPrntr, ImgList, Menus, ExtCtrls, StdCtrls, QRExport,
  ShellApi, DBClient, Spin, Printers, StrUtils;

type
  TcPREVIEW = class(TForm)
    CoolBar1: TCoolBar;
    ToolBar2: TToolBar;
    btnPrimeira: TToolButton;
    btnAnterior: TToolButton;
    btnProxima: TToolButton;
    btnUltima: TToolButton;
    btnImprimir: TToolButton;
    btnSair: TToolButton;
    _Preview: TQRPreview;
    StatusBar: TStatusBar;
    _ImageList: TImageList;
    PanelPagina: TPanel;
    spePaginas: TSpinEdit;
    LabelPagina: TLabel;
    _PrintDialog: TPrintDialog;
    BtnZoom: TToolButton;
    PanelZoom: TPanel;
    LabelZoom: TLabel;
    speZoom: TSpinEdit;
    lblAguarde: TPanel;
    ProgressBar: TProgressBar;
    btnExportar: TToolButton;
    btnEnviarEmail: TToolButton;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure btnSairClick(Sender: TObject);
    procedure btnPrimeiraClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximaClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnUltimaClick(Sender: TObject);
    procedure btnZoomClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure btnEnviarEmailClick(Sender: TObject);

    procedure _PreviewPageAvailable(Sender: TObject; PageNum: Integer);
    procedure _PreviewProgressUpdate(Sender: TObject; Progress: Integer);

    procedure spePaginasChange(Sender: TObject);
    procedure speZoomChange(Sender: TObject);

    procedure StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
  private
    sStatus : String;
    FParams : String;
    FSQL : String;
    FCaptionRel : String;
    FClientDataSet : TClientDataSet;
    procedure UpdateButtons;
    procedure SetParams(const Value: String);
  public
    class function Execute(Sender: TObject; pParams : String = '') : String;
  published
    property _Params : String read FParams write SetParams;
    property _SQL : String read FSQL write FSQL;
    property _CaptionRel : String read FCaptionRel write FCaptionRel;
    property _ClientDataSet : TClientDataSet read FClientDataSet write FClientDataSet;
  end;

var
  sFileName : String;

implementation

{$R *.DFM}

uses
  ucEXPORTARAQUIVO,
  ucRELATORIO, ucFUNCAO, ucEMAIL, ucDADOS, ucCONST, ucPROJETO, ucITEM;

type
  TTStatusBar = (tpsProjeto, tpsVersao, tpsStatus, tpsPagina, tpsProgress);

  procedure TcPREVIEW.SetParams(const Value: String);
  begin
    FParams := Value;
    if itemB('IN_BLOQIMP', Value) then begin
      btnImprimir.Enabled := False;
    end;
  end;

  procedure TcPREVIEW.UpdateButtons;
  begin
    with _Preview do begin
      btnPrimeira.Enabled := PageNumber > 1;
      btnAnterior.Enabled := PageNumber > 1;
      btnProxima.Enabled := PageNumber < QRPrinter.PageCount;
      btnUltima.Enabled := PageNumber < QRPrinter.PageCount;
      spePaginas.Value := PageNumber;
    end;

    with StatusBar do begin
      Panels[Ord(tpsProjeto)].Text := TcPROJETO.Codigo();
      Panels[Ord(tpsVersao)].Text := TcPROJETO.Versao();
      Panels[Ord(tpsStatus)].Text := sStatus;
      Panels[Ord(tpsPagina)].Text := 'Pág. ' + IntToStr(_Preview.PageNumber) + ' de ' + IntToStr(_Preview.QRPrinter.PageCount);
      Panels[Ord(tpsProgress)].Text := '';
    end;
  end;

class function TcPREVIEW.Execute(Sender: TObject; pParams : String) : String;
begin
  with TcPREVIEW.Create(nil) do begin
    _Params := pParams;
    _Preview.QRPrinter := TQRPrinter(Sender);
    Show;
  end;
end;

procedure TcPREVIEW.FormCreate(Sender: TObject);
begin
  ProgressBar.Parent := StatusBar;
  btnExportar.Visible := False;
  btnEnviarEmail.Visible := False;
end;

procedure TcPREVIEW.FormShow(Sender: TObject);
begin
  lblAguarde.Left := (Screen.Width div 2) - (lblAguarde.Width div 2);
  lblAguarde.Top := (Screen.Height div 2) - 60;
  _Preview.SetFocus;
  ActiveControl := nil;
end;

procedure TcPREVIEW.FormActivate(Sender: TObject);
begin
  UpdateButtons;
  BtnZoomClick(nil);
end;

procedure TcPREVIEW.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Let the user navigate through the preview by the keyboard
  case Key of
    VK_DOWN : begin
      with _Preview.VertScrollBar do
        Position := Position + 30;
    end;
    VK_UP : begin
      with _Preview.VertScrollBar do
        Position := Position - 30;
    end;
    VK_LEFT : begin
      with _Preview.HorzScrollBar do
        Position := Position - 30;
    end;
    VK_RIGHT : begin
      with _Preview.HorzScrollBar do
        Position := Position + 30;
    end;
    VK_NEXT : begin
      with _Preview.VertScrollBar do
        Position := Position + 60;
    end;
    VK_PRIOR : begin
      with _Preview.VertScrollBar do
        Position := Position - 60;
    end;
    VK_HOME : begin
      _Preview.PageNumber := 1;
      Application.ProcessMessages;
      UpdateButtons;
    end;
    VK_END : begin
      _Preview.PageNumber := _Preview.QRPrinter.PageCount;
      Application.ProcessMessages;
      UpdateButtons;
    end;
    VK_ESCAPE: btnSairClick(Self);
    VK_F6: btnImprimirClick(Self);
  end;
end;

procedure TcPREVIEW.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TcPREVIEW.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TcPREVIEW.btnPrimeiraClick(Sender: TObject);
begin
  Application.ProcessMessages;
  _Preview.PageNumber := 1;
  UpdateButtons;
end;

procedure TcPREVIEW.btnAnteriorClick(Sender: TObject);
begin
  Application.ProcessMessages;
  with _Preview do
    if (PageNumber > 1) then
      PageNumber := PageNumber - 1;
  UpdateButtons;
end;

procedure TcPREVIEW.btnProximaClick(Sender: TObject);
begin
  Application.ProcessMessages;
  with _Preview do
    if (PageNumber < QRPrinter.PageCount) then
      PageNumber := PageNumber + 1;
  UpdateButtons;
end;

procedure TcPREVIEW.btnUltimaClick(Sender: TObject);
begin
  Application.ProcessMessages;
  with _Preview do
    if (PageNumber < QRPrinter.PageCount) then
      PageNumber := QRPrinter.PageCount;
  UpdateButtons;
end;

procedure TcPREVIEW.btnImprimirClick(Sender: TObject);
begin
  with _PrintDialog do begin
    if (Execute) then begin
      _Preview.QRPrinter.PrinterIndex := Printer.PrinterIndex;
      _Preview.QRPrinter.Copies := _PrintDialog.Copies;
      _Preview.QRPrinter.Print;
    end;
  end;
end;

procedure TcPREVIEW.BtnZoomClick(Sender: TObject);
begin
  with _Preview do
    case Zoom of
      200 : _Preview.Zoom := 150;
      150 : _Preview.Zoom := 100;
      100 : _Preview.Zoom := 075;
      075 : _Preview.Zoom := 050;
      050 : _Preview.Zoom := 025;
      025 : _Preview.ZoomToFit;
    else
      _Preview.Zoom := 100;
    end;

  speZoom.Value := _Preview.Zoom;
end;

procedure TcPREVIEW.btnExportarClick(Sender: TObject);
var
  v_Arquivo : String;
begin
  v_Arquivo := TcEXPORTARAQUIVO.NomeArquivo('PREVIEW');
  if (v_Arquivo = '') then
    Exit;

  TcEXPORTARAQUIVO.ExportaArquivo(Self, v_Arquivo);

  ShellExecute(handle, 'open', PChar(v_Arquivo), '', nil, Sw_ShowNormal);
end;

procedure TcPREVIEW.btnEnviarEmailClick(Sender: TObject);
var
  v_Linhas : TStringList;
  v_Arquivo : String;
begin
  v_Arquivo := TcEXPORTARAQUIVO.NomeArquivo('PREVIEW');
  if (v_Arquivo = '') then
    Exit;

  TcEXPORTARAQUIVO.ExportaArquivo(Self, v_Arquivo);

  v_Linhas := TStringList.Create;
  v_Linhas.Add(_Preview.QRPrinter.Title);
  v_Linhas.Add('');
  TcEMAIL.Enviar('', _Preview.QRPrinter.Title, v_Arquivo, v_Linhas);
  v_Linhas.Free;
end;

procedure TcPREVIEW._PreviewPageAvailable(Sender: TObject; PageNum: Integer);
begin
  Caption := 'Relatório - ' + IntToStr(PageNum) + ' página';
  if PageNum > 1 then
    Caption := Caption + 's';

  spePaginas.MaxValue := PageNum;

  case _Preview.QRPrinter.Status of
    mpReady : sStatus := 'Pronto';
    mpBusy : sStatus := 'Processando';
    mpFinished : begin
      sStatus := 'Concluído';
      lblAguarde.Visible := False;
      speZoom.Value := _Preview.Zoom;
      _PreviewProgressUpdate(Self, 100);
      ProgressBar.Visible := False;
    end;
  end;

  if (ProgressBar.Visible) then
    _PreviewProgressUpdate(Self, ProgressBar.Position + 10);

  UpdateButtons;
end;

procedure TcPREVIEW._PreviewProgressUpdate(Sender: TObject; Progress: Integer);
begin
  ProgressBar.Position := Progress;
  if (Progress = 0) or (Progress >= 100) then
    ProgressBar.Position := 0;
end;

procedure TcPREVIEW.spePaginasChange(Sender: TObject);
begin
  Application.ProcessMessages;
  _Preview.PageNumber := spePaginas.Value;
  UpDateButtons;
end;

procedure TcPREVIEW.speZoomChange(Sender: TObject);
begin
  Application.ProcessMessages;
  _Preview.Zoom := speZoom.Value;
end;

procedure TcPREVIEW.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  aRect: TRect;
begin
  if Panel = StatusBar.Panels[Ord(tpsProgress)] then begin
    aRect := Rect;
    InflateRect(aRect, 1, 1);
    ProgressBar.BoundsRect := aRect;
  end;
end;

end.
