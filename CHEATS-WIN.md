### 注册WinRAR

以管理员运行cmd，一键下载安装及注册WinRAR


```batch
curl -O https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/winrar_down_reg.bat&&TIMEOUT /T 1&&start /b C:\Users\%username%\Downloads\winrar_down_reg.bat
```

### 写入hosts

详情见：`xcopy /?`，大意将文件全部复制一个新目录存放，再排除重复操作的报错。

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

### 防火墙

查看防火墙状态

```
netsh advfirewall show allprofiles
```

打开/关闭防火墙

```
netsh advfirewall set allprofiles state on/off
```

限制程序联网（添加规则）/删除规则

```
netsh advfirewall firewall add/delete rule name="no360ie" dir=out program="程序路径 " action=block
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
