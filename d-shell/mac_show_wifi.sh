## 获取当前连接网络ssid
now_conn_ssid=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')
# 获取当前Wi-Fi连接密码
echo "WIFI: $now_conn_ssid"
security find-generic-password -ga $now_conn_ssid | grep "password:"

echo "
now_conn_ssid=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')
echo WIFI: $now_conn_ssid
security find-generic-password -ga $now_conn_ssid | grep 'password:'
" > ~/Public/mac_show_wifi.sh

# 创建软链接文件夹
sudo -S mkdir -p /usr/local/bin
# 保险起见先删除再说
sudo rm -rf /usr/local/bin/mac_show_wifi.shortcut
# 没有环境变量，进入目录创建软链接。
cd /usr/local/bin
sudo ln -s  \
~/Public/mac_show_wifi.sh mac_show_wifi.shortcut \
&& echo "alias Wi-Fi密码='bash mac_show_wifi.shortcut'" >> ~/.zshrc

echo '重启终端，自此以后，查看Wi-Fi密码，在终端输入："Wi-Fi密码"，即可。'




# 草稿
# 创建符号链接，权限拒绝没搞定（已OK）
# sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/bin/airport

# 安装二维码工具
# brew install qrencode > /dev/null 2>&1
# qrencode -l M -t UTF8 -k "此处输入文字内容"

# 取第一列不打印第一行
# sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport en0 -s|awk 'NR == 1 {next} {print $1}' > wifiname.txt
# for line in $(cat wifiname.txt)
# do
# security find-generic-password -ga $line| grep "password:"
# done
# rm -rf ~/wifiname.txt

# 获取密码
# security find-generic-password -ga $now_conn_ssid| grep "password:"


# 参考
# [爱玛网-Shell 生成二维码](https://www.likecs.com/show-203261345.html#sc=147)
# [微信公众号-在Windows、Linux和Mac上查看Wi-Fi密码](https://mp.weixin.qq.com/s?__biz=MzUxODgzMDQ4NQ==&mid=2247512417&idx=3&sn=98a1775611a539d4162755f4b354d685&chksm=f980119bcef7988d2c02cc745edce9898f9686f2e7f0e12be3c7e9613836e83302449318a88c&scene=27)
# [dovov-在MAC OS X上通过SHELL脚本获取无线SSID](https://www.dovov.com/mac-os-xshellssid.html)
# [csdn-Mac 内置最强WI-FI抓包工具 Airport](https://blog.csdn.net/wank1259162/article/details/104916371)
# [爱码网-linux提取第一列且删除第一行（awk函数）](https://www.likecs.com/show-306157304.html#sc=664)
# [Shell脚本中读取文件每一行的方法总结](https://zhuanlan.zhihu.com/p/471540704?utm_id=0)
# [cnblogs-aircrack-ng破解WiFi密码](https://www.cnblogs.com/tom2015010203/p/9493595.html)
# [cnblogs-Mac Security工具使用总结](https://www.cnblogs.com/pixy/p/4817579.html)
