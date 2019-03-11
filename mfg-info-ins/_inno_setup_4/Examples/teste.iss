[Setup]
AppName=Sistema SCA
AppVerName=Sistema SCA 1.0
AppPublisher=MFG-Info
CreateAppDir=yes
AppPublisherURL=http://www.mfg-info.com.br
AppSupportURL=http://www.mfg-info.com.br
AppUpdatesURL=http://www.mfg-info.com.br
DefaultDirName=C:\MFG-Info\SCA-Agua
DefaultGroupName=SCA-Agua
OutputDir=C:\CD\Sistema
OutputBaseFilename=Instalação SCA
Compression=lzma
SolidCompression=yes
WizardImageFile=Inno1.bmp

[Types]
Name: "full"; Description: "Instalação Completa"
Name: "compact"; Description: "Atualização"
;Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
;Name: "program"; Description: "Program Files"; Types: full compact custom; Flags: fixed
Name: "program"; Description: "Program Files"; Types: full compact; Flags: fixed
Name: "DataBase"; Description: "DataBase File"; Types: full

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Files]
Source: C:\MFG-Info\SCA-Agua\Sistema\*; DestDir: {app}\Sistema; Flags: ignoreversion recursesubdirs
Source: C:\MFG-Info\SCA-Agua\Dados\*; DestDir: {app}\Dados; Components: DataBase; Flags: ignoreversion recursesubdirs
Source: C:\MFG-Info\Instalação\DLL's\*; DestDir: {sys}; Components: DataBase; Flags: ignoreversion;
Source: C:\MFG-Info\Instalação\Interbase\*; DestDir: {pf}\Interbase; Components: DataBase; Flags: ignoreversion recursesubdirs

[Icons]
Name: {group}\SCA-Agua; Filename: {app}\Sistema\SCA.exe
Name: {userdesktop}\SCA-Agua; Filename: {app}\Sistema\SCA.exe; Tasks: desktopicon

[Run]
FileName: {pf}\Interbase\Setup.exe; Description: {cm:LaunchProgram,Interbase}; Flags: nowait postinstall skipifsilent
Filename: {app}\Sistema\SCA.exe; Description: {cm:LaunchProgram,SCA}; Flags: nowait postinstall skipifsilent

