@echo off

echo\
@REM 设置成共享打印机主机名
set printerHost=xx1688
echo  %printerHost%  测试连接中...

rem 使用ping命令检查打印机是否在线
ping -n 1 %printerHost% > nul
if %errorlevel% neq 0 (
    echo  不在线 %printerHost% 稍后试
    pause
    exit
)

@REM net stop spooler & net start spooler

echo\
echo 正在与 %printerHost% 共享打印主机建立连接
@REM 用户名abc 密码123456 /persistent:yes 永久保存
net use \\%printerHost% /user:abc 123456 /persistent:yes

echo\
echo 正在连接打印机，并安装驱动
@REM  /in 参数表示安装打印机驱动程序，/n 参数指定打印机名称，
@REM /z 参数表示将打印机设置为默认打印机，/q 参数表示安静模式执行
rundll32 printui.dll,PrintUIEntry /y /in /n "\\%printerHost%\HP LaserJet MFP M232-M237 PCLmS" /q

@REM color 0a
@REM timeout /t 30
@REM color
echo\
pause