@REM  "win10正常使用就好，win11系统需先用小鱼儿IE修复工具，进行恢复IE11图标，再使用该工具防劫持。"

@echo off
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "Enable Browser Extensions" /t REG_SZ /d "NO" /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "UpsellDisabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "RedirectionMode" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "QuietExpirationTime" /t REG_QWORD /d 0 /f

@REM  -----------------------------------------------------------------------------
@REM "防Edge劫持IE浏览器，已处理完成！"

pause
del %0