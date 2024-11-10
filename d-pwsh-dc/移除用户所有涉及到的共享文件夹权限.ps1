# 配置域名
$domain = "CSXZX" 
$userName = Read-Host "请输入目标用户名（用户名）"  # 输入用户名
$excludeShares = Read-Host "请输入排除的共享文件夹（用逗号或顿号分隔，不输入则默认移除所有共享文件夹）"

# 默认排除的共享文件夹
$defaultExcludeShares = @("ADMIN$", "C$", "IPC$", "NETLOGON", "SYSVOL")

# 构造完整的用户名
$userName = "$domain\$userName"

# 获取所有共享文件夹
$shares = Get-SmbShare

# 过滤需要排除的共享文件夹
if ($excludeShares) {
    $excludeSharesList = ($excludeShares -replace "、", ",").Split(",")
    $excludeSharesList += $defaultExcludeShares  # 合并默认排除共享文件夹
    $shares = $shares | Where-Object { $excludeSharesList -notcontains $_.Name }
} else {
    # 如果没有输入排除的共享文件夹，则使用默认排除列表
    $shares = $shares | Where-Object { $defaultExcludeShares -notcontains $_.Name }
}

# 遍历所有共享文件夹，移除用户权限
foreach ($share in $shares) {
    # 检查用户是否有共享权限
    $access = Get-SmbShareAccess -Name $share.Name | Where-Object { $_.AccountName -eq $userName }
    if ($access) {
        # 移除共享权限
        Revoke-SmbShareAccess -Name $share.Name -AccountName $userName -Force
        Write-Host -ForegroundColor Green "已移除 $userName 在共享文件夹 '$($share.Name)' 的共享权限"
    } else {
        Write-Host "$userName 在共享文件夹 '$($share.Name)' 中没有共享权限，无需移除"
    }

    # 获取文件夹路径并移除 NTFS 权限
    $folderPath = $share.Path
    $acl = Get-Acl -Path $folderPath
    $userAccess = $acl.Access | Where-Object { $_.IdentityReference -eq $userName }
    
    if ($userAccess) {
        # 移除用户的 NTFS 权限
        $userAccess | ForEach-Object {
            $acl.RemoveAccessRule($_)
        }
        Set-Acl -Path $folderPath -AclObject $acl
        Write-Host -ForegroundColor Green "已移除 $userName 在 '$folderPath' 的 NTFS 权限"
    } else {
        Write-Host "$userName 在 '$folderPath' 中没有 NTFS 权限，无需移除"
    }
}

Write-Host "权限移除完毕"
