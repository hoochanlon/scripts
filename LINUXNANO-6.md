
## 附录日志查询 （INTRO-3）

日志完全清除命令 `rm /var/log/journal/* -rf;systemctl restart systemd-journald`；以及如下常用查看日志命令：

```
# 显示最近系统日志30行 
journalctl -n 30

# 查看ssh服务日志 
journalctl -u sshd.service

# 查看root用户日志
journalctl _UID=0 -n 5

# -x 是目录(catalog)的意思，在报错的信息下会，附加解决问题的网址 
# -e  pager-end 从末尾开始看
journalctl -xe
```

参考：

* [csdn-journalctl -xe命令(系统日志查询)的使用](https://blog.csdn.net/enthan809882/article/details/104551777/)
* [cnblogs-linux下的系统服务管理及日志管理](https://www.cnblogs.com/yuzhaokai0523/p/4453094.html)


















