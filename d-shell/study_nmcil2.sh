# ``` 网络配置 板块一
#
# 如果同时设置了动态获取IP和静态IP，那么静态IP将不再有效。系统会优先使用动态获取IP的配置。
# bootp 是一种比较老的协议，几乎已经过时了，dhcp 是 bootp 的一种扩展，与 bootp 兼容。
# none 不禁用网卡，暂时也不用静态IP，如果指定静态IP就用静态的（特殊装机环境）
#
# 系统出厂初始配置如下：
#
# dhcp #协议类型 dhcp bootp none
# HWADDR=52:54:00:35:3a:ac # mac
# ONBOOT=yes #启动时是否激活 yes | no
# PERSISTENT_DHCLIENT=yes # 持久化选项，持续响应DHCP获取IP yes|no|1|0 
# TYPE=Ethernet #网卡类型为以太网
# USERCTL=no # 是否允许非root用户控制该设备 yes/no
#
# ```


#``` 网络配置 板块二
#
# PROXY_METHOD=none # 代理关闭
# BROWSER_ONLY=no # 代理只限于浏览器？yes or no
# IPADDR=172.24.10.150
# PREFIX=24 # 也可以写为（METMASK=255.255.255.0但是二者一般只写其中的一种）
# GATEWAY=172.24.10.100
# DNS1=172.24.10.254
# DNS2=172.24.10.253
# DEFROUTE=yes # 默认路由开启，数据包的出口。
# IPV4_FAILURE_FATAL=no # 关闭错误检测
# IPV6INIT=no # ipv6关
# IPV6_DEFROUTE=yes # 开启ipv6默认路由设置
# IPV6_FAILURE_FATAL=no # 关闭错误检测
# NAME="System eth0" # 标识网络设备名称 （基于nmcil管理）
# UUID=5fb06bd0-0bb0-7ffb-45f1-d6edd65f3e03 #唯一表示码，可通过uuidgen eth0 生成
#
#```

#```` 推测与分析
#
# 实际上多出来的这些参数是默认的，我们只保留 IPADDR、METMASK、GATEWAY、DNS2、DNS1 就好了。
# 此外，Linux的网驱命名，NAME键值不一定为eth0，这取决于你的更改记录：
#  /etc/udev/rules.d/70-persistent-net.rules 
#
# 专项解说：
##  nmcli con mod "System eth0" ip4 10.10.10.10/24 gw4 10.10.10.1 
## 这么多做几次的话，会一个网卡绑定多个IP。
## 如果一台服务器有多个IP地址，而且每个IP地址与服务器上部署的每个网站一一对应，这样当用户请求访问不同的IP地址时，会访问到不同网站的页面资源
## 再配置一遍动态DHCP，难怪我就理解了，centos8只要存在DHCP项，下面的静态配置就失去了效果。
## 注意：这条命令会记录历史改写的配置，但如果进行重载了，是不会的。相当于初始化。
#```


# **************调试代码************************
# cat /etc/sysconfig/network-scripts/ifcfg-eth0
# nmcli c mod "System eth0" \
# ip4 172.24.10.150/24 \
# gw4 172.24.10.100 \
# ipv4.dns 172.24.10.254 \
# ipv4.method manual autoconnect yes

# rm -rf ~/.ssh/known_hosts && rm -rf ~/.ssh/known_hosts.old
# echo "192.168.0.1 255.255.255.0 192.168.0.11" > ${HOMEPATH}add_ip_net.txt
# echo "192.168.0.1,255.255.255.0,192.168.0.11" > ${HOMEPATH}add_ip_net.txt
# echo "192.168.0.1/24 192.168.0.11" > ${HOMEPATH}add_ip_net.txt
#************************************************

#********** 开始配置 network-scripts/ifcfg-eth0 *******************
echo -e "注意，该脚本适用于个人便利性及新手使用。 \n"

# 原则上是适配centos 8的，为了一定程度上的便利，将从network manager抓取设备名。
# 获取首行的网卡设备，提取到网卡设备别名。
# ifconfig -s、netstat -i 显示网卡清单
# nmcli device |awk 'NR==2{print $4,$5,$6}'

a_eth=$(nmcli device |awk 'NR==2{print $1}')

# sed 检查文本是否存在关键字，有则删除行
sudo sed -i '{/IPADDR=/d;/GATEWAY=/d;/PREFIX=/d;/METMASK=/d;}' "/etc/sysconfig/network-scripts/ifcfg-$a_eth"
# sed 匹配 “BOOTPROTO=dhcp”，整行替换
sudo sed -i 's/BOOTPROTO=dhcp/BOOTPROTO=none/g' "/etc/sysconfig/network-scripts/ifcfg-$a_eth"

