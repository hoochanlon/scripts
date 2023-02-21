# ***<s>[ihs-simple](https://github.com/hoochanlon/ihs-simple/blob/main/THINGS.md#picgo)</s>*** Quick-Simple

[![blog](https://img.shields.io/badge/%F0%9F%94%97blog-hoochanlon-lightgrey.svg?longCache=true&style=flat-square)](https://hoochanlon.github.io/) [![outlook](https://img.shields.io/badge/%F0%9F%93%A7hotmail-@邮箱联系-blue.svg?longCache=true&style=flat-square)](mailto:hoochanlon@outlook.com)[![](https://img.shields.io/github/followers/hoochanlon?color=green&style=social)](https://github.com/hoochanlon) [![](https://img.shields.io/github/stars/hoochanlon?color=green&style=social)](https://github.com/hoochanlon)

脚本代码及病毒分析文章，仅供学习与交流使用，切勿做违法用途。

## 一键搞定SSH登录、用户密码策略配置、Ban IP配置


```
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/lite_ssh_n_ban.sh)"
```

* <details><summary>SSH单项、fail2ban单项 click me! </summary>

一键调用SSH快速配置 SSH密钥登录策略、用户简单密码配置规则。

```
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/simple_ssh.sh)"
```

一键fail2ban从下载到安装及生成配置与启动服务。

```
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/simple_ban.sh)"
```

</details>

终端建议使用管理员身份运行。

CMD一键调用windows版本切换与Windows/Office激活

```
curl -O https://ghproxy.com/https://raw.githubusercontent.com/TerryHuangHD/Windows10-VersionSwitcher/master/Switch.bat&&TIMEOUT /T 1&&start Switch.bat&&powershell -command "irm https://massgrave.dev/get|iex"
```

CMD一键安装winrar注册激活

```
powershell -command Invoke-WebRequest -Uri "https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/winrar_down_reg.bat" -OutFile "C:/Users/${env:UserName}/Downloads/winrar_down_reg.bat"&&TIMEOUT /T 1&&start /b C:\Users\%username%\Downloads\winrar_down_reg.bat
```

CMD一键生成Emeditor序列号

```
curl -O https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/d-pwsh/main/emeditor_random_keygen.ps1&&powershell -c emeditor_random_keygen.ps1
```

Powershell从XchangePDF Editor下载安装到生成许可证 

```
curl https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/xchange_v8_active.ps1 -Outfile xchange_v8_active.ps1 | powershell -c xchange_v8_active.ps1
```

---

对于我来说，博客更侧重日常生活，再专门的平台发稿就行了。现在想来那些在xx之家、xx论坛投稿的，也是聪明人。一边专修技能，一边注重生活，真是两不误。

一开始只是用来做图床，图省事方便偶尔随手上传自己的小脚本，结果却成了...

<!--
[![telegram](https://img.shields.io/badge/telegram-:me-blue.svg?longCache=true&style=flat-square)](https://t.me/test) 

![ ](https://raw.githubusercontent.com/hoochanlon/hoochanlon/master/assets/github-contribution-grid-snake.svg)
-->


