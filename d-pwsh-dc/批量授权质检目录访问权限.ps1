# 定义共享名称和文件夹路径
$shareName = "质检"  # 共享名称
$folderPath = "C:\共享文件夹\质检"  # 共享文件夹的实际路径
$domainUsersFile = "C:\Users\Administrator\Desktop\质检名单.txt"  # 包含用户的txt文件路径（不带域名）

# 定义域名
$domain = "CSYLQ"

# 读取txt文件，假设每行是一个用户名（不带域名）
$domainUsers = Get-Content -Path $domainUsersFile

foreach ($user in $domainUsers) {
    # 为每个用户加上域名前缀
    $fullUserName = "$domain\$user"

    Write-Host "正在为用户 $fullUserName 添加权限..."

    # 1. 添加共享权限（只读）
    try {
        Grant-SmbShareAccess -Name $shareName -AccountName $fullUserName -AccessRight Read -Force
        Write-Host "共享权限：用户 $fullUserName 已被授予只读访问权限。"
    } catch {
        Write-Host "共享权限：无法为用户 $fullUserName 添加访问权限，可能该用户已存在或发生其他错误。"
    }

    # 2. 添加NTFS权限（只读）
    try {
        # 使用icacls命令授予用户只读权限
        # 显式 vs 继承权限：普通权限界面显示的是显式设置的权限，而“高级”选项中还会显示从父文件夹或其他权限继承而来的权限。
        # $icaclsCommand = "icacls `"$folderPath`" /grant `"${fullUserName}:(R)`" /t" # 隐示权限
        #(OI) 是“对象继承”，表示权限将应用到文件夹内的文件。
        #(CI) 是“容器继承”，表示权限将应用到文件夹内的子文件夹。
        $icaclsCommand = "icacls `"$folderPath`" /grant `"${fullUserName}:(OI)(CI)R`" /t" # 显示权限
        # 将字符串转换为命令
        Invoke-Expression $icaclsCommand
        Write-Host "NTFS权限：用户 $fullUserName 已被授予只读访问权限。"
    } catch {
        Write-Host "NTFS权限：无法为用户 $fullUserName 添加访问权限，可能发生错误。"
    }
}
