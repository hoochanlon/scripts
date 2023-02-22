## 用户管理


具体参考：[learnku-Linux设定密码策略](https://learnku.com/articles/52174)

### 用户管理

腾讯云自建用户不能SSH登录，参考[码农家园-linux新建用户无法登录ssh](https://www.codenong.com/cs106546599/)。

`vi /etc/sshd_config`

```
AllowGroups root username
```

重启服务

```
/etc/init.d/ssh restart
```

或在`/etc/passwd`文件中，修改username的组标识号。


root执行sudo时不需要输入密码(sudoers文件中，有配置root ALL=(ALL) ALL这样一条规则，该文件必须使用"visudo"命令编辑)， 当用户执行sudo时，系统会主动寻找/etc/sudoers文件，判断该用户是否有执行sudo的权限。

二者任选，自己成为root，或加入wheel组。

1. [csdn-Linux系统中将普通用户权限提升至root权限](https://blog.csdn.net/weixin_45178128/article/details/103155720)

```
chmod u+w /etc/sudoers && echo "testuser       ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers \
chmod u-w /etc/sudoers
```


> 2. 引用自 [csdn-Linux新增ssh登录用户并加入sudo组](https://blog.csdn.net/xiunai78/article/details/84578529)

```
# 全部保存成脚本操作
useradd testuser
mkdir -p /home/testuser/.ssh
echo xxxxxxxxx  > /home/testuser/.ssh/authorized_keys
chmod u+w /etc/sudoers
echo "testuser       ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
chmod u-w /etc/sudoers
groupadd wheel
usermod -G wheel testuser
echo auth       required   pam_wheel.so group=wheel >> /etc/pam.d/su
echo auth       sufficient pam_wheel.so trust use_uid >> /etc/pam.d/su
```

其他参考：[cnblogs-linux下查看所有用户及所有用户组](https://www.cnblogs.com/pengyunjing/p/8543026.html)、[csdn-Linux用户和组管理](https://blog.csdn.net/weixin_43770382/article/details/112755626)

### 特权提升方式与密码破解

#### 特权提升

参考：[详细|Linux提权总结](https://blog.csdn.net/st3pby/article/details/127718846)、[腾讯新闻-Linux特权提升技术合集](https://view.inews.qq.com/k/20211015A001PB00?web_channel=wap&openApp=false)

#### 密码破解

[cnblogs-【THM】John The Ripper(hash破解工具)-学习](https://www.cnblogs.com/Hekeats-L/archive/2022/09/30/16745318.html)
