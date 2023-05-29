# 关闭Windows更新的批处理

## 缘起

做这个呢，一是看了[晨钟酱 -【更新能永久暂停？盘点两个奇特的Windows使用技巧】 ](https://www.bilibili.com/video/BV1FM4y1i76d)视频启发，二是知乎上获取到一些信息来源[知乎-如何关闭win10的自动更新？](https://www.zhihu.com/question/65332770/answer/2369884038)，三是同事分享的重定向更新服务器信息，以及“云烟成雨”分享贴：[禁止win10更新：StopUpdates10_4.0.2023.306](
https://www.52pojie.cn/thread-1777560-1-1.html)。我整体分析这些收集来的信息资源，做这个长久令人困扰的“关闭/开启Windows更新”是可行的。

看了B站与知乎这两则讯息发帖及评论的大致详情，结合我之前有过编写IE安全性规则的经验上来看，要想稳定长久关闭Windows更新，仅用一条注册表，应对之后微软做出的相关调整，这显然不大充分。以及基于企业环境的原因，自己基本上尽量少用激活工具，以及其他不透明的工具，故为此自己就动手做了批处理关闭Windows更新的。

先列出主要的参考资料：

* 起先：[晨钟酱 -【更新能永久暂停？盘点两个奇特的Windows使用技巧】 ](https://www.bilibili.com/video/BV1FM4y1i76d)、[知乎-如何关闭win10的自动更新？](https://www.zhihu.com/question/65332770/answer/2369884038)、[云烟成雨 - 禁止win10更新：StopUpdates10_4.0.2023.306](
  https://www.52pojie.cn/thread-1777560-1-1.html)
* 核心：
  * [admx.help - 配置自动更新](https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsUpdate::AutoUpdateCfg&Language=zh-cn)（常规条目）
  * https://greatis.com/stopupdates10 （常规条目所没提到的词眼：USOClient，"WAAS Medic"）
    * https://www.howtogeek.com/799392/what-is-waasmedic-agent-exe-how-to-fix-high-disk-usage
    * https://www.majorgeeks.com/content/page/what_is_the_update_orchestrator_service.html
    * https://serverfault.com/questions/695916/registry-key-gpo-to-disable-and-block-windows-10-upgrade
* 增强：[脚本之家 - 屏蔽Win7/Win8.1升级Win10推送的三种图文方法](https://www.jb51.net/os/windows/418707.html)、[csdn-Windows 7禁用“ PC不支持”弹出窗口](https://blog.csdn.net/allway2/article/details/103905502)

## 实测效果与源码

### stop_update.bat（停止更新）

16:26，运行stop_update.bat前。

![image-20230529214310695](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/image-20230529214310695.png)

16:28，运行stop_update.bat后，出现“某些设置由你的组织来管理”红字，以及红色星号标识“你的组织已关闭更新”。

![image-20230529214449518](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/image-20230529214449518.png)

此状态下重启后是能完成最后一波更新的，因电脑性能，更新用了10分钟不等，中途走开了一会。

![image-20230529215126561](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/image-20230529215126561.png)

整体效果是令人满意的。

**stop_update.bat** 附源码：https://github.com/hoochanlon/ihs-simple/blob/main/d-bat/stop_update.bat

```cmd
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
@REM 该服务主要用于检查 Windows 更新的健康状况，以确保系统能够及时接收到最新的安全和功能更新，并将其值设置为 4 (禁止运行该服务)。
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
```

### re_update.bat （恢复更新）

re_update.bat 恢复更新启动

![image-20230529215758840](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/image-20230529215758840.png)

重启电脑后效果

![image-20230529215947512](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/image-20230529215947512.png)

**re_update.bat** 附源码：https://github.com/hoochanlon/ihs-simple/blob/main/d-bat/re_update.bat

```cmd
:: 提前注释保留项
:: https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsUpdate::AutoUpdateCfg&Language=zh-cn
@REM https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-update#update-enableautomaticupgrades
@REM https://www.howtogeek.com/799392/what-is-waasmedic-agent-exe-how-to-fix-high-disk-usage/
@REM https://www.majorgeeks.com/content/page/what_is_the_update_orchestrator_service.html
@REM https://answers.microsoft.com/en-us/windows/forum/all/windows-7-8-81-registry-edits-to-prevent-windows/4cbd4842-d11f-4579-a8de-18576aad2597
@REM https://greatis.com/stopupdates10/
@REM 暂停更新3000
@REM reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v FlightSettingsMaxPauseDays /f
@REM 此计算机的目标组名称 
@REM reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetGroup" /f
@REM 该服务使用这些信息来确定在此计算机上应该部署哪些更新。Enabled Value 0 = Disabled, 1 = Enabled
@REM reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetGroupEnabled" /f
:: -------指定 Intranet Microsoft 更新服务位置--------
@REM 此设置允许你在网络上指定一台服务器执行内部更新服务。自动更新客户端将搜索此服务，找到适用于网络上计算机的更新。
@REM Value 0 = Disabled, 1 = Enabled
@REM reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer"  /f
@REM 指定 Intranet Microsoft 网址
@REM reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer"  /f
@REM 设置 Intranet 统计服务器
@REM reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer"  /f
:: -------------------------------------------------
@REM 该服务主要用于检查 Windows 更新的健康状况，以确保系统能够及时接收到最新的安全和功能更新。，并将其值设置为 4 (禁止运行该服务)。
@REM REG delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaasMedic" /v "Start" /f
:: 提前注释保留项
:: 彻底关闭Windows更新
@REM 临时停止 Windows Update 服务
net stop wuauserv
@REM ------ Windows更新健康医生服务与更新编排器服务 -------------
@REM  "Start" 值包括 0（启动失败）、1（系统启动时自动启动）、2（手动启动）和 3（禁用），而 4 表示服务不会被启动，如果服务已经在运行，则会被停止。
@REM 该服务主要用于检查 Windows 更新的健康状况，以确保系统能够及时接收到最新的安全和功能更新。，并将其值设置为 4 (禁止运行该服务)。
@REM 更新编排器服务，关闭
REG delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start"  /f
REG delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start"  /f
@REM https://superuser.com/questions/1584410/windows-10-update-something-went-wrong-try-to-reopen-settings-later
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d 2 /f
@REM ------ Windows更新健康医生服务与更新编排器服务 -------------
@REM ---- win7 升级提示通杀 --------
@REM 关闭《获取Windows10》升级通知 https://www.jb51.net/os/windows/418707.html
REG delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v "ReservationsAllowed" /f
@REM https://serverfault.com/questions/695916/registry-key-gpo-to-disable-and-block-windows-10-upgrade
REG delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Gwx" /v "DisableGwx"  /f
@REM Windows 7禁用“ PC不支持”弹出窗口 https://blog.csdn.net/allway2/article/details/103905502
REG delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\EOSNotify" /v "DiscontinueEOS" /f
@REM ---- win7 升级提示通杀 ---------
@REM ------ 其他细节 -------------
@REM 暂停升级 enabled Value 0 = Disabled, 1 = Enabled
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "PauseDeferrals" /f
@REM 允许非管理员接收更新通知 Enabled Value 0 = Disabled, 1 = Enabled
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ElevateNonAdmins" /f
@REM 此设置允许你在网络上指定一台服务器执行内部更新服务。自动更新客户端将搜索此服务，找到适用于网络上计算机的更新。
@REM Value 0 = Disabled, 1 = Enabled
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer" /f
@REM 指定 Intranet Microsoft 网址
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer"  /f
@REM 设置 Intranet 统计服务器
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer" /f
@REM 如果启用此策略设置，则会阻止用户连接到 Windows 更新网站。 Value 1 =  Enabled, 0 = Disabled
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoWindowsUpdate" /f
@REM 配置自动更新  Value 1= Disabled, 0 = Enabled 
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /f
@REM 允许自动更新立即安装  Value 1 = Enabled，0 = Disabled
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AutoInstallMinorUpdates" /f
@REM 自动更新频率 Value 0 = Disabled, 1 = Enabled
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "DetectionFrequencyEnabled" /f
@REM 删除使用所有 Windows 更新功能的访问权限 Value 1 = Enabled，0 = Disabled
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /v "DisableWindowsUpdateAccess" /f
@REM 关闭对所有 Windows 更新功能的访问 Value 1 = Enabled，0 = Disabled
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "RescheduleWaitTimeEnabled" /f
@REM 阻止运行 Windows Anytime Upgrade（Windows版本升级）  Value 1 = Enabled，0 = Disabled
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\WAU" /v "Disabled" /f
@REM 允许或禁止 Microsoft Store 向最新版本的 Windows 提供更新。 Value 1 = Enabled, 0 = Disabled
REG delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade"  /f
@REM ------ 其他细节 -------------
@REM 启动 Windows Update 服务
net start wuauserv
pause
```

## 附录

### Win11实测效果

运行stop_update前 与 运行stop_update后

![catch2023-05-29 19.42.13](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-29%2019.42.13.png)

![catch2023-05-29 19.44.00](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-29%2019.44.00.png)

**stop_update**，安装完最后一波更新与重启后效果

![catch2023-05-29 20.01.19](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-29%2020.01.19.png)

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-29%2020.03.32.png)

**re_update** 运行后与重启效果

![catch2023-05-29 20.04.37](/Users/chanlonhoo/Pictures/屏幕截图/catch2023-05-29 20.04.37.png)

![catch2023-05-29 20.05.57](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-29%2020.05.57.png)

### 在线实测效果

使用stop_update.bat以及重启后效果

```
curl -L  https://ghproxy.com/https://github.com/hoochanlon/ihs-simple/raw/main/d-bat/stop_update.bat|cmd
```

![catch2023-05-29 22.30.26](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-29%2022.30.26.png)

![catch2023-05-29 22.35.48](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-29%2022.35.48.png)

re_update测试

```
curl -L  https://ghproxy.com/https://github.com/hoochanlon/ihs-simple/raw/main/d-bat/re_update.bat|cmd
```

![catch2023-05-29 22.38.21](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-29%2022.38.21.png)

![catch2023-05-29 22.40.54](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-29%2022.40.54.png)
