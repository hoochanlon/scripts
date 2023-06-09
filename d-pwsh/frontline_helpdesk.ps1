# 使用说明
# 下载到本地使用，需转成 GB2312 编码，否则中文乱码
function sel_man {

    # 开启PowerShell：Set-ExecutionPolicy RemoteSigned
    # 关闭PowerShell：Set-ExecutionPolicy Restricted
    # 别名查询：Get-Alias | Where-Object { $_.Definition -eq 'ForEach-Object' }

    Clear-Host
    Write-Host "`n*************************************************************" -ForegroundColor Green
    Write-Host "`n温馨提示：`n" -ForegroundColor Green
    Write-Host "1. 脚本适用Windows10及以上操作系统，并确保主机已开启PowerShell功能" -ForegroundColor Green
    Write-Host "2. 主机启用/禁用 PowerShell指令： " -ForegroundColor Green -nonewline
    Write-Host "Set-ExecutionPolicy RemoteSigned / Set-ExecutionPolicy Restricted" -ForegroundColor DarkYellow
    Write-Host "3. 该脚本信息量较大，建议全屏使用；其他见：" -ForegroundColor Green -NoNewLine
    Write-Host "https://github.com/hoochanlon/ihs-simple `n" -ForegroundColor Blue
    
    Write-Host " [1] 检查IP与网络设备连接近况" -ForegroundColor Green
    Write-Host " [2] 检查打印机、打印池、扫描仪状态" -ForegroundColor Green
    Write-Host " [3] 检查硬盘、CPU、内存、显卡等基础驱动信息" -ForegroundColor Green
    Write-Host " [4] 检查设备安全性、近期升级补丁、定时任务项" -ForegroundColor Green
    Write-Host " [5] 检查主机主动共享协议相关信息" -ForegroundColor Green
    Write-Host " [6] 检查电脑休眠、重启频次、异常关机、程序崩溃等信息" -ForegroundColor Green
    Write-Host " [7] 执行1～6选项的所有功能" -ForegroundColor Green -BackgroundColor DarkGray
    Write-Host ' [8] 生成"驱动检查"、"当天警告事件"、"logon/logoff 活动记录"、"月度已存威胁概况"分析报表' -ForegroundColor Green
    Write-Host " [9] 查看指导建议与开发说明 `n" -ForegroundColor Green
    Write-Host "`**************************************************************`n" -ForegroundColor Green
    
    Write-Host "按 Ctrl + C 可退出，键入 /？查阅该提示选项，数字键（可连续）选择相应功能：" -ForegroundColor Green -NoNewLine

}

