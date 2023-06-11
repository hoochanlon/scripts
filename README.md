# ***<s>[ihs-simple](https://github.com/hoochanlon/ihs-simple/blob/main/THINGS.md#picgo)</s>***

[![blog](https://img.shields.io/badge/%F0%9F%94%97blog-hoochanlon-lightgrey.svg?longCache=true&style=flat-square)](https://hoochanlon.github.io/) [![outlook](https://img.shields.io/badge/%F0%9F%93%A7hotmail-@邮箱联系-blue.svg?longCache=true&style=flat-square)](mailto:hoochanlon@outlook.com)[![](https://img.shields.io/github/followers/hoochanlon?color=green&style=social)](https://github.com/hoochanlon) [![](https://img.shields.io/github/stars/hoochanlon?color=green&style=social)](https://github.com/hoochanlon)

## 前言

一开始只是用来做图床，图省事方便偶尔随手上传自己的小脚本，结果却成了脚本库。至于所谓“技术”方面的东西，找个专门的平台发稿就行了。现在想来，那些在xx之家、xx论坛投稿的，也是聪明人。SEO、宣传什么的就交由他们去吧。

免责声明：所有脚本与指令、病毒分析文章，仅面向研究与学习交流之用，切勿用于其他非法用途！

<details>
<summary><B> other </B></summary>

Linux迁移 Windows command 工具：

* [cygwin](http://www.cygwin.com) 类子系统
* [gnuwin32](http://gnuwin32.sourceforge.net)、[minGW](http://www.mingw.org)  保持原生环境，尽可能提供类似的方案

python环境问题

* pyenv+pipx+poetry
  * pyenv灵活地安装与切换python版本，搭配poetry可快速生成相应版本环境。
  * pipx升级依赖工具包方便，不用担心全局兼容问题。
  * 编译的程序通常会依赖各种包，这个要看开发者给出相应提示安装哪些包了。
* miniconda、anaconda这类python发行版，依赖库齐全。

</details>


## 资讯收集（小试牛刀）

<details>
<summary><B> 点击详情 </B></summary>

一键生成全球信息报表 [图文版](https://www.52pojie.cn/thread-1779165-1-1.html)

```
python -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/get_worldometers.py)"
```

一键获取中国新闻网资讯 [图文版](https://www.52pojie.cn/thread-1780608-1-1.html)

```
python -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/get_chinanews.py)"
```

</details>

## 常见平台热搜与辟谣信息分析

<details>
<summary><B> 点击详情 </B></summary>

### 头条、抖音、微博热搜采集分析
 
一键获取今日头条、抖音、微博热搜。[图文版](https://www.52pojie.cn/thread-1785460-1-1.html) （NLP：[Stanza](https://stanfordnlp.github.io/stanza/data_objects.html)）

```
python -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/get_resou_today_s.py)"
```

* 自动化分类；整体匹配率：84%~96% 区间左右。
* 词频统计；三者共存的热搜，说明为持久公共热度，信息密度较高。
* 文本情感平均值、每条标题的情感数值；主：人为置顶热搜的文本情绪强烈程度。
* 词性分析；标记可能存有引导与被植入意识成分用词，只要定语、状语叠得多，总能是宣传正态形势。

微博在自动化分类中，噪音三者最大，信息价值低，话题含水量大，失真度偏高；各家平台的热搜标题也存有未标识谣言成分，最好用[国家辟谣平台查询](https://www.piyao.org.cn/pysjk/frontsql.htm)鉴别其真伪；虽然娱乐属性极重，但微博其本身具有一对多公共属性的社交模式，当某个社会事件被挂上热搜，它可在短时间内迅速传播信息，引发公众的关注和讨论。

推荐论文：

* 毛贺祺《大数据背景下微博热搜的新闻阅读服务功能》吉林大学新闻学专业硕士学位论文，2017.3<br>
* 喻国明《大数据分析下的中国社会舆情 总体态势与结构性特征》中国人民大学学报，2013年第５期<br>
* 王小新《当前我国受众网络新闻的阅读倾向——以百度热搜词为例》《今传媒》，2013年第9期<br>
* 许诺《基于百度热搜新闻词的社会风险事件5W提取研究》《系统工程理论与实践》，2022年第40卷第2期<br>


### 自动化收集辟谣条目及语言分析（NLP：[ThuLAC](https://github.com/thunlp/THULAC-Python)）

功能大体与上例相当，对词频的较高词语进行语法分析。

```
python -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/get_rumor_analysis.py)"
```
 
urllib3：https://github.com/urllib3/urllib3/issues/3020#issuecomment-1557412175

对谣言的定义：阿尔波特(Gordom W.Allport)和波兹曼(Leo Postman)最早为谣言下了定义,即谣言是一个与当时事件相关联的命题,是为了使人相信,一般以口传媒介的方式在人们之间流传,但是却缺乏具体的资料以证实其确切性。[^《全媒体时代网络谣言产生的心理机制与治理路径》]

谣言概念界定：究其本质而言,谣言普遍具有的属性,一是广泛传播，二是不确定性,基于此，本文将谣言界定为被广泛传播的、含有极大的不确定性的信息。“不确定性”主要是指对信息真实与否的不确定性。[^《老年群体的谣言认知不协调及其纠偏机制》]

目前,在突发事件中的各类谣言中,有明确目标性和破坏性的攻击型谣言和以实现政治、经济等利益为目标的宣传型或牟利型谣言出现的频率较低。多数谣言是出于恐惧心理和基于错误的认识判断而形成的。[^《全媒体时代网络谣言产生的心理机制与治理路径》] 从这次的谣言收集分析已证明，最大的两个类别是，社会话题与健康饮食，两者分别占比48%、43%。
 
但“后真相”时代多元文化的糅合共存和碎片化的解读方式加剧了民众的价值分歧,侵蚀了信任防线。一方面，复杂的利益诉求、多元的社会思潮与多样的传播方式交织叠加，催生出“后真相”时代多元的网络文化，加大了主流与非主流文化之间的碰撞和摩擦。虽然非主流文化是主流文化的有益补充，但诸如佛系文化、网红文化、躺平文化等难免有背离主流文化的消极因素，尤其是污丑文化、拜金文化等更是尽显畸形审美和金钱至上的错误思想，若不加警惕和批判，极易误导一些认知不足、阅历不够的受众，诱发政治偏见,不断冲击和侵蚀业已形成的政治信任。另一方面，“后真相”时代人们面对海量信息，惯以碎片化的方式拼凑事实、解读真相。一旦关涉社会分化、利益分配、政治腐败和政策失误等复杂的政治谣言鉴别，人们极易陷入碎片化信息的不断解读和重组,制造出多种“真相”,并借此持续发酵,非但无益于阻断网络政治谣言的传播，反而会频繁质疑已有政治共识,造成政治信任的流失，为谣言惑众创设了可能。[^后真相时代网络政治谣言的表征归因及治理]

就参考[^后真相时代网络政治谣言的表征归因及治理] 来说，个人生活无非涉及钱的吃穿住行，社会分化也是正常现象，“个人-集体”、“集体-个人”的差异、非一致性，这话更多“是以国家建设为中心”为首纲。下面这两条信息很值得参考研究：

* [知乎 - 如何看待央视新视频【靠力气赚钱心里才踏实，是无数平凡人的生活信仰】?](https://www.zhihu.com/question/587740721/answer/2952171143)
* [bilibili - 说我摸，说我摆，谁在意劳动者的无奈？](https://www.bilibili.com/video/BV1ss4y1M72E)
 
### B站饭圈层弹幕收集（分析中）

以社会民生话题种类繁多，不大适合定量分析研究B站Z世代用户。如果是将研究样本限定在“二次元”、“某CP党”，做定向的特质分析，无疑是个很好的突破口。查阅了几篇资料，针对Z世代标新立异的话语，不少文章都共同提及了：<u>“缘趣群体”、“群体认同”、“亚文化圈层”、“解构重构”、“詹姆斯·凯瑞”</u>，这几个关键词。这里以“磕CP”作为入手方向。（**做为社会中的个体，人的喜好专长，二者是离散且多元性的。**）

原因自然是多方面的,现实的无趣 、欲望的驱动、游戏的追求 …… 但本质原因之一 ，是来自受众对于“现实”/“真实”以及其所指代和承诺的价值、情感的不信任，于是转身投入对虚拟情感/虚假情感的沉迷之中。在影院观赏爱情电影之所以那么富有魅力，是因为对人们内心深处的那些渴望的、私密的情感进行了合理化的影像化呈现，黑暗背景中的电影院与银幕也成为人们享受私人化情感释放的理想化场所 。[^B站的CP向混剪视频为例]

后情感主义是美国社会学家斯捷潘·梅斯特罗维奇（ Stjepan G. Metrovic）提出的理论。所谓“后情感”，区别于人类的本真情感，指向一种“新的被智识化、机械化、大众媒体生产的情感”。本真情感异化为替代或虚拟的情感（“后情感”），成为文化工业批量生产并出售的一种商品。[^B站的CP向混剪视频为例]

在后情感主义时代，“情感已不必指向以往至 高无上的客观真实，而只须满足公众的快感欲求”。文艺作品不再取材于真实、表现人类本真情感，而是营造悬浮的“爱情神话”以催生“虚假欲求”，满足公众快感；公众不再需要费心建立并维持一段亲密关系，而是仅仅通过消费媒介产品就可以获得超越日常生活的类情感体验 。[^B站的CP向混剪视频为例]
 
[^《全媒体时代网络谣言产生的心理机制与治理路径》]:
    1. 胡琦《全媒体时代网络谣言产生的心理机制与治理路径》，《社会科学家》2022年第11期，135页
    2. 胡琦《全媒体时代网络谣言产生的心理机制与治理路径》，《社会科学家》2022年第11期，137页

[^《老年群体的谣言认知不协调及其纠偏机制》]: 
    1. 雷霞《老年群体的谣言认知不协调及其纠偏机制》，《现代传播》2023年第3期

[^后真相时代网络政治谣言的表征归因及治理]: 
    1. 杨芸伊,赵惜群 《“ 后真相 ” 时代网络政治谣言的表征 、归因及治理》，湖南科技大学学报(社会科学版)，2022年第11期，155页

[^B站的CP向混剪视频为例]:  
    1. 石小溪《“再生影像”的双重媒介特性与文化逻辑 —— B站的“CP向”混剪视频为例》，《电影文学》2022年第23期，27页
 

</details>

## Windows桌面技术基线检查 

首先，确保你的系统已开启 PowerShell

* **打开PowerShell功能：`Set-ExecutionPolicy RemoteSigned`**
* ***关闭PowerShell功能：`Set-ExecutionPolicy Restricted`***

<details>
<summary><B> 点击详情 </B></summary>
 

 一键使用，本地下载使用转GB2312编码 [图文版](https://www.52pojie.cn/thread-1795749-1-1.html)
 
```
 irm https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-pwsh/frontline_helpdesk.ps1|iex
```
 
功能概览：
 
1. 检查IP与网络设备连接近况
2. 检查打印机、打印池、扫描仪状态
3. 检查硬盘、CPU、内存、显卡等基础驱动信息
4. 检查设备安全性、近期升级补丁、定时任务项
5. 检查主机主动共享协议相关信息
6. 检查电脑休眠、重启频次、异常关机、程序崩溃等信息
7. 执行1～6选项的所有功能
8. 生成"设备驱动检查"、"五天内预警事件"、"登录登出活动记录"、"月度已存威胁概况"分析报表
9. 查看指导建议与开发说明 

BTW
 
Linux基线检查（PR）见：[al0ne/LinuxCheck](https://github.com/al0ne/LinuxCheck)。对于Mac来说，这些安全服务的维护成本，不适用于中小企业。
 
* [Apple - Mac系统部署](https://www.apple.com.cn/business/docs/site/Mac_Deployment_Overview.pdf)
* [vmware - 企业采购苹果设备的正确姿势-abm](https://blogs.vmware.com/china/2019/10/08/企业采购苹果设备的正确姿势-abm/)

大环境下，这篇文章 [CSDN - 企业管理Mac电脑的三种方式](https://blog.csdn.net/smartbenson/article/details/50636012)提及的管理办法，都算得上是防控得当，可对比Windows来说，却挺不够看的。

</details>



## Linux云主机毛坯房安全改造

<details>
<summary><B> 点击详情 </B></summary>

### 一键搞定SSH登录、用户密码策略配置、Ban IP配置 [图文版](https://www.52pojie.cn/thread-1749877-1-1.html)

* SSH登录: 免密的密钥模式、心跳长时间连接，客户端不掉线 
* 密码策略: 不限特殊字符、大小写，并支持4～5位长度下限
* Ban IP: 除自己IP外，30秒内短时间三次输错密码，永久封禁IP。

```
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/lite_ssh_n_ban.sh)"
```

SSH单项配置：一键调用SSH快速配置 SSH密钥登录策略、用户简单密码配置规则。（单项部分是开启限定自己IP访问的，即 AllowUsers）

```
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/simple_ssh.sh)"
```

fail2ban单项配置：一键fail2ban从下载到安装及生成配置与启动服务。(再次允许单项部分可以刷新自己公网IP配置)

```
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/simple_ban.sh)"
```

### 一键搞定Linux自定义创建具有管理员权限的用户 [图文版](https://www.52pojie.cn/thread-1749877-1-1.html)

* 自定义用户名
* su、sudo及wheel组成员免密
* sshd_config锁root远程登录，提高安全性

```
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/diy_add_wheel.sh)"
```

### 一键搞定FTP [图文版](https://www.52pojie.cn/thread-1753070-1-1.html)

* 共享目录： /var/ftp/share 
* 限制越权出逃共享访问，可读写。
* 安全，私有化，限定自己的公网IP访问。

不输密码版，用户名:ftpuser 密码：P@ssw0rd

```
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/simple_vsftpd.sh)"
```

自定义用户版

```
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/lite_vsftpd.sh)"
```

</details>

## 因企业硬性需求

<details>
<summary><B> 点击详情 </B></summary>
 
IE防Edge劫持 [图文版](https://www.52pojie.cn/thread-1774349-1-1.html)

```
curl -L  https://ghproxy.com/https://github.com/hoochanlon/ihs-simple/raw/main/d-bat/keep_ie.bat|cmd
```

一键永久关闭Windows更新设置 [图文版](https://www.52pojie.cn/thread-1791338-1-1.html)

```
curl -L  https://ghproxy.com/https://github.com/hoochanlon/ihs-simple/raw/main/d-bat/stop_update.bat|cmd
```

一键恢复被关闭的Windows更新设置

```
curl -L  https://ghproxy.com/https://github.com/hoochanlon/ihs-simple/raw/main/d-bat/re_update.bat|cmd
```

一键开启或关闭Windows defender实时保护

```
curl -OfsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-bat/choice_wdrt.bat&&call choice_wdrt.bat
```

一键关闭Windows代理设置

```
netsh winhttp reset proxy
```

一键调用设置程序是否以管理员权限运行

```
curl -OfsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-bat/nano_runas.bat&&call nano_runas.bat
```

去掉win10/win11热搜条目（需注销或重启） [admx.help 上见](https://admx.help/?Category=Windows_8.1_2012R2&Policy=Microsoft.Policies.WindowsExplorer::DisableSearchBoxSuggestions&Language=zh-cn)

```
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\explorer" /v DisableSearchBoxSuggestions /t reg_dword /d 1 /f
```

</details>

## 移花接木

<details>
<summary><B> 点击详情 </B></summary>
 
一键爬取bing壁纸 [图文版](https://www.52pojie.cn/thread-1781868-1-1.html)

```
python -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/get_bing_wallpapers.py)"
```
 
CMD一键调用windows版本切换与Windows/Office激活 [图文版](https://www.52pojie.cn/thread-1743122-1-1.html)

```
curl -O https://ghproxy.com/https://raw.githubusercontent.com/TerryHuangHD/Windows10-VersionSwitcher/master/Switch.bat&&TIMEOUT /T 1&&start Switch.bat&&powershell -command "irm https://massgrave.dev/get|iex"
```

CMD一键安装winrar注册激活 [图文版](https://www.52pojie.cn/thread-1740471-1-1.html)

```
powershell -command Invoke-WebRequest -Uri "https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/winrar_down_reg.bat" -OutFile "C:/Users/${env:UserName}/Downloads/winrar_down_reg.bat"&&TIMEOUT /T 1&&start /b C:\Users\%username%\Downloads\winrar_down_reg.bat
```

Powershell一键生成Emeditor序列号

```
irm https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-pwsh/emeditor_random_keygen.ps1|iex
```

Powershell一键IDM激活（[自己写的方案已失效，国内版权原因不做更新](https://github.com/hoochanlon/ihs-simple/blob/main/d-pwsh/fail_idm.ps1)）

```
iwr -useb https://ghproxy.com/https://raw.githubusercontent.com/lstprjct/IDM-Activation-Script/main/IAS.ps1 | iex
```

Powershell从XchangePDF Editor下载安装到生成许可证 

```
curl https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/xchange_v8_active.ps1 -Outfile xchange_v8_active.ps1 | powershell -c xchange_v8_active.ps1
```
 
win7 打开图片报错“内存不足” [图文版](https://www.52pojie.cn/thread-1768841-1-1.html)

```
powershell -c "irm  https://ghproxy.com/https://github.com/hoochanlon/ihs-simple/raw/main/d-bat/exifhelper.bat -Outfile exifhelper.bat" && exifhelper.bat
```
 
</details>

## 细枝末节

<details>
<summary><B> 点击详情 </B></summary>
 
### Windows
 
CMD获取本机公网详情
 
```
powershell -c irm "https://freeipapi.com/api/json/$(irm http://api.ipify.org)"
```

Shell获取本机公网详情（需安装 `brew install jq`）
 
```
 curl -s https://freeipapi.com/api/json/$(curl -s https://api.ipify.org) | jq .
```

一键安装打印机原理代码 [图文版](https://www.52pojie.cn/thread-1776328-1-1.html)。Mac见：[自在拉基 - Mac打印机一键安装 ](https://www.cnblogs.com/98record/p/mac-da-yin-ji-yi-jian-an-zhuang.html)（转朋友的，没需求，所以没写，原理都差不多，不过挺厉害。）
 
```
 https://github.com/hoochanlon/ihs-simple/blob/main/d-bat/install_public_network_hp_printer_driver.bat
```
 
powershell active，以及微PE显示IP脚本 

```
explorer https://github.com/hoochanlon/ihs-simple/blob/main/d-bat/weipe_showip.bat
```
 

一键安装Java [图文版](https://www.52pojie.cn/thread-1767872-1-1.html)

```
curl -O https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-bat/install_jdk.bat&&call install_jdk.bat
```

win11一键显示当前WiFi与密码并生成二维码分享 [图文版](https://www.52pojie.cn/thread-1772481-1-1.html)

```
curl -O https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-bat/show_wifi.bat&&call show_wifi.bat
```

一键显示所有WiFi

 ```
curl -OfsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-bat/oh_my_wifi.bat&&call oh_my_wifi.bat
 ```
 
 一键RAR密码爆破 [图文版](https://www.52pojie.cn/thread-1775357-1-1.html)
 
 ```
 curl -Os https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-bat/seven_z_sensei.bat&&call seven_z_sensei.bat
 ```

 </details>
 
## Mac专题

想要自由使用Mac步骤：

1. **允许所有来源： `sudo spctl --master-disable`**
2. **恢复模式下，关闭SIP：`csrutil disable`**
3. **解除苹果签名验证系统的校验隔离：`sudo xattr -d com.apple.quarantine`**

<details>
<summary><B> 点击详情 </B></summary>

重置macOS ~/.zshrc （仅环境变量配置失误，造成不可逆后果使用）

```
export PATH=/usr/bin:/usr/sbin:/bin:/sbin:/usr/X11R6/bin; sudo rm -rf ~/.zshrc
```

Mac查看当前Wi-Fi密码 [图文版](https://www.52pojie.cn/thread-1766927-1-1.html)

```
sudo bash -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/mac_show_wifi.sh)"
```

Mac 一键支持NTFS [图文版](https://github.com/hoochanlon/Free-NTFS-For-Mac)

```
sudo /bin/bash -c "$(curl -fsSL https://cdn.statically.io/gh/hoochanlon/Free-NTFS-for-Mac/main/nigate.sh)"
```

Mac 激活各类相关软件 [图文版](https://github.com/QiuChenly/MyMacsAppCrack/tree/main/Shells)

```
sudo bash -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/QiuChenly/MyMacsAppCrack/main/Shells/simple_crack.sh)"
```

macOS MS-AutoUpdate 一键带走

```
sudo /usr/bin/osascript -e "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-apple/no_ms_autoupdate.scpt)"
```

 一键RAR密码爆破 [图文版](https://www.52pojie.cn/thread-1775990-1-1.html)
 
 ```
 bash -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/7z_rar_sensei.sh)"
 ```

自动化下载 Office Mac2021 激活工具

```
sudo /usr/bin/osascript -e "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-apple/office2021.scpt)"
```

一键定时切换壁纸，一面工作，一面生活
 
 ```
  bash -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/mac_corn_diy_wallpaper.sh)"
 ```
 
</details>


## 参考文献

主题章节：

* 【常见平台热搜与辟谣信息分析·头条、抖音、微博热搜采集分析】
* 【常见平台热搜与辟谣信息分析·自动化收集辟谣条目及语言分析】
* 【常见平台热搜与辟谣信息分析·B站饭圈层弹幕收集】

<!--
[![telegram](https://img.shields.io/badge/telegram-:me-blue.svg?longCache=true&style=flat-square)](https://t.me/test) 

![ ](https://raw.githubusercontent.com/hoochanlon/hoochanlon/master/assets/github-contribution-grid-snake.svg)

[网络辟谣标签工作专区](https://www.piyao.org.cn/bq/index.htm)、[谣言曝光台](https://www.piyao.org.cn/yybgt/index.htm)
-->



