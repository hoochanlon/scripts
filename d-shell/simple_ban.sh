yum install epel-release -y && yum update -y
yum install fail2ban-firewalld fail2ban-systemd -y 
yum -y install git python3

echo -e "安装及配置fail2ban: 两次输入错误密码，封禁IP永久。\n"
# 备份原始文件
mkdir -p /etc/bak/fail2ban_conf/ && cp -p /etc/fail2ban/jail.conf /etc/bak/fail2ban_conf/
# 看来得做个定义输出，插入替换式使用。
echo -e \
"
[DEFAULT]
ignoreip = 127.0.0.1 ＃用于指定哪些地址(IP/域名等)可以忽路fai12ban防御，空格分隔
maxretry = 3   #检测扫描行为的次数，和findtime结合使用，30秒内失败3次即封禁
findtime  = 10 #在该时间段内超过尝试次数会被ban掉
bantime = -1  #屏蔽时间，默认是秒，-1为永久封禁

# “ssh-iptables”为模块配置名称，命令用法 fail2ban-client status + 模块名
# 如：fail2ban-client status  ssh-iptables

[ssh-iptables] 
enabled = true
filter = sshd
action = iptables[name=SSH, port=22, protocol=tcp] # action - 指定被命中 IP 主机地址禁止其访问的行为
logpath  = /var/log/secure #系统行为记录日志，一般无需改动
" >> /etc/fail2ban/jail.local


echo -e "加入守护进程，已设定自启，fail2ban现已启动 \n"
systemctl enable fail2ban.service && systemctl start fail2ban.service
echo -e "查看ban IP后续可使用： fail2ban-client status ssh-iptables"

rm -rf $0
# 报错调整参考：
# [stackoverflow-cant-enable-fail2ban-jail-sshd](https://stackoverflow.com/questions/42320994/cant-enable-fail2ban-jail-sshd)
# [fail2ban/issues/3462](https://github.com/fail2ban/fail2ban/issues/3462)
# [learnku-如何使用 fail2ban 来防范 SSH 暴力破解？](https://learnku.com/server/t/36233)
# [豆瓣-CentOS7 - 安装配置Fail2ban教程](https://www.douban.com/note/626688457/?_i=6892452FeAKN2V)
# [csdn-centos8安装Nginx时报错 nginx.service: Unit cannot be reloaded becau lines 1-5](https://blog.csdn.net/m0_47748508/article/details/119203994)
# [How to Install Fail2ban on Rocky Linux and AlmaLinux](https://www.tecmint.com/install-fail2ban-rocky-linux-almalinux/)
