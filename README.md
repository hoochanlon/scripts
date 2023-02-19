# ***ihs-simple***

[![blog](https://img.shields.io/badge/%F0%9F%94%97blog-hoochanlon-lightgrey.svg?longCache=true&style=flat-square)](https://hoochanlon.github.io/) [![outlook](https://img.shields.io/badge/%F0%9F%93%A7hotmail-@邮箱联系-blue.svg?longCache=true&style=flat-square)](mailto:hoochanlon@outlook.com)[![](https://img.shields.io/github/followers/hoochanlon?color=green&style=social)](https://github.com/hoochanlon) [![](https://img.shields.io/github/stars/hoochanlon?color=green&style=social)](https://github.com/hoochanlon)

一开始只是图方便，放图片做图床的。偶尔随手上传自己的小脚本，折腾电脑的文本，结果却成了个折腾电脑的便利仓...对于我来说，博客更侧重日常生活，再专门的平台发稿就行了，现在想来那些在xx之家、xx论坛投稿的，也是聪明人。一边专修技能，一边注重生活，真是两不误。

* CHAETS 快速复制粘贴指令的
* INTRO 我流式入门学习
* NANO 对病毒源码简略分析
* ZERO 自检脚本与杀毒软件解读

脚本代码及病毒分析文章，仅供学习与交流使用，切勿做违法用途。

## 图床方案

### PicGo

**⚠️ 需注意：上传文件名重复的文件会有报错。**

picgo 有squoosh压缩图片神器批量压缩图片并上传，节约图床存储空间。而且删除本地相册文件不影响远程图床仓，方便查找预览以及快速浏览。


返回路径为

```
https://raw.githubusercontent.com/username/repo/main/dir/file.png
```

须要将链接批量转成cdn

https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/AQUICK/taipei.png

### 批量转cdn链接（自定义域名即可）


将`https://raw.githubusercontent.com/`替换成 `https://cdn.jsdelivr.net/gh/`

例子

```
https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple
```

## 整合

picgo

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/true-picgo.png)

squoosh

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/squooshyes.png)

typora的设置

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/typora-set-ihs-pic.png)

一套操作下来，这样就可以复制粘贴到typora，picgo插件squoosh压缩图片，并上传到GitHub，用cdn返回链接了。nice。


![ ](https://raw.githubusercontent.com/hoochanlon/hoochanlon/master/assets/github-contribution-grid-snake.svg)

<!--
[![telegram](https://img.shields.io/badge/telegram-:me-blue.svg?longCache=true&style=flat-square)](https://t.me/test) 
-->

---

