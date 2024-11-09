# 读取用户输入
$userInput = Read-Host "请输入用户名（支持以空格、中文逗号、英文逗号、顿号分隔多个用户批量添加）"

# 定义域名
$domain = "CSXZX"

# 读取共享名称的关键字（支持模糊匹配）
$shareNameKeyword = Read-Host "请搜索共享文件名称（支持模糊匹配）"

# 查找所有共享文件夹并进行模糊匹配
$allShares = Get-SmbShare | Where-Object { $_.Name -like "*$shareNameKeyword*" }

if ($allShares.Count -eq 0) {
    Write-Host "没有找到匹配的共享名称。请检查关键字后再试。"
    Start-Sleep -Seconds 5
    exit
}

# 输出匹配到的共享文件夹名，并给出选择提示
Write-Host "匹配到以下共享文件夹，请选择一个共享文件夹进行权限设置："
$allShares | ForEach-Object { Write-Host "$($_.Name)" }

# 获取用户选择的共享文件夹
$shareNameSelection = Read-Host "请输入要选择的共享文件夹名称"

# 验证选择的共享文件夹是否在匹配结果中
$selectedShare = $allShares | Where-Object { $_.Name -eq $shareNameSelection }

if (-not $selectedShare) {
    Write-Host "无效的选择，退出脚本。"
    Start-Sleep -Seconds 5
    exit
}

# 读取权限设置
$permissionsInput = Read-Host "请输入权限设置（只读/读取、编辑/读写）"

# 将权限映射为对应的共享权限和NTFS权限
$sharePermission = ""
$ntfsPermission = ""

switch ($permissionsInput) {
    "只读" {
        $sharePermission = "(OI)(CI)(R)"
        $ntfsPermission = "Read"
        break
    }
    "读取" {
        $sharePermission = "(OI)(CI)(R)"
        $ntfsPermission = "Read"
        break
    }
    "编辑" {
        $sharePermission = "(OI)(CI)(M)"
        $ntfsPermission = "Change"
        break
    }
    "保存" {
        $sharePermission = "(OI)(CI)(M)"
        $ntfsPermission = "Change"
        break
    }
    "读写" {
        $sharePermission = "(OI)(CI)(M)"
        $ntfsPermission = "Change"
        break
    }
    default {
        Write-Host "无效的权限输入。"
        exit
    }
}

# 分割用户输入，支持空格、中文逗号、英文逗号、顿号作为分隔符
$usernames = $userInput -split '[ ,，、]'

# 循环为每个用户设置共享和安全权限
foreach ($username in $usernames) {
    # 去除首尾空格
    $username = $username.Trim()

    # 检查用户名是否为空
    if ($username) {
        # 共享权限设置
        Grant-SmbShareAccess -Name "$($selectedShare.Name)" -AccountName "$domain\$username" -AccessRight $ntfsPermission -Force

        # NTFS权限设置
        icacls "C:\共享文件夹\$($selectedShare.Name)" /grant "$domain\${username}:$sharePermission" /t

        Write-Host "已为用户 '$username' 设置权限：共享权限 '$sharePermission'，NTFS权限 '$ntfsPermission'，共享文件夹：$($selectedShare.Name)。"
    }
}

# 暂停5秒
Start-Sleep -Seconds 5

# 退出脚本
exit
