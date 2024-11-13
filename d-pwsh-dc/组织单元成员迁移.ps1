# 定义目标 OU 路径
# $targetOU = "OU=wps下发,OU=常用软件下发,DC=CSXZX,DC=com"
$targetOU = "OU=质检,OU=生产团队,DC=CSXZX,DC=com"

# 读取用户名名单文件
$userListPath = "C:\Users\Administrator\Desktop\需开通WPS权限的质检人员.txt"
$userNames = Get-Content -Path $userListPath

# 遍历名单并移动用户
foreach ($userName in $userNames) {
    # 获取用户的完整 DistinguishedName
    $user = Get-ADUser -Filter {SamAccountName -eq $userName}
    
    if ($user) {
        # 移动用户到目标OU
        Move-ADObject -Identity $user.DistinguishedName -TargetPath $targetOU
        Write-Host "用户 $userName 已移动到 $targetOU"
    } else {
        Write-Host "未找到用户 $userName"
    }
}