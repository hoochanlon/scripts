# 记阿里云主机再一次被黑客恶意脚本攻击

## 登录阿里云控制台，查看安全告警信息，并联系客服咨询有关事件详情

接到手机上的短信，我及时联系了他们阿里云的客服，看了下控制台提供的黑客线索

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/2e706e67.png)

注意到了 https://github.com/Tremblae/Tremble 的信息，主机重置快一个多来月了，这家伙又一次暴破了我的云主机。

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-02-07%2009.54.20.png)

这么高的CPU占用，我根据其进程及阿里云提供的线索，注意到了“xmrig”的进程。

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-02-07%2015.51.54.png)

下载其文件查看了json文件，已坐实黑客暴力破解及利用其他程序漏洞，攻入我的阿里云主机进行挖矿！

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-02-07%2016.05.51.png)

关于黑客仓库里的其他文件，我对阿里云客服也进行了咨询，据客服所述："通常黑客会隐蔽自己的真实IP，用正则扫描检测公网云主机及开放端口；然后不断用数据字典暴力破解密码，或是其他后门绕开密码植入脚本，或其他二进制程序；这种脚本及程序，通常会卸载系统组件，乱改文件造成系统不稳定，并开放主机其他端口Ddos别人"。

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-02-07%2016.57.43.png)

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-02-07%2016.57.59.png)

## 清理病毒的参考资料

昨天才安装体验试用了下Clamav，没想到这次居然没起到其杀毒软件的作用啊...也不知道后来了解到的河马查杀效果怎样。经过这次事件后，我对Linux平台杀毒软件检测病毒的能力，也不是太乐观。

了解黑客攻击云主机的行为方式：

* [Daryl179-阿里云服务器被挖矿的解决方法-csdn](https://blog.csdn.net/qq_47464056/article/details/125970479)
* [Daryl179-使用Kali对网站进行DDos攻击-csdn](https://blog.csdn.net/qq_47464056/article/details/127553734?spm=1001.2014.3001.5502)
* [极客飞扬-排查Linux系统下SSH被暴力破解植入pnscan 挖矿病毒入侵服务器](https://www.cnblogs.com/rmfit/p/15624873.html) 

定时任务关闭及清除：

* [-阿里云ECS遭挖矿程序攻击解决方法（彻底清除挖矿程序，顺便下载了挖矿程序的脚本）](https://blog.csdn.net/NicolasLearner/article/details/119006769)
* [阿里云安全中心-挖矿程序处理最佳实践](https://help.aliyun.com/document_detail/161236.htm?spm=5176.smartservice_service_robot_chat_new.0.0.37c73f1bUDrKsc#section-xgd-9mh-f0e)

由于是免费领的阿里云主机，我基本上很少登录，所以没配置安装软件之类的，索性把root的定时任务全清除了。

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-02-07%2010.31.54.png)


## 后续策略

土豪或企业交给阿里云团队维护另说，这里分享下我了解到的处理方式。

### 1. 修改用户登录策略

***虽然他们文章是不错参考资料，但必须要注意Linux的版本号，版本不一样，命令也是大有改动。19年的centos8取消了pam_tally2模块，但网上不少文章是2022、2020，他们可能当时就是用的centos8以下。***

* [linux 终端 设置连接登录密码 + 登录失败处理功能策略](https://www.cnblogs.com/qwer78/p/16546372.html)
* [uos账号解锁](https://blog.csdn.net/qq_35957643/article/details/125277224)
* [CentOS 8.0配置安全策略（用户3次登录失败锁定3分钟）](https://zhuanlan.zhihu.com/p/127109500?utm_id=0)

以上总结是CentOS8对修改sshd文件的教训，只适合CentOS7及以下。还学到一招查看日志信息`tail -f /var/log/messages`。

修改配置

```
vi /etc/pam.d/system-auth
# 顶行复制如下指令，即默认所有用户通用处理。
auth required  pam_faillock.so preauth silent audit deny=3  unlock_time=300 even_deny_root
```
解锁用户

```
# 解锁一个用户
faillock --user It --reset
# 解锁所有用户
faillock--reset
```

阿里给出的[《Linux操作系统加固》](https://help.aliyun.com/knowledge_list/60787.html)文档，本质上就是用户登录策略...不过文档挺好、挺详细的。

### 2. 关闭不需要的远程端口及ICMP回显（ping）

关闭自己不用的桌面系统远程端口，如Windows：3389，SSH：22，改成其他的端口。

````
cp /etc/ssh/sshd_config /etc/ssh/sshd_config_bak/sshd_config && vi /etc/ssh/sshd_config
# 找到 # port 22位置，在下方添加 port 1122
````

但完全限死，只用VNC登录使用的话，太难受了...😂

### 3. 限制IP或更换IP

“0.0.0.0/0”，任何人都能访问，还是不太安全啊...百度关键字“IP”，临时用自己的公网IP登录，弄个弹性IP，换下IP也行吧...不过由于我个人在云主机没放什么重要东西，也没部署ftp、web等服务啥的，用的时候登录网页开启远程访问端口，这样也可以。

### 4. 若是自己存有重要资料及配置，那就自己做好每天的快照备份。

Linux不像微软的Windows那么服务到位，还有补丁推送，有不少杀软防护。基本上一切都得自己来。想要高枕无忧的话，找阿里那得加钱买服务，[web应用加固](https://help.aliyun.com/knowledge_list/60792.html)，[企业支持](https://www.aliyun.com/service/supportplans)，都是一堆要钱的玩意，不太适用于我们这种个人用户。Linux恶意脚本通过其他程序服务上的机制漏洞，打开及利用这一程序后门，绕过密码注入脚本，搞破坏、静默上传下载、恶意ddos、挖矿等什么的，以及客服也对我给出了阿里云高危漏洞通报的访问入口：https://avd.aliyun.com/high-risk/list 。

![ ](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-02-07%2015.24.45.png)

总的来说，恶意脚本、软件不时重启打开，又会额外又生成多个脚本垃圾等；待到下次系统启动时，没查杀到的文件又会再自启运行生成其他文件，如此循环是挺难根除的。这样的话，还不如备份快照还原来得快。


### 关于我个人关于对黑客行为的几点猜想

* 受为KPI的媒体小编所胡吹乱奏的“黑客行为”所影响，觉得很酷、很炫，出人头地。
* 无聊搞事，个性上有些无的放矢，来恶心和报复社会的。
* 不排除他是失业者，又或是其他职业，有些大把时间闲着没事做的人。
* 一些不良组织团体或个人挖矿，所进行的整活。
