# Linux中病毒后的排查

日常备份及恢复快照是最简单省心的操作。没有有这方面措施的话，只能靠着经验来一步步梳理与排查了。

* [为什么 Linux 内核不适合国家防御](https://blog.yurunsoft.com/a/68.html)
* [Linux系统安全隐患及加强安全管理的方法](https://www.cnblogs.com/myphoebe/archive/2011/08/09/2131982.html)

## 查看并关闭异常任务

### 排查当前存在异常进程

**使用`top`打开任务管理器，`kill -9 进程名`。** 参考：[pomit-Linux中的kill与kill -9](http://www.pomit.cn/tr/5063499771865601)。简单说，"-9"这参数就是不给程序收尾的时间，立马强行中止；这样的话，程序无法完成其下一步将要进行的计划。也可以`man`加单个指令，查看使用详情。

**使用`crontab -l`查看所有的定时任务。** 参考：[csdn-阿里云ECS遭挖矿程序攻击解决方法（彻底清除挖矿程序，顺便下载了挖矿程序的脚本）](https://blog.csdn.net/NicolasLearner/article/details/119006769)、[csdn-crontab -r删除后恢复](https://blog.csdn.net/only_cyk/article/details/123550872)。

**将`/var/spool/cron/用户名文件`的备份，覆盖掉感染病毒的主机定时任务文件。** 没有备份文件的话，就只能`cat /var/spool/cron/用户名文件`逐个通过`crontab -e`编辑去删除可疑任务了。

### 排查修改文件

48小时内被修改的文件。

```
find ./ -ctime -2
```




### 异常流量程序及传输端口

安装网卡流量监测程序并启动，查看异常的传输流量。

```
yum install -y iftop && iftop -i eth0 -nNP
```

使用`netstat -u -nat`，查看端口网络协议连接情况；并使用`lsof -i 4`查看ipv4访问情况，`kill -9`相应进程。为防止蠕虫病毒通过局域网内部传输的可能性，先临时关闭FTP（21）、SMB（139、445）。

参考：[csdn-Linux定位流量异常指南](https://blog.csdn.net/q2365921/article/details/125006136)、[csdn-Linux 命令 | 常用命令 lsof 详解 + 实例](https://blog.csdn.net/nyist_zxp/article/details/115340302)




## 检查账户相关的后门

### ssh密钥后门

从根目录搜索".ssh"文件夹，看看是否存在可疑的authorized_keys。

可疑点：

* `diff`比对备份的authorized_keys，发现有差异。
* 可疑家目录的用户及其他文件夹，有多余的authorized_key。

```
cd / && find -name .ssh
```

### 密码策略后门

既然已经被入侵，现在应该注意改密码了，以及查看密码策略`vi /etc/pam.d/system-auth`

```
# 失败3次封锁300秒
auth required  pam_faillock.so preauth silent audit deny=3  unlock_time=300 even_deny_root
# 密码验证三次，忽略大小写特殊字符，最小长度1位密码
password requisite pam_pwquality.so try_first_pass local_users_only retry=3
password requisite pam_pwquality.so authtok_type= lcredit=0 ucredit=0 dcredit=0 ocredit=0  minlen=1
```

账户过期策略


```

```


允许root登录

```

```





## 日志查询

日志完全清除命令 `rm /var/log/journal/* -rf;systemctl restart systemd-journald`；以及如下常用查看日志命令：

查看ssh服务日志，看下日常ssh被尝试登录的记录。 

```
journalctl -u sshd.service
```

`id username`然后输入用户的uid，如下指令查看50行root用户行为操作记录。

```
journalctl _UID=0 -n 50
```

参考：[csdn-journalctl -xe命令(系统日志查询)的使用](https://blog.csdn.net/enthan809882/article/details/104551777/)、[cnblogs-linux下的系统服务管理及日志管理](https://www.cnblogs.com/yuzhaokai0523/p/4453094.html)

## 新增文件记录

查看最近文件一天的变更记录，`-mmin` 后面的数值是分钟。

```
find /etc -mtime 1
```

[csdn-linux中查看新增的文件](https://blog.csdn.net/qq_17576885/article/details/121995103)


## 服务模块



需要备份的系统文件：

* 定时任务文件：
* ssh密钥认证文件：`.ssh/authorized_keys`

Linux备份软件


**通过现有参考知识，排查可疑端口号 。0-1023：系统端口；1024-5000：各类应用程序端口；用户自定义：5001-65535。** 参考：[csdn-计算机常用端口号大全](https://blog.csdn.net/weixin_42828010/article/details/127500199)。


[西安交大网络安全专题-挖矿病毒处置（Linux篇) ——从入门到放弃](http://wlaq.xjtu.edu.cn/info/1008/1945.htm)


