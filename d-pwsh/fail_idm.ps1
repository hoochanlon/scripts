# *************注册表信息说明******************

## HKLM：该根键包括本地计算机的系统信息，包括硬件和操作系统信息，安全数据和计算机专用的各类软件设置信息
## HKU：这些信息告诉系统当前用户使用的图标，激活的程序组，开始菜单的内容以及颜色，字体
## HkCU：该根键包括当前登录用户的配置信息，包括环境变量，个人程序以及桌面设置等
## HKCC: 硬件的配置信息
## 其实HKEY_LOCAL_MACHINE、 HKEY_USERS、这两个才是真正的注册表键，其他都是从某个分支映射出来的，相当于快捷键方式或是别名。

# 把能见着“Internet Download Manager”名的删除干净点。
# 从 reg del DownloadManager，感觉删除注册表也真是靠想象力，并不一定绝对正确
# 删除注册软件的信息，这部分看来是没猜对，还是有意类似暴力破解一样，全扫一遍。不过适合当例子

# reg delete "HKLM\Software\DownloadManager" /f 2> $null
# reg delete "HKU\.DEFAULT\Software\Download Manager" /f 2>$null 清除默认下载器设置
# reg delete "HKLM\SOFTWARE\Internet Download Manager" /f /reg:32 “/reg:32” 32位的软件项

# HKCU：该根键包括当前登录用户的配置信息，包括环境变量，个人程序以及桌面设置等（当前用户）

# reg delete "HKCU\Software\DownloadManager" /f /v "MData" 2> $null
# reg delete "HKCU\Software\DownloadManager" /f /v "LName" 2> $null
# reg delete "HKCU\Software\DownloadManager" /f /v "FName" 2> $null
# reg delete "HKCU\Software\DownloadManager" /f /v "Email" 2> $null
# reg delete "HKCU\Software\DownloadManager" /f /v "Serial" 2> $null

# 看字义大概是试用相关的清理了，删除扫描序列及验证试用内容信息

# reg delete "HKCU\Software\DownloadManager" /f /v "scansk" 2> $null
# reg delete "HKCU\Software\DownloadManager" /f /v "tvfrdt" 2> $null
# reg delete "HKCU\Software\DownloadManager" /f /v "radxcnt" 2> $null
# reg delete "HKCU\Software\DownloadManager" /f /v "ptrk_scdt" 2> $null

# 删除更新相关的信息（自检最新版、快速静默更新）

# reg delete "HKCU\Software\DownloadManager" /f /v "LstCheck" 2> $null
# reg delete "HKCU\Software\DownloadManager" /f /v "LastCheckQU" 2> $null
# reg delete "HKCU\Software\DownloadManager" /f /v "CheckUpdtVM" 2> $null
#
# HKU：这些信息告诉系统用户使用的图标，激活的程序组，开始菜单的内容以及颜色，字体等（所有用户）
# 这部分的具体应用是清除软件在系统上记录的激活信息与自检更新项目
# 获取主机sid
# $sid=whoami /user |Select-String -SimpleMatch "S-"|Write-Output
# reg delete "HKU\$sid\Software\DownloadManager" /f /v "MData"
# reg delete "HKU\$sid\Software\DownloadManager" /f /v "MData" 2> $null
#  其余代码同理。
#*********************************************

#****专列：CLSID Classes、Wow6432Node .DEFAULT，分项解读***

# 先得说下GUID\“全局唯一标示符”,在Windows系统中也称之为Class ID，缩写为CLSID。
# CLSID是一个128位的随机数，为了确保它的随机性，避免重复，它的算法主要是从两个方面入手：
## 1. 一部分数字来自于系统网卡的序列号，由于每一个网卡的MAC地址都不一样，因此产生的ID也就会有差异。
## 2. 另外一部分数字来自于系统的当前时间。
# Wow6432Node Wow32Node项是用于储存32位软件的注册信息用的。
# 如果是64位Windows 7系统，在里面我们可以看到电脑上安装的32位软件的注册表信息。

