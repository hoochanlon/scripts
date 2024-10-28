# 导入Active Directory模块
Import-Module ActiveDirectory

# 读取txt文件中的用户列表
$filePath = "C:\Users\Administrator\Desktop\删除用户.txt"  # 替换为实际的文件路径
$userList = Get-Content -Path $filePath # -Encoding UTF8

# 循环删除用户
foreach ($user in $userList) {
    try {
        Remove-ADUser -Identity $user -Confirm:$false -ErrorAction Stop
        Write-Host "已删除用户: $user"
    } catch {
        Write-Host "用户 $user 不存在，已忽略错误。"
    }
}

# 暂停脚本
Read-Host "按 Enter 键继续..."