# 查阅指导建议与开发说明
function dev_man {

    # cls
    Write-Host "`n"
    Write-Host "### 查阅开发文档说明 ###`n" -ForegroundColor Cyan

    Write-Host "@Author https://github.com/hoochanlon`n" 

    Write-Host "#驱动·设备驱动信息表查看`n" -ForegroundColor Yellow
    Write-Host "* Problem（问题）是与设备或驱动相关的一个或多个问题的描述。可能的值包括无法启动、错误、冲突等。" 
    Write-Host "* ConfigManagerUserConfig（配置管理器用户配置）指示设备或驱动是否由用户或系统进行了配置更改。" 
    Write-Host "* ClassGuid（类别 GUID）是驱动所属设备类型的 GUID（全局唯一标识符）。"
    Write-Host "* Manufacturer（制造商）是生产设备或驱动的公司或组织的名称。" 
    Write-Host "* Present（是否存在）指示设备是否存在于系统上。"
    Write-Host "* Service（服务）是负责管理设备或驱动的 Windows 服务的名称。"
    Write-Host "* Problem：CM_PROB_PHANTOM 表示设备被操作系统标记为“虚假”的设备，损坏、丢失、未正确安装。"
    Write-Host "* Problem：CM_PROB_NONE 状态时，它应该可以正常工作，没有任何故障或错误。`n"
    Write-Host "详情见：" -ForegroundColor Yellow -NoNewline; Write-Host "https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/device-manager-problem-codes" -ForegroundColor Blue

    Write-Host "`n#注册表·注册表概要说明 `n" -ForegroundColor Yellow
    Write-Host "* HKLM：该根键包括本地计算机的系统信息，包括硬件和操作系统信息，安全数据和计算机专用的各类软件设置信息" 
    Write-Host "* HKU：这些信息告诉系统当前用户使用的图标，激活的程序组，开始菜单的内容以及颜色、字体。 " 
    Write-Host "* HkCU：该根键包括当前登录用户的配置信息，包括环境变量，个人程序以及桌面设置等。" 
    Write-Host "* HKCC: 硬件的配置信息。其实HKEY_LOCAL_MACHINE、 HKEY_USERS、这两个才是真正的注册表键，其他都是从某个分支映射出来的，相当于快捷键方式或是别名。`n" 

    Write-Host "`n* 注册表参考网站：" -ForegroundColor Yellow
    Write-Host "    https://admx.help" -ForegroundColor Blue 
    Write-Host "    https://learn.microsoft.com/zh-cn/windows/win32/apiindex/windows-api-list" -ForegroundColor Blue 

    Write-Host "`n* 注册表分析及改写工具：" -ForegroundColor Yellow
    Write-Host "   注册表分析工具：" -ForegroundColor Yellow -nonewline; Write-Host "https://www.nirsoft.net/utils/regscanner.html" -ForegroundColor Blue
    Write-Host "   注册表改写工具：" -ForegroundColor Yellow -nonewline; Write-Host "https://registry-finder.com" -ForegroundColor Blue

    Write-Host "`n#日志·事件级别：`n" -ForegroundColor Yellow  
    Write-Host " 1. 信息 (Information)，是正常的操作行为或系统状态的轻微变化，但并不表示系统存在任何问题或错误。" 
    Write-Host " 2. 警告 (Warning)，，发现已存在的问题或潜在的错误，起到早期的指示作用。" 
    Write-Host " 3. 错误 (Error)，表示某个操作或任务未能完成或完成不正确，需要引起注意。`n" 
    Write-Host '在 Windows 事件中，“成功审核”和“失败审核”实际上不是作为事件级别进行报告的，而是作为事件分类或事件源之一。'
    Write-Host "事件ID对应多个不同分类的日志，而每个不同分类的日志对定位的级别，也各不相同。`n" 
   
    Write-Host "#日志·程序标识符 `n" -ForegroundColor Yellow
    Write-Host "每个事件提供程序都有唯一的 ProviderName。以下是系统日志中，其常见的部分示例：`n"
    Write-Host "* Microsoft-Windows-Kernel-Power：提供了与系统电源管理相关的事件，例如系统挂起、恢复、关机、重启等。" 
    Write-Host "* Microsoft-Windows-Kernel-General：提供了与操作系统内核相关的事件，例如启动或关闭操作系统、内核初始化、驱动程序加载等。" 
    Write-Host "* Microsoft-Windows-Wininit：提供了与系统引导和初始化相关的事件，例如启动初始化进程、检查文件系统、加载系统驱动程序等。" 
    Write-Host "* Microsoft-Windows-Security-Auditing：提供了与安全审计和审核相关的事件，例如用户登陆、权限更改、文件和对象访问等。" 
    Write-Host "* Microsoft-Windows-DistributedCOM：提供了与分布式应用程序相关的事件，例如分布式COM调用的失败、权限问题、RPC服务器无法使用等。" 
    Write-Host "* Microsoft-Windows-DNS-Client：服务负责将域名解析为相应的 IP 地址，并将其缓存以提高性能。" 
    Write-Host "* Service Control Manager：事件通常记录了系统启动、服务启动/停止、服务崩溃等与服务相关的事件。"
    Write-Host "* LsaSrv： 是指 Windows 系统中与本地安全认证服务。如用户的登录、注销、密码重置，以及 NTLM 和 Kerberos等。" 
    Write-Host "* User32： 大量用于处理 GUI（图形用户界面）元素和用户交互的系统 API。"
    Write-Host "`n以上仅是常见的几个 ProviderName 示例，实际上还有很多其他的 ProviderName，其作用和功能也各不相同，可根据需要进行查询。"

    Write-Host "`n* 事件ID查询：" -ForegroundColor Yellow
    Write-Host "   https://www.ultimatewindowssecurity.com/securitylog/encyclopedia" -ForegroundColor Blue
    Write-Host "   https://www.myeventlog.com/search/find" -ForegroundColor Blue
    Write-Host "`n* 安全标识符查询：" -ForegroundColor Yellow -NoNewline
    Write-Host "https://rootclay.gitbook.io/windows-access-control/qi-an-quan-biao-shi-fu `n" -ForegroundColor Blue  
    Write-Host "`n* PowerShell模块组件线索查询：" -ForegroundColor Yellow
    Write-Host "    https://learn.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps" -ForegroundColor Blue
    
    Write-Host "`n日志记录开关机的现状说明：`n"
    Write-Host "1. 统计事件6005、6006、557并不能精确获取到开关机时间，6005 和 6006只是分别记录为EventLog的启动和关闭事件。"
    Write-Host "2. 但是这些事件只记录了系统的操作状态，而没有记录实际的开机和关机时间。"
    Write-Host "3. 557 该事件虽本质含义是指操作系统已成功开始启动，值得注意是："
    Write-Host '   "Active" 表示系统处于活动状态，这也可能系统正在运行某些应用程序、计算/处理一些任务，或等待用户操作。'
    Write-Host '   因此，在启动时 "Active" 可能是由操作系统自动调用的某些服务或应用程序引起的，比如锁屏解锁。'
    Write-Host "4. 事件 12 与事件 13 的 System 日志中，Windows是明确定义为系统启动与关闭的。"
    Write-Host " "
    Write-Host "**需要注意的是，这种方法的精度取决于操作系统日志的日志记录级别和日志文件大小限制。**" -ForegroundColor Yellow
    Write-Host "**如果日志满了并且被截断了，这些事件也可能不会包含完整的历史记录。**" -ForegroundColor Yellow

    Write-Host "`n#桌面技术·常见故障指导修复`n"  -ForegroundColor Cyan
    Write-host "* 应用程序无法访问 Internet 导致无法启动："  -ForegroundColor Yellow -nonewline; Write-Host "netsh winsock reset"  -ForegroundColor Green
    Write-host "* 解决SMB共享盘残留账号："  -ForegroundColor Yellow -nonewline; Write-Host "net stop workstation & net start workstation"  -ForegroundColor Green
    Write-Host "* U盘故障修复：" -ForegroundColor Yellow -nonewline; Write-host "chkdsk U盘盘符: /f" -ForegroundColor Green
    Write-Host "* 系统文件完整性扫描：" -ForegroundColor Yellow -nonewline; Write-Host "sfc /scannow"  -ForegroundColor Green 
    Write-Host "* 系统DCOM组件注册：" -ForegroundColor Yellow -nonewline; Write-Host "regsvr32 C:\Windows\System32\ole32.dll"  -ForegroundColor Green
    Write-Host "* 检查系统映像完整性：" -ForegroundColor Yellow -nonewline; Write-Host "DISM /Online /Cleanup-Image /RestoreHealth"  -ForegroundColor Green
    Write-Host "* 有关其他dll异常，可下载安装vc++运行库，解决初期问题：" -ForegroundColor Yellow
    Write-Host "  * " -ForegroundColor Yellow -NoNewline; Write-Host "https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170 `n" -ForegroundColor Blue

    Write-Host "#桌面技术·网络配置`n"  -ForegroundColor  Cyan

    Write-Host "备份IP设置到桌面 ip_config_bak.txt" -ForegroundColor Yellow
    Write-Host " "
    Write-Host "netsh interface ip show config > C:%homepath%\Desktop\ip_config_bak.txt" -ForegroundColor Green
    Write-Host " "
    Write-Host "静态IP、子网掩码、网关" -ForegroundColor Yellow
    Write-Host " "
    Write-Host 'netsh interface ip set address "以太网" static 192.168.1.1 255.255.255.0  192.168.1.11'  -ForegroundColor Green
    Write-Host " "
    Write-Host "静态DNS设置" -ForegroundColor Yellow
    Write-host `
        '
    netsh interface ip set dns "以太网" static 208.67.222.222 primary && netsh interface ip add dns "以太网" 114.114.114.114
    ' -ForegroundColor Green
    
    Write-host "`n自动网络获取`n"  -ForegroundColor Yellow
    Write-Host 'netsh interface ip set address "以太网" source=dhcp'  -ForegroundColor Green
    Write-Host 'netsh interface ip set dns "以太网" dhcp' -ForegroundColor Green 

    Write-host "`n#桌面技术·装机`n"  -ForegroundColor Cyan

    Write-Host "1. 系统/Office激活：" -ForegroundColor Yellow -NoNewline; Write-Host 'powershell -c "irm https://massgrave.dev/get|iex"' -ForegroundColor Green
    Write-host "2. 关闭防火墙：" -ForegroundColor Yellow -NoNewline; Write-Host 'netsh advfirewall set allprofiles state off'  -ForegroundColor Green
    Write-host "3. 关闭UAC：" -ForegroundColor Yellow -NoNewline; 
    Write-host 'reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f' -ForegroundColor Green
    Write-host "4. 开启SMB1：" -ForegroundColor Yellow -NoNewline; 
    Write-Host 'reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SMB1" /t REG_DWORD /d 1 /f'  -ForegroundColor Green
    Write-host "5. SMB盘设置：" -ForegroundColor Yellow -NoNewline;
    Write-Host 'net use * \\192.168.0.33\漏洞补丁 /user:test 123456 /persistent:yes'  -ForegroundColor Green
    Write-host "6. 自动化静默安装软件：" -ForegroundColor Yellow -NoNewline; Write-Host 'C:\path\your software\Setup.exe /s /qn' -ForegroundColor Green
    Write-Host "7. 显示此电脑、控制面板图标、扩展名（复制橙色代码即可）"  -ForegroundColor Yellow
    Write-Host `
        '
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{21EC2020-3AEA-1069-A2DD-08002B30309D}" /t REG_DWORD /d 0 /f
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d 0 /f
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f
        ' -ForegroundColor DarkYellow

    Write-Host "8. PE查看IP地址：`n"  -ForegroundColor Yellow
    Write-Host `
        '
        REG LOAD HKLM\TempLookIp C:\Windows\System32\config\SYSTEM & REG QUERY HKLM\TempLookIp\ControlSet001\services\Tcpip\Parameters\interfaces /s
        '  -ForegroundColor DarkYellow

    Write-Host " "
    Write-Host "9. IE防劫持（win10正常使用就好，win11需先用小鱼儿IE修复工具，恢复IE11快捷方式，再使用该代码。）：`n" -ForegroundColor Yellow
    Write-Host `
        '
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "Enable Browser Extensions" /t REG_SZ /d "NO" /f
        reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "UpsellDisabled" /t REG_DWORD /d 0 /f
        reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "RedirectionMode" /t REG_DWORD /d 0 /f
        reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "QuietExpirationTime" /t REG_QWORD /d 0 /f
        ' -ForegroundColor DarkYellow
    
    Write-Host "10. 禁用实时保护 `n" -ForegroundColor Yellow
    Write-Host `
        '
        REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /f 2>nul 1>nul
        ' -ForegroundColor DarkYellow

    Write-Host "`n11. 启用实时保护 `n" -ForegroundColor Yellow
    Write-Host `
        '
        REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f 1>nul
        ' -ForegroundColor DarkYellow

    Write-Host "`n12. 关闭win10/win11 搜索热搜 `n" -ForegroundColor Yellow
    Write-Host "    reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\explorer" /v DisableSearchBoxSuggestions /t reg_dword /d 1 /f" -ForegroundColor DarkYellow

    Write-Host " "
    Write-Host "`n#桌面技术·休眠、睡眠专题`n"  -ForegroundColor  Cyan

    Write-Host "休眠、睡眠的区别：`n" -ForegroundColor Yellow
    Write-Host "* 休眠：将系统状态保存到硬盘，关闭所有设备，电脑选择了休眠，与关机同理是不耗电的，再次唤醒时，系统从硬盘恢复数据。" -ForegroundColor Yellow
    Write-Host "* 睡眠：将系统状态保存到内存，关闭所有设备，系统进入低功耗状态；启动快，一旦插线板（市网供电）断电，睡眠是无法保存数据的。`n" -ForegroundColor Yellow
    Write-Host '具体概念可参考，"博客园 - 电脑睡眠（sleep）和休眠（Hibernate）的区别，以及休眠功能的设置"：' -ForegroundColor Yellow
    Write-Host "    https://www.cnblogs.com/fatherofbeauty/p/16351107.html" -ForegroundColor Blue
   
    Write-Host "`n交流电与直流电置零休眠、睡眠，并禁用休眠。（交流：ac，接通电源；直流：dc，用电池）`n" -ForegroundColor Yellow; 
    Write-Host `
        '
        # 交流电与直流电置零休眠
        ' -NoNewline
    Write-Host `
        '
        powercfg -change -standby-timeout-ac 0
        powercfg -change -hibernate-timeout-ac 0

        ' -ForegroundColor DarkYellow
    Write-Host `
        '
        # 交流电与直流电置零睡眠
        ' -NoNewline
    Write-Host `
        '
        powercfg -change -standby-timeout-dc 0
        powercfg -change -hibernate-timeout-dc 0

        ' -ForegroundColor DarkYellow
    Write-Host `
        '
        # 禁用休眠
        ' -NoNewline
    Write-Host `
        '
        powercfg -h off
        ' -ForegroundColor DarkYellow

    Write-Host "`n设置交流电与直流电的屏幕显示时间（默认单位为秒）：`n" -ForegroundColor Yellow; 
    Write-Host `
        '
        # 交流：ac，接通电源
        ' -NoNewline     
    Write-Host `
        '
        powercfg -setacvalueindex SCHEME_BALANCED SUB_VIDEO VIDEOIDLE 180
        ' -ForegroundColor DarkYellow

    Write-Host `
        '
        # 直流：dc，用电池
        ' -NoNewline
    Write-Host `
        '
        powercfg -setdcvalueindex SCHEME_BALANCED SUB_VIDEO VIDEOIDLE 120
        ' -ForegroundColor DarkYellow
  
    Write-Host '关于"允许计算机关闭此设备以节省电源"禁用设置，可参考：' -ForegroundColor Yellow
    Write-Host "    https://learn.microsoft.com/zh-CN/troubleshoot/windows-client/networking/power-management-on-network-adapter" -ForegroundColor Blue
    Write-Host " "
    Write-Host '以下为取消勾选"允许计算机关闭此设备以节省电源，（勾选 默认值 0 即可；取消勾选 24）"' -ForegroundColor Yellow
    Write-Host " "
    Write-Host `
        '
        reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\0001" /v PnPCapabilities /t REG_DWORD /d 24 /f
        ' -ForegroundColor DarkYellow

    Write-Host "`n#补充·共享说明 `n" -ForegroundColor Cyan

    Write-Host "`n 有别于端口流量监测分析，这个共享服务检测主要针对于局域网企业非信息质量部、开发应用部同事的主机检测，因此也较容易察觉出其主机的可疑性。`n" -ForegroundColor Yellow
    Write-Host '另外，http相比于SMB、FTP更为繁琐复杂，比较"专业化"，由于面向受众的不同，故不纳入检测范围。' -ForegroundColor Yellow; Write-Host "`nSMB列表概要："
    Write-Host '1. ADMIN$ 表示 Windows 操作系统的安装目录（通常为C:\Windows）的共享目录。该共享只有管理员帐户才能访问，用于进行远程管理操作。'
    Write-Host '2. C$ 表示整个系统驱动器（通常为 C:\）的共享目录。该共享允许拥有管理员权限的用户通过网络进行对系统根目录的访问。'
    Write-Host '3. IPC$ 共享可能被滥用的原因是，它是一个特殊的共享，允许用户在不需要进行身份验证的情况下建立连接。'
    Write-Host ' 3.1 这意味着攻击者可以使用一些工具和技术（如端口扫描、远程桌面连接等）来访问 IPC$ 共享，并尝试利用系统漏洞进行攻击。'
    Write-Host ' 3.2 禁用IPC可能会对其他服务产生负面影响，如：文件共享、AD活动目录、远程管理工具、系统备份和还原。'

    Write-Host "`n#补充·有关 Windows defender 文档 `n" -ForegroundColor Cyan

    Write-Host `
        '
        * https://learn.microsoft.com/en-us/previous-versions/windows/desktop/defender/msft-mpthreat
        * https://docs.microsoft.com/en-us/windows/security/threat-protection/microsoft-defender-antivirus/microsoft-defender-antivirus-in-windows-10
        ' -ForegroundColor Yellow

    Write-Host `
        '
        关于 Get-MpThreatDetection 的详细属性信息，可参考：https://powershell.one/wmi/root/microsoft/windows/defender/msft_mpthreatdetection
        ' -ForegroundColor Green

    Write-Host "`n#结语`n" -ForegroundColor  Cyan

    Write-Host "PowerShell是一个强大的脚本语言，可实现多种系统级操作功能，对自动化管理Windows系统十分有利。" 
    Write-Host "PowerShell实现的Windows基线检查脚本，可实现对系统基础信息、网络连接、打印机状态、防火墙状态、硬盘、CPU、内存信息等的检查。`n"
    Write-Host "`n编写基线检查脚本，涉及到多种技术，如下："
    Write-Host "1. 常见桌面问题解决方案：桌面运维涉及到的软件、硬件、网络、系统、安全等多个方面。"
    Write-Host "2. 代码实现涉及到细节：如何获取系统信息、如何获取注册表信息、如何获取事件日志信息、如何获取WMI信息等。"
    Write-Host "2.1 代码实现涉及到设计思想：如何查询结构、基本运行逻辑、异常处理等。"
    Write-Host "3. 查阅文档与验证：关键字、案例、调试、实验、反复查阅。`n"
    Write-Host "如有疑问及遗漏不当之处，可联系作者邮箱 hoochanlon@outlook.com ，以及访问GitHub项目地址：" -NoNewline -ForegroundColor Yellow
    Write-Host "https://github.com/hoochanlon/ihs-simple " -NoNewline -ForegroundColor Blue
    Write-Host "，同时欢迎咨询与指正。" -ForegroundColor Yellow

    Write-Host "`n#附录·IT运维技术分析工具`n"  -ForegroundColor  Cyan

    Write-Host "`n* 局域网网络分析工具：" -ForegroundColor Yellow
    Write-Host "    advanced-ip-scanner：" -ForegroundColor Yellow -nonewline; Write-Host "https://www.advanced-ip-scanner.com" -ForegroundColor Blue
    Write-Host "    wireshark：" -ForegroundColor Yellow -nonewline; Write-Host "https://www.wireshark.org" -ForegroundColor Blue

    Write-Host "`n* 系统各项性能分析工具：" -ForegroundColor Yellow
    Write-Host "   图拉丁工具箱：" -ForegroundColor Yellow -nonewline; Write-Host "http://www.tbtool.cn" -ForegroundColor Blue
    Write-Host "   windirstat：" -ForegroundColor Yellow -nonewline; Write-Host "https://windirstat.net" -ForegroundColor Blue
    Write-Host "   sysinternals：" -ForegroundColor Yellow -nonewline; Write-Host "https://docs.microsoft.com/zh-cn/sysinternals/downloads/process-explorer" -ForegroundColor Blue

    Write-Host "`n* PowerShell模块组件：" -ForegroundColor Yellow
    Write-Host "    https://learn.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps" -ForegroundColor Blue
    Write-Host "    https://www.powershellgallery.com" -ForegroundColor Blue

    Write-Host "`n* 注册表分析工具：" -ForegroundColor Yellow
    Write-Host "   admx.help：" -ForegroundColor Yellow -nonewline; Write-Host "https://admx.help" -ForegroundColor Blue 
    Write-Host "   regscanner：" -ForegroundColor Yellow -nonewline; Write-Host "https://www.nirsoft.net/utils/regscanner.html" -ForegroundColor Blue
    Write-Host "   registry-finder：" -ForegroundColor Yellow -nonewline; Write-Host "https://registry-finder.com" -ForegroundColor Blue

    Write-Host "`n* 事件ID分析工具：" -ForegroundColor Yellow
    Write-Host "    Win10_Events_ID_useful：" -ForegroundColor Yellow -nonewline; Write-Host "https://github.com/hoochanlon/ihs-simple/blob/main/BITRH/Win10_Events_ID_useful.xlsx" -ForegroundColor Blue
    Write-Host "   myeventlog：" -ForegroundColor Yellow -nonewline; Write-Host "https://www.myeventlog.com/search/find" -ForegroundColor Blue
    Write-Host "   ultimatewindowssecurity：" -ForegroundColor Yellow -nonewline; Write-Host "https://www.ultimatewindowssecurity.com/securitylog/encyclopedia" -ForegroundColor Blue
   
    Write-Host "`n#附录·软件分析涉及项：`n" -ForegroundColor  Cyan
    Write-Host "1. 代码分析：软件分析通常涉及对应用程序源代码的详细分析。" -ForegroundColor Yellow
    Write-Host "2. 漏洞扫描：通过漏洞扫描工具可以自动发现软件中的安全漏洞。" -ForegroundColor Yellow
    Write-Host "3. 静态分析：静态分析是指对源代码进行分析以发现潜在问题，而不是运行代码并观察其行为。" -ForegroundColor Yellow
    Write-Host "4. 动态分析：动态分析是指在运行时对应用程序进行分析以观察其行为。" -ForegroundColor Yellow
    Write-Host "5. 逆向工程：逆向工程是指使用反汇编器和其他技术分析已编译的代码以发现程序的内部机制。" -ForegroundColor Yellow
    Write-Host "6. 反作弊分析：反作弊分析是指对游戏和应用程序进行分析，以检测和打击作弊行为。" -ForegroundColor Yellow
    Write-Host "7. 安全审计：安全审计是指对软件进行详细的审查，以确定其是否符合特定的安全标准或法规。" -ForegroundColor Yellow

    Write-Host "`n#附录·信息安全资料站点聚合" -ForegroundColor  Cyan
    Write-Host " "
    Write-Host "----------------------------------------" -ForegroundColor Yellow
    Write-Host "搜索技巧：一、目的明确；二、凝练关键词；三、寻找正反两案例，分析并比对。如示（以此类推）：" -ForegroundColor Yellow
    Write-Host "[CSDN - PowerShell攻击与检测](https://blog.csdn.net/Ping_Pig/article/details/108976627)" -ForegroundColor Magenta
    Write-Host "----------------------------------------" -ForegroundColor Yellow
    Write-Host " "

    Write-Host "`n* IT技术刊文网站：" -ForegroundColor Yellow
    Write-Host "   superuser：" -ForegroundColor Yellow -nonewline; Write-Host "https://superuser.com" -ForegroundColor Blue
    Write-Host "   minitool news" -ForegroundColor Yellow -nonewline; Write-Host "https://www.minitool.com/news/automatic-sample-submission-off.html" -ForegroundColor Blue
    Write-Host "   吾爱破解" -ForegroundColor Yellow -nonewline; Write-Host "https://www.52pojie.cn/forum-10-1.html" -ForegroundColor Blue
    Write-Host "   先知社区" -ForegroundColor Yellow -nonewline; Write-Host "https://xz.aliyun.com/search?keyword=thinkphp" -ForegroundColor Blue
    Write-Host "   freebuf：" -ForegroundColor Yellow -nonewline; Write-Host "https://www.freebuf.com" -ForegroundColor Blue
    Write-Host "   舆情采集系统：" -ForegroundColor Yellow -nonewline; Write-Host "https://www.axtx.net" -ForegroundColor Blue
    Write-Host "   各类互联网IT技术杂文：" -ForegroundColor Yellow -nonewline; Write-Host "https://www.zadmei.com" -ForegroundColor Blue

    Write-Host "`n#附录·ASCII ART`n" -ForegroundColor  Cyan
    Write-Host " "
    Write-Host "-----------------------------------------------------------------------" -ForegroundColor Yellow
    Write-Host "生成 ASCII 艺术图片" -ForegroundColor Yellow
    Write-Host " [ASCII ART](https://ascii.co.uk/art)" -ForegroundColor Magenta
    Write-Host " [ASCII Art Generator](https://wiki.archlinuxcn.org/zh-hans/ASCII_艺术)" -ForegroundColor Magenta
    Write-Host "-----------------------------------------------------------------------" -ForegroundColor Yellow
    Write-Host " "
    Write-Host @"
                                                             <|/\
                                                              | |,

                                                             |-|-o
                                                             |<|.

                                              _,..._,m,      |,
                                           ,/'      '"";     | |,
                                          /             ".
                                        ,'mmmMMMMmm.      \  -|-_"
                                      _/-"^^^^^"""%#%mm,   ;  | _ o
                                ,m,_,'              "###)  ;,
                               (###%                 \#/  ;##mm.
                                ^#/  __        ___    ;  (######)
                                 ;  //.\\     //.\\   ;   \####/
                                _; (#\"//     \\"/#)  ;  ,/
                               @##\ \##/   =   `"=" ,;mm/
                               `\##>.____,...,____,<####@
                                                     ""'     m1a    

"@ -ForegroundColor DarkGreen

    <# ------- 倒计时

    # 就两位数吧，折中方案，当小于100秒时，或到了1分钟时采用
    # $t = 11
    # while ($t -ge 0) {
    #     Write-Host ($t.ToString("D2")) -NoNewline
    #     Start-Sleep -Seconds 1
    #     Write-Host -NoNewline "`b`b`b`r"
    #     $t--
    # }

    #>

}

# 检查主机名、系统安装日期、启动时间、运行时间、系统架构
function check_sys {

    Clear-Host
    Write-Host "`n"
    Write-Host "### 主机基础信息 ###" -ForegroundColor Cyan

    Get-ComputerInfo | Select-Object -Property `
        OsRegisteredUser, CsDomain, CsDNSHostName, OsName,
    OsInstallDate, OsLastBootUpTime, OsUptime, OsArchitecture `
    | Out-Host
}

# 检查IP与网络设备连接状态
function check_ip {

    Write-Host " "
    Write-Host "### 检查网络基本连接情况 ###`n" -ForegroundColor Cyan

    Write-Host "--- 检查IP地址 ---"  -ForegroundColor Yellow
    netsh interface ipv4 show addresses "以太网"
    netsh interface ipv4 show dnsservers "以太网"
    netsh winhttp show proxy

    Write-Host "--- 检查连接局域网网络状态 ---`n"  -ForegroundColor Yellow
    $result = Get-NetConnectionProfile | Select-Object -Property Name, InterfaceAlias, NetworkCategory
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "此网络存在异常。`n" -ForegroundColor DarkRed
    }

    Write-Host "--- 检查近期是否存在IP冲突 ---`n"  -ForegroundColor Yellow
    
    $result = Get-WinEvent -FilterHashtable @{
        LogName   = 'System'
        StartTime = (Get-Date).Date.AddDays(-14)
    } | Where-Object {
        ($_.Id -in 4199)
    } | Select-Object Id, Level, ProviderName, LogName, `
        TimeCreated, LevelDisplayName, TaskDisplayName
    
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "主机近期没有存在IP冲突事件。`n" -ForegroundColor Green
    }

    Write-Host "### 检查网络基本连接情况，已完成`n" -ForegroundColor Green
}

