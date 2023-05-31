@echo off
:: 见：https://bbs.huaweicloud.com/blogs/396537
:: "C:\Program Files (x86)\NSudo_8.2_All_Components\NSudo Launcher\x64\NSudoLG.exe" -U:T cmd /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features" /v "TamperProtection" /d 0 /t REG_DWORD /f""

:: 自动管理员权限运行以下代码
%1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit & cd /d "%~dp0"

:: color 9

cls
echo 请选择操作：
echo/
echo [1] 禁用实时防护
echo [2] 启用实时防护
echo/
choice /c 12 /n /m "请输入选项（1或2）："
echo/
if errorlevel 2 (
    REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /f 2>nul 1>nul
    echo 启用实时防护，OK！
    echo/
    ) else (
        REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f 1>nul
        echo 禁用实时防护，已OK！
        echo 在Windows defender点击关闭“篡改防护”即可关闭永久性关闭实时保护。
        echo 也可在需要时，自行手动开启“篡改防护”以长期打开实时保护功能。
        echo/
    )
pause
