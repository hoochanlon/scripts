@echo off
setlocal

set /p "targetPath=请输入要操作的目录或程序:"

@REM 去除输入路径两边可能存在的引号
set "targetPath=%targetPath:"=%"

@REM 判断路径是否存在
if not exist "%targetPath%" (
    echo 指定的路径不存在，已退出。
    exit /b
)

@REM 获取路径的目录部分和文件名部分
for %%F in ("%targetPath%") do (
    set "actualPath=%%~dpF"
    set "fileName=%%~nxF"
)

@REM 构建实际要操作的路径
set "actualPath=%actualPath%%fileName%"

echo --- 开始检测路径程序进程，并关闭。----
@REM 终止给定的进程
taskkill /F /FI "IMAGENAME eq %fileName%" 2>nul

@REM 如果是目录，终止目录及其子目录中所有的 .exe 进程
if exist "%actualPath%\." (
    for /r "%actualPath%" %%A in (*.exe) do (
        taskkill /F /FI "IMAGENAME eq %%~nxA" 2>nul
    )
)
echo/
echo --- 开始检测压缩软件占用情况，并关闭。----
@REM 特殊关照：winRAR、7z、360压缩、2345好压、快压

@REM winrar
if exist "%ProgramFiles%\WinRAR\." (
    for /r "%ProgramFiles%\WinRAR" %%A in (*.exe) do (
        taskkill /F /FI "IMAGENAME eq %%~nxA" 2>nul
    )
)

@REM 7z
if exist "%ProgramFiles%\7-Zip\." (
    for /r "%ProgramFiles%\7-Zip\." %%A in (*.exe) do (
        taskkill /F /FI "IMAGENAME eq %%~nxA" 2>nul
    )
)


@REM  360压缩
if exist "%ProgramFiles(x86)%\360\360zip\." (
    for /r "%ProgramFiles(x86)%\360\360zip" %%A in (*.exe) do (
        taskkill /F /FI "IMAGENAME eq %%~nxA" 2>nul
    )
)

@REM 2345 好压
if exist "%ProgramFiles%\2345Soft\HaoZip\." (
    for /r "%ProgramFiles%\2345Soft\HaoZip" %%A in (*.exe) do (
        taskkill /F /FI "IMAGENAME eq %%~nxA" 2>nul
    )
)

@REM 快压
if exist "%appdata%\快压\." (
    for /r "%appdata%\快压" %%A in (*.exe) do (
        taskkill /F /FI "IMAGENAME eq %%~nxA" 2>nul
    )
)
echo ----------------结束 ---------------------
echo/

REM 提示用户选择是否删除文件夹及其所有内容
set /p deleteOption=是否删除 %actualPath% ？(Y/N)
if /I "%deleteOption%"=="Y" (
    rd /S /Q "%actualPath%" 2>nul
    del /F /Q "%actualPath%" 2>nul
    echo 删除操作执行完成。
) else (
    if /I "%deleteOption%"=="N" (
        echo 已撤销删除操作。
    ) else (
        echo 无效的输入，已退出。
    )
)

endlocal
pause
