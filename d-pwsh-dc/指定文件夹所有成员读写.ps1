# 共享文件夹路径（直接在此修改）
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

# 遍历权限并修改 Read 为 Change
foreach ($Perm in $Permissions) {
    if ($Perm.AccessRight -eq "Read") {
        Write-Host "修改共享权限: $($Perm.AccountName) 读取 -> 更改"
        Revoke-SmbShareAccess -Name $ShareName -AccountName $Perm.AccountName -Force
        Grant-SmbShareAccess -Name $ShareName -AccountName $Perm.AccountName -AccessRight Change -Force
    }
}

# 获取安全权限（NTFS 权限）
$Acl = Get-Acl -Path $SharePath
$Modified = $false

foreach ($Entry in $Acl.Access) {
    $UserIdentity = $Entry.IdentityReference

    # 跳过 NT AUTHORITY、BUILTIN、CREATOR OWNER 以及 APPLICATION PACKAGE AUTHORITY
    if ($UserIdentity -match "NT AUTHORITY|BUILTIN|CREATOR OWNER|APPLICATION PACKAGE AUTHORITY") {
        Write-Host "跳过特殊账户: $UserIdentity"
        continue
    }

    # 解析 NTAccount，失败则跳过
    try {
        $User = $UserIdentity.Translate([System.Security.Principal.NTAccount])
    } catch {
        Write-Host "跳过无法解析的用户: $UserIdentity"
        continue
    }

    # 仅修改 Read 权限，设置为 Modify
    if ($Entry.FileSystemRights -match "Read" -and $Entry.FileSystemRights -notmatch "Modify") {
        Write-Host "修改 NTFS 安全权限: $User -> 修改"

        # 创建新的 Modify 权限
        $NewRule = New-Object System.Security.AccessControl.FileSystemAccessRule($User, "Modify", "ContainerInherit,ObjectInherit", "None", "Allow")

        # 先移除旧的 Read 权限
        $OldRule = New-Object System.Security.AccessControl.FileSystemAccessRule($User, "Read", "ContainerInherit,ObjectInherit", "None", "Allow")

        # 只对解析成功的用户进行修改
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
        Write-Host "NTFS 权限修改完成"
    } catch {
        Write-Host "Set-Acl 失败: $_"
    }
} else {
    Write-Host "未发现需要修改的 NTFS 读取权限"
}

Write-Host "权限更新完成"
