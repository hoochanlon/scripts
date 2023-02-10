# 我的Linux入门（2023.2.10）

一篇用爱发电的落后于时代的Linux折腾记录笔记。推荐Linux参考工具：[linux-command](https://wangchujiang.com/linux-command/)、[explainshell](https://www.explainshell.com)、[modern-unix](https://github.com/ibraheemdev/modern-unix)。

被黑客入侵主机挖矿后，我决定对垃圾的Linux毛坯房进行升级改造。

## 禁止程序联网

内核级的访问控制，比如SELinux，配置不当容易开不了机，而且很多操作也会受限，极其不方便。这里就只能列出用户规则与软件授权级的控制了。

### 用户组规则限制

阿里云客服给我找来了[“创建新用户，限制新用户联网”的解决方案](https://www.zhihu.com/question/419420632)，着实脑洞新奇。也确实，一个软件可能存在此相关的多个进程联网；而且还要一一知晓每个软件的联网进程名，这太反人类了。

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catzhihufwlinux.png)

<u>linux的权限采用的是文件-用户-用户组的模式，创建文件的用户具有文件的所有权限，一旦某个用户被突破，系统的风险的无限加大。</u>

参考：

* [csdn-LInux基础——SELinux](https://blog.csdn.net/qq_35258036/article/details/125932224)
* [huaweicloud-Ubuntu Apparmor 简介以及如何配置 Apparmor 配置文件](https://bbs.huaweicloud.com/blogs/371946)
* [csdn-SELinux如何永久禁用](https://blog.csdn.net/l_liangkk/article/details/114994446)
* [aws-在EC2上对SELinux故障进行紧急恢复以及排查的思路及方法](https://aws.amazon.com/cn/blogs/china/ideas-and-methods-for-emergency-recovery-and-troubleshooting-of-selinux-faults-on-ec2/?nc1=h_ls)

### Linux限制网络带宽— —Wondershaper

[yum 和 epel 的详解](https://jiuaidu.com/jianzhan/741516/)，简单说就是安装包更多。

```
sudo yum install epel-release
sudo yum install wondershaper
sudo systemctl enable wondershaper.service
sudo systemctl start wondershaper.service
# 上行带宽 -d；下行带宽-u 512.
sudo wondershaper -a eth0 -d 1024 -u 512
# 解除限制
sudo wondershaper -c eth0
```

参考：[在 Linux 中使用 Wondershaper 限制网络带宽](https://zhuanlan.zhihu.com/p/46121687)