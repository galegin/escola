; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=Sistema INATIVO
AppVerName=Sistema INATIVO 1.0
AppPublisher=MFG-Info
CreateAppDir=yes
AppPublisherURL=http://www.mfg-info.com.br
AppSupportURL=http://www.mfg-info.com.br
AppUpdatesURL=http://www.mfg-info.com.br
DefaultDirName=\MFG-Info-ESCOLA\INATIVO
DefaultGroupName=INATIVO
OutputDir=D:\projeto\mfg-info-ins\_Instalacao
OutputBaseFilename=Instala��o INATIVO
Compression=lzma
SolidCompression=yes
WizardImageFile=Inno1.bmp

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Files]
Source: D:\projeto\mfg-info-escola\INATIVO\Dados\INATIVO.gdb; DestDir: {app}\Dados; Flags: ignoreversion recursesubdirs
Source: D:\projeto\mfg-info-escola\INATIVO\INATIVO.exe; DestDir: {app}; Flags: ignoreversion recursesubdirs
Source: D:\projeto\mfg-info-escola\INATIVO\INATIVO.ini; DestDir: {app}; Flags: ignoreversion recursesubdirs
Source: D:\projeto\mfg-info-escola\INATIVO\Fundo.bmp; DestDir: {app}; Flags: ignoreversion recursesubdirs
Source: D:\projeto\mfg-info-ins\_DLL's\dbexpint.dll; DestDir: {app}; Flags: ignoreversion recursesubdirs
Source: D:\projeto\mfg-info-ins\_DLL's\fbclient.dll; DestDir: {app}; Flags: ignoreversion recursesubdirs
Source: D:\projeto\mfg-info-ins\_Instalacao\Firebird-2.5.0.20343_0_Win32.exe; DestDir: {app}; Flags: ignoreversion deleteafterinstall

[Icons]
Name: {group}\INATIVO; Filename: {app}\INATIVO.exe
Name: {userdesktop}\INATIVO; Filename: {app}\INATIVO.exe; Tasks: desktopicon

[Run]
FileName: {app}\Firebird-2.5.0.20343_0_Win32.exe; Parameters: /verysilent; Flags: runminimized
Filename: {app}\INATIVO.exe; Description: {cm:LaunchProgram,INATIVO}; Flags: nowait postinstall skipifsilent