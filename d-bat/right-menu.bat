@echo off
echo 请选择要执行的操作：
echo 1. 回归Win10经典右键菜单
echo 2. 恢复Win11及往后版本的右键菜单
echo 3. 退出

choice /c 123 /n /m "请按选项："

goto option_%errorlevel%

rem 选项处理
:option_1
rem 回归win10经典右键菜单
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
tskill explorer
echo Win10经典右键菜单已回归。
goto end

:option_2
rem 恢复win11及往后版本的右键菜单
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /va /f
rem 重启资源管理/刷新
tskill explorer
echo Win11及往后版本的右键菜单已恢复。
goto end

:option_3
echo 退出程序。
exit

:end
pause


@REM 参考连接：

@REM * https://zhuanlan.zhihu.com/p/550043382
@REM * https://answers.microsoft.com/en-us/windows/forum/all/windows-11-restore-classic-context-menu/dd8fa553-7747-4071-be58-9a8b6902a7b6
@REM * https://answers.microsoft.com/en-us/windows/forum/all/restore-old-right-click-context-menu-in-windows-11/a62e797c-eaf3-411b-aeec-e460e6e5a82a
@REM * https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/reg-add
