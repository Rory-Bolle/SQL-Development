@echo off
rem Execute a .ps1 with the same base name as this .bat
setlocal

set "script=%~dp0%~n0.ps1"

if not exist "%script%" (
  echo ERROR: PowerShell script not found: "%script%"
  endlocal
  exit /b 1
)

rem Forward all arguments to the PowerShell script
pwsh.exe -NoProfile -ExecutionPolicy Bypass -File "%script%" -- %*
endlocal
Pause

exit /b %ERRORLEVEL%

