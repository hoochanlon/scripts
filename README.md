# ***<s>[ihs-simple](https://github.com/hoochanlon/ihs-simple/blob/main/THINGS.md#picgo)</s>*** Quick-Simple

[![blog](https://img.shields.io/badge/%F0%9F%94%97blog-hoochanlon-lightgrey.svg?longCache=true&style=flat-square)](https://hoochanlon.github.io/) [![outlook](https://img.shields.io/badge/%F0%9F%93%A7hotmail-@邮箱联系-blue.svg?longCache=true&style=flat-square)](mailto:hoochanlon@outlook.com)[![](https://img.shields.io/github/followers/hoochanlon?color=green&style=social)](https://github.com/hoochanlon) [![](https://img.shields.io/github/stars/hoochanlon?color=green&style=social)](https://github.com/hoochanlon)

一开始只是用来做图床，图省事方便偶尔随手上传自己的小脚本，结果却成了...所有脚本与指令均需用管理员身份运行，脚本代码及病毒分析文章，也仅供学习与交流使用，切勿做违法用途。

```
Set-ExecutionPolicy RemoteSigned
```

## 初始云服务器快速配置

### 一键搞定SSH登录、用户密码策略配置、Ban IP配置 [图文版](https://www.52pojie.cn/thread-1749877-1-1.html)

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

### 一键搞定Linux自定义创建具有管理员权限的用户

* 自定义用户名
* su、sudo及wheel组成员免密
* sshd_config锁root远程登录，提高安全性

```
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/diy_add_wheel.sh)"
```

### 一键搞定FTP

不输密码版

* 用户名:ftpuser 密码：P@ssw0rd
* 共享目录： /var/ftp/share 
* 限制越权出逃共享访问，可读写。

```
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/simple_vsftpd.sh)"
```


## 激活相关 

### Windows/Office/winrar/IDM/emeditor/xchange pdf

CMD一键调用windows版本切换与Windows/Office激活 [图文版](https://www.52pojie.cn/thread-1743122-1-1.html)

```
curl -O https://ghproxy.com/https://raw.githubusercontent.com/TerryHuangHD/Windows10-VersionSwitcher/master/Switch.bat&&TIMEOUT /T 1&&start Switch.bat&&powershell -command "irm https://massgrave.dev/get|iex"
```

macOS终端下载Office for Mac2021 serializer.pkg 激活

```
sudo /usr/bin/osascript -e "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/serializer_office_for_mac2021.AppleScript)"
```


CMD一键安装winrar注册激活 [以winrar为例](https://www.52pojie.cn/thread-1740471-1-1.html)

```
powershell -command Invoke-WebRequest -Uri "https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/winrar_down_reg.bat" -OutFile "C:/Users/${env:UserName}/Downloads/winrar_down_reg.bat"&&TIMEOUT /T 1&&start /b C:\Users\%username%\Downloads\winrar_down_reg.bat
```

CMD一键生成Emeditor序列号

```
curl -O https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/d-pwsh/main/emeditor_random_keygen.ps1&&powershell -c emeditor_random_keygen.ps1
```

Powershell一键IDM激活

```
iwr -useb https://ghproxy.com/https://raw.githubusercontent.com/lstprjct/IDM-Activation-Script/main/IAS.ps1 | iex
```

Powershell从XchangePDF Editor下载安装到生成许可证 

```
curl https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/xchange_v8_active.ps1 -Outfile xchange_v8_active.ps1 | powershell -c xchange_v8_active.ps1
```

---

对于我来说，博客更侧重日常生活，再专门的平台发稿就行了。现在想来那些在xx之家、xx论坛投稿的，也是聪明人。一边专修技能，一边注重生活，真是两不误。


<!--
[![telegram](https://img.shields.io/badge/telegram-:me-blue.svg?longCache=true&style=flat-square)](https://t.me/test) 

![ ](https://raw.githubusercontent.com/hoochanlon/hoochanlon/master/assets/github-contribution-grid-snake.svg)
-->


