# 我的Linux入门（2023.2.10）

一篇用爱发电的落后于时代的Linux折腾记录笔记。推荐Linux参考工具：[linux-command](https://wangchujiang.com/linux-command/)、[explainshell](https://www.explainshell.com)、[modern-unix](https://github.com/ibraheemdev/modern-unix)。

被黑客入侵主机挖矿后，我决定对垃圾的Linux毛坯房进行升级改造。

## 禁止程序联网

### Linux奇葩防火墙

Linux的逻辑和我们平常见到的图形操作系统Windows、macOS不太一样，指定一个某某程序，禁止它们联网。在Windows、macOS很容易，如[win7禁止应用程序联网](https://blog.csdn.net/linxi8693/article/details/107205322/)；可到了Linux，却不是很好办了...防火墙主要针对于web、ftp等这类资源访问服务器的。而且呢，这类不少的软件产品也是要钱的。看来正版Windows贵，使用起来也为广大人民群众所接受的产品，这也是有道理的。Linux难用但免费，不过是企业省钱，加之术业有专攻罢了。

阿里云客服给我找来了[“创建新用户，限制新用户联网”的解决方案](https://www.zhihu.com/question/419420632)，着实脑洞新奇。也确实，一个软件可能存在此相关的多个进程联网；而且还要一一知晓每个软件的联网进程名，这太反人类了。

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catzhihufwlinux.png)

现在的Linux，通过web访问，也有图形化的配置界面了，安装软件什么的，也如同Windows一样简单。就比如说[mdserver-web](https://github.com/midoks/mdserver-web)、[宝塔面板](https://www.bt.cn/new/index.html)，也难怪这么多卖防火墙的，像深信服、山石都是的，以及阿里搞什么加钱购买的云盾防火墙，就是这个理。

