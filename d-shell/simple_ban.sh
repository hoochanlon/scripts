yum install epel-release -y && yum update -y
yum install fail2ban-firewalld fail2ban-systemd -y 
yum -y install git python3

echo -e "安装及配置fail2ban: 两次输入错误密码，封禁IP永久。\n"
echo -e \
"
[DEFAULT]
ignoreip=127.0.0.1 ＃用于指定哪些地址(IP/域名等)可以忽路fai12ban防御，空格分隔
findtime=30 ＃检测扫描行为的时间窗口（单位：秒），和maxretry结合使用，30秒内失败2次即封禁
maxretry=2 ＃检测扫描行为的次数，和findtime结合使用，30秒内失败2次即封禁
bantime= -1 ＃封禁该ip的时间（单位：秒），-1为永久封禁
banaction=iptables-allports #封禁该ip的端口

[sshd]
enabled=true #启用ssh扫描判断器
port=22 ＃ssh的端口，如更换过ssh的默认端口请更改成相应端口
filter=sshd #启用ssh扫描判断器
logpath=/var/log/auth.log #系统行为记录日志，一般无需改动
" >> /etc/fail2ban/jail.local

echo -e "加入守护进程，已设定自启，fail2ban现已启动 \n"
systemctl enable fail2ban.service && systemctl start fail2ban.service
echo -e "查看ban IP后续可使用：cat /var/log/fail2ban.log "

# 调试代码
# rm -rf /.ssh/authorized_keys

# 报错调整参考：
# [fail2ban/issues/3462](https://github.com/fail2ban/fail2ban/issues/3462)
# [豆瓣-CentOS7 - 安装配置Fail2ban教程](https://www.douban.com/note/626688457/?_i=6892452FeAKN2V)
# [csdn-centos8安装Nginx时报错 nginx.service: Unit cannot be reloaded becau lines 1-5](https://blog.csdn.net/m0_47748508/article/details/119203994)
