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

现象：由于ssh的加密性质，电脑重装之后，远程输入密码就登陆不上了。解决办法：电脑设置一次VNC，此时需要删除ssh的hnown_hosts。

```
rm -rf ~/.ssh/known_hosts && rm -rf ~/.ssh/known_hosts.old
```

掉线问题，主要看客户端，有些客户端长时间不操作会自动断开。系统默认就是不掉线的，除非配置在`/etc/profile `了 export TMOUT=300。改成如下便可。

```
# ClientAliveInterval 0 # 客户端每隔多少秒向服务发送一个心跳数据，类似web响应。
# ClientAliveCountMax 3 # 客户端多少秒没有相应，服务器自动断掉连接 
ClientAliveInterval 30
ClientAliveCountMax 86400
```

### 从Linux下载文件到本地，先安装lrzsz

`sz 对应的文件名` 即下载。`lz 对应的文件名` 即上传。

```
yum install lrzsz
```

### 遭遇网上的恶意脚本攻击

扫描到我云主机，并用脚本恶意破坏系统与Ddos攻击的“黑客”。据查为： https://github.com/Tremblae/Tremble 。

* 写好正则的手法去扫描检测公网云主机
* 通过常用的开放端口，不断用数据字典暴力破解密码，或是其他后门绕开密码，植入脚本
* 用脚本或打包好的二进制程序，卸载系统组件，乱改文件造成系统不稳定，并开放主机其他端口Ddos别人

![](https://fastly.jsdelivr.net/gh/hoochanlon/Free-NTFS-for-Mac/shashin/zei.png)

#### 处理办法

##### 1. 关闭不需要的远程端口，或修改成自己电脑的IP才能远程（为了方便考虑，不优先选择）

关闭自己不用的桌面系统远程端口，如Windows：3389，SSH：22，改成其他的端口。

````
cp /etc/ssh/sshd_config /etc/ssh/sshd_config_bak/sshd_config && vi /etc/ssh/sshd_config
# 找到 # port 22位置，在下方添加 port 1122
````

自己可临时百度IP，用公网IP登录。设置在“云服务器ECS” -> "ECS安全组"，编辑即可。注意：“0.0.0.0/0”代表任何人都能访问的。

##### 2. 修改用户登录策略

***虽然他们文章是不错参考资料，但必须要注意Linux的版本号，版本不一样，命令也是大有改动。19年的centos8取消了pam_tally2模块，但网上不少文章是2022、2020，他们可能当时就是用的centos8以下。***

* [linux 终端 设置连接登录密码 + 登录失败处理功能策略](https://www.cnblogs.com/qwer78/p/16546372.html)
* [uos账号解锁](https://blog.csdn.net/qq_35957643/article/details/125277224)
* [CentOS 8.0配置安全策略（用户3次登录失败锁定3分钟）](https://zhuanlan.zhihu.com/p/127109500?utm_id=0)

以上总结是CentOS8对修改sshd文件的教训，只适合CentOS7及以下。

修改配置

```
vi /etc/pam.d/system-auth
# 顶行复制如下指令，即默认所有用户通用处理。
auth required  pam_faillock.so preauth silent audit deny=3  unlock_time=300 even_deny_root
```
解锁用户

```
# 解锁一个用户
faillock --user It --reset
# 解锁所有用户
faillock--reset
```

##### 3. 阿里云技术支持对小白的推荐（要钱）

* 操作系统加固：https://help.aliyun.com/knowledge_list/60787.html
* web应用加固：https://help.aliyun.com/knowledge_list/60792.html

## Linux那奇葩的防火墙

Linux的逻辑和我们平常见到的图形操作系统Windows、macOS不太一样，指定一个某某程序，禁止它们联网。在Windows、macOS很容易，如[win7禁止应用程序联网](https://blog.csdn.net/linxi8693/article/details/107205322/)；可到了Linux，却不是很好办了...防火墙主要针对于web、ftp等这类资源访问服务器的。而且呢，这类不少的软件产品也是要钱的。看来正版Windows贵，使用起来也为广大人民群众所接受的产品，这也是有道理的。Linux难用但免费，不过是企业省钱，加之术业有专攻罢了。

阿里云客服给我找来了[“创建新用户，限制新用户联网”的解决方案](https://www.zhihu.com/question/419420632)，着实脑洞新奇。也确实，一个软件可能存在此相关的多个进程联网；而且还要一一知晓每个软件的联网进程名，这太反人类了。

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catzhihufwlinux.png)

现在的Linux，通过web访问，也有图形化的配置界面了，安装软件什么的，也如同Windows一样简单。就比如说[mdserver-web](https://github.com/midoks/mdserver-web)、[宝塔面板](https://www.bt.cn/new/index.html)，也难怪这么多卖防火墙的，像深信服、山石都是的，以及阿里搞什么加钱购买的云盾防火墙，就是这个理。

根据这情况那就备些防火墙相关的常用命令吧，把GitHub及对其加速CDN，一块ban了吧。等需要时，再来解禁一下这些主机IP。这个嘛，倒是可以做个一键脚本。

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


## Linux安装及使用杀软


