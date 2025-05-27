Write-Host "多文件夹批量添加权限脚本开始..." -ForegroundColor Cyan

# 定义域名前缀
$domain = "CSXZX"

# 用户名列表路径
$domainUsersFile = "C:\Users\Administrator\Desktop\人员名单.txt"

# 共享文件夹名列表路径（每行一个组名）
$shareConfigFile = "C:\Users\Administrator\Desktop\权限文件夹.txt"

# 根目录
$baseFolderPath = "C:\共享文件夹"

# 读取用户列表
$domainUsers = Get-Content -Path $domainUsersFile

# 读取共享名列表
$shareNames = Get-Content -Path $shareConfigFile

foreach ($shareName in $shareNames) {
    $shareName = $shareName.Trim()
    $folderPath = Join-Path $baseFolderPath $shareName

    Write-Host "`n开始处理共享 [$shareName]，路径 [$folderPath]..." -ForegroundColor Yellow

    foreach ($user in $domainUsers) {
        $fullUserName = "$domain\$user"
        Write-Host "→ 正在处理用户 $fullUserName ..."

        # 1. 添加 SMB 共享权限
        try {
            Grant-SmbShareAccess -Name $shareName -AccountName $fullUserName -AccessRight Change -Force
            Write-Host "共享权限已添加" -ForegroundColor Green
        } catch {
            Write-Host "无法添加共享权限，可能已存在或发生错误。" -ForegroundColor Red
        }

        # 2. 添加 NTFS 权限
        try {
            $icaclsCommand = "icacls `"$folderPath`" /grant `"${fullUserName}:(OI)(CI)M`" /t"
            Invoke-Expression $icaclsCommand
            Write-Host "NTFS权限已添加" -ForegroundColor Green
        } catch {
            Write-Host "无法添加NTFS权限。" -ForegroundColor Red
        }
    }
}

Write-Host "`n全部处理完成。" -ForegroundColor Cyan
