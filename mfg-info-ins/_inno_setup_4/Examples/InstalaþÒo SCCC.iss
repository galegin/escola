[Setup]
AppName=Sistema SCCC
AppVerName=Sistema SCCC 1.0
AppPublisher=MFG-Info
CreateAppDir=yes
AppPublisherURL=http://www.mfg-info.com.br
AppSupportURL=http://www.mfg-info.com.br
AppUpdatesURL=http://www.mfg-info.com.br
DefaultDirName=\MFG-Info\SCCC
DefaultGroupName=SCCC
OutputDir=C:\CD\Sistema
OutputBaseFilename=Instalação SCCC
Compression=lzma
SolidCompression=yes
WizardImageFile=Inno1.bmp

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Files]
Source: C:\MFG-Info\SCCC\Tabelas\*; DestDir: {app}\Tabelas; Flags: ignoreversion recursesubdirs
Source: C:\MFG-Info\SCCC\Sistema\*; DestDir: {app}\Sistema; Flags: ignoreversion recursesubdirs
Source: C:\MFG-Info\Instalação\BDE\*; DestDir: {pf}\BDE; Flags: ignoreversion recursesubdirs

[Icons]
Name: {group}\SCCC; Filename: {app}\Sistema\SCCC.exe
Name: {userdesktop}\SCCC; Filename: {app}\Sistema\SCCC.exe; Tasks: desktopicon

[Run]
FileName: {pf}\BDE\Setup.exe; Description: {cm:LaunchProgram,BDE}; Flags: nowait postinstall skipifsilent
Filename: {app}\Sistema\SCCC.exe; Description: {cm:LaunchProgram,SCCC}; Flags: nowait postinstall skipifsilent
