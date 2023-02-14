# Linux中病毒后的防治措施

日常备份及恢复快照是最简单省心的操作。没有有这方面措施的话，只能靠着经验来一步步梳理与排查了。

## 查看并关闭异常任务

使用`top`打开任务管理器，`kill -9 进程名`。

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