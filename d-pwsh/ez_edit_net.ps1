# 说明
# 1. 一般来说局域网的IP设置除IP地址，通常大部分参数都是固定的，所以省事起见只修改一个IP参数
# 2. 如果是hosts，CMD管理员打开记事本来写更方便... notepad C:\Windows\System32\drivers\etc\hosts
# 3. 开代理使用，nslookup的正常解析会受到影响，推测为服务器中转原因
# 4. nslookup通过配置了远程dns，其自身将会解析成IPv6的地址。
# 5. 每一个板块的代码都可以拿去用，最终ps1运行的最终效果是写入dns.sb域名解析。

#***************测试环境，静态IP配置简单例子*********************

# 1. 保存改写IP、DNS之前历史信息
netsh interface ip show config > ipbak.txt
## 1.2 打印必要提示
echo "cmd运行 ipbak.txt 查看备份信息；扔入垃圾桶：del ipbak.txt"
# 2. 修改IP、子网掩码、网关
$input_ip = Read-Host "输入IP地址";netsh interface ip set address "以太网" static $input_ip 255.255.255.0  192.168.1.1
# 3. 设置DNS，并打印OK
Set-DnsClientServerAddress -InterfaceAlias "以太网" -ServerAddresses ("114.114.114.114","8.8.8.8");echo "OK"

#------------------------------------------------------------

#*****************动态IP、DNS配置简单例子****************

netsh interface ip set address "以太网" dhcp
netsh interface ip set dnsservers "以太网" source=dhcp

#------------------------------------------------------------



#*******************将网站的dns写入主机************************
# 扩展：反向解析 nslookup -ty=ptr 1.1.1.1

# 1. 从nslookup解析网址中，获取到索引行dns记录，注入文本；dns.sb是一个dns域名。
nslookup dns.sb|Select-Object -Index 4 >dns-w.txt
# 2. 获取dns-w.txt文本内容，利用正则筛选出IP地址，$matches[0]取值
(Get-Content dns-w.txt) -match '\d+\.\d+\.\d+\.\d+'; $get_dns_num = $matches[0]
# 设置dns，将变量参数填入进去
Set-DnsClientServerAddress -InterfaceAlias "以太网" -ServerAddresses ($get_dns_num)
# 顺便把解析记录文本删掉，打印ok
del dns-w.txt;echo "ok"

#------------------------------------------------------------

# 参考资料与草稿

## 静态IP配置参考：

### [用netsh查看和设置IP地址、DNS地址、防火墙](https://blog.51cto.com/guochunyang/5851385)
### [如何在Windows中使用Powershell Grep或Select-String Cmdlet Grep文本文件？](https://blog.csdn.net/cunjiu9486/article/details/109074646)
### [PowerShell输出IP地址](https://blog.csdn.net/qq_41863100/article/details/120360662)
### [cnblogs-修改ip](https://www.cnblogs.com/awpatp/p/4549119.html)
### [【自分用メモ】PowerShellによるIPアドレスの設定及び変更](https://qiita.com/Kirito1617/items/aed439bcb66c63489337)
### [powershell - 使用Powershell在断开连接的网卡上设置静态IP，是否可以？](https://www.coder.work/article/7399792)

## 将网站的dns写入主机参考：

### [术之多-Powershell过滤管道结果](https://www.shuzhiduo.com/A/MAzAb2xMJ9/)
### [nhooo-PowerShell中使用正则表达式匹配字符串实例](https://www.nhooo.com/note/qacidn.html)
### [csdn-常用正则表达式汇总（数字匹配/字符匹配/特殊匹配）](https://blog.csdn.net/zx77588023/article/details/107116196/)
### [csdn-nslookup 入门命令详解](https://blog.csdn.net/weixin_42426841/article/details/115364502)

## 意外性参考：

### [国内可用的 IPv6 公共 DNS 和加密 DNS](https://www.cccitu.com/2205359.html)
### [csdn-无法将“XXX”项识别为 cmdlet、函数、脚本文件或可运行程序的名称。 对这个问题的解决方法](https://blog.csdn.net/sxeric/article/details/122403591)


## 终端做回显.草稿1

### 从“ipconfig /all”中，匹配关键字，输出成字符串
### $show_ip = ipconfig /all|Select-String "IPV4","子网掩码","默认网关"|out-string
### 输出IP配置，并将DNS1、2全部回显
### Write-Output $show_ip;get-DnsClientServerAddress -InterfaceAlias "以太网" -AddressFamily "IPv4"