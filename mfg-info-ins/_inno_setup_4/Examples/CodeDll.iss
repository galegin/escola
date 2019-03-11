; -- CodeDll.iss --
;
; This script shows how to call DLL functions at runtime from a [Code] section.

[Setup]
AppName=My Program
AppVerName=My Program version 1.5
DefaultDirName={pf}\My Program
DisableProgramGroupPage=yes
UninstallDisplayIcon={app}\MyProg.exe

[Files]
Source: "MyProg.exe"; DestDir: "{app}"
Source: "MyProg.hlp"; DestDir: "{app}"
Source: "Readme.txt"; DestDir: "{app}"; Flags: isreadme
Source: "MyDll.dll"; Flags: dontcopy
;Source: "MyDll.dll"; DestName: "MyDllWhichMightNotExist.dll"; Flags: dontcopy

[Code]
const
  MB_ICONINFORMATION = $40;

//importing a Windows API function
function MessageBox(hWnd: Integer; lpText, lpCaption: String; uType: Cardinal): Integer;
external 'MessageBoxA@user32.dll stdcall';

//importing a custom DLL function
procedure MyDllFunc(hWnd: Integer; lpText, lpCaption: String; uType: Cardinal);
external 'MyDllFunc@files:MyDll.dll stdcall';

//importing a function for a DLL which might not exist at runtime, see [Files] ('delay loading')
procedure MyDelayLoadedFunc(hWnd: Integer; lpText, lpCaption: String; uType: Cardinal);
external 'MyDllFunc@files:MyDllWhichMightNotExist.dll stdcall delayload';

function NextButtonClick(CurPage: Integer): Boolean;
var
  hWnd: Integer;
begin
  if CurPage = wpWelcome then begin
    hWnd := StrToInt(ExpandConstant('{wizardhwnd}'));

    MessageBox(hWnd, 'Hello from Windows API function', 'MessageBoxA', MB_OK or MB_ICONINFORMATION);

    MyDllFunc(hWnd, 'Hello from custom DLL function', 'MyDllFunc', MB_OK or MB_ICONINFORMATION);

    try
      MyDelayLoadedFunc(hWnd, 'Hello from delay loaded function', 'MyDllFunc', MB_OK or MB_ICONINFORMATION);
    except
      //handle missing dll here
    end;
  end;
  Result := True;
end;
