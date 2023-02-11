# 记上次黑客入侵阿里云主机 —— “ssh -D”事件专项分析

> ***防治手段转到[LINUXINTRO-0 SSH密钥策略](/LINUXINTRO-0.md)与[LINUXINTRO-0 FAIL2BAN策略](/LINUXINTRO-1.md)。***  
> ***注：一旦主机被黑客破解，通常都会在主机登录上，驻留SSH密钥，以及其他软件服务等登录的通行证后门。***
 
经过一个病毒源码分析，综合来看，黑客也会自然拿我这台主机做肉鸡ddos别人，这与`ssh -D`颇有出入。`ssh -D`动态端口转发，比如，把发到B机器上面的请求，都转发到A机器上面，让A机器去执行请求，所执行的网络及其他服务请求，会消耗A机器的流量以及A主机的各项资源。

## 复盘

再回顾一下我对阿里云客服的咨询

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-02-11%2023.53.26.png)

阿里云客服对我的回复：“您那个ctrl +C只是中断了您输入密码的这个步骤，那个意思是，我已经和服务器通过非正常的方式连接，我从中偷偷的断开，不会对sshd服务有影响”，并且向我展示了`systemctl status sshd`妙用，查看有哪些主机进行ssh连接。

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/ssh-ima-na.png)

对比我咨询客服的时间（蓝色的IP是北京阿里云，绿色的四川，红色的俄罗斯），看上去其实安全问题还蛮严重的。因为这些时间点我都没去管阿里云，ssh协议及端口，也是我有意直接ban掉的，等联系阿里云客服再开启，居然有人想尝试登录。

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-02-12%2000.35.46.png)

立马查了下资料，[查找谁在破解你linux服务器的密码?](https://blog.csdn.net/jiedao_liyk/article/details/78460072)、[sohu-记一次主机入侵攻防大战：firewalld指定的IP段端口访问控制 ](https://www.sohu.com/a/229348161_587184)、[yingsoo-Linux常用命令last的使用方法详解(转载下载之家)](https://www.yingsoo.com/news/servers/69311.html)。

小结一些查看相关登录记录文件或命令：

```

```


参考：

* [知乎专栏-SSH的使用详解](https://zhuanlan.zhihu.com/p/339808892)
* [cnblogs-ssh -D -L -R 差异](https://www.cnblogs.com/-chaos/p/3378564.html)
* [SSH 命令的三种代理功能（-L/-R/-D）](https://zhuanlan.zhihu.com/p/57630633)
* [百度文库-第十章 守护进程与计算机网络安全](https://wenku.baidu.com/view/d29e1399cd2f0066f5335a8102d276a20029608c.html)
* [51cto-守护进程与远程登录服务器](https://blog.51cto.com/wait0804/1783308)