#******************************************

# ****注册表搜索工具：Registry Finder 系统环境：Windows11 Mac***
#               可找到注册值
# {07999AC3-058B-40BF-984F-69EB1E554CA7}
# {5312C54E-A385-46B7-B200-ABAF81B03935}
# {436D67E1-2FB3-4A6C-B3CD-FF8A41B0664D}
# {E6871B76-C3C8-44DD-B947-ABFFE144860D}
# {79873CC5-3951-43ED-BDF9-D8759474B6FD}

# 综合推测可能是用猎人模式卸载软件捕捉的classid，以及破解爱好者收集到的有关于idm classid
# 又或者是上一个版本的为了兼容。
# 有些classic 基本上都是二进制显示的数据，也没有说明。难，可能是为了留下注册信息吧....
# 未找到的class id
# {7B8E9164-324D-4A2E-A46D-0165FB2000EC}
# {5ED60779-4DE2-4E07-B862-974CA4FF2E9C}
# {6DDF00DB-1234-46EC-8356-27E7B2051192}
# {D5B91409-A8CA-4973-9A0B-59F713D25671}
# {9C9D53D4-A978-43FC-93E2-1C21B529E6D7}
# {E8CF4E59-B7A3-41F2-86C7-82B03334F22A}
# {84797876-C678-1780-A556-0CD06786780F}

#*******************************************
# 试验一：先添加激活信息再注册还是不行，失效
# 试验二：把原本搜不到的注册项先写进去，失效
# 试验三：增加其他杀进程项，hosts屏蔽无用，ip也没用
# 试验四：补上我认为“绿化.bat”冗余、重复、未优化的注册删除项目，成功

# 疑点，之前我的语法有误，字符串方面。
# 只留下，变量的注册信息看看。

# 试验五：未找到的class id注释、起先添加的信息注释掉，失效。
# 试验六：放行注释过的注册项目，重启软件失效，英文躺窗，可能国内代理没做验证服务器
# 试验七：添加防火墙，窗口弹出无效。
# 试验八: 逻辑阻断，取代弹窗文件。 "C:\Program Files (x86)\Internet Download Manager\IDMGrHlp.exe"

#**************编写注入激活序列到idm************

# 管它有没有，先杀光软件所有进程再说，屏蔽报错
taskkill /F /IM "IDM*" /T  2> $null
# taskkill /F /IM "IDMGrHlp.exe"  2> $null
# taskkill /F /IM "IEMonitor.exe"  2> $null
# taskkill /F /IM "IDMMsgHost.exe"  2> $null
# taskkill /F /IM "MediumILStart.exe"  2> $null
# taskkill /F /IM "MediumILStart.exe"  2> $null
# taskkill /F /IM "IDMIntegrator64.exe"  2> $null


# reg add "HKCU\Software\DownloadManager" /f /v "LName" /d "Inc." 2> $null    
# reg add "HKCU\Software\DownloadManager" /f /v "FName" /d "Tonec" 2> $null
# reg add "HKCU\Software\DownloadManager" /f /v "LstCheck" /d "19/01/38" 2> $null
# reg add "HKCU\Software\DownloadManager" /f /v "Email" /d "info@tonec.com" 2> $null
# reg add "HKCU\Software\DownloadManager" /f /v "Serial" /d "7WPV5-NHHF3-A2P39-LRJ74" 2> $null

