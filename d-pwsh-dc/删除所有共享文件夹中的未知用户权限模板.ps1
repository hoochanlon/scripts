# 获取所有共享
$shares = Get-SmbShare

# 遍历每个共享
foreach ($share in $shares) {
    $shareName = $share.Name
    Write-Output "正在处理共享文件夹: $shareName"
    
    # 获取当前共享的访问权限
    $accessRules = Get-SmbShareAccess -Name $shareName

    # 筛选未知用户（匹配 SID 格式的账户）
    $unknownSIDs = $accessRules | Where-Object { $_.AccountName -match "S-1-" }

    # 删除每个未知用户的共享权限
    foreach ($rule in $unknownSIDs) {
        $unknownSID = $rule.AccountName
        Write-Output "  删除共享 '$shareName' 中的未知用户权限: $unknownSID"
        Revoke-SmbShareAccess -Name $shareName -AccountName $unknownSID -Force
    }
}

Write-Output "已成功删除所有共享文件夹中的未知用户权限"
