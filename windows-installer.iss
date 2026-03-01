; Venx2 Windows Installer Script for Inno Setup
; This script creates a professional Windows installer for Venx2
; Download Inno Setup from: https://jrsoftware.org/isdl.php

#define MyAppName "Venx2"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Your Company Name"
#define MyAppURL "https://your-company-website.com"
#define MyAppExeName "start-venx2.bat"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
AppId={{A8B7C9D1-E2F3-4A5B-6C7D-8E9F0A1B2C3D}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
LicenseFile=LICENSE.txt
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
OutputDir=installer-output
OutputBaseFilename=Venx2-Setup-{#MyAppVersion}
SetupIconFile=app\assets\images\icon.ico
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
UninstallDisplayIcon={app}\app\assets\images\icon.ico

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: checked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 6.1; Check: not IsAdminInstallMode

[Files]
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: "*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "node_modules,tmp,log,storage\*.sqlite3,coverage,.git,.bundle"
Source: "bin\install-dependencies.bat"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "bin\start-venx2.bat"; DestDir: "{app}\bin"; Flags: ignoreversion

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\bin\{#MyAppExeName}"; IconFilename: "{app}\app\assets\images\icon.ico"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\bin\{#MyAppExeName}"; IconFilename: "{app}\app\assets\images\icon.ico"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\bin\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
; Install dependencies first
Filename: "{app}\bin\install-dependencies.bat"; Description: "Install required dependencies (Ruby, Node.js, etc.)"; Flags: postinstall runascurrentuser waituntilterminated
; Setup the application
Filename: "{cmd}"; Parameters: "/c cd ""{app}"" && bundle install && yarn install && bundle exec rake db:create db:migrate db:seed && yarn build && yarn build:css"; Description: "Setup application and install packages"; Flags: postinstall runhidden waituntilterminated
; Optionally run the application
Filename: "{app}\bin\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: postinstall skipifsilent nowait

[Code]
var
  DependenciesPage: TOutputProgressWizardPage;

procedure InitializeWizard;
begin
  DependenciesPage := CreateOutputProgressPage('Checking Dependencies', 'Please wait while Setup checks for required dependencies.');
end;

function PrepareToInstall(var NeedsRestart: Boolean): String;
var
  ResultCode: Integer;
begin
  DependenciesPage.SetText('Checking Ruby installation...', '');
  DependenciesPage.SetProgress(0, 100);
  DependenciesPage.Show;
  
  try
    // Check if Ruby is installed
    if not Exec('cmd.exe', '/c where ruby', '', SW_HIDE, ewWaitUntilTerminated, ResultCode) or (ResultCode <> 0) then
    begin
      DependenciesPage.SetText('Ruby not found. It will be installed after setup.', '');
    end
    else
    begin
      DependenciesPage.SetText('Ruby is already installed.', '');
    end;
    
    DependenciesPage.SetProgress(50, 100);
    
    // Check if Node.js is installed
    DependenciesPage.SetText('Checking Node.js installation...', '');
    if not Exec('cmd.exe', '/c where node', '', SW_HIDE, ewWaitUntilTerminated, ResultCode) or (ResultCode <> 0) then
    begin
      DependenciesPage.SetText('Node.js not found. It will be installed after setup.', '');
    end
    else
    begin
      DependenciesPage.SetText('Node.js is already installed.', '');
    end;
    
    DependenciesPage.SetProgress(100, 100);
    Sleep(1000);
    
  finally
    DependenciesPage.Hide;
  end;
  
  Result := '';
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: Integer;
begin
  if CurStep = ssPostInstall then
  begin
    // Set environment variable for the app
    RegWriteStringValue(HKEY_CURRENT_USER, 'Environment', 'VENX2_HOME', ExpandConstant('{app}'));
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usPostUninstall then
  begin
    // Remove environment variable
    RegDeleteValue(HKEY_CURRENT_USER, 'Environment', 'VENX2_HOME');
    
    // Ask if user wants to remove database and uploaded files
    if MsgBox('Do you want to remove all application data including database and uploaded files?', mbConfirmation, MB_YESNO) = IDYES then
    begin
      DelTree(ExpandConstant('{app}\storage'), True, True, True);
      DelTree(ExpandConstant('{app}\log'), True, True, True);
      DelTree(ExpandConstant('{app}\tmp'), True, True, True);
    end;
  end;
end;
