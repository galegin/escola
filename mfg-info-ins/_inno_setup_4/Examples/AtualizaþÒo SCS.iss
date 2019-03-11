; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=Atualização Sistema SCS
AppVerName=Sistema SCS 1.0
AppPublisher=MFG-Info
CreateAppDir=yes
AppPublisherURL=http://www.mfg-info.com.br
AppSupportURL=http://www.mfg-info.com.br
AppUpdatesURL=http://www.mfg-info.com.br
DefaultDirName=C:\MFG-Info\SCS
DefaultGroupName=SCS
OutputDir=C:\CD\Sistema
OutputBaseFilename=Atualização SCS
Compression=lzma
SolidCompression=yes
WizardImageFile=Inno1.bmp

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Files]
Source: C:\MFG-Info\SCS\Sistema\*; DestDir: {app}\Sistema; Flags: ignoreversion recursesubdirs

[Icons]
Name: {group}\SCS; Filename: {app}\Sistema\SCS.exe
Name: {userdesktop}\SCS; Filename: {app}\Sistema\SCS.exe; Tasks: desktopicon

[Run]
Filename: {app}\Sistema\SCS.exe; Description: {cm:LaunchProgram,SCS}; Flags: nowait postinstall skipifsilent
