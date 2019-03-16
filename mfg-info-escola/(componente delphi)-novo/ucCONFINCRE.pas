unit ucCONFINCRE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin, CheckLst,
  ucCONFMANUT, ucCONFCAMPO;

type
  TcCONFINCRE = class(TcCONFMANUT)
    procedure FormCreate(Sender: TObject);
  private
  protected
    function GetFlag(pConfCampo : TcCONFCAMPO) : Boolean; override;
    procedure SetFlag(pConfCampo : TcCONFCAMPO; Value : Boolean); override;
  public
  end;

implementation

{$R *.dfm}

procedure TcCONFINCRE.FormCreate(Sender: TObject);
begin
  _Titulo := 'Configura Incremeno';
  inherited;
end;

function TcCONFINCRE.GetFlag(pConfCampo: TcCONFCAMPO): Boolean;
begin
  Result := pConfCampo.InIncre;
end;

procedure TcCONFINCRE.SetFlag(pConfCampo: TcCONFCAMPO; Value: Boolean);
begin
  pConfCampo.InIncre := Value;
end;

end.
