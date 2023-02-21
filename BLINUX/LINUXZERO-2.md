# 登录密码及授权密钥简配，限制与封禁IP，并锁Root

## SSH密钥

### 客户端

本机会将这一登录信息保存在`~/.ssh/known_hosts`文件当中，再次登录到远程服务器不用输入密码。

参数说明：

* -t 指定要创建的类型；-b 密钥长度；-f 指定文件名，名字随意。
* "-i"是指定公钥文件上传到服务器。

```
ssh-keygen -t rsa -b 4096 -f ~/.ssh/remote_ssh
```

```
ssh-copy-id -i ~/.ssh/remote_ssh.pub user@server
```

从[腾讯云-Linux多台服务器共用密钥ssh自动登陆](https://cloud.tencent.com/developer/article/2036440)得知，一份公钥可登录多台远程主机。


### 服务端

配置服务端的ssh密钥验证策略，选择是混合模式、密码模式，还是限定密钥模式访问。

编辑 /etc/ssh/sshd_config 文件，添加如下设置：

```
# 是否允许Public Key 
PubkeyAuthentication yes
# 允许Root登录
PermitRootLogin yes
# 设置是否使用口令验证。
PasswordAuthentication no # no 代表任何人远程访问都只能通过密钥，除非去机房或VNC屏幕远程
```

重启SSH服务，`systemctl restart sshd.service`。

#### 设置ssh路径下的权限

```
chmod 700 /home/xxx && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys
```

[csdn-ssh_config和sshd_config配置文件](https://blog.csdn.net/mynumber1/article/details/123699660)，ssh_config和sshd_config，前者是针对客户端的配置文件，后者则是针对服务端的配置文件。

## 密码简化与用户管理

### 密码简化

配置密码策略，修改密码得像4位数的验证码一样简单。vi /etc/pam.d/system-auth

```
# 新增自定义密码策略配置 密码验证三次 不限特殊字符、大小写、最低3位长度
password requisite pam_pwquality.so try_first_pass local_users_only retry=3
password requisite pam_pwquality.so authtok_type= lcredit=0 ucredit=0 dcredit=0 ocredit=0  minlen=4
```

具体参考：[learnku-Linux设定密码策略](https://learnku.com/articles/52174)

### 用户管理

腾讯云自建用户不能SSH登录，参考[码农家园-linux新建用户无法登录ssh](https://www.codenong.com/cs106546599/)。

`vi /etc/sshd_config`

```
AllowGroups root username
```

重启服务

```
/etc/init.d/ssh restart
```

或在`/etc/passwd`文件中，修改username的组标识号。


root执行sudo时不需要输入密码(sudoers文件中，有配置root ALL=(ALL) ALL这样一条规则，该文件必须使用"visudo"命令编辑)， 当用户执行sudo时，系统会主动寻找/etc/sudoers文件，判断该用户是否有执行sudo的权限。

二者任选，自己成为root，或加入wheel组。

1. [csdn-Linux系统中将普通用户权限提升至root权限](https://blog.csdn.net/weixin_45178128/article/details/103155720)

```
chmod u+w /etc/sudoers && echo "testuser       ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers \
chmod u-w /etc/sudoers
```


> 2. 引用自 [csdn-Linux新增ssh登录用户并加入sudo组](https://blog.csdn.net/xiunai78/article/details/84578529)

```
# 全部保存成脚本操作
useradd testuser
mkdir -p /home/testuser/.ssh
echo xxxxxxxxx  > /home/testuser/.ssh/authorized_keys
chmod u+w /etc/sudoers
echo "testuser       ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
chmod u-w /etc/sudoers
groupadd wheel
usermod -G wheel testuser
echo auth       required   pam_wheel.so group=wheel >> /etc/pam.d/su
echo auth       sufficient pam_wheel.so trust use_uid >> /etc/pam.d/su
```

其他参考：[cnblogs-linux下查看所有用户及所有用户组](https://www.cnblogs.com/pengyunjing/p/8543026.html)

## Ban IP的三种方式

### fail2ban

下载安装设置自启与启动fail2ban。

```
yum install -y fail2ban && systemctl enable fail2ban.service
```

配置 `vi /etc/fail2ban/jail.local`

```
[DEFAULT]
ignoreip=127.0.0.1 ＃用于指定哪些地址(IP/域名等)可以忽路fai12ban防御，空格分隔
findtime=60 ＃检测扫描行为的时间窗口（单位：秒），和maxretry结合使用，60秒内失败2次即封禁
maxretry=2 ＃检测扫描行为的次数，和findtime结合使用，60秒内失败2次即封禁
bantime= -1 ＃封禁该ip的时间（单位：秒），-1为永久封禁
banaction=iptables-allports #封禁该ip的端口

[sshd]
enabled=true #启用ssh扫描判断器
port=22 ＃ssh的端口，如更换过ssh的默认端口请更改成相应端口
filter=sshd #启用ssh扫描判断器
logpath=/var/log/auth.log #系统行为记录日志，一般无需改动
# 可以定制化发送邮件
sendmail-whois[name=SSH, dest=your@email.com, sender=fail2ban@example.com,sendername="Fail2Ban"]    
```

启动服务 `systemctl start fail2ban.service`，fail2ban开始生效。

```
systemctl restart fail2ban
```

日志查看 `cat /var/log/fail2ban.log`

参考：[北京大学-fail2ban安装](https://its.pku.edu.cn/faq_fail2ban.jsp)

### config for home

自身所处IP网段，由于运营商的不同，以及地区的不同，通常公司与家里公网IP差异是很大的。虽然公网IP是临时的，但三五两天常常变动的话，一是要有足够的IP资源，二是运营商不断调配IP，也会极大增加维护人工时间与物力成本，更何况现在的家庭网络路由器都是公网IP一个IP共享给多个主机。相对来说，一般是十五天或一个月变更一次。

理解：[公网IP和内网IP有何区别？如何获得公网IP上网？ - ipshu的文章 - 知乎](https://zhuanlan.zhihu.com/p/558884673)

hosts.deny，这种hosts等级的写入在CentOS8版本已废弃。用防火墙写规则吧。

CentOS7/8

```
systemctl restart network
```

```
systemctl start NetworkManager
```

结合阿里云客服提供经验，在自己所在地，百度下“IP”查地址，子网划分限制在8-16台主机基本上够用的了。即便是是局域网其实也差不多。

参考：

* [gitee - /etc/hosts.deny不生效（版本移除，以及默认不支持问题）](https://gitee.com/openeuler/kernel/issues/I29Z76)
* [try8-CentOS8网络配置教程（centos8，网卡重置命令变动）](https://try8.cn/article/10010)
* [csdn-CentOS8.5系统访问限制](https://blog.csdn.net/qq_41112887/article/details/121539810)

配合[ME2在线工具-子网划分工具](http://www.metools.info/other/subnetmask160.html)子网划分工具，轻松解决。


#### 防火墙

***启动防火墙 `systemctl enable firewalld && systemctl start firewalld`***

防火墙开启ICMP输入输出。

```
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT
```

***仅放行自己IP示例。加一条就好了，相当于是仅对这一个IP网段放行，别的就拒掉。***

```·
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.1.0/24" port protocol="tcp" port="22" accept'
```

***防火墙ban掉对方ip 禁止192.168.128.137访问主机*** 如果要取消的话，将`--add`换成`--remove`就好。

```
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.128.137" drop'
```
参数：filter，本地数据限制；-s源地址，-d目的地址，-p协议，--dport端口，-j行为/REJECT拒绝/ACCEPT同意/DROP丢弃。

```
firewall-cmd --direct  -add -rule ipv4 filter INPUT  1 -s  172.25.254.50  -p  tcp   -dport  22 -j  REJECT
```

参考：

* [博客园-Linux命令之firewall-cmd](https://www.cnblogs.com/diantong/p/9713915.html)
* [chinaunix-Linux使用防火墙firewall-cmd限制ssh只允许从指定IP段或指定源IP访问](http://blog.chinaunix.net/uid-20329764-id-5845291.html)
* [csdn-Linux系统上的防火墙命令](https://blog.csdn.net/weixin_43780179/article/details/125046304)
* [爱码网-linux下防火墙的管理工具firewall-cmd](https://www.likecs.com/show-203862572.html)

