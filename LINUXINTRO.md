# 我的Linux入门

一篇用爱发电的落后于时代的Linux折腾记录笔记。推荐Linux参考工具：[linux-command](https://wangchujiang.com/linux-command/)、[explainshell](https://www.explainshell.com)、[modern-unix](https://github.com/ibraheemdev/modern-unix)。

## 难记！重改密码

密码像4位数的验证码一样简单。

[csdn-Linux CentOS7 服务器密码策略配置修改](https://blog.csdn.net/Ahuuua/article/details/125333088)

```
vi /etc/pam.d/system-auth
password requisite pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type= lcredit=0 ucredit=0 dcredit=0 ocredit=0  minlen=4
```


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

现象：由于ssh的加密性质，电脑重装之后，远程输入密码就登陆不上了。解决办法：电脑设置一次VNC，此时需要删除ssh的hnown_hosts。

```
rm -rf ~/.ssh/known_hosts && rm -rf ~/.ssh/known_hosts.old
```

远程主机ssh拒绝，配置

```
vi /etc/ssh/sshd_config
PasswordAuthentication yes
PermitRootLogin yes
systemctl restart sshd
```

掉线问题，主要看客户端，有些客户端长时间不操作会自动断开。系统默认就是不掉线的，除非配置在`/etc/profile `了 export TMOUT=300。改成如下便可。

```
vi /etc/ssh/sshd_config
# ClientAliveInterval 0 # 客户端每隔多少秒向服务发送一个心跳数据，类似web响应。
# ClientAliveCountMax 3 # 客户端多少秒没有相应，服务器自动断掉连接 
ClientAliveInterval 30
ClientAliveCountMax 86400
: wq!
# 并重启ssh服务。
systemctl restart sshd
```

参考：[【mysql安装】阿里云centos7环境mysql安装](https://blog.csdn.net/b_ingram/article/details/122396363)

### 从Linux下载文件到本地，先安装lrzsz

`sz 对应的文件名` 即下载。`lz 对应的文件名` 即上传。

```
yum install lrzsz
```

### 换成别的压缩工具p7zip

自带解压上手起来，徒增学习成本，冗长的命令，不方便操作。

```
# a 添加压缩包 x 解压
yum install -y p7zip
```

参考文档：https://wiki.archlinux.org/title/p7zip


## Linux那奇葩的防火墙

Linux的逻辑和我们平常见到的图形操作系统Windows、macOS不太一样，指定一个某某程序，禁止它们联网。在Windows、macOS很容易，如[win7禁止应用程序联网](https://blog.csdn.net/linxi8693/article/details/107205322/)；可到了Linux，却不是很好办了...防火墙主要针对于web、ftp等这类资源访问服务器的。而且呢，这类不少的软件产品也是要钱的。看来正版Windows贵，使用起来也为广大人民群众所接受的产品，这也是有道理的。Linux难用但免费，不过是企业省钱，加之术业有专攻罢了。

阿里云客服给我找来了[“创建新用户，限制新用户联网”的解决方案](https://www.zhihu.com/question/419420632)，着实脑洞新奇。也确实，一个软件可能存在此相关的多个进程联网；而且还要一一知晓每个软件的联网进程名，这太反人类了。

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catzhihufwlinux.png)

现在的Linux，通过web访问，也有图形化的配置界面了，安装软件什么的，也如同Windows一样简单。就比如说[mdserver-web](https://github.com/midoks/mdserver-web)、[宝塔面板](https://www.bt.cn/new/index.html)，也难怪这么多卖防火墙的，像深信服、山石都是的，以及阿里搞什么加钱购买的云盾防火墙，就是这个理。

### firewall-cmd

使用firewall-cmd，需将系统的防火墙服务打开。

```
systemctl start firewalld
```

禁止192.168.128.137访问主机，如果要取消的话，将`--add`换成`--remove`就好。

```
 firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.128.137" drop'
```

重载并查看规则条目

```
firewall-cmd --reload  && firewall-cmd --list-rich-rules
```

细致到禁用对方主机具体访问端口的话，复制如下命令。参数：filter，本地数据限制；-s源地址，-d目的地址，-p协议，--dport端口，-j行为/REJECT拒绝/ACCEPT同意/DROP丢弃。

```
firewall-cmd --direct  -add -rule ipv4 filter INPUT  1 -s  172.25.254.50  -p  tcp   -dport  22 -j  REJECT
```

参考：[博客园-Linux命令之firewall-cmd](https://www.cnblogs.com/diantong/p/9713915.html)、[csdn-Linux系统上的防火墙命令](https://blog.csdn.net/weixin_43780179/article/details/125046304)、[爱码网-linux下防火墙的管理工具firewall-cmd](https://www.likecs.com/show-203862572.html)。


## 下载ClamAV和更新病毒库

freshclam为更新病毒库。

```
yum install clamav && freshclam
```

扫描；-r：迭代目录；-l：指定路径；--max-dir-recursion：指定目录层级。

```
clamscan -r /etc --max-dir-recursion=5 -l /home/www/clamav-scan.log
```

类似软件还有河马查杀：https://www.shellpub.com/doc/hm_linux_usage.html
