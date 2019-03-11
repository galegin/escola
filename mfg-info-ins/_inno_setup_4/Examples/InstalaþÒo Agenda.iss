; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=Sistema Agenda
AppVerName=Sistema Agenda 1.0
AppPublisher=MFG-Info
CreateAppDir=yes
AppPublisherURL=http://www.mfg-info.com.br
AppSupportURL=http://www.mfg-info.com.br
AppUpdatesURL=http://www.mfg-info.com.br
DefaultDirName=\MFG-Info\Agenda
DefaultGroupName=Agenda
OutputDir=C:\CD\Sistema
OutputBaseFilename=Instalação Agenda
Compression=lzma
SolidCompression=yes
WizardImageFile=Inno1.bmp

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Files]
;Source: C:\MFG-Info\Agenda\Sistema\Agenda.exe; DestDir: {app}; Flags: ignoreversion
Source: C:\MFG-Info\Agenda\Dados\*; DestDir: {app}\Dados; Flags: ignoreversion recursesubdirs
Source: C:\MFG-Info\Agenda\Sistema\*; DestDir: {app}\Sistema; Flags: ignoreversion recursesubdirs
Source: C:\MFG-Info\Instalação\DLL's\*; DestDir: {sys}; Flags: ignoreversion
Source: C:\MFG-Info\Instalação\Interbase Windows Server and Client v6.0.1\InterBase_WI-V6.0.1-server\*; DestDir: {pf}\Interbase; Flags: ignoreversion recursesubdirs
; Source: C:\MFG-Info\Instalação\Firebird-1.5.0.4306-Win32.exe; DestDir: {pf}; Flags: ignoreversion deleteafterinstall
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: {group}\Agenda; Filename: {app}\Sistema\Agenda.exe
Name: {userdesktop}\Agenda; Filename: {app}\Sistema\Agenda.exe; Tasks: desktopicon

[Run]
;FileName: {pf}\Firebird-1.5.0.4306-Win32.exe; Parameters: /verysilent; Flags: runminimized
FileName: {pf}\Interbase\Setup.exe; Description: {cm:LaunchProgram,Interbase}; Flags: nowait postinstall skipifsilent
Filename: {app}\Sistema\Agenda.exe; Description: {cm:LaunchProgram,Agenda}; Flags: nowait postinstall skipifsilent
