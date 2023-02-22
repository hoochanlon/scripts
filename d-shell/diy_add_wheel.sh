echo -e "root用户设置好后，用该脚本，可如PC一样，创建一个带管理员权限的自定义用户 \n"
echo -e "（⭐︎ 一个具有管理员权限的个性化账户，看起来如Windows PC般丝滑 ⭐︎）\n"

#******************创建wheel组用户*****************

# 接收用户输入流，并创建wheel组用户
read -p "请输入用户名：" user_name && useradd -g wheel $user_name

echo -e "$user_name 用户创建已完成 \n"

echo -e "◉ 注：显示明文，方便密码核对后确认 \n"

# -s： 隐藏输入的数据，适用于机密信息的输入
read -p "请输入密码：" pass_word 

# 将 P@ssw0rd 密码传递至passwd的标准输入（stdin）
echo $pass_word | passwd --stdin $user_name

# **************开启wheel组功能**************

# 授权读写，并开启wheel的免密sudo
chmod u+w /etc/sudoers && sed -i 's/# %wheel/%wheel/g' /etc/sudoers

# 灵感来自腾讯云lighthouse配置。他这么配，我也这么配好了。
echo "$user_name ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# 关闭授权
chmod u-w /etc/sudoers 

# 最后让wheel组的成员，切换sudo也全都免密。
# 替换 #a成a（懒人做法），centos 默认是注释，关闭着的。
sed -i 's/#a/a/g' /etc/pam.d/su

#**********************其他关键性操作*******************

# 拷贝公钥认证到wheel用户目录，没有就算啦。抛个异常，不显示，完事。
cp -p ~/.ssh/authorized_keys /home/$user_name/.ssh/authorized_keys > /dev/null 2>&1

# 替换掉PermitRootLogin yes，关闭root远程登录 (但没设定 PermitRootLogin yes，就没什么效果)
# sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config

# 所以还是删除，再追加 PermitRootLogin no 吧。
sed -i '/^PermitRootLogin/d' /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config

# sshd.service 重载
systemctl reload sshd.service

echo -e "\n root SSH登录已关闭（PermitRootLogin no），所有配置均匀完成。"
echo -e "重新再SSH登录即生效， 现可使用 $user_name SSH登录Linux \n"

#********************参考部分***************************

# 字符串处理参考：
# [csdn-sed -i 命令详解](https://blog.csdn.net/qq_42767455/article/details/104180726)

# wheel 组管理参考
# [csdn-Linux学习笔记之CentOS7的 wheel组](https://blog.csdn.net/kfepiza/article/details/124701762)
# [51cto-Linux Shell脚本专栏_批量创建100用户并设置密码脚本_03](https://blog.51cto.com/gblfy/5652817#_38)

# shell接收输入参数
# [csdn-Linux Shell接收键盘输入](https://blog.csdn.net/u013541325/article/details/126049060)

#*******************************************************

# 本地调试代码
# scp ~/Desktop/diy_add_wheel.sh root@10x.xxx.xxx.xx5:$HOMEPATH

# 删除自身
rm -rf $0
