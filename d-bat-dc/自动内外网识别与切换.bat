@echo off
cls

:: 定义接口名称
set interface="以太网"

:: 创建一个临时文件存储 netsh 输出
set temp_file=%temp%\dhcp_status_output.txt

:: 获取接口配置信息并保存到文件
netsh interface ip show config name=%interface% > "%temp_file%"

:: 初始化变量
set dhcp_status=

:: 逐行读取文件，查找 "DHCP 已启用"
for /f "tokens=2 delims=:" %%a in ('findstr /c:"DHCP 已启用" "%temp_file%"') do (
    set dhcp_status=%%a
)

:: 清理前导空格
for /f "tokens=* delims= " %%b in ("%dhcp_status%") do set dhcp_status=%%b

:: 显示结果，检查 DHCP 状态
echo 当前 DHCP 状态: "%dhcp_status%"


:: 判断当前模式并执行切换
if /i "%dhcp_status%"=="是" (
    echo 检测到当前为 DHCP 模式，正在切换到静态 IP...
    netsh interface ip set address name=%interface% source=static addr=172.16.1.55 mask=255.255.255.0 gateway=172.16.1.254 >nul 2>nul
    netsh interface ip set dnsservers %interface% static 172.16.1.6 validate=no >nul 2>nul
    echo 已切换到静态 IP 配置。
) else (
    echo 检测到当前为静态 IP 模式，正在切换到 DHCP...
    netsh interface ip set address name=%interface% source=dhcp >nul 2>nul
    @REM netsh interface ip set dnsservers %interface% dhcp >nul 2>nul
    netsh interface ip set dnsservers %interface% static 192.168.1.250 primary >nul 2>nul
    netsh interface ip add dnsservers %interface% 114.114.114.114 index=2 >nul 2>nul
    echo 已切换到 DHCP 配置。
)


:: 删除临时文件
del "%temp_file%"

@REM pause
:: 等待 3 秒后退出
@REM timeout /t 3 /nobreak >nul