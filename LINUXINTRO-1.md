# 我的Linux入门（2023.2.10）

一篇用爱发电的落后于时代的Linux折腾记录笔记。推荐Linux参考工具：[linux-command](https://wangchujiang.com/linux-command/)、[explainshell](https://www.explainshell.com)、[modern-unix](https://github.com/ibraheemdev/modern-unix)。

被黑客入侵主机挖矿后，我决定对垃圾的Linux毛坯房进行升级改造。

## 禁止对方搞事 —— BAN IP

### 思路1: 下载tcpdump抓包，脚本写个逻辑程序

💡：到时候自己提取文本、统计相同IP总数、有3次在ping我主机，直接ban ip。

```
# 下载tcpdump 
 git clone https://github.com/the-tcpdump-group/tcpdump

# 查看谁在 ping 我主机
 tcpdump -i eth0 icmp and icmp[icmptype]=icmp-echo -n
```

### 思路2: fail2ban、secure_ssh，ssh ban ip

ban ip




### 思路3: 禁止Ping，仅限于临时放开

#### 内核

关闭ping

```
vi /etc/sysctl.conf
net.ipv4.icmp_echo_ignore_all=1 
```

然后执行  `sysctl -p`

参考：[Linux禁止ping、开启ping设置](https://www.bbsmax.com/A/obzbMvAMdE/)
重要：<u>系统是否允许Ping由2个因素决定的：A、内核参数，B、防火墙。</u>

#### 防火墙

防火墙开启ICMP。

```
# 启动防火墙
systemctl start firewalld
# icmp，输入输出放开。
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT
```
防火墙ban掉对方ip

```
## 禁止192.168.128.137访问主机，如果要取消的话，将`--add`换成`--remove`就好
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.128.137" drop'

## 细致到禁用对方主机具体访问端口的话，复制如下命令。
## 参数：filter，本地数据限制；-s源地址，-d目的地址，-p协议，--dport端口，-j行为/REJECT拒绝/ACCEPT同意/DROP丢弃。 
firewall-cmd --direct  -add -rule ipv4 filter INPUT  1 -s  172.25.254.50  -p  tcp   -dport  22 -j  REJECT
```

参考：[博客园-Linux命令之firewall-cmd](https://www.cnblogs.com/diantong/p/9713915.html)、[csdn-Linux系统上的防火墙命令](https://blog.csdn.net/weixin_43780179/article/details/125046304)、[爱码网-linux下防火墙的管理工具firewall-cmd](https://www.likecs.com/show-203862572.html)。


## 下载ClamAV和更新病毒库

目前Linux的免费杀软跟玩具代码，安慰剂一样，挡不住挖矿病毒。

```
# freshclam为更新病毒库。
yum install clamav && freshclam
```

扫描；-r：迭代目录；-l：指定路径；--max-dir-recursion：指定目录层级。

```
clamscan -r /etc --max-dir-recursion=5 -l /home/www/clamav-scan.log
```

类似软件还有河马查杀：https://www.shellpub.com/doc/hm_linux_usage.html

## 禁止程序联网

### Linux奇葩防火墙

Linux的逻辑和我们平常见到的图形操作系统Windows、macOS不太一样，指定一个某某程序，禁止它们联网。在Windows、macOS很容易，如[win7禁止应用程序联网](https://blog.csdn.net/linxi8693/article/details/107205322/)；可到了Linux，却不是很好办了...防火墙主要针对于web、ftp等这类资源访问服务器的。而且呢，这类不少的软件产品也是要钱的。看来正版Windows贵，使用起来也为广大人民群众所接受的产品，这也是有道理的。Linux难用但免费，不过是企业省钱，加之术业有专攻罢了。

阿里云客服给我找来了[“创建新用户，限制新用户联网”的解决方案](https://www.zhihu.com/question/419420632)，着实脑洞新奇。也确实，一个软件可能存在此相关的多个进程联网；而且还要一一知晓每个软件的联网进程名，这太反人类了。

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catzhihufwlinux.png)

现在的Linux，通过web访问，也有图形化的配置界面了，安装软件什么的，也如同Windows一样简单。就比如说[mdserver-web](https://github.com/midoks/mdserver-web)、[宝塔面板](https://www.bt.cn/new/index.html)，也难怪这么多卖防火墙的，像深信服、山石都是的，以及阿里搞什么加钱购买的云盾防火墙，就是这个理。

