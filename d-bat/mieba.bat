@echo off
cls

REM Start-Process -FilePath "1.bat" -Wait
REM cmd /c 1.bat

rem 定义ANSI转义序列以更改文本颜色
set "red=[1;31m"
set "green=[1;32m"
set "yellow=[1;33m"
set "reset=[0m"

echo %green%C盘灭霸脚本功能说明：%reset%
echo/
echo %red%注：该脚本适合中小微企业用户，以及桌面工程师使用。%reset%
echo/
echo %yellow%1. 清空微信、钉钉、Foxmail本地账户缓存文件%reset%
echo %yellow%2. 进行部分常规磁盘清理：Windows.old、Windows更新文件、升级日志等文件%reset%
echo %yellow%3. 遍历删除未有程序占用的临时文件，并释放休眠文件%reset%
echo/
echo %red%注：微信、钉钉、Foxmail删除的只是本地记录，所有记录可从服务器云端重新找回。并在使用时，请先退出微信、钉钉、foxmail。%reset%

echo/
echo 按任意键继续执行脚本...
pause > nul

setlocal enabledelayedexpansion
set "folder=%userprofile%\AppData\Local"
set "tempFile=C:\path\to\tempfile.txt"


echo 正在删除微信缓存文件...
taskkill /F /IM "wechat*" /T  2> $null
del /q /f /s "%userprofile%\Documents\WeChat Files\"* 2>nul

echo 正在删除包含 "DingTalk" 的文件夹及其内容...
taskkill /F /IM "DingTalk*" /T  2> $null
for /d %%a in ("%folder%\*DingTalk*") do (
    echo 正在删除 %%a...
    rd /s /q "%%a" 2>nul
)

del /q /f /s %AppData%\DingTalk\* 2>nul


rem ------------------foxmail 可根据自己的企业环境，自行调整或删除---------------------

rem 测试删除效果，OK，保留。若有多个盘符默认目录是：D:\Program Files\Foxmail 7.2\Storage
set "targetFolder=C:\Foxmail 7.2\Storage"

if exist "%targetFolder%" (
    echo %yellow%检测到 %targetFolder% 目录存在。%reset%
    taskkill /F /IM "foxmail*" /T  2> $null
    rd /s /q "%targetFolder%\"
    echo %green%文件删除成功！%reset%
    mkdir "%targetFolder%"
) else (
    echo %targetFolder% 目录不存在。
)

set "targetFolder=C:\Program Files\Foxmail 7.2\Storage"

if exist "%targetFolder%" (
    echo %yellow%检测到 %targetFolder% 目录存在。%reset%
    taskkill /F /IM "foxmail*" /T  2> $null
    rd /s /q "%targetFolder%\"
    echo %green%文件删除成功！%reset%
    mkdir "%targetFolder%"
) else (
    echo %targetFolder% 目录不存在。
)

rem ------------------foxmail 可根据自己的企业环境，自行调整或删除---------------------


echo 清理 Windows.old ...
rd/s/q C:\windows.old 2>nul

echo 清理 Windows 更新文件...
if exist "%tempFile%" del /q "%tempFile%"
copy nul "%tempFile%"

del /q C:\Windows\SoftwareDistribution\Download\*.* 2>nul
rd /s /q C:\Windows\SoftwareDistribution\Download\ 2>nul

echo 清理 Windows 升级日志文件...
taskkill /f /im TrustedInstaller.exe >nul 2>&1
del /q C:\Windows\Logs\CBS\*.* 2>nul
rd /s /q C:\Windows\Logs\CBS\ 2>nul

echo 清理 Internet 临时文件...
del /q /f /s "%USERPROFILE%\AppData\Local\Temp\*.*" 2>nul
del /q /f /s "%LOCALAPPDATA%\Temp\*.*" 2>nul

echo 清理临时文件...
del /q /f /s "%TEMP%\*.*" 2>nul

echo 正在释放休眠文件
powercfg -h off

set "downloadPath=%userprofile%\Downloads"

echo %red%是否要删除下载目录里的所有文件？(Y/N)%reset%
set /p choice=

if /i "%choice%"=="Y" (
    echo 正在删除下载文件...
    for /d %%i in ("%downloadPath%\*") do (
        rd /s /q "%%i"
    )
    del /q "%downloadPath%\*.*"
    echo 下载文件已删除。
) else (
    echo 下载文件未删除。
)

echo 清空回收站...
%SystemRoot%\System32\cmd.exe /c "echo Y|PowerShell.exe -NoProfile -Command Clear-RecycleBin"

echo 清理完成。

echo.
echo 按任意键继续...
pause > nul
