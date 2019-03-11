; -- ISPPExample1.iss --
;
; This script shows various basic things you can achieve using Inno Setup Preprocessor by Alex Yackimoff.
; To enable commented #define's, either remove the ';' or use ISPPCC with the /D switch.
;
; For more information about ISPP see http://ispp.sourceforge.net

#pragma option -v+
#pragma verboselevel 9

#define Debug

;#define AppEnterprise

#ifdef AppEnterprise
  #define AppName "My Program Enterprise Edition"
#else
  #define AppName "My Program"
#endif

#define AppVersion GetFileVersion(AddBackslash(SourcePath) + "MyProg.exe")

[Setup]
AppName={#AppName}
AppVerName={#AppName} version {#AppVersion}
DefaultDirName={pf}\{#AppName}
DefaultGroupName={#AppName}
UninstallDisplayIcon={app}\MyProg.exe
LicenseFile={#file AddBackslash(SourcePath) + "ISPPExample1License.txt"}
VersionInfoVersion={#AppVersion}

[Files]
Source: "MyProg.exe"; DestDir: "{app}"
#ifdef AppEnterprise
Source: "MyProg.hlp"; DestDir: "{app}"
#endif
Source: "Readme.txt"; DestDir: "{app}"; \
  Flags: isreadme

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\MyProg.exe"

#ifdef Debug
  #expr SaveToFile(AddBackslash(SourcePath) + "Preprocessed.iss")
#endif
