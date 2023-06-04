[Windows] 驱动管理软件-Driver Booster Pro V10.3.0.124 （2022.3.10当前最新）

Driver Booster这款软件，据多数网友反馈很不错。软件搬运至lrepacks，火绒正常。

> Driver Booster（驱动加速器）是IObit公司推出的一款针对Windows操作系统的电脑的驱动程序更新工具。更新驱动可以提升电脑硬件性能，减少系统崩溃降低硬件冲突。该驱动加速器软件可以通过智能的检测引擎有效识别电脑上过期的驱动程式（如，显卡驱动，声卡驱动，网卡驱动，打印机驱动等），并将结果呈现出来供查看。您可以选择要更新的驱动，然后点击更新按钮，程序就会自动下载安装最新驱动。 —— Driver Booster  百度百科

注意：静默安装默认没有快捷方式，需常规便携安装自行设置；俄语文本的安装步骤已添加用百度翻译的中文。

配置好DNS后，下载速度起飞。

效果图1

![ ](https://s2.xptou.com/2023/03/10/640adbc35331a.PNG)

效果图2

![](https://s2.xptou.com/2023/03/10/640adc4f38c65.PNG)

**软件下载：**

链接: https://pan.baidu.com/s/1U1Gk89SK2rtX8jjRM79C5w 提取码: xtdk  --来自百度网盘超级会员v3的分享

**下载驱动网速拉不动，三种解法**：

1. 走特定IP：[ucbug-IObit Driver Booster无法更新驱动的解决办法](https://www.ucbug.com/jiaocheng/132252.html) 所提到过的“菜单-设置-网络-自定义代理设置-主机：填入 140.227.10.189 端口：3128 最后点确定完成”（文章时间2021.7.22）。
2. 改hosts：卡1%方案（ [比驱动精灵好用的IObit Driver Booster Pro v7.2.0.601 Portable【绿色免安装版】出处: 吾爱破解论坛](https://www.52pojie.cn/thread-1097107-1-1.html)）
```cmd
echo "
127.0.0.1 asc55.iobit.com
127.0.0.1 is360.iobit.com
127.0.0.1 asc.iobit.com
127.0.0.1 pf.iobit.com" >> C:\Windows\System32\drivers\etc\hosts
```
3. 修改DNS：1.0.0.1、1.1.1.1（[Driver booster无法更新驱动 (出处: 吾爱破解论坛)](https://www.52pojie.cn/thread-1217009-1-1.html)）

我个人是用第三种办法，修改DNS，效果图如此前上述所示。复制如下这段代码保存为 `.bat` 文件即可一键设置DNS，或者管理员权限的CMD窗口单条命令回车。

```cmd
netsh interface ip set dns "以太网" static 1.0.0.1 primary
netsh interface ip add dns "以太网" 1.1.1.1
```

参考资料

* [driver booster无法更新   (出处: 吾爱破解论坛)](https://www.52pojie.cn/thread-1539190-1-1.html)
* [Driver booster无法更新驱动 (出处: 吾爱破解论坛)](https://www.52pojie.cn/thread-1217009-1-1.html)
* [比驱动精灵好用的IObit Driver Booster Pro v7.2.0.601 Portable【绿色免安装版】(出处: 吾爱破解论坛)](https://www.52pojie.cn/thread-1097107-1-1.html)
* [ucbug-IObit Driver Booster无法更新驱动的解决办法](https://www.ucbug.com/jiaocheng/132252.html) 
* [51cto-用netsh查看和设置IP地址、DNS地址、防火墙](https://blog.51cto.com/guochunyang/5851385)

