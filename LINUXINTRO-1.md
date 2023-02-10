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

### 思路2: fail2ban、secure_ssh、denyhosts





参考：[[Linux] Centos DenyHosts 禁止针对 linux sshd 的暴力破解](https://my.oschina.net/notbad/blog/338545)

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

