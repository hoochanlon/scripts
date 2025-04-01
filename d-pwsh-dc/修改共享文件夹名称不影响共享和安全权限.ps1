# 1. 设置变量
$oldFolderPath = "C:\共享文件夹\新共享文件夹"   # 原共享文件夹路径
$newFolderPath = "C:\共享文件夹\更名测试" # 新的共享文件夹路径
$shareName = "更名测试"                      # 共享名称


# 2. 备份 NTFS 权限
Write-Host "正在备份 NTFS 权限..."
$acl = Get-Acl $oldFolderPath


# 3. 重命名文件夹
Write-Host "正在重命名文件夹: $oldFolderPath -> $newFolderPath"
Rename-Item -Path $oldFolderPath -NewName (Split-Path -Leaf $newFolderPath) -Force


# 4. 恢复 NTFS 权限
Write-Host "正在恢复 NTFS 权限..."
Set-Acl -Path $newFolderPath -AclObject $acl

Write-Host "文件夹重命名及共享恢复完成！"

# 5. 新建共享
Write-Host "文件夹共享创建完成！"
New-SmbShare -Name $shareName -Path $newFolderPath -FullAccess Everyone -ErrorAction SilentlyContinue


# 6. NTFS权限转换共享权限
try {
    # 获取文件夹的 NTFS 安全权限
    $acl = Get-Acl -Path $newFolderPath

    # 禁用文件夹的权限继承，并将现有的继承权限转换为显式权限
    $acl.SetAccessRuleProtection($true, $false)
    Set-Acl -Path $newFolderPath -AclObject $acl
    Write-Output "已禁用权限继承并设置显式权限。"
} catch {
    Write-Output "获取文件夹权限或禁用继承时出错: $_"
    exit
}

# 建立有效的 NTFS 用户权限列表
$ntfsUsers = @{ }

foreach ($access in $acl.Access) {
    $user = $access.IdentityReference.Value
    $permissions = $access.FileSystemRights.ToString()

    if ($permissions.Contains("FullControl")) {
        $ntfsUsers[$user] = "Full"
    }
    elseif ($permissions.Contains("Modify")) {
        $ntfsUsers[$user] = "Change"
    }
    elseif ($permissions.Contains("ReadAndExecute") -or $permissions.Contains("Read")) {
        $ntfsUsers[$user] = "Read"
    }
    else {
        Write-Output "未匹配权限类型：$permissions，跳过用户 $user 的共享权限设置"
    }
}

# 定义例外列表，仅适用于 NTFS 权限（不加入共享权限）
$exceptionList = @(
    "CREATOR OWNER", 
    "SYSTEM", 
    "Users", 
    "Administrators", 
    "BUILTIN\Administrators", 
    "NT AUTHORITY\SYSTEM", 
    "NT AUTHORITY\Authenticated Users"
)

try {
    # 清除现有的共享权限，确保只为 NTFS 权限中非例外用户添加共享权限
    Get-SmbShareAccess -Name $shareName | ForEach-Object {
        Revoke-SmbShareAccess -Name $shareName -AccountName $_.AccountName -Force
    }
    Write-Output "已清除现有共享权限。"

    # 设置共享权限为 NTFS 权限中非例外用户的权限
    foreach ($user in $ntfsUsers.Keys) {
        if (-not $exceptionList.Contains($user)) {
            try {
                # 检查用户是否为SID格式（避免没有账户名的错误）
                if ($user -match "^S-\d-\d+-(\d+-){1,14}\d+$") {
                    Write-Output "跳过SID格式用户 $user 的共享权限设置。"
                } else {
                    Grant-SmbShareAccess -Name $shareName -AccountName $user -AccessRight $ntfsUsers[$user] -Force
                    Write-Output "已为用户 $user 设置共享权限：$ntfsUsers[$user]"
                }
            } catch {
                Write-Output "为用户 $user 设置共享权限时出错（账户名与安全标识无映射）: $_"
            }
        }
    }
} catch {
    Write-Output "清除共享权限时出错: $_"
}

try {
    # 移除非 NTFS 列表中的用户，并为例外用户添加自定义 NTFS 权限
    foreach ($access in $acl.Access) {
        $user = $access.IdentityReference.Value
        if (-not $ntfsUsers.ContainsKey($user) -and -not $exceptionList.Contains($user)) {
            $acl.RemoveAccessRule($access)
            Write-Output "已移除用户 $user 的NTFS权限"
        }
    }

    # 删除 Everyone 的共享和 NTFS 权限
    Revoke-SmbShareAccess -Name $shareName -AccountName "Everyone" -Force
    $acl.Access | Where-Object { $_.IdentityReference -eq "Everyone" } | ForEach-Object { $acl.RemoveAccessRule($_) }
    Write-Output "已删除 Everyone 的共享和 NTFS 权限。"

    # 添加例外列表中的系统账户权限
    $usersRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Users", "ReadAndExecute, ListDirectory, Read", "ContainerInherit, ObjectInherit", "None", "Allow")
    $adminsRule = New-Object System.Security.AccessControl.FileSystemAccessRule("BUILTIN\Administrators", "FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
    $systemRule = New-Object System.Security.AccessControl.FileSystemAccessRule("NT AUTHORITY\SYSTEM", "FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
    $creatorOwnerRule = New-Object System.Security.AccessControl.FileSystemAccessRule("CREATOR OWNER", "FullControl", "ContainerInherit, ObjectInherit", "InheritOnly", "Allow")

    # 将新的规则添加到 ACL 中
    $acl.AddAccessRule($usersRule)
    $acl.AddAccessRule($adminsRule)
    $acl.AddAccessRule($systemRule)
    $acl.AddAccessRule($creatorOwnerRule)

    # 将更改后的 ACL 应用到文件夹
    Set-Acl -Path $newFolderPath -AclObject $acl
    Write-Output "共享和 NTFS 权限设置已完成，保留了系统级用户，并已删除多余的成员。"
} catch {
    Write-Output "设置或更新 NTFS 权限时出错: $_"
}