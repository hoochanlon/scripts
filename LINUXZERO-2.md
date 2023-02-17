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

## 密码简化

配置密码策略，修改密码得像4位数的验证码一样简单。vi /etc/pam.d/system-auth

```
# 密码验证三次，什么大小写特殊字符统统给我去掉
password requisite pam_pwquality.so try_first_pass local_users_only retry=3
password requisite pam_pwquality.so authtok_type= lcredit=0 ucredit=0 dcredit=0 ocredit=0  minlen=4
```

具体参考：[learnku-Linux设定密码策略](https://learnku.com/articles/52174)


## fail2ban

下载安装设置自启与启动fail2ban。

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
bantime =  800              #封锁时间长达一月以上（24*30）
maxretry = 2                #失败2次即封禁
findtime = 43200            #12小时之内(60*60*12)
# 可以定制化发送邮件
sendmail-whois[name=SSH, dest=your@email.com, sender=fail2ban@example.com,sendername="Fail2Ban"]    
```

启动服务 `systemctl start fail2ban.service`，fail2ban开始生效。

```
systemctl restart fail2ban
```

日志查看 `cat /var/log/fail2ban.log`

### config for home

结合阿里云客服提供经验：在自己所在地，百度下“IP”查地址，限制在8-16台主机基本上够用的了。自身所处IP网段，由于运营商的不同，以及地区的不同，通常公司与家里公网IP差异是很大的。虽然公网IP是临时的，但一个在小范围的内，变动通常不大，也就基本只在最后A.B.C.D，D分段变动。

`vi /etc/hosts.deny`

```
# 限制所有的ssh，除非从192.168.0.1/192.168.0.2 - 127上来。

hosts.deny:in.sshd:ALL
hosts.allow:in.sshd:192.168.0.1/255.255.255.254
hosts.allow:in.sshd:192.168.0.2/255.255.255.254
```

`systemctl restart network` 

配合[ME2在线工具-子网划分工具](http://www.metools.info/other/subnetmask160.html)子网划分工具，轻松解决。

参考：[csdn-linux ip限制的两种设置方式](https://blog.csdn.net/sunsineq/article/details/119107500)


