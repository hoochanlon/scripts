# 共享文件夹路径（请修改为你的实际共享文件夹路径）
$SharePath = "C:\共享文件夹"

# 确保已安装 SMB 共享管理模块
Import-Module SmbShare -ErrorAction SilentlyContinue

# 获取共享名称
$ShareName = (Get-SmbShare | Where-Object Path -eq $SharePath).Name

if (-not $ShareName) {
    Write-Host "未找到共享文件夹: $SharePath"
    exit 1
}

# 获取共享权限
$Permissions = Get-SmbShareAccess -Name $ShareName

# 遍历权限并修改 Change 为 Read
foreach ($Perm in $Permissions) {
    if ($Perm.AccessRight -eq "Change") {
        Write-Host "修改共享权限: $($Perm.AccountName) 更改 -> 只读"
        Revoke-SmbShareAccess -Name $ShareName -AccountName $Perm.AccountName -Force
        Grant-SmbShareAccess -Name $ShareName -AccountName $Perm.AccountName -AccessRight Read -Force
    }
}

# 获取安全权限（NTFS 权限）
$Acl = Get-Acl -Path $SharePath
$Modified = $false

foreach ($Entry in $Acl.Access) {
    $UserIdentity = $Entry.IdentityReference

    # 跳过 NT AUTHORITY、BUILTIN 和 CREATOR OWNER
    if ($UserIdentity -match "NT AUTHORITY|BUILTIN|CREATOR OWNER") {
        Write-Host "跳过特殊账户: $UserIdentity"
        continue
    }

    # 尝试解析用户或组名
    try {
        $User = $UserIdentity.Translate([System.Security.Principal.NTAccount])
    } catch {
        Write-Host "跳过无法解析的 SID: $UserIdentity"
        continue
    }

    # 如果权限包含 Modify，则改为 Read
    if ($Entry.FileSystemRights -match "Modify") {
        Write-Host "修改 NTFS 安全权限: $UserIdentity -> 仅保留读取权限"
        
        # 只保留 "Read" 权限
        $NewRule = New-Object System.Security.AccessControl.FileSystemAccessRule($User, "Read", "ContainerInherit,ObjectInherit", "None", "Allow")

        # 先移除旧的 Modify 权限，防止权限叠加
        $OldRule = New-Object System.Security.AccessControl.FileSystemAccessRule($User, "Modify", "ContainerInherit,ObjectInherit", "None", "Allow")
        
        # 只有在解析成功的情况下，才执行删除和添加规则
        try {
            $Acl.RemoveAccessRuleSpecific($OldRule)
            $Acl.AddAccessRule($NewRule)
            $Modified = $true
        } catch {
            Write-Host "修改权限时发生错误: $_"
        }
    }
}

# 如果修改了 ACL，则应用更改
if ($Modified) {
    try {
        Set-Acl -Path $SharePath -AclObject $Acl
        Write-Host "NTFS 权限修改完成，仅保留读取权限"
    } catch {
        Write-Host "Set-Acl 失败: $_"
    }
} else {
    Write-Host "未发现需要修改的 NTFS 权限"
}

Write-Host "权限更新完成"
