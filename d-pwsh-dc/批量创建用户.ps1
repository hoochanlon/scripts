# 导入Active Directory模块
Import-Module ActiveDirectory

# 测试一行命令
# New-ADUser -Name "王光光" -SamAccountName "王光光" -UserPrincipalName "王光光@CSYLQ.com" `
#            -Path "OU=消费业务,OU=生产团队,DC=CSYLQ,DC=com" -GivenName "光光" -Surname "王" `
#            -AccountPassword (ConvertTo-SecureString "Mima12345" -AsPlainText -Force) `
#            -Enabled $true -ChangePasswordAtLogon $true

<# 参考资料：https://learn.microsoft.com/en-us/powershell/module/activedirectory/new-aduser?view=windowsserver2022-ps #>


# 导入Active Directory模块
Import-Module ActiveDirectory

# 读取txt文件中的用户列表
$filePath = "C:\Users\Administrator\Desktop\添加用户.txt"  # 替换为实际的文件路径
$userList = Get-Content -Path $filePath  # -Encoding UTF8

# 固定密码
$password = "Mima12345"

# 循环处理用户列表
foreach ($userName in $userList) {
    # 尝试创建用户
    try {
        New-ADUser -Name $userName -SamAccountName $userName -UserPrincipalName "$userName@csylq.com" `
                   -Path "OU=售后,OU=生产团队,DC=CSYLQ,DC=com" `
                   -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) `
                   -Enabled $true -ChangePasswordAtLogon $true

        Write-Host "用户 $userName 已成功创建。"
    } catch {
        Write-Host "创建用户 $userName 时发生错误: $_"
    }
}

# 暂停脚本
Read-Host "按 Enter 键继续..."