# HKLM：该根键包括本地计算机的系统信息，包括硬件和操作系统信息，安全数据和计算机专用的各类软件设置信息
reg delete "HKLM\Software\DownloadManager" /f   2> $null
reg delete "HKLM\Software\Download Manager" /f    2> $null
reg delete "HKLM\Software\DownloadManager" /f /reg:32    2> $null
reg delete "HKLM\Software\Download Manager" /f /reg:32    2> $null
reg delete "HKLM\SOFTWARE\Internet Download Manager" /f    2> $null
reg delete "HKLM\SOFTWARE\Internet Download Manager" /f /reg:32    2> $null
reg delete "HKU\.DEFAULT\Software\DownloadManager" /f    2> $null
reg delete "HKU\.DEFAULT\Software\Download Manager" /f    2> $null
reg delete "HKU\.DEFAULT\Software\DownloadManager" /f /reg:32    2> $null
reg delete "HKU\.DEFAULT\Software\Download Manager" /f /reg:32    2> $null

## HkCU：该根键包括当前登录用户的配置信息，包括环境变量，个人程序以及桌面设置等
reg delete "HKCU\Software\DownloadManager" /f /v "MData"    2> $null
reg delete "HKCU\Software\DownloadManager" /f /v "LName"    2> $null
reg delete "HKCU\Software\DownloadManager" /f /v "FName"    2> $null
reg delete "HKCU\Software\DownloadManager" /f /v "Email"    2> $null
reg delete "HKCU\Software\DownloadManager" /f /v "Serial"    2> $null
reg delete "HKCU\Software\DownloadManager" /f /v "scansk"    2> $null
reg delete "HKCU\Software\DownloadManager" /f /v "tvfrdt"    2> $null
reg delete "HKCU\Software\DownloadManager" /f /v "radxcnt"    2> $null
reg delete "HKCU\Software\DownloadManager" /f /v "LstCheck"    2> $null
reg delete "HKCU\Software\DownloadManager" /f /v "ptrk_scdt"   2> $null
reg delete "HKCU\Software\DownloadManager" /f /v "LastCheckQU" 2> $null
reg delete "HKCU\Software\DownloadManager" /f /v "CheckUpdtVM" 2> $null


$sid=whoami /user| Select-String -SimpleMatch "-S"|Write-Output

reg delete "HKU\$sid\Software\DownloadManager" /f /v "MData" 2> $null
reg delete "HKU\$sid\Software\DownloadManager" /f /v "LName" 2> $null
reg delete "HKU\$sid\Software\DownloadManager" /f /v "FName" 2> $null
reg delete "HKU\$sid\Software\DownloadManager" /f /v "Email" 2> $null
reg delete "HKU\$sid\Software\DownloadManager" /f /v "Serial" 2> $null
reg delete "HKU\$sid\Software\DownloadManager" /f /v "scansk" 2> $null
reg delete "HKU\$sid\Software\DownloadManager" /f /v "tvfrdt" 2> $null
reg delete "HKU\$sid\Software\DownloadManager" /f /v "radxcnt" 2> $null
reg delete "HKU\$sid\Software\DownloadManager" /f /v "LstCheck" 2> $null
reg delete "HKU\$sid\Software\DownloadManager" /f /v "ptrk_scdt" 2> $null
reg delete "HKU\$sid\Software\DownloadManager" /f /v "LastCheckQU" 2> $null
reg delete "HKU\$sid\Software\DownloadManager" /f /v "CheckUpdtVM" 2> $null


# 写个函数来删除这些多余的注册class id
function Idm-Reg-Del 
{
reg delete "HKEY_CURRENT_USER\Software\Classes\Wow6432Node\CLSID\$idm_classid" /f 2> $null
reg delete "HKEY_LOCAL_MACHINE\Software\Classes\Wow6432Node\CLSID\$idm_classid" /f 2> $null
reg delete "HKEY_USERS\.DEFAULT\Software\Classes\CLSID\$idm_classid" /f 2> $null
reg delete "HKEY_USERS\.DEFAULT\Software\Classes\Wow6432Node\CLSID\$idm_classid" /f 2> $null
}

