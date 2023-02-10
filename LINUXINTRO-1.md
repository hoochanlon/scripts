# 我的Linux入门之安全设置

> 一篇用爱发电的落后于时代的Linux折腾记录笔记。推荐Linux参考工具：[linux-command](https://wangchujiang.com/linux-command/)、[explainshell](https://www.explainshell.com)、[modern-unix](https://github.com/ibraheemdev/modern-unix)。

注：被黑客连续入侵两次主机挖矿后，我决定对这Linux毛坯房进行升级改造。

## 禁止对方搞事 —— BAN IP

### 思路1: 下载tcpdump抓包，脚本写个逻辑程序

💡：到时候自己提取文本、统计相同IP总数、有3次在ping我主机，直接ban ip。

```
# 下载tcpdump 
 git clone https://github.com/the-tcpdump-group/tcpdump

# 查看谁在 ping 我主机
 tcpdump -i eth0 icmp and icmp[icmptype]=icmp-echo -n
```

### 思路2: 使用ban ip等软件及脚本

常见的有：fail2ban、denyhosts、secure_ssh。这里以fail2ban为例，从下载安装设置自启与启动。

```
yum install -y fail2ban && systemctl enable fail2ban.service
```

配置 `vi /etc/fail2ban/jail.conf`

```
# 注意时区问题：systemctl restart rsyslog
# 注意端口号：我们修改ssh端口后，fail2ban也需要修改端口号
action = iptables[name=SSH,port=ssh,protocol=tcp] 
enabled = true
filter = sshd
logpath = /var/log/secure   #日志位置
bantime =  30d              #封锁时间一个月
maxretry = 2                #失败2次即封禁
findtime = 180              #3分钟之内
# 可以定制化发送邮件
sendmail-whois[name=SSH, dest=your@email.com, sender=fail2ban@example.com,sendername="Fail2Ban"]    
```

启动服务 `systemctl start fail2ban.service`，fail2ban开始生效。

```
systemctl restart fail2ban
```


参考：

* [oschina-Centos DenyHosts 禁止针对 linux sshd 的暴力破解](https://my.oschina.net/notbad/blog/338545)
* [bbsmax-fail2ban的使用以及防暴力破解与邮件预警](https://www.bbsmax.com/A/QW5YD19MJm/)
* [csdn-fail2ban配置教程 有效防止服务器被暴力破解](https://blog.csdn.net/qq_44293827/article/details/118641216)


## 禁止随意乱发洪流，仅限于临时放开

重要：<u>系统是否允许Ping由2个因素决定的：A、内核参数，B、防火墙。</u>

### 内核关闭ping

编辑 `/etc/sysctl.conf` 然后执行 `sysctl -p`

```
net.ipv4.icmp_echo_ignore_all=1 
```

参考：[Linux禁止ping、开启ping设置](https://www.bbsmax.com/A/obzbMvAMdE/)

### 防火墙

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

