@echo off
@%1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
@cd /d "%~dp0"

@echo off
setlocal EnableDelayedExpansion

REM 获取批处理脚本所在文件夹的路径
set "script_dir=%~dp0"

REM 拼接文件路径
set "my_chrome_file_path=%script_dir%ChromeSetup_v65.exe"

REM 判断文件是否存在
if exist "%my_chrome_file_path%" (
    echo ChromeSetup_v65.exe文件已存在
) else (
    echo ChromeSetup_v65.exe文件不存在
    exit /b
)

REM 设置要安装的 Chrome 版本
set "CHROME_VERSION=65.0.3325.52"

REM 检查是否已安装 Chrome
reg query "HKEY_CURRENT_USER\Software\Google\Chrome\BLBeacon" >nul 2>&1
if %errorlevel% neq 0 (
    echo Chrome 未安装在此计算机上。

    REM 安装目标版本的 Chrome
    echo 安装 Chrome 版本 %CHROME_VERSION%...
    start /wait "" "%my_chrome_file_path%"

) else (

    REM 获取当前安装的 Chrome 版本号
    for /f "tokens=3" %%i in ('reg query "HKEY_CURRENT_USER\Software\Google\Chrome\BLBeacon" /v version') do (
        set "CURRENT_VERSION=%%i"
    )

    REM 检查当前版本是否为目标版本
    if not "!CURRENT_VERSION!" equ "%CHROME_VERSION%" (

        REM 卸载当前版本的 Chrome
        echo 卸载当前 Chrome 版本 !CURRENT_VERSION!...
        start /wait "" "C:\Program Files (x86)\Google\Chrome\Application\!CURRENT_VERSION!\Installer\setup.exe" -uninstall -system-level

        REM 安装目标版本的 Chrome
        echo 安装 Chrome 版本 %CHROME_VERSION%...
        start /wait "" "%my_chrome_file_path%"
    ) else (
        echo 当前 Chrome 已经是目标版本 %CHROME_VERSION%。不需要更新。
    )
)

echo 正在设置文件夹权限，禁用 Chrome 升级，请稍等...

:: 检查 chrome update 文件夹是否存在，不存在则创建
IF NOT EXIST "%userprofile%\AppData\Local\Google\Update" (
    mkdir "%userprofile%\AppData\Local\Google\Update"
)

@REM 对文件授予Everyone组完全控制权限
@REM icacls "C:\Windows\System32\usosvc.dll" /grant "Everyone":F

:: 对文件夹拒绝指定用户或组的访问权限 (OI)(CI) 表示要应用到对象和子对象的权限，(RX) 表示拒绝读取和执行权限。
icacls "%userprofile%\AppData\Local\Google\Update" /deny "Everyone":(OI)(CI)RX

:: 检查操作是否成功
if %errorlevel% neq 0 (
    echo 设置文件夹权限失败。
) else (
    echo 设置文件夹权限成功。
)

endlocal
pause