$idm_classid="{07999AC3-058B-40BF-984F-69EB1E554CA7}";Idm-Reg-Del 
$idm_classid="{5312C54E-A385-46B7-B200-ABAF81B03935}";Idm-Reg-Del
$idm_classid="{436D67E1-2FB3-4A6C-B3CD-FF8A41B0664D}";Idm-Reg-Del
$idm_classid="{E6871B76-C3C8-44DD-B947-ABFFE144860D}";Idm-Reg-Del
$idm_classid="{79873CC5-3951-43ED-BDF9-D8759474B6FD}";Idm-Reg-Del

$idm_classid="{7B8E9164-324D-4A2E-A46D-0165FB2000EC}";Idm-Reg-Del
$idm_classid="{5ED60779-4DE2-4E07-B862-974CA4FF2E9C}";Idm-Reg-Del
$idm_classid="{6DDF00DB-1234-46EC-8356-27E7B2051192}";Idm-Reg-Del
$idm_classid="{D5B91409-A8CA-4973-9A0B-59F713D25671}";Idm-Reg-Del
$idm_classid="{9C9D53D4-A978-43FC-93E2-1C21B529E6D7";Idm-Reg-Del
$idm_classid="{E8CF4E59-B7A3-41F2-86C7-82B03334F22A}";Idm-Reg-Del
$idm_classid="{84797876-C678-1780-A556-0CD06786780F}";Idm-Reg-Del

# Write-Output "断网，并写入注册信息。"
# netsh interface set interface "以太网" disabled 
# Start-Sleep -s 3

# 开始写入注册信息
# 经测试，网上的绿化代码虽然不简洁，大量重复，但有效！我这个一旦被识别后就只能先卸载软件啦。
#（先添加注册信息，删除后，再添加；我想是不是为了清理软件激活之后所生成新的注册信息，否则真是没必要）
reg add "HKCU\Software\DownloadManager" /f /v "LName" /d "Inc." 2> $null    
reg add "HKCU\Software\DownloadManager" /f /v "FName" /d "Tonec" 2> $null
reg add "HKCU\Software\DownloadManager" /f /v "LstCheck" /d "19/01/38" 2> $null
reg add "HKCU\Software\DownloadManager" /f /v "Email" /d "info@tonec.com" 2> $null
reg add "HKCU\Software\DownloadManager" /f /v "Serial" /d "7WPV5-NHHF3-A2P39-LRJ74" 2> $null


# ban ip
# netsh advfirewall firewall add rule name="屏蔽IDM验证审核IP地址" dir=out  action=block enable=yes profile=any localip=any remoteip="169.55.0.227","169.55.0.224","50.22.78.28","50.97.82.44","69.41.163.149","174.127.73.85" interfacetype=any
# ban 验证激活程序
netsh advfirewall firewall add rule name="测试-屏蔽IDM验证程序" dir=out program="C:\Program Files (x86)\Internet Download Manager\IDMGrHlp.exe" action=block

Remove-Item -Path "C:\Program Files (x86)\Internet Download Manager\IDMGrHlp.exe" -Recurse -Force
New-Item "C:\Program Files (x86)\Internet Download Manager\IDMGrHlp.exe"  -type file  -force


# Write-Output "
# 127.0.0.1 *.registeridm.com
# 127.0.0.1 *.tonec.com
# 127.0.0.1 *register.internetdownloadmanager.com
# 127.0.0.1 *register.idm.com
# 127.0.0.1 *reg.idm.com
# 127.0.0.1 reg.internetdownloadmanager.com
# " >> C:\Windows\System32\drivers\etc\hosts


# Write-Output "开启网络，并屏蔽idm联网验证。"
# netsh interface set interface "以太网" enable

Write-Output "已注入序列号等许可信息离线激活，测试。"





#*******参考************

# 批处理

