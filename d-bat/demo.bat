::------ 须重启及细节方面的相关设置 -------
@REM https://admx.help
@REM learn Microsoft

@REM 特权提升 (小细节)
%1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"

@REM 默认以管理员权限运行 RegistryFinder.exe

reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files\Registry Finder\RegistryFinder.exe"  /t REG_SZ /d "RUNASADMIN" /f

@REM win10 开启 smb1 共享，重启生效
:: https://admx.help/?Category=SecurityBaseline&Policy=Microsoft.Policies.SecGuide::Pol_SecGuide_0001_SMBv1_Server
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SMB1" /t REG_DWORD /d 1 /f

@REM 关闭UAC，重启生效
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f

@REM 激活powershell
powershell -command "Set-ExecutionPolicy RemoteSigned"

@REM 关闭防火墙 (小细节)
netsh advfirewall set allprofiles state off

@REM 关闭休眠 (小细节)
powercfg /H off 

@REM U盘修复 (小细节)
@REM chkdsk G:/f

@REM 设置域名计算机名需要netdom工具，专业版默认是没有的，故不设。
@REM win+r 输入 sysdm.cpl 手动填写计算机名吧。

::--------- 涉及重启的相关设置 ----------

@REM 

::-------- 修改IP和DNS ---------------

@REM 自动获取
@REM netsh interface ip set address "以太网" source=dhcp

@REM 静态IP设置
netsh interface ip set address "以太网" static 192.168.1.1 255.255.255.0  192.168.1.11

@REM 批处理设置DNS，win7是本地连接
netsh interface ip set dns "以太网" static 208.67.222.222 primary
netsh interface ip add dns "以太网" 1.1.1.1

::-------- 修改IP和DNS ---------------

@REM 

::-------  建立smb共享盘映射 ---------

@REM 建立smb共享盘映射 win7格式 
@REM /persistent:yes 它告诉系统将指定的设置或配置持久保存到系统中。
@REM 替换成你的共享盘IP与目录，以及用户名与密码； 123456是密码，test是用户名
@REM net use * \\192.168.0.33\漏洞补丁 123456 /user:test  /persistent:yes

@REM win10及以上格式
net use * \\192.168.0.33\漏洞补丁 /user:test 123456 /persistent:yes

::-------  建立smb共享盘映射 ---------

@REM 

::------- 简单配置IE ---------------

@REM 将所有网站都加入兼容性视图
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\BrowserEmulation" /v "AllSitesCompatibilityMode" /t REG_DWORD /d 1 /f

@REM -- 主页设置与防劫持
@REM 设置主页
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /t REG_SZ /d www.baidu.com /f
@REM 死锁主页
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v HomePage /d 1 /f >nul

@REM 防止 edge 劫持 IE，关闭第三方扩展
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "Enable Browser Extensions" /t REG_SZ /d "NO" /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "UpsellDisabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "RedirectionMode" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "QuietExpirationTime" /t REG_QWORD /d 0 /f

@REM -- 设置IE受信任的站点和内网站点安全级别

@REM 直接将可信任站点的安全级别调至最低
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "CurrentLevel" /t REG_DWORD /d 0x10000 /f 
@REM 直接将Intranet 内部网的安全级别调至最低
@REM 0 本地计算机区域；1 Intranet 内部网； 2 受信任的站点区域；3 Internet 外网域；4 受限制的站点区域。
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" /v "CurrentLevel" /t REG_DWORD /d 0x10000 /f 

@REM 内部网禁用保护模式
reg add "HKCU\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" /v "2500" /t REG_DWORD /d 0x00003 /f 
@REM 受信任的站点区域禁用保护模式
reg add "HKCU\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2500" /t REG_DWORD /d 0x00003 /f 

@REM -- 加入可信任站点

@REM 这里会存在信任站点GUI界面删除不了IP站点的bug，所以最好设置为与IE浏览器相关的业务。
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\192.168.0.1" /v http /t REG_DWORD /d 0x00000002 /f
@REM 有域名的网站倒是可以正常删除，IP的就只能用注册表删除了。
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\baidu.com\www" /v http /t REG_DWORD /d 0x00000002 /f

