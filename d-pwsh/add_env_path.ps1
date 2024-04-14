# 接受用户输入的新路径
$newPath = Read-Host "请输入要添加的新路径"

# 获取桌面路径
$desktopPath = [Environment]::GetFolderPath("Desktop")

# 备份当前用户的 PATH 环境变量到桌面的文本文件
$currentUserPath = [Environment]::GetEnvironmentVariable("PATH", "User")
$currentUserPath | Out-File -FilePath "$desktopPath\user_path_backup.txt"

# 如果新路径不存在于当前用户的 PATH 环境变量中，则添加新路径
if ($currentUserPath -notlike "*$newPath*") {
    $currentUserPath += ";$newPath"
    [Environment]::SetEnvironmentVariable("PATH", $currentUserPath, [System.EnvironmentVariableTarget]::User)
}

# 备份计算机的 PATH 环境变量到桌面的文本文件
$systemPath = [Environment]::GetEnvironmentVariable("PATH", "Machine")
$systemPath | Out-File -FilePath "$desktopPath\system_path_backup.txt"

# 如果新路径不存在于计算机的 PATH 环境变量中，则添加新路径
if ($systemPath -notlike "*$newPath*") {
    $systemPath += ";$newPath"
    [Environment]::SetEnvironmentVariable("PATH", $systemPath, [System.EnvironmentVariableTarget]::Machine)
}

# 提示修改完成
Write-Host "环境变量已修改"
Write-Host  "用户变量备份在桌面的 user_path_backup.txt 文件中"
Write-Host  "系统变量备份在桌面的 system_path_backup.txt 文件中"

Write-Host `n;

# 显示修改后的 PATH 环境变量
Write-Host "修改后的计算机 PATH 环境变量：" 
[Environment]::GetEnvironmentVariable("PATH", "Machine")

Write-Host `n;

Write-Host "修改后的用户 PATH 环境变量：" 
[Environment]::GetEnvironmentVariable("PATH", "User")


# ------------------------ batch ---------------------------------

# @echo off

# REM 提示用户输入新路径
# set /p newPath=请输入要添加的新路径：

# REM 获取桌面路径
# set "desktopPath=%userprofile%\Desktop"

# REM 备份当前用户的 PATH 环境变量到桌面的文本文件
# powershell -Command "[Environment]::GetEnvironmentVariable('PATH', 'User')" > "%desktopPath%\user_path_backup.txt"

# REM 如果新路径不存在于当前用户的 PATH 环境变量中，则添加新路径
# powershell -Command "$currentUserPath = [Environment]::GetEnvironmentVariable('PATH', 'User'); if ($currentUserPath -notlike '*%newPath%*') { $currentUserPath += ';%newPath%'; [Environment]::SetEnvironmentVariable('PATH', $currentUserPath, [System.EnvironmentVariableTarget]::User) }"

# REM 备份计算机的 PATH 环境变量到桌面的文本文件
# powershell -Command "[Environment]::GetEnvironmentVariable('PATH', 'Machine')" > "%desktopPath%\system_path_backup.txt"

# REM 如果新路径不存在于计算机的 PATH 环境变量中，则添加新路径
# powershell -Command "$systemPath = [Environment]::GetEnvironmentVariable('PATH', 'Machine'); if ($systemPath -notlike '*%newPath%*') { $systemPath += ';%newPath%'; [Environment]::SetEnvironmentVariable('PATH', $systemPath, [System.EnvironmentVariableTarget]::Machine) }"

# REM 提示修改完成
# echo 环境变量已修改

# echo.

# REM 显示修改后的 PATH 环境变量
# echo 修改后的计算机 PATH 环境变量：
# powershell -Command "[Environment]::GetEnvironmentVariable('PATH', 'Machine')"

# echo.

# echo 修改后的用户 PATH 环境变量：
# powershell -Command "[Environment]::GetEnvironmentVariable('PATH', 'User')"
# pause

# ------------------------ batch ---------------------------------