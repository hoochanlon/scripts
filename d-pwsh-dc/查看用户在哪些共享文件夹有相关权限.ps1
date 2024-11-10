# 配置域名
$domain = "CSXZX"
$userName = Read-Host "请输入目标用户名（用户名）"  # 输入用户名
$userName = "$domain\$userName"  # 构造完整用户名

# 获取用户的共享权限
Write-Host "检查 $userName 的共享权限："
Get-SmbShare | ForEach-Object {
    $shareName = $_.Name
    $access = Get-SmbShareAccess -Name $shareName | Where-Object { $_.AccountName -eq $userName }
    if ($access) {
        $access | ForEach-Object {
            Write-Host "$userName 在共享文件夹 '$shareName' 中的权限：$($_.AccessControlType) $($_.AccessRight)"
        }
    }
}

# 获取用户的NTFS权限
Write-Host "`n检查 $userName 的 NTFS 权限："
Get-SmbShare | ForEach-Object {
    $folderPath = $_.Path
    if ($folderPath -and (Test-Path $folderPath)) {  # 检查路径是否为空且存在
        $acl = Get-Acl -Path $folderPath
        $userAccess = $acl.Access | Where-Object { $_.IdentityReference -eq $userName }
        if ($userAccess) {
            $userAccess | ForEach-Object {
                Write-Host "$userName 在 '$folderPath' 中的 NTFS 权限：$($_.AccessControlType) $($_.FileSystemRights)"
            }
        }
    }
}

Write-Host "`n检查完成。"
