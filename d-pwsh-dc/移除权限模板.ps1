# 配置域名
$domain = "CSXZX"  

# 提示用户输入用户名和共享文件夹名称
$userName = Read-Host "请输入目标用户名（用户名）"  # 仅输入用户名
$shareName = Read-Host "请输入共享文件夹名称"  # 输入共享文件夹名称

# 构造完整的用户名
$userName = "$domain\$userName"

# 获取共享文件夹路径
$folderPath = (Get-SmbShare -Name $shareName).Path

# 移除 NTFS 权限
$acl = Get-Acl -Path $folderPath
$acl.Access | Where-Object { $_.IdentityReference -eq $userName } | ForEach-Object {
    $acl.RemoveAccessRule($_)
}
Set-Acl -Path $folderPath -AclObject $acl
Write-Host "已成功移除 $userName 的 NTFS 权限"

# 移除共享权限
Revoke-SmbShareAccess -Name $shareName -AccountName $userName -Force
Write-Host "已成功移除 $userName 的共享权限"
