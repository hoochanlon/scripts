@echo off

set "regPath=HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run"

@REM 将路径添加到注册表中的 LastKey 值
@REM LastKey 是其中的一个值，用于存储上次在注册表编辑器中访问的注册表路径。
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /v LastKey /t REG_SZ /d "%regPath%" /f

REM 提示用户是否打开注册表 （archon1 的建议）
choice /c YN /m "是否打开注册表（高级）定位到相关项"
if errorlevel 2 (
    echo 用户选择不打开注册表编辑器。
) else (
    start regedit
)

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


@REM 脚本过程
@REM 问题追溯
@REM https://answers.microsoft.com/zh-hans/windows/forum/all/%E4%BD%A0%E5%A5%BD-%E8%AF%B7%E9%97%AE/c65a02d7-3e09-4c53-9761-b59ecbea3513
@REM 参考项：定位注册表、网页编码
@REM https://blog.csdn.net/admans/article/details/122682970
@REM https://blog.csdn.net/lanlangaogao/article/details/122535848