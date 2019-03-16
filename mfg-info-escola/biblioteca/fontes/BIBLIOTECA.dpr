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
  ucXML in '..\..\(componente delphi)-novo\ucXML.pas',
  ucITEM in '..\..\(componente delphi)-novo\ucITEM.pas',
  ucFORM in '..\..\(Componente Delphi)-Novo\ucFORM.pas' {cFORM},
  ucALTERARSENHA in '..\..\(Componente Delphi)-Novo\ucALTERARSENHA.pas' {cALTERARSENHA},
  ucBACKUP in '..\..\(Componente Delphi)-Novo\ucBACKUP.pas' {cBACKUP},
  ucCADASTRO in '..\..\(Componente Delphi)-Novo\ucCADASTRO.pas' {cCADASTRO},
  ucCADASTROFUNC in '..\..\(Componente Delphi)-Novo\ucCADASTROFUNC.pas',
  ucCLIENT in '..\..\(Componente Delphi)-Novo\ucCLIENT.pas' {cCLIENT},
  ucCOMP in '..\..\(Componente Delphi)-Novo\ucCOMP.pas',
  ucCOMPPESQ in '..\..\(componente delphi)-novo\ucCOMPPESQ.pas',
  ucCONFEMAIL in '..\..\(Componente Delphi)-Novo\ucCONFEMAIL.pas' {cCONFEMAIL},
  ucCONFIMPRESSAO in '..\..\(Componente Delphi)-Novo\ucCONFIMPRESSAO.pas' {cCONFIMPRESSAO},
  ucCONFMANUT in '..\..\(componente delphi)-novo\ucCONFMANUT.pas' {cCONFMANUT},
  ucCONFINCRE in '..\..\(componente delphi)-novo\ucCONFINCRE.pas' {cCONFINCRE},
  ucCONFVALID in '..\..\(componente delphi)-novo\ucCONFVALID.pas' {cCONFVALID},
  ucCONFPAGINA in '..\..\(Componente Delphi)-Novo\ucCONFPAGINA.pas' {cCONFPAGINA},
  ucCONFRELAT in '..\..\(componente delphi)-novo\ucCONFRELAT.pas' {cCONFRELAT},
  ucCONST in '..\..\(Componente Delphi)-Novo\ucCONST.pas',
  ucDADOS in '..\..\(Componente Delphi)-Novo\ucDADOS.pas' {dDADOS: TDataModule},
  ucDIR in '..\..\(Componente Delphi)-Novo\ucDIR.pas' {cDIR},
  ucDIRETORIO in '..\..\(Componente Delphi)-Novo\ucDIRETORIO.pas',
  ucEMAIL in '..\..\(Componente Delphi)-Novo\ucEMAIL.pas' {cEMAIL},
  ucFUNCAO in '..\..\(Componente Delphi)-Novo\ucFUNCAO.pas',
  ucLISTAEMAIL in '..\..\(Componente Delphi)-Novo\ucLISTAEMAIL.pas' {cLISTAEMAIL},
  ucLOGALTERACAO in '..\..\(Componente Delphi)-Novo\ucLOGALTERACAO.pas',
  ucLOGIN in '..\..\(Componente Delphi)-Novo\ucLOGIN.pas' {cLOGIN},
  ucMENU in '..\..\(Componente Delphi)-Novo\ucMENU.pas' {cMENU},
  ucOBS in '..\..\(Componente Delphi)-Novo\ucOBS.pas' {cOBS},
  ucPARAMETRO in '..\..\(Componente Delphi)-Novo\ucPARAMETRO.pas' {cPARAMETRO},
  ucPREVIEW in '..\..\(Componente Delphi)-Novo\ucPREVIEW.pas' {cPREVIEW},
  ucPREVIEW_TXT in '..\..\(Componente Delphi)-Novo\ucPREVIEW_TXT.pas' {cPREVIEW_TXT},
  ucRELATORIO in '..\..\(Componente Delphi)-Novo\ucRELATORIO.pas' {cRELATORIO: TQuickRep},
  ucSOBRE in '..\..\(Componente Delphi)-Novo\ucSOBRE.pas' {cSOBRE},
  ucSPLASH in '..\..\(Componente Delphi)-Novo\ucSPLASH.pas' {cSPLASH},
  ucSTRING in '..\..\(Componente delphi)-novo\ucSTRING.pas',
  ucUSUARIO in '..\..\(Componente Delphi)-Novo\ucUSUARIO.pas' {cUSUARIO},
  ucARQUIVO in '..\..\(componente delphi)-novo\ucARQUIVO.pas',
  ucPATH in '..\..\(componente delphi)-novo\ucPATH.pas',
  ucMETADATA in '..\..\(componente delphi)-novo\ucMETADATA.pas',
  ucCAMPO in '..\..\(componente delphi)-novo\ucCAMPO.pas',
  ucFORMATAR in '..\..\(componente delphi)-novo\ucFORMATAR.pas',
  ucSELECT in '..\..\(componente delphi)-novo\ucSELECT.pas',
  ucCOMANDO in '..\..\(componente delphi)-novo\ucCOMANDO.pas',
  ucCONSULTA in '..\..\(componente delphi)-novo\ucCONSULTA.pas',
  ucMANUTENCAO in '..\..\(componente delphi)-novo\ucMANUTENCAO.pas',
  ucVERSAO in '..\..\(componente delphi)-novo\ucVERSAO.pas',
  ucPROJETO in '..\..\(componente delphi)-novo\ucPROJETO.pas',
  ucREGXML in '..\..\(componente delphi)-novo\ucREGXML.pas',
  ucFOTO in '..\..\(componente delphi)-novo\ucFOTO.pas' {cFOTO},
  ucREPORT in '..\..\(componente delphi)-novo\ucREPORT.pas' {cREPORT: TQuickRep},
  ucTIPOIMPRESSAO in '..\..\(Componente Delphi)-Novo\ucTIPOIMPRESSAO.pas',
  ucEXPORTARAQUIVO in '..\..\(Componente Delphi)-Novo\ucEXPORTARAQUIVO.pas',
  ucCONFCAMPO in '..\..\(componente delphi)-novo\ucCONFCAMPO.pas',
  ucCONFCAMPOJSON in '..\..\(componente delphi)-novo\ucCONFCAMPOJSON.pas',
  uLkJSON in '..\..\(componente delphi)-novo\uLkJSON.pas',
  uMENU in 'uMENU.pas' {fMENU},
  uLIMPEZA in 'uLIMPEZA.pas',
  uLIVRO in 'uLIVRO.pas' {fLIVRO},
  uLOCACAO in 'uLOCACAO.pas' {fLOCACAO},
  uCONSULTA in 'uCONSULTA.pas' {fCONSULTA},
  uGENERO in 'uGENERO.pas' {fGENERO},
  uEDITORA in 'uEDITORA.pas' {fEDITORA},
  uCURSO in 'uCURSO.pas' {fCURSO},
  uLOCADOR in 'uLOCADOR.pas' {fLOCADOR},
  uCAIXA in 'uCAIXA.pas' {fCAIXA},
  uINFLIV in 'uINFLIV.pas' {fINFLIV},
  uTPENSINO in 'uTPENSINO.pas' {fTPENSINO},
  uTURMA in 'uTURMA.pas' {fTURMA},
  uRELCARTEIRA in 'uRELCARTEIRA.pas' {rRELCARTEIRA: TQuickRep};

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
