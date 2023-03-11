看到福利区 [分享两个EmEditor 终身授权激活码(出处: 吾爱破解论坛)](https://www.52pojie.cn/thread-1756848-1-1.html)，我是觉得下载文件在去查看太麻烦了，直接发个curl请求过去把序列号拷贝到粘贴版，过去复制到程序就完事了，为防“君子”简单做了下混淆base64编码，所以顺便看点资料，随手写了个玩具代码，这个没什么技巧性可言的，故作讨论贴。

下面powershell一键搞定。

```powershell
irm https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-pwsh/emeditor_random_keygen.ps1|iex 
```

git仓：https://github.com/hoochanlon/ihs-simple/blob/main/d-pwsh/emeditor_random_keygen.ps1  附源码：

```powershell
# 发现一个升级的aiu文件，删不删随喜吧，"C:\ProgramData\Emurasoft\EmEditor\updates\emed64_updates4u.aiu"
# 摇骰子1～6点随机选一个 emeditor key。
# $emeditor_v21_str;$getkey; 重复定义增加多余的输出显示
$i =  (1..6|Get-Random)
$emeditor_v21_str = switch ($i)
{
1 {"RABNAEEAWgBNAC0AVwBIAFkANQAyAC0AQQBYADIAMgAyAC0AWgBRAEoAWABOAC0ANwA5AEoAWABIAA=="}
2 {"RABTAEIAWgBHAC0AQgBGADIAWABIAC0ATQA5ADIAMgAyAC0ARAA1AE0AOABMAC0AUQBDAEMAWABIAA=="}
3 {"RABNAEEAWgBFAC0AVgBLAFoASgBWAC0AMgA4AFoAWgBaAC0ANABUADcAQQBKAC0ANwBIAEgANQA1AA=="}
4 {"RABQAEEAWgA2AC0AUwBIADIAVQBQAC0AUwA3AFoAWgBaAC0AWAA0ADcAVABVAC0ARgBVAEwAMgBYAA=="}
5 {"RABTAEgAWgBBAC0AUQBKADMARwBXAC0AWQBVAFoAWgBaAC0AUwBWAEYAWgAyAC0ANgBEAEIAVQBFAA=="}
6 {"RABNAEEAWgBNAC0AWgBNADUANQA2AC0ASwA2AFoAWgBaAC0AOQA5AEwAVwA4AC0AVwBWADUAQgBUAA=="}
}

# 编码测试 [System.Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes("asdasdxzczc"));
$getkey = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($emeditor_v21_str))
Set-Clipboard -Value $getkey # Get-Clipboard

Write-Output ""
Write-Output "注册名字随便填一个，序列号粘贴进去就行了。序列号已复制到粘贴板：" $getkey
Write-Output ""
Write-Output "xp/win7/server2008请下载：http://files.emeditor.com/emed32_14.8.1.exe"
Write-Output ""
Write-Output "win10/win11及未来更高版本以上：https://support.emeditor.com/en/downloads/latest/installer/64"
```

编码测试过程中的发现：

`iwr https://xxxx.com | iex`  ，据[CS免杀-PowerShell加载命令免杀](http://www.hackdig.com/03/hack-309458.htm)所说“缩写IWR，用来访问网页的内容，默认使用IE引擎“。结合我个人实验推测，不管是UTF8还是GB2312，中文都会显示乱码应该是与这个有关系。（可探讨）

通过`iex`反弹加载远程git仓字符文本内容执行，都不用像以前调用下载，然后文件执行，最后还要附加一句删除脚本自身语句，省去`remove-item $MyInvocation.MyCommand.Path -force`这一动作。

效果图一

![](https://s2.xptou.com/2023/03/11/640c770c2d89b.png)

效果图二

![](https://s2.xptou.com/2023/03/11/640c770dccc24.png)

最后，我推测emeditor甚至可通过注入注册表的方式直接完成，免进入界面去激活。粗略来说：

* CLSID，“全局唯一标示符”，标识软件用的（随机数字），“Classes\Wow6432Node\” 软件的注册信息用的。

加上之前写过[fail_idm.ps1](https://github.com/hoochanlon/ihs-simple/blob/main/d-pwsh/fail_idm.ps1)的经验，综上我觉得是可行的。（可探讨）不过我嫌麻烦，就没做了。

![](https://s2.xptou.com/2023/03/11/640c770e6e2de.png)


参考资料：

* [educba-powershell-base64](https://www.educba.com/powershell-base64/)
* [EmEditor 17.2.4 安装版+便携版+永久序列号+插件包(出处: 吾爱破解论坛)](https://www.52pojie.cn/thread-658917-1-1.html)
* [强制注册EmEditor 16.4(出处: 吾爱破解论坛)](https://www.52pojie.cn/thread-578165-1-1.html)
* [cnblogs-PowerDesigner 12破解汉化](https://www.cnblogs.com/estherlty/p/15771219.html)
* [bilibili-文本编辑器 EmEditor v22.0](https://www.bilibili.com/read/cv19068695)
* https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-clipboard
  https://learn.microsoft.com/zh-cn/powershell/scripting/learn/deep-dives/everything-about-switch
* [CS免杀-PowerShell加载命令免杀](http://www.hackdig.com/03/hack-309458.htm)





