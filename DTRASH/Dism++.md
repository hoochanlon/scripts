# Dism++封装系统（适用企业标装环境）

### 操作与使用

使用系统自带的sysprep工具的oobe选项，之后进PE，打开Dism++，选择C盘里的系统，点击“文件”，另存为映像wim文件即可。这里需要说明，并不是wim文件的镜像sid就会变，而是勾选了oobe部署“新体验”才会重置sid。

进行封装前，保险起见还是得看看SID可重置的次数。win7默认是3次，win10是1001次。

```
slmgr /dlv
```

以管理员权限运行命令行

```bat
c:/windows/system32/sysprep/sysprep /oobe /generalize /reboot
```

![](https://s2.xptou.com/2023/03/15/64111bf17aba5.PNG)

这条命令是等价于[傲梅备份-使用Sysprep封装Win10、11的详细教程！](https://www.abackup.com/easybackup-tutorials/sysprep-encapsulates-windows-10-666.html)提到的如下配置方式，"进入系统全新体验（OOBE），勾选通用"。唯一的区别就是reboot和shutdown了。

![](https://www.abackup.com/easybackup-tutorials/images/sysprep-encapsulates-windows-10-666/2.png)

进入PE选择系统盘，右击“文件”，选择“另存为镜像”

![](https://s2.xptou.com/2023/03/15/6410a35e795c4.jpg)

正常保存就好了。

从[百度百科-卷影拷贝服务](https://baike.baidu.com/item/卷影拷贝服务/7295968?fr=aladdin)中的描述，可粗略的理解为相当于是你扔进回收站删除的东西、不同时间点有遗漏的，也还能找得回来。[从官方遗存的文档对“可启动”的说明来看](https://wenku.baidu.com/view/b40cf1219ec3d5bbfd0a74f5.html)，PE也是个小小系统壳，这选项是留个做PE的人用的。

<img src="https://s2.xptou.com/2023/03/15/6410a0b4678e4.jpg"  />

桌面软件及IE等相关设置都如同ghost镜像都保存了，并且重装三次，每次的SID都不一样。

![](https://s2.xptou.com/2023/03/15/6410a360f2b60.png)

### 发现与分享

单独格盘装系统不影响重置次数，已封装镜像再进行一次sysprep oobe才会影响。就傲梅所提到的“[在单个系统镜像上，您可以**运行8次**Sysprep。在运行这个工具8次之后，您需要重新创建您的系统镜像](https://www.abackup.com/easybackup-tutorials/sysprep-encapsulates-windows-10-666.html#toc.0.052977313769533296)”，可并没有说明具体系统，至少可以确定的是，win7、win10的默认重置数可不是这样。

简单说[cnblogs-Windows：sysprep.exe工具：审核模式 VS OOBE模式（工厂模式 VS 用户模式）](https://www.cnblogs.com/jinzhenshui/p/15138131.html)提到的几处关键点：勾选通用生成SID、OOBE全新体验为用户的个性化设置、系统审核模式基本上和域Windows server服务器装机一个性质，Administrator账户、进入系统前的预先安装，比如驱动安装等。

 链接: https://pan.baidu.com/s/1vd_nBPOIU1wp65bkd2GRWw 提取码: 8fu2 
--来自百度网盘超级会员v3的分享

| ventoy-1.0.89                      | 其他                                          |
| ---------------------------------- | --------------------------------------------- |
| Win7 usb3.0驱动纯净镜像（FAE自用） | 驱动注入与强制关闭win10更新（联想知识库工具） |
| Win10 1909                         | dism++ PDF文档                                |
| WeiPE_2.2+2.1+1.2.iso              | HEU_KMS_Activator_v26.0.0.exe.zip             |

<!-- ![](https://s2.xptou.com/2023/03/15/6410a45ae0b01.png) -->

参考：

* [csdn-pe查看原系统IP配置](https://blog.csdn.net/qq_36701078/article/details/116212330)
* [cnblogs-WIN2008R2/WIN2012R2等重新生成SID（服务器安全标识的ID）](https://www.cnblogs.com/pipci/p/15128926.html)
* [cnblogs-UUID、GUID、SID、SUSID](https://www.cnblogs.com/Chary/p/9771938.html)
* [spiceworks-change-sid-on-windows-10](https://community.spiceworks.com/topic/2319623-change-sid-on-windows-10)
* [ 华为云-Windows操作系统制作私有镜像为什么要执行Sysprep操作？](https://support.huaweicloud.com/ims_faq/ims_faq_0024.html)
* [百度百科-卷影拷贝服务](https://baike.baidu.com/item/卷影拷贝服务/7295968?fr=aladdin)
* [百度文库-Dism++帮助文档](https://wenku.baidu.com/view/b40cf1219ec3d5bbfd0a74f5.html)
* [jrjxdiy-封装windows镜像时sysprep重置次数超过限制的解决办法](https://www.jrjxdiy.com/windows/windows-sysprep-tries-limit.html)
* [傲梅备份-使用Sysprep封装Win10、11的详细教程！](https://www.abackup.com/easybackup-tutorials/sysprep-encapsulates-windows-10-666.html)
* [cnblogs-Windows：sysprep.exe工具：审核模式 VS OOBE模式（工厂模式 VS 用户模式）](https://www.cnblogs.com/jinzhenshui/p/15138131.html)