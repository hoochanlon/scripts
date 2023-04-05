:: "自动提权"
@echo off

:: ---------- 本地运行可打开特权提升 ---------------
@REM %1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
@REM cd /d "%~dp0"
:: ---------- 本地运行可打开特权提升 ---------------


echo "win10正常使用就好，win11系统需先用小鱼儿IE修复工具，进行恢复IE11图标，再使用该工具防劫持。"

@echo off
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "Enable Browser Extensions" /t REG_SZ /d "NO" /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "UpsellDisabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "RedirectionMode" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "QuietExpirationTime" /t REG_QWORD /d 0 /f

echo -----------------------------------------------------------------------------
echo "防Edge劫持IE浏览器，已处理完成！"

pause
del %0