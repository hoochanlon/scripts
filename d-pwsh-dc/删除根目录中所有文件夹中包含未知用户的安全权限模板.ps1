# 定义根文件夹路径
$folderPath = "C:\共享文件夹"  # 替换为实际路径

# 递归遍历指定文件夹及其子文件夹
Get-ChildItem -Path $folderPath -Recurse | ForEach-Object {
    # 获取当前文件或文件夹的 ACL
    $acl = Get-Acl -Path $_.FullName

    # 查找所有未知用户（SID 格式且没有解析为用户名的账户）
    $unknownSIDs = $acl.Access | Where-Object { $_.IdentityReference -match "^S-1-" }

    # 删除每个未知用户的权限
    foreach ($rule in $unknownSIDs) {
        $acl.RemoveAccessRule($rule)
        Write-Output "已删除文件/文件夹 $($_.FullName) 中的未知用户权限: $($rule.IdentityReference.Value)"
    }

    # 将更改后的 ACL 应用到文件或文件夹
    Set-Acl -Path $_.FullName -AclObject $acl
}

Write-Output "已成功删除文件夹 $folderPath 中所有未知用户的安全权限"
