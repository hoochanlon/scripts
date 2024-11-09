Write-Host "授权组员访问组长文件夹权限"

# 定义文件路径
$membersFile = "C:\Users\administrator\Desktop\授权名单.txt"   # 存放组员名字的文件，每行一个
$foldersFile = "C:\Users\administrator\Desktop\权限模板.txt"   # 存放文件夹描述的文件，每行一个

# 读取文件内容
$members = Get-Content -Path $membersFile | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }
$folderEntries = Get-Content -Path $foldersFile | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }

# 获取组员数量和文件夹数量
$memberCount = $members.Count
$folderCount = $folderEntries.Count

# 确保组员和文件夹数量相同
if ($memberCount -ne $folderCount) {
    Write-Host "组员数量 ($memberCount) 和文件夹数量 ($folderCount) 不匹配，无法继续。"
    exit
}

# 遍历每个文件夹，为对应的组员赋予读取访问权限
for ($i = 0; $i -lt $memberCount; $i++) {
    $member = $members[$i]
    $folderEntry = $folderEntries[$i]

    # 提取文件夹名称并忽略描述部分
    $folderName = ($folderEntry -split "[,、]")[0].Trim()

    # 去除“组”字后缀以实现模糊匹配
    $normalizedFolderName = $folderName -replace "组$", ""
    
    # 定义共享文件夹路径，并尝试匹配
    $folderPathWithGroup = "C:\共享文件夹\" + $folderName  # 带“组”字的路径
    $folderPathWithoutGroup = "C:\共享文件夹\" + $normalizedFolderName  # 去掉“组”字的路径
    
    # 检查文件夹路径是否存在，以决定使用带“组”或不带“组”的文件夹路径
    if (Test-Path $folderPathWithGroup) {
        $folderPath = $folderPathWithGroup
        $shareName = $folderName
    } elseif (Test-Path $folderPathWithoutGroup) {
        $folderPath = $folderPathWithoutGroup
        $shareName = $normalizedFolderName
    } else {
        Write-Host "文件夹 $folderName 或 $normalizedFolderName 不存在，跳过此项。"
        continue
    }

    # 统一分配读取权限
    $smbAccessRight = "Read"
    $fileSystemRight = "(OI)(CI)R"  # 读取权限

    # 添加SMB共享权限
    Grant-SmbShareAccess -Name $shareName -AccountName $member -AccessRight "${smbAccessRight}" -Force
    Write-Host "已为 $member 添加 $shareName 共享的读取权限"

    # 添加文件系统访问权限
    icacls "$folderPath" /grant "${member}:${fileSystemRight}"
    Write-Host "已为 $member 添加 $folderPath 文件夹的读取权限"
}

<# 质检TO项目公共目录 #>
Write-Host "质检文件夹批量授权"

# 定义共享名称和文件夹路径
$shareName = "质检"  # 共享名称
$folderPath = "C:\共享文件夹\质检"  # 共享文件夹的实际路径
$domainUsersFile = "C:\Users\administrator\Desktop\授权名单.txt"  # 包含用户的txt文件路径（不带域名）

# 定义域名
$domain = "CSXZX"

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
