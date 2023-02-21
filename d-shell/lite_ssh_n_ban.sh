echo -e "置顶：执行脚本需要使用 sudo bash 指令"

# 备份ssh服务端、客户端配置文件到ssh.bak目录
mkdir -p /etc/bak/ssh && cp -p /etc/ssh/{ssh_config,sshd_config} /etc/bak/ssh

# netstat -t查询连接情况，awk抓取第五列信息，过滤掉端口含字母的。获得正确的IP池。
# 再从IP池中cut掉":"端口，取第二行数据提纯，获得了连接服务器上的IP。
# get_my_ip=$(netstat -t|awk '{print $5}'|grep -v -E '[a-zA-Z]'|cut -d":" -f1|sed -n '1p')
# get_my_ip=$(netstat -t|awk '{print $5}'|grep -v -E '[a-zA-Z]|^10|^169|^172|^192'|cut -d":" -f1|sed -n '1p')

# 筛选方式优化，选有:22就行了。
get_my_ip=$(netstat -n|grep -i :22|awk '{print $5}'|cut -d":" -f1|sed -n '1p')
get_my_ip_port=$(netstat -n|grep -i :22|awk '{print $5}'|sed -n '1p')

# 编辑、修改配置权限、重启服务生效
echo -e \
"
PubkeyAuthentication yes # 是否允许Public Key
PermitRootLogin yes # 是否允许Root登录
PasswordAuthentication no # 设置是否使用口令验证
ClientAliveInterval 30 # 客户端每隔多少秒向服务发送一个心跳数据，类似web响应。
ClientAliveCountMax 86400  # 客户端多少秒没有相应，服务器自动断掉连接 
# AllowUsers *@$get_my_ip *@127.0.0.1 # 刚登录上就立马切代理容易中断SSH连接。
" \
>>/etc/ssh/sshd_config

# 该授权的授权，>/dev/null 2>&1 屏蔽报错，有不明白的查找注释的参考资料。
chmod 700 $HOME && chmod 700 ~/.ssh 
touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys >/dev/null 2>&1
systemctl restart sshd.service


#---------------账户密码简化要求-----------------------

# 备份文件
mkdir -p /etc/bak/pam.d/ && cp -p /etc/pam.d/system-auth  /etc/bak/pam.d/
# 可行，但会有Linux系统的无效至少8位字符；pam.d/system-auth优先级远高于login.defs
# 一个是配置系统模块的，另一个只是辅助性质的账号登录策略，两者相差很大

echo -e "
# 新增自定义密码策略配置 密码验证三次 不限特殊字符、大小写、最低3位长度
password\trequisite\tpam_pwquality.so\ttry_first_pass local_users_only retry=3
password\trequisite\tpam_pwquality.so\tauthtok_type= minlen=4 
password\trequisite\tpam_pwquality.so dcredit=0 ocredit=0 lcredit=0 ucredit=0
" >>/etc/pam.d/system-auth

echo -e "\nSSH服务端密钥、登录策略、心跳响应，以及限制IP范围"
echo -e "简化用户密码规则：任意大小写/符号/纯数字，并可设4位长度"
echo -e "SSH服务端（Linux）所有设置均已完成。\n"

#******************安装及配置fail2ban*****************************

echo -e "安装fail2ban以及各项依赖"
yum install epel-release -y && yum update -y
yum install fail2ban-firewalld fail2ban-systemd -y 
yum -y install git python3

echo -e "安装及配置fail2ban: 3次输入错误密码，封禁IP永久。\n"
# 备份原始文件
mkdir -p /etc/bak/fail2ban_conf/ && cp -p /etc/fail2ban/jail.conf /etc/bak/fail2ban_conf/

echo -e \
"
[DEFAULT]
ignoreip = 127.0.0.1 $get_my_ip
maxretry = 3 
findtime  = 10 
bantime = -1

[ssh-iptables] 
enabled = true
filter = sshd
action = iptables[name=SSH, port=22, protocol=tcp] 
logpath  = /var/log/secure
" >> /etc/fail2ban/jail.local


echo -e "加入守护进程，已设定自启，fail2ban现已启动 \n"
systemctl enable fail2ban.service && systemctl start fail2ban.service


#************所有设置完成，开始啰嗦的ECHO*********************

echo -e "****点对点配置项简说*****"
echo -e "服务端SSH各项配置：vi /etc/ssh/sshd_config"
echo -e "服务端密码策略各项配置：vi /etc/pam.d/system-auth"
echo -e "查看ban IP后续可使用：fail2ban-client status ssh-iptables \n"

echo -e '客户端生成密钥: ssh-keygen -t ed25519 -C "your@email.com"'
echo -e "复制公钥到服务端: ssh-copy-id -i ~/.ssh/id_ed25519.pub user@server"
echo -e "客户端故障检查: rm -rf ~/.ssh/known_hosts ~/.ssh/known_hosts.old && cat ~/.ssh/ssh_config \n"

echo -e "------ban｜key｜ password----\n"
echo -e "ban ip的优先级是最高的，有密钥、密码也不行"
echo -e "配置了密钥，没授权许可，就算有密码，也登不上。"
echo -e "大部分Linux被黑，多是密码简单，没配一对一密钥，以及部署服务程序上的提权与反弹相关的漏洞"
echo -e "最为重要的一点限定IP与BAN IP的核心策略设置。"

rm -rf $0
