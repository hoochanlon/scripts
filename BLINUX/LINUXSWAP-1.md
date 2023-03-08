# python在Linux环境下编译安装

## 查阅python简单安装相关信息汇总

[Linux上面碰到鬼畜逆天级的软件依赖关系大家都是怎么解决的？ - 三级狗的回答 - 知乎](https://www.zhihu.com/question/291606128/answer/1194596591) 讲到了一些关键的要因，这也是他个人经验上的总结：

1. 提示即将安装某软件，但是现在的系统内的版本高于现在的版本，相当于系统不建议我们再搞了；如果非要硬上，很可能会破坏现有的程序依赖结构。影响小，软件崩溃，或影响其他软件的正常使用；影响大，用户界面、资源管理、甚至系统加载都会出问题。所以微软的兼容性确实相当好了。
2. dpkg、rpm两者都可以各自安装，只要安装的相关软件没对系统做特别要求，都能装。某个软件版本在一个管理包低了，就换个管理包装（互补）。
3. 知乎链接的答主这么能折腾的人，都没写面板的方式安装。更大可能是当时的宝塔这类的web面板还不支持这项功能。（2020.5）

同时也注意到了除虚拟容器docker之外的包管理器“nix”，从[ssine-Nix 入门介绍](https://ssine.ink/posts/intro-to-nix/)可以看出，使用nix的目的，不用去关心各种依赖，省心安装与卸载软件，能更好的管理软件环境。

安装方式查看资料：

| [51cto（译文）-Nix：纯粹功能型的Linux软件包管理器](https://www.51cto.com/article/587341.html) | [清华大学开源软件镜像站-Nix 镜像使用帮助](https://mirror.tuna.tsinghua.edu.cn/help/nix/) |
| ------------------------------------------------------------ | ------------------------------------------------------------ |

测试`nix-shell -p python311`安装与验证版本后，发现也这nix包管理器实际上也是管理包环境沙箱，类同于Mac下的PD虚拟机那种逻辑。还有比docker好的一点就是，名称和进程不会像docker管理的有些乱。

还有种方式就是[csdn-virtualenv系列 (1) · 导致Python多版本依赖困境的根源](https://blog.csdn.net/bluishglc/article/details/128300113)所提到的python专属的虚拟环境：Virtualenv用来管理python的多个版本。

## 编译安装体验

Linux终端的软件生态特性，照着他人博客来几乎一开始就必然失败的...所以先从基础的了解开始，再来慢慢编译安装、配置什么的。

### make

> 引用自 [webplus pro-浅析./configure、make、make install之间的关系](http://www.sudytech.com/_s80/65/c4/c3276a26052/page.psp)
>
> ./configure      就是设计部出了一张设计稿，根据客户需要，符合各种要求
>
> make      就是前端组做好了模板
>
> make install     就是实施人员将模板上传至了后台，而且做了各种模板绑定，能真正看到实际展示效果
>
> make clean 清除编译产生的可执行文件及目标文件

补：这是对[cnblogs-编译安装](https://www.cnblogs.com/machangwei-8/p/15495528.html)的这些相关内容形象、生动化的说明；make veryclean的理解，可以将 定义执行规则的makefile文件删除，完完全全的“白手起家，自己造”了。

### 不少博客中看到的python安装依赖项

据[cnblogs-Linux下编译安装python3](https://www.cnblogs.com/freeweb/p/5181764.html)所说，“如果没有这些模块在后面使用会出现一些问题”。


```shell
# 涉及传输与压缩
yum -y install zlib zlib-devel
# 无损压缩数据相关的东西
yum -y install bzip2 bzip2-devel
# 屏幕绘制以及基于文本终端的图形互动功能的动态
yum -y install ncurses ncurses-devel
# 没有readline则交互式界面删除键和方向键都无法正常使用
yum -y install readline readline-devel
# openssl则不支持ssl相关的功能（我的理解是影响到python支持其相关增强功能）
yum -y install openssl openssl-devel
# openssl编译成静态库, 包含进工程的好处是可以避免系统中其他openssl版本的影响
yum -y install openssl-static
# 两个压缩工具
yum -y install xz lzma xz-devel
# 给Linux存放临时数据调用信息的数据库
yum -y install sqlite sqlite-devel
# [csdn-[转]GDBM学习笔记](https://blog.csdn.net/heiyeshuwu/article/details/51519388)
# 从上方的文章得知，简单说就是数据持久化用的数据库系统。
yum -y install gdbm gdbm-devel
# 图形用户界面库
yum -y install tk tk-devel
# [cnblogs-外部函数接口 LibFFI](https://www.cnblogs.com/feng9exe/p/10396313.html) 
# 从上方文章得知，是一种语言调用另一种语言的库
yum -y install libffi libffi-dev
```

1. 这么多需要安装的依赖，我推测更大的可能是博客作者自己的需求，而不是python本身的必装项。我想，不少这方面转载及教程的笔者，可能混了许多的个人项，甚至一些依赖的作用关系，可能他自己也不清楚，只知道这样装不会错就行了。

2. 从[nginx安装过程中为啥同时需要zlib与zlib-devel，不是有zlib就可以了吗？](https://segmentfault.com/q/1010000041534545)问题的回答，得知是Linux发行版的分包策略所致，“运行环境”与“构建环境”相区分。

### 官网下载编译安装

[官网-在类Unix环境下使用Python](https://docs.python.org/zh-cn/3.11/using/unix.html#using-python-on-unix-platforms)

编译的话，是要指定目录`./configure --prefix=/usr/python`，而yum是不用的。

```shell
# 下载
wget https://www.python.org/ftp/python/3.11.2/Python-3.11.2.tgz
# 参考：[csdn-tar命令 zcvf,xvf的使用](https://blog.csdn.net/luolianxi/article/details/112915930)
# x解压、v过程、f指定文件名
tar -xf Python-3.11.2.tgz # 注意看解压名称。
# 进入目录
cd ~/Python-3.11.2
# 指定安装路径
./configure --prefix=/usr/python
# 编译安装
make && make install
# 创建软链接, -f 强制。
ln -sf /usr/python/bin/python3.11 /usr/bin/python3
```


