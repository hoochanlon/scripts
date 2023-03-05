yum install -y epel-release

yum install -y git*

git clone https://gh.api.99988866.xyz/https://github.com/rofl0r/proxychains-ng.git

cd proxychains-ng
# 指定相关配置目录
./configure --prefix=/usr --sysconfdir=/etc
# 编译与安装
make && sudo make install

# 下载pigchacli与安装
# sudo rm -rf /usr/bin/pigchacli
# sudo curl -o /usr/bin/pigchacli https://webdownload.duangspeed.com/linux/pigchacli_x86_64 -k
# sudo chmod +x /usr/bin/pigchacli
# 拷贝文件到etc目录，并配置
sudo cp ./src/proxychains.conf /etc/
# vim /etc/proxychains.conf
sed -i '161s/^/# /'  /etc/proxychains.conf
echo -e "http 127.0.0.1 15777" >> /etc/proxychains.conf