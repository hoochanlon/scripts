@echo off
@%1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
@cd /d "%~dp0"

@echo off
@setlocal enabledelayedexpansion

:: 检查chrome update文件夹是否存在，不存在则创建
IF NOT EXIST "%userprofile%\AppData\Local\Google\Update" (
    mkdir "%userprofile%\AppData\Local\Google\Update"
)

@REM 对文件授予Everyone组完全控制权限
@REM icacls "C:\Windows\System32\usosvc.dll" /grant "Everyone":F

:: 对文件夹拒绝指定用户或组的访问权限
::(OI)(CI) 表示要应用到对象和子对象的权限， (RX) 表示拒绝读取和执行权限。
icacls "%userprofile%\AppData\Local\Google\Update" /deny "Everyone":(OI)(CI)RX


:: 检查操作是否成功
if %errorlevel% neq 0 (
    echo 设置文件夹权限失败。
) else (
    echo 设置文件夹权限成功。
)

pause
