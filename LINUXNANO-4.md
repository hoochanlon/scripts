# 记上次黑客入侵阿里云主机 —— 入侵行为分析

> 防治手段转到[LINUXINTRO-0 SSH密钥策略](/LINUXINTRO-0.md)与[LINUXINTRO-0 FAIL2BAN策略](/LINUXINTRO-1.md)

## 入侵方式

***注：一旦主机被黑客破解，通常都会在主机登录上，驻留SSH密钥，以及其他软件服务等登录的通行证后门。***

此前我好奇一个问题： 我的服务器都没有域名，黑客是什么扫到我的服务器公网地址的？针对这一问题我联系了阿里云客服。与之沟通答复及讨论，要点总结如下：

### 杜美莎手法

在没有公网业务、服务部署的前提下，黑客基本上是通过“[杜美莎](http://foofus.net/goons/jmk/medusa/medusa.html)”之类的软件来进行入侵的。黑客会通过其他渠道购买及下载IP池，批量扫描，字典破解密码，因为服务器的都是暴漏在公网环境下的。杜美莎是集IP扫描、端口探测、密码暴破于一身的主机渗透解锁软件。

### ddos攻击

“如果对方换成ddos攻击，这个就是杀敌1000，自损800没什么深仇大恨，不会去搞。” 客服补充说道；我便回“自损800？没有吧，ddos不是一直ping吗？ping又不需要什么东西。” 听到这话，客服举例向我解释：“我攻击您50G流量，这个50G流量从哪里来的，我自己的流量啊”。

### 中间人攻击

看了文章这篇[csdn-中间人攻击](https://blog.csdn.net/holen_/article/details/122839940)，黑客需要从中间劫持双方通信的流量包，并对流量包解包分析参数。这又对黑客提出要求，即理解网络方面的专业知识，而且我和阿里云之间的密码输入是https post请求(参考信息[POST请求](https://blog.csdn.net/weixin_41040445/article/details/115260390))，又得要求黑客需要了解一定的密码学知识。此外截获这方面的流量，可能还得去运营商那租台服务器什么。

综合起来，这对黑客的人力物力及时间的成本高了。黑客极有可能清楚这台主机局域网的网络走向的，知道做什么业务才侵入进来。

> 附图转自 [csdn-中间人攻击](https://blog.csdn.net/holen_/article/details/122839940) 

中间人攻击知会图解

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/csdn-zjrgj-sy.png)

中间劫获方法简要图解

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/csdn-zjrgj-arp.png)

黑客选择那种手段也会考虑成本

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-02-11%2023.24.56.png)


## “ssh -D”事件专项分析

经过一个病毒源码分析，综合来看，黑客也会自然拿我这台主机做肉鸡ddos别人，这与`ssh -D`颇有出入。`ssh -D`动态端口转发，比如，把发到B机器上面的请求，都转发到A机器上面，让A机器去执行请求，所执行的网络及其他服务请求，会消耗A机器的流量以及A主机的各项资源。

再回顾一下我对阿里云客服的咨询

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-02-11%2023.53.26.png)

阿里云客服对我的回复：“您那个ctrl +C只是中断了您输入密码的这个步骤，那个意思是，我已经和服务器通过非正常的方式连接，我从中偷偷的断开，不会对sshd服务有影响”，并且向我展示了`systemctl status sshd`妙用，查看有哪些主机进行ssh连接。

蓝色的IP是阿里云，绿色的四川绵阳，红色的俄罗斯。

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/ssh-ima-na.png)

被黑客入侵过多回，自己对阿里云这方面需求也少，就索性ban掉了ssh端口，有问题要咨询客服了才打开了。

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-02-12%2000.35.46.png)


[查找谁在破解你linux服务器的密码?](https://blog.csdn.net/jiedao_liyk/article/details/78460072)，查找 `/var/log/secure`也是种办法。[sohu-记一次主机入侵攻防大战：firewalld指定的IP段端口访问控制 ](https://www.sohu.com/a/229348161_587184)


也算发现不少问题

参考：

* [知乎专栏-SSH的使用详解](https://zhuanlan.zhihu.com/p/339808892)
* [cnblogs-ssh -D -L -R 差异](https://www.cnblogs.com/-chaos/p/3378564.html)
* [SSH 命令的三种代理功能（-L/-R/-D）](https://zhuanlan.zhihu.com/p/57630633)
* [百度文库-第十章 守护进程与计算机网络安全](https://wenku.baidu.com/view/d29e1399cd2f0066f5335a8102d276a20029608c.html)
* [51cto-守护进程与远程登录服务器](https://blog.51cto.com/wait0804/1783308)



