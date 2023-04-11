@echo off

:: ----------------- 检测环境变量 ------------

@REM 设置环境变量
if not defined %WiFi% > nul (setx WiFi "%userprofile%\show_wifi.bat")

:: ----------------- 获取当前WiFi与密码 ---------------------

@REM 排除BSSID（基本服务集标识符）信息，有干扰到正常SSID输出。
setlocal enabledelayedexpansion
for /f "tokens=2 delims=:" %%i in ('netsh wlan show interfaces ^| findstr "SSID" ^| findstr /v "BSSID"') do (
    set now_wifi_ssid=%%i
    @REM 替换空格
    set now_wifi_ssid=!now_wifi_ssid: =!
)

for /f "tokens=2 delims=: " %%i in ('netsh wlan show profile name^="%now_wifi_ssid%" key^=clear ^| findstr "关键内容"') do (
    set "now_wifi_password=%%i"
    set now_wifi_password=!now_wifi_password!
)

echo WiFi：%now_wifi_ssid%
echo WiFi密码：%now_wifi_password%

:: ----------------- 二维码 ---------------------------------

@REM 二维码基本上是照片打开，Windows终端(旧版)字符支持受限，效果不理想
@REM Windows11以上自带的新版终端可行！
@REM https://github.com/microsoft/terminal

pip install qrcode > nul 2>&1
pip install pillow > nul 2>&1
pip install qrcode-terminal > nul 2>&1
set data= WiFi：%now_wifi_ssid% WiFi密码：%now_wifi_password%
python -c "import qrcode_terminal; qrcode_terminal.draw('%data%')"

::------------ 移动文件至用户家目录 ---------------

@REM 批处理判断文件%userprofile%\show_wifi.bat是否存在
if not exist "c:\%userprofile%\show_wifi.bat" > nul (
    move "%~dp0\%~nx0" "%userprofile%\%~nx0"
)

:: --------------- 参考部分 ----------------------------------

@REM @REM 参考文档及资料 一

@REM @REM "tokens=2 delims=:" 参数只能在 for 命令中使用，tokens=2 ，“:” 之后的第二文本
@REM @REM  "%now_ssid: =%" 将所有空格置 nul
@REM netsh wlan show profile /? 帮助文档
@REM netsh wlan show profile name="GIADA-GNXS" key=clear

@REM @REM [csdn -for /f命令之—Delims和Tokens用法&总结](https://blog.csdn.net/kagurawill/article/details/114982328)
@REM @REM [cnblogs -【No0000A4】DOS命令（cmd）批处理：替换字符串、截取字符串、扩充字符串、获取字符串长度](https://www.cnblogs.com/Chary/p/5825189.html)

@REM @REM 参考文档及资料 二

@REM WiFi名称输出的不是理想的结果 00，第一次取值正常，第二次成了00
@REM 找到方案为：开启延迟变量，脚本之家例子不错，说了那么多，其实就是以实时变量相对，条与行的概念也十分重要
@REM https://www.jb51.net/article/193245.htm

:: --------------- 参考部分 ----------------------------------