@REM -- IE仿真模式或者说是此API，官方打算弃用不支持了。
@REM https://learn.microsoft.com/zh-cn/troubleshoot/developer/browsers/development-website/ie-document-modes-faq
@REM https://learn.microsoft.com/zh-cn/previous-versions/windows/internet-explorer/ie-developer/general-info/ee330730(v=vs.85)
@REM https://learn.microsoft.com/zh-cn/internet-explorer/ie11-deploy-guide/deprecated-document-modes

::------- 简单配置IE ------------

@REM 

::---------- 桌面图标 -----------------

@REM 参考：[百度知道-如何用一个批处理显示桌面上的图标](https://zhidao.baidu.com/question/87216101.html)
@REM 工具：https://registry-finder.com

@REM 显示桌面和控制面板图标
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{21EC2020-3AEA-1069-A2DD-08002B30309D}" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d 0 /f

@REM 显示用户文件
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d 0 /f

@REM 显示文件扩展名，1为隐藏
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f

::---------- 桌面图标 ---------------

@REM 

::--------- win10、win11激活 --------
powershell -command "irm https://massgrave.dev/get|iex"
::--------- win10、win11激活 --------

@REM 

::--------- 自动化安装软件 -----------

@REM 部分软件可实现自动化安装，并非所有
set bat_install_path=C:%HOMEPATH%\Downloads
for %%f in (%bat_install_path%\*.exe) do (
  echo Installing %%~nxf...
  %%f /S /SP- /VERYSILENT /NORESTART /SUPPRESSMSGBOXES /FORCE
)

@REM 市面上软件众多，每家的软件打包各不相同
@REM 使用批处理自动安装，运行起来实际上不稳定，建议去学习 AutoIt 脚本语言
@REM [百度百科 - AutoIt](https://baike.baidu.com/item/autoit/4327423?fr=aladdin)
@REM 它利用模拟键盘按键，鼠标移动和窗口/控件的组合来实现自动化任务
@REM 上面这句话摘自[简书-AutoIt3基础教程及实战案例](https://www.jianshu.com/p/c7bd769f5a56)

::--------- 运行自动安装软件 -----------

@REM 

::-------- 装机有人忘记IP，从PE里看的方式 ---------

@REM 在PE环境里对注册表的查询操作存在路径不全的识别问题
REG LOAD HKLM\TempLookIp C:\Windows\System32\config\SYSTEM
@REM 打开注册表，粘贴
@REM HKLM\TempLookIp\ControlSet001\services\Tcpip\Parameters\interfaces

::-------- 装机有人忘记IP，从PE里看的方式 ---------

@REM 

::-- 最后关于powershell的运行策略 ----------------

@REM 大可不必因开启powershell而关闭此项功能，日后也用得着的。
@REM "RemoteSigned" 只允许在本地或远程下载且经过数字签名的脚本文件。
@REM 如果您完全信任则可以选择 "Unrestricted" 安全策略。
@REM https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.3&viewFallbackFrom=powershell-7.1

::-- 最后关于powershell的运行策略 ----------------

@echo off
set printerIP=192.168.0.252

echo 检查网络打印机 %printerIP% 是否在线...
ping -n 1 %printerIP% > nul
if %errorlevel% neq 0 (
    echo 不在线 %printerIP% 稍后试
    pause
    exit
)

rem 连接网络打印机 通用
@REM rundll32 printui.dll,PrintUIEntry /if /b ""  /r "IP_%printerIP%" /m "Generic / Text Only"

@REM 已安装惠普打印机驱动，特例测试
@REM rundll32 printui.dll,PrintUIEntry /if /b ""  /r "IP_%printerIP%" /m "HP Universal Printing PCL 6"


:: ---------------- 静默安装打印机驱动 -------------------------

详情见：https://github.com/hoochanlon/ihs-simple/blob/main/d-ipynb/打印机自动化安装研究.ipynb

rem 连接网络打印机 通用
@REM rundll32 printui.dll,PrintUIEntry /if /b ""  /r "IP_%printerIP%" /m "Generic / Text Only"

@REM 已安装惠普打印机驱动，特例测试
@REM rundll32 printui.dll,PrintUIEntry /if /b ""  /r "IP_%printerIP%" /m "HP Universal Printing PCL 6"

