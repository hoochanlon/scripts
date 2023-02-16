# 自检与杀毒类民工科研究

了解个大概怎么回事就行了，至少不要想黑盒测试一样。顺便还看了一篇还不错的排查文章：[温州市公安局网络安全保卫支队-我的云服务器被植入挖矿木马，CPU飙升200%](https://baijiahao.baidu.com/s?id=1717502061981148613&wfr=spider&for=pc)。

## LinuxCheck自检脚本功能陈列

自检脚本功能陈列（非源码、仓库说明顺序，仅个人写作方便），以及个人对该脚本处理执行意义推测（括号内）：

### 检查内容分解 上

* 部分类型的挖矿木马检测、常规挖矿进程检测
* Python3 pip 检测（推测是脚本自身用到的依赖项检测，以及python也挺普遍的，二者都有吧）
* JSP、PHP webshell查杀 （常规，杀软河马查杀也有效果）
* Redis弱密码检测 （数据库缓存服务暴露在公网上，服务没设置密码，攻破后导致数据随意访问）
* SSH检查：SSH key显示罗列（比对用的）、SSH inetd(特权提升)、软连接后门、SSH暴破IP统计
* Rootkit检查：
    * lsmod可疑模块罗列（认为可疑的逻辑：控制系统内存，以及类似增强型功能的支持扩展，可能造成系统不稳定。）
    * Rootkit 内核模块（病毒样本的模块吧）
    * `/usr/src/ofa_kernel/default/compat/mlx_compat.ko`

通过`modinfo mlx_compat`的回显来看，大概是兼容、移植用的；百度再往下搜就会找到“学术”、“专利”相关的文章，这倒让我挺惊奇意外的。

参考：

* [csdn-linux权限提升——inetd服务后门](https://blog.csdn.net/qq_50854790/article/details/123014484)
* [cnblogs-losbyday-SSH详解](https://www.cnblogs.com/losbyday/p/5859880.html)
* [cnblogs-lsmod命令详解](https://www.cnblogs.com/machangwei-8/p/10398706.html)
* [linuxstack-linux命令 - lsmod, 显示已载入系统的模块](https://www.oomspot.com/post/linuxminglinglsmodxianshiyizairuxitongdemokuai)
* [csdn-【linux】内核模块管理：lsmod、insmod、rmmod、modinfo、modprobe、depmod命令](https://blog.csdn.net/bandaoyu/article/details/128582615)
* [刘大湿-[Linux] modinfo命令：显示kernel模块的信息](https://www.liuzhongwei.com/page/2194.html)
* [csdn-Redis？它主要用来什么的](https://blog.csdn.net/u014723137/article/details/125658176)
* [csdn-Redis系列漏洞总结](https://blog.csdn.net/weixin_52118430/article/details/127441743)
* [csdn-Redis漏洞汇总](https://blog.csdn.net/Jietewang/article/details/119540542)
* [浅析Linux系统入侵排查与应急响应技术](https://zhuanlan.zhihu.com/p/450512117)

### 检查内容分解 中

* Bash配置检查：
    * History （**`history -a` 从缓存中取出历史记录。**）
    * `/etc/rc.local` （**是`/etc/rc.d/rc.local`的软连接，查看自启服务的；**默认没有执行权限，需手动修改。）
    * `/etc/profile` （**全局的环境变量配置文件**,这里修改会对所有用户起作用。）
    * `$HOME/.profile` （**对当前用户的家目录的有用，修改后，`source`更新**）
    * `~/.bash_profile` （**它只能登入的时候执行一次。**）
    * `~/.bashrc` (**同`~/.bash_profile`，最大区别：shell script每次都会执行。**)
    * bash反弹shell（**简单粗糙的理解就是，我执行的shell，传到你机器上执行。**）
* 环境变量检查：
    * PATH
    * LD_PRELOAD（**抓关键句快速了解：它允许你定义在程序运行前优先加载的动态链接库，另一方面，我们也可以以向别人的程序注入程序，从而达到特定的目的。**）
    * LD_ELF_PRELOAD、LD_AOUT_PRELOAD （**ELF，简单理解，参与程序的调度连接与执行。(涉及汇编知识)**）
    * PROMPT_COMMAND (`export PROMPT_COMMAND="echo Hello" `查看异常的命令导入)
    * ld.so.preload (**通过配置`/etc/ld.so.preload`，可以自定义程序运行前优先加载的动态链接库**)
* 服务信息检查与任务检查：（**主要问题点是隐藏后门，植入一般用户不了解的模块、运行编辑器附加命令、系统回显截断机制。**）
    * 正在运行的Service
    * 最近添加的Service
    * Crontab
    * Crontab Backdoor

参考：

* [知乎专栏-Linux 简要后门入门](https://zhuanlan.zhihu.com/p/486774390)
* [先知社区-linux常见backdoor及排查技术](https://xz.aliyun.com/t/10079)
* [csdn-Linux history -w 与 history -a 功能区别](https://blog.csdn.net/weixin_44629980/article/details/124467009)
* [简书 - /etc/profile - 环境变量](https://www.jianshu.com/p/1dd22f5b521a)
* [csdn - linux的/etc/rc.local文件(开机自启)](https://blog.csdn.net/ws_kfxd/article/details/110088503)
* [云海天教程网-bashrc与profile的区别](https://www.yht7.com/news/9382)
* [cnblogs-反弹bash shell命令详解](https://www.cnblogs.com/pandana/p/16289320.html)
* [tinylab-一起看看那些经典的 LD_PRELOAD 用法](https://tinylab.org/using-ld_preload/)
* [奇安信攻防社区-深入分析 LD_PRELOAD](https://forum.butian.net/share/1493)
* [csdn -linux库的制作--静态库、动态库（共享库）](https://blog.csdn.net/qq_54075859/article/details/126611696)
* [简书-ELF文件运行时动态链接](https://www.jianshu.com/p/16e97c8e629f)
* [cnblogs-LD_PRELOAD的偷梁换柱之能](https://www.cnblogs.com/net66/p/5609026.html)
* [先知社区-蓝队基础：安全运维防护浅析](https://xz.aliyun.com/t/10197)
* [BASH脚本基础：环境变量PROMPT_COMMAND介绍](https://blog.csdn.net/liumiaocn/article/details/104113262)
* [温州市公安局网络安全保卫支队-我的云服务器被植入挖矿木马，CPU飙升200%](https://baijiahao.baidu.com/s?id=1717502061981148613&wfr=spider&for=pc)


### 检查内容分解 下

* 文件检查：
    * 系统文件修改时间
    * 7天内改动文件、大于200M文件
    * 可疑黑客文件（）、敏感文件、隐藏文件
    * 临时目录/tmp 
    * alias
    * SUID：/usr/libexec/abrt-action-install-debuginfo-to-abrt-cache
    * lsof +L1
* 基础配置检查：
    * 系统配置信息、登陆用户、hosbv
    * CPU使用率/CPU TOP15/内存占用 TOP15、内存占用/硬盘剩余空间
    * 硬盘挂载、常用软件
* 网络/流量检查
    * ifconfig、网卡混杂模式、TCP连接类别
    * 端口监听、对外开放端口
    * 网络连接、网络流量、路由表、路由转发
    * DNS、ARP、IPTABLES
* 用户信息检查：可登陆用户、登录信息、密码文件修改日期、sudoers（特权提升文件）



## clamav 杀毒策略


* [docs.clamav-faq-scan-alerts](https://docs.clamav.net/faq/faq-scan-alerts.html)
* [zabbx-clamav开源杀毒软件部署和使用](https://www.zabbx.cn/archives/clamav开源杀毒软件部署和使用)