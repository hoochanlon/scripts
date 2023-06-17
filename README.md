# ***<s>[ihs-simple](https://github.com/hoochanlon/ihs-simple/blob/main/THINGS.md#picgo)</s>***

[![blog](https://img.shields.io/badge/%F0%9F%94%97blog-hoochanlon-lightgrey.svg?longCache=true&style=flat-square)](https://hoochanlon.github.io/) [![outlook](https://img.shields.io/badge/%F0%9F%93%A7hotmail-@邮箱联系-blue.svg?longCache=true&style=flat-square)](mailto:hoochanlon@outlook.com)[![](https://img.shields.io/github/followers/hoochanlon?color=green&style=social)](https://github.com/hoochanlon) [![](https://img.shields.io/github/stars/hoochanlon?color=green&style=social)](https://github.com/hoochanlon)

## 🧙‍♂️


> 系统平台：Windows/Mac/Linux。 脚本语言：多种、不限；我流，按需编写。 研究对象：基础信息自动化、云主机远程安全处理、社会科学信息化及数据分析。
>
> 跨学科信息化综合应用：桌面基线排查、软件激活破解、免杀及特权执行、渗透式支援固件识别读写、主机账户密码空值检测、Wi-Fi密码扫描、云主机终端安全加固、主机系统日志分析、自然语言处理、人文社科信息数据分析等。有关自动化信息处理生成的报告报表，可查阅 d-xlsx 目录了解详情。


一开始只是用来做图床，为图省事方便，自己就偶尔随手上传小脚本，结果却成了各类程序语言脚本库。至于所谓 “技术” 方面的东西，找个专门的平台发稿就行了。现在想来，那些在xx之家、xx论坛投稿的笔者也是聪明人。SEO、宣传聚流，什么的...那就交由他们去吧。

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

免责声明：所有脚本与指令、病毒分析文章，仅面向研究与学习交流之用，切勿用于其他非法用途！

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
4. 检查设备安全性、近期升级补丁、定时任务项、证书策略、系统核心文件控制访问状况
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

## Mac基础终端操控知会

想要自由使用Mac步骤：

1. **允许所有来源： `sudo spctl --master-disable`**
2. **恢复模式下，关闭SIP：`csrutil disable`**
3. **解除苹果签名验证系统的校验隔离：`sudo xattr -d com.apple.quarantine`**
4. **运行终端工具包前提 —— homebrew，复制如下指令安装**

```
/bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/install.sh)"
```

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
sudo -u $USER python3 -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/mac_ntfs_ninja.py)"
```

Mac 激活各类相关软件 [图文版](https://github.com/QiuChenly/MyMacsAppCrack/tree/main/Shells)（DMCA）

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
 
最后，转朋友的：[自在拉基 - Mac打印机一键安装](https://www.cnblogs.com/98record/p/mac-da-yin-ji-yi-jian-an-zhuang.html)。（没需求，所以没写；原理都差不多，确实挺厉害的。）
 
</details>


## Linux云主机毛坯房安全改造

购买云服务商提供的云主机，系统基本没有任何的安全软件保护。每天都有各地不法分子扫描公网，并不断远程暴破、入侵主机。所以需要采取防治措施。

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

## 企业系统基础环境需求

主要涉及：IE、Windows defender、Windows更新、钉钉静默安装、打印机自动化安装

<details>
<summary><B> 点击详情 </B></summary>
 
IE防Edge劫持 [图文版](https://www.52pojie.cn/thread-1774349-1-1.html) 

```
curl -L  https://ghproxy.com/https://github.com/hoochanlon/ihs-simple/raw/main/d-bat/keep_ie.bat|cmd
```
 
* 注【1】：[域控环境IE模版 图文](https://www.52pojie.cn/thread-1765347-1-1.html) 
* 注【2】：代码地址：https://github.com/hoochanlon/ihs-simple/blob/main/d-bat/saigonoie.bat

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

一键调用设置程序是否以管理员权限运行

```
curl -OfsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-bat/nano_runas.bat&&call nano_runas.bat
```

去掉win10/win11热搜条目（需注销或重启） [admx.help 上见](https://admx.help/?Category=Windows_8.1_2012R2&Policy=Microsoft.Policies.WindowsExplorer::DisableSearchBoxSuggestions&Language=zh-cn)

```
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\explorer" /v DisableSearchBoxSuggestions /t reg_dword /d 1 /f
```

钉钉静默安装源码： [fuck_dingding.bat](./d-bat/fuck_dingding.bat)；打印机安装详情见：[打印机自动化安装研究.ipynb](./d-ipynb/打印机自动化安装研究.ipynb)

</details>

## 移花接木与细枝末节


* Windows/Office、winrar、emeditor、idm、XchangePDF
* Wi-Fi、bing壁纸、PE查看局域网IP、解析主机IP运营商及归属地查询
* 其他更多...

<details>
<summary><B> 点击详情 </B></summary>
 
### 移花接木
 
CMD一键调用windows版本切换与Windows/Office激活 [图文版](https://www.52pojie.cn/thread-1743122-1-1.html)

```
curl -O https://ghproxy.com/https://raw.githubusercontent.com/TerryHuangHD/Windows10-VersionSwitcher/master/Switch.bat&&TIMEOUT /T 1&&start Switch.bat&&powershell -command "irm https://massgrave.dev/get|iex"
```

CMD一键安装winrar注册激活

```
powershell -command Invoke-WebRequest -Uri "https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-bat/winrar_down_reg.bat" -OutFile "C:/Users/${env:UserName}/Downloads/winrar_down_reg.bat"&&TIMEOUT /T 1&&start /b C:\Users\%username%\Downloads\winrar_down_reg.bat
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
curl https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-pwsh/xchange_v8_active.ps1 -Outfile xchange_v8_active.ps1 | powershell -c xchange_v8_active.ps1
```
 
win7 打开图片报错“内存不足” [图文版](https://www.52pojie.cn/thread-1768841-1-1.html)

```
powershell -c "irm  https://ghproxy.com/https://github.com/hoochanlon/ihs-simple/raw/main/d-bat/exifhelper.bat -Outfile exifhelper.bat" && exifhelper.bat
```
 
### 细枝末节
 
一键爬取bing壁纸 [图文版](https://www.52pojie.cn/thread-1781868-1-1.html)

```
python3 -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/get_bing_wallpapers.py)"
```
 
CMD获取本机公网详情
 
```
powershell -c irm "https://freeipapi.com/api/json/$(irm http://api.ipify.org)"
```

Shell获取本机公网详情（需安装 `brew install jq`）
 
```
 curl -s https://freeipapi.com/api/json/$(curl -s https://api.ipify.org) | jq .
