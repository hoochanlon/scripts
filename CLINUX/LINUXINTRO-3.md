# 我的Linux入门 下载及使用软件

> 一篇用爱发电的落后于时代的Linux折腾记录笔记。推荐Linux参考工具：[linux-command](https://wangchujiang.com/linux-command/)、[explainshell](https://www.explainshell.com)、[modern-unix](https://github.com/ibraheemdev/modern-unix)。

## 简单使用

首先将压缩软件换成7zip。自带解压上手起来，徒增学习成本，冗长的命令，不方便操作。

```
# a 添加压缩包 x 解压
# 参考文档：https://wiki.archlinux.org/title/p7zip
yum install -y p7zip
```

## Mac使用SCP上传与拷贝文件

先试试能不能ping通Linux，`ping 101.xx.xx.xx -c 3`。

Mac上传文件到Linux

```
scp /Users/chanlonhoo/Downloads/cake1.PNG root@101.xx.xxx.xxx:/
```

Mac从Linux上下载文件

```
scp root@101.xx.xx.xxx:/cake1.PNG /Users/chanlonhoo/Downloads
```

bash: scp: 未找到命令 lost connection；在Linux上安装便可解决。

```
yum install openssh-clients*
```

参考：[csdn-bash: scp: 未找到命令 lost connection](https://blog.csdn.net/weixin_44825767/article/details/112209810)

## 下载ClamAV和更新病毒库

给自己来上安慰剂...

```
# freshclam为更新病毒库。
yum install clamav && freshclam
```

扫描；-r：迭代目录；-l：指定路径；--max-dir-recursion：指定目录层级。

```
clamscan -r /etc --max-dir-recursion=5 -l /var/log/clamav-scan.log
```

扫描根目录，记录到日志，并删除可疑文件。

```
clamscan -r / -l /var/log/clamscan.log --remove
```

`crontab -e`设置定时任务，注意：定时任务通常都是后台静默运行，没有echo，不会回显在终端。 [跳转LINUXZERO-0.md#clamav](https://github.com/hoochanlon/ihs-simple/blob/main/LINUXZERO-0.md#clamav简明使用)

```
0 3 * * * * clamscan -r / -l /var/log/clamscan.log --remove
```


详请参考：

* [BASH脚本基础：环境变量PROMPT_COMMAND介绍](https://blog.csdn.net/liumiaocn/article/details/104113262)
* [csdn-linux系统定时任务与延迟任务](https://blog.csdn.net/westos_yanzheng/article/details/126604664)
* [csdn-云服务器Linux挖矿病毒杀毒软件clamscan安装](https://blog.csdn.net/m0_59069586/article/details/126956289)
* [51cto-Linux下杀毒软件（ClamAV）安装及使用](https://blog.51cto.com/u_9691128/4293334)
* [betheme.net-centos7.6 yum安装clamav 进行病毒扫描查杀](https://betheme.net/news/txtlist_i98729v.html)
