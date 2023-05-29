:: 提前注释保留项

:: https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsUpdate::AutoUpdateCfg&Language=zh-cn
@REM https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-update#update-enableautomaticupgrades
@REM https://www.howtogeek.com/799392/what-is-waasmedic-agent-exe-how-to-fix-high-disk-usage/
@REM https://www.majorgeeks.com/content/page/what_is_the_update_orchestrator_service.html
@REM https://answers.microsoft.com/en-us/windows/forum/all/windows-7-8-81-registry-edits-to-prevent-windows/4cbd4842-d11f-4579-a8de-18576aad2597
@REM https://greatis.com/stopupdates10/

@REM 暂停更新3000
@REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v FlightSettingsMaxPauseDays /t reg_dword /d 3000 /f

@REM 此计算机的目标组名称 
@REM reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetGroup" /t REG_SZ /d "YourTargetGroup" /f

@REM 该服务使用这些信息来确定在此计算机上应该部署哪些更新。Enabled Value 0 = Disabled, 1 = Enabled
@REM reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetGroupEnabled" /t REG_DWORD /d "0x0" /f

:: -------指定 Intranet Microsoft 更新服务位置--------
@REM 此设置允许你在网络上指定一台服务器执行内部更新服务。自动更新客户端将搜索此服务，找到适用于网络上计算机的更新。
@REM Value 0 = Disabled, 1 = Enabled
@REM reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer" /t REG_DWORD /d "0x1" /f
@REM 指定 Intranet Microsoft 网址
@REM reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer" /t REG_SZ /d "http://127.0.0.1" /f
@REM 设置 Intranet 统计服务器
@REM reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer" /t REG_SZ /d "http://127.0.0.1" /f
:: -------------------------------------------------

@REM 该服务主要用于检查 Windows 更新的健康状况，以确保系统能够及时接收到最新的安全和功能更新。，并将其值设置为 4 (禁止运行该服务)。
@REM REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaasMedic" /v "Start" /t REG_DWORD /d 4 /f

:: 提前注释保留项


:: 彻底关闭Windows更新

@REM 临时停止 Windows Update 服务
net stop wuauserv

@REM 暂停升级 enabled Value 0 = Disabled, 1 = Enabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "PauseDeferrals" /t REG_DWORD /d "0x1" /f

@REM 允许非管理员接收更新通知 Enabled Value 0 = Disabled, 1 = Enabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ElevateNonAdmins" /t REG_DWORD /d "0x1" /f

@REM 此设置允许你在网络上指定一台服务器执行内部更新服务。自动更新客户端将搜索此服务，找到适用于网络上计算机的更新。
@REM Value 0 = Disabled, 1 = Enabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer" /t REG_DWORD /d "0x1" /f

@REM 指定 Intranet Microsoft 网址
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer" /t REG_SZ /d "http://127.0.0.1" /f
@REM 设置 Intranet 统计服务器
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer" /t REG_SZ /d "http://127.0.0.1" /f

@REM 如果启用此策略设置，则会阻止用户连接到 Windows 更新网站。 Value 1 =  Enabled, 0 = Disabled
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoWindowsUpdate" /t REG_DWORD /d "0x1" /f

@REM 配置自动更新  Value 1= Disabled, 0 = Enabled 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d "0x1" /f

@REM 允许自动更新立即安装  Value 1 = Enabled，0 = Disabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AutoInstallMinorUpdates" /t REG_DWORD /d "0x1" /f

@REM 自动更新频率 Value 0 = Disabled, 1 = Enabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "DetectionFrequencyEnabled" /t REG_DWORD /d "0x0" /f

@REM 重新计划自动更新计划的安装 Value 1 = Enabled，0 = Disabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "RescheduleWaitTimeEnabled" /t REG_DWORD /d "0x0" /f

@REM 删除使用所有 Windows 更新功能的访问权限 Value 1 = Enabled，0 = Disabled
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d "0x1" /f

@REM 关闭对所有 Windows 更新功能的访问 Value 1 = Enabled，0 = Disabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "RescheduleWaitTimeEnabled" /t REG_DWORD /d "0x1" /f

@REM 阻止运行 Windows Anytime Upgrade（Windows版本升级）  Value 1 = Enabled，0 = Disabled
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\WAU" /v "Disabled" /t REG_DWORD /d "0x1" /f

@REM 允许或禁止 Microsoft Store 向最新版本的 Windows 提供更新。 Value 1 = Enabled, 0 = Disabled
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /t REG_DWORD /d 1 /f

@REM ------ Windows更新健康医生服务与更新编排器服务
@REM  "Start" 值包括 0（启动失败）、1（系统启动时自动启动）、2（手动启动）和 3（禁用），而 4 表示服务不会被启动，如果服务已经在运行，则会被停止。
@REM 该服务主要用于检查 Windows 更新的健康状况，以确保系统能够及时接收到最新的安全和功能更新。，并将其值设置为 4 (禁止运行该服务)。
@REM 更新编排器服务，关闭
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d 4 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d 4 /f
@REM ------ Windows更新健康医生服务与更新编排器服务

@REM ---- win7 升级提示通杀
@REM 关闭《获取Windows10》升级通知 https://www.jb51.net/os/windows/418707.html
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v "ReservationsAllowed" /t REG_DWORD /d 0 /f
@REM https://serverfault.com/questions/695916/registry-key-gpo-to-disable-and-block-windows-10-upgrade
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Gwx" /v "DisableGwx" /t REG_DWORD /d 1 /f
@REM Windows 7禁用“ PC不支持”弹出窗口 https://blog.csdn.net/allway2/article/details/103905502
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\EOSNotify" /v "DiscontinueEOS" /t REG_DWORD /d 1 /f
@REM ---- win7 升级提示通杀

@REM 启动 Windows Update 服务
net start wuauserv

:: 彻底关闭Windows更新

pause