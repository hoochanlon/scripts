# Mac指令速记即用

`sudo -S`之后的操作可不用输密码；终端挂载不休眠`caffeinate`，以及安装` neofetch` 可查看系统资料。`tldr`比`man`更好用。


### vim日常操作

---
* 显示行数，`set nu`，删除当前行，`dd`；删除X-Y行，`24,30d`。
* 将X-Y行复制，`24，30 copy`；将X-Y行剪切至Z行，`24,30 move 10`。
* 将所有星号替换为减号，`%s/*/-/`；定位特定行，替换字符，`10,50s/word1/word2/`。
* “yy”复制当前行；p贴在下一行；重复上回单次操作键盘“.”。
* ”u“撤销，”ctrl+r” 前进。
---

### 个人常用的Shell

#### 简化解除软件门禁指令

保存别名到存档配置文件，已软件签名为例

* ls >> test.txt 定向输入到文件，echo 输入可自动换行
* 配置存档 for Mac，新版为`~/.zshrc`
* 参考：[Catalina以后的系统添加别名](https://blog.csdn.net/weixin_26737625/article/details/108259518)、[macOS Command - xattr](https://blog.csdn.net/lovechris00/article/details/113060237)

```
echo "alias sign='sudo xattr -d com.apple.quarantine'" >> ~/.zshrc
```

#### 安装允许任何来源

```
sudo spctl --master-disable
```

#### 修复程序启动以及打开方式重复的bug

```
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
```

#### 把文件扔进垃圾桶

```
trash /Users/chanlonhoo/未命名文件夹
```

#### App Store下载出问题用终端的应用商店mas

```
brew install mas
mas search bear
mas install 1091189122
```

#### 截图

更改默认前缀

```
defaults write com.apple.screencapture name "catch"
```

更改截图文件类型jpg

```
defaults write com.apple.screencapture type jpg
```

#### 复制路径

复制当前路径

```
pwd｜pbcopy

```
参考：[Linux 系统中“|”管道的作用是什么](https://zhidao.baidu.com/question/548984916.html)

把长串目录临时设置变量

```
# 设置变量，并进入改变量目录
workdir='/filer/home/xiaoming'|cd $workdir
# 写入文件永久执行
echo "export workdir='/filer/home/xiaoming'" >> ~/.bash_profile
```
改写：[百度知道-linux 把长路径名赋值给变量](https://zhidao.baidu.com/question/2206329112263835988.html)

#### 查看系统启动时间及信息

启动时间

```
uptime
```

系统信息

```
brew install neofetch && neofetch
```

#### 替换搜索工具find与安装目录切换工具

```
brew install fd  && brew install z
```

#### 原生查看系统信息并简化

* 将指令参数等重命名为`systeminfo`，简化命令字母单词
* `>>` 并写配置文件` ~/.zshrc`永久保存

```
echo "alias systeminfo='system_profiler SPSoftwareDataType SPHardwareDataType'" >> ~/.zshrc
```

#### brew查看安装过的东西

其中cask是增强包

```
brew list
```

#### git使用ssh

生成 ssh key 并复制密钥内容

参考：[码农家园-为什么要在ssh-keygen中使用`-t rsa -b 4096`？](https://www.codenong.com/51834225/)

```
ssh-keygen -t rsa -b 4096 -C \
"youmail@outlook.com" \
&&  pbcopy <  ~/.ssh/id_rsa.pub

```

测试链接

```
ssh -T git@gitlab.com
```

#### 对查看IP地址命令进行简化，`ip`

内网

```
echo "alias ip=ipconfig getifaddr en0" >> ~/.zshrc
```

外网

```
curl cip.cc
```

参考：https://www.yundongfang.com/Yun124125.html


####  清除DNS缓存

```
sudo dscacheutil -flushcache
```

#### 查看磁盘空间

```
brew install duf && duf --all
```

#### 查看隐藏文件

```
ls -al
```

### [Nigate Free-NTFS-for-Mac](https://github.com/hoochanlon/Free-NTFS-for-Mac)

#### Homebrew(Mac、Linux)

```
 /bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/install.sh)"
```

#### 下载文件内容写入到某个位置

参考：[入门小站-linux之curl使用技巧](https://baijiahao.baidu.com/s?id=1714333474878440110)

```
curl https://fastly.jsdelivr.net/gh/hoochanlon/Free-NTFS-for-Mac/nigate.sh > ~/Public/nigate.sh
```
#### 在线执行脚本

* `/bin/bash -c`使用bash执行
* `-fsSL`
  * -f(--fail) — 表示在服务器错误时，阻止一个返回的表示错误原因的 HTML 页面
  * -L(--location) — 参数会让 HTTP 请求跟随服务器的重定向。
  * -S(--show-error) — 指定只输出错误信息，通常与 -s 一起使用。
  * -s(--silent) — 不显示错误和进度信息。

参考：[csdn-curl -fsSL](https://blog.csdn.net/weixin_46267040/article/details/125370144)，顺便提一嘴无关紧要的[终端小游戏](http://www.nndssk.com/xtwt/1479093c5Wg3.html)

```
/bin/bash -c "$(curl -fsSL https://cdn.statically.io/gh/hoochanlon/Free-NTFS-for-Mac/main/nigate.sh)"
```

#### 指令别名与文件软链接

说人话就是把长的命令变成几个字母的单词（别名），文件建立个快捷方式（软链接）

* 文件类型需要用到软链接，不能用别名，别名只适用于命令
* 别名只能生效于本机已存在的文件，curl 那么就用不了了

参考：[csdn-创建mac软件快捷启动方式 软连接方式ln -s](https://blog.csdn.net/guokaigdg/article/details/89457317) 

```
sudo /usr/local/bin ln -s  \
~/Public/nigate.sh nigate.shortcut \
&& echo "alias nigate='bash nigate.shortcut'" >> ~/.zshrc
```