# 检查打印机状态详情
function check_printer {

    Write-Host " "
    Write-Host "### 检检查打印机状态 ###`n" -ForegroundColor Cyan

    Write-Host "--- 检查打印机服务，以及连接打印机数量 ---"  -ForegroundColor Yellow
    Get-Service | findstr "Spooler" | Out-Host

    Write-Host "--- 检查打印池是否有文件 ---"  -ForegroundColor Yellow
    Get-ChildItem C:\Windows\System32\spool\PRINTERS

    $result = Get-Printer | Select-Object Name, PrinterStatus
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "没有配置任何虚拟或实体打印机" -ForegroundColor DarkRed
    }
   
    Write-Host "--- 检查是否存在默认打印机 ---"  -ForegroundColor Yellow
    
    $result = Get-CimInstance -Class Win32_Printer | Where-Object { $_.Default -eq $true } | Select-Object Name 
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "没有配置默认打印机" -ForegroundColor Magenta
    }

    Write-Host "--- 检查是否存在扫描仪服务 ---"  -ForegroundColor Yellow
   
    $result = Get-Service stisvc
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "扫描仪服务缺失" -ForegroundColor Magenta
    }
    
    Write-Host "`n### 检查打印机状态，已完成`n" -ForegroundColor Green
} 

# 检查硬盘、CPU、内存信息
function check_disk_cpu_mem {

    # [math]::Round 用于调用 .NET Framework 中的静态方法或属性。
    # https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_arithmetic_operators?view=powershell-7.3
    
    Write-Host " "
    Write-Host "### 开始检查硬盘、CPU、内存、系统基础驱动 ###`n"  -ForegroundColor Cyan

    Write-Host "--- 检查硬盘类型与容量 ---"  -ForegroundColor Yellow
    $result = Get-PhysicalDisk 
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "获取不到硬盘类型与容量`n"  -ForegroundColor Red
    }
   
    Write-Host "--- 检查硬盘分区及可用空间 ---"  -ForegroundColor Yellow
    $result = Get-Volume
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "获取不到硬盘分区及可用空间`n"  -ForegroundColor Red
    }

    Write-Host "--- 检查CPU参数 ---"  -ForegroundColor Yellow
    $result = Get-CimInstance -Class Win32_Processor | Select-Object Caption, MaxClockSpeed 
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "获取不到CPU参数`n"  -ForegroundColor Red
    }

    Write-Host "--- 检查内存条参数、类型 ---`n"  -ForegroundColor Yellow
    Write-Host "DDR1: 400 MHz以下；DDR2: 800 MHz以下；DDR3: 2133 MHz以下；DDR4: 3200 MHz以下。" 
    
    $result = Get-CimInstance -Class Win32_PhysicalMemory | 
    Select-Object -Property BankLabel, 
    @{Name = "Capacity(GB)"; Expression = { [math]::Round($_.Capacity / 1GB, 2) } }, 
    DeviceLocator, PartNumber, SerialNumber, Speed
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "获取不到内存条参数、类型`n"  -ForegroundColor Red
    }

    
    Write-Host "--- 检查电脑显示参数状态 ---"  -ForegroundColor Yellow

    $videoController = Get-CimInstance -Class Win32_VideoController -ErrorAction SilentlyContinue

    if ($videoController) {

        $Name = $videoController.Name
        $DriverVersion = $videoController.DriverVersion
        $AdapterCompatibility = $videoController.AdapterCompatibility
        $Status = $videoController.Status
        $AdapterRAM = [System.Math]::Round($videoController.AdapterRAM / (1024 * 1024 * 1024), 2)
        $CurrentHorizontalResolution = $videoController.CurrentHorizontalResolution
        $CurrentVerticalResolution = $videoController.CurrentVerticalResolution
        $VideoModeDescription = $videoController.VideoModeDescription
        $MaxRefreshRate = $videoController.MaxRefreshRate

        if ([string]::IsNullOrEmpty($Name)) { $Name = "N/A" }
        if ([string]::IsNullOrEmpty($AdapterCompatibility)) { $Name = "N/A" }
        if ([string]::IsNullOrEmpty($Status)) { $Status = "N/A" }
        if ([string]::IsNullOrEmpty($DriverVersion)) { $DriverVersion = "N/A" }
        if ([string]::IsNullOrEmpty($AdapterRAM)) { $AdapterRAM = "N/A" }

        if ([string]::IsNullOrEmpty($CurrentHorizontalResolution)) { $CurrentHorizontalResolution = "N/A" }
        if ([string]::IsNullOrEmpty($CurrentVerticalResolution)) { $CurrentVerticalResolution = "N/A" }
        if ([string]::IsNullOrEmpty($VideoModeDescription)) { $VideoModeDescription = "N/A" }
        if ([string]::IsNullOrEmpty($MaxRefreshRate)) { $MaxRefreshRate = "N/A" }
        
        Write-Host " "
        Write-Host "显卡驱动：$Name"
        Write-Host "驱动版本：$DriverVersion"
        Write-Host "状态：$Status"
        Write-Host "显存(GB)：$AdapterRAM"
        Write-Host "平台兼容性：$AdapterCompatibility"
        Write-Host "最大刷新率：$MaxRefreshRate"
        Write-Host "当前水平分辨率：$CurrentHorizontalResolution"
        Write-Host "当前垂直分辨率：$CurrentVerticalResolution"
        Write-Host "视频模式描述：$VideoModeDescription"
        Write-Host " "
    }
    else {
        Write-Host "未能检测到 Video Controller。`n"
    }

    Write-Host "`n--- 检查显示屏设备详情 ---`n"  -ForegroundColor Yellow

    $monitor_id = Get-CimInstance -Namespace root\wmi -ClassName WmiMonitorID | Select-Object -First 1

    if ($null -ne $monitor_id) {
        $Manufacturer = [System.Text.Encoding]::UTF8.GetString($monitor_id.ManufacturerName)
        $ProductCode = [System.Text.Encoding]::UTF8.GetString($monitor_id.ProductCodeID)
        $SerialNumber = [System.Text.Encoding]::UTF8.GetString($monitor_id.SerialNumberID)
        $UserFriendlyNameLength = $monitor_id.UserFriendlyNameLength
        $UserFriendlyNameBytes = $monitor_id.UserFriendlyName[0..($UserFriendlyNameLength - 1)]
        
        if ($null -ne $UserFriendlyNameBytes) {
            $UserFriendlyName = [System.Text.Encoding]::UTF8.GetString($UserFriendlyNameBytes)
        }
        else {
            $UserFriendlyName = "N/A"
        }
        
        $WeekOfManufacture = $monitor_id.WeekOfManufacture
        $YearOfManufacture = $monitor_id.YearOfManufacture
        
        Write-Host "Active: $($monitor_id.Active)"
        Write-Host "Instance Name: $($monitor_id.InstanceName)"
        Write-Host "Manufacturer: $Manufacturer"
        Write-Host "Product Code: $ProductCode"
        Write-Host "Serial Number: $SerialNumber"
        Write-Host "User-friendly name: $UserFriendlyName (Length: $UserFriendlyNameLength)"
        Write-Host "Week of Manufacture: $WeekOfManufacture"
        Write-Host "Year of Manufacture: $YearOfManufacture"
    }
    else {
        Write-Host "`n没有查询到相关显示屏具体信息。`n" -ForegroundColor Red
    }

    Write-Host "`n--- 检查主板信息 ---"  -ForegroundColor Yellow

    $result = Get-CimInstance -Class Win32_BaseBoard | Select-Object Manufacturer, Product, Model, SerialNumber
    if ($result) {
        $result | Format-List
    }
    else {
        Write-Host "`n未查询到主板信息`n"  -ForegroundColor Green
    }

    Write-Host "`n--- 检查驱动是否存有异常 ---`n"  -ForegroundColor Yellow
    $result = Get-PnpDevice | Where-Object { $_.Status -ne "Ok" }
    if ($result) {
        $result | Select-Object FriendlyName, Status | Out-Host
    }
    else {
        Write-Host "设备驱动运转正常`n"  -ForegroundColor Green
    }
    Write-Host "### 检查硬盘、CPU、内存、系统基础驱动，已完成`n"  -ForegroundColor Green
}

