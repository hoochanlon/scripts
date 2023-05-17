# ***<s>[ihs-simple](https://github.com/hoochanlon/ihs-simple/blob/main/THINGS.md#picgo)</s>***

[![blog](https://img.shields.io/badge/%F0%9F%94%97blog-hoochanlon-lightgrey.svg?longCache=true&style=flat-square)](https://hoochanlon.github.io/) [![outlook](https://img.shields.io/badge/%F0%9F%93%A7hotmail-@邮箱联系-blue.svg?longCache=true&style=flat-square)](mailto:hoochanlon@outlook.com)[![](https://img.shields.io/github/followers/hoochanlon?color=green&style=social)](https://github.com/hoochanlon) [![](https://img.shields.io/github/stars/hoochanlon?color=green&style=social)](https://github.com/hoochanlon)

一开始只是用来做图床，图省事方便偶尔随手上传自己的小脚本，结果却成了...所有脚本与指令均需用管理员身份运行，脚本代码及病毒分析文章，也仅供学习与交流使用，切勿做违法用途。

---

## 资讯分析与图片采集

### 资讯分析

一键生成全球信息报表 [图文版](https://www.52pojie.cn/thread-1779165-1-1.html)

```
python -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/get_worldometers.py)"
```

一键获取中国新闻网资讯 [图文版](https://www.52pojie.cn/thread-1780608-1-1.html)

```
python -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/get_chinanews.py)"
```

**一键获取今日头条、抖音、微博热搜。[图文版](https://www.52pojie.cn/thread-1785460-1-1.html)**

```
python -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/get_resou_today.py)"
```

* 自动化分类；整体匹配率：84%~96% 区间左右；其中，微博噪音三者最大，失真度偏高，信息价值低，话题含水量大。
* 词频统计；三者共存的热搜，说明为持久公共热度，信息密度较高。
* 文本情感平均值、每条标题的情感数值；主：人为置顶热搜的文本情绪强烈程度。

新增：词性分析（get_resou_today_s）；只要定语、状语叠得多，总能是宣传形势大好。标记可能存有引导与被植入意识成分用词。选型：[ThuLAC](https://github.com/thunlp/THULAC-Python)虽不错，但较封闭，AI的魔法略显麻烦；故选型 [Stanza](https://stanfordnlp.github.io/stanza/data_objects.html)，也够用。

```
python -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/get_resou_today_s.py)"
```

### 图片采集

一键爬取bing壁纸 [图文版](https://www.52pojie.cn/thread-1781868-1-1.html)

```
python -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/get_bing_wallpapers.py)"
```

## 细枝末节

powershell active，以及微PE显示IP脚本 `explorer https://github.com/hoochanlon/ihs-simple/blob/main/d-bat/weipe_showip.bat`

```
Set-ExecutionPolicy RemoteSigned
```

重置macOS ~/.zshrc （仅环境变量配置失误，造成不可逆后果使用）

```
export PATH=/usr/bin:/usr/sbin:/bin:/sbin:/usr/X11R6/bin; sudo rm -rf ~/.zshrc
```

Windows关闭代理设置

```
netsh winhttp reset proxy
```

 一键安装打印机原理代码 [图文版](https://www.52pojie.cn/thread-1776328-1-1.html)
 
 ```
 https://github.com/hoochanlon/ihs-simple/blob/main/d-bat/install_public_network_hp_printer_driver.bat
 ```

win7 打开图片报错“内存不足” [图文版](https://www.52pojie.cn/thread-1768841-1-1.html)

```
powershell -c "irm  https://ghproxy.com/https://github.com/hoochanlon/ihs-simple/raw/main/d-bat/exifhelper.bat -Outfile exifhelper.bat" && exifhelper.bat
```

## 环境适配

一键安装Java [图文版](https://www.52pojie.cn/thread-1767872-1-1.html)

```
curl -O https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-bat/install_jdk.bat&&call install_jdk.bat
```

IE防Edge劫持 [图文版](https://www.52pojie.cn/thread-1774349-1-1.html)

```
curl -L  https://ghproxy.com/https://github.com/hoochanlon/ihs-simple/raw/main/d-bat/keep_ie.bat|cmd
```

一键调用设置程序是否以管理员权限运行

```
curl -OfsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-bat/nano_runas.bat&&call nano_runas.bat
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
 
## Mac专题

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

macOS终端下载Office for Mac2021 serializer.pkg 激活

```
sudo /usr/bin/osascript -e "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/serializer_office_for_mac2021.AppleScript)"
```

 一键RAR密码爆破 [图文版](https://www.52pojie.cn/thread-1775990-1-1.html)
 
 ```
 bash -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/7z_rar_sensei.sh)"
 ```
 
 一键定时切换壁纸，一面工作，一面生活
 
 ```
  bash -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/mac_corn_diy_wallpaper.sh)"
 ```
 
一键安装打印机 [自在拉基 - Mac打印机一键安装 ](https://www.cnblogs.com/98record/p/mac-da-yin-ji-yi-jian-an-zhuang.html)（转朋友的，没需求，所以没写，原理都差不多，不过挺厉害。）


## 移花接木

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

## Linux毛坯房安全改造

一键搞定SSH登录、用户密码策略配置、Ban IP配置 [图文版](https://www.52pojie.cn/thread-1749877-1-1.html)

* SSH登录: 免密的密钥模式、心跳长时间连接，客户端不掉线 
* 密码策略: 不限特殊字符、大小写，并支持4～5位长度下限
* Ban IP: 除自己IP外，30秒内短时间三次输错密码，永久封禁IP。

```
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/lite_ssh_n_ban.sh)"
```

<details><summary>SSH单项、fail2ban单项 click me! </summary>

一键调用SSH快速配置 SSH密钥登录策略、用户简单密码配置规则。（单项部分是开启限定自己IP访问的，即 AllowUsers）

```
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/simple_ssh.sh)"
```

一键fail2ban从下载到安装及生成配置与启动服务。(再次允许单项部分可以刷新自己公网IP配置)

```
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/simple_ban.sh)"
```

</details>

一键搞定Linux自定义创建具有管理员权限的用户 [图文版](https://www.52pojie.cn/thread-1749877-1-1.html)

* 自定义用户名
* su、sudo及wheel组成员免密
* sshd_config锁root远程登录，提高安全性

```
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/diy_add_wheel.sh)"
```

一键搞定FTP [图文版](https://www.52pojie.cn/thread-1753070-1-1.html)

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

<!--
[![telegram](https://img.shields.io/badge/telegram-:me-blue.svg?longCache=true&style=flat-square)](https://t.me/test) 

![ ](https://raw.githubusercontent.com/hoochanlon/hoochanlon/master/assets/github-contribution-grid-snake.svg)
-->

---

Linux迁移 Windows command 工具：

* [cygwin](http://www.cygwin.com) 类子系统
* [gnuwin32](http://gnuwin32.sourceforge.net)、[minGW](http://www.mingw.org)  保持原生环境，尽可能提供类似的方案

python环境问题

* pyenv+pipx+poetry
  * pyenv灵活地安装与切换python版本，搭配poetry可快速生成相应版本环境。
  * pipx升级依赖工具包方便，不用担心全局兼容问题。
  * 编译的程序通常会依赖各种包，这个要看开发者给出相应提示安装哪些包了。
* miniconda、anaconda这类python发行版，依赖库齐全。

对于我来说，博客更侧重日常生活，基本上不会往里塞计网专业上的东西，更多的是个人见闻与人文社科。至于所谓“技术”方面的东西，找个专门的平台发稿就行了。现在想来，那些在xx之家、xx论坛投稿的，也是聪明人。SEO、宣传什么的就交由他们去吧。
