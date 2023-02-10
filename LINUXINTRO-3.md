# 我的Linux入门 下载及使用软件

> 一篇用爱发电的落后于时代的Linux折腾记录笔记。推荐Linux参考工具：[linux-command](https://wangchujiang.com/linux-command/)、[explainshell](https://www.explainshell.com)、[modern-unix](https://github.com/ibraheemdev/modern-unix)。


## 简单使用

首先将压缩软件换成7zip。自带解压上手起来，徒增学习成本，冗长的命令，不方便操作。

```
# a 添加压缩包 x 解压
# 参考文档：https://wiki.archlinux.org/title/p7zip
yum install -y p7zip
```

从Linux下载文件到本地，先安装lrzsz，`sz 对应的文件名` 即下载。`rz 对应的文件名` 即上传（仅限文件类别）。

```
yum install lrzsz
```

进阶使用scp，上传下载文件（拷贝）。



## 下载ClamAV和更新病毒库

目前Linux的免费杀软跟玩具代码，安慰剂一样，挡不住挖矿病毒。

```
# freshclam为更新病毒库。
yum install clamav && freshclam
```

扫描；-r：迭代目录；-l：指定路径；--max-dir-recursion：指定目录层级。

```
clamscan -r /etc --max-dir-recursion=5 -l /home/www/clamav-scan.log
```

类似软件还有河马查杀：https://www.shellpub.com/doc/hm_linux_usage.html

