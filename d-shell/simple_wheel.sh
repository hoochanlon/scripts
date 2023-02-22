
# **************开启wheel组功能**************

# 授权读写
chmod u+w /etc/sudoers

# 开启wheel的免密sudo，并追加wheelman
sed -i 's/# %wheel/%wheel/g' /etc/sudoers

# 灵感来自腾讯云lighthouse配置
echo "wheelman ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# 关闭授权
chmod u-w /etc/sudoers 

# 切换sudo免密，替换 #a成a（懒人做法）
sed -i 's/#a/a/g' /etc/pam.d/su


#*************拷贝公钥认证到wheel用户目录**********
cp -p ~/.ssh/authorized_keys /home/wheelman/.ssh/authorized_keys > /dev/null 2>&1


#******************创建wheelman*****************

# 创建 wheelman 用户
useradd -g wheel wheelman

# 将 P@ssw0rd 密码传递至passwd的标准输入（stdin）
# 这命令只有root才能操作，忘记sudo了....补上
echo "P@ssw0rd"|sudo passwd --stdin wheelman

# 替换掉PermitRootLogin yes，关闭root远程登录
# sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sed -i '/^PermitRootLogin/d' /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config

echo "wheelman 管理员用户创建，测试完成"

#********************参考部分***************************

# 字符串处理参考：
# [csdn-sed -i 命令详解](https://blog.csdn.net/qq_42767455/article/details/104180726)

# wheel 组管理参考
# [csdn-Linux学习笔记之CentOS7的 wheel组](https://blog.csdn.net/kfepiza/article/details/124701762)
# [51cto-Linux Shell脚本专栏_批量创建100用户并设置密码脚本_03](https://blog.51cto.com/gblfy/5652817#_38)

rm -rf $0
