unit ucREPORT;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, QRPrntr, DB,
  DBClient, FMTBcd, SqlExpr, Provider;

type
  TcREPORT = class(TQuickRep)
    _Query: TSQLQuery;
    _Provider: TDataSetProvider;
    _DataSet: TClientDataSet;
    procedure QuickRepPreview(Sender: TObject);
  private
    procedure SetParams(const Value: String);
  protected
    FParams : String;
  public
    constructor create(Aowner : TComponent); override;
  published
    property _Params : String read FParams write SetParams;

    class procedure execute(pParams : String = '');
  end;

implementation

{$R *.DFM}

uses
  ucDADOS, ucPREVIEW, ucITEM, ucXML;

class procedure TcREPORT.execute(pParams : String);
begin
  Application.CreateForm(TComponentClass(Self), Self);
  with TcREPORT(Self) do begin
    try
      _Params := pParams;
      Prepare;
      if itemB('IN_PRINT', pParams) then
        Print
      else
        Preview;
    except
      Free;
      raise;
    end;
    Free;
  end;
end;

constructor TcREPORT.create(Aowner: TComponent);
begin
  inherited; //
  _Query.SQLConnection := dDADOS._Conexao;
end;

procedure TcREPORT.QuickRepPreview(Sender: TObject);
begin
  with TcPREVIEW.Create(Application) do begin
    _Preview.QRPrinter := TQRPrinter(Sender);
    _ClientDataSet := TClientDataSet(DataSet);
    _CaptionRel := itemX('DS_CAPTION', _Params);
    _Sql := itemX('DS_SQL', _Params);
    Show;
  end;
end;

procedure TcREPORT.SetParams(const Value: String);
begin
  FParams := Value;

  if itemX('DS_SQL', FParams) <> '' then
    with _DataSet do begin
      Close;
      _Query.SQL.Text := itemX('DS_SQL', FParams);
      Open;
    end;
end;

end.
