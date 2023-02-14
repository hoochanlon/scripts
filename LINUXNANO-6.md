# Linux中病毒后的防治措施

日常备份及恢复快照是最简单省心的操作。没有有这方面措施的话，只能靠着经验来一步步梳理与排查了。

需要备份的系统文件：

* 定时任务文件：
* ssh密钥认证文件：`.ssh/authorized_keys`

## 查看并关闭异常任务

### 查看并杀死当前占用CPU的异常任务

使用`top`打开任务管理器，`kill -9 进程名`。

参考：[pomit-Linux中的kill与kill -9](http://www.pomit.cn/tr/5063499771865601)。简单说，"-9"这参数就是不给程序收尾的时间，立马强行中止；这样的话，程序无法完成其下一步将要进行的计划。

### 查看定时任务

使用`crontab -l`查看所有的定时任务。

 * [csdn-阿里云ECS遭挖矿程序攻击解决方法（彻底清除挖矿程序，顺便下载了挖矿程序的脚本）](https://blog.csdn.net/NicolasLearner/article/details/119006769)
 * [csdn-crontab -r删除后恢复](https://blog.csdn.net/only_cyk/article/details/123550872)


### 异常流量任务



## 防止密码后门

用`diff`、`colordiff`（需下载）比对文本，删除不认识的公钥。

```
vim ~/.ssh/authorized_keys
```

```
vi /etc/pam.d/system-auth
# 顶行复制如下指令，即默认所有用户通用处理。
auth required  pam_faillock.so preauth silent audit deny=3  unlock_time=300 even_deny_root
```

参考：[51cto-kdevtmpfsi挖矿病毒清除](https://blog.51cto.com/liuyj/5205391)


## 日志查询

日志完全清除命令 `rm /var/log/journal/* -rf;systemctl restart systemd-journald`；以及如下常用查看日志命令：

查看ssh服务日志，看下日常ssh被尝试登录的记录。 

```
journalctl -u sshd.service
```

`id username`然后输入用户的uid，如下指令查看root用户5行日志记录

```
journalctl _UID=0 -n 5
```

参考：[csdn-journalctl -xe命令(系统日志查询)的使用](https://blog.csdn.net/enthan809882/article/details/104551777/)、[cnblogs-linux下的系统服务管理及日志管理](https://www.cnblogs.com/yuzhaokai0523/p/4453094.html)

## 新增文件记录

查看最近文件一天的变更记录，`-mmin` 后面的数值是分钟。

```
find /etc -mtime 1
```

[csdn-linux中查看新增的文件](https://blog.csdn.net/qq_17576885/article/details/121995103)


## 服务模块