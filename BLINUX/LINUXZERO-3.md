# Linux云服务器一键搭建自用FTP脚本

在水区做了调查，大家普遍对Linux FTP搭建很简单，不过从我自己的实际搭建过程中却不太容易。为此特意做了开源与笔记化的一键脚本，注释全面，方便后续的学习与交流。

* 安全：
   * 私有化，限定自己的公网IP访问。
   * 限制用户出逃共享目录之外的目录，可读写。
   * 自定义用户名，密码符合Linux常规创建用户就行。
   * 对获取客户端IP进行了优化，从本机登录信息获取IP信息，彻底杜绝了从监听SSH端口抓取IP被混淆的风险。

虽说scp上传与下载也挺方便，但不方便目录的整体管理。而且刚入手学习Linux的人来说知道宝塔、Zfile各种面板的人也是少数，做一键脚本的目的也是帮助新人少走弯路。

起手方式不需要了解虚拟用户映射及FTP验证、PAM模块原理，一键搞定FTP。

```
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/lite_vsftpd.sh)"
```

最后在阿里云服务器的安全组，或腾讯云的防火墙放行21000端口，搞定。效果图如下：

图床由 https://cdn.jsdelivr.net 提供支持。

放行防火墙

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-02-28%2021.26.19.png)

已可读写

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-03-01%2015.39.06.png)

策略生效状态查看

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-03-01%2022.10.10.png)


后续的自定义，可略览如下相关文件，进行此方面相关的深入学习与研究。

* 共享目录：/var/ftp/share 
* 访问配置文件 /etc/security/access.conf
* FTP配置文件: /etc/vsftpd/vsftpd.conf
* FTP模块支持文件: /etc/pam.d/vsftpd