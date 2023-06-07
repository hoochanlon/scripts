# 查阅指导建议与开发说明
function jixian_yuanc_man {

    Write-Host "`n"
    Write-Host "`n### 远程调用Windows基线脚本开发说明 ###`n" -ForegroundColor Cyan

    Write-Host "`n该部分为调用PS1函数测试，以首张猫图以示区分。`n" -ForegroundColor DarkCyan

    Write-Host @"
                    *                  *
                        __                *
                    ,db'    *     *
                    ,d8/       *        *    *
                    888
                    `db\       *     *
                    `o`_                    **
                *               *   *    _      *
                        *                 / )
                    *    (\__/) *       ( (  *
                ,-.,-.,)    (.,-.,-.,-.) ).,-.,-.
                | @|  ={      }= | @|  / / | @|o |
                _j__j__j_)     `-------/ /__j__j__j_
                ________(               /___________
                |  | @| \              || o|O | @|
                |o |  |,'\       ,   ,'"|  |  |  |  hjw
                vV\|/vV|`-'\  ,---\   | \Vv\hjwVv\//v
                            _) )    `. \ /
                        (__/       ) )
                                    (_/
"@ -ForegroundColor DarkYellow


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

    Write-Host "`n#其他·共享补充说明 `n" -ForegroundColor Cyan

    Write-Host "`n 有别于端口流量监测分析，这个共享服务检测主要针对于局域网企业非信息质量部、开发应用部同事的主机检测，因此也较容易察觉出其主机的可疑性。`n" -ForegroundColor Yellow
    Write-Host '另外，http相比于SMB、FTP更为繁琐复杂，比较"专业化"，由于面向受众的不同，故不纳入检测范围。' -ForegroundColor Yellow;Write-Host "`nSMB列表概要："
    Write-Host '1. ADMIN$ 表示 Windows 操作系统的安装目录（通常为C:\Windows）的共享目录。该共享只有管理员帐户才能访问，用于进行远程管理操作。'
    Write-Host '2. C$ 表示整个系统驱动器（通常为 C:\）的共享目录。该共享允许拥有管理员权限的用户通过网络进行对系统根目录的访问。'
    Write-Host '3. IPC$ 共享可能被滥用的原因是，它是一个特殊的共享，允许用户在不需要进行身份验证的情况下建立连接。'
    Write-Host ' 3.1 这意味着攻击者可以使用一些工具和技术（如端口扫描、远程桌面连接等）来访问 IPC$ 共享，并尝试利用系统漏洞进行攻击。'
    Write-Host ' 3.2 禁用IPC可能会对其他服务产生负面影响，如：文件共享、AD活动目录、远程管理工具、系统备份和还原。'

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

}