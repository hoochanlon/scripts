### win11 home to pro

升级了，但没激活。[代码出处 akbch/win11-home-to-pro](https://github.com/pakbch/win11-home-to-pro/blob/main/code.bat)

``` 
sc config LicenseManager start= auto & net start LicenseManager
sc config wuauserv start= auto & net start wuauserv
changepk.exe /productkey VK7JG-NPHTM-C97JM-9MPGT-3V66T
exit
```

微软产品激活。详情：https://massgrave.dev

```
irm https://massgrave.dev/get | iex
```

去你的！一步到位！我全都要！

```
curl -O https://ghproxy.com/https://raw.githubusercontent.com/TerryHuangHD/Windows10-VersionSwitcher/master/Switch.bat&&TIMEOUT /T 1&&start Switch.bat&&powershell -command "irm https://massgrave.dev/get|iex"
```

### 提升管理权限

https://zhidao.baidu.com/question/1431089222201948539.html 家庭版，嫌麻烦，没做

### 写入hosts

详情见：`xcopy /?`，大意将文件全部复制到一个新目录（xcopy特性）存放，再排除重复操作的报错。

```
@xcopy C:\Windows\system32\drivers\etc\hosts C:\Windows\system32\drivers\etc\hosts.bak\ /d /c /i /y 
```

利用如上逻辑进行还原，即原备份文件覆盖。

```
@copy C:\Windows\System32\drivers\etc\hosts.bak\hosts C:\Windows\System32\drivers\etc\hosts /y
```

写入

```
@echo 117.79.149.116 search.b2b.cn >>C:\Windows\System32\drivers\etc\hosts
```

参考： [windwos使用CMD命令添加hosts的方法](https://blog.csdn.net/pokes/article/details/122179412)

### 复制与粘贴文本

快速回到桌面

```
cd %userprofile%\desktop
```

参考：[jack孟-Windows系统，命令行窗口里的内容复制到剪贴板](https://www.cnblogs.com/mq0036/p/16285243.html)

### 结束进程

`/IM` 指定进程名称，这比PID好多了。

```
TASKKILL /F /IM PDFXHost32.exe
```

参考：[csdn-taskkill /f /im *.exe 的作用](https://blog.csdn.net/ccf19881030/article/details/119040631)


### 防火墙

查看防火墙状态

```
netsh advfirewall show allprofiles
```

打开/关闭防火墙

```
netsh advfirewall set allprofiles state on/off
```

添加限制程序联网规则

```
netsh advfirewall firewall add rule name="no_ie_for_em" dir=out program="%localappdata%\Programs\EmEditor\emeditor.exe" action=block
```


让Windows防火墙允许或禁止 ping

```
netsh firewall set icmpsetting 8
netsh firewall set icmpsetting 8 disable
```

新版

```
netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow/block
```

参考：

* [learn.microsoft](https://learn.microsoft.com/zh-CN/troubleshoot/windows-server/networking/netsh-advfirewall-firewall-control-firewall-behavior)
* [csdn-Windows系统设置开启Ping或禁Ping（超详细）](https://blog.csdn.net/wlc_1111/article/details/106048982)
* [windows防火墙实验-命令行设置远程桌面连接以及禁止浏览器上网](https://www.bbsmax.com/A/KE5QjnkLdL/)
