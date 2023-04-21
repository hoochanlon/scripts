@echo off
set printerIP=192.168.0.252

echo 检查网络打印机 %printerIP% 是否在线...
ping -n 1 %printerIP% > nul
if %errorlevel% neq 0 (
    echo 不在线 %printerIP% 稍后试
    pause
    exit
)

rem 连接网络打印机 通用
@REM rundll32 printui.dll,PrintUIEntry /if /b ""  /r "IP_%printerIP%" /m "Generic / Text Only"

@REM 已安装惠普打印机驱动，特例测试
@REM rundll32 printui.dll,PrintUIEntry /if /b ""  /r "IP_%printerIP%" /m "HP Universal Printing PCL 6"


:: ---------------- 静默安装打印机驱动 -------------------------

@REM 详情见：各类“一键安装打印机”博文及帖子的观后感 https://www.52pojie.cn/thread-1776328-1-1.html

@REM 由于惠普打印机驱动不支持静默安装，所以使用备份还原方式拟态静默安装。两个步骤
@REM 1. 导出注册表 
@REM reg export "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Monitors\Standard TCP/IP Port\Ports\IP_192.168.0.252" "C:\Users\nice\Documents\IP_192.168.0.252.reg"
@REM 2. 使用dism，导出驱动，再利用服务器卸载失败的效果，去定位到具体打印机型号驱动
@REM dism /online /export-driver /destination:F:\backup\

@REM 静默模式导入注册表
regedit /s C:\Users\nice\Documents\IP_192.168.0.252.reg

@REM 保险稳妥的用法，不初始化一下也挺容易造成执行失败。
@REM 有时打印机删不掉一些文件也可以用这命令
net stop spooler
net start spooler

@REM rundll32：运行 Windows DLL 文件。
@REM printui.dll：Windows 的打印机用户界面组件 DLL 文件。
@REM PrintUIEntry：打印机用户界面入口点。
@REM /if：安装新的打印机。
@REM /b ""：设置打印机名称为空字符串，使其在安装后由用户进行命名。
@REM /f F:\backup\hpcu215u\hpcu215u.inf：指定打印机驱动程序包的位置和 .inf 文件名称。
@REM /r "IP_%printerIP%"：设置打印机端口为 IP 地址端口，并使用 %printerIP% 变量指定 IP 地址。这个变量需要在其他地方定义，通常是通过批处理脚本进行传递。
@REM /m "HP Universal Printing PCL 6"：指定要安装的打印机驱动程序的名称。

@REM 安装打印机
rundll32 printui.dll,PrintUIEntry /if /b "" /f F:\backup\hpcu215u\hpcu215u.inf /r "IP_%printerIP%" /m "HP Universal Printing PCL 6"

echo 连接网络打印机，已OK
pause
