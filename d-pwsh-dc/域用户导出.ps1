# 导出文件路径
$outputFile = "C:\Users\Administrator\Desktop\域用户清单.txt"

# 清空或创建导出文件
Out-File -FilePath $outputFile # -Encoding UTF8 -Force

# 导入 Active Directory 模块
Import-Module ActiveDirectory

# 设置组织单元的 DistinguishedName
$ous = @(
    "OU=生产团队,DC=CSXZX,DC=com",
    "OU=培训,DC=CSXZX,DC=com",
    "OU=临时保存权限,DC=CSXZX,DC=com"
)

foreach ($ou in $ous) {
    # 获取组织单元中的所有用户
    $users = Get-ADUser -Filter * -SearchBase $ou -Properties Name

    # 将用户名字写入文件
    if ($users) {
        $ouName = (Get-ADOrganizationalUnit -Identity $ou).Name  # 获取 OU 名称
        Add-Content -Path $outputFile -Value "组织单元：$ouName"
        foreach ($user in $users) {
            Add-Content -Path $outputFile -Value $user.Name  # 只保留用户名称
        }
        Add-Content -Path $outputFile -Value "`r`n"  # 添加换行分隔符
    } else {
        Write-Host "未找到任何用户在组织单元 $ouName 中。"
    }
}

Write-Host "已导出所有指定组织单元中的用户名字到 $outputFile"

# 暂停 5 秒
Start-Sleep -Seconds 5

