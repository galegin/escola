program BIBLIOTECA;

{
PENDENTE
  EM LOCADOR
  - IMPRIMIR A CARTEIRINHA COM CODIGO DE BARRA DO ALUNO E FOTO
  - GRAVAR FOTO

CONFIGURAR MANUTENCAO 2 COLUNAS MELHOR APROVEITAMENTO TELA  - OK
TESTAR MOTIVO ISENCAO  - OK
SOLICITACAO ESCOLA
CONFIGURACAO
}

uses
  Forms,
  SysUtils,
  cAPPPROTECT in '..\..\(componente delphi)-novo\cAPPPROTECT.pas',
  fAPPPROTECT in '..\..\(componente delphi)-novo\fAPPPROTECT.pas',
  uLkJSON in '..\..\(componente delphi)-novo\uLkJSON.pas',
  ucALTERARSENHA in '..\..\(Componente Delphi)-Novo\ucALTERARSENHA.pas' {cALTERARSENHA},
  ucARQUIVO in '..\..\(componente delphi)-novo\ucARQUIVO.pas',
  ucBACKUP in '..\..\(Componente Delphi)-Novo\ucBACKUP.pas' {cBACKUP},
  ucCADASTRO in '..\..\(Componente Delphi)-Novo\ucCADASTRO.pas' {cCADASTRO},
  ucCADASTROFUNC in '..\..\(Componente Delphi)-Novo\ucCADASTROFUNC.pas',
  ucCAMPO in '..\..\(componente delphi)-novo\ucCAMPO.pas',
  ucCLIENT in '..\..\(Componente Delphi)-Novo\ucCLIENT.pas' {cCLIENT},
  ucCOMANDO in '..\..\(componente delphi)-novo\ucCOMANDO.pas',
  ucCOMP in '..\..\(Componente Delphi)-Novo\ucCOMP.pas',
  ucCOMPPESQ in '..\..\(componente delphi)-novo\ucCOMPPESQ.pas',
  ucCONFCAMPO in '..\..\(componente delphi)-novo\ucCONFCAMPO.pas',
  ucCONFCAMPOJSON in '..\..\(componente delphi)-novo\ucCONFCAMPOJSON.pas',
  ucCONFCAMPOMET in '..\..\(componente delphi)-novo\ucCONFCAMPOMET.pas',
  ucCONFEMAIL in '..\..\(Componente Delphi)-Novo\ucCONFEMAIL.pas' {cCONFEMAIL},
  ucCONFIMPRESSAO in '..\..\(Componente Delphi)-Novo\ucCONFIMPRESSAO.pas' {cCONFIMPRESSAO},
  ucCONFINCRE in '..\..\(componente delphi)-novo\ucCONFINCRE.pas' {cCONFINCRE},
  ucCONFMANUT in '..\..\(componente delphi)-novo\ucCONFMANUT.pas' {cCONFMANUT},
  ucCONFPAGINA in '..\..\(Componente Delphi)-Novo\ucCONFPAGINA.pas' {cCONFPAGINA},
  ucCONFRELAT in '..\..\(componente delphi)-novo\ucCONFRELAT.pas' {cCONFRELAT},
  ucCONFVALID in '..\..\(componente delphi)-novo\ucCONFVALID.pas' {cCONFVALID},
  ucCONST in '..\..\(Componente Delphi)-Novo\ucCONST.pas',
  ucCONSULTA in '..\..\(componente delphi)-novo\ucCONSULTA.pas',
  ucDADOS in '..\..\(Componente Delphi)-Novo\ucDADOS.pas' {dDADOS: TDataModule},
  ucDIR in '..\..\(Componente Delphi)-Novo\ucDIR.pas' {cDIR},
  ucDIRETORIO in '..\..\(Componente Delphi)-Novo\ucDIRETORIO.pas',
  ucEMAIL in '..\..\(Componente Delphi)-Novo\ucEMAIL.pas' {cEMAIL},
  ucEXPORTARAQUIVO in '..\..\(Componente Delphi)-Novo\ucEXPORTARAQUIVO.pas',
  ucFORM in '..\..\(Componente Delphi)-Novo\ucFORM.pas' {cFORM},
  ucFORMATAR in '..\..\(componente delphi)-novo\ucFORMATAR.pas',
  ucFOTO in '..\..\(componente delphi)-novo\ucFOTO.pas' {cFOTO},
  ucFUNCAO in '..\..\(Componente Delphi)-Novo\ucFUNCAO.pas',
  ucITEM in '..\..\(componente delphi)-novo\ucITEM.pas',
  ucLISTAEMAIL in '..\..\(Componente Delphi)-Novo\ucLISTAEMAIL.pas' {cLISTAEMAIL},
  ucLOGALTERACAO in '..\..\(Componente Delphi)-Novo\ucLOGALTERACAO.pas',
  ucLOGIN in '..\..\(Componente Delphi)-Novo\ucLOGIN.pas' {cLOGIN},
  ucMANUTENCAO in '..\..\(componente delphi)-novo\ucMANUTENCAO.pas',
  ucMENU in '..\..\(Componente Delphi)-Novo\ucMENU.pas' {cMENU},
  ucMETADATA in '..\..\(componente delphi)-novo\ucMETADATA.pas',
  ucOBS in '..\..\(Componente Delphi)-Novo\ucOBS.pas' {cOBS},
  ucPARAMETRO in '..\..\(Componente Delphi)-Novo\ucPARAMETRO.pas' {cPARAMETRO},
  ucPATH in '..\..\(componente delphi)-novo\ucPATH.pas',
  ucPREVIEW in '..\..\(Componente Delphi)-Novo\ucPREVIEW.pas' {cPREVIEW},
  ucPREVIEW_TXT in '..\..\(Componente Delphi)-Novo\ucPREVIEW_TXT.pas' {cPREVIEW_TXT},
  ucPROJETO in '..\..\(componente delphi)-novo\ucPROJETO.pas',
  ucREGXML in '..\..\(componente delphi)-novo\ucREGXML.pas',
  ucRELATORIO in '..\..\(Componente Delphi)-Novo\ucRELATORIO.pas' {cRELATORIO: TQuickRep},
  ucREPORT in '..\..\(componente delphi)-novo\ucREPORT.pas' {cREPORT: TQuickRep},
  ucSELECT in '..\..\(componente delphi)-novo\ucSELECT.pas',
  ucSOBRE in '..\..\(Componente Delphi)-Novo\ucSOBRE.pas' {cSOBRE},
  ucSPLASH in '..\..\(Componente Delphi)-Novo\ucSPLASH.pas' {cSPLASH},
  ucSTRING in '..\..\(Componente delphi)-novo\ucSTRING.pas',
  ucTIPOIMPRESSAO in '..\..\(Componente Delphi)-Novo\ucTIPOIMPRESSAO.pas',
  ucUSUARIO in '..\..\(Componente Delphi)-Novo\ucUSUARIO.pas' {cUSUARIO},
  ucVERSAO in '..\..\(componente delphi)-novo\ucVERSAO.pas',
  ucVERSAOEXE in '..\..\(componente delphi)-novo\ucVERSAOEXE.pas',
  ucXML in '..\..\(componente delphi)-novo\ucXML.pas',
  uMENU in 'uMENU.pas' {fMENU},
  uCAIXA in 'uCAIXA.pas' {fCAIXA},
  uCONSULTA in 'uCONSULTA.pas' {fCONSULTA},
  uCURSO in 'uCURSO.pas' {fCURSO},
  uEDITORA in 'uEDITORA.pas' {fEDITORA},
  uGENERO in 'uGENERO.pas' {fGENERO},
  uINFLIV in 'uINFLIV.pas' {fINFLIV},
  uLIMPEZA in 'uLIMPEZA.pas',
  uLIVRO in 'uLIVRO.pas' {fLIVRO},
  uLOCACAO in 'uLOCACAO.pas' {fLOCACAO},
  uLOCADOR in 'uLOCADOR.pas' {fLOCADOR},
  uRELCARTEIRA in 'uRELCARTEIRA.pas' {rRELCARTEIRA: TQuickRep},
  uRELETIQUETA in 'uRELETIQUETA.pas' {rRELETIQUETA: TQuickRep},
  uTPENSINO in 'uTPENSINO.pas' {fTPENSINO},
  uTURMA in 'uTURMA.pas' {fTURMA};

{$R *.res}

begin
  Application.Title := 'Sistema de Controle de Biblioteca';

  cSPLASH := TcSPLASH.Create(Application);
  cSPLASH.Show;
  cSPLASH.Update;
  Sleep(2000);

  Application.Initialize;
  Application.CreateForm(TfMENU, fMENU);
  cSPLASH.Hide;
  cSPLASH.Free;

  Application.Run;
end.
