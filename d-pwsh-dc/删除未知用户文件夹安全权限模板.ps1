# 定义共享文件夹路径
$folderPath = "C:\共享文件夹\售后"

# 获取文件及文件夹的现有权限
$acl = Get-Acl -Path $folderPath

# 查找并删除所有未知用户（使用 SID 表示的权限）
$acl.Access | Where-Object { $_.IdentityReference -match "^S-1-" } | ForEach-Object {
    $acl.RemoveAccessRule($_)
}

# 应用更改后的 ACL
Set-Acl -Path $folderPath -AclObject $acl

Write-Output "已成功删除文件夹 $folderPath 中的未知用户权限"