```

一键安装打印机原理代码 [图文版](https://www.52pojie.cn/thread-1776328-1-1.html)。
 
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


## 常见平台热搜与辟谣信息分析

对人文社科期刊、论文研究对象进行跨学科、基础调研（不限于同事访谈、网络论坛问卷调查）等综合性分析。

* 数据收集、过滤、分类归档
* "平均/极值"基础数学统计
* 分词、文本情绪值计算汇总（自然语言处理）
* 观点交流、意见分享等

前提：开始前，先复制如下指令安装 pip 工具包。涉及到斯坦福大学语言模型 [stanza](https://stanfordnlp.github.io/stanza) 处理的数据需要外网连接。

```
pip3 install --no-cache-dir -r https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-txt/requirements.txt
```


<details>
<summary><B> 点击详情 </B></summary>
 
### 新闻资讯收集（序·小试牛刀）

一键获取中国新闻网资讯 [图文版](https://www.52pojie.cn/thread-1780608-1-1.html)

```
python3 -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/get_chinanews.py)"
```
 
一键生成全球信息报表 [图文版](https://www.52pojie.cn/thread-1779165-1-1.html)

```
python3 -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/get_worldometers.py)"
```

### 头条、抖音、微博热搜采集分析
 
一键获取今日头条、抖音、微博热搜。[图文版](https://www.52pojie.cn/thread-1785460-1-1.html) （NLP：[Stanza](https://stanfordnlp.github.io/stanza/data_objects.html)）

```
python3 -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/get_resou_today_s.py)"
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
python3 -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/get_rumor_analysis.py)"
```
 
urllib3：https://github.com/urllib3/urllib3/issues/3020#issuecomment-1557412175

对谣言的定义：阿尔波特(Gordom W.Allport)和波兹曼(Leo Postman)最早为谣言下了定义,即谣言是一个与当时事件相关联的命题,是为了使人相信,一般以口传媒介的方式在人们之间流传,但是却缺乏具体的资料以证实其确切性。[^《全媒体时代网络谣言产生的心理机制与治理路径》]

谣言概念界定：究其本质而言,谣言普遍具有的属性,一是广泛传播，二是不确定性,基于此，本文将谣言界定为被广泛传播的、含有极大的不确定性的信息。“不确定性”主要是指对信息真实与否的不确定性。[^《老年群体的谣言认知不协调及其纠偏机制》]

目前,在突发事件中的各类谣言中,有明确目标性和破坏性的攻击型谣言和以实现政治、经济等利益为目标的宣传型或牟利型谣言出现的频率较低。多数谣言是出于恐惧心理和基于错误的认识判断而形成的。[^《全媒体时代网络谣言产生的心理机制与治理路径》] 从这次的谣言收集分析已证明，最大的两个类别是，社会话题与健康饮食，两者分别占比48%、43%。
 
但“后真相”时代多元文化的糅合共存和碎片化的解读方式加剧了民众的价值分歧,侵蚀了信任防线。一方面，复杂的利益诉求、多元的社会思潮与多样的传播方式交织叠加，催生出“后真相”时代多元的网络文化，加大了主流与非主流文化之间的碰撞和摩擦。虽然非主流文化是主流文化的有益补充，但诸如佛系文化、网红文化、躺平文化等难免有背离主流文化的消极因素，尤其是污丑文化、拜金文化等更是尽显畸形审美和金钱至上的错误思想，若不加警惕和批判，极易误导一些认知不足、阅历不够的受众，诱发政治偏见,不断冲击和侵蚀业已形成的政治信任。另一方面，“后真相”时代人们面对海量信息，惯以碎片化的方式拼凑事实、解读真相。一旦关涉社会分化、利益分配、政治腐败和政策失误等复杂的政治谣言鉴别，人们极易陷入碎片化信息的不断解读和重组,制造出多种“真相”,并借此持续发酵,非但无益于阻断网络政治谣言的传播，反而会频繁质疑已有政治共识,造成政治信任的流失，为谣言惑众创设了可能。[^后真相时代网络政治谣言的表征归因及治理]

就参考[^后真相时代网络政治谣言的表征归因及治理] 来说，个人生活无非涉及钱的吃穿住行，社会分化也是正常现象，“个人-集体”、“集体-个人”的差异、非一致性，这话更多“是以国家建设为中心”为首纲。下面这两条信息很值得参考研究：

* [知乎 - 如何看待央视新视频【靠力气赚钱心里才踏实，是无数平凡人的生活信仰】?](https://www.zhihu.com/question/587740721/answer/2952171143)
* [bilibili - 说我摸，说我摆，谁在意劳动者的无奈？](https://www.bilibili.com/video/BV1ss4y1M72E)
 
</details>

文本分析工作内容，见下图。目的性都差不多，只不过方式略有不同而已，殊途同归了，算是。

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-06-17%2019.25.52.png)

上图引用自 黄俊《传播创新研究（第四辑）· 职场辱虐的情绪影响和行为反应研究、B站等社交媒体的传播研究》149页[^职场辱虐的情绪影响和行为反应研究]

[^《全媒体时代网络谣言产生的心理机制与治理路径》]:
    1. 胡琦《全媒体时代网络谣言产生的心理机制与治理路径》，《社会科学家》2022年第11期，135页
    2. 胡琦《全媒体时代网络谣言产生的心理机制与治理路径》，《社会科学家》2022年第11期，137页

[^《老年群体的谣言认知不协调及其纠偏机制》]: 
    1. 雷霞《老年群体的谣言认知不协调及其纠偏机制》，《现代传播》2023年第3期

[^后真相时代网络政治谣言的表征归因及治理]: 
    1. 杨芸伊,赵惜群 《“ 后真相 ” 时代网络政治谣言的表征 、归因及治理》，湖南科技大学学报(社会科学版)，2022年第11期，155页

[^职场辱虐的情绪影响和行为反应研究]:
    1. 黄俊《传播创新研究（第四辑）· 职场辱虐的情绪影响和行为反应研究、B站等社交媒体的传播研究》149页

## 参考文献

注：由于研究范围较广泛，部分专题涉及内容较深，因此采用 ipynb 独立开题综述具体内容，并放置相关链接的形式（脚注问题：https://github.com/jupyter/notebook/issues/1287#issuecomment-451080550 ）。故此处参考文献列表仅限于 README.Markdown

<!--
[![telegram](https://img.shields.io/badge/telegram-:me-blue.svg?longCache=true&style=flat-square)](https://t.me/test) 

![ ](https://raw.githubusercontent.com/hoochanlon/hoochanlon/master/assets/github-contribution-grid-snake.svg)

[网络辟谣标签工作专区](https://www.piyao.org.cn/bq/index.htm)、[谣言曝光台](https://www.piyao.org.cn/yybgt/index.htm)
-->



