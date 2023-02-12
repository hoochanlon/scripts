# 记上次黑客入侵阿里云主机 —— 入侵行为分析

> ***防治手段转到[LINUXINTRO-0 SSH密钥策略](/LINUXINTRO-0.md)与[LINUXINTRO-0 FAIL2BAN策略](/LINUXINTRO-1.md)。***
> ***注：一旦主机被黑客破解，通常都会在主机登录上，驻留SSH密钥，以及其他软件服务等登录的通行证后门。***

## 入侵方式

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

上回分析过病毒源码，这回来看个图, 顺便了解下[腾讯主机安全（云镜）捕获挖矿木马源码分析](https://s.tencent.com/research/report/1181.html)，加强理解。

> 转 [cnblogs-双平台传播——活跃的H2Miner组织挖矿分析](https://www.cnblogs.com/bonelee/p/16378059.html)

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/c-3-1.jpg)


## 附录与参考资料

### 清除SSH密钥后门



### 参考

* [使用Medusa美杜莎暴力破解SSH密码-51CTO博客](https://blog.51cto.com/u_15766933/5630258)
* [Docker SYS_ADMIN 容器逃逸原理解析 - FreeBuf网络安全行业门户](https://www.freebuf.com/vuls/264843.html)
* [Linux默认端口，如何防止被恶意扫描](https://www.bilibili.com/read/cv6200341)
* [Linux/centos减轻/防止DDoS攻击的轻量级小程序，软件防火墙 - 大概是个博客](https://dagai.net/archives/893)
* [腾讯主机安全（云镜）捕获挖矿木马4SHMiner，已有上万服务器受害(2020)](https://s.tencent.com/research/report/1181.html)
* [cnblogs-双平台传播——活跃的H2Miner组织挖矿分析](https://www.cnblogs.com/bonelee/p/16378059.html)