echo -e "支持 192.168.0.1/24 格式，可空格或逗号分段：IP 子网掩码 网关 \n"
read -p "请输入IP、子网掩码、网关: " add_ip_net

# 传入到文本进行分割取值
echo "$add_ip_net" > ${HOMEPATH}add_ip_net.txt

if [ ! "$(cat ${HOMEPATH}add_ip_net.txt|grep '/')" ]; then

a_ip=$(cat ${HOMEPATH}add_ip_net.txt|awk -F "[, ' ']" '{print $1}')
a_mask=$(cat ${HOMEPATH}add_ip_net.txt|awk -F "[, ' ']" '{print $2}')
a_gateway=$(cat ${HOMEPATH}add_ip_net.txt|awk -F "[, ' ']" '{print $3}')

# 插入
sudo echo "

IPADDR=$a_ip
METMASK=$a_mask
GATEWAY=$a_gateway

" >> "/etc/sysconfig/network-scripts/ifcfg-$a_eth"

else

a_ip=$(cat ${HOMEPATH}add_ip_net.txt|awk -F "[, / ' ']" '{print $1}')
a_prefix=$(cat ${HOMEPATH}add_ip_net.txt|awk -F "[, / ' ']" '{print $2}')
a_gateway=$(cat ${HOMEPATH}add_ip_net.txt|awk -F "[, / ' ']" '{print $3}')

# 插入
sudo echo "
IPADDR=$a_ip
PREFIX=$a_prefix
GATEWAY=$a_gateway
" >> "/etc/sysconfig/network-scripts/ifcfg-$a_eth"

fi

rm -rf ${HOMEPATH}add_ip_net.txt
systemctl restart network
echo "修改成功。小推荐：yum install -y ipcalc （子网掩码换算器）"
echo '若将网络设置成自动获取，输入此条指令即可：nmcli con mod "System eth0" ipv4.method auto'
echo '若后续添加DNS，输入该指令生效：nmcli c mod "System eth0" ipv4.dns 1.1.1.1,223.5.5.5'




# ````参考 
# 网络配置
# [Linux网络架设篇，虚拟机l系统中网卡设备名与配置文件不符如何处理？](https://www.bbsmax.com/A/o75NB3Ex5W/)
# [知乎-BOOTP和DHCP有什么区别？](https://www.zhihu.com/question/57081221)
# [bookstack-IPv4的dhclient守护进程持久化配置](https://www.bookstack.cn/read/openeuler-1.0-base/Administration-IPv4的dhclient守护进程持久化配置.md)
# [csdn-linux静态地址于dhcp共存,linux dhcp 获取ip地址能上网，设置静态ip地址则不能上网...](https://blog.csdn.net/weixin_42513170/article/details/116880156) 
# [爱码网-linux——网络文件的配置](https://www.likecs.com/show-205084292.html)
# [csdn-配置静态IP地址（centos和ubuntu）](https://blog.csdn.net/weixin_47661174/article/details/125894194)
# [Linux系统中手动配置IP地址（CentOS 7、8为例）](https://blog.csdn.net/weixin_44411385/article/details/123499862)
# [nmcli详解](https://blog.csdn.net/wq1205750492/article/details/124497231)
# [csdn-Linux中nmcli命令详解](https://blog.csdn.net/yulin003/article/details/125561203)
# [csdn-RHEL8使用nmcli配置网络](https://blog.csdn.net/omaidb/article/details/120028501)
# [51cto-快速上手Apache](https://blog.51cto.com/u_14519396/6000235)
# [电子发烧友论坛-嵌入式Linux下如何设置永久ip和临时ip地址](https://bbs.elecfans.com/jishu_2190937_1_1.html)
# [9.2. 使用 NetworkManager 命令行工具 nmcli](https://access.redhat.com/documentation/zh-cn/red_hat_enterprise_linux/7/html/networking_guide/sec-network_bridging_using_the_networkmanager_command_line_tool_nmcli)
# [qiita-nmcliコマンドの隅をつつく](https://qiita.com/kanatatsu64/items/b7b8eca17202386d27e3)


# 文本处理
# [csdn-shell编程 sed 命令追查找[关键字] 并在该行附近修改文本](https://blog.csdn.net/lingyiwin/article/details/126022315)
# [csdn-Linux sed 关键字匹配整行中任意字符进行替换(正则表达式整行替换)](https://blog.csdn.net/weixin_44190581/article/details/124266264)
# [csdn-Linux三剑客之awk命令详解](https://blog.csdn.net/qq_57377057/article/details/126254525)