# 查看防火墙状态以及是否开放特定端口规则（初期功能）
# 检查设备安全性、近期升级补丁、定时任务项
function check_fw {

    Write-Host " "
    Write-Host "### 检查设备安全性、近期升级补丁、定时任务项 ###`n" -ForegroundColor Cyan

    Write-Host "--- 检测Windows defender实时保护状态 ---"  -ForegroundColor Yellow
    Get-MpComputerStatus | Select-Object -Property RealTimeProtectionEnabled, AntivirusEnabled | Out-Host
   
    Write-Host "--- 检测防火墙是否开启 ---"  -ForegroundColor Yellow
    Get-NetFirewallProfile | Select-Object Name, Enabled | Out-Host

    Write-Host "--- 关于远程桌面与ICMP ping防火墙策略是否启用 ---"  -ForegroundColor Yellow
    Get-NetFirewallRule -DisplayName "远程桌面*", "核心网络诊断*ICMPv4*" | Select-Object DisplayName, Enabled | Out-Host

    Write-Host "--- 检查主机安装补丁近况 ---`n"  -ForegroundColor Yellow
    Get-HotFix | Sort-Object -Property InstalledOn -Descending | Select-Object -First 9 | Out-Host

    Write-Host "--- 检查非主机系统性的计划任务 ---`n"  -ForegroundColor Yellow

    Get-ScheduledTask | Where-Object { $_.TaskPath -notlike "*Microsoft*" -and $_.TaskName -notlike "*Microsoft*" } `
    | Get-ScheduledTaskInfo | Select-Object TaskName, LastRunTime, NextRunTime | Format-table

    Write-Host "--- 系统级软件自启检查 (Run) ---`n" -ForegroundColor Yellow

    Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -ErrorAction SilentlyContinue `
    | Select-Object * -ExcludeProperty PSPath, PSChildName, PSDrive, PSParentPath, PSProvider, *Microsoft* | Format-List

    Write-Host "--- 用户级软件自启检查 (Run) ---`n" -ForegroundColor Yellow

    Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -ErrorAction SilentlyContinue `
    | Select-Object * -ExcludeProperty PSPath, PSChildName, PSDrive, PSParentPath, PSProvider, *Microsoft* | Format-List

    Write-Host "--- 系统级与用户级软件只生效一次自启的检查 (RunOnce) ---`n" -ForegroundColor Yellow

    # 系统级 HKLM
    $run_once_path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"
    if ((-not (Test-Path $run_once_path)) -or ($null -eq (Get-ItemProperty -Path $run_once_path))) {
        # Write-Warning "未找到 RunOnce 属性。"
        Write-Host "没有发现系统级的一次性自启项`n" -ForegroundColor Green
    }
    else {
        Get-ItemProperty -Path $run_once_path `
        | Select-Object * -ExcludeProperty PSPath, PSChildName, PSDrive, PSParentPath, PSProvider, *Microsoft* | Format-List
    }
    # 用户级 HKCU
    if (-not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce")) { 
        Write-Host "没有发现用户级的一次性自启项`n"  -ForegroundColor Green
    }
    else {
        Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" `
        | Select-Object * -ExcludeProperty PSPath, PSChildName, PSDrive, PSParentPath, PSProvider, *Microsoft* | Format-List
    }

    Write-Host "### 检查设备安全性、近期升级补丁、定时任务项，已完成`n" -ForegroundColor Green
}

