inherited fMENU: TfMENU
  Left = 225
  Top = 246
  Caption = 'fMENU'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited MainMenu1: TMainMenu
    object Processo1: TMenuItem [2]
      Caption = 'Processo'
      object Limpardados1: TMenuItem
        Caption = 'Limpar dados'
        OnClick = Limpardados1Click
      end
    end
  end
end
