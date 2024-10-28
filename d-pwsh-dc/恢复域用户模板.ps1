# 张三没有删除前 Deleted 后面是空值，同时也可查出一些同名的被删除。
Get-ADObject -Filter {samaccountname -eq " 张三"} -IncludeDeletedObjects

# 通过GUID恢复
Restore-ADObject -Identity fc9ef534-e4b4-4bda-b894-4e91797d233e"" -NewName "张三" -TargetPath "OU=生产团队,DC=CSYLQ,DC=COM"


# 重新设置密码
Set-ADAccountPassword -Identity "张三" -NewPassword (ConvertTo-SecureString -AsPlainText "Mima123" -Force)

# 解锁账户
Enable-ADAccount -Identity "张三"