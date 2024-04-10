@REM 问题追溯
@REM https://answers.microsoft.com/zh-hans/windows/forum/all/%E4%BD%A0%E5%A5%BD-%E8%AF%B7%E9%97%AE/c65a02d7-3e09-4c53-9761-b59ecbea3513
@REM 删除注册表项
@REM reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v ProtonVPN /f

@echo off

:loop
@REM echo 输入要删除的注册表值名称，或输入 'exit' 退出:
set /p reg_value=  输入要删除的注册表值名称，或输入 'exit' 退出:

if not "%reg_value%"=="" (
    if "%reg_value%"=="exit" (
        goto :end
    ) else (
        reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "%reg_value%" /f
    )
) else (
    echo 未输入任何值名称。
)

goto :loop

:end
echo 脚本已退出。