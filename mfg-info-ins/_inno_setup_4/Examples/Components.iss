; -- Components.iss --
; Demonstrates a components-based installation.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!

[Setup]
AppName=My Program
AppVerName=My Program version 1.5
DefaultDirName={pf}\My Program
DefaultGroupName=My Program
UninstallDisplayIcon={app}\MyProg.exe

[Types]
Name: "full"; Description: "Full installation"
Name: "compact"; Description: "Compact installation"
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
; Note: The following line does nothing other than provide a visual cue
; to the user that the program files are installed no matter what.
Name: "program"; Description: "Program Files"; Types: full compact custom; Flags: fixed
Name: "help"; Description: "Help File"; Types: full
Name: "readme"; Description: "Readme File"; Types: full
Name: "readme\en"; Description: "English"; Flags: exclusive
Name: "readme\de"; Description: "German"; Flags: exclusive

[Files]
Source: "MyProg.exe"; DestDir: "{app}"
Source: "MyProg.hlp"; DestDir: "{app}"; Components: help
Source: "Readme.txt"; DestDir: "{app}"; Components: readme\en; Flags: isreadme
Source: "Readme-German.txt"; DestName: "Liesmich.txt"; DestDir: "{app}"; Components: readme\de; Flags: isreadme

[Icons]
Name: "{group}\My Program"; Filename: "{app}\MyProg.exe"
