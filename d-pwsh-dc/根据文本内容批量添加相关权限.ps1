# 定义主目录路径
$baseFolderPath = "C:\共享文件夹"  # 基础路径
$userFile = "C:\Users\Administrator\Desktop\权限分配列表.txt"  # 替换为实际的 TXT 文件路径

# 读取用户文件的每一行
Get-Content $userFile | ForEach-Object {
    # 按空格分隔每一行的内容
    # $parts = $_ -split '\s+'
    $parts = $_ -split '[\s,\t、]+'  # 正则表达式包含空格、制表符、逗号和顿号
    if ($parts.Length -ge 8) {
        $username = $parts[0]
        $folder2 = $parts[5]  # 组文件夹
        $folder3 = $parts[6]  # 公共目录文件夹
        $permissionType = $parts[7]

        # 设置 NTFS 权限类型
        $ntfsPermission = if ($permissionType -like "*访问*") { 
            "(OI)(CI)(R)"  # 只读权限
        } elseif ($permissionType -like "*编辑*" -or $permissionType -like "*读写*" -or $permissionType -like "*保存*") { 
            "(OI)(CI)(M)"  # 修改权限
        } else { 
            "(OI)(CI)(R)"  # 默认读权限
        }

        # 设置共享权限类型
        $sharePermission = if ($permissionType -like "*访问*") { 
            "Read"  # 共享只读权限
        } elseif ($permissionType -like "*编辑*" -or $permissionType -like "*读写*" -or $permissionType -like "*保存*") { 
            "Change"  # 共享更改权限
        } else { 
            "Read"  # 默认共享只读权限
        }

        # 处理 folder2（组文件夹）路径，去掉“组”字
        $folder2WithoutGroup = if ($folder2 -like "*组") {
            $folder2 -replace "组$", ""  # 去掉“组”字（结尾）
        } else {
            $folder2  # 如果没有“组”字，保持原样
        }

        # 构建完整的文件夹路径
        $fullPath1 = Join-Path -Path $baseFolderPath -ChildPath $folder2  # 原始组文件夹路径
        $fullPath2 = Join-Path -Path $baseFolderPath -ChildPath $folder3  # 公共目录文件夹路径
        $fullPath3 = Join-Path -Path $baseFolderPath -ChildPath $folder2WithoutGroup  # 去掉“组”字后的文件夹路径

        # 为每个文件夹路径分配权限
        $folders = @($fullPath1, $fullPath2, $fullPath3)
        
        foreach ($folderPath in $folders) {
            # 检查文件夹路径是否存在
            if (-Not (Test-Path $folderPath)) {
                Write-Output "路径 $folderPath 不存在，跳过该路径。"
                continue
            }

            # 使用 icacls 设置 NTFS 权限
            icacls "$folderPath" /grant ${username}:$ntfsPermission /t
            Write-Host "已为用户 $username 在文件夹 $folderPath 分配 NTFS $ntfsPermission 权限。" -ForegroundColor Yellow
            
            # 检查共享是否存在
            $netShareName = (Get-Item $folderPath).Name  # 使用文件夹名称作为共享名称

            if (Get-SmbShare -Name $netShareName -ErrorAction SilentlyContinue) {
                # 如果共享存在，添加共享权限
                Grant-SmbShareAccess -Name $netShareName -AccountName "$username" -AccessRight $sharePermission -Force
                Write-Host "已为用户 $username 在共享 $netShareName 分配共享 $sharePermission 权限。" -ForegroundColor Yellow
            } else {
                Write-Output "共享 $netShareName 不存在，跳过共享权限分配。"
            }
        }
    }
    else {
        Write-Output "行格式不匹配，跳过：$_"
    }
}

Write-Output "所有用户权限已成功添加。"
