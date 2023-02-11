# 我的Linux入门之阿里云（免费版）初体验

一篇用爱发电的落后于时代的Linux折腾记录笔记。推荐Linux参考工具：[linux-command](https://wangchujiang.com/linux-command/)、[explainshell](https://www.explainshell.com)、[modern-unix](https://github.com/ibraheemdev/modern-unix)。

## SSH连接主机相关

连接主机输入主机密码，设置主机名。

``` 
# 连接主机
ssh root@公网IP
# 设置主机名
hostnamectl set-hostname xiaohong
# 正常设置主机名需要重启，执行bash刷新
bash
````

配置密码策略，修改密码得像4位数的验证码一样简单。vi /etc/pam.d/system-auth

```
# 密码验证三次，什么大小写特殊字符统统给我去掉
password requisite pam_pwquality.so try_first_pass local_users_only retry=3
password requisite pam_pwquality.so authtok_type= lcredit=0 ucredit=0 dcredit=0 ocredit=0  minlen=4
```

然后修改密码：`passwd root`

参考：[csdn-Linux CentOS7 服务器密码策略配置修改](https://blog.csdn.net/Ahuuua/article/details/125333088)、[CentOS操作系统密码复杂度策略查看和设置](https://www.cnblogs.com/wwwcf1982603555/p/15560277.html)。


## SSH免密登录快速配置

### 客户端

本机会将这一登录信息保存在`~/.ssh/known_hosts`文件当中，再次登录到远程服务器不用输入密码。

```
# 参数说明：-t 指定要创建的类型；-b 密钥长度；-f 指定文件名；id_rsa-remotessh 名字随意
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa-remotessh
```

"-i"是指定公钥文件上传到服务器。

```
ssh-copy-id -i .ssh/id_rsa.pub user@server
```

输入密码，至此客户端完成操作，下面是服务器端，即远程主机的配置。

### 服务端

编辑 /etc/ssh/sshd_config 文件，添加如下设置：

```
# 是否允许Public Key 
PubkeyAuthentication yes
# 允许Root登录
PermitRootLogin yes
# 设置是否使用口令验证
PasswordAuthentication no
```

重启SSH服务，`systemctl restart sshd.service`。

#### 设置ssh路径下的权限

```
chmod 700 /home/xxx && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys
```

[经“码司机”的实验](https://blog.csdn.net/qq_39320261/article/details/128342057)，“/.ssh”与“ahthorized_keys”不得高于700，“/.ssh”的上层目录不得高于755；而我自己的现场主机是root用户，所以并没有什么相关的权限制约问题。


参考：

* [csdn-设置ssh免密不起作用？彻底搞懂密钥】vscode在remote SSH免密远程登录](https://blog.csdn.net/weixin_42907822/article/details/125237307)
* [cnblogs-ssh实现免密登录](https://www.cnblogs.com/hongdada/p/13045121.html)
* [csdn-【问题解决】解决Linux配置SSH公钥后仍然需要输入密码的问题](https://blog.csdn.net/qq_39320261/article/details/128342057)

## SSH故障排除

```
> id_rsa 就是私钥文件
> id_rsa.pub 就是公钥文件
> known_host 就是记录你曾经远程连接过的机器信息文件
```

此类提示是远程主机未授权给本地

```
C:\Users\chanlonhoo>ssh root@101.x.xx.xxx
root@101.x.xx.xxx: Permission denied (publickey,gssapi-keyex,gssapi-with-mic).
```

现象：由于ssh的加密性质，电脑重装之后，远程输入密码就登陆不上了。解决办法：电脑设置一次VNC，此时需要删除ssh的hnown_hosts。

```
rm -rf ~/.ssh/known_hosts && rm -rf ~/.ssh/known_hosts.old
```

掉线问题，主要看客户端，有些客户端长时间不操作会自动断开。系统默认就是不掉线的，除非配置在`/etc/profile `了 export TMOUT=300。改成如下便可。

vi /etc/ssh/sshd_config

```
# ClientAliveInterval 0 # 客户端每隔多少秒向服务发送一个心跳数据，类似web响应。
# ClientAliveCountMax 3 # 客户端多少秒没有相应，服务器自动断掉连接 
ClientAliveInterval 30
ClientAliveCountMax 86400
```

并重启ssh服务，`systemctl restart sshd`。
