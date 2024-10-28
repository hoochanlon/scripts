# 定义共享名称
$shareName = "消费"  # 替换为实际共享名称

# 获取共享的访问权限
$accessRules = Get-SmbShareAccess -Name $shareName

# 筛选未知用户（匹配 AccountName 包含 SID 的条目）
$unknownSIDs = $accessRules | Where-Object { $_.AccountName -match "S-1-" }

# 遍历并删除每个未知用户的共享权限
foreach ($rule in $unknownSIDs) {
    $unknownSID = $rule.AccountName
    Write-Output "正在删除共享 '$shareName' 中的未知用户权限: $unknownSID"
    Revoke-SmbShareAccess -Name $shareName -AccountName $unknownSID -Force
}

Write-Output "已成功删除共享 '$shareName' 中所有未知用户的权限"
