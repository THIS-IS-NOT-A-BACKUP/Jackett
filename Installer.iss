; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Jackett"
#define MyAppVersion GetFileVersion(MyFileForVersion)
#define MyAppPublisher "Jackett"
#define MyAppURL "https://github.com/Jackett/Jackett"
#define MyAppExeName "JackettTray.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{C2A9FC00-AA48-4F17-9A72-62FBCEE2785B}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
CloseApplications=yes
CloseApplicationsFilter=*.chm
RestartApplications=no
DefaultDirName={commonappdata}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputBaseFilename={#MyOutputFilename}
SetupIconFile=src\Jackett.Tray\jackett.ico
UninstallDisplayIcon={commonappdata}\Jackett\{#MyAppExeName}
VersionInfoVersion={#MyAppVersion}
UninstallDisplayName={#MyAppName}
Compression=lzma
SolidCompression=yes
DisableDirPage=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "windowsService"; Description: "Install as a Windows Service"
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "{#MySourceFolder}\*"; DestDir: "{commonappdata}\Jackett"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{commonappdata}\Jackett\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{commonappdata}\Jackett\{#MyAppExeName}"; Tasks: desktopicon

[Code]
Procedure RegisterExtraCloseApplicationsResources();
Begin
  RegisterExtraCloseApplicationsResource(False, ExpandConstant('{app}\JackettService.exe'));
  RegisterExtraCloseApplicationsResource(False, ExpandConstant('{app}\{#MyAppExeName}'));
End;

[Run]
Filename: "{commonappdata}\Jackett\JackettConsole.exe"; Parameters: "--Uninstall"; Flags: waituntilterminated runhidden;
Filename: "{commonappdata}\Jackett\JackettConsole.exe"; Parameters: "--ReserveUrls"; Flags: waituntilterminated runhidden;
Filename: "{commonappdata}\Jackett\JackettConsole.exe"; Parameters: "--Install"; Flags: waituntilterminated runhidden; Tasks: windowsService
Filename: "{commonappdata}\Jackett\JackettConsole.exe"; Parameters: "--Start"; Flags: waituntilterminated runhidden; Tasks: windowsService
Filename: "{commonappdata}\Jackett\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[UninstallRun]
Filename: "{commonappdata}\Jackett\JackettConsole.exe"; Parameters: "--Uninstall"; Flags: waituntilterminated skipifdoesntexist runhidden
Filename: "{sys}\taskkill.exe"; Parameters: "/f /im {#MyAppExeName}"; Flags: waituntilterminated skipifdoesntexist runhidden
Filename: "{sys}\taskkill.exe"; Parameters: "/f /im JackettConsole.exe"; Flags: waituntilterminated skipifdoesntexist runhidden