# [csdn-CMD 命令换行](https://blog.csdn.net/xiaoruofan/article/details/126263734)
# [如何在Windows10中使用PowerShell阻止IP或网站](https://www.xiaoyuanjiu.com/100298.html)
# [三行代码-阻止某些公共/外部ip地址连接到internet(从批处理文件、windows、防火墙)](http://ask.sov5.cn/q/A2ohMJN7dq) 
# [利用防火墙规则阻止idm验证](https://blog.csdn.net/q412717840/article/details/109743287)
# [cnblogs-IDM HOSTS本地注册 屏蔽的网址](https://www.cnblogs.com/Magiclala/p/16111334.html)
# [souhu-屏蔽IDM发现新版本提示的方法](https://www.sohu.com/a/132104086_612933)
# [cnblogs-用批处理获取系统中当前账户的SID](https://www.cnblogs.com/GuominQiu/articles/1871063.html)
# [cnblogs-wmic 命令用法及实例](https://jiuaidu.com/jianzhan/908099/)
# [qa.1r1g-执行命令时如何忽略PowerShell中的特定错误？](https://qa.1r1g.com/sf/ask/3818470141/)

# 注册表

# [csdn-关于RegDeleteKey无法删除注册表项](https://blog.csdn.net/yiyefangzhou24/article/details/6134536)
# [csdn-注册表：HKCR, HKCU, HKLM, HKU, HKCC，注册表中常用的5种数据类型](https://blog.csdn.net/up_upup/article/details/108679443)
# [cnblogs-应急响应-Windows各种操作记录备份](https://www.cnblogs.com/autopwn/p/15701716.html)
# [cnblogs—安装时填写注册表](https://www.cnblogs.com/Leo_wl/archive/2012/10/19/2731740.html)
# [摘编百科-clsid](https://www.zhaibian.com/baike/26933812114132084113.html)
# [北海亭-Win7注册表里面Wow6432Node是什么?](https://www.beihaiting.com/a/ZSK/JZS/2013/0410/1869.html)

# 字符串处理
# [csdn-for /f命令之—Delims和Tokens用法&总结](https://blog.csdn.net/kagurawill/article/details/114982328)
# [百度知道-执行DOS命令，报错说此时不应有%%a,求高手帮忙解决！](https://zhidao.baidu.com/question/1548324309453385987.html)
# [cnblogs-批处理中的变量和参数（一）](https://www.cnblogs.com/siwuxie095/p/6351210.html)
# [cnblogs-Powershell ——findstr](https://www.cnblogs.com/thescentedpath/p/findstr.html)
# [csdn-powershell 文件/文件夹操作](https://blog.csdn.net/winterye12/article/details/105918774)

# 草稿

# netsh advfirewall firewall add rule name="测试-屏蔽IDM主程序" dir=out program="C:\Program Files (x86)\Internet Download Manager\IDMan.exe" action=block
# netsh advfirewall firewall del rule name="测试-屏蔽IDM主程序"

# netsh interface set interface "以太网" disabled 
# netsh advfirewall firewall add rule name="测试-屏蔽IDM验证程序" dir=out program="C:\Program Files (x86)\Internet Download Manager\IDMGrHlp.exe" action=block
# netsh advfirewall firewall add rule name="屏蔽IDM验证审核IP地址" dir=out  action=block enable=yes profile=any localip=any remoteip="169.55.0.227","169.55.0.224","50.22.78.28","50.97.82.44","69.41.163.149","174.echo 127.73.85" interfacetype=any

#  屏蔽其特定验证服务器域名，双管齐下，减小因更换其他域名就失效的几率。
# echo 127.0.0.1 *.registeridm.com >> C:\Windows\System32\drivers\etc\hosts

# 窗口调试用 %i；%%i 批处理文件用。
# 获取主机上的SID:：wmic userAccount where "Name='%userName%'" get sid /value
# “For /f”常用来解析文本，读取字符串， delims负责切分字符串，而tokens负责提取字符串，此时在输出sid变量就成纯的sid序列了

# for循环遍历，这批处理还不支持数组，变量嵌套尝试了会，不太行，难搞
# 把这重复性的代码包装成函数。也没有...goto吧。初始化classid，并用goto包装。
# 已换成powershell
