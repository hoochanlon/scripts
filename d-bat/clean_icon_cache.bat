@REM 关闭Windows外壳程序explorer
@REM 该命令会强制结束explorer.exe进程，关闭资源管理器及任务栏等
taskkill /f /im explorer.exe

@REM 清理系统图标缓存数据库
@REM 通过修改图标缓存数据库文件属性，确保可以删除它们
attrib -h -s -r "%userprofile%\AppData\Local\IconCache.db"
@REM 删除图标缓存数据库，强制删除图标缓存
del /f "%userprofile%\AppData\Local\IconCache.db"

@REM 清理Windows Explorer中的图标缓存文件
@REM 通过递归地修改Windows资源管理器的缓存文件的属性，使其可以被删除
@REM /s: 对当前目录以及所有子目录中的文件执行属性操作。
@REM /d: 递归地对所有子目录应用操作。
@REM -h: 取消隐藏属性，使文件或文件夹变为可见。
@REM -s: 取消系统属性，使文件或文件夹不再被视为系统文件。
@REM -r: 取消只读属性，使文件或文件夹可以被写入。
attrib /s /d -h -s -r "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\*"
@REM 删除不同尺寸的缩略图缓存文件（32x32, 96x96, 102x102等）
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_32.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_96.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_102.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_256.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_1024.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_idx.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_sr.db"

@REM 清理系统托盘记忆的图标
@REM 通过删除注册表中的IconStreams和PastIconsStream键来清理托盘图标的缓存
echo y|reg delete "HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v IconStreams
echo y|reg delete "HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v PastIconsStream

@REM 重启Windows外壳程序explorer
@REM 重新启动explorer.exe，恢复任务栏和资源管理器
start explorer
