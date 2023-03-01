# ********** 核心的五篇文档，csdn博主整理思绪排版较为清晰易读。************
## [cnblogs-Linux搭建FTP服务器](https://www.cnblogs.com/Caiyundo/p/9979442.html)
## [csdn-Linux中ftp服务的安装与配置](https://blog.csdn.net/qq_36205206/article/details/125808803)
## [csdn-腾讯云Linux 轻量应用服务器如何搭建 FTP 服务？](https://blog.csdn.net/zdc1228/article/details/128428207)
## [csdn-腾讯云服务器FTP连接不上](https://blog.csdn.net/qq_40787608/article/details/123411675)
## [腾讯云-Linux 轻量应用服务器搭建 FTP 服务](https://cloud.tencent.com/document/product/1207/47638)
## [zhihu-vsftp新建用户无法登录？](https://www.zhihu.com/question/268255821/answer/622810196?utm_id=0)
##
## 往后可以用这款了，配置web云盘分享：https://github.com/zfile-dev/zfile
## 共享文件格式NFS、SMB、FTP、WebDAV 各有何优势：https://blog.csdn.net/hdxx2022/article/details/127490158
#*******************************************************************

#********* 腾讯云文档提醒解读***************************
#
# FTP 可通过主动模式和被动模式与客户端机器进行连接并传输数据。
# 由于大多数客户端机器的防火墙设置及无法获取真实 IP 等原因，建议您选择被动模式搭建 FTP 服务。
# 如下修改以设置被动模式为例，您如需选择主动模式，请前往 设置 FTP 主动模式。
#
# 主动模式和被动模式的不同简单概述为： 
# 主动模式传送数据时是“服务器”连接到“客户端”的端口（客户端开启数据端口）；
# 被动模式传送数据是“客户端”连接到“服务器”的端口（服务端开启数据端口）。
# [csdn-FTP的主动模式和被动模式](https://blog.csdn.net/weixin_42039228/article/details/124338444)
#****************************************************


#-----------下载安装，专属用户创建与限定目录------------

# 添加用户，普通用户是没有权限登录SSH的，需要额外授权，不要紧。
# 完善起见，已 usermod -s /sbin/nologin ftpuser 

yum install -y vsftpd
yum install lsof -y
sudo systemctl enable vsftpd
# 启动成功，默认开启匿名访问，但无权限修改或上传。
sudo systemctl start vsftpd
# 新建组并将用户添加到ftpusers组。
sudo groupadd ftpusers && sudo useradd -g ftpusers ftpuser
# 限制登录终端
sudo usermod -s /sbin/nologin ftpuser 
echo "P@ssw0rd"|sudo passwd --stdin ftpuser # 密码规则测试过关罢了
# 创建FTP共享的特定目录
sudo sudo mkdir /var/ftp/share
echo "hello world " > /var/ftp/share/test.txt
# 授权 -R 递归；属主名:属组名 
sudo chown -R ftpuser:ftpusers /var/ftp/share

#----------备份vsftpd.conf文件，与获取本机公网IP----------

# 这里配置修改以被动模式为例。
# 修改：查找与替换。先sed不加参数匹配试试水，配置完加个中文注释，方便理解。
# 源目录文件备份 vsftpd.conf.bak
cp -rp /etc/vsftpd/vsftpd.conf{,.bak}

