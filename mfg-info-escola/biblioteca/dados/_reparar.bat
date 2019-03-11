@echo off
echo "------------------------------------------------------------"
echo "-- REPARADOR DE DATABASE                                  --"
echo "------------------------------------------------------------"
pause

set DS_UNID=d
set DS_FIRE=c:\program files (x86)\firebird\firebird_2_5\bin\
set DS_BASE=d:\projeto\mfg-info-escola\biblioteca\dados\
set ISC_USER=sysdba
set ISC_PASSWORD=masterkey
set CD_DATABASE=limpo

echo "------------------------------------------------------------"
echo "-- DIR: %DS_BASE% --"
echo "------------------------------------------------------------"
%DS_UNID%:
cd "%DS_BASE%"
pause

del %CD_DATABASE%.fbk
del %CD_DATABASE%.nov

echo "------------------------------------------------------------"
echo "-- VERIFICANDO: %CD_DATABASE% --"
echo "------------------------------------------------------------"
"%DS_FIRE%gfix" -v -full %CD_DATABASE%.fdb
"%DS_FIRE%gfix" -mend -full -ignore %CD_DATABASE%.fdb
"%DS_FIRE%gfix" -mend -ig %CD_DATABASE%.fdb
pause

echo "------------------------------------------------------------"
echo "-- BACKUP: %CD_DATABASE% --"
echo "------------------------------------------------------------"
"%DS_FIRE%gbak" -b -g -v -ignore -limbo %CD_DATABASE%.fdb %CD_DATABASE%.fbk
pause

echo "------------------------------------------------------------"
echo "-- RESTORE: %CD_DATABASE% --"
echo "------------------------------------------------------------"
"%DS_FIRE%gbak" -create -v -P 8192 %CD_DATABASE%.fbk %CD_DATABASE%.nov
pause

echo "------------------------------------------------------------"
echo "-- WRITE MODE: %CD_DATABASE% --"
echo "------------------------------------------------------------"
"%DS_FIRE%gfix" -write sync %CD_DATABASE%.nov
pause

echo "------------------------------------------------------------"
echo "-- ARQUIVO: CORRIGIDO %CD_DATABASE%.nov RENOMEIE PARA %CD_DATABASE%.fdb --"
echo "------------------------------------------------------------"
pause
