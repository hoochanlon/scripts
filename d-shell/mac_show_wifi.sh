# 保持代码样式写文件
cat << 'EOF' > ~/Public/mac_show_wifi.sh

# 详情：https://developer.apple.com/documentation/security/1515362-seckeychainsearchcopynext/

# 获取当前Wi-Fi名称
wifi_ssid=$(networksetup -getairportnetwork en0 | awk '{print $4}')

# 获取当前Wi-Fi密码
# -D 指定项；-a 接收账户，传递到security；-w明文。
wifi_password=$(
  security find-generic-password \
  -D "AirPort network password" \
  -a "$wifi_ssid" \
  -w
)

# 打印Wi-Fi与Wi-Fi密码
echo "Wi-Fi："$wifi_ssid;echo "Wi-Fi密码："$wifi_password

# echo -e "Wi-Fi："$wifi_ssid \n Wi-Fi密码：$wifi_password" >> Wi-Fi密码.txt

brew install qrencode > /dev/null 2>&1
# 只屏蔽报错不屏蔽输出，2> /dev/null
qrencode -l M -t UTF8 -s 4 -m 2 "WIFI:${wifi_ssid} Wi-Fi密码:${wifi_password}" 2> /dev/null

EOF

# 创建软链接文件夹
sudo -S mkdir -p /usr/local/bin
# 保险起见先删除再说
sudo rm -rf /usr/local/bin/mac_show_wifi.shortcut
# 没有环境变量，进入目录创建软链接。
cd /usr/local/bin
sudo ln -s  \
~/Public/mac_show_wifi.sh mac_show_wifi.shortcut \
&& echo "alias Wi-Fi密码='bash mac_show_wifi.shortcut'" >> ~/.zshrc

echo '重开终端，自此以后，查看Wi-Fi密码，在终端输入："Wi-Fi密码"，即可。'
