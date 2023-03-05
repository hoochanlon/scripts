### ddos、堡垒机、云蜜罐

* [csdn-什么是高防IP？](https://blog.csdn.net/qq_44887910/article/details/128775342)
* [新网知识社区-常见的ddos防护方法有哪些？](https://blog.csdn.net/weixin_45761101/article/details/121940520)
* [jumpserver/jumpserver](https://github.com/jumpserver/jumpserver)
* https://github.com/hacklcx/HFish
* https://github.com/birdhan/SecurityProduct

### 网络修改

* [linux设置软链接](https://www.cnblogs.com/dengsheng/p/16313069.html)
* [51cto-linux 添加路由 ](https://blog.51cto.com/crazyming/568781)
* [百家号-如何在 Linux 中使用 nmcli 命令配置 IP 网络](https://baijiahao.baidu.com/s?id=1752077717322308869&wfr=spider&for=pc&searchword=Linux网络配置nmui)（nmcli ）

nmcli 永久生效的；ifconfig 临时生效。

#### 特权提升与密码破解

* [详细|Linux提权总结](https://blog.csdn.net/st3pby/article/details/127718846)
* [腾讯新闻-Linux特权提升技术合集](https://view.inews.qq.com/k/20211015A001PB00?web_channel=wap&openApp=false)
* [cnblogs-【THM】John The Ripper(hash破解工具)-学习](https://www.cnblogs.com/Hekeats-L/archive/2022/09/30/16745318.html)

### 勒索病毒

* https://www.nomoreransom.org/en/decryption-tools.html
* https://lesuobingdu.360.cn

## docker

* [www.freebuf.com-内网代理转发工具总结](https://www.freebuf.com/sectool/308049.html)
* [Error starting userland proxy: listen tcp4 0.0.0.0:8005: bind: address alrea](https://blog.csdn.net/qwq1518346864/article/details/117597351)
* [xiebruce.top-macOS使用了代理也无法ping通google的原因及其解决办法](https://www.xiebruce.top/1718.html)
* [csdn-Linux端口转发的几种常用方法](https://blog.csdn.net/u010680373/article/details/124779749)

<s>yum install docker -y </s> 少走弯路，按官网配置

```
# 查找端口进程
netstat -tanlp
# 杀掉相关进程
sudo kill 4257
# 容器进程
docker ps 
# 杀死容器进程
podman kill "docker容器进程ID" > /dev/null 2&>1

yum install -y epel-release
yum install -y httping
# 使用方法
httping -x 127.0.0.1:1087 -g https://www.google.com

# 即便使用了代理，chatgpt依旧会检查是否为代理IP，而ban IP。


# * [cnblogs-怎么让 Linux 进程在后台运行](https://www.cnblogs.com/iluoye/p/16620660.html)
# * [Podman一篇就学会](https://blog.csdn.net/hyhxy0206/article/details/121943182)
```
