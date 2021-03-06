; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=Sistema Igreja
AppVerName=Sistema Igreja 1.0
AppPublisher=MFG-Info
CreateAppDir=yes
AppPublisherURL=http://www.mfg-info.com.br
AppSupportURL=http://www.mfg-info.com.br
AppUpdatesURL=http://www.mfg-info.com.br
DefaultDirName=C:\MFG-Info\SCI
DefaultGroupName=SCI
OutputDir=C:\CD\Sistema
OutputBaseFilename=Instalação Igreja
Compression=lzma
SolidCompression=yes
WizardImageFile=Inno1.bmp

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Files]
Source: C:\MFG-Info\SCI\Dados\*; DestDir: {app}\Dados; Flags: ignoreversion recursesubdirs
Source: C:\MFG-Info\SCI\Sistema\*; DestDir: {app}\Sistema; Flags: ignoreversion recursesubdirs
Source: C:\MFG-Info\Instalação\DLL's\*; DestDir: {sys}; Flags: ignoreversion
Source: C:\MFG-Info\Instalação\Interbase Windows Server and Client v6.0.1\InterBase_WI-V6.0.1-server\*; DestDir: {pf}\Interbase; Flags: ignoreversion recursesubdirs

[Icons]
Name: {group}\SCI; Filename: {app}\Sistema\SCI.exe
Name: {userdesktop}\SCI; Filename: {app}\Sistema\SCI.exe; Tasks: desktopicon

[Run]
FileName: {pf}\Interbase\Setup.exe; Description: {cm:LaunchProgram,Interbase}; Flags: nowait postinstall skipifsilent
Filename: {app}\Sistema\SCI.exe; Description: {cm:LaunchProgram,SCI}; Flags: nowait postinstall skipifsilent