# 共享检查（包括：共享端口、共享文件）
function check_share {

    Write-Host " "
    Write-Host "### 检查主机主动共享安全概况（仅做基础性检测：默认端口、共享文件） ###`n" -ForegroundColor Cyan

    Write-Host "--- 检测防火墙是否开启（为了方便查看） ---"  -ForegroundColor Yellow
    Get-NetFirewallProfile | Select-Object Name, Enabled | Out-Host

    Write-Host "--- 检查主机访问局域网资源的smb 1.0功能是否开启 ---"  -ForegroundColor Yellow
    Get-WindowsOptionalFeature -Online | Where-Object FeatureName -eq "SMB1Protocol" | Out-Host

    Write-Host "--- 检查主机是否存在用smb共享文件给其他电脑 ---`n" -ForegroundColor Yellow

    # https://support.microsoft.com/zh-cn/windows/在-windows-中通过网络共享文件-b58704b2-f53a-4b82-7bc1-80f9994725bf
    Write-Host "SMB服务检测"
    Get-Service | Where-Object { $_.Name -match 'LanmanServer' } | Out-Host

    $result = Get-SmbShare | Select-Object Name, Path, Description
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "没有发现共享文件。`n" -ForegroundColor Green
    }

    Write-Host "--- 检查主机是否存在ftp共享服务 ---" -ForegroundColor Yellow
    # https://juejin.cn/s/windows查看ftp服务是否开启
    $result = Get-Service | Where-Object { $_.Name -match 'ftp' }
    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "`n没有发现主动的FTP服务。`n" -ForegroundColor Green
    }

    Write-Host "--- 远程桌面处于打开状态：0 打开，1 关闭 ---" -ForegroundColor Yellow
    Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" | Select-Object fDenyTSConnections | Out-Host

    # 远程桌面服务
    Get-Service | Where-Object { $_.Name -match 'TermService' } | Out-Host

    Write-Host "--- 检查一个月内是否发生可疑的远程桌面（RDP）登录行为 ---`n"  -ForegroundColor Yellow
    $result = Get-WinEvent -FilterHashtable @{
        LogName   = 'Security';
        ID        = 4624, 4625;
        StartTime = (Get-Date).Date.AddDays(-30);
        Message   = '*远程桌面*'
    } -ErrorAction SilentlyContinue
    if ($result) {
        $result | Out-GridView -Title "可疑的远程桌面（RDP）行为记录表"
    }
    else {
        Write-Host "近30天内未曾发生可疑的远程桌面登录行为。`n" -ForegroundColor Green
    }
    Write-Host "### 防御检查（包括：共享端口、共享文件），已完成`n" -ForegroundColor Green
}

