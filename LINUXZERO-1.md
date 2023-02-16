## 自检与杀毒民工科研究

## LinuxCheck自检脚本功能陈列

自检脚本功能陈列（非源码、仓库说明顺序，仅个人写作方便），以及个人对该脚本处理执行意义推测（括号内）：

### 检查内容分解 上

* 部分类型的挖矿木马检测、常规挖矿进程检测
* Python3 pip 检测（推测是脚本自身用到的依赖项检测，以及python也挺普遍的，二者都有吧）
* JSP、PHP webshell查杀 （常规）
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

### 检查内容分解 中

* Bash配置检查：
    * History （**`history -a` 从缓存中取出历史记录。**）
    * `/etc/rc.local` （**是`/etc/rc.d/rc.local`的软连接，查看自启服务的；**默认没有执行权限，需手动修改。）
    * `/etc/profile` （**全局的环境变量配置文件**,这里修改会对所有用户起作用。）
    * `$HOME/.profile` （**对当前用户的家目录的有用，修改后，`source`更新**）
    * `~/.bash_profile` （**它只能登入的时候执行一次。**）
    * `~/.bashrc` (**同`~/.bash_profile`，最大区别：shell script每次都会执行。**)
    * bash反弹shell
* 环境变量检查：
    * PATH
    * LD_PRELOAD、LD_ELF_PRELOAD、LD_AOUT_PRELOAD
    * PROMPT_COMMAND
    * ld.so.preload
* 服务信息检查：
    * 正在运行的Service
    * 最近添加的Service
* 任务检查
    * Crontab
    * Crontab Backdoor

参考：

* [csdn-Linux history -w 与 history -a 功能区别](https://blog.csdn.net/weixin_44629980/article/details/124467009)
* [简书 - /etc/profile - 环境变量](https://www.jianshu.com/p/1dd22f5b521a)
* [csdn - linux的/etc/rc.local文件(开机自启)](https://blog.csdn.net/ws_kfxd/article/details/110088503)
* [云海天教程网-bashrc与profile的区别](https://www.yht7.com/news/9382)


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