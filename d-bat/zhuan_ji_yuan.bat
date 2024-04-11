@echo off
@REM 默认以管理员权限运行 RegistryFinder 注册表软件
@REM reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files\Registry Finder\RegistryFinder.exe"  /t REG_SZ /d "RUNASADMIN" /f

@REM 以管理员程序运行cmd
%1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"

@REM 显示桌面和控制面板图标；显示文件扩展名，1为隐藏。
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{21EC2020-3AEA-1069-A2DD-08002B30309D}" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f

@REM 启用SMB1 
@REM 参考
:: https://blog.csdn.net/no1xium/article/details/108102968
:: https://learn.microsoft.com/zh-cn/windows-hardware/manufacture/desktop/enable-or-disable-windows-features-using-dism?view=windows-11
:: https://blog.csdn.net/ysapfa/article/details/131222044
rem 启用 SMBv1 客户端
dism /online /enable-feature /featurename:SMB1Protocol /all /norestart
rem 启用 SMBv1 服务器
dism /online /enable-feature /featurename:SMB1Protocol-Server /all /norestart
rem 在注册表中设置 SMBv1 的启用
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v SMB1 /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v AllowInsecureGuestAuth /t REG_DWORD /d 1 /f


@REM 关闭UAC，重启生效；关闭防火墙。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f
netsh advfirewall set allprofiles state off


@REM 禁用休眠 （交流：ac，接通电源；直流：dc，用电池）
@REM https://github.com/hoochanlon/scripts/blob/main/d-pwsh/frontline_helpdesk.ps1
powercfg -change -standby-timeout-dc 0
powercfg -change -hibernate-timeout-ac 0


@REM 禁用"允许计算机关闭此设备以节省电源"
@REM https://learn.microsoft.com/zh-CN/troubleshoot/windows-client/networking/power-management-on-network-adapter
@REM https://learn.microsoft.com/zh-tw/windows-hardware/design/device-experiences/modern-standby-sleepstudy
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\0001" /v PnPCapabilities /t REG_DWORD /d 24 /f

@REM  --------------------------------新版Windows开启IE浏览器，防Edge劫持IE浏览器---------------------------------------------
@REM https://github.com/hoochanlon/scripts/blob/main/d-bat/keep_ie.bat

@REM 小鱼儿IE修复工具2.2已解决劫持问题。win10正常运行脚本就好。
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "Enable Browser Extensions" /t REG_SZ /d "NO" /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "UpsellDisabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "RedirectionMode" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "QuietExpirationTime" /t REG_QWORD /d 0 /f

:: The new "End of Life" upgrade notification for Internet Explorer
:: https://support.microsoft.com/en-us/topic/the-new-end-of-life-upgrade-notification-for-internet-explorer-ca9a8d93-3f92-ee13-f608-a585f4fa08d4
::Note If the value of the iexplore.exe registry entry is 0, or if the registry entry doesn't exist, the notification feature is enabled by default.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_DISABLE_IE11_SECURITY_EOL_NOTIFICATION" /v "iexplore.exe" /t REG_DWORD /d 1 /f
@REM  -------------------------------"防Edge劫持IE浏览器，已处理完成！"--------------------------------------------------------

pause


@REM  ---------------------------- 额外的注释 -------------------------------------------

::--------- 运行自动安装软件 -----------

@REM 部分软件可实现自动化安装，并非所有
@REM 市面上软件众多，每家的软件打包各不相同
@REM 使用批处理自动安装，运行起来实际上不稳定。

@REM set bat_install_path=C:%HOMEPATH%\Downloads
@REM for %%f in (%bat_install_path%\*.exe) do (
@REM   echo Installing %%~nxf...
@REM   %%f /S /SP- /VERYSILENT /NORESTART /SUPPRESSMSGBOXES /FORCE
@REM )


::-------- 装机有人忘记IP，从PE里看的方式 ---------

@REM 在PE环境里对注册表的查询操作存在路径不全的识别问题
@REM REG LOAD HKLM\TempLookIp C:\Windows\System32\config\SYSTEM
@REM 打开注册表，粘贴 HKLM\TempLookIp\ControlSet001\services\Tcpip\Parameters\interfaces
@REM regedit
@REM  echo "HKLM\TempLookIp\ControlSet001\services\Tcpip\Parameters\interfaces" | clip 



@REM powershell面向装机编程——快捷修改IP与软件安装自动化
@REM https://www.52pojie.cn/thread-1745963-1-1.html


@REM 写了个关闭Windows更新的批处理
@REM https://www.52pojie.cn/thread-1791338-1-1.html


@REM 启用/禁用实时防护推荐使用软件
@REM https://www.sordum.org/9480/defender-control-v2-1/
@REM https://www.52pojie.cn/thread-1791895-1-1.html （过去已成回忆）
:: 因为微软经常打补丁，不少注册项被封禁、以及系统会自动检测并删除而失效


@REM  ---------------------------- 额外的注释 -------------------------------------------