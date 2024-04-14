@echo off

REM 提示用户输入新路径
set /p newPath=请输入要添加的新路径：

REM 获取桌面路径
set "desktopPath=%userprofile%\Desktop"

REM 备份当前用户的 PATH 环境变量到桌面的文本文件
powershell -Command "[Environment]::GetEnvironmentVariable('PATH', 'User')" > "%desktopPath%\user_path_backup.txt"

REM 如果新路径不存在于当前用户的 PATH 环境变量中，则添加新路径
powershell -Command "$currentUserPath = [Environment]::GetEnvironmentVariable('PATH', 'User'); if ($currentUserPath -notlike '*%newPath%*') { $currentUserPath += ';%newPath%'; [Environment]::SetEnvironmentVariable('PATH', $currentUserPath, [System.EnvironmentVariableTarget]::User) }"

REM 备份计算机的 PATH 环境变量到桌面的文本文件
powershell -Command "[Environment]::GetEnvironmentVariable('PATH', 'Machine')" > "%desktopPath%\system_path_backup.txt"

REM 如果新路径不存在于计算机的 PATH 环境变量中，则添加新路径
powershell -Command "$systemPath = [Environment]::GetEnvironmentVariable('PATH', 'Machine'); if ($systemPath -notlike '*%newPath%*') { $systemPath += ';%newPath%'; [Environment]::SetEnvironmentVariable('PATH', $systemPath, [System.EnvironmentVariableTarget]::Machine) }"

REM 提示修改完成
echo 环境变量已修改
echo 用户变量备份在桌面的 user_path_backup.txt 文件中
echo 系统变量备份在桌面的 system_path_backup.txt 文件中
echo.

REM 显示修改后的 PATH 环境变量
echo 修改后的计算机 PATH 环境变量：
powershell -Command "[Environment]::GetEnvironmentVariable('PATH', 'Machine')"

echo.

echo 修改后的用户 PATH 环境变量：
powershell -Command "[Environment]::GetEnvironmentVariable('PATH', 'User')"
pause