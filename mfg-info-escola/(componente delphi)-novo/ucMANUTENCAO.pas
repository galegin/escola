unit ucMANUTENCAO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, ExtCtrls, Grids,
  FMTBcd, DB, DBClient, Provider, SqlExpr, ucFORM, DBGrids, Menus;

type
  TcMANUTENCAO = class(TcFORM)
    ScrollBox1: TScrollBox;
    LabelF12: TLabel;
    StringGrid1: TStringGrid;
    Image1: TImage;
    Memo1: TMemo;
    ToolButtonConfirmar: TToolButton;
    ToolButtonCancelar: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ToolButtonConfirmarClick(Sender: TObject);
    procedure ToolButtonCancelarClick(Sender: TObject);
  private
  public
  published
    class function execute(pParams : String = ''; pFiltro : String = '') : String;
  end;

implementation

{$R *.dfm}

uses
  ucDADOS, ucITEM, ucCADASTROFUNC, ucFUNCAO, ucLOGALTERACAO;

//------------------------------------------------------------------------------

class function TcMANUTENCAO.execute(pParams, pFiltro : String) : String;
begin
  with TcMANUTENCAO.Create(nil) do begin
    Name := item('DS_CAPTION', pParams) + 'm';

    try
      _Params := pParams;
      _Filtro := pFiltro;
      if ShowModal = mrOk then begin
        Result := _Result + Hint;
        putitem(Result, 'IN_OK', True);
      end;
    finally
      Free;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TcMANUTENCAO.FormShow(Sender: TObject);
var
  vSqlChave : String;
begin
  _Caption := item('DS_CAPTION', _Params);
  _TabMan := item('DS_TABELA', _Params);
  cSQL := item('DS_SQL', _Params);

  Caption := _Caption; // Incluindo / Alterando / Excluindo / Consultando

  p_LerIni;
  p_Consultar(cSQL,REG_LIMPO);
  p_CriarCampos(ScrollBox1);

  inherited;

  Application.ProcessMessages;

  _DataSet.Insert;

  if itemB('IN_ALTERAR', _Params) or itemB('IN_EXCLUIR', _Params) then begin
    p_HabilitaChave(False);
    getlistitensocc(_Filtro, _DataSet);
    p_CarregarCampos;
    vSqlChave := f_GerarChave;
    p_Consultar(cSQL + ' and ' + vSqlChave);
    if itemB('IN_ALTERAR',_Params) then _DataSet.Edit;
  end;

  p_MontaTabela;

  ToolButtonFechar.Visible := itemB('IN_CONSULTA', _Params);
  ToolButtonConfirmar.Visible := not itemB('IN_CONSULTA', _Params);
  ToolButtonCancelar.Visible := not itemB('IN_CONSULTA', _Params);
end;

procedure TcMANUTENCAO.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_F3) and (ToolButtonConfirmar.Visible) then ToolButtonConfirmar.Click;
end;

//------------------------------------------------------------------------------

procedure TcMANUTENCAO.ToolButtonConfirmarClick(Sender: TObject);
begin
  p_DesCarregarCampos;
  dDADOS.p_IncrementoCodigo(_DataSet, _TabMan, _IncMan);
  if not f_VerObrigatorio then Exit;
  TcLOGALTERACAO.Gravar(_DataSet, _TabMan, cLogMan);
  _DataSet.Post;
  ModalResult := mrOk;
end;

procedure TcMANUTENCAO.ToolButtonCancelarClick(Sender: TObject);
begin
  _DataSet.Cancel;
  ModalResult := mrCancel;
end;

//------------------------------------------------------------------------------

end.
