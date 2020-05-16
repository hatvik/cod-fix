:: Rename the files "ModernWarfare.exe" and "Modern Warfare Launcher.exe" to prevent crashes
@ECHO off
:: Change your install path here
:: set INSTALL_LOCATION=C:\Program Files (x86)\Call of Duty Modern Warfare
set INSTALL_LOCATION=D:\Call of Duty Modern Warfare
:: Leave the rest alone
set PROCNAME="ModernWarfare.exe"
set PROCNAME2=""Modern Warfare Launcher.exe""
 
:: Test that install location is correct.
if exist "%INSTALL_LOCATION%\Modern Warfare Launcher.exe" (
    rem file exists
) else (
    echo Cant find "%INSTALL_LOCATION%\Modern Warfare Launcher.exe"
	echo Did you update INSTALL_LOCATION in the script? 
	echo Verify that "%INSTALL_LOCATION%" is correct. Exiting ...
	pause
	exit 1
)

 
    :initialbattlenet
CHOICE /M "Start Battle.Net Client?"
if "%ERRORLEVEL%" == "1" GOTO startbattlenet
if "%ERRORLEVEL%" == "2" GOTO initialbattlenet
goto exitscript
 
    :startbattlenet
Echo Start Battle.net...
"%INSTALL_LOCATION%\Modern Warfare Launcher.exe"
@ping -n 5 localhost> nul
cls
:checkstart
TaskList|Find "Blizzard Battle.net App" >NUL || If Errorlevel 1 Goto startgame
Goto checkstart
 
 
    :startgame
echo Start cod and wait while I check game status...
tasklist /FI "IMAGENAME eq %PROCNAME%*" 2>NUL | find /I /N %PROCNAME%>NUL
if "%ERRORLEVEL%"=="0" (
    Goto gameruns
)
cls
Goto startgame
 
 
    :exitgame
CHOICE /M "Once you are done playing, type y here. Did you stop playing?"
if "%ERRORLEVEL%" == "1" GOTO gamequits
if "%ERRORLEVEL%" == "2" GOTO exitgame
@PAUSE
 
    :gameruns
@ping -n 5 localhost> nul
ren "%INSTALL_LOCATION%\%PROCNAME%" %PROCNAME%1 >nul
ren "%INSTALL_LOCATION%\%PROCNAME2%" "%PROCNAME2%1" >nul
if exist "%INSTALL_LOCATION%\%PROCNAME%1" goto startrenameok
echo Oops, something went wrong. Let's try it again
@pause
goto startgame
 
    :startrenameok
cls
ECHO Files renamed successfully!
ECHO Have fun playing
@ping -n 5 localhost> nul
cls
GOTO exitgame
 
    :gamequits
ren "%INSTALL_LOCATION%\%PROCNAME%1" %PROCNAME% >nul
ren "%INSTALL_LOCATION%\%PROCNAME2%1" "%PROCNAME2%" >nul
if exist "%INSTALL_LOCATION%\%PROCNAME%" goto quitrenameok
echo Oops, something went wrong. Let's try it again
goto startgame
 
    :quitrenameok
cls
ECHO Files renamed successfully!
ECHO I hope it was fun.
GOTO exitscript
 
    :exitscript
echo.
echo Script will be terminated...
@ping -n 3 localhost> nul
exit