# 事件查询
function check_key_events {
    
    Write-Host " "
    Write-Host "### 检查电脑休眠、开关机、程序崩溃等事件 ###`n" -ForegroundColor Cyan

    # 查看本地用户及用户组
    Write-Host "--- 查看本地用户状态 ---`n" -ForegroundColor Yellow
    localuser | Out-Host
    Get-LocalGroupMember -Group Administrators | Out-Host

    Write-Host "--- 检查密码未设置的本地用户 ---`n" -ForegroundColor Yellow
    Get-LocalUser | Where-Object { $null -eq $_.Password } | Select-Object Name | Out-Host

    # 新增：独立检查系统睡眠状态
    # 休眠与睡眠的区别：https://www.cnblogs.com/fatherofbeauty/p/16351107.html
    Write-Host "--- 检查是否开启睡眠功能。 （交流：接通电源；直流：用电池）---`n" -ForegroundColor Yellow
    Write-Host '注：如果是台式机、虚拟机可忽略“关闭或打开盖子功能”的信息内容' -ForegroundColor Green

    powercfg -q SCHEME_BALANCED SUB_SLEEP STANDBYIDLE; powercfg -q SCHEME_BALANCED SUB_BUTTONS | Out-Host

    Write-Host "--- 最近两周的重启频次 ---"  -ForegroundColor Yellow

    # 参考：[codeantenna - windows系统日志开关机、重启日志事件](https://codeantenna.com/a/QEcwIkyexa)
    # 当有多个ID描述一个词汇时，注意检查 Message 属性，对其的细微区分
    $result = Get-WinEvent -FilterHashtable @{
        LogName      = 'System'
        ProviderName = 'User32'
        Id           = 1074 
        StartTime    = (Get-Date).AddDays(-14)
    } 

    if ($result) {
        $result | Out-Host
        $sum = ($result | Measure-Object).Count
        Write-Host "重启总计:"$sum, "次；平均每天重启:"$([math]::Round($sum / 14, 2)),"次" -ForegroundColor Green

        # 计算每天的重启次数并找到最大值
        $dateCounts = @{}
        foreach ($event in $result) {
            # 转成字符串，只保留日期部分
            $date = $event.TimeCreated.ToShortDateString()
            # 如果日期已存在，次数加1，否则初始化为1
            if ($dateCounts.Contains($date)) {
                $dateCounts[$date] += 1
            }
            else {
                $dateCounts[$date] = 1
            }
        }
        # 找到最大值
        $maxDate = ($dateCounts.GetEnumerator() | Sort-Object -Property Value -Descending | Select-Object -First 1).Name
        $maxCount = $dateCounts[$maxDate]
        Write-Host "重启最多次数的日期: $maxDate, 以及该天重启次数: $maxCount" -ForegroundColor Cyan

    }
    else {
        Write-Host "没有找到最近14天的重启数据。"-ForegroundColor DarkRed
    }

    # 41 非正常开机，6008 异常关机
    Write-Host "`n--- 最近2周内是否存在非正常开机与异常关机 ---`n" -ForegroundColor Yellow
    $result = Get-WinEvent -FilterHashtable @{
        LogName   = 'System'
        Id        = 41, 6008
        StartTime = (Get-Date).AddDays(-14)
    } -ErrorAction SilentlyContinue

    if ($result) {
        # $result | Out-GridView -Title "最近2周内是否存在非正常开机与异常关机"
        $result | Out-Host
    }
    else {
        Write-Host "最近2周开关机操作，正常。`n" -ForegroundColor Green
    }

    Write-Host "--- 最近7天内是否存在蓝屏或崩溃现象 ---`n"  -ForegroundColor Yellow
    # https://social.microsoft.com/Forums/zh-CN/068ccdf2-96f4-484d-a5cb-df05f59e1959/win1020107202142659730475221202010720214id1000652921001?forum=window7betacn
    $result = Get-WinEvent -FilterHashtable @{
        LogName   = 'System'
        Id        = 1001 # 事件ID 1001对应多个LogName，而每个LogName对1001定位的级别，也各不相同。
        StartTime = (Get-Date).AddDays(-7)
    } -ErrorAction SilentlyContinue

    if ($result) {
        $result | Out-Host
    }
    else {
        Write-Host "近7天内未曾出现蓝屏或崩溃现象。`n" -ForegroundColor Green
    }

    Write-Host "--- 检查近期及当前时间段，是否有异常警告和错误事件 ---`n"  -ForegroundColor Yellow

    do {
        # 获取用户输入的日期和时间
        $dateTimeString = Read-Host "请输入日期和时间（格式为 yyyy-MM-dd HH:mm）"
    
        try {
            # 使用 Get-Date 尝试将字符串转换为日期时间对象
            $startTime = Get-Date $dateTimeString
            break
        }
        catch {
            # 如果转换失败，则提示用户重新输入
            Write-Host "输入的格式无效，请重新输入。" -ForegroundColor Yellow
        }
    } while ($true)
    
    # 构建筛选条件并获取异常事件
    $filter = @{
        LogName   = 'Application', 'System', 'Security'
        StartTime = $startTime
    }
    
    $events = Get-WinEvent -FilterHashtable $filter -ErrorAction SilentlyContinue `
    | Where-Object { $_.LevelDisplayName -in "错误", "警告", "关键" } 

    if ($events) {
        $events | Out-GridView -Title "近期及当前异常警告和错误事件分析表"
    }
    else {
        Write-Host "未找到任何异常事件。" -ForegroundColor Green
    }
    Write-Host "`n### 检查电脑休眠、开关机、程序崩溃等事件，已完成`n" -ForegroundColor Green
}
    
