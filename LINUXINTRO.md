## Linux云服务器初体验

### 连接、配置、上传与下载

连接主机输入主机密码，设置主机名。

``` 
# 连接主机
ssh root@公网IP
# 设置主机名
hostnamectl set-hostname xiaohong
# 正常设置主机名需要重启，执行bash刷新
bash
````

现象：由于ssh的加密性质，电脑重装之后，远程输入密码就登陆不上了。解决办法：电脑设置一次VNC，此时需要删除ssh的hnown_hosts。

```
rm -rf ~/.ssh/known_hosts && rm -rf ~/.ssh/known_hosts.old
```

从Linux下载文件到本地，先安装lrzsz

```
yum install lrzsz
```

* `sz 对应的文件名` 即下载。
* `lz 对应的文件名` 即上传。


### 网上的恶意脚本攻击

扫描到我云主机，并用脚本恶意破坏系统与Ddos攻击的“黑客”。据查为： https://github.com/Tremblae/Tremble 。

* 写好正则的手法去扫描检测公网云主机
* 通过常用的开放端口，不断用数据字典暴力破解密码，或是其他后门绕开密码，植入脚本
* 用脚本或打包好的二进制程序，卸载系统组件，乱改文件造成系统不稳定，并开放主机其他端口Ddos别人

![](https://fastly.jsdelivr.net/gh/hoochanlon/Free-NTFS-for-Mac/shashin/zei.png)

处理办法：

关闭自己不用的桌面系统远程端口，如Windows，3389。“0.0.0.0/0”是任何人都能访问的，自己可临时百度IP，用公网IP登录。设置在“云服务器ECS” -> "ECS安全组"，编辑即可。

阿里云技术支持的推荐

* 操作系统加固：https://help.aliyun.com/knowledge_list/60787.html
* web应用加固：https://help.aliyun.com/knowledge_list/60792.html

## Linux那奇葩的防火墙

