# 我的Linux入门

一篇用爱发电的落后于时代的Linux折腾记录笔记。推荐Linux参考工具：[linux-command](https://wangchujiang.com/linux-command/)、[explainshell](https://www.explainshell.com)、[modern-unix](https://github.com/ibraheemdev/modern-unix)。

## Linux云服务器初体验

### SSH连接主机相关

连接主机输入主机密码，设置主机名。

``` 
# 连接主机
ssh root@公网IP
# 设置主机名
hostnamectl set-hostname xiaohong
# 正常设置主机名需要重启，执行bash刷新
bash
````

### 修改密码

密码像4位数的验证码一样简单。

```
vi /etc/pam.d/system-auth
password requisite pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type= lcredit=0 ucredit=0 dcredit=0 ocredit=0  minlen=4
```

```
passwd root
```

参考：[csdn-Linux CentOS7 服务器密码策略配置修改](https://blog.csdn.net/Ahuuua/article/details/125333088)、[CentOS操作系统密码复杂度策略查看和设置](https://www.cnblogs.com/wwwcf1982603555/p/15560277.html)


### 快速配置SSH免密登录

注：这只是针对免密码登录的密钥访问形式，外部访问一样要输入密码，登录成功后也配备SSH授权。

#### 服务端

编辑 /etc/ssh/sshd_config 文件，添加如下设置：

```
# 设置是否使用RSA算法进行安全验证
RSAAuthentication yes
# 是否允许Public Key 
PubkeyAuthentication yes
# 允许Root登录
PermitRootLogin yes
# 设置是否使用口令验证
PasswordAuthentication no
```
service sshd restart

#### 客户端

本机会将这一登录信息保存在`~/.ssh/known_hosts`文件当中，再次登录到远程服务器不用输入密码。

```
ssh-keygen
ssh-keygen -t rsa -C "your@email.com"
ssh-copy-id -i .ssh/id_rsa.pub user@server
ssh user@server
```

参考：[cnblogs-ssh实现免密登录](https://www.cnblogs.com/hongdada/p/13045121.html)


### SSH故障排除

现象：由于ssh的加密性质，电脑重装之后，远程输入密码就登陆不上了。解决办法：电脑设置一次VNC，此时需要删除ssh的hnown_hosts。

```
rm -rf ~/.ssh/known_hosts && rm -rf ~/.ssh/known_hosts.old
```

掉线问题，主要看客户端，有些客户端长时间不操作会自动断开。系统默认就是不掉线的，除非配置在`/etc/profile `了 export TMOUT=300。改成如下便可。

```
vi /etc/ssh/sshd_config
# ClientAliveInterval 0 # 客户端每隔多少秒向服务发送一个心跳数据，类似web响应。
# ClientAliveCountMax 3 # 客户端多少秒没有相应，服务器自动断掉连接 
ClientAliveInterval 30
ClientAliveCountMax 86400
```

并重启ssh服务，`systemctl restart sshd`。

参考：[【mysql安装】阿里云centos7环境mysql安装](https://blog.csdn.net/b_ingram/article/details/122396363)

### lrzsz 和 scp

从Linux下载文件到本地，先安装lrzsz，`sz 对应的文件名` 即下载。`rz 对应的文件名` 即上传。

```
yum install lrzsz
```

### p7zip

换成别的压缩工具。自带解压上手起来，徒增学习成本，冗长的命令，不方便操作。

```
# a 添加压缩包 x 解压
yum install -y p7zip
```

参考文档：https://wiki.archlinux.org/title/p7zip

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
