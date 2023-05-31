## 关闭Windows defender实时保护方案验证

## 代码验证测试

### 禁止实时保护bat

如下指令是基于[v2ex - 如何永久关闭 Win10 的 defender 的实时保护](https://v2ex.com/t/712755)帖子 kokutou 提及到注册表，按他的思路做的batch移植。

```
@REM 如果启用此策略设置，则 Windows Defender 不会运行，不扫描计算机是否有恶意软件或其他可能不需要的软件。Enabled Value 1；Disabled Value 0。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f

@REM 如果启用此策略设置，Microsoft Defender 防病毒将不会提示用户对检测到的恶意软件采取操作。
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f
```

第一条指令可参考 [admx.help - 关闭 Windows Defender](https://admx.help/?Category=Windows_8.1_2012R2&Policy=Microsoft.Policies.WindowsDefender::DisableAntiSpyware&Language=zh-cn) 对“DisableAntiSpyware”参数说明。其中官方对此的部分解释：“如果启用此策略设置，则 Windows Defender 不会运行，不扫描计算机是否有恶意软件或其他可能不需要的软件。” 这么说来，Windows defender与“实时保护”形成一种你中有我，我中有你的间性关系了。

第二条指令参考 [admx.help - 关闭实时保护](https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsDefender::DisableRealtimeMonitoring&Language=zh-cn) 参考说明，整体没多大难度。不过，kokukou对此的表述：“这2个注册表对应 2 条组策略，而且似乎其实好像其实第一条就够了，和以前一样, 没啥变化，就是要先关掉篡改保护。” 很值得做一番验证实验。

上述代码以管理员权限执行后，再点击关闭“篡改防护”按钮，几秒不等左右，“实时保护”也会随着“篡改防护”进入关闭状态，并且按钮呈灰色。我们通过`Get-MpComputerStatus` 获取 Windows Defender 的状态：

“RealTimeProtectionEnabled	:False”，表示实时保护以出于关闭状态，未启用。

![](https://s2.xptou.com/2023/05/31/6476a56516a94.png)

### 再次启用实时保护bat

将此前的1，改为0值。

```
@REM 如果启用此策略设置，则 Windows Defender 不会运行，不扫描计算机是否有恶意软件或其他可能不需要的软件。Enabled Value 1；Disabled Value 0。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 0 /f

@REM 如果启用此策略设置，Microsoft Defender 防病毒将不会提示用户对检测到的恶意软件采取操作。
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 0 /f
```

我们从中可以发现当前的实时保护只能暂时性的关闭。

![](https://s2.xptou.com/2023/05/31/6476a56af2ac7.png)

![](https://s2.xptou.com/2023/05/31/6476a5a6d407e.png)

而使用 reg delete 则是又回到我们熟悉的当初状态

```
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f

REG delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /f

pause
```

![](https://s2.xptou.com/2023/05/31/6476a645e5114.png)

![](https://s2.xptou.com/2023/05/31/6476a4edb8b65.png)

### “DisableAntiSpyware”、“DisableRealtimeMonitoring”单条逻辑独立测试对比

一、***DisableAntiSpyware***

```
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
```

第一次未关闭篡改保护，执行后效果

![](https://s2.xptou.com/2023/05/31/6476a6d1e5020.png)

关闭“篡改防护”执行效果

![](https://s2.xptou.com/2023/05/31/6476a6fc8ee5d.png)

2023.5.31 8:57 补充验证资料：

![](https://s2.xptou.com/2023/05/31/6476a7178676f.png)

但重启后，两者别无二致。

![](https://s2.xptou.com/2023/05/31/6476a4edb8b65.png)

实验结论：不管有没有关闭“篡改防护”，只针对 DisableAntiSpyware 进行策略改动，不可行。

二、***DisableRealtimeMonitoring***

```
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f
```

实验结论：不管有没有关闭“篡改防护”，执行该条代码都不影响。

![](https://s2.xptou.com/2023/05/31/6476a77e7d18e.png)

效果差异对比，注意“篡改防护”与“实时保护”状态。

![](https://s2.xptou.com/2023/05/31/6476a808ca557.png)

![](https://s2.xptou.com/2023/05/31/6476a855bc61a.png)

扔入激活工具测试，发现激活工具正常运行，未被拦截或直接干掉。

![](https://s2.xptou.com/2023/05/31/6476a86a89c64.png)

## 代码测试总结

1. **DisableAntiSpyware：如果启用此策略设置，则 Windows Defender 不会运行，不扫描计算机是否有恶意软件或其他可能不需要的软件。** 
2. **DisableRealtimeMonitoring：如果启用此策略设置，Microsoft Defender 防病毒将不会提示用户对检测到的恶意软件采取操作。** （我的理解是“知道，但不作为”，“睁一只眼闭眼”。）

“DisableAntiSpyware：如果启用此策略设置，则 Windows Defender 不会运行，不扫描计算机是否有恶意软件或其他可能不需要的软件。” 这句话从平时理解上来看，按理说只要关闭了杀软就行了。但这会与我们通过 `Get-MpComputerStatus` 得到的“实时保护”的结果 "RealTimeProtectionEnabled : True" 产生悖论。

所以我认定“实时保护”处于开启状态，Windows defender依旧会照常检测，通过“2023.5.31 8:57 补充验证资料”，已证实。这种关系，可类比为CSS元素子父级样式的优先级，越小级别的元素，设置样式生效优先级越高。

### 代码调优

新增选项开关，一步到位。

```
@echo off
:: 见：https://bbs.huaweicloud.com/blogs/396537
:: "C:\Program Files (x86)\NSudo_8.2_All_Components\NSudo Launcher\x64\NSudoLG.exe" -U:T cmd /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features" /v "TamperProtection" /d 0 /t REG_DWORD /f""

:: 自动管理员权限运行以下代码
%1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit & cd /d "%~dp0"

:: color 9

cls
echo 请选择操作：
echo/
echo [1] 禁用实时防护
echo [2] 启用实时防护
echo/
choice /c 12 /n /m "请输入选项（1或2）："
echo/
if errorlevel 2 (
    REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /f 2>nul 1>nul
    echo 启用实时防护，OK！
    echo/
    ) else (
        REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f 1>nul
        echo 禁用实时防护，已OK！
        echo 在Windows defender点击关闭“篡改防护”即可关闭永久性关闭实时保护。
        echo 也可在需要时，自行手动开启“篡改防护”以长期打开实时保护功能。
        echo/
    )
pause
```

代码调优的执行效果

![](https://s2.xptou.com/2023/05/31/6476b67ad1c48.png)

![](https://s2.xptou.com/2023/05/31/6476b68335eab.png)

在线测试

```
curl -OfsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-bat/choice_wdrt.bat&&call choice_wdrt.bat
```

![](https://s2.xptou.com/2023/05/31/6476bd0defa05.png)

## 附录：整体探索过程

### 查阅官方及第三方资料整合

推敲点：

1. [csdn - Win10如何彻底关闭实时保护（第二种才有效）](https://blog.csdn.net/azxc98765/article/details/120094030), 在这基础上转换成批处理，为往后的维护及资料查找上，是要方便很多的。
2. 基于第一点而找到的 [v2ex - 如何永久关闭 Win10 的 defender 的实时保护](https://v2ex.com/t/712755)
3. 有关于一些文章提到配置Windows defender有关的组策略不管用，我怀疑或许与这有关吧，[admx.help - 配置本地设置替换以关闭入侵防护系统](https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsDefender::RealtimeProtection_LocalSettingOverrideDisableIntrusionPreventionSystem&Language=zh-cn)
4. 自己依照admx.help提供的“实时保护”注册表数据所写的批处理，就“实时保护没效果”来说，我与大家是相差无几的处理境况。有必要在参考第三方资料的同时，做额外的差异比较。

一些绕弯的参考项：

1. [Access Denied - Setting Owner and/or Permissions on Registry Key](https://answers.microsoft.com/en-us/windows/forum/all/access-denied-setting-owner-andor-permissions-on/71cdd66a-75ce-4e79-bace-89637e0dacae?messageId=e5059fad-18c9-4b97-b7a5-cedcf48b083a&page=3)（后来用NSudoLG提权工具了）
2. [Automatic Sample Submission Turns off? Here’s How to Fix It! [MiniTool Tips]](https://www.minitool.com/news/automatic-sample-submission-off.html)（文章不错，但我的重心是在“实时防护”问题上）

后续参考储备：

* [csdn - Windows 退域后仍出现‘此设置由管理员进行管理‘的问题](https://blog.csdn.net/geekqian/article/details/90608482)
* [freebuf - 花式沉默Defender](https://www.freebuf.com/articles/network/324952.html)

### Tamper Protection

从 [bbs.huaweicloud - 红蓝对抗之致盲 Windows defender](https://bbs.huaweicloud.com/blogs/396537)（2022.11.21）了解到使用[NSudoLG](https://github.com/M2Team/NSudo)这类权限提升工具来获取注册表关键项的权限，从而操作该项整个注册表的所有内容。在此基础上，经过我简单的提权及写入篡改保护注册项发现：Windows defender 的篡改保护项值是具有“自主调节性”的；当你将“HKLM\SOFTWARE\Microsoft\Windows Defender\Features”的“TamperProtection”键改为"0x4"时，再开关篡改保护按钮，该键又会回到默认值“0x5”。

“TamperProtection”键写入，参考如下：

> 【来源】https://www.wintips.org/how-to-disable-tamper-protection-security-on-windows-10/

> **4.** In the Edit DWORD window that opens:*
>
> - To **Disable Tamper Protection**, set the value data to **0** and click on the **OK** button.*
> - To **Enable Tamper Protection**, set the value to **5** and click **OK. \***

> \* Note: If after pressing OK, you receive the error: "*Error Editing Value. Cannot edit TamperProtection. Error writing the value's new contents*.", proceed below to take the ownership of the "Features" registry key and then repeat the above step.

翻阅相关此前资料来看，不少文章均未提及对“TamperProtection”键值修改出现的有关异样情况，我推测是微软又加强了一道安全等级防护，防止注册表、代码等方式直接干预Windows defender的主要安全监测审核程序，造成破坏性的安全性事件影响。

后续在看了 [unSafe.sh - 当前Defender AV 防篡改的局限及功能测试](https://buaq.net/go-103627.html) 对“篡改保护”详细介绍及注册表捕捉事件说明，也证实我上述的想法所推测的那样，“篡改保护”在Windows defender安全防护处于内核级定位。

![](https://s2.xptou.com/2023/05/31/6476a89432477.png)

