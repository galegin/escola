; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=Sistema BIBLIOTECA
AppVerName=Atualização do Sistema BIBLIOTECA 1.0
AppPublisher=MFG-Info
CreateAppDir=yes
AppPublisherURL=http://www.mfg-info.com.br
AppSupportURL=http://www.mfg-info.com.br
AppUpdatesURL=http://www.mfg-info.com.br
DefaultDirName=\MFG-Info-ESCOLA\BIBLIOTECA
DefaultGroupName=BIBLIOTECA
OutputDir=D:\projeto\mfg-info-ins\_Instalacao
OutputBaseFilename=Atualização BIBLIOTECA
Compression=lzma
SolidCompression=yes
WizardImageFile=Inno1.bmp

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Files]
Source: D:\projeto\mfg-info-escola\BIBLIOTECA\BIBLIOTECA.*; DestDir: {app}; Flags: ignoreversion

[Icons]
Name: {group}\BIBLIOTECA; Filename: {app}\BIBLIOTECA.exe
Name: {userdesktop}\BIBLIOTECA; Filename: {app}\BIBLIOTECA.exe; Tasks: desktopicon

[Run]
Filename: {app}\BIBLIOTECA.exe; Description: {cm:LaunchProgram,BIBLIOTECA}; Flags: nowait postinstall skipifsilent
