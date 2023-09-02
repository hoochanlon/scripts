@%1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
@cd /d "%~dp0"
@echo off
@REM 永久添加静态路由
@route add 192.168.0.0 mask 255.255.255.0 192.168.3.11 -p
@pause
@REM  删除路由
@REM route delete 192.168.0.0
