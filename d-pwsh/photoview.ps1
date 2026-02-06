# 照片查看器修复工具 - PowerShell 版本
# 保存为 PhotoViewerFix.ps1

# 检查管理员权限
function Test-Administrator {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# 显示菜单
function Show-Menu {
    Clear-Host
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "       Windows 照片查看器修复工具" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "请选择：" -ForegroundColor White
    Write-Host ""
    Write-Host "  1. 设置旧照片应用（推荐）" -ForegroundColor Green
    Write-Host "  2. 设置win10以上版本默认照片应用" -ForegroundColor cyan
    Write-Host "  3. 检查当前状态" -ForegroundColor Gray
    Write-Host "  4. 恢复系统默认打印方式（删除sRGB）" -ForegroundColor Yellow
    Write-Host "  5. 设置Agfa状态（sRGB=RSWOP.icm）" -ForegroundColor Magenta
    Write-Host "  6. 退出" -ForegroundColor Red
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
}

# 方法一：完全修复
function Method1-FullFix {
    Clear-Host
    Write-Host "方法一：完全修复" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Cyan
    
    # 检查文件是否存在
    $photoViewerPath = "$env:ProgramFiles\Windows Photo Viewer\PhotoViewer.dll"
    if (-not (Test-Path $photoViewerPath)) {
        Write-Host "[错误] 未找到 PhotoViewer.dll" -ForegroundColor Red
        Write-Host "请从 Windows.old 或其他 Windows 系统复制此文件到："
        Write-Host $photoViewerPath
        Write-Host ""
        Read-Host "按回车键继续..."
        return
    }
    
    Write-Host "[1/7] 正在检查文件..." -ForegroundColor Yellow
    Write-Host "  PhotoViewer.dll 存在: $photoViewerPath" -ForegroundColor Green

    # 说明：Windows 10/11 对“默认应用”有 UserChoice Hash 保护，脚本无法可靠地强制设为默认。
    # 本工具会把“Windows 照片查看器”注册到“默认应用”列表，并尽量清理旧的用户选择，最终仍需在设置里手动确认一次。
    
    # 修复 HKCR 权限问题（使用 .NET 方法）
    Write-Host "[2/7] 正在修复注册表权限..." -ForegroundColor Yellow
    try {
        # 方法1：使用 .NET RegistryKey 类
        $regPath = "Applications\photoviewer.dll\shell\open\command"
        $registryKey = [Microsoft.Win32.Registry]::ClassesRoot.OpenSubKey($regPath, $true)
        if ($registryKey -eq $null) {
            $registryKey = [Microsoft.Win32.Registry]::ClassesRoot.CreateSubKey($regPath)
        }
        $registryKey.SetValue("", """$env:SystemRoot\System32\rundll32.exe"" ""$env:ProgramFiles\Windows Photo Viewer\PhotoViewer.dll"", ImageView_Fullscreen %1")
        $registryKey.Close()
        Write-Host "  HKCR 注册表项设置成功" -ForegroundColor Green
    }
    catch {
        Write-Host "  HKCR 权限不足，尝试用户级别修复..." -ForegroundColor Yellow
    }
    
    # 用户级别修复
    Write-Host "[3/7] 正在设置用户级别关联..." -ForegroundColor Yellow
    
    # 创建用户级别的照片查看器关联
    $userPhotoViewerPath = "HKCU:\Software\Classes\Applications\photoviewer.dll\shell\open\command"
    New-Item -Path $userPhotoViewerPath -Force | Out-Null
    Set-ItemProperty -Path $userPhotoViewerPath -Name "(default)" -Value """$env:SystemRoot\System32\rundll32.exe"" ""$env:ProgramFiles\Windows Photo Viewer\PhotoViewer.dll"", ImageView_Fullscreen %1"
    
    # 创建文件类型定义
    $tiffPath = "HKCU:\Software\Classes\PhotoViewer.FileAssoc.Tiff"
    New-Item -Path $tiffPath -Force | Out-Null
    Set-ItemProperty -Path $tiffPath -Name "(default)" -Value "Windows 照片查看器"
    
    $tiffIconPath = "$tiffPath\DefaultIcon"
    New-Item -Path $tiffIconPath -Force | Out-Null
    Set-ItemProperty -Path $tiffIconPath -Name "(default)" -Value "$env:SystemRoot\System32\imageres.dll,-70"
    
    $tiffCommandPath = "$tiffPath\shell\open\command"
    New-Item -Path $tiffCommandPath -Force | Out-Null
    Set-ItemProperty -Path $tiffCommandPath -Name "(default)" -Value """$env:SystemRoot\System32\rundll32.exe"" ""$env:ProgramFiles\Windows Photo Viewer\PhotoViewer.dll"", ImageView_Fullscreen %1"
    
    Write-Host "  用户级别关联设置成功" -ForegroundColor Green

    # 注册到系统“默认应用”列表（让它出现在 设置 -> 默认应用 里）
    Write-Host "  正在注册到系统默认应用列表..." -ForegroundColor Yellow
    try {
        $regAppsPath = "HKLM:\SOFTWARE\RegisteredApplications"
        $capRoot = "HKLM:\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities"
        $capFileAssoc = "$capRoot\FileAssociations"

        New-Item -Path $capRoot -Force | Out-Null
        New-Item -Path $capFileAssoc -Force | Out-Null

        # 应用显示名
        New-ItemProperty -Path $capRoot -Name "ApplicationName" -Value "Windows 照片查看器" -PropertyType String -Force | Out-Null
        New-ItemProperty -Path $capRoot -Name "ApplicationDescription" -Value "Windows 照片查看器" -PropertyType String -Force | Out-Null

        # 关联能力：这些扩展名都指向 PhotoViewer.FileAssoc.Tiff（脚本前面已在 HKCU 创建）
        $capExts = @(".jpg", ".jpeg", ".png", ".bmp", ".gif", ".tif", ".tiff")
        foreach ($ext in $capExts) {
            New-ItemProperty -Path $capFileAssoc -Name $ext -Value "PhotoViewer.FileAssoc.Tiff" -PropertyType String -Force | Out-Null
        }

        # 注册应用能力路径
        New-ItemProperty -Path $regAppsPath -Name "Windows Photo Viewer" -Value "SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities" -PropertyType String -Force | Out-Null
        Write-Host "  系统默认应用注册成功" -ForegroundColor Green
    }
    catch {
        Write-Host "  系统默认应用注册失败（可能权限不足/策略限制）：$($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # 关联图片格式
    Write-Host "[4/7] 正在关联图片格式..." -ForegroundColor Yellow
    $imageFormats = @(".jpg", ".jpeg", ".png", ".bmp", ".gif", ".tif", ".tiff")
    
    foreach ($format in $imageFormats) {
        $formatPath = "HKCU:\Software\Classes\$format"
        New-Item -Path $formatPath -Force | Out-Null
        Set-ItemProperty -Path $formatPath -Name "(default)" -Value "PhotoViewer.FileAssoc.Tiff"
        
        # 设置内容类型
        $contentType = switch ($format) {
            ".jpg"  { "image/jpeg" }
            ".jpeg" { "image/jpeg" }
            ".png"  { "image/png" }
            ".bmp"  { "image/bmp" }
            ".gif"  { "image/gif" }
            ".tif"  { "image/tiff" }
            ".tiff" { "image/tiff" }
            default { $null }
        }
        if ($contentType) {
            Set-ItemProperty -Path $formatPath -Name "Content Type" -Value $contentType | Out-Null
        }
        
        # 添加到打开方式列表（只要键名存在即可，值设为空字符串防止 null 错误）
        $openWithPath = "$formatPath\OpenWithProgids"
        New-Item -Path $openWithPath -Force | Out-Null
        New-ItemProperty -Path $openWithPath -Name "PhotoViewer.FileAssoc.Tiff" -Value "" -PropertyType String -Force | Out-Null
    }
    Write-Host "  图片格式关联成功" -ForegroundColor Green
    
    # 清除用户选择
    Write-Host "[5/7] 正在清除用户默认选择..." -ForegroundColor Yellow
    $extensions = @(".jpg", ".jpeg", ".png", ".bmp", ".gif", ".tif", ".tiff")
    foreach ($ext in $extensions) {
        $userChoicePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\$ext\UserChoice"
        if (Test-Path $userChoicePath) {
            # 直接删除整个 UserChoice 键比只删 Progid 更有效（但 Windows 仍可能因 Hash 保护重新生成）
            Remove-Item -Path $userChoicePath -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
    Write-Host "  用户选择已清除" -ForegroundColor Green
    
    # 使用 cmd 命令设置关联
    Write-Host "[6/7] 正在使用系统命令设置关联..." -ForegroundColor Yellow
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c assoc .jpg=PhotoViewer.FileAssoc.Tiff" -Wait -WindowStyle Hidden
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c assoc .jpeg=PhotoViewer.FileAssoc.Tiff" -Wait -WindowStyle Hidden
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c assoc .png=PhotoViewer.FileAssoc.Tiff" -Wait -WindowStyle Hidden
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c ftype PhotoViewer.FileAssoc.Tiff=""%SystemRoot%\System32\rundll32.exe"" ""%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll"", ImageView_Fullscreen %%1" -Wait -WindowStyle Hidden
    Write-Host "  系统命令执行成功" -ForegroundColor Green
    
    # 重启资源管理器
    Write-Host "[7/7] 正在重启资源管理器..." -ForegroundColor Yellow
    Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    Start-Process "explorer.exe"
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "修复完成！" -ForegroundColor Green
    Write-Host ""
    Write-Host "现在请执行以下操作：" -ForegroundColor Yellow
    Write-Host "1. 打开 设置 -> 应用 -> 默认应用"
    Write-Host "2. 找到并点击当前的“照片查看器”默认项（可能显示为“照片”）"
    Write-Host "3. 选择“Windows 照片查看器”"
    Write-Host "4. 或者：右键任意图片 -> 打开方式 -> 选择其他应用 -> 勾选“始终使用此应用”"
    Write-Host ""
    Write-Host "如果没有看到'Windows 照片查看器'，请尝试："
    Write-Host "- 点击'更多应用'"
    Write-Host "- 滚动到底部，点击'在这台电脑上查找其他应用'"
    Write-Host "- 浏览到: C:\Windows\System32\rundll32.exe"
    Write-Host "- 命名为'Windows照片查看器'"
    Write-Host ""
    Write-Host "即将为你打开“默认应用”设置窗口，方便直接选择。" -ForegroundColor Yellow
    try {
        Start-Process "ms-settings:defaultapps" -ErrorAction Stop
    }
    catch {
        # 旧版控制面板备用入口
        Start-Process "control.exe" "/name Microsoft.DefaultPrograms" -ErrorAction SilentlyContinue
    }
    Write-Host ""
    Read-Host "按回车键返回主菜单..."
}



# 方法四：恢复默认照片应用
function Method4-RestoreDefault {
    Clear-Host
    Write-Host "方法四：恢复默认照片应用" -ForegroundColor Blue
    Write-Host "========================================" -ForegroundColor Cyan
    
    Write-Host "警告：这将恢复 Windows 10/11 的默认照片应用" -ForegroundColor Red
    Write-Host ""
    
    $confirm = Read-Host "确定要恢复默认设置吗？(Y/N)"
    if ($confirm -ne "Y" -and $confirm -ne "y") {
        return
    }
    
    Write-Host ""
    Write-Host "正在恢复默认设置..." -ForegroundColor Yellow
    
    # 清除用户关联
    $imageFormats = @(".jpg", ".jpeg", ".png", ".bmp", ".gif", ".tif", ".tiff")
    foreach ($format in $imageFormats) {
        $userChoicePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\$format\UserChoice"
        if (Test-Path $userChoicePath) {
            Remove-ItemProperty -Path $userChoicePath -Name "Progid" -ErrorAction SilentlyContinue
        }
        
        # 删除用户级别的关联
        $formatPath = "HKCU:\Software\Classes\$format"
        if (Test-Path $formatPath) {
            Remove-Item -Path $formatPath -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
    
    # 删除照片查看器关联
    $photoViewerPath = "HKCU:\Software\Classes\Applications\photoviewer.dll"
    if (Test-Path $photoViewerPath) {
        Remove-Item -Path $photoViewerPath -Recurse -Force -ErrorAction SilentlyContinue
    }
    
    $tiffPath = "HKCU:\Software\Classes\PhotoViewer.FileAssoc.Tiff"
    if (Test-Path $tiffPath) {
        Remove-Item -Path $tiffPath -Recurse -Force -ErrorAction SilentlyContinue
    }
    
    # 重置关联命令
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c assoc .jpg=jpegfile" -Wait -WindowStyle Hidden
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c assoc .png=pngfile" -Wait -WindowStyle Hidden

    Write-Host "即将为你打开“默认应用”设置窗口，方便直接选择。" -ForegroundColor Yellow
    try {
        Start-Process "ms-settings:defaultapps" -ErrorAction Stop
    }
    catch {
        # 旧版控制面板备用入口
        Start-Process "control.exe" "/name Microsoft.DefaultPrograms" -ErrorAction SilentlyContinue
    }
    Write-Host ""
    Read-Host "按回车键返回主菜单..."
}

# 检查当前状态
function Method5-CheckStatus {
    Clear-Host
    Write-Host "检查当前状态" -ForegroundColor Gray
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    
    # 检查文件
    Write-Host "1. 文件检查：" -ForegroundColor Yellow
    $photoViewerPath = "$env:ProgramFiles\Windows Photo Viewer\PhotoViewer.dll"
    if (Test-Path $photoViewerPath) {
        Write-Host "   [√] PhotoViewer.dll 存在" -ForegroundColor Green
    } else {
        Write-Host "   [×] PhotoViewer.dll 不存在" -ForegroundColor Red
    }
    
    # 检查注册表
    Write-Host ""
    Write-Host "2. 注册表检查：" -ForegroundColor Yellow
    
    # 检查用户级别关联
    $userPhotoViewerPath = "HKCU:\Software\Classes\Applications\photoviewer.dll"
    if (Test-Path $userPhotoViewerPath) {
        Write-Host "   [√] 用户级别照片查看器已注册" -ForegroundColor Green
    } else {
        Write-Host "   [×] 用户级别照片查看器未注册" -ForegroundColor Red
    }
    
    # 检查文件关联
    Write-Host ""
    Write-Host "3. 文件关联检查：" -ForegroundColor Yellow
    
    $testFormats = @(".jpg", ".png")
    foreach ($format in $testFormats) {
        $formatPath = "HKCU:\Software\Classes\$format"
        if (Test-Path $formatPath) {
            $value = Get-ItemProperty -Path $formatPath -Name "(default)" -ErrorAction SilentlyContinue
            if ($value."(default)" -eq "PhotoViewer.FileAssoc.Tiff") {
                Write-Host "   [√] $format 关联到照片查看器" -ForegroundColor Green
            } else {
                Write-Host "   [!] $format 关联到其他程序" -ForegroundColor Yellow
            }
        } else {
            Write-Host "   [ ] $format 无用户关联" -ForegroundColor Gray
        }
    }
    
    # 检查默认程序
    Write-Host ""
    Write-Host "4. 默认程序检查：" -ForegroundColor Yellow
    
    $userChoicePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpg\UserChoice"
    if (Test-Path $userChoicePath) {
        $progId = Get-ItemProperty -Path $userChoicePath -Name "Progid" -ErrorAction SilentlyContinue
        if ($progId) {
            Write-Host "   [!] .jpg 用户选择: $($progId.Progid)" -ForegroundColor Yellow
        }
    } else {
        Write-Host "   [√] .jpg 使用系统默认" -ForegroundColor Green
    }
    
    # 检查色彩模式
    Write-Host ""
    Write-Host "5. 色彩模式检查：" -ForegroundColor Yellow
    
    $regPath = "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ICM\RegisteredProfiles"
    if (-not (Test-Path $regPath)) {
        Write-Host "   [√] 使用系统默认色彩配置" -ForegroundColor Green
        Write-Host "   [说明] 可以正常打印" -ForegroundColor Gray
    } else {
        $sRGBValue = Get-ItemProperty -Path $regPath -Name "sRGB" -ErrorAction SilentlyContinue
        if ($sRGBValue) {
            if ($sRGBValue.sRGB -eq "RSWOP.icm") {
                Write-Host "   [√] Agfa模式已启用 (RSWOP.icm)" -ForegroundColor Magenta
                Write-Host "   [说明] 此模式下可以正常看图" -ForegroundColor Gray
            } else {
                Write-Host "   [!] sRGB设置为: $($sRGBValue.sRGB)" -ForegroundColor Yellow
            }
        } else {
            Write-Host "   [√] 使用系统默认色彩配置" -ForegroundColor Green
            Write-Host "   [说明] 可以正常打印" -ForegroundColor Gray
        }
    }
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Read-Host "按回车键返回主菜单..."
}

# 恢复系统默认打印方式（删除sRGB）
function Method6-RestorePrintDefault {
    Clear-Host
    Write-Host "恢复系统默认打印方式" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    
    $regPath = "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ICM\RegisteredProfiles"
    
    # 检查注册表路径是否存在
    if (-not (Test-Path $regPath)) {
        Write-Host "[警告] 注册表路径不存在，正在创建..." -ForegroundColor Yellow
        New-Item -Path $regPath -Force | Out-Null
    }
    
    # 检查sRGB项是否存在
    $sRGBValue = Get-ItemProperty -Path $regPath -Name "sRGB" -ErrorAction SilentlyContinue
    if ($sRGBValue) {
        Write-Host "当前sRGB值: $($sRGBValue.sRGB)" -ForegroundColor Gray
        Write-Host ""
        Write-Host "正在删除sRGB注册表项以恢复系统默认..." -ForegroundColor Yellow
        
        try {
            Remove-ItemProperty -Path $regPath -Name "sRGB" -Force -ErrorAction Stop
            Write-Host "[√] sRGB项已删除，已恢复系统默认打印方式" -ForegroundColor Green
        }
        catch {
            Write-Host "[×] 删除失败: $($_.Exception.Message)" -ForegroundColor Red
        }
    } else {
        Write-Host "[√] sRGB项不存在，已经是系统默认状态" -ForegroundColor Green
    }
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Read-Host "按回车键返回主菜单..."
}

# 设置Agfa状态（sRGB=RSWOP.icm）
function Method7-SetAgfaMode {
    Clear-Host
    Write-Host "设置Agfa状态（能够正常看图）" -ForegroundColor Magenta
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    
    $regPath = "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ICM\RegisteredProfiles"
    
    # 检查注册表路径是否存在
    if (-not (Test-Path $regPath)) {
        Write-Host "[信息] 注册表路径不存在，正在创建..." -ForegroundColor Yellow
        New-Item -Path $regPath -Force | Out-Null
    }
    
    # 检查当前值
    $currentValue = Get-ItemProperty -Path $regPath -Name "sRGB" -ErrorAction SilentlyContinue
    if ($currentValue) {
        Write-Host "当前sRGB值: $($currentValue.sRGB)" -ForegroundColor Gray
    } else {
        Write-Host "当前sRGB值: (未设置)" -ForegroundColor Gray
    }
    
    Write-Host ""
    Write-Host "正在设置sRGB为RSWOP.icm..." -ForegroundColor Yellow
    
    try {
        Set-ItemProperty -Path $regPath -Name "sRGB" -Value "RSWOP.icm" -Type String -Force
        Write-Host "[√] sRGB已设置为RSWOP.icm，Agfa状态下可以正常看图" -ForegroundColor Green
    }
    catch {
        Write-Host "[×] 设置失败: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Read-Host "按回车键返回主菜单..."
}

# 主程序
function Main {
    # 检查管理员权限
    if (-not (Test-Administrator)) {
        Write-Host "请以管理员身份运行此脚本！" -ForegroundColor Red
        Write-Host ""
        Write-Host "右键点击此文件，选择'以管理员身份运行'" -ForegroundColor Yellow
        Write-Host "或打开 PowerShell 管理员窗口后运行此脚本" -ForegroundColor Yellow
        Write-Host ""
        Read-Host "按回车键退出..."
        return
    }
    
    # 设置执行策略（临时）
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
    
    while ($true) {
        Show-Menu
        $choice = Read-Host "请输入选择 (1-6)"
        
        switch ($choice) {
            "1" { Method1-FullFix }
            "2" { Method4-RestoreDefault }
            "3" { Method5-CheckStatus }
            "4" { Method6-RestorePrintDefault }
            "5" { Method7-SetAgfaMode }
            "6" { 
                Write-Host "再见！" -ForegroundColor Green
                Start-Sleep -Seconds 1
                return 
            }
            default {
                Write-Host "无效选择，请重新输入！" -ForegroundColor Red
                Start-Sleep -Seconds 1
            }
        }
    }
}

# 运行主程序
Main