echo -e "置顶：执行脚本需要使用 sudo bash 指令，配置SSH服务端登录、口令验证、长会话响应心跳连接、IP范围限自家用。\n"


echo -e "----------配置服务端：Linux SSH，启动---------------\n"

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
AllowUsers *@$get_my_ip *@127.0.0.1 # 刚登录上就立马切代理容易中断SSH连接。
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
echo -e "关于本次修改的服务端配置：\n"
echo -e "SSH各项配置：vi /etc/ssh/sshd_config"
echo -e "密码策略各项配置：vi /etc/pam.d/system-auth \n"

echo -e "---开始配置Windows/Mac客户端。进阶工具：remote ssh for vscode。---------\n"
echo -e '第一步，生成Windows/Mac主机上的SSH共钥：ssh-keygen -t ed25519 -C "your@email.com" \n'
echo -e "第二步，复制公钥到远程: ssh-copy-id -i ~/.ssh/id_ed25519.pub user@server \n"
echo -e "至此客户端配置完成。\n"
echo -e "------其他答疑------\n"
echo -e "如遇“Host key verification failed”，复制以下指令可解决：\n"
echo -e "rm -rf ~/.ssh/known_hosts && rm -rf ~/.ssh/known_hosts.old\n"
echo -e "免密登录成功后，sshd_config中可注释掉AllowUsers配置的IP白名单了，因为仅限你一台主机认证许可。"
echo -e "你也可以安装fail2ban，或修改本代码，自定义IP活动范围，各省地区及运营商网段参考：http://ips.chacuo.net/view/s_GD \n"

# 删除自身
rm -rf $0

# echo -e '本机将文件上传到Linux：scp ~/Desktop/simple_ssh.sh root@101.xxx.xxx.xxx:${HOMEPATH} \n'
# 限制IP活动范围的五条说明

# 1. 虽然公网IP是临时的，但一个在小范围的内，通常变动不大。
# 2. 因为常常变动的话，一是要有足够的IP资源，二是运营商不断调配IP，也会极大增加维护人工时间与物力成本。
# 3. 更何况现在的家庭网络路由器都是公网IP一个IP共享给多个主机、移动终端上网，这也是少有变动。
# 4. ssh配置限IP访问策略，比防火墙方便。防火墙需要开启守护进程与启动，并且需要配置条目规则。
# 5. centOS8也不支持hosts.deny了，所以这里就以SSH的限制做标准啦。

# 试验结果：

## ssh

# * 挪动ssh文件到其他目录会出现验证失败。
# * 变更ssh文件，最好将sshd服务重启下，不然有影响到输入密码
# * PasswordAuthentication no 还会输密码，除权限外，就是自定义名称，客户端没配置ssh config的原因。
# * 发现了ssh公钥可接入多台主机，没必要做遍历、找出最新文件，文件名附上时间来创建ssh key了
# 系统对ssh验证文件权限的强制要求。操作快了，客户端没发公钥，就没有authorized_keys。
# IP对了，SSH密钥不对，其实系统还是会要你输密码。 
# Authenticator provider $SSH_SK_PROVIDER did not resolve 检查下你的客户端ssh config文件


## 其他

# root执行sudo时不需要输入密码(sudoers文件中有配置root ALL=(ALL) ALL这样一条规则)
# `su -` 需要写入进 /etc/sudoers 才能使用自己密码提权限。
# 自己成为root的方式实现起来比较轻松，或加入wheel组。过于繁琐

## * <<learn learn 会出现：Vim: Warning: Output is not to a terminal

# 参考资料

# * [csdn-ssh免登陆配置](https://blog.csdn.net/lux_veritas/article/details/8255613)
# * [ssh正在寻找的默认文件名是id_rsa和id_rsa.pub](https://unix.stackexchange.com/questions/131886/ssh-public-key-wont-send-to-server)
# * [cnblogs-CentOS7.4配置SSH登录密码与密钥身份验证踩坑 ](https://www.cnblogs.com/Leroscox/p/9627809.html)
# * [cnblogs-SSH 运维总结](https://www.cnblogs.com/kevingrace/p/6110842.html)
# * [x技术-一种Linux系统下用户终端操作命令及回显信息监控方法与流程](https://www.xjishu.com/zhuanli/62/201811249220.html)
# * [简书-Shell 脚本自我删除](https://www.jianshu.com/p/226ac2f34be2/)
# * [csdn-shell脚本中的多行注释](https://blog.csdn.net/s2603898260/article/details/105525111)
# * [csdn-Linux 密码策略配置](https://blog.csdn.net/qq_41054313/article/details/121786781)
# * [PHP教程-Linux系统设置复杂密码策略方法](https://www.xp.cn/b.php/80908.html)
# * [腾讯云-Linux多台服务器共用密钥ssh自动登陆](https://cloud.tencent.com/developer/article/2036440)
# * [百度知道-命令cp -a 和 cp -p 有什么区别？](http://zhidao.baidu.com/question/547747089/answer/2398650655)
# * [csdn-echo命令的换行方法](https://blog.csdn.net/qq_32907195/article/details/128553287)
# * [脚本之家-详解shell中>/dev/null 2>&1到底是什么](https://www.jb51.net/article/106373.htm)
# * [csdn-ssh_config和sshd_config配置文件](https://blog.csdn.net/mynumber1/article/details/123699660)
# * [cnblogs-cp如何将同一个路径下的多个文件复制到某个目录下](https://www.cnblogs.com/ztt-14789/p/16767861.html)
# * [try8-CentOS8网络配置教程（centos8，网卡重置命令变动）](https://try8.cn/article/10010)
# * [gitee - /etc/hosts.deny不生效（版本移除，以及默认不支持问题）](https://gitee.com/openeuler/kernel/issues/I29Z76)
# * [csdn-Linux处理海量数据之cut、awk、sed命令](https://blog.csdn.net/vincent_wen0766/article/details/108256276)
# * [csdn-sed -i 命令详解](https://blog.csdn.net/qq_42767455/article/details/104180726)
# * [csdn-如何使echo命令结果显示单引号或者双引号](https://blog.csdn.net/qq_43551263/article/details/111343584)
# * [csdn-【Linux】查看服务器当前 SSH 连接 IP 地址](https://blog.csdn.net/qq_42951560/article/details/125030247)

# 保留资料

# * [csdn-Linux系统中将普通用户权限提升至root权限](https://blog.csdn.net/weixin_45178128/article/details/103155720)
# * [csdn-Linux新增ssh登录用户并加入sudo组](https://blog.csdn.net/xiunai78/article/details/84578529)
# * [csdn-linux中禁用Root帐户的4种方法](https://blog.csdn.net/qq_40907977/article/details/120698811)
# * [脚本之家-shell脚本for循环实现文件和目录遍历](https://www.jb51.net/article/230123.htm)
# * [China unix-shell条件判断if中的-a到-z的意思](http://blog.chinaunix.net/uid-31012107-id-5823694.html)
# * [csdn-通过修改配置屏蔽SSH的弱加密算法](https://blog.csdn.net/miaodichiyou/article/details/120504344)
