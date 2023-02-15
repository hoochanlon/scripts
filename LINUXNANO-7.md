# 安全策略

### ssh认证密钥后门

用`diff`、`colordiff`（需下载）比对文本，删除不认识的公钥。

```
vim ~/.ssh/authorized_keys
```

### 密码策略后门

`vi /etc/pam.d/system-auth`

```
# 失败3次封锁300秒 
auth required  pam_faillock.so preauth silent audit deny=3  unlock_time=300 even_deny_root
# 密码验证三次，忽略大小写特殊字符，最小长度1位密码
password requisite pam_pwquality.so try_first_pass local_users_only retry=3
password requisite pam_pwquality.so authtok_type= lcredit=0 ucredit=0 dcredit=0 ocredit=0  minlen=1
```

参考：

* [51cto-kdevtmpfsi挖矿病毒清除](https://blog.51cto.com/liuyj/5205391)
* [【实用】防暴力破解服务器ssh登入次数](https://cloud.tencent.com/developer/article/2142596)

### 绑定IP

bind ip

