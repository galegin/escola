unit uCAIXA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, FMTBcd, Menus, SqlExpr, Provider, DB, DBClient,
  StdCtrls, Grids, DBGrids, Buttons, ExtCtrls, ComCtrls, ToolWin, ucFORM;

type
  TfCAIXA = class(TcCADASTRO)
    procedure FormCreate(Sender: TObject);
    procedure ToolButtonConsultarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

uses
  ucFUNCAO, ucCONST;

const
  DS_SQL =
    'select DT_PAGOMULTA ' +
    ',      sum(VL_MULTA) as VL_MULTA ' +
    'from V_GER_CAIXA ' ;

  DS_GRP =
    ' group by DT_PAGOMULTA ';

procedure TfCAIXA.FormCreate(Sender: TObject);
begin
  inherited;
  
  cModoFormulario := mfConsulta;
  cTabMan := 'V_GER_CAIXA';

  cSQL := DS_SQL + DS_GRP;
end;

procedure TfCAIXA.ToolButtonConsultarClick(Sender: TObject);
var
  vSql : String;
begin
  vSql := DS_SQL + f_ObterFiltroSQL + DS_GRP;
  p_Consultar(vSql);
  if _DataSet.IsEmpty then
    raise Exception.Create(cMESSAGE_NENHUMREGISTRO);
end;

procedure TfCAIXA.FormShow(Sender: TObject);
begin
  inherited;
  ToolButtonImprimir.Visible := True;
end;

initialization
  RegisterClass(TfCAIXA);

end.