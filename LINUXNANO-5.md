# 记上次黑客入侵阿里云主机 —— “ssh -D”事件专项分析

> ***防治手段转到[LINUXINTRO-0 SSH密钥策略](/LINUXINTRO-0.md)与[LINUXINTRO-0 FAIL2BAN策略](/LINUXINTRO-1.md)。***  
> ***注：一旦主机被黑客破解，通常都会在主机登录上，驻留SSH密钥，以及其他软件服务等登录的通行证后门。***

## 回顾阿里云客服对我的解惑

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-02-11%2023.53.26.png)

阿里云客服对我的回复：“您那个ctrl +C只是中断了您输入密码的这个步骤；那个意思是，我已经和服务器通过非正常的方式连接，我从中偷偷的断开，不会对sshd服务有影响。”并且向我展示了`systemctl status sshd`，查看有哪些主机进行ssh连接。（他意思应该是指黑客断开动态端口转发，不会影响到我正常ssh远程连接的使用。）

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/ssh-ima-na.png)

对比我咨询客服的时间（蓝色的IP是北京阿里云，绿色的四川，红色的俄罗斯），看上去其实安全问题还蛮严重的。因为这些时间点我都没去管阿里云，ssh协议及端口，也是我有意直接ban掉的，等联系阿里云客服再开启，居然有人想尝试登录。

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-02-12%2000.35.46.png)

由于我的“var/log/wtmp”和“utmp”被黑客删了，`last`、`lastb`二者来查看“尝试及登录过系统的用户”，也没什么效果了。但`journalctl`是可以的。我分析了下原因：一是他自身的编程知识水平，另一可能是有意而为之。有意为之要因推测：

&nbsp;&nbsp;&nbsp;从[知乎专栏-linux系统下各种日志文件的介绍，查看及日志服务配置](https://zhuanlan.zhihu.com/p/298335887)等相关文章可看出，屏蔽日志可以说是比较麻烦的，而且熟悉Linux也不会给你可乘之机啊。挖矿一直都会有日志产生，反正小白即不会也不懂怎么看；再者，看着情况公网主机基本上遭人扫描、暴破也是常事了。觉得没必要`rm /var/log/journal/* -rf;systemctl restart systemd-journald`，这显得多此一举；以及我的主机禁用日志服务测试情况：就算清除日志与`disable`掉日志服务，开机一样会自启记录。

不由得想起`top`任务进程与`chkconfig`运行级别想关联，再联想又会牵涉到`.service`服务调用模块上；所以，现在还是要回到正题`ssh -D`上，这些层层关联稍后再梳理。

## ssh -D

紧接着接着就是`ssh -D`后面的一堆“乱码”。

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-02-12%2015.28.08.png)

根据阿里云客服提示的“[chacha20-poly1305](https://baike.baidu.com/item/chacha20-poly1305/19712425?fr=aladdin)加密算法”，再结合`ssh -D [本地地址:]本地端口号 远程用户@远程地址`来推测，现在看有两种可能：一、黑客当时可能用的是他自己的主机，还没用其他肉鸡做跳板到我这；二、这种加密方式已经很普遍了，除了比较高端科技的云盾，可能真的拿它不是办法。

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-02-12%2016.08.58.png)

经过一次病毒源码分析，以及了解了黑客常见的几种入侵方式，综合来看，黑客也会自然拿我这台主机做肉鸡ddos别人。这与`ssh -D`颇有出入，`ssh -D`动态端口转发，比如：把发到B机器上面的请求，都转发到A机器上面；让A机器去执行请求，所执行的网络及其他服务请求，会消耗A机器的流量以及A主机的各项资源。再用A这台主机做跳板，又`ssh -D`动态转发到其他肉鸡上，可真算得上隐蔽。暴力破解我密码，自然会去查我主机IP，而且我的主机密码是符合复杂规律，但实际上又是特别简单的密码：“P@ssw0rd”。难怪这也解释了，为什么黑客会两次三番地入侵我主机。

再来理解一遍，客服对我关于`ssh -D`疑问的答复：“我已经和服务器通过非正常的方式连接，我从中偷偷的断开，不会对sshd服务有影响。” 以及结合查找的文章资料[为什么ssh一关闭，程序就不再运行了？](https://www.cnblogs.com/lomper/p/7053694.html)，看完如下引用这篇文章的这句话基本明白是怎么一回事了，涉及到sshd进程组方面的知识，保持通信防止挂断ssh被察觉。

> 因此当网络断开或终端窗口关闭后, 也就是SSH断开以后, 控制进程收到 SIGHUP 信号退出, 会导致该会话期内其他进程退出；简而言之: 就是 ssh 打开以后, bash等都是他的子程序, 一旦ssh关闭, 系统将所有相关进程杀掉!! 导致一旦ssh关闭, 执行中的任务就取消了.


参考：

* [知乎专栏-SSH的使用详解](https://zhuanlan.zhihu.com/p/339808892)
* [cnblogs-ssh -D -L -R 差异](https://www.cnblogs.com/-chaos/p/3378564.html)
* [SSH 命令的三种代理功能（-L/-R/-D）](https://zhuanlan.zhihu.com/p/57630633)
* [百度文库-第十章 守护进程与计算机网络安全](https://wenku.baidu.com/view/d29e1399cd2f0066f5335a8102d276a20029608c.html)
* [51cto-守护进程与远程登录服务器](https://blog.51cto.com/wait0804/1783308)
* [腾讯新闻-SSH服务渗透测试利用指北](https://new.qq.com/rain/a/20200629A0AUZX00)









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


















