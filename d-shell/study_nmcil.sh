# ******************新知*****************************
#
# /etc/udev/rules.d/70-persistent-net.rules Linux的网驱命名，NAME键值不一定为eth0，这取决于你的更改记录。
# [Linux网络架设篇，虚拟机l系统中网卡设备名与配置文件不符如何处理？](https://www.bbsmax.com/A/o75NB3Ex5W/)

# centos8里,当BOOTPROTO=dhcp的时候,会动态获得ip地址,如果下面也静态指定了ip地址,也会生效
# centos7里,当BOOTPROTO=dhcp的时候,会动态获得ip地址,如果下面也静态指定了ip地址,不会生效
#
#****************************************************

# 安装IP计算器
if [ ! -x $(command -v ipcalc) ]; then yum install -y ipcalc;fi

# 找出错误的居然是chatgpt 
# [qiita-nmcliコマンドの隅をつつく](https://qiita.com/kanatatsu64/items/b7b8eca17202386d27e3)
# ifconfig -s、netstat -i、nmcli device显示网卡清单
# awk抓取第二行，cut空行做分隔符，选取第一段字符
# 得到第一块网卡名 "System eth0" (不是eth0设备驱动名)
eth0_name=$(nmcli con |awk 'NR==2'|cut -d' ' -f1,2)

# DHCP 
nmcli con mod "$eth0_name" ipv4.method auto

# 专项解说：
# 这么多做几次的话，会一个网卡绑定多个IP。
## 如果一台服务器有多个IP地址，而且每个IP地址与服务器上部署的每个网站一一对应，这样当用户请求访问不同的IP地址时，会访问到不同网站的页面资源
## 这条命令会记录历史改写的配置，但如果进行重载了，是不会的。相当于初始化。
# nmcli con mod "$(nmcli con |awk 'NR==2'|cut -d' ' -f1,2)" ip4 10.10.10.10/24 gw4 10.10.10.1

# static
# 再配置一遍动态DHCP，难怪我就理解了，centos8只要存在DHCP项，下面的静态配置就失去了效果。
nmcli c mod "System eth0" \
ip4 172.24.10.150/24 \
gw4 172.24.10.100 \
ipv4.dns 172.24.10.254 \
ipv4.method manual autoconnect yes

nmcli con reload #重载

# [csdn-配置静态IP地址（centos和ubuntu）](https://blog.csdn.net/weixin_47661174/article/details/125894194)
# [Linux系统中手动配置IP地址（CentOS 7、8为例）](https://blog.csdn.net/weixin_44411385/article/details/123499862)
# [nmcli详解](https://blog.csdn.net/wq1205750492/article/details/124497231)
# [csdn-Linux中nmcli命令详解](https://blog.csdn.net/yulin003/article/details/125561203)
# [csdn-RHEL8使用nmcli配置网络](https://blog.csdn.net/omaidb/article/details/120028501)
# [51cto-快速上手Apache](https://blog.51cto.com/u_14519396/6000235)
# [电子发烧友论坛-嵌入式Linux下如何设置永久ip和临时ip地址](https://bbs.elecfans.com/jishu_2190937_1_1.html)


 
