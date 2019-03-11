[Setup]
AppName=Sistema SCCCS
AppVerName=Sistema SCCCS 1.0
AppPublisher=MFG-Info
CreateAppDir=yes
AppPublisherURL=http://www.mfg-info.com.br
AppSupportURL=http://www.mfg-info.com.br
AppUpdatesURL=http://www.mfg-info.com.br
DefaultDirName=\MFG-Info\SCCCS
DefaultGroupName=SCCCS
OutputDir=C:\CD\Sistema
OutputBaseFilename=Instalação SCCCS
Compression=lzma
SolidCompression=yes
WizardImageFile=Inno1.bmp

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Files]
Source: C:\MFG-Info\SCCCS\Tabelas\*; DestDir: {app}\Tabelas; Flags: ignoreversion recursesubdirs
Source: C:\MFG-Info\SCCCS\Sistema\*; DestDir: {app}\Sistema; Flags: ignoreversion recursesubdirs
Source: C:\MFG-Info\Instalação\BDE\*; DestDir: {pf}\BDE; Flags: ignoreversion recursesubdirs

[Icons]
Name: {group}\SCCCS; Filename: {app}\Sistema\SCCCS.exe
Name: {userdesktop}\SCCCS; Filename: {app}\Sistema\SCCCS.exe; Tasks: desktopicon

[Run]
FileName: {pf}\BDE\Setup.exe; Description: {cm:LaunchProgram,BDE}; Flags: nowait postinstall skipifsilent
Filename: {app}\Sistema\SCCCS.exe; Description: {cm:LaunchProgram,SCCCS}; Flags: nowait postinstall skipifsilent
