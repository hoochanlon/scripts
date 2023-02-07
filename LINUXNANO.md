# LINUX遭遇网上的恶意脚本攻击

扫描到我云主机，并用脚本恶意破坏系统与Ddos攻击的“黑客”。据查为： https://github.com/Tremblae/Tremble 。

* 写好正则的手法去扫描检测公网云主机
* 通过常用的开放端口，不断用数据字典暴力破解密码，或是其他后门绕开密码，植入脚本
* 用脚本或打包好的二进制程序，卸载系统组件，乱改文件造成系统不稳定，并开放主机其他端口Ddos别人

![](https://fastly.jsdelivr.net/gh/hoochanlon/Free-NTFS-for-Mac/shashin/zei.png)

## 处理办法

### 1. 关闭不需要的远程端口，或修改成自己电脑的IP才能远程（为了方便考虑，不优先选择）

关闭自己不用的桌面系统远程端口，如Windows：3389，SSH：22，改成其他的端口。

````
cp /etc/ssh/sshd_config /etc/ssh/sshd_config_bak/sshd_config && vi /etc/ssh/sshd_config
# 找到 # port 22位置，在下方添加 port 1122
````

自己可临时百度IP，用公网IP登录。设置在“云服务器ECS” -> "ECS安全组"，编辑即可。注意：“0.0.0.0/0”代表任何人都能访问的。

### 2. 修改用户登录策略

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

### 3. 阿里云技术支持对小白的推荐（要钱）

* 操作系统加固：https://help.aliyun.com/knowledge_list/60787.html
* web应用加固：https://help.aliyun.com/knowledge_list/60792.html
