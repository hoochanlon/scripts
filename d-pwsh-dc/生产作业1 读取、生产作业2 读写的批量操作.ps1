# 定义域名
$domain = "CSXZX"

# 定义共享名称和文件夹路径
$shareName1 = "生产作业1"  # 共享名称
$folderPath1 = "C:\共享文件夹\生产作业1"  # 共享文件夹的实际路径

$shareName2 = "生产作业2"  # 共享名称
$folderPath2 = "C:\共享文件夹\生产作业2"  # 共享文件夹的实际路径

$domainUsersFile = "C:\Users\Administrator\Desktop\生产作业名单.txt"  # 包含用户的txt文件路径（不带域名）


# 读取txt文件，假设每行是一个用户名（不带域名）
$domainUsers = Get-Content -Path $domainUsersFile

foreach ($user in $domainUsers) {
    # 为每个用户加上域名前缀
    $fullUserName = "$domain\$user"

    Write-Host "正在为用户 $fullUserName 添加权限..."

    # 1. 添加共享权限
    try {
        Grant-SmbShareAccess -Name $shareName1 -AccountName $fullUserName -AccessRight Read -Force
        Write-Host "共享权限：用户 $fullUserName 已被授予  $shareName2 访问权限。"

        Grant-SmbShareAccess -Name $shareName2 -AccountName $fullUserName -AccessRight Change -Force
        Write-Host "共享权限：用户 $fullUserName 已被授予 $shareName2 读写权限。"

    } catch {
        Write-Host "共享权限：无法为用户 $fullUserName 添加访问权限，可能该用户已存在或发生其他错误。"
    }

    # 2. 添加NTFS权限（只读）
    try {
        $icaclsCommand1 = "icacls `"$folderPath1`" /grant `"${fullUserName}:(OI)(CI)R`" /t" # 显示权限
        $icaclsCommand2 = "icacls `"$folderPath2`" /grant `"${fullUserName}:(OI)(CI)M`" /t" # 显示权限
        # 将字符串转换为命令
        Invoke-Expression $icaclsCommand1
        Invoke-Expression $icaclsCommand2
        Write-Host "NTFS权限：用户 $fullUserName 已被授予 $folderPath1 只读访问权限。"
         Write-Host "NTFS权限：用户 $fullUserName 已被授予 $folderPath2 读写权限。"
    } catch {
        Write-Host "NTFS权限：无法为用户 $fullUserName 添加访问权限，可能发生错误。"
    }
}
