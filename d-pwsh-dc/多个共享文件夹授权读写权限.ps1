# 定义共享名称和文件夹路径
$shares = @(
    # 定义了一个包含两个共享的数组 $shares。在循环中，我们为每个用户和每个共享依次添加权限。
    # 这样，用户将同时获得对“生产作业1”和“生产作业2”两个文件夹的访问权限。
    @{ Name = "生产作业1"; Path = "C:\共享文件夹\生产作业1" },
    @{ Name = "生产作业2"; Path = "C:\共享文件夹\生产作业2" }
)

$domainUsersFile = "C:\Users\Administrator\Desktop\生产作业名单.txt"  # 包含用户的txt文件路径（不带域名）

# 定义域名
$domain = "CSYLQ"

# 读取txt文件，假设每行是一个用户名（不带域名）
$domainUsers = Get-Content -Path $domainUsersFile

foreach ($user in $domainUsers) {
    # 为每个用户加上域名前缀
    $fullUserName = "$domain\$user"

    foreach ($share in $shares) {
        Write-Host "正在为用户 $fullUserName 添加权限到共享 $($share.Name)..."

        # 1. 添加共享权限（只读）
        try {
            Grant-SmbShareAccess -Name $share.Name -AccountName $fullUserName -AccessRight Change -Force
            Write-Host "共享权限：用户 $fullUserName 已被授予 $($share.Name) 的只读访问权限。"
        } catch {
            Write-Host "共享权限：无法为用户 $fullUserName 添加访问权限到 $($share.Name)，可能该用户已存在或发生其他错误。"
        }

        # 2. 添加NTFS权限（只读）
        try {
            $icaclsCommand = "icacls `"$($share.Path)`" /grant `"${fullUserName}:(OI)(CI)(M)`" /t" # 显示权限
            # 将字符串转换为命令
            Invoke-Expression $icaclsCommand
            Write-Host "NTFS权限：用户 $fullUserName 已被授予 $($share.Name) 的只读访问权限。"
        } catch {
            Write-Host "NTFS权限：无法为用户 $fullUserName 添加访问权限到 $($share.Name)，可能发生错误。"
        }
    }
}

