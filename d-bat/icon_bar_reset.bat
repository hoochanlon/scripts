rem 关闭Windows外壳程序explorer
taskkill /f /im explorer.exe

rem 清理系统图标缓存数据库
attrib -h -s -r "%userprofile%\AppData\Local\IconCache.db"
del /f "%userprofile%\AppData\Local\IconCache.db"
attrib /s /d -h -s -r "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\*"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_16.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_32.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_48.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_96.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_256.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_768.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_1280.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_1920.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_2560.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_custom_stream.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_exif.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_idx.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_sr.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_wide.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_wide_alternate.db"

del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache_16.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache_32.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache_48.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache_96.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache_256.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache_768.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache_1280.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache_1920.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache_2560.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache_custom_stream.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache_exif.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache_idx.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache_sr.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache_wide.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache_wide_alternate.db"

rem 清理系统托盘记忆的图标
echo y|reg delete "HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v IconStreams
echo y|reg delete "HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v PastIconsStream

rem 重启 Windows 外壳程序 explorer
start explorer

@REM 参考
@REM https://bbs.pcbeta.com/viewthread-1971698-1-1.html
@REM https://www.cnblogs.com/it89/p/12008743.html 
@REM https://blog.csdn.net/luoyayun361/article/details/79228390 （thumbcache）
@REM https://www.sysgeek.cn/rebuild-icon-thumbnail-cache-windows-10/ （iconcache）