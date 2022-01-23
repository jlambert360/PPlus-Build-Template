:: ============================================================================
:: Virtual SD card main script
:: ============================================================================
@echo off
cls

cd /d %~dp0

::set MIN_EXEC_TIME=3

powershell.exe .\ConfigureNetplay.ps1

call settings.bat

IF EXIST "%SD_CARD_PATH%" goto :Continue
IF NOT EXIST "%SD_CARD_PATH%" goto :MakeSD

:MakeSD
echo  Creating a virtual SD card. . .
"mksdcard.exe" %SD_CARD_SIZE% "sd.raw"
move "sd.raw" "%SD_CARD_PATH%"
echo.
echo  Created.

:Continue
set PURGE_COMMAND=
if %PURGE%==1 (
    set PURGE_COMMAND=/PURGE
)

call mount.bat || goto error

ROBOCOPY "%BUILD_DIR:\=\\%Project+" "%SD_CARD_MOUNT_DRIVE_LETTER:\=\\%:\\Project+." ^
    /E ^
    /NS ^
    /NP ^
    /NJH ^
    %PURGE_COMMAND%
IF %ERRORLEVEL% GEQ 8 goto error

"%SD_CARD_MOUNT_DRIVE_LETTER:\=\\%:\\Project+\GCTRealMate.exe" -q "%SD_CARD_MOUNT_DRIVE_LETTER:\=\\%:\\Project+\RSBE01.txt"
"%SD_CARD_MOUNT_DRIVE_LETTER:\=\\%:\\Project+\GCTRealMate.exe" -q "%SD_CARD_MOUNT_DRIVE_LETTER:\=\\%:\\Project+\BOOST.txt"
"%SD_CARD_MOUNT_DRIVE_LETTER:\=\\%:\\Project+\GCTRealMate.exe" -q "%SD_CARD_MOUNT_DRIVE_LETTER:\=\\%:\\Project+\NETPLAY.txt"
"%SD_CARD_MOUNT_DRIVE_LETTER:\=\\%:\\Project+\GCTRealMate.exe" -q "%SD_CARD_MOUNT_DRIVE_LETTER:\=\\%:\\Project+\NETBOOST.txt"

fsutil file createnew "%SD_CARD_MOUNT_DRIVE_LETTER:\=\\%:\\DON'T PUT THIS BUILD ON A WII.txt" 0

::timeout /t %MIN_EXEC_TIME% /nobreak > NUL

call unmount.bat || goto error

powershell.exe .\CleanNetplayFiles.ps1

goto :eof

:error
color 0c
pause > NUL 2> NUL
color
goto :eof