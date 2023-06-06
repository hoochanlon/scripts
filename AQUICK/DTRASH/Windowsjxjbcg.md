##  Windows基线脚本

### 内存条

```powershell
Get-WmiObject -Class Win32_PhysicalMemory | Select-Object -Property BankLabel, Capacity, DeviceLocator, PartNumber, SerialNumber, Speed
```

在大多数情况下，DDR4 内存的时钟速度（即频率）会更高，通常在 2133 MHz 至 4800 MHz 之间，而 DDR3 的时钟速度范围为 800 MHz 至 2133 MHz，因此也可以通过查看内存的时钟速度来确定其类型。

### 验证驱动安装

### 初期探寻

第一种通过hash算法数值验证，`(Get-FileHash $driverPath -Algorithm SHA256).Hash`但很粗略。第二种[csdn - 2019-8-30-PowerShell-通过-WMI-获取系统安装的驱动](https://blog.csdn.net/lindexi_gd/article/details/103184934) 检测status的值是否OK。

```powershell
# 查看所有
Get-WmiObject Win32_SystemDriver | Format-List Caption,Status
# 筛选出非OK的
Get-WmiObject Win32_SystemDriver | Where-Object { $_.Status -ne "OK" } | Format-List Caption,Status
```

### 中后期

PnpDevice是Windows操作系统中表示PnP设备的一个对象，它包含了有关设备的大量信息，比如设备的硬件ID、驱动程序文件名、驱动程序状态等等。

判断驱动是否正常可以通过判断PnpDevice对象的状态信息来实现。例如，如果PnpDevice对象的DriverName属性值为NULL，或者设备状态为Error，则表明该设备的驱动程序可能没有正确安装或者配置错误。

此外，PnpDevice对象还包含许多其他信息，比如设备的资源分配情况、设备节点名称、设备类型等等，这些信息也可以用于判断驱动是否正常。例如，如果某个设备节点下面没有任何子节点，则说明该设备的驱动程序可能存在异常。因此，使用PnpDevice对象来判断驱动是否正常是一种有效的方法。


### 睡眠模式

绕弯：休眠与睡眠的区别，[cnblogs - 电脑睡眠（sleep）和休眠（Hibernate）的区别，以及休眠功能的设置](https://www.cnblogs.com/fatherofbeauty/p/16351107.html)。

```powershell
# 休眠功能是否开启，最后一次启动时间
Get-CimInstance win32_operatingsystem | 
        Select-Object   @{label="HibernateEnabled";Expression={$_.HibernateEnabled}}, 
                        @{label="LastBootUpTime";Expression={$_.LastBootUpTime}}| Out-Host
```

正轨：`Get-CimInstance -namespace "root\cimv2\power" -ClassName Win32_PowerPlan`只能看基础电源“平衡”、“高性能”策略是否开启，而不能进一步细化粒度。 

中途了解[csdn - WMI的讲解(是什么，做什么，为什么)](https://blog.csdn.net/Ping_Pig/article/details/119446154)

### 其他

**选项**

虚拟键盘接收用户按键，code对应键盘数值参考：https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

### 系统时间

**通过 6005 、6006 来知晓系统唤醒频次并不精确**

```
2023/5/31 10:39:54    6005 事件日志服务已启动。
2023/5/31 10:39:45    6006 事件日志服务已停止。
2023/5/31 10:36:52    6005 事件日志服务已启动。
2023/5/31 10:36:39    6006 事件日志服务已停止。
2023/5/31 8:51:20     6005 事件日志服务已启动。
2023/5/31 8:51:12     6006 事件日志服务已停止。
2023/5/31 7:26:26     6005 事件日志服务已启动。
```

自己在测试机上一直做着测试，该时间段并未唤醒或重启过系统，因此通过事件ID：6005、6006来判断系统重启或唤醒频次并不准。powershell统计事件6005和6006，以及557似乎并不能精确获取到开关机时间。

这表明系统时间是使用 UTC (世界协调时间) 格式记录的，而 `TimeCreated` 属性则是将 UTC 时间转换为本地时间。UTC 时间与本地时间之间的差异取决于系统所在地区的时区设置。

在您提供的示例中，系统启动时的 UTC 时间是 2023 年 6 月 5 日早上 2:33:57.378748400 UTC。这个时间戳代表了从 1970 年 1 月 1 日午夜 UTC 开始的秒数或毫秒数。Windows 会将其转换为本地时间，即 2023 年 6 月 5 日上午 10:33:58（假设您所在的时区为 UTC+8）。

因此，`TimeCreated` 属性显示的时间是系统启动时的本地时间。

**regsvr32**

因此，regsvr32 和 sfc /scannow 命令是用于不同的目的。前者用于注册 DLL 文件，后者用于检查和修复受保护的 Windows 系统文件。虽然它们都可以解决某些问题，但是它们并不相同，而且执行起来也不同。

**DISM**

`DISM /Online /Cleanup-Image /RestoreHealth`  命令不会导致任何文件丢失，该命令主要旨在检查和修复 Windows 系统文件的完整性，并从 Windows 更新服务器下载缺失或损坏的文件。它会在 Windows 映像文件中进行扫描和修复操作，但不会影响您现有的个人文件或程序。

**系统映像**

系统映像（System Image）和系统镜像（System Clone）是两个不同的概念。

系统映像是指捕获完整的操作系统配置和状态，包括操作系统、外部程序、配置文件、用户数据和设置等。它实际上是一个完整的备份，可以用来还原到之前的系统状态。系统映像通常包含所有系统驱动程序和 OS 补丁，以便在还原后无需重新安装它们。

与此不同，系统镜像是指将系统驱动器完全复制到另一个驱动器中，以便在需要时可以立即启动该系统。简单来说，系统克隆是将一个完全相同的副本创建到另一个位置或目标磁盘中。

系统映像通常用于备份和还原整个系统的目的，而系统镜像则用于在多台计算机或在更换硬盘后部署新设备的目的。另外，创建系统映像通常需要使用系统备份和还原工具，如 Windows Backup and Restore，而创建系统镜像通常需要使用磁盘镜像软件，如 Acronis True Image 或 Norton Ghost。

总之，系统映像指的是捕获整个操作系统、配置文件和用户数据的备份，而系统镜像指的是将整个系统驱动器复制到另一个驱动器，以便进行快速部署。


### 选特定的事件 ID

* [舆情采集系统 - WINDOWS日志事件ID速查表](https://www.axtx.net/archives/1043.html)
* [learn.microsoft -  4624 (S) ：帐户已成功登录](https://learn.microsoft.com/zh-cn/windows/security/threat-protection/auditing/event-4624)
* [csdn - Windows事件ID大全](https://blog.csdn.net/bcbobo21cn/article/details/129610017)
* [Windows server- 附录 L：事件监视器](https://learn.microsoft.com/zh-cn/windows-server/identity/ad-ds/plan/appendix-l--events-to-monitor)
* [奇安信攻防社区 - Windows日志总结](https://forum.butian.net/share/355)
* [learn.microsoft - 事件識別碼 41 的進階疑難排解：「系統已重新開機，但未先完全關閉」](https://learn.microsoft.com/zh-tw/troubleshoot/windows-client/performance/event-id-41-restart)

```
Get-WinEvent -LogName System | Where-Object {$_.Id -eq 42}
```

可以通过以下PowerShell命令查看最近七天的异常开关机事件：

```
Get-EventLog System -After (Get-Date).AddDays(-7) | Where-Object {$_.EventID -eq '1074' -or $_.EventID -eq '6008'} | Format-Table TimeGenerated, EventID, Message -AutoSize
```

55 指定的网络资源或设备不再可用、1393*磁盘*结构*损坏*且无法读取。


events level查询：https://learn.microsoft.com/zh-cn/powershell/scripting/samples/creating-get-winevent-queries-with-filterhashtable?view=powershell-7.3


### 日志专题

Windows 的系统日志是用于记录操作系统级别事件和错误的一种日志类型。它包括了许多不同的事件提供程序，每个事件提供程序都有唯一的 "ProviderName" 标识符。以下是 Windows 系统日志中 ProviderName 常见的一些示例：

- Microsoft-Windows-Kernel-Power：提供了与系统电源管理相关的事件，例如系统挂起、恢复、关机、重启等。
- Microsoft-Windows-Kernel-General：提供了与操作系统内核相关的事件，例如启动或关闭操作系统、内核初始化、驱动程序加载等。
- Microsoft-Windows-Wininit：提供了与系统引导和初始化相关的事件，例如启动初始化进程、检查文件系统、加载系统驱动程序等。
- Microsoft-Windows-Security-Auditing：提供了与安全审计和审核相关的事件，例如用户登陆、权限更改、文件和对象访问等。
- Microsoft-Windows-DistributedCOM：提供了与分布式应用程序相关的事件，例如分布式COM调用的失败、权限问题、RPC服务器无法使用等。
-  Microsoft-Windows-DNS-Client：服务负责将域名解析为相应的 IP 地址，并将其缓存以提高性能。

### 事件ID与LogName

事件 ID 1001 可能对应于不同的 "LogName"。它通常用于表示 “Windows Error Reporting Service”（WER）已将信息记录到 Windows 系统事件日志中。

当某个应用程序或进程在 Windows 操作系统中崩溃时，WER 将自动记录相关的错误信息，例如异常类型、错误代码、应用程序名称等。这些信息通常会被记录到不同的 Windows 事件日志中，包括 Application、System 和 Security 日志。因此，您可能会在这些日志中找到与事件 ID 1001 相关的条目。

只检查单个日志，有些事件可能会跨越多个日志和多个事件 ID，可能会错过一些重要的信息。因此，请根据具体情况进行分析，以了解特定事件的详细信息。

根据您提供的信息，这条事件的级别是 4，即“信息”级别。虽然这条事件包含了一些关键的信息（例如密钥管理服务的地址、激活请求的 ID 等等），但从整体上看，它更多地是一条记录性质的事件，不会对系统的安全和稳定性造成影响，因此被归类为“信息”级别。

需要注意的是，事件级别并没有固定的定义，具体的划分标准可以根据实际情况而有所不同。在不同的 Windows 组件、应用程序或者操作系统版本中，同样的事件可能被赋予不同的级别。因此，在分析事件日志时，我们需要结合具体的背景和含义，来判断一个事件的级别是否适当。

信息方面大部分都是有关用户登录、特权提升、系统激活，警告很多都是时间同步方面的东西。