# 生成基线检查报表
function try_csv_xlsx {

    Write-Host " "
    Write-Host '### 生成"设备信息"、"事件汇总"、"活动记录"、"Windows defender威胁概况"分析报表 ###' -ForegroundColor Cyan; Write-Host " "

    # 检查 PowerShell 版本是否支持 ImportExcel 模块
    if ($PSVersionTable.PSVersion.Major -lt 5) {
        Write-Host "当前 PowerShell 版本不支持 ImportExcel 模块，请更新至 PowerShell 5 及以上版本。" -ForegroundColor Red
        return
    }

    # 尝试安装 ImportExcel 模块
    try {
        if (!(Get-Module -Name ImportExcel -ListAvailable)) { 
            Install-Module ImportExcel -Force 
        }
    }
    catch {
        Write-Host "安装 ImportExcel 模块失败，请确保所用网络处于正常联网状态：" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
        return
    }
    

    # 获取当前用户的桌面目录路径，比 ${env:username}/desktop 具有可移植性。
    $desktop_path = [Environment]::GetFolderPath('Desktop')
    $report_path = Join-Path $desktop_path ((Get-Date).ToString('yyyy-MM-dd') + '基线检查报表.xlsx')

    Write-Host "`n设备信息、当天警告事件，正在生成中，请耐心等待几分钟时间... `n" -ForegroundColor Yellow

    # 驱动信息
    #  -ErrorAction SilentlyContinue
    $result = Get-PnpDevice | Select-Object `
        Class, FriendlyName, Problem, `
        Status, ConfigManagerUserConfig, SystemName, `
        ClassGuid, Manufacturer, Present, Service

    if ($result) {
        $result | Export-Excel -Path $report_path -WorksheetName "载体驱动信息"
    }
    else {
        Write-Host '未查询到任何匹配信息，请检查账户权限、事件日志等设置问题。'
    }

    Write-Host "`n 驱动信息汇总已完成，正在生成截止目前的当天重要事件统计`n"

    # 事件ID，见：https://github.com/hoochanlon/ihs-simple/blob/main/BITRH/Win10_Events_ID_useful.xlsx
    $result = Get-WinEvent -FilterHashtable @{
        LogName   = 'Application', 'System', 'Security'
        StartTime = (Get-Date).Date
    } | Where-Object { $_.LevelDisplayName -in "错误", "警告", "关键"
    } | Select-Object Message, Id, Level, ProviderName, LogName, `
        TimeCreated, LevelDisplayName

    if ($result) {
        $result | Export-Excel -Path $report_path -WorksheetName '预警事件汇总'
    }
    else {
        Write-Host '未找到任何匹配条目，请检查系统权限、事件日志等设置问题。' -ForegroundColor Red
    }

    Write-Host "`n 追加：一周 logon/logoff 活动时间记录`n"
    
    $result = Get-WinEvent -FilterHashtable @{
        LogName   = 'Application', 'System', 'Security'
        StartTime = (Get-Date).AddDays(-7)
    } | Where-Object {
        ($_.Id -in 4648, 4634)
    } |Select-Object MachineName, Id, Level, ProviderName, LogName,  `
    TimeCreated, ContainerLog, LevelDisplayName, TaskDisplayName

    if ($result) {
        $result | Export-Excel -Path $report_path -WorksheetName "主机出录活动"
    }
    else {
        Write-Host '未找到任何匹配条目，请检查系统权限、事件日志等设置问题。' -ForegroundColor Red
    }

    # sqllite 结合 Get-MpThreatDetection 和 Get-MpThreat 才能得到理想数据。
    # 正好先用Excel来导入 Get-MpThreatDetection 与 Get-MpThreat 安全信息统计。
    
    # 最近 30 天内的威胁检测记录
    Write-Host '正在检测已存威胁，并生成相关月度的报告（如果没有，将不生成该项报表）' 
    
    $result = Get-MpThreatDetection `
    | Select-Object ActionSuccess, CurrentThreatExecutionStatusID, `
        DetectionID, DetectionSourceTypeID,	DomainUser,	InitialDetectionTime, LastThreatStatusChangeTime, `
        ProcessName, ThreatID, ThreatStatusID

    if ($result) {
        $result | Export-Excel -Path $report_path -WorksheetName "威胁记录检测"
    }
    else {
        Write-Host '未检测出威胁事件。可能原因：第三方杀软接管，或者未开启 Windows defender。' -ForegroundColor Magenta
    }           

    # 最近 30 天内的威胁类别
    $result = Get-MpThreat `
    | Select-Object CategoryID, DidThreatExecute, IsActive, RollupStatus, `
        SeverityID, ThreatID, ThreatName

    if ($result) {
        $result | Export-Excel -Path $report_path -WorksheetName "威胁类别详情"
    }
    else {
        Write-Host '未检测出威胁事件。可能原因：第三方杀软接管，或者未开启 Windows defender。' -ForegroundColor Magenta
    }    
    
    Write-Host " "
    Write-Host '### 基线检查报表已生成，请在桌面位置查阅。' -ForegroundColor Green; Write-Host "`n"

}


