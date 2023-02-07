# LINUX遭遇网上的恶意脚本攻击

扫描到我云主机，并用脚本恶意破坏系统与Ddos攻击的“黑客”。据查为： https://github.com/Tremblae/Tremble 。

* 写好正则的手法去扫描检测公网云主机
* 通过常用的开放端口，不断用数据字典暴力破解密码，或是其他后门绕开密码，植入脚本
* 用脚本或打包好的二进制程序，卸载系统组件，乱改文件造成系统不稳定，并开放主机其他端口Ddos别人

![](https://fastly.jsdelivr.net/gh/hoochanlon/Free-NTFS-for-Mac/shashin/zei.png)

## 后续策略

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

### 2. 关闭不需要的远程端口及ICMP回显。

关闭自己不用的桌面系统远程端口，如Windows：3389，SSH：22，改成其他的端口。

````
cp /etc/ssh/sshd_config /etc/ssh/sshd_config_bak/sshd_config && vi /etc/ssh/sshd_config
# 找到 # port 22位置，在下方添加 port 1122
````

自己可临时百度IP，用公网IP登录。设置在“云服务器ECS” -> "ECS安全组"，编辑即可。注意：“0.0.0.0/0”代表任何人都能访问的。由于是自己用搞着玩，又没有部署数据库、文件、网页等服务，用的时候登录网页开启远程访问端口。

### 3. 若是自己存有重要资料及配置，那就自己做好每天的快照备份。

Linux不像微软的Windows那么服务到位，还有补丁推送，有不少杀软防护。一切基本上都得自己来。想要高枕无忧的话，找阿里那得加钱买服务，企业支持什么的。Linux恶意脚本通过其他程序服务上的机制漏洞，打开及利用这一程序后门，绕过密码注入脚本，搞破坏、静默上传下载、恶意ddos、挖矿等什么的。此外恶意脚本、软件不时重启打开，又会额外又生成多个脚本垃圾等，等下一次自启时，没查杀到的文件又一次自启生成运行，反复不觉，不好彻底清理。还不如备份快照还原来得快。

阿里云已报漏洞信息访问入口：https://avd.aliyun.com/high-risk/list

### 4. 阿里云技术支持对小白的推荐（要钱）

* 操作系统加固：https://help.aliyun.com/knowledge_list/60787.html
* web应用加固：https://help.aliyun.com/knowledge_list/60792.html