# 获取Linux的本机公网IP 服务器
# 详情：https://blog.csdn.net/doris_9800/article/details/104620510
linux_public_ip=$(curl -s http://ip.tool.chinaz.com/ |grep 'class="fz24"' | awk -F '>|<' '{print$3}')

# 获取Windows或Mac电脑的IP 客户端
get_my_ip=$(who|awk '{print $5}'| cut -d '(' -f2 | cut -d ')' -f1|sed -n '1p')

# 这获取IP的方式，有被混淆的风险，毕竟有ssh插队的风险，注释掉
# get_my_ip=$(netstat -n|grep -i :22|awk '{print $5}'|cut -d":" -f1|sed -n '1p')

# cut
# -d 表示需要需要使用自定义切割符
# -f2 表示对切割后的几块内容选择第2部分输出
# -f1 表示对切割后的几块内容选择第1部分输出

#------------------------------------------------------


#************************说明性文档***************************************
#
# local_enable=YES         #支持本地用户登录
# chroot_local_user=YES    #全部用户被限制在主目录
# chroot_list_enable=YES   #启用例外用户名单
# chroot_list_file=/etc/vsftpd/chroot_list  #指定用户列表文件，该列表中的用户不被锁定在主目录
#
#*********************************************************************


#-----------vsftpd.conf 配置用户基本策略：禁匿名、将访问限制在规定目录、ipv4 ----------

# 在12行全局换成anonymous_enable=NO
sed -i '12canonymous_enable=NO' /etc/vsftpd/vsftpd.conf


## 100、101、103行去掉注释，配置chroot如上各项。
sed -i '100,101s/^#//' /etc/vsftpd/vsftpd.conf
sed -i '103s/^#//' /etc/vsftpd/vsftpd.conf

# 将Listen=NO换成Listen=YES
sed -i 's/listen=NO/listen=YES/' /etc/vsftpd/vsftpd.conf

# 在123行首追加注释，即关闭IPv6 sockets
sed -i '123s/^/# /' /etc/vsftpd/vsftpd.conf

# 在52行首取消注释，打开日志记录
sed -i '52s/^#//' /etc/vsftpd/vsftpd.conf

# 开启被动模式 pasv_enable=YES
# pasv连接模式时的最小端口、最大连接端口
# 这里只要把最小端口号和最大端口号配置成一样的，就成了开放固定端口了
# allow_writeable_chroot=YES 在限制目录下可写入
echo -e "
local_root=/var/ftp/share
allow_writeable_chroot=YES
pasv_enable=YES
pasv_address=$linux_public_ip
pasv_min_port=21000
pasv_max_port=21000
" >> /etc/vsftpd/vsftpd.conf

# 创建文件，否则会即使有用户也登录不上，不需要其他权限，ftpuser不访问这个文件
# 推测程序编写的逻辑是靠这一“小文件”来对策略进行决策的，配置开启了这功能，然后又没有文件自然乱套了。（编码人员没想那么多吧，可能不想管...）
touch /etc/vsftpd/chroot_list
## chroot_list_file=/etc/vsftpd/chroot_list 打开限制名单文件配置


# 注释第4行 auth required pam_shells.so 模块认证。
sudo sed -i '4s/^/#/' /etc/pam.d/vsftpd

#------pam_access.so是模块，会调用到配置文件/etc/security/access.conf------
# [csdn-实战vsftp针对用户和IP访问控制](https://blog.csdn.net/weixin_58400622/article/details/126438957)

# /etc/pam.d/vsftpd （模块配置文件）
## 备份/etc/pam.d/vsftpd
cp -rp /etc/pam.d/vsftpd{,.bak}
# 在第7行前插入模块
sudo sed -i '7i\account    required     pam_access.so' /etc/pam.d/vsftpd

# access.conf
## 备份access.conf文件
cp -rp /etc/security/access.conf{,.bak}
## 将最后一个规则定义为全部拒绝，表示只有自己允许的例外条件
## 网上的配置可能存在过时，也就不需要加‘@’访问了，智能识别组名，等于是
echo  -e "
+:ftpusers:$get_my_ip
-:ALL:ALL

" >> /etc/security/access.conf

#---------------------------------------------------


# 重启ftp服务。
sudo systemctl restart vsftpd

echo -e "***调试专用代码***"
echo 'scp /Users/chanlonhoo/Desktop/1.sh root@101.xxx.xxx.xxx:${HOMEPATH}'
echo -e "rm -rf ~/.ssh/known_hosts && rm -rf ~/.ssh/known_hosts.old"
echo -e "查看所有用户信息：cat /etc/passwd"
echo -e "新建用户，添加FTP共享组：useradd -G ftpusers <用户名称>"
echo -e "已有用户，添加FTP共享组：usermod -a -G ftpusers <用户名称>"
echo -e "***************** \n"

echo -e "\n ****************FTP基本说明与概况******************** \n"
echo -e "FTP专属用户已创建完成：ftpuser；密码：P@ssw0rd"
echo -e "FTP共享目录位置：cat /var/ftp/share"
echo -e "重要‼️ 注意在阿里云安全组，或腾讯云服务器防火墙，放行21000端口。"

echo -e "\n至此，FTP搭建已完成，下面是FTP相关配置简览"
echo -e "查看FTP历史访问记录：/var/log/xferlog"
echo -e "核心配置文件：vi /etc/vsftpd/vsftpd.conf"
echo -e "FTP限制用户及IP访问文件：vi /etc/security/access.conf\n"
echo -e "Windows可以用文件管理器访问，就可以上传下载了。"
echo -e "Mac推荐使用Cyberduck、FileZilla、ForkLift访问，自带访达对FTP功能支持不完善。\n"


# 删除自身
rm -rf $0

# 可能该项说明对初次上手的用户是干扰
# echo -e "用户访问其他目录限制配置文件：/etc/vsftpd/chroot_list"
# echo -e "具体操作方法为：填写想要随意访问路径的用户名，一个用户名，占据一行。\n"


#*********参考***********************

## ftp
### [csdn-linux如何查看端口是否开放](https://blog.csdn.net/blueheartstone/article/details/127045442)
### [csdn-shell if else 语句 写成一行](https://blog.csdn.net/qq_29060627/article/details/126471917)
### [cnblogs-Linux搭建FTP服务器](https://www.cnblogs.com/Caiyundo/p/9979442.html)
### [csdn-Linux中ftp服务的安装与配置](https://blog.csdn.net/qq_36205206/article/details/125808803)
### [csdn-FTP被动模式服务器端开有限的端口](https://blog.csdn.net/chipiqiao3947/article/details/100857760)
### [zhihu-vsftpd超实用技巧详解（二）-限制用户逃出家目录](https://zhuanlan.zhihu.com/p/77325423)

## python http server
### [【SimpleHTTPServer】Linux/上使用 python -m SimpleHTTPServer 快速搭建http服务](https://blog.csdn.net/michaelwoshi/article/details/102991018)
### [csdn-python3 报错 No module named SimpleHTTPServer](https://blog.csdn.net/hotpotbo/article/details/88227301)
### [知晓号-linux开端口命令（服务器开启端口命令）](https://www.dkper.com/27137.html)

## smb
### [cnblogs-Windows10 SMB 445端口 公网映射问题的解决方法](https://www.cnblogs.com/Ridiculer/p/15333284.html)
### [csdn-Linux之SAMBA服务——SMB协议](https://blog.csdn.net/qq_46839776/article/details/119939755)
### [cnblogs-Windows10 SMB 445端口 公网映射问题的解决方法](https://www.cnblogs.com/Ridiculer/p/15333284.html)

## 字符串处理
#### [51cto-sed插入行](https://blog.51cto.com/u_4296776/5369128)
#### [csdn-vim配置高亮显示](https://blog.csdn.net/heimao0307/article/details/79757274)
#### [linux 的curl grep awk 联合查询----小练习](https://blog.csdn.net/doris_9800/article/details/104620510)

#****************插曲***********************************

## [灰信网-VSFTPD 启动异常 (CODE=EXITED, STATUS=2)](https://www.freesion.com/article/6269698160/)，忘记sed 加 -i 了...
## 组创建失败也会出现登录异常，服务器上不存在该共享。请检查该共享的名称，然后再试一次
## [csdn-Linux系统用户添加到用户组](https://blog.csdn.net/shenyunsese/article/details/124449334)
## [csdn-usermod命令的 -s使用方法](https://blog.csdn.net/qq_42276808/article/details/104145927)

# cp -p /etc/ssh/{ssh_config,sshd_config,sshd_config.bak} 不可行
## Linux查看用户所属组 groups ftpuser 创建组：groupadd ftpusers 
## 新建用户并将其加入指定用户组,作为其主用户组（每个用户有且只有一个主用户组）
## 新建用户，并关联组
## useradd -g <用户组名称> <用户名称>
## 或者 新建用户并将其加入指定附属用户组，附属用户组可以有多个，多个附属组名称用逗号分隔即可
## useradd -G <用户组名称> <用户名称>
## 已有用户
## -a 代表append，和 -G 一起使用，将用户添加到新用户组中而不必离开原有的其他用户组
## usermod -a -G <用户组名称> <用户名称>

## 谷歌云，默认开启selinux的。国内机器，默认关闭内部的防火墙。
## 如果您服务器内部启用了防火墙，那是要两边一起做策略的。
## 腾讯默认是放开端口的，除非额外限制，目前的策略来看。

# 来自 [csdn-关闭防火墙是否就默认所有端口打开](https://blog.csdn.net/weixin_39166924/article/details/98754038)
# 默认的应该是不防护已开放端口了，端口是否打开的根本是取决于你开的服务或者是应用，
# 这些才会去打开原本没有打开的端口，防火墙只不过在开启的时候会对这些端口做防护而已，并不是防火墙开的这些端口。
# 比如80端口，你只有做了web应用，如iis等服务器上才会打开80端口，这时候防火墙可能会保护80端口，
# 使外面的用户无法访问，但关闭了防火墙，防护取消就可以正常访问了，所以防火墙并不是打开80的根本


#*******FTP安全性设置***************************

# [cnblog-Linux Access.conf安全配置](https://www.cnblogs.com/yizhipanghu/p/14241923.html)
# [zhihu-Linux access.conf 限制用户ssh/rsh登陆不生效的问题](https://zhuanlan.zhihu.com/p/525921900)
# [csdn-实战vsftp针对用户和IP访问控制](https://blog.csdn.net/weixin_58400622/article/details/126438957)
# [金步国-Linux PAM 学习笔记](http://www.jinbuguo.com/linux/pam.html)
# [cnblogs-linux查看当前ssh登陆的ip](https://www.cnblogs.com/you-jia/p/4741717.html)
# [cnblogs-linux shell脚本 如何去除变量中的小括号](https://blog.csdn.net/qq_25955145/article/details/116011951)
# access.conf不生效很大程度与PAM有关。
