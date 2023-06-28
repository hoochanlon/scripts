@echo off
cls

REM Start-Process -FilePath "1.bat" -Wait
REM cmd /c 1.bat

rem ¶¨ÒåANSI×ªÒåÐòÁÐÒÔ¸ü¸ÄÎÄ±¾ÑÕÉ«
set "red=[1;31m"
set "green=[1;32m"
set "yellow=[1;33m"
set "reset=[0m"

echo %green%CÅÌÃð°Ô½Å±¾¹¦ÄÜËµÃ÷£º%reset%
echo/
echo %red%×¢£º¸Ã½Å±¾ÊÊºÏÖÐÐ¡Î¢ÆóÒµÓÃ»§£¬ÒÔ¼°×ÀÃæ¹¤³ÌÊ¦Ê¹ÓÃ¡£%reset%
echo/
echo %yellow%1. Çå¿ÕÎ¢ÐÅ¡¢¶¤¶¤¡¢Foxmail±¾µØÕË»§»º´æÎÄ¼þ%reset%
echo %yellow%2. ½øÐÐ²¿·Ö³£¹æ´ÅÅÌÇåÀí£ºWindows.old¡¢Windows¸üÐÂÎÄ¼þ¡¢Éý¼¶ÈÕÖ¾µÈÎÄ¼þ%reset%
echo %yellow%3. ±éÀúÉ¾³ýÎ´ÓÐ³ÌÐòÕ¼ÓÃµÄÁÙÊ±ÎÄ¼þ£¬²¢ÊÍ·ÅÐÝÃßÎÄ¼þ%reset%
echo/
echo %red%×¢£ºÎ¢ÐÅ¡¢¶¤¶¤¡¢FoxmailÉ¾³ýµÄÖ»ÊÇ±¾µØ¼ÇÂ¼£¬ËùÓÐ¼ÇÂ¼¿É´Ó·þÎñÆ÷ÔÆ¶ËÖØÐÂÕÒ»Ø¡£²¢ÔÚÊ¹ÓÃÊ±£¬ÇëÏÈÍË³öÎ¢ÐÅ¡¢¶¤¶¤¡¢foxmail¡£%reset%

echo/
echo °´ÈÎÒâ¼ü¼ÌÐøÖ´ÐÐ½Å±¾...
pause > nul

setlocal enabledelayedexpansion
set "folder=%userprofile%\AppData\Local"
set "tempFile=C:\path\to\tempfile.txt"


echo ÕýÔÚÉ¾³ýÎ¢ÐÅ»º´æÎÄ¼þ...
taskkill /F /IM "wechat*" /T  2> $null
del /q /f /s "%userprofile%\Documents\WeChat Files\"* 2>nul

echo ÕýÔÚÉ¾³ý°üº¬ "DingTalk" µÄÎÄ¼þ¼Ð¼°ÆäÄÚÈÝ...
taskkill /F /IM "DingTalk*" /T  2> $null
for /d %%a in ("%folder%\*DingTalk*") do (
    echo ÕýÔÚÉ¾³ý %%a...
    rd /s /q "%%a" 2>nul
)

del /q /f /s %AppData%\DingTalk\* 2>nul


rem ------------------foxmail ¿É¸ù¾Ý×Ô¼ºµÄÆóÒµ»·¾³£¬×ÔÐÐµ÷Õû»òÉ¾³ý---------------------

rem ²âÊÔÉ¾³ýÐ§¹û£¬OK£¬±£Áô¡£ÈôÓÐ¶à¸öÅÌ·ûÄ¬ÈÏÄ¿Â¼ÊÇ£ºD:\Program Files\Foxmail 7.2\Storage
set "targetFolder=C:\Foxmail 7.2\Storage"

if exist "%targetFolder%" (
    echo %yellow%¼ì²âµ½ %targetFolder% Ä¿Â¼´æÔÚ¡£%reset%
    taskkill /F /IM "foxmail*" /T  2> $null
    rd /s /q "%targetFolder%\"
    echo %green%ÎÄ¼þÉ¾³ý³É¹¦£¡%reset%
    mkdir "%targetFolder%"
) else (
    echo %targetFolder% Ä¿Â¼²»´æÔÚ¡£
)

set "targetFolder=C:\Program Files\Foxmail 7.2\Storage"

if exist "%targetFolder%" (
    echo %yellow%¼ì²âµ½ %targetFolder% Ä¿Â¼´æÔÚ¡£%reset%
    taskkill /F /IM "foxmail*" /T  2> $null
    rd /s /q "%targetFolder%\"
    echo %green%ÎÄ¼þÉ¾³ý³É¹¦£¡%reset%
    mkdir "%targetFolder%"
) else (
    echo %targetFolder% Ä¿Â¼²»´æÔÚ¡£
)

rem ------------------foxmail ¿É¸ù¾Ý×Ô¼ºµÄÆóÒµ»·¾³£¬×ÔÐÐµ÷Õû»òÉ¾³ý---------------------


echo ÇåÀí Windows.old ...
rd/s/q C:\windows.old 2>nul

echo ÇåÀí Windows ¸üÐÂÎÄ¼þ...
if exist "%tempFile%" del /q "%tempFile%"
copy nul "%tempFile%"

del /q C:\Windows\SoftwareDistribution\Download\*.* 2>nul
rd /s /q C:\Windows\SoftwareDistribution\Download\ 2>nul

echo ÇåÀí Windows Éý¼¶ÈÕÖ¾ÎÄ¼þ...
taskkill /f /im TrustedInstaller.exe >nul 2>&1
del /q C:\Windows\Logs\CBS\*.* 2>nul
rd /s /q C:\Windows\Logs\CBS\ 2>nul

echo ÇåÀí Internet ÁÙÊ±ÎÄ¼þ...
del /q /f /s "%USERPROFILE%\AppData\Local\Temp\*.*" 2>nul
del /q /f /s "%LOCALAPPDATA%\Temp\*.*" 2>nul

echo ÇåÀíÁÙÊ±ÎÄ¼þ...
del /q /f /s "%TEMP%\*.*" 2>nul

echo ÕýÔÚÊÍ·ÅÐÝÃßÎÄ¼þ
powercfg -h off

set "downloadPath=%userprofile%\Downloads"

echo %red%ÊÇ·ñÒªÉ¾³ýÏÂÔØÄ¿Â¼ÀïµÄËùÓÐÎÄ¼þ£¿(Y/N)%reset%
set /p choice=

if /i "%choice%"=="Y" (
    echo ÕýÔÚÉ¾³ýÏÂÔØÎÄ¼þ...
    for /d %%i in ("%downloadPath%\*") do (
        rd /s /q "%%i"
    )
    del /q "%downloadPath%\*.*"
    echo ÏÂÔØÎÄ¼þÒÑÉ¾³ý¡£
) else (
    echo ÏÂÔØÎÄ¼þÎ´É¾³ý¡£
)

echo Çå¿Õ»ØÊÕÕ¾...
%SystemRoot%\System32\cmd.exe /c "echo Y|PowerShell.exe -NoProfile -Command Clear-RecycleBin"

echo ÇåÀíÍê³É¡£

echo.
echo °´ÈÎÒâ¼ü¼ÌÐø...
pause > nul
