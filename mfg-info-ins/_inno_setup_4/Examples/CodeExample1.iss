; -- CodeExample1.iss --
;
; This script shows various things you can achieve using a [Code] section

[Setup]
AppName=My Program
AppVerName=My Program version 1.5
DefaultDirName={code:MyConst}\My Program
DefaultGroupName=My Program
UninstallDisplayIcon={app}\MyProg.exe

[Files]
Source: "MyProg.exe"; DestDir: "{app}"; Check: MyProgCheck; BeforeInstall: BeforeMyProgInstall(MyProg.exe); AfterInstall: AfterMyProgInstall(MyProg.exe)
Source: "MyProg.hlp"; DestDir: "{app}"; Check: MyProgCheck; BeforeInstall: BeforeMyProgInstall(MyProg.hlp); AfterInstall: AfterMyProgInstall(MyProg.hlp)
Source: "Readme.txt"; DestDir: "{app}"; Flags: isreadme

[Icons]
Name: "{group}\My Program"; Filename: "{app}\MyProg.exe"

[Code]
var
  MyProgChecked: Boolean;
  MyProgCheckResult: Boolean;
  FinishedInstall: Boolean;

function InitializeSetup(): Boolean;
begin
  Result := MsgBox('Script.InitializeSetup:' #13#13 'Setup is initializing. Do you really want to start setup?', mbConfirmation, MB_YESNO) = idYes;
  if Result = False then
    MsgBox('Script.InitializeSetup:' #13#13 'Ok, bye bye.', mbInformation, MB_OK);
end;

procedure DeInitializeSetup();
var
  FileName: String;
  ErrorCode: Integer;
begin
  if FinishedInstall then begin
    if MsgBox('Script.DeInitializeSetup:' #13#13 'The [Code] scripting demo has finished. Do you want to uninstall My Program now?', mbConfirmation, MB_YESNO) = idYes then begin
      FileName := ExpandConstant('{uninstallexe}');
      if not InstShellExec(FileName, '', '', SW_SHOWNORMAL, ErrorCode) then
        MsgBox('Script.DeInitializeSetup:' #13#13 'Execution of ''' + FileName + ''' failed. ' + SysErrorMessage(ErrorCode) + '.', mbError, MB_OK);
    end else
      MsgBox('Script.DeInitializeSetup:' #13#13 'Ok, bye bye.', mbInformation, MB_OK);
  end;
end;

procedure CurStepChanged(CurStep: Integer);
begin
  if CurStep = csFinished then
    FinishedInstall := True;
end;

function NextButtonClick(CurPage: Integer): Boolean;
var
  ErrorCode: Integer;
begin
  case CurPage of
    wpSelectDir:
      MsgBox('Script.NextButtonClick:' #13#13 'You selected: ''' + WizardDirValue + '''.', mbInformation, MB_OK);
    wpSelectProgramGroup:
      MsgBox('Script.NextButtonClick:' #13#13 'You selected: ''' + WizardGroupValue + '''.', mbInformation, MB_OK);
    wpReady:
      begin
        if MsgBox('Script.NextButtonClick:' #13#13 'Using the script, files can now be extracted before the installation starts. For example we could extract ''MyProg.exe'' now and run it.' #13#13 'Do you want to do this?', mbConfirmation, MB_YESNO) = idYes then begin
          if ExtractTemporaryFile('myprog.exe') then begin
            if not InstExec(ExpandConstant('{tmp}\myprog.exe'), '', '', True, False, SW_SHOWNORMAL, ErrorCode) then
              MsgBox('Script.NextButtonClick:' #13#13 'The file could not be executed. ' + SysErrorMessage(ErrorCode) + '.', mbError, MB_OK);
          end else
            MsgBox('Script.NextButtonClick:' #13#13 'The file could not be extracted.', mbError, MB_OK);
        end;
        BringToFrontAndRestore();
        MsgBox('Script.NextButtonClick:' #13#13 'The normal installation will now start.', mbInformation, MB_OK);
      end;
  end;

  Result := True;
end;

function SkipCurPage(CurPage: Integer): Boolean;
begin
  case CurPage of
    wpInfoBefore:
      Result := MsgBox('Script.SkipCurPage:' #13#13 'Do you want to skip the ''InfoBefore'' page?', mbConfirmation, MB_YESNO or MB_DEFBUTTON2) = idYes;
    else
      Result := False;
  end;
end;

procedure CurPageChanged(CurPage: Integer);
begin
  case CurPage of
    wpWelcome:
      MsgBox('Script.CurPageChanged:' #13#13 'Welcome to the [Code] scripting demo. This demo will show you some possibilities of the scripting support.' #13#13 'The scripting engine used is RemObjects Pascal Script by Carlo Kok. See http://www.remobjects.com/?ps for more information.', mbInformation, MB_OK);
    wpFinished:
      MsgBox('Script.CurPageChanged:' #13#13 'Welcome to final page of this demo. Click Finish to exit.', mbInformation, MB_OK);
  end;
end;

function MyProgCheck(): Boolean;
begin
  if not MyProgChecked then begin
    MyProgCheckResult := MsgBox('Script.MyProg:' #13#13 'Do you want to install MyProg.exe and MyProg.hlp to ' + ExtractFilePath(CurrentFileName) + '?', mbConfirmation, MB_YESNO) = idYes;
    MyProgChecked := True;
  end;
  Result := MyProgCheckResult;
end;

procedure BeforeMyProgInstall(S: String);
begin
  MsgBox('Script.BeforeMyProgInstall:' #13#13 'Setup is now going to install ' + S + ' as ' + CurrentFileName + '.', mbInformation, MB_OK);
end;

procedure AfterMyProgInstall(S: String);
begin
  MsgBox('Script.AfterMyProgInstall:' #13#13 'Setup just installed ' + S + ' as ' + CurrentFileName + '.', mbInformation, MB_OK);
end;

function MyConst(Default: String): String;
begin
  Result := ExpandConstant('{pf}');
end;