# switch
function select_option {

    # 使用说明
    sel_man

    $valid_option = $true
    $has_checked_sys = $false

    while ($valid_option) {
     
        # 虚拟按键code与对应键盘项参考
        # https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
        $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").VirtualKeyCode

        switch ($key) {
            { $_ -in 49, 97 } {
                # 数字键 1 和 数字键小键盘 1
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
                check_ip
            }
            { $_ -in 50, 98 } {
                # 数字键 2 和 数字键小键盘 2
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
                check_printer
            }
            { $_ -in 51, 99 } {
                # 数字键 3 和 数字键小键盘 3
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
                check_disk_cpu_mem
            }
            { $_ -in 52, 100 } {
                # 数字键 4 和 数字键小键盘 4
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
                check_fw
            }
            { $_ -in 53, 101 } {
                # 数字键 5 和 数字键小键盘 5
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
                check_share
            }
            { $_ -in 54, 102 } {
                # 数字键 6 和 数字键小键盘 6
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
                check_key_events
            }
            { $_ -in 55, 103 } {
                # 数字键 7 和 数字键小键盘 7
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
                check_ip
                check_printer
                check_fw
                check_disk_cpu_mem
                check_key_events
            }
            { $_ -in 56, 104 } {
                # 数字键 8 和 数字键小键盘 8
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
                try_csv_xlsx
            }
            { $_ -in 57, 105 } {
                # 数字键 9 和 数字键小键盘 9
                dev_man
                if (!$has_checked_sys) {
                    check_sys
                    $has_checked_sys = $true
                }
            }
            191 {
                # 键盘 /？
                # 远程调用
                # Invoke-Expression ((New-Object Net.WebClient).DownloadString($url));$function 
                sel_man
            }
            Default {
                # $valid_option = $false
                continue
            }
        }        
    }
}

select_option
